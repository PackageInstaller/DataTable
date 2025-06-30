-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/battleinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local BattleInfo = dataclass("BattleInfo")
BattleInfo.id = 0
BattleInfo.battleType = 0
BattleInfo.battleid = 0
BattleInfo.battleSceneId = 0
BattleInfo.lineId = 0
BattleInfo.leftAssistNum = 0
BattleInfo.totalAssistNum = 0
BattleInfo.seed = 0
BattleInfo.guide = 0
BattleInfo.battleVerifyNum = 0
BattleInfo.battleDuration = 0
BattleInfo.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.left = {}
  self.right = {}
  self.assist = ((require("protocols.bean.protocol.battle.fighter")).Create)()
  self.auto = ((require("protocols.bean.protocol.battle.autofightskills")).Create)()
  self.battleBuffs = {}
end

BattleInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleSceneId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.left)) then
    return false
  end
  for key,value in pairs(self.left) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC58) then
      return false
    end
    if not value:Marshal(R9_PC58) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.right)) then
    return false
  end
  for key,value in pairs(self.right) do
    -- DECOMPILER ERROR at PC89: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC58) then
      return false
    end
    -- DECOMPILER ERROR at PC96: Overwrote pending register: R9 in 'AssignReg'

    if not value:Marshal(R9_PC58) then
      return false
    end
  end
  if not (self.assist):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftAssistNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalAssistNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.seed) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.guide) then
    return false
  end
  if not (self.auto):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.battleVerifyNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.battleDuration) then
    return false
  end
  local length = (table.slen)(self.battleBuffs)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC187: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.battleBuffs)[i]):Marshal(R9_PC58) then
      return false
    end
  end
  return true
end

BattleInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
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
    -- DECOMPILER ERROR at PC71: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.left)[key] = value
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
    -- DECOMPILER ERROR at PC112: Overwrote pending register: R8 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC121: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.right)[key] = value
  end
  if not (self.assist):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.auto):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC206: Confused about usage of register: R14 in 'UnsetPending'

    (self.battleBuffs)[i] = ((require("protocols.bean.protocol.battle.battlebuff")).Create)()
    if not ((self.battleBuffs)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return BattleInfo

