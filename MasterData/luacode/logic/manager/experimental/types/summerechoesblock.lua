local CSRLand = BeanManager.GetTableByName("activity.csrland")
local CSRLandShape = BeanManager.GetTableByName("activity.csrlandshape")
local UIManager = CS.PixelNeko.UI.UIManager
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local GameObjectHelper = CS.PixelNeko.Common.GameObjectHelper
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local SummerEchoesBlock = strictclass("SummerEchoesBlock")

function SummerEchoesBlock:Ctor(id)
  self._id = id
  self._cfgData = CSRLand:GetRecorder(id)
  if not self._cfgData then
    LogErrorFormat("SummerEchoesBlock", "ID %s can't find", tostring(id))
  end
  self._coordinate = {}
  self._worldPosition = {}
  self._eventIDs = {}
  self._locked = {}
  self._autoExplore = {}
  self._fog = false
end

function SummerEchoesBlock:Destroy()
end

function SummerEchoesBlock:Init(data)
  self._coordinate = {
    x = data.abscissa,
    y = data.vertical
  }
  self._eventIDs = data.event
  self._locked = data.locked
  self._autoExplore = data.autoExplore
  self._fog = data.fog == 0
end

function SummerEchoesBlock:SetCoordinateInformation(data)
  self._origin = data.origin
  self._xOffset = data.xOffset
  self._yOffset = data.yOffset
  self._xUnit = data.xUnit
  self._yUnit = data.yUnit
  self._cover = {
    x = self._xUnit,
    y = 0.8
  }
end

function SummerEchoesBlock:GetId()
  return self._id
end

function SummerEchoesBlock:GetWorldPos()
  return {
    x = self._worldPosition.x,
    y = self._worldPosition.y,
    z = self._worldPosition.z
  }
end

function SummerEchoesBlock:GetCenterPos()
  if self._gameObject then
    local gameObject = TransformStaticFunctions.GetChild(self._gameObject, "Center")
    if gameObject then
      return {
        x = gameObject.transform.position.x,
        y = gameObject.transform.position.y,
        z = gameObject.transform.position.z
      }
    end
  end
  return {
    x = self._worldPosition.x,
    y = self._worldPosition.y,
    z = self._worldPosition.z
  }
end

function SummerEchoesBlock:GetEventIconWorldPos()
  if self._gameObject then
    local gameObject = TransformStaticFunctions.GetChild(self._gameObject, "UIPoint")
    if not gameObject then
      LogErrorFormat("SummerEchoesBlock", "GameObeject %s Canot Find Child UIPoint", self._gameObject.name)
      return {
        x = -999,
        y = -999,
        z = -999
      }
    end
    return {
      x = gameObject.transform.position.x,
      y = gameObject.transform.position.y,
      z = gameObject.transform.position.z
    }
  end
  return {
    x = -999,
    y = -999,
    z = -999
  }
end

function SummerEchoesBlock:GetGameObject()
  return self._gameObject
end

function SummerEchoesBlock:GetCoordinate()
  return {
    x = self._coordinate.x,
    y = self._coordinate.y
  }
end

function SummerEchoesBlock:CreatGameObjectInstantiate(parent)
  self._selectAnimator = nil
  self._selectEffect = nil
  if self._gameObject then
    LogErrorFormat("SummerEchoesBlock", "SummerEchoesBlock已经创建过实例")
    return
  end
  self._parent = parent
  self._gameObject = PrefabLoader.LoadAndInstantiatePrefab(self._cfgData.assetBundle, self._cfgData.prefabName)
  TransformStaticFunctions.SetParent(self._gameObject.transform, self._parent)
  local x = self._origin.x + self._coordinate.x * self._xUnit + self._xOffset * self._coordinate.y
  local y = self._origin.y + self._coordinate.y * self._yUnit + self._yOffset
  self._worldPosition = {
    x = x,
    y = 0,
    z = y
  }
  TransformStaticFunctions.SetPosition(self._gameObject, x, 0, y)
  local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(self._gameObject)
  if sceneObjectClick then
    sceneObjectClick.IntData = self._id
  else
    LogErrorFormat("SummerEchoesBlock", "GameObject s% can't find SceneObjectClick Script", self._gameObject.name)
  end
  self._selectAnimator = AnimatorStaticFunctions.Get(self._gameObject)
  self._selectEffect = TransformStaticFunctions.GetChild(self._gameObject.transform, "UI_TX_Beach_SelectEffect")
  if self._selectEffect then
    TransformStaticFunctions.SetActive(self._selectEffect, false)
  end
  self:RefreshFog()
end

function SummerEchoesBlock:RefreshFog()
  if self._fog then
    if not self._fogGameObject then
      self._fogGameObject = PrefabLoader.LoadAndInstantiatePrefab(self._cfgData.fogAssetBundle, self._cfgData.fogPrefabName)
      TransformStaticFunctions.SetParent(self._fogGameObject.transform, self._parent)
      local x = self._origin.x + self._coordinate.x * self._xUnit + self._xOffset * self._coordinate.y + self._cfgData.fogOffset[1]
      local y = self._origin.y + self._coordinate.y * self._yUnit + self._yOffset + self._cfgData.fogOffset[2]
      TransformStaticFunctions.SetPosition(self._fogGameObject, x, 4.5, y)
    end
  elseif self._fogGameObject then
    GameObjectHelper.DestroyObject(self._fogGameObject)
    self._fogGameObject = nil
  end
end

function SummerEchoesBlock:GetCoordinates()
  local coordinates = {}
  local coordinatesCfg = CSRLandShape:GetRecorder(self._cfgData.shapeType).landCoordinate
  coordinatesCfg = string.split(coordinatesCfg, ";")
  local offsetCoordinate = {}
  for _, coordinate in ipairs(coordinatesCfg) do
    offsetCoordinate = string.split(coordinate, ",")
    local temp = {
      x = tonumber(offsetCoordinate[1]) + self._coordinate.x,
      y = tonumber(offsetCoordinate[2]) + self._coordinate.y
    }
    table.insert(coordinates, temp)
  end
  return coordinates
end

function SummerEchoesBlock:SetSelect(func)
  self._selectFunc = func
  self:SetSelectPos()
end

function SummerEchoesBlock:SetSelectPos()
  local leftDownWordPos = {}
  local rightUpWordPos = {}
  leftDownWordPos.x = self._worldPosition.x - self._cover.x / 2
  rightUpWordPos.x = self._worldPosition.x + self._cover.x / 2
  leftDownWordPos.y = self._worldPosition.y
  rightUpWordPos.y = self._worldPosition.y
  leftDownWordPos.z = self._worldPosition.z - self._cover.y / 2
  rightUpWordPos.z = self._worldPosition.z + self._cover.y / 2
  self._selectFunc(UIManager.TransformPoint(self._parentGameObject.gameObject, leftDownWordPos), UIManager.TransformPoint(self._parentGameObject.gameObject, rightUpWordPos), self._worldPosition)
end

function SummerEchoesBlock:GetCurrentCoordinate()
  local x = self._gameObject.transform.position.x
  local y = self._gameObject.transform.position.z
  local coordinate = {}
  coordinate.y = (y - self._origin.y - self._yOffset) / self._yUnit
  coordinate.x = (x - self._origin.x - self._xOffset * coordinate.y) / self._xUnit
  coordinate.y = math.floor(coordinate.y + 0.5)
  coordinate.x = math.floor(coordinate.x + 0.5)
  return coordinate
end

function SummerEchoesBlock:SetSelectState(flg)
  if self._selectAnimator and self._selectAnimator.speed then
    self._selectAnimator:SetBool("select", flg)
  end
  if self._selectEffect then
    TransformStaticFunctions.SetActive(self._selectEffect, flg)
  end
end

return SummerEchoesBlock
