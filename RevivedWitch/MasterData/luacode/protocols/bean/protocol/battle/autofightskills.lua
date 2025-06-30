-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/autofightskills.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local AutoFightSkills = dataclass("AutoFightSkills")
AutoFightSkills.autoFight = 0
AutoFightSkills.speed = 0
AutoFightSkills.lock = 0
AutoFightSkills.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.orderSKill = ((require("protocols.bean.protocol.battle.chosenskill")).Create)()
  self.disorderSkill = ((require("protocols.bean.protocol.battle.chosenskill")).Create)()
  self.eruptSkill = {}
end

AutoFightSkills.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.autoFight) then
    return false
  end
  if not (self.orderSKill):Marshal(buffer) then
    return false
  end
  if not (self.disorderSkill):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.eruptSkill)) then
    return false
  end
  for key,value in pairs(self.eruptSkill) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolFloat)(buffer, self.speed) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.lock) then
    return false
  end
  return true
end

AutoFightSkills.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  if not (self.orderSKill):Unmarshal(buffer) then
    return false
  end
  if not (self.disorderSkill):Unmarshal(buffer) then
    return false
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC53: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.eruptSkill)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadFloat)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return AutoFightSkills

