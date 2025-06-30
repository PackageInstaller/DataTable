-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtyard/interactmodaldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local PhysicsStaticFunctions = ((CS.PixelNeko).Lua).PhysicsStaticFunctions
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local UIManager = ((CS.PixelNeko).UI).UIManager
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local InteractModalDialog = class("InteractModalDialog", Dialog)
InteractModalDialog.AssetBundleName = "ui/layouts"
InteractModalDialog.AssetName = "SceneObjectInteract"
InteractModalDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InteractModalDialog
  ((InteractModalDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._courtyardSceneController = nil
  self._raycastHits = nil
  self._yardCharacter = nil
end

InteractModalDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : PhysicsStaticFunctions
  self._raycastHits = (PhysicsStaticFunctions.CreateRaycastHits)(1)
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  ;
  (self._rootWindow):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  ;
  (self._rootWindow):Subscribe_DragEvent(self.OnDrag, self)
  ;
  (self._rootWindow):Subscribe_EndDragEvent(self.OnEndDrag, self)
  ;
  (self._rootWindow):Subscribe_CancelDragEvent(self.OnEndDrag, self)
end

InteractModalDialog.OnDestroy = function(self)
  -- function num : 0_2
end

InteractModalDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._courtyardSceneController = sceneController
end

InteractModalDialog.IsHitYardCharacter = function(self, position)
  -- function num : 0_4 , upvalues : UIManager, PhysicsStaticFunctions, _ENV, SceneObjectClick
  local mainCamera = (self._courtyardSceneController):GetMainCamera()
  local outputViewPos = (UIManager.ScreenToViewportPointInMargin)("Main", position.x, position.y, 0)
  local ray = (mainCamera:ViewportPointToRay(outputViewPos))
  local count = nil
  self._raycastHits = (PhysicsStaticFunctions.RaycastNonAllocSort)(ray, self._raycastHits, 1000000, Layers.YardCharacterLayerID)
  if count == 0 then
    return 
  end
  local raycastHit = (self._raycastHits)[0]
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)((raycastHit.collider).gameObject)
  if sceneObjectClick == nil then
    return 
  end
  if sceneObjectClick.SceneName ~= "HomeMain_ForBuild" then
    local buildingType = tonumber(sceneObjectClick.StringData)
    local yardCharacter = (((self._courtyardSceneController)._yardCharacters)[buildingType])[sceneObjectClick.IntData]
    return yardCharacter
  end
  do
    return false
  end
end

InteractModalDialog.OnMouseClicked = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  local yardCharacter = self:IsHitYardCharacter(args.position)
  if yardCharacter then
    ((NekoData.BehaviorManager).BM_Voice):Play(yardCharacter:GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).YardTouch, nil)
    yardCharacter:ClickCharacter()
  end
end

InteractModalDialog.OnBeginDrag = function(self, args)
  -- function num : 0_6
  local yardCharacter = self:IsHitYardCharacter(args.position)
  if yardCharacter then
    self._yardCharacter = yardCharacter
    ;
    (self._yardCharacter):BeginDragYardCharacter()
    self._drag = true
  end
end

InteractModalDialog.OnDrag = function(self, args)
  -- function num : 0_7 , upvalues : UIManager, _ENV
  if self._drag and self._yardCharacter then
    local pos = (self._yardCharacter):GetPosition()
    local mainCamera = (self._courtyardSceneController):GetMainCamera()
    local position = args.position
    local pos1 = (UIManager.ScreenToViewportPointInMargin)("Main", position.x, position.y, position.z)
    local pos2 = mainCamera:WorldToViewportPoint(pos)
    local pos3 = ((CS.UnityEngine).Vector3)(pos1.x, pos1.y, pos2.z)
    local pos4 = mainCamera:ViewportToWorldPoint(pos3)
    local deltaX, deltaY = 0, 0
    if (args.delta).x * (pos4.x - pos.x) > 0 then
      deltaX = pos4.x - pos.x
    end
    if (args.delta).y * (pos4.y - pos.y) > 0 then
      deltaY = pos4.y - pos.y
    end
    ;
    (self._yardCharacter):DragYardCharacter(deltaX, deltaY, pos4.z - pos.z)
  end
end

InteractModalDialog.OnEndDrag = function(self, args)
  -- function num : 0_8
  self._drag = false
  if self._yardCharacter then
    (self._yardCharacter):EndDragYardCharacter()
    self._yardCharacter = nil
  end
end

InteractModalDialog.AddNewModal = function(self)
  -- function num : 0_9
end

return InteractModalDialog

