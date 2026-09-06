local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSendMailCode = dataclass("CSendMailCode", require("framework.net.protocol"))
CSendMailCode.ProtocolType = 2255
CSendMailCode.MaxSize = 65535
CSendMailCode.address = ""

function CSendMailCode:Ctor(client)
  CSendMailCode.super.Ctor(self, client)
end

function CSendMailCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.address) then
    return false
  end
  return true
end

function CSendMailCode:Unmarshal(buffer)
  local ret = true
  ret, self.address = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSendMailCode
