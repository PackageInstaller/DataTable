-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/interactdialog.lua 

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
  self._groupName = "Operation"
  self._hexagonSceneController = nil
  self._raycastHits = nil
end

InteractDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : PhysicsStaticFunctions
  self._raycastHits = (PhysicsStaticFunctions.CreateRaycastHits)(1)
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnBackClicked, self)
  self._beginDragHandler = (self._rootWindow):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._dragHandler = (self._rootWindow):Subscribe_DragEvent(self.OnDrag, self)
  self._endDragHandler = (self._rootWindow):Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._cancelDragHandler = (self._rootWindow):Subscribe_CancelDragEvent(self.OnEndDrag, self)
end

InteractDialog.OnDestroy = function(self)
  -- function num : 0_2
  self._dialog = nil
end

InteractDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._hexagonSceneController = sceneController
end

InteractDialog.IsHitSceneObject = function(self, position)
  -- function num : 0_4 , upvalues : UIManager, PhysicsStaticFunctions, _ENV, SceneObjectClick
  local mainCamera = (self._hexagonSceneController):GetMainCamera()
  local outputViewPos = (UIManager.ScreenToViewportPointInMargin)("Main", position.x, position.y, 0)
  local ray = (mainCamera:ViewportPointToRay(outputViewPos))
  -- DECOMPILER ERROR at PC12: Overwrote pending register: R5 in 'AssignReg'

  local count, raycastHit, sceneObjectClick = .end, nil, nil
  self._raycastHits = (PhysicsStaticFunctions.RaycastNonAllocSort)(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return 
  end
  raycastHit = (self._raycastHits)[0]
  sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)((raycastHit.collider).gameObject)
  return sceneObjectClick
end

InteractDialog.OnBackClicked = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  (self._hexagonSceneController):CancleSelectBlock()
  local sceneObjectClick = self:IsHitSceneObject(args.position)
  if sceneObjectClick then
    local blockID = tonumber(sceneObjectClick.IntData)
    if not self._DIYing and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):BlockHasEvent(blockID) then
      (self._hexagonSceneController):SelectBlock(blockID)
      ;
      (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):OnBlockClick(blockID)
    end
  end
end

InteractDialog.OnBeginDrag = function(self, args)
  -- function num : 0_6
  (self._hexagonSceneController):CancleSelectBlock()
  ;
  (self._hexagonSceneController):MoveCamera(0, 0)
  self._sceneObjectDrag = self:IsHitSceneObject(args.position)
end

InteractDialog.OnDrag = function(self, args)
  -- function num : 0_7 , upvalues : UIManager, _ENV
  if self._DIYing and self._sceneObjectDrag and self._selectBlock then
    local mainCamera = (self._hexagonSceneController):GetMainCamera()
    local position = args.position
    local pos1 = (UIManager.ScreenToViewportPointInMargin)("Main", position.x, position.y, position.z)
    local pos2 = mainCamera:ViewportToWorldPoint(pos1)
    local offsetZ = pos2.y / (math.tan)((math.rad)(((mainCamera.transform).eulerAngles).x))
    local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
    local x = pos2.x
    local y = 0
    local z = pos2.z + offsetZ
    ;
    (self._selectBlock):SetWorldPos({x = x, y = y, z = z})
  end
  do
    ;
    (self._hexagonSceneController):MoveCamera(-(args.delta).x / 150, -(args.delta).y / 150)
    ;
    (self._hexagonSceneController):MoveCamera(-(args.delta).x / 150, -(args.delta).y / 150)
  end
end

InteractDialog.OnEndDrag = function(self)
  -- function num : 0_8
  (self._hexagonSceneController):MoveCamera(0, 0)
  if self._selectBlock then
    (self._selectBlock):EndDrag()
    local tempCoordinates = (self._selectBlock):GetTempCoordinates()
    if not (self._hexagonSceneController):CheckCoordinate(tempCoordinates) then
      (self._selectBlock):CancelMove()
    end
  end
  do
    self._sceneObjectDrag = nil
  end
end

InteractDialog.OnEnterDIYMode = function(self)
  -- function num : 0_9
  self._DIYing = true
end

InteractDialog.OnExitDIYMode = function(self)
  -- function num : 0_10
  self._DIYing = false
end

InteractDialog.CancelMove = function(self)
  -- function num : 0_11
  (self._selectBlock):CancelMove()
  self._selectBlock = nil
end

InteractDialog.FinishSelect = function(self)
  -- function num : 0_12
  self._selectBlock = nil
end

return InteractDialog

