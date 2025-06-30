-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sstarttowerexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SStartTowerExplore = dataclass("SStartTowerExplore", require("framework.net.protocol"))
SStartTowerExplore.ProtocolType = 1982
SStartTowerExplore.MaxSize = 65535
SStartTowerExplore.mapShowType = 0
SStartTowerExplore.playerPos = 0
SStartTowerExplore.currentTowerFloor = 0
SStartTowerExplore.totalFloors = 0
SStartTowerExplore.towerFloorId = 0
SStartTowerExplore.towerID = 0
SStartTowerExplore.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SStartTowerExplore
  ((SStartTowerExplore.super).Ctor)(self, client)
  self.mapList = {}
  self.linueupStatue = {}
end

SStartTowerExplore.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.mapList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.mapList)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.mapShowType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.playerPos) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.linueupStatue)) then
    return false
  end
  for key,value in pairs(self.linueupStatue) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC60) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC60) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.currentTowerFloor) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalFloors) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.towerFloorId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.towerID) then
    return false
  end
  return true
end

SStartTowerExplore.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.mapList)[i] = ((require("protocols.bean.protocol.battle.squreinfo")).Create)()
    if not ((self.mapList)[i]):Unmarshal(buffer) then
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
    -- DECOMPILER ERROR at PC75: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.linueupStatue)[key] = value
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
  return ret
end

return SStartTowerExplore

