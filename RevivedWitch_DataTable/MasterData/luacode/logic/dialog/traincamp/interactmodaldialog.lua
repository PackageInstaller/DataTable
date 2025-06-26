-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/traincamp/interactmodaldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PhysicsStaticFunctions = ((CS.PixelNeko).Lua).PhysicsStaticFunctions
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local UIManager = ((CS.PixelNeko).UI).UIManager
local InteractModalDialog = class("InteractModalDialog", Dialog)
InteractModalDialog.AssetBundleName = "ui/layouts"
InteractModalDialog.AssetName = "SceneObjectInteract"
InteractModalDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InteractModalDialog
  ((InteractModalDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._trainCampSceneController = nil
  self._raycastHitsChar = nil
  self._expUpCells = {}
  self._finishCells = {}
end

InteractModalDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : PhysicsStaticFunctions, _ENV
  self._raycastHitsChar = (PhysicsStaticFunctions.CreateRaycastHits)(((NekoData.BehaviorManager).BM_TrainCamp):GetDispatchMaxRoleNum())
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnBackClicked, self)
  ;
  (self._rootWindow):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  ;
  (self._rootWindow):Subscribe_DragEvent(self.OnDrag, self)
  ;
  (self._rootWindow):Subscribe_EndDragEvent(self.OnEndDrag, self)
  ;
  (self._rootWindow):Subscribe_CancelDragEvent(self.OnEndDrag, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

InteractModalDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:DestroyCells()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

InteractModalDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._trainCampSceneController = sceneController
end

InteractModalDialog.IsHitSceneObject = function(self, position)
  -- function num : 0_4 , upvalues : UIManager, PhysicsStaticFunctions, _ENV, SceneObjectClick
  local mainCamera = (self._trainCampSceneController):GetMainCamera()
  local outputViewPos = (UIManager.ScreenToViewportPointInMargin)("TrainCampMain", position.x, position.y, 0)
  local ray = (mainCamera:ViewportPointToRay(outputViewPos))
  local count, raycastHit = nil, nil
  self._raycastHitsChar = (PhysicsStaticFunctions.RaycastNonAllocSort)(ray, self._raycastHitsChar, 1000000, Layers.YardCharacterLayerID)
  if count == 0 then
    return 
  else
    raycastHit = (self._raycastHitsChar)[0]
  end
  return (SceneObjectClick.GetSceneObjectClick)((raycastHit.collider).gameObject)
end

InteractModalDialog.OnBackClicked = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  local sceneObjectClick = self:IsHitSceneObject(args.position)
  if sceneObjectClick then
    local trainCharacter = ((self._trainCampSceneController)._characters)[sceneObjectClick.IntData]
    if trainCharacter then
      if not trainCharacter:IsAttacker() then
        trainCharacter:ClickCharacter()
      end
      ;
      ((NekoData.BehaviorManager).BM_Voice):Play(trainCharacter:GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).YardTouch, nil)
    end
  end
end

InteractModalDialog.OnBeginDrag = function(self, args)
  -- function num : 0_6
  local sceneObjectClick = (self:IsHitSceneObject(args.position))
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local dragCharacter = .end
  if sceneObjectClick then
    dragCharacter = ((self._trainCampSceneController)._characters)[sceneObjectClick.IntData]
  end
  if dragCharacter and not dragCharacter:IsAttacker() then
    self._dragCharacter = dragCharacter
    ;
    (self._dragCharacter):BeginDragYardCharacter()
  end
end

InteractModalDialog.OnDrag = function(self, args)
  -- function num : 0_7 , upvalues : UIManager, _ENV
  if self._dragCharacter then
    local pos = (self._dragCharacter):GetPosition()
    local mainCamera = (self._trainCampSceneController):GetMainCamera()
    local position = args.position
    local pos1 = (UIManager.ScreenToViewportPointInMargin)("TrainCampMain", position.x, position.y, position.z)
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
    (self._dragCharacter):DragYardCharacter(deltaX, deltaY, pos4.z - pos.z)
  end
end

InteractModalDialog.OnEndDrag = function(self, args)
  -- function num : 0_8
  if self._dragCharacter then
    (self._dragCharacter):EndDragYardCharacter()
    self._dragCharacter = nil
  end
end

InteractModalDialog.DestroyCells = function(self)
  -- function num : 0_9 , upvalues : _ENV
  for k,v in pairs(self._expUpCells) do
    v:Destroy()
    v:RootWindowDestroy()
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._expUpCells)[k] = nil
  end
  for k,v in pairs(self._finishCells) do
    v:Destroy()
    v:RootWindowDestroy()
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._finishCells)[k] = nil
  end
end

InteractModalDialog.CreateExpCell = function(self, roleId)
  -- function num : 0_10 , upvalues : _ENV
  if not (self._expUpCells)[roleId] then
    local expUpCell = (DialogManager.CreateDialog)("traincamp.expupcell", (self._rootWindow)._uiObject)
    expUpCell:SetData(self)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._expUpCells)[roleId] = expUpCell
  end
end

InteractModalDialog.CreateFinishCell = function(self, roleId)
  -- function num : 0_11 , upvalues : _ENV
  if not (self._finishCells)[roleId] then
    local finishCell = (DialogManager.CreateDialog)("traincamp.finishcell", (self._rootWindow)._uiObject)
    finishCell:SetData(self)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._finishCells)[roleId] = finishCell
  end
end

InteractModalDialog.OnUpdate = function(self)
  -- function num : 0_12 , upvalues : _ENV, TransformStaticFunctions
  for k,v in pairs((self._trainCampSceneController)._characters) do
    if not (self._finishCells)[k] then
      local cell = (self._expUpCells)[k]
    end
    if cell then
      cell:UpdatePosition((TransformStaticFunctions.GetPosition)(v._popPoint))
    end
  end
end

InteractModalDialog.AddNewModal = function(self)
  -- function num : 0_13
end

return InteractModalDialog

