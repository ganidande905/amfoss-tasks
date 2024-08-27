import cv2
import numpy as np
from PIL import Image, ImageDraw
def DetectDot(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    _, thresh = cv2.threshold(gray, 240, 255, cv2.THRESH_BINARY_INV)
    contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    if len(contours) > 0:
        dot_contour = max(contours, key=cv2.contourArea)
        x, y, w, h = cv2.boundingRect(dot_contour)
        dot_center = (x + w // 2, y + h // 2)
        dot_color = image[y + h // 2, x + w // 2]
        return dot_center, dot_color
    else:
        return None, None
def nonwhite_area(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    _, mask = cv2.threshold(gray, 240, 255, cv2.THRESH_BINARY_INV)
    mask = cv2.bitwise_not(mask) 
    return mask
def cv2_mask_to_pil(mask):
    return Image.fromarray(mask).convert('L')
def ProcessImg(image_paths):
    max_width = 0
    total_height = 0
    dots = []
    colors = []
    for path in image_paths:
        img = cv2.imread(path)
        if img is None:   
            continue
        if np.all(img == 255):
            dots.append(None)
            colors.append(None)
            continue

        dot_center, dot_color = DetectDot(img)
        
        if dot_center:
            dots.append(dot_center)
            colors.append(dot_color)
            max_width = max(max_width, img.shape[1])
            total_height += img.shape[0]
        else:
            dots.append(None)
            colors.append(None)
    canvas = Image.new('RGB', (max_width, total_height), color='white')
    draw = ImageDraw.Draw(canvas)
    
    y_offset = 0
    for path in image_paths:
        img = cv2.imread(path)
        if img is None:
            continue
        if np.all(img == 255):
            continue
        mask = nonwhite_area(img)
        img_pil = Image.fromarray(img)
        img_mask = cv2_mask_to_pil(mask)
        img_pil_masked = Image.new('RGB', img_pil.size, 'white')
        img_pil_masked.paste(img_pil, (0, 0), img_mask)
        canvas.paste(img_pil_masked, (0, y_offset))
        y_offset += img_pil.size[1]
    for i in range(1, len(dots)):
        if dots[i - 1] and dots[i]:
            prev_dot = dots[i - 1]
            current_dot = dots[i]
            prev_color = colors[i - 1]
            if prev_color is not None:
                line_color = tuple(prev_color[::-1]) 
                draw.line([prev_dot[0], prev_dot[1] + y_offset - total_height, current_dot[0], current_dot[1] + y_offset - total_height], fill=line_color, width=2)

    return canvas
def main():
    image_paths = [f"task-10/assets/Layer {i}.png" for i in range(1, 99)] 
    final_image = ProcessImg(image_paths)
    final_image.save("final_image.jpg")

if __name__ == "__main__":
    main()
