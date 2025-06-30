-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtyard/interactdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local PhysicsStaticFunctions = ((CS.PixelNeko).Lua).PhysicsStaticFunctions
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local UIManager = ((CS.PixelNeko).UI).UIManager
local InteractDialog = class("InteractDialog", Dialog)
InteractDialog.AssetBundleName = "ui/layouts"
InteractDialog.AssetName = "SceneObjectInteract"
InteractDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InteractDialog
  ((InteractDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._courtyardSceneController = nil
  self._raycastHits = nil
end

InteractDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : PhysicsStaticFunctions
  self._raycastHits = (PhysicsStaticFunctions.CreateRaycastHits)(2)
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnBackClicked, self)
  self._beginDragHandler = (self._rootWindow):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._dragHandler = (self._rootWindow):Subscribe_DragEvent(self.OnDrag, self)
  self._endDragHandler = (self._rootWindow):Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._cancelDragHandler = (self._rootWindow):Subscribe_CancelDragEvent(self.OnEndDrag, self)
end

InteractDialog.OnDestroy = function(self)
  -- function num : 0_2
end

InteractDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._courtyardSceneController = sceneController
end

InteractDialog.OnBackClicked = function(self, args)
  -- function num : 0_4 , upvalues : UIManager, PhysicsStaticFunctions, _ENV, SceneObjectClick
  (self._courtyardSceneController):MoveCamera(0, 0)
  local position = args.position
  local mainCamera = (self._courtyardSceneController):GetMainCamera()
  local outputViewPos = (UIManager.ScreenToViewportPointInMargin)("Main", position.x, position.y, 0)
  local ray = (mainCamera:ViewportPointToRay(outputViewPos))
  local count = nil
  self._raycastHits = (PhysicsStaticFunctions.RaycastNonAllocSort)(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return 
  end
  local raycastHit = (self._raycastHits)[0]
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)((raycastHit.collider).gameObject)
  if sceneObjectClick == nil then
    return 
  end
  if sceneObjectClick.SceneName == "HomeMain_ForBuild" then
    (self._courtyardSceneController):SetCameraAnimatorState(sceneObjectClick.IntData)
  else
    if sceneObjectClick.SceneName == "Glows" then
      local lightKey = sceneObjectClick.IntData
      if ((self._courtyardSceneController)._lights)[lightKey] then
        local ccollectLightSpot = (LuaNetManager.CreateProtocol)("protocol.yard.ccollectlightspot")
        ccollectLightSpot.key = lightKey
        ccollectLightSpot:Send()
      end
    end
  end
end

InteractDialog.OnBeginDrag = function(self)
  -- function num : 0_5
  (self._courtyardSceneController):MoveCamera(0, 0)
end

InteractDialog.OnDrag = function(self, args)
  -- function num : 0_6
  (self._courtyardSceneController):MoveCamera(-(args.delta).x / 100, -(args.delta).y / 100)
end

InteractDialog.OnEndDrag = function(self)
  -- function num : 0_7
  (self._courtyardSceneController):MoveCamera(0, 0)
end

InteractDialog.OnBeginZoom = function(self, args)
  -- function num : 0_8 , upvalues : _ENV
  (self._courtyardSceneController):BeginZoomScene(args.scale)
  local dialog = (DialogManager.GetDialog)("courtyard.yardmaindialog")
  if dialog then
    dialog:OnCameraTransformChanged()
  end
end

InteractDialog.OnZoom = function(self, args)
  -- function num : 0_9 , upvalues : _ENV
  (self._courtyardSceneController):ZoomScene(args.scale)
  local dialog = (DialogManager.GetDialog)("courtyard.yardmaindialog")
  if dialog then
    dialog:OnCameraTransformChanged()
  end
end

InteractDialog.OnEndZoom = function(self, args)
  -- function num : 0_10 , upvalues : _ENV
  (self._courtyardSceneController):ZoomScene(args.scale)
  local dialog = (DialogManager.GetDialog)("courtyard.yardmaindialog")
  if dialog then
    dialog:OnCameraTransformChanged()
  end
end

InteractDialog.OnCancelZoom = function(self, args)
  -- function num : 0_11
end

InteractDialog.SetDragEnable = function(self, flag)
  -- function num : 0_12
  if flag then
    if self._beginDragHandler then
      (self._rootWindow):Unsubscribe_BeginDragEvent(self._beginDragHandler)
      self._beginDragHandler = nil
    end
    if self._dragHandler then
      (self._rootWindow):Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
    if self._endDragHandler then
      (self._rootWindow):Unsubscribe_EndDragEvent(self._endDragHandler)
      self._endDragHandler = nil
    end
    if self._cancelDragHandler then
      (self._rootWindow):Unsubscribe_CancelDragEvent(self._cancelDragHandler)
      self._cancelDragHandler = nil
    end
    self._beginDragHandler = (self._rootWindow):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
    self._dragHandler = (self._rootWindow):Subscribe_DragEvent(self.OnDrag, self)
    self._endDragHandler = (self._rootWindow):Subscribe_EndDragEvent(self.OnEndDrag, self)
    self._cancelDragHandler = (self._rootWindow):Subscribe_CancelDragEvent(self.OnEndDrag, self)
  else
    if self._beginDragHandler then
      (self._rootWindow):Unsubscribe_BeginDragEvent(self._beginDragHandler)
      self._beginDragHandler = nil
    end
    if self._dragHandler then
      (self._rootWindow):Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
    if self._endDragHandler then
      (self._rootWindow):Unsubscribe_EndDragEvent(self._endDragHandler)
      self._endDragHandler = nil
    end
    if self._cancelDragHandler then
      (self._rootWindow):Unsubscribe_CancelDragEvent(self._cancelDragHandler)
      self._cancelDragHandler = nil
    end
  end
end

return InteractDialog

