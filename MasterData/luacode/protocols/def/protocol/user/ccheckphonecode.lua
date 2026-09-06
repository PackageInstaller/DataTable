local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckPhoneCode = dataclass("CCheckPhoneCode", require("framework.net.protocol"))
CCheckPhoneCode.ProtocolType = 2253
CCheckPhoneCode.MaxSize = 65535
CCheckPhoneCode.code = ""

function CCheckPhoneCode:Ctor(client)
  CCheckPhoneCode.super.Ctor(self, client)
end

function CCheckPhoneCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.code) then
    return false
  end
  return true
end

function CCheckPhoneCode:Unmarshal(buffer)
  local ret = true
  ret, self.code = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckPhoneCode
