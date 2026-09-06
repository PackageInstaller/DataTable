local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local InteractModalDialog = class("InteractModalDialog", Dialog)
InteractModalDialog.AssetBundleName = "ui/layouts"
InteractModalDialog.AssetName = "SceneObjectInteract"

function InteractModalDialog:Ctor(...)
  InteractModalDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._trainCampSceneController = nil
  self._raycastHitsChar = nil
  self._expUpCells = {}
  self._finishCells = {}
end

function InteractModalDialog:OnCreate()
  self._raycastHitsChar = PhysicsStaticFunctions.CreateRaycastHits(NekoData.BehaviorManager.BM_TrainCamp:GetDispatchMaxRoleNum())
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackClicked, self)
  self._rootWindow:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._rootWindow:Subscribe_DragEvent(self.OnDrag, self)
  self._rootWindow:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._rootWindow:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function InteractModalDialog:OnDestroy()
  self:DestroyCells()
  LuaNotificationCenter.RemoveObserver(self)
end

function InteractModalDialog:Init(sceneController)
  self._trainCampSceneController = sceneController
end

function InteractModalDialog:IsHitSceneObject(position)
  local mainCamera = self._trainCampSceneController:GetMainCamera()
  local outputViewPos = UIManager.ScreenToViewportPointInMargin("TrainCampMain", position.x, position.y, 0)
  local ray = mainCamera:ViewportPointToRay(outputViewPos)
  local count, raycastHit
  self._raycastHitsChar, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHitsChar, 1000000, Layers.YardCharacterLayerID)
  if count == 0 then
    return
  else
    raycastHit = self._raycastHitsChar[0]
  end
  return SceneObjectClick.GetSceneObjectClick(raycastHit.collider.gameObject)
end

function InteractModalDialog:OnBackClicked(args)
  local sceneObjectClick = self:IsHitSceneObject(args.position)
  if sceneObjectClick then
    local trainCharacter = self._trainCampSceneController._characters[sceneObjectClick.IntData]
    if trainCharacter then
      if not trainCharacter:IsAttacker() then
        trainCharacter:ClickCharacter()
      end
      NekoData.BehaviorManager.BM_Voice:Play(trainCharacter:GetId(), NekoData.BehaviorManager.BM_Voice.VoiceType.YardTouch, nil)
    end
  end
end

function InteractModalDialog:OnBeginDrag(args)
  local sceneObjectClick = self:IsHitSceneObject(args.position)
  local dragCharacter
  if sceneObjectClick then
    dragCharacter = self._trainCampSceneController._characters[sceneObjectClick.IntData]
  end
  if dragCharacter and not dragCharacter:IsAttacker() then
    self._dragCharacter = dragCharacter
    self._dragCharacter:BeginDragYardCharacter()
  end
end

function InteractModalDialog:OnDrag(args)
  if self._dragCharacter then
    local pos = self._dragCharacter:GetPosition()
    local mainCamera = self._trainCampSceneController:GetMainCamera()
    local position = args.position
    local pos1 = UIManager.ScreenToViewportPointInMargin("TrainCampMain", position.x, position.y, position.z)
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
  end
end

function InteractModalDialog:OnEndDrag(args)
  if self._dragCharacter then
    self._dragCharacter:EndDragYardCharacter()
    self._dragCharacter = nil
  end
end

function InteractModalDialog:DestroyCells()
  for k, v in pairs(self._expUpCells) do
    v:Destroy()
    v:RootWindowDestroy()
    self._expUpCells[k] = nil
  end
  for k, v in pairs(self._finishCells) do
    v:Destroy()
    v:RootWindowDestroy()
    self._finishCells[k] = nil
  end
end

function InteractModalDialog:CreateExpCell(roleId)
  if not self._expUpCells[roleId] then
    local expUpCell = DialogManager.CreateDialog("traincamp.expupcell", self._rootWindow._uiObject)
    expUpCell:SetData(self)
    self._expUpCells[roleId] = expUpCell
  end
end

function InteractModalDialog:CreateFinishCell(roleId)
  if not self._finishCells[roleId] then
    local finishCell = DialogManager.CreateDialog("traincamp.finishcell", self._rootWindow._uiObject)
    finishCell:SetData(self)
    self._finishCells[roleId] = finishCell
  end
end

function InteractModalDialog:OnUpdate()
  for k, v in pairs(self._trainCampSceneController._characters) do
    local cell = self._finishCells[k] or self._expUpCells[k]
    if cell then
      cell:UpdatePosition(TransformStaticFunctions.GetPosition(v._popPoint))
    end
  end
end

function InteractModalDialog:AddNewModal()
end

return InteractModalDialog
