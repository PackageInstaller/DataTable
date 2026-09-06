local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCheckPhoneCode = dataclass("SCheckPhoneCode", require("framework.net.protocol"))
SCheckPhoneCode.ProtocolType = 2254
SCheckPhoneCode.MaxSize = 65535
SCheckPhoneCode.result = 0
SCheckPhoneCode.num = ""

function SCheckPhoneCode:Ctor(client)
  SCheckPhoneCode.super.Ctor(self, client)
end

function SCheckPhoneCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.num) then
    return false
  end
  return true
end

function SCheckPhoneCode:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.num = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCheckPhoneCode
