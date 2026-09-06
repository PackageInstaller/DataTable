local DM_MiniMap = class("DM_MiniMap")
local Point = require("protocols.bean.protocol.battle.point")

local function GenRowColID(self, row, col)
  return row * self._miniMap.groundColCount + col
end

local function ParseRorColID(self, rowColID)
  local row = math.floor(rowColID / self._miniMap.groundColCount)
  local col = rowColID - row * self._miniMap.groundColCount
  return row, col
end

function DM_MiniMap:Ctor()
  self._miniMap = NekoData.Data.miniMap
  self._miniMap.visibleAreaTable = {}
  self._miniMap.outVisibleAreaTable = {}
  self._miniMap.cachedVisibleAreaTable = {}
  self._miniMap.cachedOutVisibleAreaTable = {}
  self._miniMap.groundRowCount = 1
  self._miniMap.groundColCount = 1
  self._miniMap.tempProtocolData = {}
  self._miniMap.isMapOpened = false
  self._miniMap.dynamicObjectID = 0
  self._miniMap.specialPoints = {}
  self._miniMap.isSwitching = false
end

function DM_MiniMap:InitMap(rowCount, colCount)
  self._miniMap.groundRowCount = rowCount
  self._miniMap.groundColCount = colCount
  if self:IsMapOpened() == false then
    for k, v in pairs(self._miniMap.tempProtocolData.visiblePoints) do
      local row, col = ParseRorColID(self, v)
      if self:IsValidCoord(row, col) == true then
        self:SetVisibleArea(row, col)
      end
    end
    for k, v in pairs(self._miniMap.tempProtocolData.outVisiblePoints) do
      local row, col = ParseRorColID(self, v)
      if self:IsValidCoord(row, col) == true then
        self:SetOutVisibleArea(row, col)
      end
    end
  end
  self._miniMap.tempProtocolData = {}
  self._miniMap.isSwitching = false
end

function DM_MiniMap:GetSpecialPoints()
  return self._miniMap.specialPoints
end

function DM_MiniMap:IsMapOpened()
  return self._miniMap.isMapOpened
end

function DM_MiniMap:SetVisibleArea(row, col)
  self._miniMap.visibleAreaTable[GenRowColID(self, row, col)] = {
    [1] = row,
    [2] = col
  }
end

function DM_MiniMap:IsAreaVisible(row, col)
  return self._miniMap.visibleAreaTable[GenRowColID(self, row, col)] ~= nil
end

function DM_MiniMap:GetVisibleAreas()
  local visibleAreas = {}
  for k, v in pairs(self._miniMap.visibleAreaTable) do
    table.insert(visibleAreas, v)
  end
  return visibleAreas
end

function DM_MiniMap:SetOutVisibleArea(row, col)
  self._miniMap.outVisibleAreaTable[GenRowColID(self, row, col)] = {
    [1] = row,
    [2] = col
  }
end

function DM_MiniMap:IsOutAreaVisible(row, col)
  return self._miniMap.outVisibleAreaTable[GenRowColID(self, row, col)] ~= nil
end

function DM_MiniMap:GetOutVisibleAreas()
  local outVisibleAreas = {}
  for k, v in pairs(self._miniMap.outVisibleAreaTable) do
    table.insert(outVisibleAreas, v)
  end
  return outVisibleAreas
end

function DM_MiniMap:SetOutVisibleToVisible(row, col)
  self._miniMap.visibleAreaTable[GenRowColID(self, row, col)] = {
    [1] = row,
    [2] = col
  }
  self._miniMap.outVisibleAreaTable[GenRowColID(self, row, col)] = nil
end

function DM_MiniMap:CacheVisibleArea(row, col)
  table.insert(self._miniMap.cachedVisibleAreaTable, GenRowColID(self, row, col))
end

function DM_MiniMap:CacheOutVisibleArea(row, col)
  local id = GenRowColID(self, row, col)
  self._miniMap.cachedOutVisibleAreaTable[id] = id
end

function DM_MiniMap:CacheOutVisibleToVisible(row, col)
  local id = GenRowColID(self, row, col)
  table.insert(self._miniMap.cachedVisibleAreaTable, id)
  self._miniMap.cachedOutVisibleAreaTable[id] = nil
end

function DM_MiniMap:AddObject()
  local id = self._miniMap.dynamicObjectID + 1
  self._miniMap.dynamicObjectID = id
  return id
end

function DM_MiniMap:GetCachedVisibleArea()
  return self._miniMap.cachedVisibleAreaTable
end

function DM_MiniMap:GetCachedOutVisibleArea()
  local results = {}
  for k, v in pairs(self._miniMap.cachedOutVisibleAreaTable) do
    table.insert(results, v)
  end
  return results
end

function DM_MiniMap:ClearCachedVisibleArea()
  self._miniMap.cachedVisibleAreaTable = {}
end

function DM_MiniMap:ClearCachedOutVisibleArea()
  self._miniMap.cachedOutVisibleAreaTable = {}
end

function DM_MiniMap:IsValidCoord(row, col)
  return 0 <= row and row < self._miniMap.groundRowCount and 0 <= col and col < self._miniMap.groundColCount
end

function DM_MiniMap:Clear()
  self._miniMap.dynamicObjectID = 0
  self._miniMap.specialPoints = {}
  self._miniMap.visibleAreaTable = {}
  self._miniMap.outVisibleAreaTable = {}
end

function DM_MiniMap:IsSwitching()
  return self._miniMap.isSwitching
end

function DM_MiniMap:OnSEnterDungeon(protocol)
  self:Clear()
  if protocol.mapOpened == 1 then
    self._miniMap.isMapOpened = true
  else
    self._miniMap.isMapOpened = false
    local points = {}
    for k, v in pairs(protocol.points) do
      table.insert(points, v)
    end
    local outPoints = {}
    for k, v in pairs(protocol.prePoints) do
      table.insert(outPoints, v)
    end
    self._miniMap.tempProtocolData.visiblePoints = points
    self._miniMap.tempProtocolData.outVisiblePoints = outPoints
  end
  local specialPoints = self._miniMap.specialPoints
  for k, v in pairs(protocol.specialPoint) do
    table.insert(specialPoints, points)
  end
  self._miniMap.isSwitching = true
end

return DM_MiniMap
