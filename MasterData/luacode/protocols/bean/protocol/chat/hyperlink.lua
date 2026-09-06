local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Hyperlink = dataclass("Hyperlink")
Hyperlink.userId = 0
Hyperlink.linkType = 0
Hyperlink.linkText = 0
Hyperlink.ITEM = 1
Hyperlink.EMOJI = 2

function Hyperlink:Ctor()
end

function Hyperlink:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.linkType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.linkText) then
    return false
  end
  return true
end

function Hyperlink:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.linkType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.linkText = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Hyperlink
