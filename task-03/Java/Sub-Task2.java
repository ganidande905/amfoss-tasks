import java.nio.file.*;

public class FileCopy {
    public static void main(String[] args) throws Exception {
        String content = new String(Files.readAllBytes(Paths.get("input.txt")));
        Files.write(Paths.get("output.txt"), content.getBytes());
    }
}
