local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SupportRoleForShow = dataclass("SupportRoleForShow")
SupportRoleForShow.id = 0
SupportRoleForShow.breakLv = 0
SupportRoleForShow.lv = 0
SupportRoleForShow.skin = 0

function SupportRoleForShow:Ctor()
  self.contractSkill = {}
end

function SupportRoleForShow:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.breakLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.lv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skin) then
    return false
  end
  local length = table.slen(self.contractSkill)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.contractSkill[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SupportRoleForShow:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.breakLv = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.lv = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.skin = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.contractSkill[i] = require("protocols.bean.protocol.skill.beans.skillitem").Create()
    if not self.contractSkill[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SupportRoleForShow
