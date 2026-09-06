local CHexagonLand = BeanManager.GetTableByName("activity.chexagonland")
local CHexagonLandShape = BeanManager.GetTableByName("activity.chexagonlandshape")
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local GameObjectHelper = CS.PixelNeko.Common.GameObjectHelper
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local HexagonalBlock = strictclass("HexagonalBlock")

local function GetWorldPosition(coordinate)
end

function HexagonalBlock:Ctor(id)
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

function HexagonalBlock:Destroy()
end

function HexagonalBlock:Init(data)
  self._coordinate = {
    x = data.abscissa,
    y = data.vertical
  }
  self._worldPosition = GetWorldPosition(self._coordinate)
  self._level = data.level
  self._eventIDs = data.event
end

function HexagonalBlock:SetCoordinateInformation(data)
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

function HexagonalBlock:GetId()
  return self._id
end

function HexagonalBlock:GetWorldPos()
  return {
    x = self._worldPosition.x,
    y = self._worldPosition.y,
    z = self._worldPosition.z
  }
end

function HexagonalBlock:GetEventIconWorldPos()
  if self._gameObject then
    local gameObject = TransformStaticFunctions.GetChild(self._gameObject, "UIPoint")
    if not gameObject then
      LogErrorFormat("HexagonalBlock", "GameObeject %s Canot Find Child UIPoint", self._gameObject.name)
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

function HexagonalBlock:GetGameObject()
  return self._gameObject
end

function HexagonalBlock:GetCoordinate()
  return {
    x = self._coordinate.x,
    y = self._coordinate.y
  }
end

function HexagonalBlock:GetTempCoordinate()
  return {
    x = self._tempCoordinate.x,
    y = self._tempCoordinate.y
  }
end

function HexagonalBlock:SetWorldPos(worldPosition)
  TransformStaticFunctions.SetPosition(self._gameObject, worldPosition.x, worldPosition.y, worldPosition.z)
  self._worldPosition = worldPosition
  self:SetSelectPos()
end

function HexagonalBlock:CanMove()
  return self._cfgData.canMove == 1
end

function HexagonalBlock:CreatGameObjectInstantiate(parent)
  self._selectAnimator = nil
  self._selectEffect = nil
  if self._gameObject then
    LogErrorFormat("HexagonalBlock", "HexagonalBlock已经创建过实例")
    return
  end
  self._parent = parent
  self._gameObject = PrefabLoader.LoadAndInstantiatePrefab(self._cfgData.assetBundle, self._cfgData.prefabName[self._level])
  TransformStaticFunctions.SetParent(self._gameObject.transform, parent)
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
    LogErrorFormat("HexagonalBlock", "GameObject s% cannt find SceneObjectClick Script", self._gameObject.name)
  end
  self._selectAnimator = AnimatorStaticFunctions.Get(self._gameObject)
  self._selectEffect = TransformStaticFunctions.GetChild(self._gameObject.transform, "UI_TX_Beach_SelectEffect")
  if self._selectEffect then
    TransformStaticFunctions.SetActive(self._selectEffect, false)
  end
end

function HexagonalBlock:SetWorldPosByCoordinate(coordinate)
  local x = self._origin.x + coordinate.x * self._xUnit + self._xOffset * coordinate.y
  local y = self._origin.y + coordinate.y * self._yUnit + self._yOffset
  self._worldPosition = {
    x = x,
    y = 0,
    z = y
  }
  TransformStaticFunctions.SetPosition(self._gameObject, x, 0, y)
  self:SetSelectPos()
end

function HexagonalBlock:SetPos(pos)
  if not self._gameObject then
    LogError("HexagonalBlock", "No Instantiate")
    return
  end
  TransformStaticFunctions.SetPosition(self._gameObject, pos.x, pos.y, pos.z)
end

function HexagonalBlock:DestroyInstantiate()
  GameObjectHelper.DestroyObject(self._gameObject)
  self._gameObject = nil
end

function HexagonalBlock:InitSceneObjectClickData()
  if not self._gameObject then
    LogError("HexagonalBlock", "No Instantiate")
    return
  end
  local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(self._gameObject)
  if sceneObjectClick then
    sceneObjectClick.IntData = self._id
  else
    LogError("HexagonalBlock", "No SceneObjectClick Script")
  end
end

function HexagonalBlock:EndDrag()
  local x = self._worldPosition.x
  local y = self._worldPosition.z
  local coordinate = {}
  coordinate.y = (y - self._origin.y - self._yOffset) / self._yUnit
  coordinate.x = (x - self._origin.x - self._xOffset * coordinate.y) / self._xUnit
  coordinate.y = math.floor(coordinate.y + 0.5)
  coordinate.x = math.floor(coordinate.x + 0.5)
  self._tempCoordinate = coordinate
  self:SetWorldPosByCoordinate(self._tempCoordinate)
  return self._tempCoordinate
end

function HexagonalBlock:GetCoordinates()
  local coordinates = {}
  local coordinatesCfg = CHexagonLandShape:GetRecorder(self._cfgData.shapeType).landCoordinate
  coordinatesCfg = string.split(coordinatesCfg, ";")
  local offsetCoordinate = {}
  for i, coordinate in ipairs(coordinatesCfg) do
    offsetCoordinate = string.split(coordinate, ",")
    local temp = {
      x = tonumber(offsetCoordinate[1]) + self._coordinate.x,
      y = tonumber(offsetCoordinate[2]) + self._coordinate.y
    }
    table.insert(coordinates, temp)
  end
  return coordinates
end

function HexagonalBlock:GetTempCoordinates()
  local tempCoordinates = {}
  local coordinatesCfg = CHexagonLandShape:GetRecorder(self._cfgData.shapeType).landCoordinate
  coordinatesCfg = string.split(coordinatesCfg, ";")
  local offsetCoordinate = {}
  for i, coordinate in ipairs(coordinatesCfg) do
    offsetCoordinate = string.split(coordinate, ",")
    local temp = {
      x = tonumber(offsetCoordinate[1]) + self._tempCoordinate.x,
      y = tonumber(offsetCoordinate[2]) + self._tempCoordinate.y
    }
    table.insert(tempCoordinates, temp)
  end
  return tempCoordinates
end

function HexagonalBlock:CancelMove()
  self:SetWorldPosByCoordinate(self._coordinate)
end

function HexagonalBlock:SubmitMove()
  self._coordinate = self._tempCoordinate
  self._tempCoordinate = nil
end

function HexagonalBlock:SetSelect(func)
  self._selectFunc = func
  self:SetSelectPos()
end

function HexagonalBlock:SetSelectPos()
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

function HexagonalBlock:OnLevelUp(level)
  if level > self._level then
    self._level = level
    TransformStaticFunctions.SetActive(self._gameObject, false)
    self._gameObject = nil
    self:CreatGameObjectInstantiate(self._parent)
  end
end

function HexagonalBlock:GetCurrentCoordinate()
  local x = self._gameObject.transform.position.x
  local y = self._gameObject.transform.position.z
  local coordinate = {}
  coordinate.y = (y - self._origin.y - self._yOffset) / self._yUnit
  coordinate.x = (x - self._origin.x - self._xOffset * coordinate.y) / self._xUnit
  coordinate.y = math.floor(coordinate.y + 0.5)
  coordinate.x = math.floor(coordinate.x + 0.5)
  return coordinate
end

function HexagonalBlock:SetSelectState(flg)
  if self._selectAnimator and self._selectAnimator.speed then
    self._selectAnimator:SetBool("select", flg)
  end
  if self._selectEffect then
    TransformStaticFunctions.SetActive(self._selectEffect, flg)
  end
end

function HexagonalBlock:PlayBuildAnimation()
  if self._selectAnimator then
    self._selectAnimator:Play("Create")
  end
end

return HexagonalBlock
