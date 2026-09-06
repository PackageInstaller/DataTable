local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSearchUser = dataclass("CSearchUser", require("framework.net.protocol"))
CSearchUser.ProtocolType = 1122
CSearchUser.MaxSize = 65535
CSearchUser.Keyword = ""

function CSearchUser:Ctor(client)
  CSearchUser.super.Ctor(self, client)
end

function CSearchUser:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.Keyword) then
    return false
  end
  return true
end

function CSearchUser:Unmarshal(buffer)
  local ret = true
  ret, self.Keyword = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSearchUser
