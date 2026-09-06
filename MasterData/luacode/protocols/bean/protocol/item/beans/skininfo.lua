local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SkinInfo = dataclass("SkinInfo")
SkinInfo.skinID = 0
SkinInfo.skinStatus = 0
SkinInfo.isInSelling = 0

function SkinInfo:Ctor()
end

function SkinInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skinID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skinStatus) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.isInSelling) then
    return false
  end
  return true
end

function SkinInfo:Unmarshal(buffer)
  local ret = true
  ret, self.skinID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.skinStatus = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.isInSelling = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SkinInfo
