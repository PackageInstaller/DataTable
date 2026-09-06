local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSendPhoneCode = dataclass("CSendPhoneCode", require("framework.net.protocol"))
CSendPhoneCode.ProtocolType = 2251
CSendPhoneCode.MaxSize = 65535
CSendPhoneCode.phoneNum = ""

function CSendPhoneCode:Ctor(client)
  CSendPhoneCode.super.Ctor(self, client)
end

function CSendPhoneCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.phoneNum) then
    return false
  end
  return true
end

function CSendPhoneCode:Unmarshal(buffer)
  local ret = true
  ret, self.phoneNum = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSendPhoneCode
