-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/fantasyconflictdefendrecord.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local FantasyConflictDefendRecord = dataclass("FantasyConflictDefendRecord")
FantasyConflictDefendRecord.result = 0
FantasyConflictDefendRecord.time = 0
FantasyConflictDefendRecord.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.enemyUserData = ((require("protocols.bean.protocol.chat.baseuserdata")).Create)()
  self.enemyRoleList = {}
  self.mineRoleList = {}
end

FantasyConflictDefendRecord.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.time) then
    return false
  end
  if not (self.enemyUserData):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.enemyRoleList)) then
    return false
  end
  for key,value in pairs(self.enemyRoleList) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    if not value:Marshal(R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.mineRoleList)) then
    return false
  end
  for key,value in pairs(self.mineRoleList) do
    -- DECOMPILER ERROR at PC73: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    -- DECOMPILER ERROR at PC80: Overwrote pending register: R9 in 'AssignReg'

    if not value:Marshal(R9_PC42) then
      return false
    end
  end
  return true
end

FantasyConflictDefendRecord.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  if not (self.enemyUserData):Unmarshal(buffer) then
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
    -- DECOMPILER ERROR at PC55: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.enemyRoleList)[key] = value
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
    -- DECOMPILER ERROR at PC96: Overwrote pending register: R8 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC105: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.mineRoleList)[key] = value
  end
  return ret
end

return FantasyConflictDefendRecord

