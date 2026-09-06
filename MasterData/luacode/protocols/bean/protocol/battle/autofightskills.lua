local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local AutoFightSkills = dataclass("AutoFightSkills")
AutoFightSkills.autoFight = 0
AutoFightSkills.speed = 0
AutoFightSkills.lock = 0

function AutoFightSkills:Ctor()
  self.orderSKill = require("protocols.bean.protocol.battle.chosenskill").Create()
  self.disorderSkill = require("protocols.bean.protocol.battle.chosenskill").Create()
  self.eruptSkill = {}
end

function AutoFightSkills:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.autoFight) then
    return false
  end
  if not self.orderSKill:Marshal(buffer) then
    return false
  end
  if not self.disorderSkill:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.eruptSkill)) then
    return false
  end
  for key, value in pairs(self.eruptSkill) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolFloat(buffer, self.speed) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.lock) then
    return false
  end
  return true
end

function AutoFightSkills:Unmarshal(buffer)
  local ret = true
  ret, self.autoFight = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  if not self.orderSKill:Unmarshal(buffer) then
    return false
  end
  if not self.disorderSkill:Unmarshal(buffer) then
    return false
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.eruptSkill[key] = value
  end
  ret, self.speed = ProtocolBufferStaticFunctions.ReadFloat(buffer)
  if not ret then
    return ret
  end
  ret, self.lock = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  return ret
end

return AutoFightSkills
