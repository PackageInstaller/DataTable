local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendPhoneCode = dataclass("SSendPhoneCode", require("framework.net.protocol"))
SSendPhoneCode.ProtocolType = 2252
SSendPhoneCode.MaxSize = 65535
SSendPhoneCode.result = 0
SSendPhoneCode.time = 0

function SSendPhoneCode:Ctor(client)
  SSendPhoneCode.super.Ctor(self, client)
end

function SSendPhoneCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.time) then
    return false
  end
  return true
end

function SSendPhoneCode:Unmarshal(buffer)
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

return SSendPhoneCode
