-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/furnitureitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFurnitureItem = (BeanManager.GetTableByName)("item.cfurnitureitem")
local CDormFurnitureLevel = (BeanManager.GetTableByName)("courtyard.cdormfurniturelevel")
local CDormCoordinate = (BeanManager.GetTableByName)("courtyard.cdormcoordinate")
local CDormFurnitureType = (BeanManager.GetTableByName)("courtyard.cdormfurnituretype")
local CDormCoordinateTrans = (BeanManager.GetTableByName)("courtyard.cdormcoordinatetrans")
local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = strictclass("FurnitureItem", Item)
FurnitureItem.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : FurnitureItem, CFurnitureItem, CDormFurnitureLevel, CDormFurnitureType, CDormCoordinateTrans, CDormCoordinate, _ENV
  ((FurnitureItem.super).Ctor)(self, id)
  self._furnitureItemRecord = CFurnitureItem:GetRecorder(self._itemId)
  self._furnitureLayerRecorder = CDormFurnitureLevel:GetRecorder((self._furnitureItemRecord).level)
  self._furnitureTypeRecorder = CDormFurnitureType:GetRecorder((self._furnitureItemRecord).type)
  self._dormCoordinateTransRecorder = CDormCoordinateTrans:GetRecorder(1)
  local InitialCoordinateRecorder = nil
  if (self._furnitureLayerRecorder).place == 0 then
    InitialCoordinateRecorder = CDormCoordinate:GetRecorder(2)
  else
    InitialCoordinateRecorder = CDormCoordinate:GetRecorder(1)
  end
  local tmpPos = (string.split)(InitialCoordinateRecorder.InitialCoordinate, ",")
  self._initialCoordinate = {x = tonumber(tmpPos[1]), y = tonumber(tmpPos[2]), z = tonumber(tmpPos[3])}
  self._gridSpace = InitialCoordinateRecorder.length
  self:InitRange()
  self:InitCover()
end

FurnitureItem.InitRange = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._range = {
leftDown = {}
, 
rightUp = {}
}
  local list = (string.split)(((self._furnitureItemRecord).putRange)[1], ",")
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._range).leftDown).x = tonumber(list[1])
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._range).leftDown).y = tonumber(list[2])
  list = (string.split)(((self._furnitureItemRecord).putRange)[2], ",")
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._range).rightUp).x = tonumber(list[1])
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._range).rightUp).y = tonumber(list[2])
end

FurnitureItem.InitCover = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local list = (string.split)((self._furnitureItemRecord).cover, "*")
  self._cover = {x = tonumber(list[1]), y = tonumber(list[2])}
end

FurnitureItem.GetRange = function(self)
  -- function num : 0_3
  return self._range
end

FurnitureItem.GetCover = function(self)
  -- function num : 0_4
  return self._cover
end

FurnitureItem.GetDefaultLeftDownGridPos = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local leftDownPos = {}
  leftDownPos.x = (math.floor)(((self._range).leftDown).x + (((self._range).rightUp).x - ((self._range).leftDown).x + 1 - (self._cover).x) / 2)
  leftDownPos.y = (math.floor)(((self._range).leftDown).y + (((self._range).rightUp).y - ((self._range).leftDown).y + 1 - (self._cover).y) / 2)
  return leftDownPos
end

FurnitureItem.GetType = function(self)
  -- function num : 0_6
  return (self._furnitureItemRecord).type
end

FurnitureItem.GetLimitNum = function(self)
  -- function num : 0_7
  return (self._furnitureTypeRecorder).num
end

FurnitureItem.GetLayerId = function(self)
  -- function num : 0_8
  return (self._furnitureItemRecord).level
end

FurnitureItem.GetComfort = function(self)
  -- function num : 0_9
  return (self._furnitureItemRecord).comfortPoint
end

FurnitureItem.GetPutRangeShow = function(self)
  -- function num : 0_10
  if (self._furnitureItemRecord).putRangeShow ~= 0 then
    return (self._furnitureItemRecord).putRangeShow
  end
end

FurnitureItem.GetCoverAsset = function(self)
  -- function num : 0_11
  if (self._furnitureLayerRecorder).place == 0 then
    return {assetBundle = "sceneobjects/dorm.prefabs.assetbundle", prefabName = "dorm_placegrid_h"}
  else
    return {assetBundle = "sceneobjects/dorm.prefabs.assetbundle", prefabName = "dorm_placegrid_v"}
  end
end

FurnitureItem.GetFurnitureAsset = function(self)
  -- function num : 0_12
  return {assetBundle = (self._furnitureItemRecord).assetBundle, prefabName = (self._furnitureItemRecord).prefabName}
end

FurnitureItem.GetGridSpace = function(self)
  -- function num : 0_13
  return self._gridSpace
end

FurnitureItem.GetInitialCoordinate = function(self)
  -- function num : 0_14
  return self._initialCoordinate
end

FurnitureItem.IsWallDirection = function(self)
  -- function num : 0_15
  do return (self._furnitureLayerRecorder).place ~= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FurnitureItem.GetTrans = function(self)
  -- function num : 0_16
  return self._dormCoordinateTransRecorder
end

return FurnitureItem

