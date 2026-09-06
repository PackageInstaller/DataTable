local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeUserName = dataclass("SChangeUserName", require("framework.net.protocol"))
SChangeUserName.ProtocolType = 2221
SChangeUserName.MaxSize = 65535
SChangeUserName.name = ""

function SChangeUserName:Ctor(client)
  SChangeUserName.super.Ctor(self, client)
end

function SChangeUserName:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  return true
end

function SChangeUserName:Unmarshal(buffer)
  local ret = true
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeUserName
