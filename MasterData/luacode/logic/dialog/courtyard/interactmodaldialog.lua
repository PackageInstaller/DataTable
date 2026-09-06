local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local InteractModalDialog = class("InteractModalDialog", Dialog)
InteractModalDialog.AssetBundleName = "ui/layouts"
InteractModalDialog.AssetName = "SceneObjectInteract"

function InteractModalDialog:Ctor(...)
  InteractModalDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._courtyardSceneController = nil
  self._raycastHits = nil
  self._yardCharacter = nil
end

function InteractModalDialog:OnCreate()
  self._raycastHits = PhysicsStaticFunctions.CreateRaycastHits(1)
  self._rootWindow:Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  self._rootWindow:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._rootWindow:Subscribe_DragEvent(self.OnDrag, self)
  self._rootWindow:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._rootWindow:Subscribe_CancelDragEvent(self.OnEndDrag, self)
end

function InteractModalDialog:OnDestroy()
end

function InteractModalDialog:Init(sceneController)
  self._courtyardSceneController = sceneController
end

function InteractModalDialog:IsHitYardCharacter(position)
  local mainCamera = self._courtyardSceneController:GetMainCamera()
  local outputViewPos = UIManager.ScreenToViewportPointInMargin("Main", position.x, position.y, 0)
  local ray = mainCamera:ViewportPointToRay(outputViewPos)
  local count
  self._raycastHits, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHits, 1000000, Layers.YardCharacterLayerID)
  if count == 0 then
    return
  end
  local raycastHit = self._raycastHits[0]
  local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(raycastHit.collider.gameObject)
  if sceneObjectClick == nil then
    return
  end
  if sceneObjectClick.SceneName ~= "HomeMain_ForBuild" then
    local buildingType = tonumber(sceneObjectClick.StringData)
    local yardCharacter = self._courtyardSceneController._yardCharacters[buildingType][sceneObjectClick.IntData]
    return yardCharacter
  end
  return false
end

function InteractModalDialog:OnMouseClicked(args)
  local yardCharacter = self:IsHitYardCharacter(args.position)
  if yardCharacter then
    NekoData.BehaviorManager.BM_Voice:Play(yardCharacter:GetId(), NekoData.BehaviorManager.BM_Voice.VoiceType.YardTouch, nil)
    yardCharacter:ClickCharacter()
  end
end

function InteractModalDialog:OnBeginDrag(args)
  local yardCharacter = self:IsHitYardCharacter(args.position)
  if yardCharacter then
    self._yardCharacter = yardCharacter
    self._yardCharacter:BeginDragYardCharacter()
    self._drag = true
  end
end

function InteractModalDialog:OnDrag(args)
  if self._drag and self._yardCharacter then
    local pos = self._yardCharacter:GetPosition()
    local mainCamera = self._courtyardSceneController:GetMainCamera()
    local position = args.position
    local pos1 = UIManager.ScreenToViewportPointInMargin("Main", position.x, position.y, position.z)
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
    self._yardCharacter:DragYardCharacter(deltaX, deltaY, pos4.z - pos.z)
  end
end

function InteractModalDialog:OnEndDrag(args)
  self._drag = false
  if self._yardCharacter then
    self._yardCharacter:EndDragYardCharacter()
    self._yardCharacter = nil
  end
end

function InteractModalDialog:AddNewModal()
end

return InteractModalDialog
