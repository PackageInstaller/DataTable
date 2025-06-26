-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/furniture.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local YardSceneHelper = (((CS.PixelNeko).P1).Scene).YardSceneHelper
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local UIManager = ((CS.PixelNeko).UI).UIManager
local CDormFloorCfg = (BeanManager.GetTableByName)("courtyard.cdormfloor")
local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local Furniture = strictclass("Furniture")
Furniture.Ctor = function(self, id, key)
  -- function num : 0_0 , upvalues : _ENV, BagTypeEnum, FurnitureItem
  if key and key ~= 0 then
    self._item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, key)
  else
    self._item = (FurnitureItem.Create)(id)
  end
  self._isWallDirection = (self._item):IsWallDirection()
  self._initialCoordinate = (self._item):GetInitialCoordinate()
  self._gridSpace = (self._item):GetGridSpace()
  self._cover = (self._item):GetCover()
  self._range = (self._item):GetRange()
  self._trans = (self._item):GetTrans()
  self._type = (self._item):GetType()
end

Furniture.Destroy = function(self)
  -- function num : 0_1 , upvalues : TransformStaticFunctions, _ENV
  if self._type == 1 then
    (TransformStaticFunctions.SetActive)(((self._roomScenes)[self._roomId]).defaultFloor, true)
  else
    if self._type == 2 then
      (TransformStaticFunctions.SetActive)(((self._roomScenes)[self._roomId]).defaultWall, true)
    end
  end
  if self._furnitureGameObject then
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._furnitureGameObject)
    self._furnitureGameObject = nil
  end
  if self._coverGameObject then
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._coverGameObject)
    self._coverGameObject = nil
  end
end

Furniture.SetInitLeftDownGridPos = function(self, pos)
  -- function num : 0_2
  self._leftDownPos = pos
end

Furniture.SetInitPosition = function(self, sceneController, furnitureInfo)
  -- function num : 0_3 , upvalues : TransformStaticFunctions, YardSceneHelper, AnimationHelper, SceneObjectClick, CDormFloorCfg
  self._sceneController = sceneController
  self._roomId = furnitureInfo.roomId
  self._roomScenes = (self._sceneController):GetRoomScenes()
  local angleX, angleY, angleZ = (TransformStaticFunctions.GetWorldEuler)(((self._sceneController):GetMainCamera()).gameObject)
  self._angleX = angleX
  self._parentGameObject = (((self._roomScenes)[self._roomId]).furniturePoints)[(self._item):GetLayerId()]
  self._wallObject = ((self._roomScenes)[self._roomId]).wallObject
  local coverAsset = (self._item):GetCoverAsset()
  self._coverGameObject = (YardSceneHelper.CreatePlayer)(coverAsset.assetBundle, coverAsset.prefabName, self._parentGameObject)
  self._coverGameObjectColor = 1
  ;
  (AnimationHelper.SetAnimatorInteger2)(self._coverGameObject, "state", 1)
  local furnitureAsset = (self._item):GetFurnitureAsset()
  self._furnitureGameObject = (YardSceneHelper.CreatePlayer)(furnitureAsset.assetBundle, furnitureAsset.prefabName, self._parentGameObject)
  if self._type == 1 then
    (TransformStaticFunctions.SetActive)(((self._roomScenes)[self._roomId]).defaultFloor, false)
  else
    if self._type == 2 then
      (TransformStaticFunctions.SetActive)(((self._roomScenes)[self._roomId]).defaultWall, false)
    end
  end
  self._localWordPos = {}
  if not self._leftDownPos then
    self._leftDownPos = (self._item):GetDefaultLeftDownGridPos()
  end
  self:SetPositionByLeftDownGridPos()
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)(self._furnitureGameObject)
  if sceneObjectClick == nil then
    return 
  end
  sceneObjectClick.SceneName = (CDormFloorCfg:GetRecorder(self._roomId)).name
  sceneObjectClick.IntData = (self._item):GetKey()
  sceneObjectClick.StringData = (self._item):GetLayerId()
end

Furniture.SetPositionByLeftDownGridPos = function(self)
  -- function num : 0_4 , upvalues : TransformStaticFunctions
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  if not self._isWallDirection then
    (self._localWordPos).x = (self._initialCoordinate).x + ((self._leftDownPos).x - 1) * self._gridSpace + (self._cover).x * self._gridSpace / 2
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._localWordPos).y = 0
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._localWordPos).z = (self._initialCoordinate).z + ((self._leftDownPos).y - 1) * self._gridSpace + (self._cover).y * self._gridSpace / 2
    ;
    (TransformStaticFunctions.SetLocalScale)(self._coverGameObject, (self._cover).x * self._gridSpace, 1, (self._cover).y * self._gridSpace)
  else
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._localWordPos).x = (self._initialCoordinate).x + ((self._leftDownPos).x - 1) * self._gridSpace + (self._cover).x * self._gridSpace / 2
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._localWordPos).y = (self._initialCoordinate).y + ((self._leftDownPos).y - 1) * self._gridSpace + (self._cover).y * self._gridSpace / 2
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._localWordPos).z = 0
    ;
    (TransformStaticFunctions.SetLocalScale)(self._coverGameObject, (self._cover).x * self._gridSpace, (self._cover).y * self._gridSpace, 1)
  end
  ;
  (TransformStaticFunctions.SetLocalPosition)(self._furnitureGameObject, (self._localWordPos).x, (self._localWordPos).y, (self._localWordPos).z)
  ;
  (TransformStaticFunctions.SetLocalPosition)(self._coverGameObject, (self._localWordPos).x, (self._localWordPos).y, (self._localWordPos).z)
  self._wordPos = {}
  -- DECOMPILER ERROR at PC122: Confused about usage of register: R3 in 'UnsetPending'

  -- DECOMPILER ERROR at PC123: Confused about usage of register: R2 in 'UnsetPending'

  -- DECOMPILER ERROR at PC124: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._wordPos).x = (TransformStaticFunctions.GetPosition)(self._coverGameObject)
end

Furniture.BeginDragFurniture = function(self, dragPos)
  -- function num : 0_5 , upvalues : UIManager
  self._lastPos = {}
  local pos = (UIManager.InverseTransformPoint)(self._parentGameObject, dragPos)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._lastPos).x = pos.x
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  if self._isWallDirection then
    (self._lastPos).y = pos.y
  else
    pos = (UIManager.InverseTransformPoint)(self._wallObject, dragPos)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._lastPos).y = pos.y
  end
end

Furniture.DragFurniture = function(self, dragPos)
  -- function num : 0_6 , upvalues : UIManager, _ENV
  self._lastLeftDownPos = {x = (self._leftDownPos).x, y = (self._leftDownPos).y}
  local pos = (UIManager.InverseTransformPoint)(self._parentGameObject, dragPos)
  local posX = pos.x
  local deltaX = posX - (self._lastPos).x
  local posY = pos.y
  local deltaY = posY - (self._lastPos).y
  if not self._isWallDirection then
    pos = (UIManager.InverseTransformPoint)(self._wallObject, dragPos)
    posY = pos.y
    deltaY = posY - (self._lastPos).y - (self._cover).y * self._gridSpace / 2 * (math.sin)((math.rad)(self._angleX))
  end
  local leftDownX = (math.floor)((pos.x - (self._initialCoordinate).x - (self._cover).x * self._gridSpace / 2) / self._gridSpace) + 1
  if leftDownX < ((self._range).leftDown).x then
    leftDownX = ((self._range).leftDown).x
  else
    if ((self._range).rightUp).x - (self._cover).x + 1 < leftDownX then
      leftDownX = ((self._range).rightUp).x - (self._cover).x + 1
    end
  end
  -- DECOMPILER ERROR at PC100: Confused about usage of register: R8 in 'UnsetPending'

  if (deltaX < 0 and leftDownX < (self._leftDownPos).x) or deltaX > 0 and (self._leftDownPos).x < leftDownX then
    (self._leftDownPos).x = leftDownX
  end
  local leftDownY = nil
  if self._isWallDirection then
    leftDownY = (math.floor)((posY - (self._initialCoordinate).y - (self._cover).y * self._gridSpace / 2) / self._gridSpace) + 1
  else
    local posZ = posY / (math.sin)((math.rad)(self._angleX))
    leftDownY = (math.floor)((posZ - (self._initialCoordinate).z - (self._cover).y * self._gridSpace / 2) / self._gridSpace) + 1
  end
  do
    if leftDownY < ((self._range).leftDown).y then
      leftDownY = ((self._range).leftDown).y
    else
      if ((self._range).rightUp).y - (self._cover).y + 1 < leftDownY then
        leftDownY = ((self._range).rightUp).y - (self._cover).y + 1
      end
    end
    -- DECOMPILER ERROR at PC182: Confused about usage of register: R9 in 'UnsetPending'

    if (deltaY < 0 and leftDownY < (self._leftDownPos).y) or deltaY > 0 and (self._leftDownPos).y < leftDownY then
      (self._leftDownPos).y = leftDownY
    end
    if (self._leftDownPos).x ~= (self._lastLeftDownPos).x or (self._leftDownPos).y ~= (self._lastLeftDownPos).y then
      self:SetPositionByLeftDownGridPos()
      -- DECOMPILER ERROR at PC198: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self._lastPos).x = posX
      -- DECOMPILER ERROR at PC200: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self._lastPos).y = posY
      if self._selectFunc then
        self:SetSelectPos()
      end
    end
  end
end

Furniture.GetLeftDownGridPos = function(self)
  -- function num : 0_7
  return self._leftDownPos
end

Furniture.GetRightUpGridPos = function(self)
  -- function num : 0_8
  return {x = (self._leftDownPos).x + (self._cover).x - 1, y = (self._leftDownPos).y + (self._cover).y - 1}
end

Furniture.SetCoverGameObjectColor = function(self, state)
  -- function num : 0_9 , upvalues : AnimationHelper
  if self._coverGameObjectColor ~= state then
    self._coverGameObjectColor = state
    ;
    (AnimationHelper.SetAnimatorInteger2)(self._coverGameObject, "state", state)
  end
end

Furniture.SetCoverGameObjectActive = function(self, isActive)
  -- function num : 0_10 , upvalues : TransformStaticFunctions, AnimationHelper
  if self._type ~= 1 and self._type ~= 2 then
    if isActive then
      (TransformStaticFunctions.SetActive)(self._coverGameObject, isActive)
      if isActive then
        (AnimationHelper.SetAnimatorInteger2)(self._coverGameObject, "state", self._coverGameObjectColor)
      end
    else
      if self._coverGameObjectColor == 1 then
        (TransformStaticFunctions.SetActive)(self._coverGameObject, isActive)
      end
    end
  else
    ;
    (TransformStaticFunctions.SetActive)(self._coverGameObject, false)
  end
end

Furniture.SetSelect = function(self, func)
  -- function num : 0_11
  self._selectFunc = func
  self:SetSelectPos()
end

Furniture.SetSelectPos = function(self)
  -- function num : 0_12 , upvalues : UIManager
  local leftDownWordPos = {}
  local rightUpWordPos = {}
  if not self._isWallDirection then
    leftDownWordPos.y = (self._localWordPos).y
    leftDownWordPos.z = (self._localWordPos).z - (self._cover).y * self._gridSpace / 2
    rightUpWordPos.y = (self._localWordPos).y
    rightUpWordPos.z = (self._localWordPos).z + (self._cover).y * self._gridSpace / 2
  else
    leftDownWordPos.y = (self._localWordPos).y - (self._cover).y * self._gridSpace / 2
    leftDownWordPos.z = (self._localWordPos).z
    rightUpWordPos.y = (self._localWordPos).y + (self._cover).y * self._gridSpace / 2
    rightUpWordPos.z = (self._localWordPos).z
  end
  leftDownWordPos.x = (self._localWordPos).x - (self._cover).x * self._gridSpace / 2
  rightUpWordPos.x = (self._localWordPos).x + (self._cover).x * self._gridSpace / 2
  local rightUpGridPos = self:GetRightUpGridPos()
  local arriveTop = rightUpGridPos.y == 7
  ;
  (self._selectFunc)((UIManager.TransformPoint)(self._parentGameObject, leftDownWordPos), (UIManager.TransformPoint)(self._parentGameObject, rightUpWordPos), self._wordPos, arriveTop)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Furniture.CancleSelect = function(self)
  -- function num : 0_13
  self._selectFunc = nil
end

Furniture.GetItem = function(self)
  -- function num : 0_14
  return self._item
end

return Furniture

