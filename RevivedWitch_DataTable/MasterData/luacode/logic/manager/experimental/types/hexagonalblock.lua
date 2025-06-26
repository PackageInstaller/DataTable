-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/hexagonalblock.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CHexagonLand = (BeanManager.GetTableByName)("activity.chexagonland")
local CHexagonLandShape = (BeanManager.GetTableByName)("activity.chexagonlandshape")
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local GameObjectHelper = ((CS.PixelNeko).Common).GameObjectHelper
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local UIManager = ((CS.PixelNeko).UI).UIManager
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local HexagonalBlock = strictclass("HexagonalBlock")
local GetWorldPosition = function(coordinate)
  -- function num : 0_0
end

HexagonalBlock.Ctor = function(self, id)
  -- function num : 0_1 , upvalues : CHexagonLand, _ENV
  self._id = id
  self._cfgData = CHexagonLand:GetRecorder(id)
  if not self._cfgData then
    LogErrorFormat("HexagonalBlock", "ID %s cannt find", tostring(id))
  end
  self._worldPosition = {}
  self._localWordPos = {}
  self._coordinate = {}
  self._level = 0
  self._eventID = 0
  self._gameObject = nil
end

HexagonalBlock.Destroy = function(self)
  -- function num : 0_2
end

HexagonalBlock.Init = function(self, data)
  -- function num : 0_3 , upvalues : GetWorldPosition
  self._coordinate = {x = data.abscissa, y = data.vertical}
  self._worldPosition = GetWorldPosition(self._coordinate)
  self._level = data.level
  self._eventIDs = data.event
end

HexagonalBlock.SetCoordinateInformation = function(self, data)
  -- function num : 0_4
  self._origin = data.origin
  self._xOffset = data.xOffset
  self._yOffset = data.yOffset
  self._xUnit = data.xUnit
  self._yUnit = data.yUnit
  self._cover = {x = self._xUnit, y = 0.8}
end

HexagonalBlock.GetId = function(self)
  -- function num : 0_5
  return self._id
end

HexagonalBlock.GetWorldPos = function(self)
  -- function num : 0_6
  return {x = (self._worldPosition).x, y = (self._worldPosition).y, z = (self._worldPosition).z}
end

HexagonalBlock.GetEventIconWorldPos = function(self)
  -- function num : 0_7 , upvalues : TransformStaticFunctions, _ENV
  do
    if self._gameObject then
      local gameObject = (TransformStaticFunctions.GetChild)(self._gameObject, "UIPoint")
      if not gameObject then
        LogErrorFormat("HexagonalBlock", "GameObeject %s Canot Find Child UIPoint", (self._gameObject).name)
        return {x = -999, y = -999, z = -999}
      end
      return {x = ((gameObject.transform).position).x, y = ((gameObject.transform).position).y, z = ((gameObject.transform).position).z}
    end
    return {x = -999, y = -999, z = -999}
  end
end

HexagonalBlock.GetGameObject = function(self)
  -- function num : 0_8
  return self._gameObject
end

HexagonalBlock.GetCoordinate = function(self)
  -- function num : 0_9
  return {x = (self._coordinate).x, y = (self._coordinate).y}
end

HexagonalBlock.GetTempCoordinate = function(self)
  -- function num : 0_10
  return {x = (self._tempCoordinate).x, y = (self._tempCoordinate).y}
end

HexagonalBlock.SetWorldPos = function(self, worldPosition)
  -- function num : 0_11 , upvalues : TransformStaticFunctions
  (TransformStaticFunctions.SetPosition)(self._gameObject, worldPosition.x, worldPosition.y, worldPosition.z)
  self._worldPosition = worldPosition
  self:SetSelectPos()
end

HexagonalBlock.CanMove = function(self)
  -- function num : 0_12
  do return (self._cfgData).canMove == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HexagonalBlock.CreatGameObjectInstantiate = function(self, parent)
  -- function num : 0_13 , upvalues : _ENV, PrefabLoader, TransformStaticFunctions, SceneObjectClick, AnimatorStaticFunctions
  self._selectAnimator = nil
  self._selectEffect = nil
  if self._gameObject then
    LogErrorFormat("HexagonalBlock", "HexagonalBlock已经创建过实例")
    return 
  end
  self._parent = parent
  self._gameObject = (PrefabLoader.LoadAndInstantiatePrefab)((self._cfgData).assetBundle, ((self._cfgData).prefabName)[self._level])
  ;
  (TransformStaticFunctions.SetParent)((self._gameObject).transform, parent)
  local x = (self._origin).x + (self._coordinate).x * self._xUnit + self._xOffset * (self._coordinate).y
  local y = (self._origin).y + (self._coordinate).y * self._yUnit + self._yOffset
  self._worldPosition = {x = x, y = 0, z = y}
  ;
  (TransformStaticFunctions.SetPosition)(self._gameObject, x, 0, y)
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)(self._gameObject)
  if sceneObjectClick then
    sceneObjectClick.IntData = self._id
  else
    LogErrorFormat("HexagonalBlock", "GameObject s% cannt find SceneObjectClick Script", (self._gameObject).name)
  end
  self._selectAnimator = (AnimatorStaticFunctions.Get)(self._gameObject)
  self._selectEffect = (TransformStaticFunctions.GetChild)((self._gameObject).transform, "UI_TX_Beach_SelectEffect")
  if self._selectEffect then
    (TransformStaticFunctions.SetActive)(self._selectEffect, false)
  end
end

HexagonalBlock.SetWorldPosByCoordinate = function(self, coordinate)
  -- function num : 0_14 , upvalues : TransformStaticFunctions
  local x = (self._origin).x + coordinate.x * self._xUnit + self._xOffset * coordinate.y
  local y = (self._origin).y + coordinate.y * self._yUnit + self._yOffset
  self._worldPosition = {x = x, y = 0, z = y}
  ;
  (TransformStaticFunctions.SetPosition)(self._gameObject, x, 0, y)
  self:SetSelectPos()
end

HexagonalBlock.SetPos = function(self, pos)
  -- function num : 0_15 , upvalues : _ENV, TransformStaticFunctions
  if not self._gameObject then
    LogError("HexagonalBlock", "No Instantiate")
    return 
  end
  ;
  (TransformStaticFunctions.SetPosition)(self._gameObject, pos.x, pos.y, pos.z)
end

HexagonalBlock.DestroyInstantiate = function(self)
  -- function num : 0_16 , upvalues : GameObjectHelper
  (GameObjectHelper.DestroyObject)(self._gameObject)
  self._gameObject = nil
end

HexagonalBlock.InitSceneObjectClickData = function(self)
  -- function num : 0_17 , upvalues : _ENV, SceneObjectClick
  if not self._gameObject then
    LogError("HexagonalBlock", "No Instantiate")
    return 
  end
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)(self._gameObject)
  if sceneObjectClick then
    sceneObjectClick.IntData = self._id
  else
    LogError("HexagonalBlock", "No SceneObjectClick Script")
  end
end

HexagonalBlock.EndDrag = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local x = (self._worldPosition).x
  local y = (self._worldPosition).z
  local coordinate = {}
  coordinate.y = (y - (self._origin).y - self._yOffset) / self._yUnit
  coordinate.x = (x - (self._origin).x - self._xOffset * coordinate.y) / self._xUnit
  coordinate.y = (math.floor)(coordinate.y + 0.5)
  coordinate.x = (math.floor)(coordinate.x + 0.5)
  self._tempCoordinate = coordinate
  self:SetWorldPosByCoordinate(self._tempCoordinate)
  return self._tempCoordinate
end

HexagonalBlock.GetCoordinates = function(self)
  -- function num : 0_19 , upvalues : CHexagonLandShape, _ENV
  local coordinates = {}
  local coordinatesCfg = (CHexagonLandShape:GetRecorder((self._cfgData).shapeType)).landCoordinate
  coordinatesCfg = (string.split)(coordinatesCfg, ";")
  local offsetCoordinate = {}
  for i,coordinate in ipairs(coordinatesCfg) do
    offsetCoordinate = (string.split)(coordinate, ",")
    local temp = {x = tonumber(offsetCoordinate[1]) + (self._coordinate).x, y = tonumber(offsetCoordinate[2]) + (self._coordinate).y}
    ;
    (table.insert)(coordinates, temp)
  end
  return coordinates
end

HexagonalBlock.GetTempCoordinates = function(self)
  -- function num : 0_20 , upvalues : CHexagonLandShape, _ENV
  local tempCoordinates = {}
  local coordinatesCfg = (CHexagonLandShape:GetRecorder((self._cfgData).shapeType)).landCoordinate
  coordinatesCfg = (string.split)(coordinatesCfg, ";")
  local offsetCoordinate = {}
  for i,coordinate in ipairs(coordinatesCfg) do
    offsetCoordinate = (string.split)(coordinate, ",")
    local temp = {x = tonumber(offsetCoordinate[1]) + (self._tempCoordinate).x, y = tonumber(offsetCoordinate[2]) + (self._tempCoordinate).y}
    ;
    (table.insert)(tempCoordinates, temp)
  end
  return tempCoordinates
end

HexagonalBlock.CancelMove = function(self)
  -- function num : 0_21
  self:SetWorldPosByCoordinate(self._coordinate)
end

HexagonalBlock.SubmitMove = function(self)
  -- function num : 0_22
  self._coordinate = self._tempCoordinate
  self._tempCoordinate = nil
end

HexagonalBlock.SetSelect = function(self, func)
  -- function num : 0_23
  self._selectFunc = func
  self:SetSelectPos()
end

HexagonalBlock.SetSelectPos = function(self)
  -- function num : 0_24 , upvalues : UIManager
  local leftDownWordPos = {}
  local rightUpWordPos = {}
  leftDownWordPos.x = (self._worldPosition).x - (self._cover).x / 2
  rightUpWordPos.x = (self._worldPosition).x + (self._cover).x / 2
  leftDownWordPos.y = (self._worldPosition).y
  rightUpWordPos.y = (self._worldPosition).y
  leftDownWordPos.z = (self._worldPosition).z - (self._cover).y / 2
  rightUpWordPos.z = (self._worldPosition).z + (self._cover).y / 2
  ;
  (self._selectFunc)((UIManager.TransformPoint)((self._parentGameObject).gameObject, leftDownWordPos), (UIManager.TransformPoint)((self._parentGameObject).gameObject, rightUpWordPos), self._worldPosition)
end

HexagonalBlock.OnLevelUp = function(self, level)
  -- function num : 0_25 , upvalues : TransformStaticFunctions
  if self._level < level then
    self._level = level
    ;
    (TransformStaticFunctions.SetActive)(self._gameObject, false)
    self._gameObject = nil
    self:CreatGameObjectInstantiate(self._parent)
  end
end

HexagonalBlock.GetCurrentCoordinate = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local x = (((self._gameObject).transform).position).x
  local y = (((self._gameObject).transform).position).z
  local coordinate = {}
  coordinate.y = (y - (self._origin).y - self._yOffset) / self._yUnit
  coordinate.x = (x - (self._origin).x - self._xOffset * coordinate.y) / self._xUnit
  coordinate.y = (math.floor)(coordinate.y + 0.5)
  coordinate.x = (math.floor)(coordinate.x + 0.5)
  return coordinate
end

HexagonalBlock.SetSelectState = function(self, flg)
  -- function num : 0_27 , upvalues : TransformStaticFunctions
  if self._selectAnimator and (self._selectAnimator).speed then
    (self._selectAnimator):SetBool("select", flg)
  end
  if self._selectEffect then
    (TransformStaticFunctions.SetActive)(self._selectEffect, flg)
  end
end

HexagonalBlock.PlayBuildAnimation = function(self)
  -- function num : 0_28
  if self._selectAnimator then
    (self._selectAnimator):Play("Create")
  end
end

return HexagonalBlock

