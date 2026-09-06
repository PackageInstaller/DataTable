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
  self._hexagonSceneController = nil
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
  self._hexagonSceneController = sceneController
end

function InteractDialog:IsHitSceneObject(position)
  local mainCamera = self._hexagonSceneController:GetMainCamera()
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
  self._hexagonSceneController:CancleSelectBlock()
  local sceneObjectClick = self:IsHitSceneObject(args.position)
  if sceneObjectClick then
    local blockID = tonumber(sceneObjectClick.IntData)
    if not self._DIYing and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID):BlockHasEvent(blockID) then
      self._hexagonSceneController:SelectBlock(blockID)
      NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID):OnBlockClick(blockID)
    else
    end
  end
end

function InteractDialog:OnBeginDrag(args)
  self._hexagonSceneController:CancleSelectBlock()
  self._hexagonSceneController:MoveCamera(0, 0)
  self._sceneObjectDrag = self:IsHitSceneObject(args.position)
end

function InteractDialog:OnDrag(args)
  if self._DIYing then
    if self._sceneObjectDrag then
      if self._selectBlock then
        local mainCamera = self._hexagonSceneController:GetMainCamera()
        local position = args.position
        local pos1 = UIManager.ScreenToViewportPointInMargin("Main", position.x, position.y, position.z)
        local pos2 = mainCamera:ViewportToWorldPoint(pos1)
        local offsetZ = pos2.y / math.tan(math.rad(mainCamera.transform.eulerAngles.x))
        local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
        local x = pos2.x
        local y = 0
        local z = pos2.z + offsetZ
        self._selectBlock:SetWorldPos({
          x = x,
          y = y,
          z = z
        })
      end
    else
      self._hexagonSceneController:MoveCamera(-args.delta.x / 150, -args.delta.y / 150)
    end
  else
    self._hexagonSceneController:MoveCamera(-args.delta.x / 150, -args.delta.y / 150)
  end
end

function InteractDialog:OnEndDrag()
  self._hexagonSceneController:MoveCamera(0, 0)
  if self._selectBlock then
    self._selectBlock:EndDrag()
    local tempCoordinates = self._selectBlock:GetTempCoordinates()
    if not self._hexagonSceneController:CheckCoordinate(tempCoordinates) then
      self._selectBlock:CancelMove()
    end
  end
  self._sceneObjectDrag = nil
end

function InteractDialog:OnEnterDIYMode()
  self._DIYing = true
end

function InteractDialog:OnExitDIYMode()
  self._DIYing = false
end

function InteractDialog:CancelMove()
  self._selectBlock:CancelMove()
  self._selectBlock = nil
end

function InteractDialog:FinishSelect()
  self._selectBlock = nil
end

return InteractDialog
