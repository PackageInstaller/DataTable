-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgettowerfloorinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetTowerFloorInfo = dataclass("SGetTowerFloorInfo", require("framework.net.protocol"))
SGetTowerFloorInfo.ProtocolType = 2415
SGetTowerFloorInfo.MaxSize = 65535
SGetTowerFloorInfo.enterType = 0
SGetTowerFloorInfo.passedPoints = 0
SGetTowerFloorInfo.highestPointID = 0
SGetTowerFloorInfo.time2reset = 0
SGetTowerFloorInfo.autoExploreUnlock = 0
SGetTowerFloorInfo.autoExploreState = 0
SGetTowerFloorInfo.rewardRedPoint = 0
SGetTowerFloorInfo.buffNum4Reset = 0
SGetTowerFloorInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetTowerFloorInfo
  ((SGetTowerFloorInfo.super).Ctor)(self, client)
  self.points = {}
  self.buffList = {}
  self.rolesState = {}
  self.buff4Choice = {}
end

SGetTowerFloorInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.enterType) then
    return false
  end
  local length = (table.slen)(self.points)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.points)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.passedPoints) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.highestPointID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.time2reset) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.buffList)) then
    return false
  end
  for key,value in pairs(self.buffList) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC76) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC76) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.rolesState)) then
    return false
  end
  for key,value in pairs(self.rolesState) do
    -- DECOMPILER ERROR at PC108: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC76) then
      return false
    end
    -- DECOMPILER ERROR at PC116: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC76) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.autoExploreUnlock) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.autoExploreState) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardRedPoint) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.buffNum4Reset) then
    return false
  end
  local length = (table.slen)(self.buff4Choice)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC174: Overwrote pending register: R10 in 'AssignReg'

    -- DECOMPILER ERROR at PC175: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC76) then
      return false
    end
  end
  return true
end

SGetTowerFloorInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.points)[i] = ((require("protocols.bean.protocol.activity.pointinfo")).Create)()
    if not ((self.points)[i]):Unmarshal(buffer) then
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
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
    -- DECOMPILER ERROR at PC91: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.buffList)[key] = value
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
    -- DECOMPILER ERROR at PC127: Overwrote pending register: R9 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC133: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self.rolesState)[key] = value
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
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC184: Confused about usage of register: R15 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SGetTowerFloorInfo

