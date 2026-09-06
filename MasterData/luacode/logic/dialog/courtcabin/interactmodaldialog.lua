local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local CDormFurnitureLevel = BeanManager.GetTableByName("courtyard.cdormfurniturelevel")
local CDormFloorCfg = BeanManager.GetTableByName("courtyard.cdormfloor")
local MaxLayerNum = #CDormFurnitureLevel:GetAllIds()
local CharMaxLayerNum = NekoData.BehaviorManager.BM_Cabin:GetDispatchLimitRoleNum()
local InteractModalDialog = class("InteractModalDialog", Dialog)
InteractModalDialog.AssetBundleName = "ui/layouts"
InteractModalDialog.AssetName = "SceneObjectInteract"

function InteractModalDialog:Ctor(...)
  InteractModalDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._cabinSceneController = nil
  self._raycastHits = nil
  self._raycastHitsFurniture = nil
  self._raycastHitsChar = nil
  self._cdormFloorCfg = {}
  self._selectRoomId = 0
  self._dressupIng = false
  self._show = true
  self._responseMouse = true
end

function InteractModalDialog:OnCreate()
  self._raycastHits = PhysicsStaticFunctions.CreateRaycastHits(1)
  self._raycastHitsFurniture = PhysicsStaticFunctions.CreateRaycastHits(MaxLayerNum)
  self._raycastHitsChar = PhysicsStaticFunctions.CreateRaycastHits(CharMaxLayerNum)
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackClicked, self)
  self._rootWindow:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._rootWindow:Subscribe_DragEvent(self.OnDrag, self)
  self._rootWindow:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._rootWindow:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  local allIds = CDormFloorCfg:GetAllIds()
  for i = 1, #allIds do
    self._cdormFloorCfg[i] = CDormFloorCfg:GetRecorder(allIds[i])
  end
  LuaNotificationCenter.AddObserver(self, self.OnEnterDressUpMode, Common.n_EnterDressUpMode, nil)
  LuaNotificationCenter.AddObserver(self, self.OnExitDressUpMode, Common.n_ExitDressUpMode, nil)
  LuaNotificationCenter.AddObserver(self, self.OnHideUI, Common.n_HideUI, nil)
  LuaNotificationCenter.AddObserver(self, self.OnCuePlayEnd, Common.n_CuePlayEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnCuePlayEnd, Common.n_CuePlayStop, nil)
end

function InteractModalDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self:SetVoiceIdNil()
end

function InteractModalDialog:Init(sceneController)
  self._cabinSceneController = sceneController
  self:RefreshRoom(1, true)
end

function InteractModalDialog:IsHitSceneObject(position)
  local mainCamera = self._cabinSceneController:GetMainCamera()
  local outputViewPos = UIManager.ScreenToViewportPointInMargin("DormMain", position.x, position.y, 0)
  local ray = mainCamera:ViewportPointToRay(outputViewPos)
  local count, raycastHit, sceneObjectClick
  if self._dressupIng then
    self._raycastHitsFurniture, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHitsFurniture, 1000000, Layers.FurnitureLayerID)
    if count == 0 then
      return
    end
    raycastHit = self._raycastHitsFurniture[0]
  else
    self._raycastHitsChar, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHitsChar, 1000000, Layers.YardCharacterLayerID)
    if count == 0 then
      self._raycastHits, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
      if count == 0 then
        return
      end
      raycastHit = self._raycastHits[0]
    else
      raycastHit = self._raycastHitsChar[0]
    end
  end
  sceneObjectClick = SceneObjectClick.GetSceneObjectClick(raycastHit.collider.gameObject)
  if sceneObjectClick and self._dressupIng then
    LuaNotificationCenter.PostNotification(Common.n_SelectFurniture, self, {
      layerId = tonumber(sceneObjectClick.StringData),
      key = sceneObjectClick.IntData
    })
  end
  return sceneObjectClick
end

function InteractModalDialog:OnBackClicked(args)
  if not self._responseMouse then
    return
  end
  self._cabinSceneController:MoveCamera(0, 0)
  local sceneObjectClick = self:IsHitSceneObject(args.position)
  if sceneObjectClick then
    local roomId
    if not self._dressupIng then
      if sceneObjectClick.SceneName ~= "" then
        roomId = tonumber(sceneObjectClick.IntData)
      elseif not self._voiceId then
        roomId = tonumber(sceneObjectClick.StringData)
        local character = self._cabinSceneController._characters[roomId][sceneObjectClick.IntData]
        if character then
          character:ClickCharacter()
          self._voiceId = NekoData.BehaviorManager.BM_Voice:Play(character:GetId(), NekoData.BehaviorManager.BM_Voice.VoiceType.YardTouch, nil)
        end
      end
      if roomId then
        self:RefreshRoom(roomId, true)
      end
    end
  end
end

function InteractModalDialog:RefreshRoom(roomId, isClick)
  if roomId <= NekoData.BehaviorManager.BM_Cabin:GetLevel() then
    if self._show and isClick then
      self._cabinSceneController:SetCameraAnimatorState(roomId)
    end
    if self._selectRoomId ~= roomId then
      self._selectRoomId = roomId
      LuaNotificationCenter.PostNotification(Common.n_SelectRoomIdChanged, nil, self._selectRoomId)
    end
  end
end

function InteractModalDialog:OnBeginDrag(args)
  if not self._responseMouse then
    return
  end
  local sceneObjectClick = self:IsHitSceneObject(args.position)
  if self._dressupIng then
    if sceneObjectClick then
      local stringData = sceneObjectClick.StringData
      local intData = sceneObjectClick.IntData
      self._furniture = self._cabinSceneController._furnitures[self._selectRoomId][tonumber(stringData)][intData]
      if self._furniture then
        local mainCamera = self._cabinSceneController:GetMainCamera()
        local position = args.position
        local pos1 = UIManager.ScreenToViewportPointInMargin("DormMain", position.x, position.y, 0)
        local pos2 = mainCamera:ViewportToWorldPoint(pos1)
        self._furniture:BeginDragFurniture(pos2)
        self._cabinSceneController:CheckOverlap(self._furniture:GetItem():GetLayerId())
      end
    end
  else
    if sceneObjectClick and sceneObjectClick.SceneName == "" then
      self._dragCharacter = self._cabinSceneController._characters[tonumber(sceneObjectClick.StringData)][sceneObjectClick.IntData]
    end
    if self._dragCharacter then
      self._dragCharacter:BeginDragYardCharacter()
    else
      self._cabinSceneController:SetCameraAnimatorState(0)
      self._cabinSceneController:MoveCamera(0, 0)
    end
  end
end

function InteractModalDialog:OnDrag(args)
  if not self._responseMouse then
    return
  end
  if self._dressupIng then
    if self._furniture then
      local mainCamera = self._cabinSceneController:GetMainCamera()
      local position = args.position
      local pos1 = UIManager.ScreenToViewportPointInMargin("DormMain", position.x, position.y, position.z)
      local pos2 = mainCamera:ViewportToWorldPoint(pos1)
      self._furniture:DragFurniture(pos2)
      self._cabinSceneController:CheckOverlap(self._furniture:GetItem():GetLayerId())
    end
  elseif self._dragCharacter then
    local pos = self._dragCharacter:GetPosition()
    local mainCamera = self._cabinSceneController:GetMainCamera()
    local position = args.position
    local pos1 = UIManager.ScreenToViewportPointInMargin("DormMain", position.x, position.y, position.z)
    local pos2 = mainCamera:WorldToViewportPoint(pos)
    local pos3 = CS.UnityEngine.Vector3(pos1.x, pos1.y, pos2.z)
    local pos4 = mainCamera:ViewportToWorldPoint(pos3)
    local deltaX, deltaY = 0, 0
    if 0 < args.delta.x * (pos4.x - pos.x) then
      deltaX = pos4.x - pos.x
    end
    if 0 < args.delta.y * (pos4.y - pos.y) then
      deltaY = pos4.y - pos.y
    end
    self._dragCharacter:DragYardCharacter(deltaX, deltaY, pos4.z - pos.z)
  else
    self._cabinSceneController:MoveCamera(-args.delta.x / 100, -args.delta.y / 100)
  end
end

function InteractModalDialog:OnEndDrag(args)
  if not self._responseMouse then
    return
  end
  if self._dressupIng then
    if self._furniture then
      self._furniture = nil
    end
  elseif self._dragCharacter then
    self._dragCharacter:EndDragYardCharacter()
    self._dragCharacter = nil
  else
    self._cabinSceneController:MoveCamera(0, 0)
  end
end

function InteractModalDialog:OnEnterDressUpMode()
  CS.PixelNeko.UI.UIManager.CancelTouch(self._rootWindow._uiObject)
  self._dressupIng = true
end

function InteractModalDialog:OnExitDressUpMode()
  self._dressupIng = false
end

function InteractModalDialog:OnHideUI(notification)
  self._show = notification.userInfo
end

function InteractModalDialog:AddNewModal()
end

function InteractModalDialog:GetSelectRoomId()
  return self._selectRoomId
end

function InteractModalDialog:GetSceneController()
  return self._cabinSceneController
end

function InteractModalDialog:SetResponseMouse(value)
  self._responseMouse = value
end

function InteractModalDialog:OnCuePlayEnd(notification)
  if self._voiceId then
    local cueSheet, cueName = LuaAudioManager.GetCueSheetAndCueNameWithVoiceID(self._voiceId)
    if cueSheet == notification.userInfo.cueSheet and cueName == notification.userInfo.cueName then
      self:SetVoiceIdNil(true)
    end
  end
end

function InteractModalDialog:SetVoiceIdNil(auto)
  if self._voiceId then
    if not auto then
      NekoData.BehaviorManager.BM_Voice:StopVoice(self._voiceId)
    end
    self._voiceId = nil
  end
end

return InteractModalDialog
