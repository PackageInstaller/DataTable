local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRandomName = dataclass("SRandomName", require("framework.net.protocol"))
SRandomName.ProtocolType = 2204
SRandomName.MaxSize = 65535
SRandomName.name = ""

function SRandomName:Ctor(client)
  SRandomName.super.Ctor(self, client)
end

function SRandomName:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  return true
end

function SRandomName:Unmarshal(buffer)
  local ret = true
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRandomName
