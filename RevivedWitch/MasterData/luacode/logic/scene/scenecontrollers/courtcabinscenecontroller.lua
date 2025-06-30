-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/courtcabinscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local UIManager = ((CS.PixelNeko).UI).UIManager
local YardSceneCamera = (((CS.PixelNeko).P1).Camera).YardSceneCamera
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local YardSceneHelper = (((CS.PixelNeko).P1).Scene).YardSceneHelper
local BoxColiderStaticFunctions = ((CS.PixelNeko).Lua).BoxColiderStaticFunctions
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local CDormFloorCfg = (BeanManager.GetTableByName)("courtyard.cdormfloor")
local CFurnitureItem = (BeanManager.GetTableByName)("item.cfurnitureitem")
local CDormFurnitureLevel = (BeanManager.GetTableByName)("courtyard.cdormfurniturelevel")
local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
local Furniture = require("logic.manager.experimental.types.furniture")
local YardCharacter = require("logic.manager.experimental.types.yardcharacter")
local CharacterSize_z = 0.1
local MaxRoleNum = ((NekoData.BehaviorManager).BM_Cabin):GetDispatchLimitRoleNum()
local CourtCabinSceneController = class("CourtCabinSceneController", SceneController)
CourtCabinSceneController.Ctor = function(self, sceneRef)
  -- function num : 0_0 , upvalues : CourtCabinSceneController
  ((CourtCabinSceneController.super).Ctor)(self, sceneRef)
  self._dormFurnitureLevelCfg = {}
  self._selectRoomId = 0
  self._selectFurniture = nil
  self._show = true
  self._furnitures = {}
  self._characters = {}
end

CourtCabinSceneController.Init = function(self)
  -- function num : 0_1 , upvalues : CourtCabinSceneController, CDormFurnitureLevel, _ENV, SceneObjectClick, YardSceneCamera
  ((CourtCabinSceneController.super).Init)(self)
  local allIds = CDormFurnitureLevel:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormFurnitureLevel:GetRecorder(allIds[i])
    ;
    (table.insert)(self._dormFurnitureLevelCfg, recorder)
  end
  self._roomScenes = (self._sceneRef):GetRoomScenes()
  for i,v in ipairs(self._roomScenes) do
    local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)(v.room)
    if sceneObjectClick == nil then
      return 
    end
    sceneObjectClick.StringData = DataCommon.CabinScene
    sceneObjectClick.IntData = i
  end
  self._yardSceneCamera = (YardSceneCamera.GetYardSceneCamera)(((self._sceneRef):GetMainCamera()).gameObject)
  if self._yardSceneCamera then
    (self._yardSceneCamera):SetTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
  end
  local allRoomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetAllRoomInfo()
  for k,v in pairs(allRoomInfo) do
    self:RefreshFurnituresByRoomId(v.roomId)
    self:RefreshCharactersByRoomId(v.roomId)
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCabin, Common.n_RefreshCabin, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRoom, Common.n_RefreshRoom, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRoomFurnitures, Common.n_RefreshRoomFurnitures, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSelectRoomIdChanged, Common.n_SelectRoomIdChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSelectFurniture, Common.n_SelectFurniture, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLoadFurniture, Common.n_LoadFurniture, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUnLoadFurniture, Common.n_UnLoadFurniture, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnClearAllFurnitures, Common.n_ClearAllFurnitures, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUseTheme, Common.n_UseTheme, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReturnInitState, Common.n_ReturnInitState, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEnterDressUpMode, Common.n_EnterDressUpMode, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnExitDressUpMode, Common.n_ExitDressUpMode, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnHideUI, Common.n_HideUI, nil)
end

CourtCabinSceneController.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._yardSceneCamera then
    (self._yardSceneCamera):SetTransformChangedCallback(nil, self)
  end
  for roomId,Info in pairs(self._furnitures) do
    for k,v in pairs(Info) do
      for key,furniture in pairs(v) do
        furniture:Destroy()
        v[key] = nil
      end
    end
  end
  for roomId,Info in pairs(self._characters) do
    for roleKey,character in pairs(Info) do
      character:Destroy()
    end
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

CourtCabinSceneController.EnterCabin = function(self)
  -- function num : 0_3 , upvalues : _ENV, TransformStaticFunctions
  self:RefreshCabinLevel()
  for i,v in ipairs(self._roomScenes) do
    for _,grid in pairs(v.grids) do
      (TransformStaticFunctions.SetActive)(grid, false)
    end
  end
  local allRoomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetAllRoomInfo()
  for k,v in pairs(allRoomInfo) do
    self:RefreshCharactersByRoomId(v.roomId)
  end
  self._state = nil
end

CourtCabinSceneController.RefreshCabinLevel = function(self)
  -- function num : 0_4 , upvalues : _ENV, TransformStaticFunctions
  local level = ((NekoData.BehaviorManager).BM_Cabin):GetLevel()
  self._cabinLevel = level
  for i,v in ipairs(self._roomScenes) do
    local tag = false
    if level >= i then
      tag = i ~= 1
      if i == 2 then
        if level >= i then
          if level == 2 then
            tag = not ((NekoData.BehaviorManager).BM_Guide):HasFinished(36)
          else
            tag = false
          end
          if level >= i then
            do
              if level == 3 then
                tag = not ((NekoData.BehaviorManager).BM_Guide):HasFinished(37)
              else
                tag = false
              end
              ;
              (TransformStaticFunctions.SetActive)(v.lock, tag)
              -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  ;
  ((self._sceneRef):GetStateDrivenCameraAnimator()):SetInteger("unlock", level)
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

CourtCabinSceneController.OnRefreshCabin = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local allRoomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetAllRoomInfo()
  for k,v in pairs(allRoomInfo) do
    self:RefreshFurnituresByRoomId(v.roomId)
  end
end

CourtCabinSceneController.OnRefreshRoomFurnitures = function(self, notification)
  -- function num : 0_6
  local roomId = ((notification.userInfo).floor).id
  self:RefreshFurnituresByRoomId(roomId)
end

CourtCabinSceneController.OnRefreshRoom = function(self, notification)
  -- function num : 0_7
  local roomId = ((notification.userInfo).floor).id
  self:RefreshCharactersByRoomId(roomId)
end

CourtCabinSceneController.RefreshFurnituresByRoomId = function(self, roomId)
  -- function num : 0_8 , upvalues : _ENV, Furniture
  self:ClearAllFurnitures(roomId)
  local roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById(roomId)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  if not (self._furnitures)[roomInfo.roomId] then
    (self._furnitures)[roomInfo.roomId] = {}
  end
  for key,furnitureInfo in pairs(roomInfo.furnitures) do
    local furnitureId = furnitureInfo.itemId
    local furniture = (Furniture.Create)(furnitureId, furnitureInfo.key)
    furniture:SetInitLeftDownGridPos({x = (furnitureInfo.point).x, y = (furnitureInfo.point).y})
    furniture:SetInitPosition(self, {roomId = roomInfo.roomId})
    furniture:SetCoverGameObjectActive(false)
    local layerId = (furniture:GetItem()):GetLayerId()
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R11 in 'UnsetPending'

    if not ((self._furnitures)[roomInfo.roomId])[layerId] then
      ((self._furnitures)[roomInfo.roomId])[layerId] = {}
    end
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (((self._furnitures)[roomInfo.roomId])[layerId])[furnitureInfo.key] = furniture
  end
end

CourtCabinSceneController.RefreshCharactersByRoomId = function(self, roomId)
  -- function num : 0_9 , upvalues : _ENV, TransformStaticFunctions, BoxColiderStaticFunctions, CharacterSize_z, MaxRoleNum, YardCharacter
  local map = (self._characters)[roomId]
  if map then
    for roleKey,character in pairs(map) do
      character:Destroy()
    end
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._characters)[roomId] = nil
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._characters)[roomId] = {}
  local roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById(roomId)
  local characterPoint = ((self._roomScenes)[roomId]).characterPoints
  local downColliderObject = (TransformStaticFunctions.GetChild)(characterPoint, "Bottom")
  local boundsMin = (BoxColiderStaticFunctions.GetBoundsMin)(downColliderObject)
  local boundsSize = (BoxColiderStaticFunctions.GetBoundsSize)(downColliderObject)
  local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / MaxRoleNum
  local z = boundsMin.z + CharacterSize_z
  for i,roleKey in ipairs(roomInfo.roles) do
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
    local yardCharacter = (YardCharacter.Create)(role:GetId(), "Cabin")
    yardCharacter:CreatePlayer(characterPoint)
    yardCharacter:SetClickParam(tostring(roomId), roleKey)
    local pos = yardCharacter:GetPosition()
    yardCharacter:InitZPosition(z)
    z = z + deltaZ
    yardCharacter:LoadBehavior()
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R18 in 'UnsetPending'

    ;
    ((self._characters)[roomId])[roleKey] = yardCharacter
  end
end

CourtCabinSceneController.SetInteractDialog = function(self, dialog)
  -- function num : 0_10
  self._interactDialog = dialog
end

CourtCabinSceneController.SetCameraAnimatorState = function(self, state)
  -- function num : 0_11
  if self._state ~= state then
    self._state = state
    if state == 0 then
      ((self._sceneRef):GetStateDrivenCameraAnimator()):SetInteger("room", state)
    else
      ;
      ((self._sceneRef):GetStateDrivenCameraAnimator()):SetInteger("room", state)
    end
  end
end

CourtCabinSceneController.CameraTransformChangedChangedCallback = function(self, deltaPos)
  -- function num : 0_12 , upvalues : _ENV, UIManager, BoxColiderStaticFunctions, TransformStaticFunctions, StateEventTriggerHelper, AnimationHelper
  if self._state == 0 and self._interactDialog then
    for i,v in ipairs(self._roomScenes) do
      local outputViewPos = (UIManager.ScreenToViewportPointInMargin)("DormMain", (UIManager.WorldToScreenPointInMargin)("DormMain", (BoxColiderStaticFunctions.GetBoundsCenter)(v.room)))
      local bx, by, bz = (BoxColiderStaticFunctions.GetBoundsCenter)(v.room)
      local y = outputViewPos.y
      if y > 0.5 and y < 0.7 then
        (self._interactDialog):RefreshRoom(i)
        break
      end
    end
  end
  do
    if self._state ~= 0 then
      do
        if self._inGuide and self._inGuide == self._state then
          local x, y, z = (TransformStaticFunctions.GetPosition)(((self._sceneRef):GetMainCamera()).gameObject)
          if (math.abs)(y - ((self._roomScenes)[self._state]).cm_vcam_posY) * 1000 < 1 then
            self._inGuide = false
            ;
            (StateEventTriggerHelper.AddAnimationEventListener)(((self._roomScenes)[self._state]).lock, "UnlockRoom", self.OnUnlockAnimationEnd, self)
            ;
            (AnimationHelper.PlayAnimation2)(((self._roomScenes)[self._state]).lock, "UnlockRoom", 0, 0)
          end
        end
        self:MoveCamera(deltaPos.x, deltaPos.y)
      end
    end
  end
end

CourtCabinSceneController.MoveCamera = function(self, xScreenOffset, yScreenOffset)
  -- function num : 0_13 , upvalues : _ENV
  local transform = (((self._roomScenes)[self._cabinLevel]).cameraFollowPoint).transform
  transform:Translate(xScreenOffset, yScreenOffset, 0, ((CS.UnityEngine).Space).World)
end

CourtCabinSceneController.OnUnlockAnimationEnd = function(self, floatValue, intValue, stringValue, obj, clipName)
  -- function num : 0_14 , upvalues : TransformStaticFunctions, _ENV
  if clipName == "UnlockRoom" and stringValue == "finish" then
    (TransformStaticFunctions.SetActive)(((self._roomScenes)[self._state]).lock, false)
    local dialog = (DialogManager.GetDialog)("courtcabin.cabinmaindialog")
    if dialog then
      (dialog:GetRootWindow()):SetAnimatorInteger("isHide", 0)
    end
    ;
    (self._interactDialog):SetResponseMouse(true)
  end
end

CourtCabinSceneController.OnSelectRoomIdChanged = function(self, notification)
  -- function num : 0_15 , upvalues : _ENV, TransformStaticFunctions
  local selectRoomId = notification.userInfo
  if self._selectRoomId ~= selectRoomId then
    self._selectRoomId = selectRoomId
    for i,v in ipairs(self._roomScenes) do
      (TransformStaticFunctions.SetActive)(v.select, not self._show or self._selectRoomId == i)
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

CourtCabinSceneController.OnSelectFurniture = function(self, notification)
  -- function num : 0_16 , upvalues : _ENV, TransformStaticFunctions
  local furnitureKey = (notification.userInfo).key
  local layerId = (notification.userInfo).layerId
  local lastSelectFurnitureItem, lastLayerId, lastKey = nil, nil, nil
  if self._selectFurniture then
    lastSelectFurnitureItem = (self._selectFurniture):GetItem()
    lastLayerId = lastSelectFurnitureItem:GetLayerId()
    lastKey = lastSelectFurnitureItem:GetKey()
    local map = ((self._furnitures)[self._selectRoomId])[layerId]
    -- DECOMPILER ERROR at PC32: Unhandled construct in 'MakeBoolean' P1

    if map and lastKey ~= furnitureKey then
      if lastLayerId ~= layerId then
        local lastMap = ((self._furnitures)[self._selectRoomId])[lastLayerId]
        do
          for k,v in pairs(lastMap) do
            v:SetCoverGameObjectActive(false)
          end
          for k,v in pairs(map) do
            v:SetCoverGameObjectActive(true)
          end
        end
      end
      do
        self._selectFurniture = map[furnitureKey]
        do
          local dialog = (DialogManager.GetDialog)("courtcabin.dressupcabindialog")
          if dialog then
            (self._selectFurniture):SetSelect(function(a, b, c, d)
    -- function num : 0_16_0 , upvalues : dialog
    dialog:RefreshSelectState(a, b, c, d)
  end
)
          end
          do
            local lastMap = ((self._furnitures)[self._selectRoomId])[lastLayerId]
            for k,v in pairs(lastMap) do
              v:SetCoverGameObjectActive(false)
            end
            ;
            (self._selectFurniture):CancleSelect()
            self._selectFurniture = nil
            if (self._furnitures)[self._selectRoomId] then
              local map = ((self._furnitures)[self._selectRoomId])[layerId]
              if map then
                for k,v in pairs(map) do
                  v:SetCoverGameObjectActive(true)
                end
                self._selectFurniture = map[furnitureKey]
                local dialog = (DialogManager.GetDialog)("courtcabin.dressupcabindialog")
                if dialog then
                  (self._selectFurniture):SetSelect(function(a, b, c, d)
    -- function num : 0_16_1 , upvalues : dialog
    dialog:RefreshSelectState(a, b, c, d)
  end
)
                end
              end
            end
            do
              if self._selectFurniture then
                local putRangeShow = ((self._selectFurniture)._item):GetPutRangeShow()
                local grids = ((self._roomScenes)[self._selectRoomId]).grids
                for k,v in pairs(grids) do
                  (TransformStaticFunctions.SetActive)(v, k == putRangeShow)
                end
              elseif self._selectRoomId ~= 0 then
                local grids = ((self._roomScenes)[self._selectRoomId]).grids
                for k,v in pairs(grids) do
                  (TransformStaticFunctions.SetActive)(v, false)
                end
              end
              -- DECOMPILER ERROR: 5 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
end

CourtCabinSceneController.CheckOverlap = function(self, layerId)
  -- function num : 0_17 , upvalues : _ENV
  local map = ((self._furnitures)[self._selectRoomId])[layerId]
  local overlapMap = {}
  for key1,aFurniture in pairs(map) do
    for key2,bFurniture in pairs(map) do
      if key1 ~= key2 then
        local aLeftDownPos = aFurniture:GetLeftDownGridPos()
        local aRightUpPos = aFurniture:GetRightUpGridPos()
        local bLeftDownPos = bFurniture:GetLeftDownGridPos()
        local bRightUpPos = bFurniture:GetRightUpGridPos()
        local overlapLeftDownX = (math.max)(aLeftDownPos.x, bLeftDownPos.x)
        local overlapRightUpX = (math.min)(aRightUpPos.x, bRightUpPos.x)
        local overlapLeftDownY = (math.max)(aLeftDownPos.y, bLeftDownPos.y)
        local overlapRightUpY = (math.min)(aRightUpPos.y, bRightUpPos.y)
        if overlapLeftDownX <= overlapRightUpX and overlapLeftDownY <= overlapRightUpY then
          overlapMap[key1] = aFurniture
          overlapMap[key2] = bFurniture
        end
      end
    end
  end
  local overlap = false
  for key,furniture in pairs(map) do
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

CourtCabinSceneController.OnLoadFurniture = function(self, notification)
  -- function num : 0_18 , upvalues : Furniture
  local info = notification.userInfo
  local furniture = (Furniture.Create)(info.id, info.key)
  furniture:SetInitPosition(self, {roomId = self._selectRoomId})
  local type = (furniture._item):GetType()
  if type == 1 or type == 2 then
    furniture:SetCoverGameObjectActive(false)
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

  if not ((self._furnitures)[self._selectRoomId])[info.layerId] then
    ((self._furnitures)[self._selectRoomId])[info.layerId] = {}
  end
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self._furnitures)[self._selectRoomId])[info.layerId])[info.key] = furniture
  self:CheckOverlap(info.layerId)
end

CourtCabinSceneController.OnUnLoadFurniture = function(self, notification)
  -- function num : 0_19
  local layerId = (notification.userInfo).layerId
  local furnitureKey = (notification.userInfo).key
  local furniture = (((self._furnitures)[self._selectRoomId])[layerId])[furnitureKey]
  furniture:Destroy()
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self._furnitures)[self._selectRoomId])[layerId])[furnitureKey] = nil
  self:CheckOverlap(layerId)
end

CourtCabinSceneController.OnUseTheme = function(self, notification)
  -- function num : 0_20 , upvalues : _ENV, Furniture
  local themeInfo = notification.userInfo
  self:ClearAllFurnitures()
  local tag = nil
  if themeInfo.tag and themeInfo.tag == "Preview" then
    tag = 1
  end
  for i,v in ipairs(themeInfo.itemIdList) do
    local furniture = (Furniture.Create)(v.id, v.key)
    furniture:SetInitLeftDownGridPos({x = ((themeInfo.positionList)[i]).x, y = ((themeInfo.positionList)[i]).y})
    furniture:SetInitPosition(self, {roomId = self._selectRoomId})
    furniture:SetCoverGameObjectActive(false)
    local layer = (furniture:GetItem()):GetLayerId()
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R11 in 'UnsetPending'

    if not ((self._furnitures)[self._selectRoomId])[layer] then
      ((self._furnitures)[self._selectRoomId])[layer] = {}
    end
    local key = v.key
    if tag then
      key = tag
    end
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (((self._furnitures)[self._selectRoomId])[layer])[key] = furniture
    if tag then
      tag = tag + 1
    end
  end
end

CourtCabinSceneController.OnReturnInitState = function(self)
  -- function num : 0_21
  self:RefreshFurnituresByRoomId(self._selectRoomId)
end

CourtCabinSceneController.SetCharacterActive = function(self, roomId, isActive)
  -- function num : 0_22 , upvalues : TransformStaticFunctions
  (TransformStaticFunctions.SetActive)(((self._roomScenes)[roomId]).characterPoints, isActive)
end

CourtCabinSceneController.OnEnterDressUpMode = function(self)
  -- function num : 0_23
  self:SetCameraAnimatorState(self._selectRoomId)
  self:SetCharacterActive(self._selectRoomId, false)
end

CourtCabinSceneController.OnExitDressUpMode = function(self)
  -- function num : 0_24 , upvalues : _ENV
  self:SetCharacterActive(self._selectRoomId, true)
  local allRoomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetAllRoomInfo()
  for k,v in pairs(allRoomInfo) do
    self:RefreshCharactersByRoomId(v.roomId)
  end
end

CourtCabinSceneController.OnHideUI = function(self, notification)
  -- function num : 0_25 , upvalues : _ENV, TransformStaticFunctions
  self._show = notification.userInfo
  for i,v in ipairs(self._roomScenes) do
    (TransformStaticFunctions.SetActive)(v.select, not self._show or self._selectRoomId == i)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

CourtCabinSceneController.OnClearAllFurnitures = function(self)
  -- function num : 0_26
  self:ClearAllFurnitures()
end

CourtCabinSceneController.ClearAllFurnitures = function(self, roomId)
  -- function num : 0_27 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_SelectFurniture, self, {layerId = 0, key = 0})
  if not roomId then
    roomId = self._selectRoomId
  end
  local map = (self._furnitures)[roomId]
  if map then
    for k,v in pairs(map) do
      for key,furniture in pairs(v) do
        furniture:Destroy()
        v[key] = nil
      end
    end
  end
end

CourtCabinSceneController.IsModify = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local map = (self._furnitures)[self._selectRoomId]
  local roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById(self._selectRoomId)
  local count1 = 0
  local curMap = {}
  if map then
    for layer,value in pairs(map) do
      for key,furniture in pairs(value) do
        local id = (furniture:GetItem()):GetID()
        if not curMap[id] then
          curMap[id] = {}
        end
        ;
        (table.insert)(curMap[id], furniture:GetLeftDownGridPos())
        count1 = count1 + 1
      end
    end
  end
  do
    local count2 = 0
    local map2 = {}
    for key,furnitureInfo in pairs(roomInfo.furnitures) do
      local id = furnitureInfo.itemId
      if not map2[id] then
        map2[id] = {}
      end
      ;
      (table.insert)(map2[id], {x = (furnitureInfo.point).x, y = (furnitureInfo.point).y})
      count2 = count2 + 1
    end
    if count1 ~= count2 then
      return true
    else
      for id,curlist in pairs(curMap) do
        local list = map2[id]
        if not list then
          return true
        else
          if #curlist ~= #list then
            return true
          else
            for i,curPos in ipairs(R14_PC91) do
              local tag = false
              for index,pos in ipairs(list) do
                if curPos.x == pos.x and curPos.y == pos.y then
                  tag = true
                  break
                end
              end
              do
                do
                  if not tag then
                    return true
                  end
                  -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

                end
              end
            end
          end
        end
      end
    end
    do
      return false
    end
  end
end

CourtCabinSceneController.GetMainCamera = function(self)
  -- function num : 0_29
  return (self._sceneRef):GetMainCamera()
end

CourtCabinSceneController.GetRoomScenes = function(self)
  -- function num : 0_30
  return self._roomScenes
end

return CourtCabinSceneController

