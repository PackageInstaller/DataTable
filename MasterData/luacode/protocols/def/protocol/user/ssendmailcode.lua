local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendMailCode = dataclass("SSendMailCode", require("framework.net.protocol"))
SSendMailCode.ProtocolType = 2256
SSendMailCode.MaxSize = 65535
SSendMailCode.result = 0
SSendMailCode.time = 0

function SSendMailCode:Ctor(client)
  SSendMailCode.super.Ctor(self, client)
end

function SSendMailCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.time) then
    return false
  end
  return true
end

function SSendMailCode:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.time = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendMailCode
