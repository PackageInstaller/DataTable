package unluac.parse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.HashMap;
import java.util.Map;

import unluac.Configuration;
import unluac.Configuration.Mode;
import unluac.Version;
import unluac.assemble.Tokenizer;
import unluac.decompile.CodeExtract;
import unluac.decompile.Op;
import unluac.decompile.OpcodeMap;
import unluac.decompile.Type;
import unluac.decompile.TypeMap;


public class BHeader {

  private static final byte[] signature = {
    0x1B, 0x4C, 0x75, 0x61,
  };

  /* 电击文库零境交错自定义 Lua 头签名："\0fci"（替换原版 "\x1bLua"），
     后面直接跟主函数 upvalue 计数 1 字节，没有标准 5.3 的 34 字节头。 */
  private static final byte[] fciSignature = {
    0x00, 0x66, 0x63, 0x69,
  };

  /* 标准 Lua 5.3.5 头部字节（用于合成默认 LHeader，实际文件里没有这段） */
  private static final byte[] lua53DefaultHeader = {
    0x00,                                              /* format */
    0x19, (byte) 0x93, 0x0D, 0x0A, 0x1A, 0x0A,          /* tail */
    0x04,                                              /* int size */
    0x08,                                              /* size_t size */
    0x04,                                              /* instruction size */
    0x08,                                              /* lua_Integer size */
    0x08,                                              /* lua_Number size */
    0x78, 0x56, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,    /* LUAC_INT 0x5678 LE */
    0x00, 0x00, 0x00, 0x00, 0x00, 0x28, 0x77, 0x40,    /* LUAC_NUM 370.5 LE */
  };
  
  public final boolean debug = false;

  /** 是否电击文库零境交错的自定义 "\0fci" 头（长字符串长度用 int32 而非 size_t）。 */
  public final boolean customHeader;
  
  public final Configuration config;
  public final Version version;
  public final LHeader lheader;
  public final LHeaderType lheader_type;
  public final BIntegerType integer;
  public final BIntegerType sizeT;
  public final LBooleanType bool;
  public final LNumberType number;
  public final LNumberType linteger;
  public final LNumberType lfloat;
  public final LStringType string;
  public final LConstantType constant;
  public final LAbsLineInfoType abslineinfo;
  public final LLocalType local;
  public final LUpvalueType upvalue;
  public final LFunctionType function;
  public final CodeExtract extractor;
  public final TypeMap typemap;
  public final OpcodeMap opmap;
  
  public final LFunction main;
  
  public BHeader(Version version, LHeader lheader, TypeMap typemap) {
    this(version, lheader, typemap, null);
  }
  
  public BHeader(Version version, LHeader lheader, TypeMap typemap, LFunction main) {
    this.config = null;
    this.customHeader = false;
    this.version = version;
    this.lheader = lheader;
    this.lheader_type = version.getLHeaderType();
    integer = lheader.integer;
    sizeT = lheader.sizeT;
    bool = lheader.bool;
    number = lheader.number;
    linteger = lheader.linteger;
    lfloat = lheader.lfloat;
    string = lheader.string;
    constant = lheader.constant;
    abslineinfo = lheader.abslineinfo;
    local = lheader.local;
    upvalue = lheader.upvalue;
    function = lheader.function;
    extractor = lheader.extractor;
    this.typemap = typemap;
    opmap = version.getOpcodeMap();
    this.main = main;
  }
  
  public BHeader(ByteBuffer buffer, Configuration config) {
    this.config = config;
    // 4 byte Lua signature (standard "\x1bLua" or game custom "\0fci")
    byte[] sig4 = new byte[4];
    buffer.mark();
    buffer.get(sig4);
    buffer.reset();
    boolean fci = (sig4[0] == 0x00 && sig4[1] == 0x66 && sig4[2] == 0x63 && sig4[3] == 0x69);
    customHeader = fci;
    if(fci) {
      buffer.position(buffer.position() + 4);
    } else {
      for(int i = 0; i < signature.length; i++) {
        if(buffer.get() != signature[i]) {
          throw new IllegalStateException("The input file does not have the signature of a valid Lua file.");
        }
      }
    }

    int versionNumber;
    int major, minor;
    if(fci) {
      // 游戏自定义头：[\0fci][主函数 upvalue 计数][函数 dump]，没有版本字节；
      // 固定按 Lua 5.3 处理，后面的 upvalue 计数由下方统一读取。
      major = 5;
      minor = 3;
      versionNumber = 0x53;
    } else {
      versionNumber = 0xFF & buffer.get();
      major = versionNumber >> 4;
      minor = versionNumber & 0x0F;
    }

    version = Version.getVersion(config, major, minor);
    if(version == null) {
      throw new IllegalStateException("The input chunk's Lua version is " + major + "." + minor + "; unluac can only handle Lua 5.0 - Lua 5.4.");
    }

    lheader_type = version.getLHeaderType();
    if(fci) {
      buffer.order(ByteOrder.LITTLE_ENDIAN);
      lheader = lheader_type.parse(ByteBuffer.wrap(lua53DefaultHeader).order(ByteOrder.LITTLE_ENDIAN), this);
    } else {
      lheader = lheader_type.parse(buffer, this);
    }
    integer = lheader.integer;
    sizeT = lheader.sizeT;
    bool = lheader.bool;
    number = lheader.number;
    linteger = lheader.linteger;
    lfloat = lheader.lfloat;
    string = lheader.string;
    constant = lheader.constant;
    abslineinfo = lheader.abslineinfo;
    local = lheader.local;
    upvalue = lheader.upvalue;
    function = lheader.function;
    extractor = lheader.extractor;
    
    try {
      if(config.typemap != null) {
        Tokenizer t = new Tokenizer(new FileInputStream(new File(config.typemap)));
        String tok;
        Map<Integer, Type> usertypemap = new HashMap<Integer, Type>();
        while((tok = t.next()) != null) {
          if(tok.equals(".type")) {
            tok = t.next();
            if(tok == null) throw new RuntimeException("Unexpected end of typemap file.");
            int opcode;
            try {
              opcode = Integer.parseInt(tok);
            } catch(NumberFormatException e) {
              throw new RuntimeException("Excepted number in typemap file, got \"" + tok + "\".");
            }
            tok = t.next();
            if(tok == null) throw new RuntimeException("Unexpected end of typemap file.");
            Type type = Type.get(tok);
            if(type == null) throw new RuntimeException("Unknown type name \"" + tok + "\" in typemap file.");
            usertypemap.put(opcode, type);
          } else {
            throw new RuntimeException("Unexpected token \"" + tok + "\" + in typemap file.");
          }
        }
        typemap = new TypeMap(usertypemap);
      } else {
        typemap = version.getTypeMap();
      }
      
      if(config.opmap != null) {      
        Tokenizer t = new Tokenizer(new FileInputStream(new File(config.opmap)));
        String tok;
        Map<Integer, Op> useropmap = new HashMap<Integer, Op>();
        while((tok = t.next()) != null) {
          if(tok.equals(".op")) {
            tok = t.next();
            if(tok == null) throw new RuntimeException("Unexpected end of opmap file.");
            int opcode;
            try {
              opcode = Integer.parseInt(tok);
            } catch(NumberFormatException e) {
              throw new RuntimeException("Excepted number in opmap file, got \"" + tok + "\".");
            }
            tok = t.next();
            if(tok == null) throw new RuntimeException("Unexpected end of opmap file.");
            Op op = version.getOpcodeMap().get(tok);
            if(op == null) throw new RuntimeException("Unknown op name \"" + tok + "\" in opmap file.");
            useropmap.put(opcode, op);
          } else {
            throw new RuntimeException("Unexpected token \"" + tok + "\" + in opmap file.");
          }
        }
        opmap = new OpcodeMap(useropmap);
      } else {
        opmap = version.getOpcodeMap();
      }
    } catch(IOException e) {
      throw new RuntimeException(e.getMessage());
    }
    
    int upvalues = -1;
    if(versionNumber >= 0x53) {
      upvalues = 0xFF & buffer.get();
      if(debug) {
        System.out.println("-- main chunk upvalue count: " + upvalues);
      }
      // TODO: check this value
    }
    main = function.parse(buffer, this);
    if(upvalues >= 0) {
      if(main.numUpvalues != upvalues) {
        throw new IllegalStateException("The main chunk has the wrong number of upvalues: " + main.numUpvalues + " (" + upvalues + " expected)");
      }
    }
    if(main.numUpvalues >= 1 && versionNumber >= 0x52 && (main.upvalues[0].name == null || main.upvalues[0].name.isEmpty()) && config.mode == Mode.DECOMPILE) {
      main.upvalues[0].name = "_ENV";
    }
    main.setLevel(1);
  }
  
  public void write(OutputStream out) throws IOException {
    out.write(signature);
    int major = version.getVersionMajor();
    int minor = version.getVersionMinor();
    int versionNumber = (major << 4) | minor;
    out.write(versionNumber);
    version.getLHeaderType().write(out, this, lheader);
    if(version.useupvaluecountinheader.get()) {
      out.write(main.numUpvalues);
    }
    function.write(out, this, main);
  }
  
}
