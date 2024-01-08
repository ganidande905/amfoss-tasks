def is_stable(n, vectors):
    total_x = total_y = total_z = 0

    for vector in vectors:
        total_x += vector[0]
        total_y += vector[1]
        total_z += vector[2]

    if total_x == 0 and total_y == 0 and total_z == 0:
        return "YES"
    else:
        return "NO"


n = int(input())
vectors = []

for _ in range(n):
    vector = list(map(int, input().split()))
    vectors.append(vector)

result = is_stable(n, vectors)
print(result)