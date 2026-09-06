local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local BoxColiderStaticFunctions = CS.PixelNeko.Lua.BoxColiderStaticFunctions
local TrainCharacter = require("logic.manager.experimental.types.traincharacter")
local Role = require("logic.manager.experimental.types.role")
local TrainStatus = LuaNetManager.GetBeanDef("protocol.yard.train")
local CharacterSize_z = 0.1
local TrainCampSceneController = class("TrainCampSceneController", SceneController)

function TrainCampSceneController:Ctor(sceneRef)
  TrainCampSceneController.super.Ctor(self, sceneRef)
  self._characters = {}
  self._characterZ = {pos = nil, deltaZ = nil}
end

function TrainCampSceneController:Init()
  TrainCampSceneController.super.Init(self)
end

function TrainCampSceneController:OnDestroy()
  self:ExitTrainCamp()
end

function TrainCampSceneController:SetInteractDialog(dialog)
  self._interactModalDialog = dialog
end

function TrainCampSceneController:EnterTrainCamp()
  self:RefreshCharacters()
  LuaNotificationCenter.AddObserver(self, self.OnStartTrainTask, Common.n_StartTrainTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCharacters, Common.n_CompleteTrainTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCharacters, Common.n_StopTrainTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCharacters, Common.n_RefreshTrainTask, nil)
end

function TrainCampSceneController:ExitTrainCamp()
  self._characterZ = {pos = nil, deltaZ = nil}
  for roleId, character in pairs(self._characters) do
    character:Destroy()
    self._characters[roleId] = nil
  end
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function TrainCampSceneController:RefreshCharacters()
  for roleId, character in pairs(self._characters) do
    character:Destroy()
    self._characters[roleId] = nil
  end
  self._interactModalDialog:DestroyCells()
  local normalCharacterPoint = self._sceneRef:GetNormalCharacterPoint()
  local attackerPoint = self._sceneRef:GetAttackerPoint()
  local downColliderObject = TransformStaticFunctions.GetChild(normalCharacterPoint, "Bottom")
  local boundsMin = BoxColiderStaticFunctions.GetBoundsMin(downColliderObject)
  local boundsSize = BoxColiderStaticFunctions.GetBoundsSize(downColliderObject)
  local dispatchRoleList = NekoData.BehaviorManager.BM_TrainCamp:GetDispatchRoles(true)
  local MaxRoleNum = #dispatchRoleList
  local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / NekoData.BehaviorManager.BM_TrainCamp:GetDispatchMaxRoleNum()
  local z = boundsMin.z + CharacterSize_z
  local rolesWithStatus = NekoData.BehaviorManager.BM_TrainCamp:GetRolesWithStatus()
  local haveWorkingRole = false
  for k, v in pairs(rolesWithStatus) do
    if v == TrainStatus.PROCESSING then
      haveWorkingRole = true
      break
    end
  end
  local randomAttackerId
  if haveWorkingRole then
    local randomMap = {}
    local randomNum = 0
    while not randomAttackerId do
      local index = math.random(1, MaxRoleNum)
      local roleId = dispatchRoleList[index]
      if not randomMap[roleId] then
        randomNum = randomNum + 1
        randomMap[roleId] = true
      end
      if rolesWithStatus[roleId] == TrainStatus.PROCESSING then
        local role = Role.Create(roleId)
        if role:IsAttacker() then
          randomAttackerId = roleId
        end
      end
      if randomNum == MaxRoleNum then
        break
      end
    end
  end
  for _, roleId in ipairs(dispatchRoleList) do
    local trainCharacter
    if not randomAttackerId or randomAttackerId ~= roleId then
      trainCharacter = TrainCharacter.Create(roleId)
      trainCharacter:CreatePlayer(normalCharacterPoint)
      trainCharacter:SetClickParam(roleId)
      local pos = trainCharacter:GetPosition()
      trainCharacter:InitZPosition(z)
      z = z + deltaZ
      trainCharacter:LoadBehavior()
    else
      trainCharacter = TrainCharacter.Create(roleId, true)
      trainCharacter:CreatePlayer(attackerPoint)
      trainCharacter:SetClickParam(roleId)
    end
    if rolesWithStatus[roleId] == TrainStatus.PROCESSING then
      self._interactModalDialog:CreateExpCell(roleId)
      trainCharacter:SetUiCell(self._interactModalDialog._expUpCells[roleId])
    else
      self._interactModalDialog:CreateFinishCell(roleId)
      trainCharacter:SetUiCell(self._interactModalDialog._finishCells[roleId])
    end
    self._characters[roleId] = trainCharacter
  end
  self._characterZ.pos = z
  self._characterZ.deltaZ = deltaZ
  if not self._task then
    self._task = GameTimer.AddTask(10, 10, function()
      if self._interactModalDialog then
        for k, v in pairs(self._interactModalDialog._expUpCells) do
          v:PlayAppearAnimation()
        end
      end
    end, nil)
  end
end

function TrainCampSceneController:OnStartTrainTask(notification)
  if self._characterZ.pos then
    local protocol = notification.userInfo
    local roleId = protocol.train.roleId
    local trainCharacter = TrainCharacter.Create(roleId)
    local normalCharacterPoint = self._sceneRef:GetNormalCharacterPoint()
    trainCharacter:CreatePlayer(normalCharacterPoint)
    trainCharacter:SetClickParam(roleId)
    trainCharacter:InitZPosition(self._characterZ.pos)
    self._characterZ.pos = self._characterZ.pos + self._characterZ.deltaZ
    trainCharacter:LoadBehavior()
    local rolesWithStatus = NekoData.BehaviorManager.BM_TrainCamp:GetRolesWithStatus()
    if rolesWithStatus[roleId] == TrainStatus.PROCESSING then
      self._interactModalDialog:CreateExpCell(roleId)
      trainCharacter:SetUiCell(self._interactModalDialog._expUpCells[roleId])
    else
      self._interactModalDialog:CreateFinishCell(roleId)
      trainCharacter:SetUiCell(self._interactModalDialog._finishCells[roleId])
    end
    self._characters[roleId] = trainCharacter
  end
end

function TrainCampSceneController:GetMainCamera()
  return self._sceneRef._mainCamera
end

return TrainCampSceneController
