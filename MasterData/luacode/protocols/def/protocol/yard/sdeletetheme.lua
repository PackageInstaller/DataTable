local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDeleteTheme = dataclass("SDeleteTheme", require("framework.net.protocol"))
SDeleteTheme.ProtocolType = 2366
SDeleteTheme.MaxSize = 65535
SDeleteTheme.key = 0

function SDeleteTheme:Ctor(client)
  SDeleteTheme.super.Ctor(self, client)
end

function SDeleteTheme:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  return true
end

function SDeleteTheme:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SDeleteTheme
