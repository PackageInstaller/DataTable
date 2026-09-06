local CFurnitureItem = BeanManager.GetTableByName("item.cfurnitureitem")
local CDormFurnitureLevel = BeanManager.GetTableByName("courtyard.cdormfurniturelevel")
local CDormCoordinate = BeanManager.GetTableByName("courtyard.cdormcoordinate")
local CDormFurnitureType = BeanManager.GetTableByName("courtyard.cdormfurnituretype")
local CDormCoordinateTrans = BeanManager.GetTableByName("courtyard.cdormcoordinatetrans")
local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = strictclass("FurnitureItem", Item)

function FurnitureItem:Ctor(id)
  FurnitureItem.super.Ctor(self, id)
  self._furnitureItemRecord = CFurnitureItem:GetRecorder(self._itemId)
  self._furnitureLayerRecorder = CDormFurnitureLevel:GetRecorder(self._furnitureItemRecord.level)
  self._furnitureTypeRecorder = CDormFurnitureType:GetRecorder(self._furnitureItemRecord.type)
  self._dormCoordinateTransRecorder = CDormCoordinateTrans:GetRecorder(1)
  local InitialCoordinateRecorder
  if self._furnitureLayerRecorder.place == 0 then
    InitialCoordinateRecorder = CDormCoordinate:GetRecorder(2)
  else
    InitialCoordinateRecorder = CDormCoordinate:GetRecorder(1)
  end
  local tmpPos = string.split(InitialCoordinateRecorder.InitialCoordinate, ",")
  self._initialCoordinate = {
    x = tonumber(tmpPos[1]),
    y = tonumber(tmpPos[2]),
    z = tonumber(tmpPos[3])
  }
  self._gridSpace = InitialCoordinateRecorder.length
  self:InitRange()
  self:InitCover()
end

function FurnitureItem:InitRange()
  self._range = {
    leftDown = {},
    rightUp = {}
  }
  local list = string.split(self._furnitureItemRecord.putRange[1], ",")
  self._range.leftDown.x = tonumber(list[1])
  self._range.leftDown.y = tonumber(list[2])
  list = string.split(self._furnitureItemRecord.putRange[2], ",")
  self._range.rightUp.x = tonumber(list[1])
  self._range.rightUp.y = tonumber(list[2])
end

function FurnitureItem:InitCover()
  local list = string.split(self._furnitureItemRecord.cover, "*")
  self._cover = {
    x = tonumber(list[1]),
    y = tonumber(list[2])
  }
end

function FurnitureItem:GetRange()
  return self._range
end

function FurnitureItem:GetCover()
  return self._cover
end

function FurnitureItem:GetDefaultLeftDownGridPos()
  local leftDownPos = {}
  leftDownPos.x = math.floor(self._range.leftDown.x + (self._range.rightUp.x - self._range.leftDown.x + 1 - self._cover.x) / 2)
  leftDownPos.y = math.floor(self._range.leftDown.y + (self._range.rightUp.y - self._range.leftDown.y + 1 - self._cover.y) / 2)
  return leftDownPos
end

function FurnitureItem:GetType()
  return self._furnitureItemRecord.type
end

function FurnitureItem:GetLimitNum()
  return self._furnitureTypeRecorder.num
end

function FurnitureItem:GetLayerId()
  return self._furnitureItemRecord.level
end

function FurnitureItem:GetComfort()
  return self._furnitureItemRecord.comfortPoint
end

function FurnitureItem:GetPutRangeShow()
  if self._furnitureItemRecord.putRangeShow ~= 0 then
    return self._furnitureItemRecord.putRangeShow
  end
end

function FurnitureItem:GetCoverAsset()
  if self._furnitureLayerRecorder.place == 0 then
    return {
      assetBundle = "sceneobjects/dorm.prefabs.assetbundle",
      prefabName = "dorm_placegrid_h"
    }
  else
    return {
      assetBundle = "sceneobjects/dorm.prefabs.assetbundle",
      prefabName = "dorm_placegrid_v"
    }
  end
end

function FurnitureItem:GetFurnitureAsset()
  return {
    assetBundle = self._furnitureItemRecord.assetBundle,
    prefabName = self._furnitureItemRecord.prefabName
  }
end

function FurnitureItem:GetGridSpace()
  return self._gridSpace
end

function FurnitureItem:GetInitialCoordinate()
  return self._initialCoordinate
end

function FurnitureItem:IsWallDirection()
  return self._furnitureLayerRecorder.place ~= 0
end

function FurnitureItem:GetTrans()
  return self._dormCoordinateTransRecorder
end

return FurnitureItem
