local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShowSpark = dataclass("SShowSpark", require("framework.net.protocol"))
SShowSpark.ProtocolType = 1157
SShowSpark.MaxSize = 65535
SShowSpark.userId = 0

function SShowSpark:Ctor(client)
  SShowSpark.super.Ctor(self, client)
end

function SShowSpark:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function SShowSpark:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SShowSpark
