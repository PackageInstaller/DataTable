package unluac;

import java.io.FileOutputStream;
import java.io.PrintStream;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.FileChannel;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import unluac.decompile.Decompiler;
import unluac.decompile.FileOutputProvider;
import unluac.decompile.Output;
import unluac.parse.BHeader;
import unluac.parse.LFunction;

/** 批量反编译电击文库零境交错的 Lua 字节码（单 JVM 处理，避免反复启动）。 */
public class BatchDecompile {

  private static LFunction fileToFunction(String fn, Configuration config) throws Exception {
    RandomAccessFile file = new RandomAccessFile(fn, "r");
    try {
      ByteBuffer buffer = ByteBuffer.allocate((int) file.length());
      buffer.order(ByteOrder.LITTLE_ENDIAN);
      FileChannel in = file.getChannel();
      while (buffer.hasRemaining()) {
        in.read(buffer);
      }
      buffer.rewind();
      return new BHeader(buffer, config).main;
    } finally {
      file.close();
    }
  }

  public static void main(String[] args) throws Exception {
    if (args.length < 3) {
      System.err.println("usage: BatchDecompile <srcRoot> <outRoot> <opmap>");
      System.exit(1);
    }
    Path srcRoot = Paths.get(args[0]);
    Path outRoot = Paths.get(args[1]);
    Configuration config = new Configuration();
    config.opmap = args[2];
    int ok = 0, fail = 0;
    try (var walk = Files.walk(srcRoot)) {
      for (Path p : (Iterable<Path>) walk::iterator) {
        if (!p.toString().endsWith(".bytes")) {
          continue;
        }
        try {
          byte[] head = Files.readAllBytes(p);
          if (head.length < 4 || head[0] != 0 || head[1] != 'f' || head[2] != 'c' || head[3] != 'i') {
            continue;
          }
          LFunction lmain = fileToFunction(p.toString(), config);
          Decompiler d = new Decompiler(lmain);
          Decompiler.State result = d.decompile();
          String rel = srcRoot.relativize(p).toString();
          if (rel.endsWith(".bytes")) {
            rel = rel.substring(0, rel.length() - 6);
          }
          Path out = outRoot.resolve(rel + ".lua");
          Files.createDirectories(out.getParent());
          FileOutputStream fos = new FileOutputStream(out.toFile());
          Output o = new Output(new FileOutputProvider(fos));
          d.print(result, o);
          o.finish();
          ok++;
        } catch (Exception e) {
          fail++;
          System.err.println("FAIL " + p + ": " + e);
        }
      }
    }
    System.out.println("decompiled ok=" + ok + " fail=" + fail);
  }
}
