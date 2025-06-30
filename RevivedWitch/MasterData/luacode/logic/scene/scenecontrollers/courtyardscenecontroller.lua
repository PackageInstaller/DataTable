-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/courtyardscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local ZoomSceneConfig = (((CS.PixelNeko).P1).Config).ZoomSceneConfig
local BoxColiderConfig = (((CS.PixelNeko).P1).Config).BoxColiderConfig
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local BoxColiderStaticFunctions = ((CS.PixelNeko).Lua).BoxColiderStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local YardSceneCamera = (((CS.PixelNeko).P1).Camera).YardSceneCamera
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local YardSceneHelper = (((CS.PixelNeko).P1).Scene).YardSceneHelper
local YardCharacter = require("logic.manager.experimental.types.yardcharacter")
local Light = require("logic.manager.experimental.types.light")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CAudioPlayerCell = (BeanManager.GetTableByName)("courtyard.caudioplayercell")
local HideDialogIBtnGuide = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(113)).Value) == 0
local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local CharacterSize_z = 0.1
local CourtyardSceneController = class("CourtyardSceneController", SceneController)
local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  local guideId = (notification.userInfo).guideID
  if guideId == 16 or guideId == 55 or guideId == 56 or guideId == 58 or guideId == 59 then
    if (notification.userInfo).guideStatus == "Start" then
      local dialog = (DialogManager.GetDialog)("courtyard.interactdialog")
      if dialog then
        dialog:SetDragEnable(false)
      end
    else
      do
        local dialog = (DialogManager.GetDialog)("courtyard.interactdialog")
        if dialog then
          dialog:SetDragEnable(true)
        end
      end
    end
  end
end

local GetLightPointIndex = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local index = nil
  while 1 do
    while 1 do
      if (table.nums)(self._lights) < self._lightMaxNum then
        if not (self._lightPoints)[1] then
          index = 1
          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    index = (math.random)(2, self._lightMaxNum)
  end
  if (self._lightPoints)[index] then
    return index
  end
end

CourtyardSceneController.Ctor = function(self, sceneRef)
  -- function num : 0_2 , upvalues : CourtyardSceneController, _ENV, HideDialogIBtnGuide
  ((CourtyardSceneController.super).Ctor)(self, sceneRef)
  self._yardCharacters = {}
  self._lights = {}
  self._lightEffectGameObjects = {}
  self._lightPoints = {}
  self._bmBuildings = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.MagicTree] = (NekoData.BehaviorManager).BM_MagicTree
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.Explore] = (NekoData.BehaviorManager).BM_Explore
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.Firefly] = (NekoData.BehaviorManager).BM_Firefly
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.Alchemy] = (NekoData.BehaviorManager).BM_Alchemy
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.Cabin] = (NekoData.BehaviorManager).BM_Cabin
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.TrainCamp] = (NekoData.BehaviorManager).BM_TrainCamp
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.YardMusic] = (NekoData.BehaviorManager).BM_YardMusic
  self._yardSceneCamera = nil
  self._canSetWorkState = true
  self._state = 0
  if not HideDialogIBtnGuide then
    ((NekoData.BehaviorManager).BM_Game):SetLocalTipsNew((DataCommon.LocalTips).GuideOpenInstructionDialog_Magictree)
    ;
    ((NekoData.BehaviorManager).BM_Game):SetLocalTipsNew((DataCommon.LocalTips).GuideOpenInstructionDialog_Cabin)
    ;
    ((NekoData.BehaviorManager).BM_Game):SetLocalTipsNew((DataCommon.LocalTips).GuideOpenInstructionDialog_TrainCamp)
    ;
    ((NekoData.BehaviorManager).BM_Game):SetLocalTipsNew((DataCommon.LocalTips).GuideOpenInstructionDialog_Alchemy)
    ;
    ((NekoData.BehaviorManager).BM_Game):SetLocalTipsNew((DataCommon.LocalTips).GuideOpenInstructionDialog_Explore)
    ;
    ((NekoData.BehaviorManager).BM_Game):SetLocalTipsNew((DataCommon.LocalTips).GuideOpenInstructionDialog_Firefly)
  end
end

CourtyardSceneController.Init = function(self)
  -- function num : 0_3 , upvalues : CourtyardSceneController, _ENV, CAudioPlayerCell, AnimationHelper, CCourtyardLvUpCfg, StateEventTriggerHelper, TransformStaticFunctions, BoxColiderStaticFunctions, CharacterSize_z, YardCharacter, Light, GetLightPointIndex, ZoomSceneConfig, BoxColiderConfig, YardSceneCamera, HandleGuideStatusChanged
  ((CourtyardSceneController.super).Init)(self)
  local musicId = ((NekoData.BehaviorManager).BM_YardMusic):GetPlayingId()
  if musicId ~= 0 then
    local record = CAudioPlayerCell:GetRecorder(musicId)
    ;
    (LuaAudioManager.PlayBGM)(record.audioID)
  else
    do
      ;
      (LuaAudioManager.PlayBGM)(242)
      for k,v in pairs((self._sceneRef):GetBuildingScenes()) do
        local bm_building = (self._bmBuildings)[k]
        local level = bm_building:GetLevel()
        if k ~= DataCommon.MagicTree and bm_building and level > 0 then
          (AnimationHelper.SetAnimatorInteger2)(v, "state", 1)
        end
        do
          do
            if level > 0 then
              local buildingLvRecord = CCourtyardLvUpCfg:GetRecorder(k + level)
              -- DECOMPILER ERROR at PC62: Unhandled construct in 'MakeBoolean' P1

              if buildingLvRecord and buildingLvRecord.houseState ~= 0 then
                (AnimationHelper.SetAnimatorInteger2)(v, "level", buildingLvRecord.houseState)
              end
            end
            LogErrorFormat("CourtyardSceneController", "Can not find record by buildingLevel: %s", k + level)
            ;
            (StateEventTriggerHelper.AddStateExitListener)(v, self.OnAnimationStateExitEvent, self)
            -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
      for k,v in pairs(self._bmBuildings) do
        local roleList = v:GetDispatchRoles()
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R8 in 'UnsetPending'

        if #roleList > 0 then
          if not (self._yardCharacters)[k] then
            (self._yardCharacters)[k] = {}
          end
          local characterPoint = ((self._sceneRef):GetCharacterPoints())[k]
          local downColliderObject = (TransformStaticFunctions.GetChild)(characterPoint, "Bottom")
          local boundsMin = (BoxColiderStaticFunctions.GetBoundsMin)(downColliderObject)
          local boundsSize = (BoxColiderStaticFunctions.GetBoundsSize)(downColliderObject)
          local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / v:GetDispatchMaxRoleNum()
          local z = boundsMin.z + CharacterSize_z
          for i,roleKey in ipairs(roleList) do
            local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
            local yardCharacter = (YardCharacter.Create)(role:GetId(), "Yard")
            yardCharacter:CreatePlayer(characterPoint)
            yardCharacter:SetClickParam(tostring(k), roleKey)
            yardCharacter:InitZPosition(z)
            z = z + deltaZ
            yardCharacter:LoadBehavior()
            -- DECOMPILER ERROR at PC148: Confused about usage of register: R21 in 'UnsetPending'

            ;
            ((self._yardCharacters)[k])[roleKey] = yardCharacter
          end
        end
      end
      self._lightMaxNum = #(self._sceneRef)._glowsPoints
      for i = 1, self._lightMaxNum do
        -- DECOMPILER ERROR at PC162: Confused about usage of register: R6 in 'UnsetPending'

        (self._lightPoints)[i] = false
      end
      for k,v in pairs(((NekoData.BehaviorManager).BM_Firefly):GetSceneLights()) do
        local light = (Light.Create)(v, k)
        local index = GetLightPointIndex(self)
        -- DECOMPILER ERROR at PC182: Confused about usage of register: R9 in 'UnsetPending'

        if index then
          (self._lightPoints)[index] = k
          light:CreatePlayer(((self._sceneRef)._glowsPoints)[index])
          light:SetClickParam(k)
          -- DECOMPILER ERROR at PC192: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self._lights)[k] = light
        else
          LogErrorFormat("CourtyardSceneController", "SceneLights num error：=%s (The maximum quantity is = %s)", (table.nums)(((NekoData.BehaviorManager).BM_Firefly):GetSceneLights()), self._lightMaxNum)
        end
      end
      for k,v in pairs(self._bmBuildings) do
        self:RefreshSceneWorkEffect(k)
      end
      ;
      (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
      local dialog = (DialogManager.CreateSingletonDialog)("courtyard.interactdialog")
      if dialog then
        dialog:Init(self)
      end
      dialog = (DialogManager.CreateSingletonDialog)("courtyard.yardmaindialog")
      if dialog then
        dialog:Init(self)
      end
      if ((NekoData.BehaviorManager).BM_YardMusic):GetLevel() > 0 then
        (DialogManager.CreateSingletonDialog)("yardmusic.playingmusicdialog")
      end
      self._defFOV = (((((CS.PixelNeko).Lua).Cinemachine).CinemachineVirtualCameraStaticFunctions).GetFOV)((self._sceneRef):GetCinemachineStart())
      self._zoomSceneConfig = (ZoomSceneConfig.GetZoomSceneConfig)(((self._sceneRef):GetCinemachineStart()).gameObject)
      self._minFOV = (self._zoomSceneConfig).MinFOV
      self._maxFOV = (self._zoomSceneConfig).MaxFOV
      local x, y = nil, nil
      x = (BoxColiderStaticFunctions.GetSize)((self._sceneRef)._cameraBorder)
      self._boxColiderConfig = (BoxColiderConfig.GetBoxColiderConfig)(((self._sceneRef)._cameraBorder).gameObject)
      self._minBorder = (self._boxColiderConfig).BorderMin
      self._maxBorder = (self._boxColiderConfig).BorderMax
      self._yardSceneCamera = (YardSceneCamera.GetYardSceneCamera)(((self._sceneRef):GetMainCamera()).gameObject)
      if self._yardSceneCamera then
        (self._yardSceneCamera):SetTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
      end
      ;
      (StateEventTriggerHelper.AddStateEnterListener)((self._sceneRef)._cinemachinesGameObject, self.OnAnimationEvent, self)
      ;
      (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_3_0 , upvalues : self
    self:OnRefreshCharacters()
  end
, Common.n_RefreshCourtYard, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_3_1 , upvalues : self, _ENV
    self:OnRefreshCharacters(DataCommon.MagicTree)
  end
, Common.n_RefreshMagicTreeTask, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_3_2 , upvalues : self, _ENV
    self:OnRefreshCharacters(DataCommon.MagicTree)
  end
, Common.n_RefreshMagicTree, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_3_3 , upvalues : self, _ENV
    self:OnRefreshCharacters(DataCommon.Explore)
  end
, Common.n_RefreshExploreSlot, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_3_4 , upvalues : self, _ENV
    self:OnRefreshCharacters(DataCommon.Explore)
  end
, Common.n_RefreshAllExploreSlots, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_3_5 , upvalues : self, _ENV
    self:OnRefreshCharacters(DataCommon.Firefly)
  end
, Common.n_RefreshFirefly, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_3_6 , upvalues : self, _ENV
    self:OnRefreshCharacters(DataCommon.Alchemy)
  end
, Common.n_AlchemyRoleChanged, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBuildingWorkState, Common.n_BuildingWorkStateChanged, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBuildingScene, Common.n_BuildingUnlock, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBuildingSceneModel, Common.n_BuildingLevelUp, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, self.OnLightAdd, Common.n_LightAdd, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, self.OnLightRemove, Common.n_LightRemove, nil)
      ;
      (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
    end
  end
end

CourtyardSceneController.CameraTransformChangedChangedCallback = function(self)
  -- function num : 0_4 , upvalues : _ENV, CourtyardSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_CameraTransformChanged, CourtyardSceneController, self)
end

CourtyardSceneController.SetYardFSM = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._yardFSM = (YardFSM.Create)()
  ;
  (self._yardFSM):Init()
  ;
  (self._yardFSM):SetStateEnterCallBack(self.OnStateEnter, self)
  ;
  (self._yardFSM):SetStateExitCallBack(self.OnStateExit, self)
  local sign = ((NekoData.BehaviorManager).BM_Game):GetFastMenuSignFromCourtyard()
  if sign then
    ((NekoData.DataManager).DM_Game):SetFastMenuSignFromCourtyard(nil)
    self:SetCameraAnimatorState(sign)
  end
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
end

CourtyardSceneController.EnterYard = function(self)
  -- function num : 0_6
  self:OnRefreshCharacters()
end

CourtyardSceneController.OnRefreshCharacters = function(self, buildingId)
  -- function num : 0_7 , upvalues : _ENV, TransformStaticFunctions, BoxColiderStaticFunctions, CharacterSize_z, YardCharacter, Light, GetLightPointIndex
  if not buildingId then
    for buildingType,yardCharacters in pairs(self._yardCharacters) do
      for roleKey,yardCharacter in pairs(yardCharacters) do
        yardCharacter:Destroy()
      end
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self._yardCharacters)[buildingType] = nil
    end
    for k,v in pairs(self._bmBuildings) do
      local roleList = v:GetDispatchRoles()
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

      if #roleList > 0 then
        if not (self._yardCharacters)[k] then
          (self._yardCharacters)[k] = {}
        end
        local characterPoint = ((self._sceneRef):GetCharacterPoints())[k]
        local downColliderObject = (TransformStaticFunctions.GetChild)(characterPoint, "Bottom")
        local boundsMin = (BoxColiderStaticFunctions.GetBoundsMin)(downColliderObject)
        local boundsSize = (BoxColiderStaticFunctions.GetBoundsSize)(downColliderObject)
        local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / v:GetDispatchMaxRoleNum()
        local z = boundsMin.z + CharacterSize_z
        for i,roleKey in ipairs(roleList) do
          local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
          local yardCharacter = (YardCharacter.Create)(role:GetId(), "Yard")
          yardCharacter:CreatePlayer(characterPoint)
          yardCharacter:SetClickParam(tostring(k), roleKey)
          yardCharacter:InitZPosition(z)
          z = z + deltaZ
          yardCharacter:LoadBehavior()
          -- DECOMPILER ERROR at PC90: Confused about usage of register: R21 in 'UnsetPending'

          ;
          ((self._yardCharacters)[k])[roleKey] = yardCharacter
        end
      end
    end
  else
    do
      local bm_building = (self._bmBuildings)[buildingId]
      local roleList = bm_building:GetDispatchRoles()
      local yardCharacters = (self._yardCharacters)[buildingId]
      local num = #roleList
      local tag = false
      if (yardCharacters and num ~= (table.nums)(yardCharacters)) or yardCharacters == nil and num > 0 then
        tag = true
      else
        if yardCharacters and num == (table.nums)(yardCharacters) then
          for i,v in ipairs(roleList) do
            if not yardCharacters[v] then
              tag = true
            end
          end
        end
      end
      do
        if tag then
          if yardCharacters then
            for roleKey,yardCharacter in pairs(yardCharacters) do
              yardCharacter:Destroy()
              yardCharacters[roleKey] = nil
            end
          end
          do
            -- DECOMPILER ERROR at PC157: Confused about usage of register: R7 in 'UnsetPending'

            if num > 0 then
              if not (self._yardCharacters)[buildingId] then
                (self._yardCharacters)[buildingId] = {}
              end
              local characterPoint = ((self._sceneRef):GetCharacterPoints())[buildingId]
              local downColliderObject = (TransformStaticFunctions.GetChild)(characterPoint, "Bottom")
              local boundsMin = (BoxColiderStaticFunctions.GetBoundsMin)(downColliderObject)
              local boundsSize = (BoxColiderStaticFunctions.GetBoundsSize)(downColliderObject)
              local deltaZ = (boundsSize.z - 2 * CharacterSize_z) / bm_building:GetDispatchMaxRoleNum()
              local z = boundsMin.z + CharacterSize_z
              for i,roleKey in ipairs(roleList) do
                local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
                local yardCharacter = (YardCharacter.Create)(role:GetId(), "Yard")
                yardCharacter:CreatePlayer(characterPoint)
                yardCharacter:SetClickParam(tostring(buildingId), roleKey)
                yardCharacter:InitZPosition(z)
                z = z + deltaZ
                yardCharacter:LoadBehavior()
                -- DECOMPILER ERROR at PC214: Confused about usage of register: R20 in 'UnsetPending'

                ;
                ((self._yardCharacters)[buildingId])[roleKey] = yardCharacter
              end
            end
            do
              if buildingId == DataCommon.Firefly then
                local num = (table.nums)(self._lights)
                local newNum = (table.nums)(((NekoData.BehaviorManager).BM_Firefly):GetSceneLights())
                if num ~= newNum then
                  for i = 1, self._lightMaxNum do
                    -- DECOMPILER ERROR at PC240: Confused about usage of register: R13 in 'UnsetPending'

                    (self._lightPoints)[i] = false
                  end
                  for k,v in pairs(self._lights) do
                    ((self._lights)[k]):Destroy()
                    -- DECOMPILER ERROR at PC251: Confused about usage of register: R14 in 'UnsetPending'

                    ;
                    (self._lights)[k] = nil
                  end
                  for k,v in pairs(((NekoData.BehaviorManager).BM_Firefly):GetSceneLights()) do
                    local light = (Light.Create)(v, k)
                    local index = GetLightPointIndex(self)
                    -- DECOMPILER ERROR at PC272: Confused about usage of register: R16 in 'UnsetPending'

                    if index then
                      (self._lightPoints)[index] = k
                      light:CreatePlayer(((self._sceneRef)._glowsPoints)[index])
                      light:SetClickParam(k)
                      -- DECOMPILER ERROR at PC282: Confused about usage of register: R16 in 'UnsetPending'

                      ;
                      (self._lights)[k] = light
                    else
                      LogErrorFormat("CourtyardSceneController", "SceneLights num error：=%s (The maximum quantity is = %s)", (table.nums)(((NekoData.BehaviorManager).BM_Firefly):GetSceneLights()), self._lightMaxNum)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

CourtyardSceneController.OnRefreshBuildingWorkState = function(self, notification)
  -- function num : 0_8
  self:RefreshSceneWorkEffect((notification.userInfo).buildingId)
end

CourtyardSceneController.RefreshSceneWorkEffect = function(self, buildingId)
  -- function num : 0_9 , upvalues : _ENV, AnimationHelper
  local bm_building = (self._bmBuildings)[buildingId]
  if bm_building and bm_building:GetLevel() > 0 and type(self._canSetWorkState) == "boolean" then
    local tag = false
    if bm_building:GetWorkState() <= 0 then
      tag = buildingId ~= DataCommon.MagicTree
      if bm_building:GetWorkState() <= 0 then
        tag = buildingId ~= DataCommon.Explore
        if bm_building:GetWorkState() == -1 then
          do
            tag = buildingId ~= DataCommon.Firefly
            if buildingId == DataCommon.Alchemy or buildingId == DataCommon.Cabin then
              tag = true
            end
            if tag then
              (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef):GetBuildingScenes())[buildingId], "work", 1)
            else
              (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef):GetBuildingScenes())[buildingId], "work", 0)
            end
            -- DECOMPILER ERROR: 10 unprocessed JMP targets
          end
        end
      end
    end
  end
end

CourtyardSceneController.OnRefreshBuildingScene = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV, AnimationHelper
  LogInfoFormat("CourtyardSceneController", "------ buildingId = %s -------", (notification.userInfo).buildingId)
  ;
  ((DialogManager.GetGroup)("Modal")):CloseAllDialog()
  local buildingId = (notification.userInfo).buildingId
  local buildingScene = ((self._sceneRef):GetBuildingScenes())[buildingId]
  local bm_building = (self._bmBuildings)[buildingId]
  if buildingId ~= DataCommon.MagicTree then
    self._canSetWorkState = buildingId
    ;
    (AnimationHelper.SetAnimatorInteger2)(buildingScene, "state", 1)
  end
end

CourtyardSceneController.OnRefreshBuildingSceneModel = function(self, notification)
  -- function num : 0_11 , upvalues : CCourtyardLvUpCfg, AnimationHelper, _ENV
  local buildingId = (notification.userInfo).buildingId
  local buildingScene = ((self._sceneRef):GetBuildingScenes())[buildingId]
  local bm_building = (self._bmBuildings)[buildingId]
  local level = bm_building:GetLevel()
  if level > 0 then
    local buildingLvRecord = CCourtyardLvUpCfg:GetRecorder(buildingId + level)
    -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

    if buildingLvRecord and buildingLvRecord.houseState ~= 0 then
      (AnimationHelper.SetAnimatorInteger2)(buildingScene, "level", buildingLvRecord.houseState)
    end
  end
  LogErrorFormat("CourtyardSceneController", "Can not find record by buildingLevel: %s", buildingId + level)
end

CourtyardSceneController.OnLightAdd = function(self, notification)
  -- function num : 0_12 , upvalues : Light, GetLightPointIndex, _ENV
  local protocol = notification.userInfo
  local key = (protocol.light).key
  if not (self._lights)[key] then
    local light = (Light.Create)((protocol.light).itemId, key)
    local index = GetLightPointIndex(self)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    if index then
      (self._lightPoints)[index] = key
      light:CreatePlayer(((self._sceneRef)._glowsPoints)[index])
      light:SetClickParam(key)
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._lights)[key] = light
    else
      LogErrorFormat("CourtyardSceneController", "SceneLights num error：=%s (The maximum quantity is = %s)", (table.nums)(((NekoData.BehaviorManager).BM_Firefly):GetSceneLights()), self._lightMaxNum)
    end
  end
end

CourtyardSceneController.OnLightRemove = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV, YardSceneHelper
  local protocol = notification.userInfo
  if (self._lights)[(protocol.light).key] then
    ((self._lights)[(protocol.light).key]):Destroy()
    local assetBundleName, assetName = (EffectUtil.GetAssetBundleNameAndAssetName)(1030)
    local gameObject = (YardSceneHelper.CreateEffect)(assetBundleName, assetName, (self._sceneRef)._magicTreeCollectLightEffect)
    ;
    (table.insert)(self._lightEffectGameObjects, gameObject)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._lights)[(protocol.light).key] = nil
    for k,v in pairs(self._lightPoints) do
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R11 in 'UnsetPending'

      if v == (protocol.light).key then
        (self._lightPoints)[k] = nil
        break
      end
    end
  end
end

CourtyardSceneController.OnDestroy = function(self)
  -- function num : 0_14 , upvalues : _ENV
  for buildingType,yardCharacters in pairs(self._yardCharacters) do
    for roleKey,yardCharacter in pairs(yardCharacters) do
      yardCharacter:Destroy()
    end
  end
  for k,v in pairs(self._lights) do
    ((self._lights)[k]):Destroy()
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._lights)[k] = nil
  end
  if self._yardSceneCamera then
    (self._yardSceneCamera):SetTransformChangedCallback(nil, self)
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("courtyard.yardmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (DialogManager.DestroySingletonDialog)("yardmusic.playingmusicdialog")
  ;
  (DialogManager.DestroySingletonDialog)("yardmusic.yardmusicdialog")
end

CourtyardSceneController.OnAnimationEvent = function(self, handle, stateName, normalizedTime)
  -- function num : 0_15 , upvalues : _ENV
  self._stateName = stateName
  if stateName ~= "Open" and stateName ~= "TreeOpen" then
    return 
  end
  ;
  ((self._sceneRef):GetCinemachiesAnimator()):SetBool("isOpenedDialog", true)
  ;
  ((self._sceneRef):GetMainCameraAnimator()):SetBool("isOpenedDialog", true)
  local dialog = nil
  if self._state ~= 0 or self._state == 1 then
    LogInfo("CourtyardSceneController", "跳转魔法树")
    dialog = (DialogManager.CreateSingletonDialog)("magictree.magictreedialog")
  else
    if self._state == 2 then
      LogInfo("CourtyardSceneController", "跳转探索")
      dialog = (DialogManager.CreateSingletonDialog)("explore.exploredialog")
    else
      if self._state == 3 then
        LogInfo("CourtyardSceneController", "跳转炼金所")
        dialog = (DialogManager.CreateSingletonDialog)("courtyard.interactmodaldialog")
        dialog:Init(self)
        dialog = (DialogManager.CreateSingletonDialog)("alchemy.alchemydialog")
      else
        if self._state == 5 then
          LogInfo("CourtyardSceneController", "跳转萤火灯台")
          dialog = (DialogManager.CreateSingletonDialog)("firefly.fireflydialog")
        end
      end
    end
  end
  if dialog then
    dialog:Init(self)
  end
end

CourtyardSceneController.OnAnimationStateExitEvent = function(self, handler, stateName, normalizedTime)
  -- function num : 0_16
  if stateName == "Open" then
    local buildingId = self._canSetWorkState
    self._canSetWorkState = true
    self:RefreshSceneWorkEffect(buildingId)
  end
end

CourtyardSceneController.MoveCamera = function(self, xScreenOffset, yScreenOffset)
  -- function num : 0_17 , upvalues : _ENV
  local transform = ((self._sceneRef)._cameraFollowPoint).transform
  transform:Translate(xScreenOffset, yScreenOffset, 0, ((CS.UnityEngine).Space).World)
end

CourtyardSceneController.GetMainCamera = function(self)
  -- function num : 0_18
  return (self._sceneRef):GetMainCamera()
end

CourtyardSceneController.SetCameraAnimatorState = function(self, state)
  -- function num : 0_19 , upvalues : _ENV, CCourtyardLvUpCfg
  if self._state ~= state then
    if (state < 6 and (self._yardFSM):GetParameter("sceneId") ~= 0) or state >= 6 and (self._state ~= 0 or (DialogManager.GetDialog)("yardmusic.yardmusicdialog")) then
      return 
    end
    local lastState = self._state
    if state == 0 then
      (DialogManager.DestroySingletonDialog)("courtyard.interactmodaldialog")
      self._state = state
    else
      if state == 1 then
        self._state = state
      else
        if state == 2 then
          if ((NekoData.BehaviorManager).BM_Explore):GetLevel() > 0 then
            self._state = state
          else
            ;
            ((NekoData.BehaviorManager).BM_Message):SendMessageById(100092, {(CCourtyardLvUpCfg:GetRecorder(DataCommon.Explore + 1)).openCondition})
          end
        else
          if state == 3 then
            if ((NekoData.BehaviorManager).BM_Alchemy):GetLevel() > 0 then
              self._state = state
            else
              ;
              ((NekoData.BehaviorManager).BM_Message):SendMessageById(100092, {(CCourtyardLvUpCfg:GetRecorder(DataCommon.Alchemy + 1)).openCondition})
            end
          else
            if state == 4 then
              if ((NekoData.BehaviorManager).BM_YardMusic):GetLevel() > 0 then
                LogInfo("CourtyardSceneController", "跳转音乐播放器")
                ;
                (DialogManager.CreateSingletonDialog)("yardmusic.yardmusicdialog")
                local jsonStr = (JSON.encode)({eventName = "event", id = "18"})
                ;
                (ThinkingAnalyticsInterface.UploadEvent_TA)(jsonStr)
              else
                do
                  ;
                  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100092, {(CCourtyardLvUpCfg:GetRecorder(DataCommon.YardMusic + 1)).openCondition})
                  if state == 5 then
                    if ((NekoData.BehaviorManager).BM_Firefly):GetLevel() > 0 then
                      self._state = state
                    else
                      ;
                      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100092, {(CCourtyardLvUpCfg:GetRecorder(DataCommon.Firefly + 1)).openCondition})
                    end
                  else
                    if state == 6 then
                      if ((NekoData.BehaviorManager).BM_Cabin):GetLevel() > 0 then
                        LogInfo("CourtyardSceneController", "跳转魔女小屋")
                        ;
                        (self._yardFSM):SetNumber("sceneId", 30008)
                        local jsonStr = (JSON.encode)({eventName = "event", id = "19"})
                        ;
                        (ThinkingAnalyticsInterface.UploadEvent_TA)(jsonStr)
                      else
                        do
                          ;
                          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100092, {(CCourtyardLvUpCfg:GetRecorder(DataCommon.Cabin + 1)).openCondition})
                          if state == 7 then
                            if ((NekoData.BehaviorManager).BM_TrainCamp):GetLevel() > 0 then
                              LogInfo("CourtyardSceneController", "跳转训练所")
                              ;
                              (self._yardFSM):SetNumber("sceneId", 30013)
                            else
                              ;
                              ((NekoData.BehaviorManager).BM_Message):SendMessageById(100092, {(CCourtyardLvUpCfg:GetRecorder(DataCommon.TrainCamp + 1)).openCondition})
                            end
                          end
                          if self._state ~= lastState then
                            if self._state == 0 then
                              ((self._sceneRef):GetCinemachiesAnimator()):SetBool("isOpenedDialog", false)
                              ;
                              ((self._sceneRef):GetMainCameraAnimator()):SetBool("isOpenedDialog", false)
                            end
                            ;
                            ((self._sceneRef):GetCinemachiesAnimator()):SetInteger("Target", state)
                            ;
                            ((self._sceneRef):GetMainCameraAnimator()):SetInteger("Target", state)
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

CourtyardSceneController.BeginZoomScene = function(self, scale)
  -- function num : 0_20 , upvalues : _ENV
  self:MoveCamera(0, 0)
  self._lastFOV = (((((CS.PixelNeko).Lua).Cinemachine).CinemachineVirtualCameraStaticFunctions).GetFOV)((self._sceneRef):GetCinemachineStart())
end

CourtyardSceneController.ZoomScene = function(self, scale)
  -- function num : 0_21 , upvalues : BoxColiderStaticFunctions, _ENV
  local curFOV = self._lastFOV / scale
  if curFOV < self._minFOV then
    curFOV = self._minFOV
    ;
    (BoxColiderStaticFunctions.SetSize)((self._sceneRef)._cameraBorder, (self._maxBorder).x, (self._maxBorder).y, self._boxColliderZ)
  else
    if self._maxFOV < curFOV then
      curFOV = self._maxFOV
      ;
      (BoxColiderStaticFunctions.SetSize)((self._sceneRef)._cameraBorder, (self._minBorder).x, (self._minBorder).y, self._boxColliderZ)
    else
      ;
      (self._borderBoxColiderSizeTween):reset()
      ;
      (self._borderBoxColiderSizeTween):update(curFOV - self._minFOV)
      ;
      (BoxColiderStaticFunctions.SetSize)((self._sceneRef)._cameraBorder, ((self._borderBoxColiderSizeTween).subject).x, ((self._borderBoxColiderSizeTween).subject).y, self._boxColliderZ)
    end
  end
  ;
  (((((CS.PixelNeko).Lua).Cinemachine).CinemachineVirtualCameraStaticFunctions).SetFOV)((self._sceneRef):GetCinemachineStart(), curFOV)
end

CourtyardSceneController.GetBuildingSizeAndPos = function(self, buildingId)
  -- function num : 0_22 , upvalues : BoxColiderStaticFunctions, UIManager, _ENV
  local buildingObject = ((self._sceneRef):GetBuildingScenes())[buildingId]
  local posMin = (BoxColiderStaticFunctions.GetBoundsMin)(buildingObject)
  local minScreenPos_x, minScreenPos_y = (UIManager.WorldToScreenPointInMargin)("Main", posMin.x, posMin.y, posMin.z)
  local minLocalPos_x, minLocalPos_y = (UIManager.ScreenPointToLocalPointInRectangle)(nil, minScreenPos_x, minScreenPos_y)
  local posMax = (BoxColiderStaticFunctions.GetBoundsMax)(buildingObject)
  local maxScreenPos_x, maxScreenPos_y = (UIManager.WorldToScreenPointInMargin)("Main", posMax.x, posMax.y, posMax.z)
  local maxLocalPos_x, maxLocalPos_y = (UIManager.ScreenPointToLocalPointInRectangle)(nil, maxScreenPos_x, maxScreenPos_y)
  local width = (math.abs)(maxLocalPos_x - minLocalPos_x)
  local height = (math.abs)(maxLocalPos_y - minLocalPos_y)
  local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)(nil, (UIManager.WorldToScreenPointInMargin)("Main", (BoxColiderStaticFunctions.GetBoundsCenter)(buildingObject)))
  return {width = width, height = height, posX = posX, posY = posY}
end

CourtyardSceneController.GetSizeAndPos = function(self, lightObject_1)
  -- function num : 0_23 , upvalues : BoxColiderStaticFunctions, UIManager, _ENV
  local posMin = (BoxColiderStaticFunctions.GetBoundsMin)(lightObject_1)
  local minScreenPos_x, minScreenPos_y = (UIManager.WorldToScreenPointInMargin)("Main", posMin.x, posMin.y, posMin.z)
  local minLocalPos_x, minLocalPos_y = (UIManager.ScreenPointToLocalPointInRectangle)(nil, minScreenPos_x, minScreenPos_y)
  local posMax = (BoxColiderStaticFunctions.GetBoundsMax)(lightObject_1)
  local maxScreenPos_x, maxScreenPos_y = (UIManager.WorldToScreenPointInMargin)("Main", posMax.x, posMax.y, posMax.z)
  local maxLocalPos_x, maxLocalPos_y = (UIManager.ScreenPointToLocalPointInRectangle)(nil, maxScreenPos_x, maxScreenPos_y)
  local width = (math.abs)(maxLocalPos_x - minLocalPos_x)
  local height = (math.abs)(maxLocalPos_y - minLocalPos_y)
  local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)(nil, (UIManager.WorldToScreenPointInMargin)("Main", (BoxColiderStaticFunctions.GetBoundsCenter)(lightObject_1)))
  return {width = width, height = height, posX = posX, posY = posY}
end

CourtyardSceneController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_24 , upvalues : CourtyardSceneController, _ENV
  ((CourtyardSceneController.super).Update)(self, deltaTime, unscaleDeltaTime)
  if self._yardFSM then
    (self._yardFSM):Update()
    ;
    ((require("logic.fsm.yardfsm." .. (string.lower)((self._yardFSM):GetCurrentState()))).Update)(self)
  end
end

CourtyardSceneController.OnStateEnter = function(self, currentState, lastState)
  -- function num : 0_25 , upvalues : _ENV
  ((require("logic.fsm.yardfsm." .. (string.lower)(currentState))).OnEnter)(self, lastState)
end

CourtyardSceneController.OnStateExit = function(self, currentState, nextState)
  -- function num : 0_26 , upvalues : _ENV
  ((require("logic.fsm.yardfsm." .. (string.lower)(currentState))).OnExit)(self, nextState)
end

do return CourtyardSceneController end
-- DECOMPILER ERROR: 1 unprocessed JMP targets

