local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local InteractDialog = class("InteractDialog", Dialog)
InteractDialog.AssetBundleName = "ui/layouts"
InteractDialog.AssetName = "SceneObjectInteract"

function InteractDialog:Ctor(...)
  InteractDialog.super.Ctor(self, ...)
  self._groupName = "Operation"
  self._summerechoesSceneController = nil
  self._raycastHits = nil
end

function InteractDialog:OnCreate()
  self._raycastHits = PhysicsStaticFunctions.CreateRaycastHits(1)
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackClicked, self)
  self._beginDragHandler = self._rootWindow:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._dragHandler = self._rootWindow:Subscribe_DragEvent(self.OnDrag, self)
  self._endDragHandler = self._rootWindow:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._cancelDragHandler = self._rootWindow:Subscribe_CancelDragEvent(self.OnEndDrag, self)
end

function InteractDialog:OnDestroy()
  self._dialog = nil
end

function InteractDialog:Init(sceneController)
  self._summerechoesSceneController = sceneController
end

function InteractDialog:IsHitSceneObject(position)
  local mainCamera = self._summerechoesSceneController:GetMainCamera()
  local outputViewPos = UIManager.ScreenToViewportPointInMargin("Main", position.x, position.y, 0)
  local ray = mainCamera:ViewportPointToRay(outputViewPos)
  local count, raycastHit, sceneObjectClick
  self._raycastHits, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return
  end
  raycastHit = self._raycastHits[0]
  sceneObjectClick = SceneObjectClick.GetSceneObjectClick(raycastHit.collider.gameObject)
  return sceneObjectClick
end

function InteractDialog:OnBackClicked(args)
  self._summerechoesSceneController:CancleSelectBlock()
  local sceneObjectClick = self:IsHitSceneObject(args.position)
  if sceneObjectClick then
    local blockID = tonumber(sceneObjectClick.IntData)
    if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):BlockHasEvent(blockID) then
      LogError("sceneObjectClick blockID", tostring(blockID))
      self._summerechoesSceneController:SelectBlock(blockID)
      NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):OnBlockClick(blockID)
    end
  end
end

function InteractDialog:OnBeginDrag(args)
  self._summerechoesSceneController:CancleSelectBlock()
  self._summerechoesSceneController:MoveCamera(0, 0)
  self._sceneObjectDrag = self:IsHitSceneObject(args.position)
end

function InteractDialog:OnDrag(args)
  self._summerechoesSceneController:MoveCamera(-args.delta.x / 150, -args.delta.y / 150)
end

function InteractDialog:OnEndDrag()
  self._summerechoesSceneController:MoveCamera(0, 0)
  if self._selectBlock then
    self._selectBlock:EndDrag()
    local tempCoordinates = self._selectBlock:GetTempCoordinates()
    if not self._summerechoesSceneController:CheckCoordinate(tempCoordinates) then
      self._selectBlock:CancelMove()
    end
  end
  self._sceneObjectDrag = nil
end

function InteractDialog:CancelMove()
  self._selectBlock:CancelMove()
  self._selectBlock = nil
end

function InteractDialog:FinishSelect()
  self._selectBlock = nil
end

return InteractDialog
