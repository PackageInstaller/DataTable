-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_minimap.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_MiniMap = class("DM_MiniMap")
local Point = require("protocols.bean.protocol.battle.point")
local GenRowColID = function(self, row, col)
  -- function num : 0_0
  return row * (self._miniMap).groundColCount + col
end

local ParseRorColID = function(self, rowColID)
  -- function num : 0_1 , upvalues : _ENV
  local row = (math.floor)(rowColID / (self._miniMap).groundColCount)
  local col = rowColID - row * (self._miniMap).groundColCount
  return row, col
end

DM_MiniMap.Ctor = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self._miniMap = (NekoData.Data).miniMap
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).visibleAreaTable = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).outVisibleAreaTable = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).cachedVisibleAreaTable = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).cachedOutVisibleAreaTable = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).groundRowCount = 1
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).groundColCount = 1
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).tempProtocolData = {}
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).isMapOpened = false
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).dynamicObjectID = 0
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).specialPoints = {}
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).isSwitching = false
end

DM_MiniMap.InitMap = function(self, rowCount, colCount)
  -- function num : 0_3 , upvalues : _ENV, ParseRorColID
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._miniMap).groundRowCount = rowCount
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._miniMap).groundColCount = colCount
  if self:IsMapOpened() == false then
    for k,v in pairs(((self._miniMap).tempProtocolData).visiblePoints) do
      local row, col = ParseRorColID(self, v)
      if self:IsValidCoord(row, col) == true then
        self:SetVisibleArea(row, col)
      end
    end
    for k,v in pairs(((self._miniMap).tempProtocolData).outVisiblePoints) do
      local row, col = ParseRorColID(self, v)
      if self:IsValidCoord(row, col) == true then
        self:SetOutVisibleArea(row, col)
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._miniMap).tempProtocolData = {}
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._miniMap).isSwitching = false
  end
end

DM_MiniMap.GetSpecialPoints = function(self)
  -- function num : 0_4
  return (self._miniMap).specialPoints
end

DM_MiniMap.IsMapOpened = function(self)
  -- function num : 0_5
  return (self._miniMap).isMapOpened
end

DM_MiniMap.SetVisibleArea = function(self, row, col)
  -- function num : 0_6 , upvalues : GenRowColID
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ((self._miniMap).visibleAreaTable)[GenRowColID(self, row, col)] = {[1] = row, [2] = col}
end

DM_MiniMap.IsAreaVisible = function(self, row, col)
  -- function num : 0_7 , upvalues : GenRowColID
  do return ((self._miniMap).visibleAreaTable)[GenRowColID(self, row, col)] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_MiniMap.GetVisibleAreas = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local visibleAreas = {}
  for k,v in pairs((self._miniMap).visibleAreaTable) do
    (table.insert)(visibleAreas, v)
  end
  return visibleAreas
end

DM_MiniMap.SetOutVisibleArea = function(self, row, col)
  -- function num : 0_9 , upvalues : GenRowColID
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ((self._miniMap).outVisibleAreaTable)[GenRowColID(self, row, col)] = {[1] = row, [2] = col}
end

DM_MiniMap.IsOutAreaVisible = function(self, row, col)
  -- function num : 0_10 , upvalues : GenRowColID
  do return ((self._miniMap).outVisibleAreaTable)[GenRowColID(self, row, col)] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_MiniMap.GetOutVisibleAreas = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local outVisibleAreas = {}
  for k,v in pairs((self._miniMap).outVisibleAreaTable) do
    (table.insert)(outVisibleAreas, v)
  end
  return outVisibleAreas
end

DM_MiniMap.SetOutVisibleToVisible = function(self, row, col)
  -- function num : 0_12 , upvalues : GenRowColID
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ((self._miniMap).visibleAreaTable)[GenRowColID(self, row, col)] = {[1] = row, [2] = col}
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._miniMap).outVisibleAreaTable)[GenRowColID(self, row, col)] = nil
end

DM_MiniMap.CacheVisibleArea = function(self, row, col)
  -- function num : 0_13 , upvalues : _ENV, GenRowColID
  (table.insert)((self._miniMap).cachedVisibleAreaTable, GenRowColID(self, row, col))
end

DM_MiniMap.CacheOutVisibleArea = function(self, row, col)
  -- function num : 0_14 , upvalues : GenRowColID
  local id = GenRowColID(self, row, col)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._miniMap).cachedOutVisibleAreaTable)[id] = id
end

DM_MiniMap.CacheOutVisibleToVisible = function(self, row, col)
  -- function num : 0_15 , upvalues : GenRowColID, _ENV
  local id = GenRowColID(self, row, col)
  ;
  (table.insert)((self._miniMap).cachedVisibleAreaTable, id)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._miniMap).cachedOutVisibleAreaTable)[id] = nil
end

DM_MiniMap.AddObject = function(self)
  -- function num : 0_16
  local id = (self._miniMap).dynamicObjectID + 1
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._miniMap).dynamicObjectID = id
  return id
end

DM_MiniMap.GetCachedVisibleArea = function(self)
  -- function num : 0_17
  return (self._miniMap).cachedVisibleAreaTable
end

DM_MiniMap.GetCachedOutVisibleArea = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local results = {}
  for k,v in pairs((self._miniMap).cachedOutVisibleAreaTable) do
    (table.insert)(results, v)
  end
  return results
end

DM_MiniMap.ClearCachedVisibleArea = function(self)
  -- function num : 0_19
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._miniMap).cachedVisibleAreaTable = {}
end

DM_MiniMap.ClearCachedOutVisibleArea = function(self)
  -- function num : 0_20
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._miniMap).cachedOutVisibleAreaTable = {}
end

DM_MiniMap.IsValidCoord = function(self, row, col)
  -- function num : 0_21
  do return row >= 0 and row < (self._miniMap).groundRowCount and col >= 0 and col < (self._miniMap).groundColCount end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_MiniMap.Clear = function(self)
  -- function num : 0_22
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._miniMap).dynamicObjectID = 0
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).specialPoints = {}
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).visibleAreaTable = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._miniMap).outVisibleAreaTable = {}
end

DM_MiniMap.IsSwitching = function(self)
  -- function num : 0_23
  return (self._miniMap).isSwitching
end

DM_MiniMap.OnSEnterDungeon = function(self, protocol)
  -- function num : 0_24 , upvalues : _ENV
  self:Clear()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.mapOpened == 1 then
    (self._miniMap).isMapOpened = true
  else
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._miniMap).isMapOpened = false
    local points = {}
    for k,v in pairs(protocol.points) do
      (table.insert)(points, v)
    end
    local outPoints = {}
    for k,v in pairs(protocol.prePoints) do
      (table.insert)(outPoints, v)
    end
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self._miniMap).tempProtocolData).visiblePoints = points
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self._miniMap).tempProtocolData).outVisiblePoints = outPoints
  end
  do
    local specialPoints = (self._miniMap).specialPoints
    for k,v in pairs(protocol.specialPoint) do
      (table.insert)(specialPoints, points)
    end
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._miniMap).isSwitching = true
  end
end

return DM_MiniMap

