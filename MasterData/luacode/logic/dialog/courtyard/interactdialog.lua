local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local InteractDialog = class("InteractDialog", Dialog)
InteractDialog.AssetBundleName = "ui/layouts"
InteractDialog.AssetName = "SceneObjectInteract"

function InteractDialog:Ctor(...)
  InteractDialog.super.Ctor(self, ...)
  self._groupName = "Default"
  self._courtyardSceneController = nil
  self._raycastHits = nil
end

function InteractDialog:OnCreate()
  self._raycastHits = PhysicsStaticFunctions.CreateRaycastHits(2)
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackClicked, self)
  self._beginDragHandler = self._rootWindow:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._dragHandler = self._rootWindow:Subscribe_DragEvent(self.OnDrag, self)
  self._endDragHandler = self._rootWindow:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._cancelDragHandler = self._rootWindow:Subscribe_CancelDragEvent(self.OnEndDrag, self)
end

function InteractDialog:OnDestroy()
end

function InteractDialog:Init(sceneController)
  self._courtyardSceneController = sceneController
end

function InteractDialog:OnBackClicked(args)
  self._courtyardSceneController:MoveCamera(0, 0)
  local position = args.position
  local mainCamera = self._courtyardSceneController:GetMainCamera()
  local outputViewPos = UIManager.ScreenToViewportPointInMargin("Main", position.x, position.y, 0)
  local ray = mainCamera:ViewportPointToRay(outputViewPos)
  local count
  self._raycastHits, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return
  end
  local raycastHit = self._raycastHits[0]
  local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(raycastHit.collider.gameObject)
  if sceneObjectClick == nil then
    return
  end
  if sceneObjectClick.SceneName == "HomeMain_ForBuild" then
    self._courtyardSceneController:SetCameraAnimatorState(sceneObjectClick.IntData)
  elseif sceneObjectClick.SceneName == "Glows" then
    local lightKey = sceneObjectClick.IntData
    if self._courtyardSceneController._lights[lightKey] then
      local ccollectLightSpot = LuaNetManager.CreateProtocol("protocol.yard.ccollectlightspot")
      ccollectLightSpot.key = lightKey
      ccollectLightSpot:Send()
    end
  end
end

function InteractDialog:OnBeginDrag()
  self._courtyardSceneController:MoveCamera(0, 0)
end

function InteractDialog:OnDrag(args)
  self._courtyardSceneController:MoveCamera(-args.delta.x / 100, -args.delta.y / 100)
end

function InteractDialog:OnEndDrag()
  self._courtyardSceneController:MoveCamera(0, 0)
end

function InteractDialog:OnBeginZoom(args)
  self._courtyardSceneController:BeginZoomScene(args.scale)
  local dialog = DialogManager.GetDialog("courtyard.yardmaindialog")
  if dialog then
    dialog:OnCameraTransformChanged()
  end
end

function InteractDialog:OnZoom(args)
  self._courtyardSceneController:ZoomScene(args.scale)
  local dialog = DialogManager.GetDialog("courtyard.yardmaindialog")
  if dialog then
    dialog:OnCameraTransformChanged()
  end
end

function InteractDialog:OnEndZoom(args)
  self._courtyardSceneController:ZoomScene(args.scale)
  local dialog = DialogManager.GetDialog("courtyard.yardmaindialog")
  if dialog then
    dialog:OnCameraTransformChanged()
  end
end

function InteractDialog:OnCancelZoom(args)
end

function InteractDialog:SetDragEnable(flag)
  if flag then
    if self._beginDragHandler then
      self._rootWindow:Unsubscribe_BeginDragEvent(self._beginDragHandler)
      self._beginDragHandler = nil
    end
    if self._dragHandler then
      self._rootWindow:Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
    if self._endDragHandler then
      self._rootWindow:Unsubscribe_EndDragEvent(self._endDragHandler)
      self._endDragHandler = nil
    end
    if self._cancelDragHandler then
      self._rootWindow:Unsubscribe_CancelDragEvent(self._cancelDragHandler)
      self._cancelDragHandler = nil
    end
    self._beginDragHandler = self._rootWindow:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
    self._dragHandler = self._rootWindow:Subscribe_DragEvent(self.OnDrag, self)
    self._endDragHandler = self._rootWindow:Subscribe_EndDragEvent(self.OnEndDrag, self)
    self._cancelDragHandler = self._rootWindow:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  else
    if self._beginDragHandler then
      self._rootWindow:Unsubscribe_BeginDragEvent(self._beginDragHandler)
      self._beginDragHandler = nil
    end
    if self._dragHandler then
      self._rootWindow:Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
    if self._endDragHandler then
      self._rootWindow:Unsubscribe_EndDragEvent(self._endDragHandler)
      self._endDragHandler = nil
    end
    if self._cancelDragHandler then
      self._rootWindow:Unsubscribe_CancelDragEvent(self._cancelDragHandler)
      self._cancelDragHandler = nil
    end
  end
end

return InteractDialog
