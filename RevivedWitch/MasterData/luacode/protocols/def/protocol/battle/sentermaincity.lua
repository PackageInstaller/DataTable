-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sentermaincity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SEnterMainCity = dataclass("SEnterMainCity", require("framework.net.protocol"))
SEnterMainCity.ProtocolType = 1953
SEnterMainCity.MaxSize = 65535
SEnterMainCity.lastFloorId = 0
SEnterMainCity.tip = 0
SEnterMainCity.dungeonType = 0
SEnterMainCity.TIP_VOID = 0
SEnterMainCity.TIP_FAIL = 1
SEnterMainCity.TIP_NORMAL = 2
SEnterMainCity.TIP_JUMP = 3
SEnterMainCity.TIP_NO_TALK = 4
SEnterMainCity.TIP_EXCEPTION = 5
SEnterMainCity.TIP_DO_NOTHING = 6
SEnterMainCity.TOWER_BACK = 66
SEnterMainCity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SEnterMainCity, _ENV
  ((SEnterMainCity.super).Ctor)(self, client)
  self.battleResult = ((require("protocols.bean.protocol.battle.battleresult")).Create)()
  self.money = {}
  self.exploreawards = {}
  self.resourceParams = {}
  self.firstPassAward = {}
  self.curBattleInfo = ((require("protocols.bean.protocol.battle.battleinfo")).Create)()
end

SEnterMainCity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lastFloorId) then
    return false
  end
  if not (self.battleResult):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.money)) then
    return false
  end
  for key,value in pairs(self.money) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R9_PC34) then
      return false
    end
  end
  local length = (table.slen)(self.exploreawards)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC68: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.exploreawards)[i]):Marshal(R9_PC34) then
      return false
    end
  end
  local length = (table.slen)(self.resourceParams)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC92: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R9_PC34, (self.resourceParams)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.firstPassAward)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC117: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC118: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC119: Overwrote pending register: R9 in 'AssignReg'

    R9_PC34 = R9_PC34(R9_PC34, buffer)
    if not R9_PC34 then
      R9_PC34 = false
      return R9_PC34
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.tip) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dungeonType) then
    return false
  end
  if not (self.curBattleInfo):Marshal(buffer) then
    return false
  end
  return true
end

SEnterMainCity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.battleResult):Unmarshal(buffer) then
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
    -- DECOMPILER ERROR at PC45: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.money)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R11 in 'UnsetPending'

    (self.exploreawards)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.exploreawards)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R12 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC125: Confused about usage of register: R13 in 'UnsetPending'

    (self.firstPassAward)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.firstPassAward)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.curBattleInfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SEnterMainCity

