local YardSceneHelper = CS.PixelNeko.P1.Scene.YardSceneHelper
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local UIManager = CS.PixelNeko.UI.UIManager
local CDormFloorCfg = BeanManager.GetTableByName("courtyard.cdormfloor")
local BagTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local Furniture = strictclass("Furniture")

function Furniture:Ctor(id, key)
  if key and key ~= 0 then
    self._item = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, key)
  else
    self._item = FurnitureItem.Create(id)
  end
  self._isWallDirection = self._item:IsWallDirection()
  self._initialCoordinate = self._item:GetInitialCoordinate()
  self._gridSpace = self._item:GetGridSpace()
  self._cover = self._item:GetCover()
  self._range = self._item:GetRange()
  self._trans = self._item:GetTrans()
  self._type = self._item:GetType()
end

function Furniture:Destroy()
  if self._type == 1 then
    TransformStaticFunctions.SetActive(self._roomScenes[self._roomId].defaultFloor, true)
  elseif self._type == 2 then
    TransformStaticFunctions.SetActive(self._roomScenes[self._roomId].defaultWall, true)
  end
  if self._furnitureGameObject then
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._furnitureGameObject)
    self._furnitureGameObject = nil
  end
  if self._coverGameObject then
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._coverGameObject)
    self._coverGameObject = nil
  end
end

function Furniture:SetInitLeftDownGridPos(pos)
  self._leftDownPos = pos
end

function Furniture:SetInitPosition(sceneController, furnitureInfo)
  self._sceneController = sceneController
  self._roomId = furnitureInfo.roomId
  self._roomScenes = self._sceneController:GetRoomScenes()
  local angleX, angleY, angleZ = TransformStaticFunctions.GetWorldEuler(self._sceneController:GetMainCamera().gameObject)
  self._angleX = angleX
  self._parentGameObject = self._roomScenes[self._roomId].furniturePoints[self._item:GetLayerId()]
  self._wallObject = self._roomScenes[self._roomId].wallObject
  local coverAsset = self._item:GetCoverAsset()
  self._coverGameObject = YardSceneHelper.CreatePlayer(coverAsset.assetBundle, coverAsset.prefabName, self._parentGameObject)
  self._coverGameObjectColor = 1
  AnimationHelper.SetAnimatorInteger2(self._coverGameObject, "state", 1)
  local furnitureAsset = self._item:GetFurnitureAsset()
  self._furnitureGameObject = YardSceneHelper.CreatePlayer(furnitureAsset.assetBundle, furnitureAsset.prefabName, self._parentGameObject)
  if self._type == 1 then
    TransformStaticFunctions.SetActive(self._roomScenes[self._roomId].defaultFloor, false)
  elseif self._type == 2 then
    TransformStaticFunctions.SetActive(self._roomScenes[self._roomId].defaultWall, false)
  end
  self._localWordPos = {}
  if not self._leftDownPos then
    self._leftDownPos = self._item:GetDefaultLeftDownGridPos()
  end
  self:SetPositionByLeftDownGridPos()
  local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(self._furnitureGameObject)
  if sceneObjectClick == nil then
    return
  end
  sceneObjectClick.SceneName = CDormFloorCfg:GetRecorder(self._roomId).name
  sceneObjectClick.IntData = self._item:GetKey()
  sceneObjectClick.StringData = self._item:GetLayerId()
end

function Furniture:SetPositionByLeftDownGridPos()
  if not self._isWallDirection then
    self._localWordPos.x = self._initialCoordinate.x + (self._leftDownPos.x - 1) * self._gridSpace + self._cover.x * self._gridSpace / 2
    self._localWordPos.y = 0
    self._localWordPos.z = self._initialCoordinate.z + (self._leftDownPos.y - 1) * self._gridSpace + self._cover.y * self._gridSpace / 2
    TransformStaticFunctions.SetLocalScale(self._coverGameObject, self._cover.x * self._gridSpace, 1, self._cover.y * self._gridSpace)
  else
    self._localWordPos.x = self._initialCoordinate.x + (self._leftDownPos.x - 1) * self._gridSpace + self._cover.x * self._gridSpace / 2
    self._localWordPos.y = self._initialCoordinate.y + (self._leftDownPos.y - 1) * self._gridSpace + self._cover.y * self._gridSpace / 2
    self._localWordPos.z = 0
    TransformStaticFunctions.SetLocalScale(self._coverGameObject, self._cover.x * self._gridSpace, self._cover.y * self._gridSpace, 1)
  end
  TransformStaticFunctions.SetLocalPosition(self._furnitureGameObject, self._localWordPos.x, self._localWordPos.y, self._localWordPos.z)
  TransformStaticFunctions.SetLocalPosition(self._coverGameObject, self._localWordPos.x, self._localWordPos.y, self._localWordPos.z)
  self._wordPos = {}
  self._wordPos.x, self._wordPos.y, self._wordPos.z = TransformStaticFunctions.GetPosition(self._coverGameObject)
end

function Furniture:BeginDragFurniture(dragPos)
  self._lastPos = {}
  local pos = UIManager.InverseTransformPoint(self._parentGameObject, dragPos)
  self._lastPos.x = pos.x
  if self._isWallDirection then
    self._lastPos.y = pos.y
  else
    pos = UIManager.InverseTransformPoint(self._wallObject, dragPos)
    self._lastPos.y = pos.y
  end
end

function Furniture:DragFurniture(dragPos)
  self._lastLeftDownPos = {
    x = self._leftDownPos.x,
    y = self._leftDownPos.y
  }
  local pos = UIManager.InverseTransformPoint(self._parentGameObject, dragPos)
  local posX = pos.x
  local deltaX = posX - self._lastPos.x
  local posY = pos.y
  local deltaY = posY - self._lastPos.y
  if not self._isWallDirection then
    pos = UIManager.InverseTransformPoint(self._wallObject, dragPos)
    posY = pos.y
    deltaY = posY - self._lastPos.y - self._cover.y * self._gridSpace / 2 * math.sin(math.rad(self._angleX))
  end
  local leftDownX = math.floor((pos.x - self._initialCoordinate.x - self._cover.x * self._gridSpace / 2) / self._gridSpace) + 1
  if leftDownX < self._range.leftDown.x then
    leftDownX = self._range.leftDown.x
  elseif leftDownX > self._range.rightUp.x - self._cover.x + 1 then
    leftDownX = self._range.rightUp.x - self._cover.x + 1
  end
  if deltaX < 0 and leftDownX < self._leftDownPos.x or 0 < deltaX and leftDownX > self._leftDownPos.x then
    self._leftDownPos.x = leftDownX
  end
  local leftDownY
  if self._isWallDirection then
    leftDownY = math.floor((posY - self._initialCoordinate.y - self._cover.y * self._gridSpace / 2) / self._gridSpace) + 1
  else
    local posZ = posY / math.sin(math.rad(self._angleX))
    leftDownY = math.floor((posZ - self._initialCoordinate.z - self._cover.y * self._gridSpace / 2) / self._gridSpace) + 1
  end
  if leftDownY < self._range.leftDown.y then
    leftDownY = self._range.leftDown.y
  elseif leftDownY > self._range.rightUp.y - self._cover.y + 1 then
    leftDownY = self._range.rightUp.y - self._cover.y + 1
  end
  if deltaY < 0 and leftDownY < self._leftDownPos.y or 0 < deltaY and leftDownY > self._leftDownPos.y then
    self._leftDownPos.y = leftDownY
  end
  if self._leftDownPos.x ~= self._lastLeftDownPos.x or self._leftDownPos.y ~= self._lastLeftDownPos.y then
    self:SetPositionByLeftDownGridPos()
    self._lastPos.x = posX
    self._lastPos.y = posY
    if self._selectFunc then
      self:SetSelectPos()
    end
  end
end

function Furniture:GetLeftDownGridPos()
  return self._leftDownPos
end

function Furniture:GetRightUpGridPos()
  return {
    x = self._leftDownPos.x + self._cover.x - 1,
    y = self._leftDownPos.y + self._cover.y - 1
  }
end

function Furniture:SetCoverGameObjectColor(state)
  if self._coverGameObjectColor ~= state then
    self._coverGameObjectColor = state
    AnimationHelper.SetAnimatorInteger2(self._coverGameObject, "state", state)
  end
end

function Furniture:SetCoverGameObjectActive(isActive)
  if self._type ~= 1 and self._type ~= 2 then
    if isActive then
      TransformStaticFunctions.SetActive(self._coverGameObject, isActive)
      if isActive then
        AnimationHelper.SetAnimatorInteger2(self._coverGameObject, "state", self._coverGameObjectColor)
      end
    elseif self._coverGameObjectColor == 1 then
      TransformStaticFunctions.SetActive(self._coverGameObject, isActive)
    end
  else
    TransformStaticFunctions.SetActive(self._coverGameObject, false)
  end
end

function Furniture:SetSelect(func)
  self._selectFunc = func
  self:SetSelectPos()
end

function Furniture:SetSelectPos()
  local leftDownWordPos = {}
  local rightUpWordPos = {}
  if not self._isWallDirection then
    leftDownWordPos.y = self._localWordPos.y
    leftDownWordPos.z = self._localWordPos.z - self._cover.y * self._gridSpace / 2
    rightUpWordPos.y = self._localWordPos.y
    rightUpWordPos.z = self._localWordPos.z + self._cover.y * self._gridSpace / 2
  else
    leftDownWordPos.y = self._localWordPos.y - self._cover.y * self._gridSpace / 2
    leftDownWordPos.z = self._localWordPos.z
    rightUpWordPos.y = self._localWordPos.y + self._cover.y * self._gridSpace / 2
    rightUpWordPos.z = self._localWordPos.z
  end
  leftDownWordPos.x = self._localWordPos.x - self._cover.x * self._gridSpace / 2
  rightUpWordPos.x = self._localWordPos.x + self._cover.x * self._gridSpace / 2
  local rightUpGridPos = self:GetRightUpGridPos()
  local arriveTop = rightUpGridPos.y == 7
  self._selectFunc(UIManager.TransformPoint(self._parentGameObject, leftDownWordPos), UIManager.TransformPoint(self._parentGameObject, rightUpWordPos), self._wordPos, arriveTop)
end

function Furniture:CancleSelect()
  self._selectFunc = nil
end

function Furniture:GetItem()
  return self._item
end

return Furniture
