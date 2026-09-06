local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SkillItem = dataclass("SkillItem")
SkillItem.skillItemId = 0
SkillItem.skillLevel = 0
SkillItem.power = 0
SkillItem.selected = 0

function SkillItem:Ctor()
end

function SkillItem:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillItemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillLevel) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.power) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.selected) then
    return false
  end
  return true
end

function SkillItem:Unmarshal(buffer)
  local ret = true
  ret, self.skillItemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.skillLevel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.power = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.selected = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SkillItem
