local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeSummerActivityTime = dataclass("CChangeSummerActivityTime", require("framework.net.protocol"))
CChangeSummerActivityTime.ProtocolType = 2477
CChangeSummerActivityTime.MaxSize = 65535

function CChangeSummerActivityTime:Ctor(client)
  CChangeSummerActivityTime.super.Ctor(self, client)
end

function CChangeSummerActivityTime:Marshal(buffer)
  return true
end

function CChangeSummerActivityTime:Unmarshal(buffer)
  local ret = true
  return ret
end

return CChangeSummerActivityTime
