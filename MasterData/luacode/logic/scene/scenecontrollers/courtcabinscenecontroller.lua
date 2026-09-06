local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local YardSceneCamera = CS.PixelNeko.P1.Camera.YardSceneCamera
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local YardSceneHelper = CS.PixelNeko.P1.Scene.YardSceneHelper
local BoxColiderStaticFunctions = CS.PixelNeko.Lua.BoxColiderStaticFunctions
local StateEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local CDormFloorCfg = BeanManager.GetTableByName("courtyard.cdormfloor")
local CFurnitureItem = BeanManager.GetTableByName("item.cfurnitureitem")
local CDormFurnitureLevel = BeanManager.GetTableByName("courtyard.cdormfurniturelevel")
local BagTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes")
local Furniture = require("logic.manager.experimental.types.furniture")
local YardCharacter = require("logic.manager.experimental.types.yardcharacter")
local CharacterSize_z = 0.1
local MaxRoleNum = NekoData.BehaviorManager.BM_Cabin:GetDispatchLimitRoleNum()
local CourtCabinSceneController = class("CourtCabinSceneController", SceneController)

function CourtCabinSceneController:Ctor(sceneRef)
  CourtCabinSceneController.super.Ctor(self, sceneRef)
  self._dormFurnitureLevelCfg = {}
  self._selectRoomId = 0
  self._selectFurniture = nil
  self._show = true
  self._furnitures = {}
  self._characters = {}
end

function CourtCabinSceneController:Init()
  CourtCabinSceneController.super.Init(self)
  local allIds = CDormFurnitureLevel:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormFurnitureLevel:GetRecorder(allIds[i])
    table.insert(self._dormFurnitureLevelCfg, recorder)
  end
  self._roomScenes = self._sceneRef:GetRoomScenes()
  for i, v in ipairs(self._roomScenes) do
    local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(v.room)
    if sceneObjectClick == nil then
      return
    end
    sceneObjectClick.StringData = DataCommon.CabinScene
    sceneObjectClick.IntData = i
  end
  self._yardSceneCamera = YardSceneCamera.GetYardSceneCamera(self._sceneRef:GetMainCamera().gameObject)
  if self._yardSceneCamera then
    self._yardSceneCamera:SetTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
  end
  local allRoomInfo = NekoData.BehaviorManager.BM_Cabin:GetAllRoomInfo()
  for k, v in pairs(allRoomInfo) do
    self:RefreshFurnituresByRoomId(v.roomId)
    self:RefreshCharactersByRoomId(v.roomId)
  end
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCabin, Common.n_RefreshCabin, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoom, Common.n_RefreshRoom, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoomFurnitures, Common.n_RefreshRoomFurnitures, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSelectRoomIdChanged, Common.n_SelectRoomIdChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSelectFurniture, Common.n_SelectFurniture, nil)
  LuaNotificationCenter.AddObserver(self, self.OnLoadFurniture, Common.n_LoadFurniture, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUnLoadFurniture, Common.n_UnLoadFurniture, nil)
  LuaNotificationCenter.AddObserver(self, self.OnClearAllFurnitures, Common.n_ClearAllFurnitures, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUseTheme, Common.n_UseTheme, nil)
  LuaNotificationCenter.AddObserver(self, self.OnReturnInitState, Common.n_ReturnInitState, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEnterDressUpMode, Common.n_EnterDressUpMode, nil)
  LuaNotificationCenter.AddObserver(self, self.OnExitDressUpMode, Common.n_ExitDressUpMode, nil)
  LuaNotificationCenter.AddObserver(self, self.OnHideUI, Common.n_HideUI, nil)
end

function CourtCabinSceneController:OnDestroy()
  if self._yardSceneCamera then
    self._yardSceneCamera:SetTransformChangedCallback(nil, self)
  end
  for roomId, Info in pairs(self._furnitures) do
    for k, v in pairs(Info) do
      for key, furniture in pairs(v) do
        furniture:Destroy()
        v[key] = nil
      end
    end
  end
  for roomId, Info in pairs(self._characters) do
    for roleKey, character in pairs(Info) do
      character:Destroy()
    end
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function CourtCabinSceneController:EnterCabin()
  self:RefreshCabinLevel()
  for i, v in ipairs(self._roomScenes) do
    for _, grid in pairs(v.grids) do
      TransformStaticFunctions.SetActive(grid, false)
    end
  end
  local allRoomInfo = NekoData.BehaviorManager.BM_Cabin:GetAllRoomInfo()
  for k, v in pairs(allRoomInfo) do
    self:RefreshCharactersByRoomId(v.roomId)
  end
  self._state = nil
end

function CourtCabinSceneController:RefreshCabinLevel()
  local level = NekoData.BehaviorManager.BM_Cabin:GetLevel()
  self._cabinLevel = level
  for i, v in ipairs(self._roomScenes) do
    local tag = false
    if i == 1 then
      tag = i > level
    elseif i == 2 then
      tag = i > level or level == 2 and not NekoData.BehaviorManager.BM_Guide:HasFinished(36)
    else
      tag = i > level or level == 3 and not NekoData.BehaviorManager.BM_Guide:HasFinished(37)
    end
    TransformStaticFunctions.SetActive(v.lock, tag)
  end
  self._sceneRef:GetStateDrivenCameraAnimator():SetInteger("unlock", level)
end

function CourtCabinSceneController:OnRefreshCabin()
  local allRoomInfo = NekoData.BehaviorManager.BM_Cabin:GetAllRoomInfo()
  for k, v in pairs(allRoomInfo) do
    self:RefreshFurnituresByRoomId(v.roomId)
  end
end

function CourtCabinSceneController:OnRefreshRoomFurnitures(notification)
  local roomId = notification.userInfo.floor.id
  self:RefreshFurnituresByRoomId(roomId)
end

function CourtCabinSceneController:OnRefreshRoom(notification)
  local roomId = notification.userInfo.floor.id
  self:RefreshCharactersByRoomId(roomId)
end

function CourtCabinSceneController:RefreshFurnituresByRoomId(roomId)
  self:ClearAllFurnitures(roomId)
  local roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(roomId)
  if not self._furnitures[roomInfo.roomId] then
    self._furnitures[roomInfo.roomId] = {}
  end
  for key, furnitureInfo in pairs(roomInfo.furnitures) do
    local furnitureId = furnitureInfo.itemId
    local furniture = Furniture.Create(furnitureId, furnitureInfo.key)
    furniture:SetInitLeftDownGridPos({
      x = furnitureInfo.point.x,
      y = furnitureInfo.point.y
    })
    furniture:SetInitPosition(self, {
      roomId = roomInfo.roomId
    })
    furniture:SetCoverGameObjectActive(false)
    local layerId = furniture:GetItem():GetLayerId()
    if not self._furnitures[roomInfo.roomId][layerId] then
      self._furnitures[roomInfo.roomId][layerId] = {}
    end
    self._furnitures[roomInfo.roomId][layerId][furnitureInfo.key] = furniture
  end
end

function CourtCabinSceneController:RefreshCharactersByRoomId(roomId)
  local map = self._characters[roomId]
  if map then
    for roleKey, character in pairs(map) do
      character:Destroy()
    end
    self._characters[roomId] = nil
  end
  self._characters[roomId] = {}
  local roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(roomId)
  local characterPoint = self._roomScenes[roomId].characterPoints
  local downColliderObject = TransformStaticFunctions.GetChild(characterPoint, "Bottom")
  local boundsMin = BoxColiderStaticFunctions.GetBoundsMin(downColliderObject)
  local boundsSize = BoxColiderStaticFunctions.GetBoundsSize(downColliderObject)
  local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / MaxRoleNum
  local z = boundsMin.z + CharacterSize_z
  for i, roleKey in ipairs(roomInfo.roles) do
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
    local yardCharacter = YardCharacter.Create(role:GetId(), "Cabin")
    yardCharacter:CreatePlayer(characterPoint)
    yardCharacter:SetClickParam(tostring(roomId), roleKey)
    local pos = yardCharacter:GetPosition()
    yardCharacter:InitZPosition(z)
    z = z + deltaZ
    yardCharacter:LoadBehavior()
    self._characters[roomId][roleKey] = yardCharacter
  end
end

function CourtCabinSceneController:SetInteractDialog(dialog)
  self._interactDialog = dialog
end

function CourtCabinSceneController:SetCameraAnimatorState(state)
  if self._state ~= state then
    self._state = state
    if state == 0 then
      self._sceneRef:GetStateDrivenCameraAnimator():SetInteger("room", state)
    else
      self._sceneRef:GetStateDrivenCameraAnimator():SetInteger("room", state)
    end
  end
end

function CourtCabinSceneController:CameraTransformChangedChangedCallback(deltaPos)
  if self._state == 0 and self._interactDialog then
    for i, v in ipairs(self._roomScenes) do
      local outputViewPos = UIManager.ScreenToViewportPointInMargin("DormMain", UIManager.WorldToScreenPointInMargin("DormMain", BoxColiderStaticFunctions.GetBoundsCenter(v.room)))
      local bx, by, bz = BoxColiderStaticFunctions.GetBoundsCenter(v.room)
      local y = outputViewPos.y
      if 0.5 < y and y < 0.7 then
        self._interactDialog:RefreshRoom(i)
        break
      end
    end
  end
  if self._state ~= 0 then
    if self._inGuide and self._inGuide == self._state then
      local x, y, z = TransformStaticFunctions.GetPosition(self._sceneRef:GetMainCamera().gameObject)
      if math.abs(y - self._roomScenes[self._state].cm_vcam_posY) * 1000 < 1 then
        self._inGuide = false
        StateEventTriggerHelper.AddAnimationEventListener(self._roomScenes[self._state].lock, "UnlockRoom", self.OnUnlockAnimationEnd, self)
        AnimationHelper.PlayAnimation2(self._roomScenes[self._state].lock, "UnlockRoom", 0, 0)
      end
    end
    self:MoveCamera(deltaPos.x, deltaPos.y)
  end
end

function CourtCabinSceneController:MoveCamera(xScreenOffset, yScreenOffset)
  local transform = self._roomScenes[self._cabinLevel].cameraFollowPoint.transform
  transform:Translate(xScreenOffset, yScreenOffset, 0, CS.UnityEngine.Space.World)
end

function CourtCabinSceneController:OnUnlockAnimationEnd(floatValue, intValue, stringValue, obj, clipName)
  if clipName == "UnlockRoom" and stringValue == "finish" then
    TransformStaticFunctions.SetActive(self._roomScenes[self._state].lock, false)
    local dialog = DialogManager.GetDialog("courtcabin.cabinmaindialog")
    if dialog then
      dialog:GetRootWindow():SetAnimatorInteger("isHide", 0)
    end
    self._interactDialog:SetResponseMouse(true)
  end
end

function CourtCabinSceneController:OnSelectRoomIdChanged(notification)
  local selectRoomId = notification.userInfo
  if self._selectRoomId ~= selectRoomId then
    self._selectRoomId = selectRoomId
    for i, v in ipairs(self._roomScenes) do
      TransformStaticFunctions.SetActive(v.select, self._show and self._selectRoomId == i)
    end
  end
end

function CourtCabinSceneController:OnSelectFurniture(notification)
  local furnitureKey = notification.userInfo.key
  local layerId = notification.userInfo.layerId
  local lastSelectFurnitureItem, lastLayerId, lastKey
  if self._selectFurniture then
    lastSelectFurnitureItem = self._selectFurniture:GetItem()
    lastLayerId = lastSelectFurnitureItem:GetLayerId()
    lastKey = lastSelectFurnitureItem:GetKey()
    local map = self._furnitures[self._selectRoomId][layerId]
    if map then
      if lastKey ~= furnitureKey then
        if lastLayerId ~= layerId then
          local lastMap = self._furnitures[self._selectRoomId][lastLayerId]
          for k, v in pairs(lastMap) do
            v:SetCoverGameObjectActive(false)
          end
          for k, v in pairs(map) do
            v:SetCoverGameObjectActive(true)
          end
        end
        self._selectFurniture = map[furnitureKey]
        local dialog = DialogManager.GetDialog("courtcabin.dressupcabindialog")
        if dialog then
          self._selectFurniture:SetSelect(function(a, b, c, d)
            dialog:RefreshSelectState(a, b, c, d)
          end)
        end
      end
    else
      local lastMap = self._furnitures[self._selectRoomId][lastLayerId]
      for k, v in pairs(lastMap) do
        v:SetCoverGameObjectActive(false)
      end
      self._selectFurniture:CancleSelect()
      self._selectFurniture = nil
    end
  elseif self._furnitures[self._selectRoomId] then
    local map = self._furnitures[self._selectRoomId][layerId]
    if map then
      for k, v in pairs(map) do
        v:SetCoverGameObjectActive(true)
      end
      self._selectFurniture = map[furnitureKey]
      local dialog = DialogManager.GetDialog("courtcabin.dressupcabindialog")
      if dialog then
        self._selectFurniture:SetSelect(function(a, b, c, d)
          dialog:RefreshSelectState(a, b, c, d)
        end)
      end
    end
  end
  if self._selectFurniture then
    local putRangeShow = self._selectFurniture._item:GetPutRangeShow()
    local grids = self._roomScenes[self._selectRoomId].grids
    for k, v in pairs(grids) do
      TransformStaticFunctions.SetActive(v, k == putRangeShow)
    end
  elseif self._selectRoomId ~= 0 then
    local grids = self._roomScenes[self._selectRoomId].grids
    for k, v in pairs(grids) do
      TransformStaticFunctions.SetActive(v, false)
    end
  end
end

function CourtCabinSceneController:CheckOverlap(layerId)
  local map = self._furnitures[self._selectRoomId][layerId]
  local overlapMap = {}
  for key1, aFurniture in pairs(map) do
    for key2, bFurniture in pairs(map) do
      if key1 ~= key2 then
        local aLeftDownPos = aFurniture:GetLeftDownGridPos()
        local aRightUpPos = aFurniture:GetRightUpGridPos()
        local bLeftDownPos = bFurniture:GetLeftDownGridPos()
        local bRightUpPos = bFurniture:GetRightUpGridPos()
        local overlapLeftDownX = math.max(aLeftDownPos.x, bLeftDownPos.x)
        local overlapRightUpX = math.min(aRightUpPos.x, bRightUpPos.x)
        local overlapLeftDownY = math.max(aLeftDownPos.y, bLeftDownPos.y)
        local overlapRightUpY = math.min(aRightUpPos.y, bRightUpPos.y)
        if overlapLeftDownX <= overlapRightUpX and overlapLeftDownY <= overlapRightUpY then
          overlapMap[key1] = aFurniture
          overlapMap[key2] = bFurniture
        end
      end
    end
  end
  local overlap = false
  for key, furniture in pairs(map) do
    if overlapMap[key] then
      overlap = true
      furniture:SetCoverGameObjectColor(0)
    else
      furniture:SetCoverGameObjectColor(1)
      if not self._selectFurniture then
        furniture:SetCoverGameObjectActive(false)
      end
    end
  end
  return overlap
end

function CourtCabinSceneController:OnLoadFurniture(notification)
  local info = notification.userInfo
  local furniture = Furniture.Create(info.id, info.key)
  furniture:SetInitPosition(self, {
    roomId = self._selectRoomId
  })
  local type = furniture._item:GetType()
  if type == 1 or type == 2 then
    furniture:SetCoverGameObjectActive(false)
  end
  if not self._furnitures[self._selectRoomId][info.layerId] then
    self._furnitures[self._selectRoomId][info.layerId] = {}
  end
  self._furnitures[self._selectRoomId][info.layerId][info.key] = furniture
  self:CheckOverlap(info.layerId)
end

function CourtCabinSceneController:OnUnLoadFurniture(notification)
  local layerId = notification.userInfo.layerId
  local furnitureKey = notification.userInfo.key
  local furniture = self._furnitures[self._selectRoomId][layerId][furnitureKey]
  furniture:Destroy()
  self._furnitures[self._selectRoomId][layerId][furnitureKey] = nil
  self:CheckOverlap(layerId)
end

function CourtCabinSceneController:OnUseTheme(notification)
  local themeInfo = notification.userInfo
  self:ClearAllFurnitures()
  local tag
  if themeInfo.tag and themeInfo.tag == "Preview" then
    tag = 1
  end
  for i, v in ipairs(themeInfo.itemIdList) do
    local furniture = Furniture.Create(v.id, v.key)
    furniture:SetInitLeftDownGridPos({
      x = themeInfo.positionList[i].x,
      y = themeInfo.positionList[i].y
    })
    furniture:SetInitPosition(self, {
      roomId = self._selectRoomId
    })
    furniture:SetCoverGameObjectActive(false)
    local layer = furniture:GetItem():GetLayerId()
    if not self._furnitures[self._selectRoomId][layer] then
      self._furnitures[self._selectRoomId][layer] = {}
    end
    local key = v.key
    if tag then
      key = tag
    end
    self._furnitures[self._selectRoomId][layer][key] = furniture
    tag = tag and tag + 1
  end
end

function CourtCabinSceneController:OnReturnInitState()
  self:RefreshFurnituresByRoomId(self._selectRoomId)
end

function CourtCabinSceneController:SetCharacterActive(roomId, isActive)
  TransformStaticFunctions.SetActive(self._roomScenes[roomId].characterPoints, isActive)
end

function CourtCabinSceneController:OnEnterDressUpMode()
  self:SetCameraAnimatorState(self._selectRoomId)
  self:SetCharacterActive(self._selectRoomId, false)
end

function CourtCabinSceneController:OnExitDressUpMode()
  self:SetCharacterActive(self._selectRoomId, true)
  local allRoomInfo = NekoData.BehaviorManager.BM_Cabin:GetAllRoomInfo()
  for k, v in pairs(allRoomInfo) do
    self:RefreshCharactersByRoomId(v.roomId)
  end
end

function CourtCabinSceneController:OnHideUI(notification)
  self._show = notification.userInfo
  for i, v in ipairs(self._roomScenes) do
    TransformStaticFunctions.SetActive(v.select, self._show and self._selectRoomId == i)
  end
end

function CourtCabinSceneController:OnClearAllFurnitures()
  self:ClearAllFurnitures()
end

function CourtCabinSceneController:ClearAllFurnitures(roomId)
  LuaNotificationCenter.PostNotification(Common.n_SelectFurniture, self, {layerId = 0, key = 0})
  roomId = roomId or self._selectRoomId
  local map = self._furnitures[roomId]
  if map then
    for k, v in pairs(map) do
      for key, furniture in pairs(v) do
        furniture:Destroy()
        v[key] = nil
      end
    end
  end
end

function CourtCabinSceneController:IsModify()
  local map = self._furnitures[self._selectRoomId]
  local roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(self._selectRoomId)
  local count1 = 0
  local curMap = {}
  if map then
    for layer, value in pairs(map) do
      for key, furniture in pairs(value) do
        local id = furniture:GetItem():GetID()
        if not curMap[id] then
          curMap[id] = {}
        end
        table.insert(curMap[id], furniture:GetLeftDownGridPos())
        count1 = count1 + 1
      end
    end
  end
  local count2 = 0
  local map2 = {}
  for key, furnitureInfo in pairs(roomInfo.furnitures) do
    local id = furnitureInfo.itemId
    if not map2[id] then
      map2[id] = {}
    end
    table.insert(map2[id], {
      x = furnitureInfo.point.x,
      y = furnitureInfo.point.y
    })
    count2 = count2 + 1
  end
  if count1 ~= count2 then
    return true
  else
    for id, curlist in pairs(curMap) do
      local list = map2[id]
      if not list then
        return true
      elseif #curlist ~= #list then
        return true
      else
        for i, curPos in ipairs(curlist) do
          local tag = false
          for index, pos in ipairs(list) do
            if curPos.x == pos.x and curPos.y == pos.y then
              tag = true
              break
            end
          end
          if not tag then
            return true
          end
        end
      end
    end
  end
  return false
end

function CourtCabinSceneController:GetMainCamera()
  return self._sceneRef:GetMainCamera()
end

function CourtCabinSceneController:GetRoomScenes()
  return self._roomScenes
end

return CourtCabinSceneController
