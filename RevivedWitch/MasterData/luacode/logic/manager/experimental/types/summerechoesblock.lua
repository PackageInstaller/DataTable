-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/summerechoesblock.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSRLand = (BeanManager.GetTableByName)("activity.csrland")
local CSRLandShape = (BeanManager.GetTableByName)("activity.csrlandshape")
local UIManager = ((CS.PixelNeko).UI).UIManager
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local GameObjectHelper = ((CS.PixelNeko).Common).GameObjectHelper
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local SummerEchoesBlock = strictclass("SummerEchoesBlock")
SummerEchoesBlock.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : CSRLand, _ENV
  self._id = id
  self._cfgData = CSRLand:GetRecorder(id)
  if not self._cfgData then
    LogErrorFormat("SummerEchoesBlock", "ID %s can\'t find", tostring(id))
  end
  self._coordinate = {}
  self._worldPosition = {}
  self._eventIDs = {}
  self._locked = {}
  self._autoExplore = {}
  self._fog = false
end

SummerEchoesBlock.Destroy = function(self)
  -- function num : 0_1
end

SummerEchoesBlock.Init = function(self, data)
  -- function num : 0_2
  self._coordinate = {x = data.abscissa, y = data.vertical}
  self._eventIDs = data.event
  self._locked = data.locked
  self._autoExplore = data.autoExplore
  self._fog = data.fog == 0
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SummerEchoesBlock.SetCoordinateInformation = function(self, data)
  -- function num : 0_3
  self._origin = data.origin
  self._xOffset = data.xOffset
  self._yOffset = data.yOffset
  self._xUnit = data.xUnit
  self._yUnit = data.yUnit
  self._cover = {x = self._xUnit, y = 0.8}
end

SummerEchoesBlock.GetId = function(self)
  -- function num : 0_4
  return self._id
end

SummerEchoesBlock.GetWorldPos = function(self)
  -- function num : 0_5
  return {x = (self._worldPosition).x, y = (self._worldPosition).y, z = (self._worldPosition).z}
end

SummerEchoesBlock.GetCenterPos = function(self)
  -- function num : 0_6 , upvalues : TransformStaticFunctions
  do
    if self._gameObject then
      local gameObject = (TransformStaticFunctions.GetChild)(self._gameObject, "Center")
      if gameObject then
        return {x = ((gameObject.transform).position).x, y = ((gameObject.transform).position).y, z = ((gameObject.transform).position).z}
      end
    end
    return {x = (self._worldPosition).x, y = (self._worldPosition).y, z = (self._worldPosition).z}
  end
end

SummerEchoesBlock.GetEventIconWorldPos = function(self)
  -- function num : 0_7 , upvalues : TransformStaticFunctions, _ENV
  do
    if self._gameObject then
      local gameObject = (TransformStaticFunctions.GetChild)(self._gameObject, "UIPoint")
      if not gameObject then
        LogErrorFormat("SummerEchoesBlock", "GameObeject %s Canot Find Child UIPoint", (self._gameObject).name)
        return {x = -999, y = -999, z = -999}
      end
      return {x = ((gameObject.transform).position).x, y = ((gameObject.transform).position).y, z = ((gameObject.transform).position).z}
    end
    return {x = -999, y = -999, z = -999}
  end
end

SummerEchoesBlock.GetGameObject = function(self)
  -- function num : 0_8
  return self._gameObject
end

SummerEchoesBlock.GetCoordinate = function(self)
  -- function num : 0_9
  return {x = (self._coordinate).x, y = (self._coordinate).y}
end

SummerEchoesBlock.CreatGameObjectInstantiate = function(self, parent)
  -- function num : 0_10 , upvalues : _ENV, PrefabLoader, TransformStaticFunctions, SceneObjectClick, AnimatorStaticFunctions
  self._selectAnimator = nil
  self._selectEffect = nil
  if self._gameObject then
    LogErrorFormat("SummerEchoesBlock", "SummerEchoesBlock已经创建过实例")
    return 
  end
  self._parent = parent
  self._gameObject = (PrefabLoader.LoadAndInstantiatePrefab)((self._cfgData).assetBundle, (self._cfgData).prefabName)
  ;
  (TransformStaticFunctions.SetParent)((self._gameObject).transform, self._parent)
  local x = (self._origin).x + (self._coordinate).x * self._xUnit + self._xOffset * (self._coordinate).y
  local y = (self._origin).y + (self._coordinate).y * self._yUnit + self._yOffset
  self._worldPosition = {x = x, y = 0, z = y}
  ;
  (TransformStaticFunctions.SetPosition)(self._gameObject, x, 0, y)
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)(self._gameObject)
  if sceneObjectClick then
    sceneObjectClick.IntData = self._id
  else
    LogErrorFormat("SummerEchoesBlock", "GameObject s% can\'t find SceneObjectClick Script", (self._gameObject).name)
  end
  self._selectAnimator = (AnimatorStaticFunctions.Get)(self._gameObject)
  self._selectEffect = (TransformStaticFunctions.GetChild)((self._gameObject).transform, "UI_TX_Beach_SelectEffect")
  if self._selectEffect then
    (TransformStaticFunctions.SetActive)(self._selectEffect, false)
  end
  self:RefreshFog()
end

SummerEchoesBlock.RefreshFog = function(self)
  -- function num : 0_11 , upvalues : PrefabLoader, TransformStaticFunctions, GameObjectHelper
  if self._fog and not self._fogGameObject then
    self._fogGameObject = (PrefabLoader.LoadAndInstantiatePrefab)((self._cfgData).fogAssetBundle, (self._cfgData).fogPrefabName)
    ;
    (TransformStaticFunctions.SetParent)((self._fogGameObject).transform, self._parent)
    local x = (self._origin).x + (self._coordinate).x * self._xUnit + self._xOffset * (self._coordinate).y + ((self._cfgData).fogOffset)[1]
    local y = (self._origin).y + (self._coordinate).y * self._yUnit + self._yOffset + ((self._cfgData).fogOffset)[2]
    ;
    (TransformStaticFunctions.SetPosition)(self._fogGameObject, x, 4.5, y)
  end
  do
    if self._fogGameObject then
      (GameObjectHelper.DestroyObject)(self._fogGameObject)
      self._fogGameObject = nil
    end
  end
end

SummerEchoesBlock.GetCoordinates = function(self)
  -- function num : 0_12 , upvalues : CSRLandShape, _ENV
  local coordinates = {}
  local coordinatesCfg = (CSRLandShape:GetRecorder((self._cfgData).shapeType)).landCoordinate
  coordinatesCfg = (string.split)(coordinatesCfg, ";")
  local offsetCoordinate = {}
  for _,coordinate in ipairs(coordinatesCfg) do
    offsetCoordinate = (string.split)(coordinate, ",")
    local temp = {x = tonumber(offsetCoordinate[1]) + (self._coordinate).x, y = tonumber(offsetCoordinate[2]) + (self._coordinate).y}
    ;
    (table.insert)(coordinates, temp)
  end
  return coordinates
end

SummerEchoesBlock.SetSelect = function(self, func)
  -- function num : 0_13
  self._selectFunc = func
  self:SetSelectPos()
end

SummerEchoesBlock.SetSelectPos = function(self)
  -- function num : 0_14 , upvalues : UIManager
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

SummerEchoesBlock.GetCurrentCoordinate = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local x = (((self._gameObject).transform).position).x
  local y = (((self._gameObject).transform).position).z
  local coordinate = {}
  coordinate.y = (y - (self._origin).y - self._yOffset) / self._yUnit
  coordinate.x = (x - (self._origin).x - self._xOffset * coordinate.y) / self._xUnit
  coordinate.y = (math.floor)(coordinate.y + 0.5)
  coordinate.x = (math.floor)(coordinate.x + 0.5)
  return coordinate
end

SummerEchoesBlock.SetSelectState = function(self, flg)
  -- function num : 0_16 , upvalues : TransformStaticFunctions
  if self._selectAnimator and (self._selectAnimator).speed then
    (self._selectAnimator):SetBool("select", flg)
  end
  if self._selectEffect then
    (TransformStaticFunctions.SetActive)(self._selectEffect, flg)
  end
end

return SummerEchoesBlock

