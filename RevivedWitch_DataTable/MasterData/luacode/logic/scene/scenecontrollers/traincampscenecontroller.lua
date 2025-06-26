-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/traincampscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local BoxColiderStaticFunctions = ((CS.PixelNeko).Lua).BoxColiderStaticFunctions
local TrainCharacter = require("logic.manager.experimental.types.traincharacter")
local Role = require("logic.manager.experimental.types.role")
local TrainStatus = (LuaNetManager.GetBeanDef)("protocol.yard.train")
local CharacterSize_z = 0.1
local TrainCampSceneController = class("TrainCampSceneController", SceneController)
TrainCampSceneController.Ctor = function(self, sceneRef)
  -- function num : 0_0 , upvalues : TrainCampSceneController
  ((TrainCampSceneController.super).Ctor)(self, sceneRef)
  self._characters = {}
  self._characterZ = {pos = nil, deltaZ = nil}
end

TrainCampSceneController.Init = function(self)
  -- function num : 0_1 , upvalues : TrainCampSceneController
  ((TrainCampSceneController.super).Init)(self)
end

TrainCampSceneController.OnDestroy = function(self)
  -- function num : 0_2
  self:ExitTrainCamp()
end

TrainCampSceneController.SetInteractDialog = function(self, dialog)
  -- function num : 0_3
  self._interactModalDialog = dialog
end

TrainCampSceneController.EnterTrainCamp = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:RefreshCharacters()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStartTrainTask, Common.n_StartTrainTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCharacters, Common.n_CompleteTrainTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCharacters, Common.n_StopTrainTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCharacters, Common.n_RefreshTrainTask, nil)
end

TrainCampSceneController.ExitTrainCamp = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._characterZ = {pos = nil, deltaZ = nil}
  for roleId,character in pairs(self._characters) do
    character:Destroy()
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._characters)[roleId] = nil
  end
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

TrainCampSceneController.RefreshCharacters = function(self)
  -- function num : 0_6 , upvalues : _ENV, TransformStaticFunctions, BoxColiderStaticFunctions, CharacterSize_z, TrainStatus, Role, TrainCharacter
  for roleId,character in pairs(self._characters) do
    character:Destroy()
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._characters)[roleId] = nil
  end
  ;
  (self._interactModalDialog):DestroyCells()
  local normalCharacterPoint = (self._sceneRef):GetNormalCharacterPoint()
  local attackerPoint = (self._sceneRef):GetAttackerPoint()
  local downColliderObject = (TransformStaticFunctions.GetChild)(normalCharacterPoint, "Bottom")
  local boundsMin = (BoxColiderStaticFunctions.GetBoundsMin)(downColliderObject)
  local boundsSize = (BoxColiderStaticFunctions.GetBoundsSize)(downColliderObject)
  local dispatchRoleList = ((NekoData.BehaviorManager).BM_TrainCamp):GetDispatchRoles(true)
  local MaxRoleNum = #dispatchRoleList
  local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / ((NekoData.BehaviorManager).BM_TrainCamp):GetDispatchMaxRoleNum()
  local z = boundsMin.z + CharacterSize_z
  local rolesWithStatus = ((NekoData.BehaviorManager).BM_TrainCamp):GetRolesWithStatus()
  local haveWorkingRole = false
  for k,v in pairs(rolesWithStatus) do
    if v == TrainStatus.PROCESSING then
      haveWorkingRole = true
      break
    end
  end
  do
    local randomAttackerId = nil
    if haveWorkingRole then
      local randomMap = {}
      local randomNum = 0
      while not randomAttackerId do
        local index = (math.random)(1, MaxRoleNum)
        local roleId = dispatchRoleList[index]
        if not randomMap[roleId] then
          randomNum = randomNum + 1
          randomMap[roleId] = true
        end
        if rolesWithStatus[roleId] == TrainStatus.PROCESSING then
          local role = (Role.Create)(roleId)
          if role:IsAttacker() then
            randomAttackerId = roleId
          end
        end
      end
    end
    do
      if randomNum ~= MaxRoleNum then
        for _,roleId in ipairs(dispatchRoleList) do
          local trainCharacter = nil
          if not randomAttackerId or randomAttackerId ~= roleId then
            trainCharacter = (TrainCharacter.Create)(roleId)
            trainCharacter:CreatePlayer(normalCharacterPoint)
            trainCharacter:SetClickParam(roleId)
            local pos = trainCharacter:GetPosition()
            trainCharacter:InitZPosition(z)
            z = z + deltaZ
            trainCharacter:LoadBehavior()
          else
            do
              do
                trainCharacter = (TrainCharacter.Create)(roleId, true)
                trainCharacter:CreatePlayer(attackerPoint)
                trainCharacter:SetClickParam(roleId)
                if rolesWithStatus[roleId] == TrainStatus.PROCESSING then
                  (self._interactModalDialog):CreateExpCell(roleId)
                  trainCharacter:SetUiCell(((self._interactModalDialog)._expUpCells)[roleId])
                else
                  ;
                  (self._interactModalDialog):CreateFinishCell(roleId)
                  trainCharacter:SetUiCell(((self._interactModalDialog)._finishCells)[roleId])
                end
                -- DECOMPILER ERROR at PC162: Confused about usage of register: R19 in 'UnsetPending'

                ;
                (self._characters)[roleId] = trainCharacter
                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
        -- DECOMPILER ERROR at PC166: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (self._characterZ).pos = z
        -- DECOMPILER ERROR at PC168: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (self._characterZ).deltaZ = deltaZ
        if not self._task then
          self._task = (GameTimer.AddTask)(10, 10, function()
    -- function num : 0_6_0 , upvalues : self, _ENV
    if self._interactModalDialog then
      for k,v in pairs((self._interactModalDialog)._expUpCells) do
        v:PlayAppearAnimation()
      end
    end
  end
, nil)
        end
      end
    end
  end
end

TrainCampSceneController.OnStartTrainTask = function(self, notification)
  -- function num : 0_7 , upvalues : TrainCharacter, _ENV, TrainStatus
  if (self._characterZ).pos then
    local protocol = notification.userInfo
    local roleId = (protocol.train).roleId
    local trainCharacter = (TrainCharacter.Create)(roleId)
    local normalCharacterPoint = (self._sceneRef):GetNormalCharacterPoint()
    trainCharacter:CreatePlayer(normalCharacterPoint)
    trainCharacter:SetClickParam(roleId)
    trainCharacter:InitZPosition((self._characterZ).pos)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._characterZ).pos = (self._characterZ).pos + (self._characterZ).deltaZ
    trainCharacter:LoadBehavior()
    local rolesWithStatus = ((NekoData.BehaviorManager).BM_TrainCamp):GetRolesWithStatus()
    if rolesWithStatus[roleId] == TrainStatus.PROCESSING then
      (self._interactModalDialog):CreateExpCell(roleId)
      trainCharacter:SetUiCell(((self._interactModalDialog)._expUpCells)[roleId])
    else
      ;
      (self._interactModalDialog):CreateFinishCell(roleId)
      trainCharacter:SetUiCell(((self._interactModalDialog)._finishCells)[roleId])
    end
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._characters)[roleId] = trainCharacter
  end
end

TrainCampSceneController.GetMainCamera = function(self)
  -- function num : 0_8
  return (self._sceneRef)._mainCamera
end

return TrainCampSceneController

