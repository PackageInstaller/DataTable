local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDeleteTheme = dataclass("CDeleteTheme", require("framework.net.protocol"))
CDeleteTheme.ProtocolType = 2365
CDeleteTheme.MaxSize = 65535
CDeleteTheme.key = 0

function CDeleteTheme:Ctor(client)
  CDeleteTheme.super.Ctor(self, client)
end

function CDeleteTheme:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  return true
end

function CDeleteTheme:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDeleteTheme
