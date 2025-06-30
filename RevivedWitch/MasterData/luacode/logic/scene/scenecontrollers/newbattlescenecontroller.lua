-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/newbattlescenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleSceneHelper = ((((CS.PixelNeko).P1).Scene).Battle).BattleSceneHelper
local EventTriggerHelper = (((CS.PixelNeko).P1).TimeLine).EventTriggerHelper
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local TimeSkillStaticFunctions = ((CS.PixelNeko).Lua).TimeSkillStaticFunctions
local GameObjectHelper = ((CS.PixelNeko).Common).GameObjectHelper
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local Queue = require("framework.queue")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local BattleWorld = require("logic.newbattle.battleworld")
local SoulTask = require("logic.scene.types.soultask")
local LuaCodeVersionManager = require("logic.manager.luacodeversionmanager")
local SystemType = require("protocols.bean.protocol.common.systemtype")
local codeVersionFile = require("protocols.def.protocol.battle.cbattleend")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local BattleResultType = require("protocols.bean.protocol.battle.battleresult")
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CRoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkillBehaviorTable = (BeanManager.GetTableByName)("skill.cskillbehavior")
local CBattleConfig = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CSkillEffectTable = (BeanManager.GetTableByName)("skill.cskilleffect")
local CBuffEffectTable = (BeanManager.GetTableByName)("buff.cbuffeffect")
local CBattleGuideLinkConfig = (BeanManager.GetTableByName)("guide.cbattleguidelinkconfig")
local SoundLevelTable = (BeanManager.GetTableByName)("setting.csoundlevel")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CResourceDungeonStageDialog = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstagedialog")
local CBattleSceneCfg = (BeanManager.GetTableByName)("scene.cbattlescenecfg")
local CBeatMelonConfig = (BeanManager.GetTableByName)("activity.cbeatmelonconfig")
local SRoleCreate = (BattleClientProtocolManager.GetProtocolDef)("action.srolecreate")
local SRoleChangeShapeAndAttribute = (BattleClientProtocolManager.GetProtocolDef)("action.srolechangeshapeandattribute")
local SRoleSummon = (BattleClientProtocolManager.GetProtocolDef)("action.srolesummoncreate")
local BattleEndType = (BattleClientProtocolManager.GetBeanDef)("data.battleendtype")
local Enum_Camp = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
local LineUpStation = (BattleClientProtocolManager.GetBeanDef)("data.lineupstation")
local CSRChallengeBattle = (BeanManager.GetTableByName)("activity.csrchallengebattle")
local NewBattleSceneController = class("NewBattleSceneController", SceneController)
local AnimatorListTypeEnum = {EMengAnimator = 1}
NewBattleSceneController.Ctor = function(self, sceneRef)
  -- function num : 0_0 , upvalues : NewBattleSceneController, Queue, _ENV
  ((NewBattleSceneController.super).Ctor)(self, sceneRef)
  self._bsc_localProtocolData = (Queue.Create)()
  self._bsc_battleWorld = nil
  self._bsc_battleStartProtocol = nil
  self._bsc_battleEndProtocol = nil
  self._bsc_battleStepTimeCount = 0
  self._bsc_stepNum = 0
  self._bsc_battleResult = 0
  self._bsc_soulTasks = 0
  self._bsc_battleTimeLine = false
  self._bsc_battleFSM = nil
  self._bsc_awardDialogKey = 0
  self._nextSceneId = 0
  self._bsc_leftSoulBattlerId = 0
  self._bsc_rightSoulBattlerId = 0
  self._bsc_isUsePartner = 0
  self._sendprotocolList = {}
  self._bsc_deltaTime_count = nil
  self._bsc_battleTime = 0
  self._bsc_upBattleTime = 0
  self._bsc_battleGuideTag = {}
  self._bsc_ifOneBattleHasSendCBattleEnd = false
  self._alternateRoleEnterTask = {}
  self._actorTimeSkillChangeValueTask = {timeCount = nil, 
dataValue = {}
, isOver = false}
  self._bsc_animatorGroup = {}
  self._bsc_battleCameraAnimationInfo = {cameraMoveType, moveDelayTime, resetDelayTime, currentTime, skillId}
  self._bsc_battleNewMainUIActiveState = false
  self._bsc_canEnterAccountsState = false
  self._bsc_isBossViolent = false
end

NewBattleSceneController.Init = function(self)
  -- function num : 0_1 , upvalues : NewBattleSceneController, _ENV, CBattleSceneCfg, StateEventTriggerHelper, EventTriggerHelper, SoundLevelTable, AnimatorListTypeEnum, AnimatorStaticFunctions
  ((NewBattleSceneController.super).Init)(self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.BSC_OnBattleAwardDialogClosed, Common.n_DialogWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  local battleSceneCfgRecorder = CBattleSceneCfg:GetRecorder(self:GetSceneID())
  if battleSceneCfgRecorder and battleSceneCfgRecorder.hasBulletTime == 1 then
    if not (self._sceneRef):BSR_GetEndTimeLineTransform() then
      LogWarning("NewBattleSceneController", "Maybe There is no End Camera Parameter for Bullet Time")
    end
    self._bsc_canWaitingForEndTimeline = true
    ;
    (StateEventTriggerHelper.AddAnimationEventListener)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "CameraBlendKill", self.OnEndBattleCameraAnimation, self)
  else
    self._bsc_canWaitingForEndTimeline = false
    LogInfoFormat("NewBattleSceneController", "CBattleSceneCfg中无场景 %s 子弹时间配置或配置为不需要子弹时间", self:GetSceneID())
  end
  self._bsc_hasStartBattleLogic = false
  if battleSceneCfgRecorder and battleSceneCfgRecorder.alwaysenterbattle == 1 then
    self._bsc_timerForceStartBattle = true
  else
    self._bsc_timerForceStartBattle = false
    LogInfoFormat("NewBattleSceneController", "CBattleSceneCfg中无场景 %s 强制定时进入战斗或配置为不要强制定时进入战斗", self:GetSceneID())
  end
  if (self._sceneRef):BSR_GetStartTimeLineTransform() then
    self._bsc_canWaitingForStartTimeline = true
    ;
    (EventTriggerHelper.AddTriggerBehaviourPlayListener)((self._sceneRef):BSR_GetStartTimeLineTransform(), self.OnStartTriggerBehaviourPlay, self)
  else
    self._bsc_canWaitingForStartTimeline = false
  end
  local categoryRecord = SoundLevelTable:GetRecorder(4)
  if categoryRecord then
    (LuaAudioManager.PauseCategory)(tonumber(categoryRecord.categoryID), false)
  end
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._bsc_animatorGroup)[AnimatorListTypeEnum.EMengAnimator] = (AnimatorStaticFunctions.Get)((self._sceneRef):BSR_GetEMengAnimatorGameObject())
  self._bsc_battlePosList = {}
  local posFile = require("data.battledata.scenepos." .. (string.lower)(self:GetSceneName()))
  for i = 1, #posFile do
    local currentIndexPos = posFile[i]
    local x, y, z = currentIndexPos.x, currentIndexPos.y, currentIndexPos.z
    -- DECOMPILER ERROR at PC150: Confused about usage of register: R12 in 'UnsetPending'

    if x and y and z then
      (self._bsc_battlePosList)[i] = {x = fixedpoint(x) * 1000, y = fixedpoint(y) * 1000, z = fixedpoint(z) * 1000}
    else
      LogErrorFormat("NewBattleSceneController", "pos index %s get x %s y %s z %s", R15_PC159, x, y, z)
    end
  end
  if (self._sceneRef):BSR_GetBattleCamera() then
    (StateEventTriggerHelper.AddStateEnterListener)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, self.BSR_OnBattleCameraStateEnter, self)
  end
end

NewBattleSceneController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_2 , upvalues : _ENV, SystemType, AnimationHelper, TransformStaticFunctions
  if self._bsc_deltaTime_count then
    if unscaleDeltaTime > 0.05 then
      self._bsc_deltaTime_count = self._bsc_deltaTime_count + 1
    else
      self._bsc_deltaTime_count = 0
    end
    if self._bsc_deltaTime_count >= 5 then
      local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
      self._bsc_deltaTime_count = nil
      if plat ~= SystemType.UNITY then
        local csend = (LuaNetManager.CreateProtocol)("protocol.user.crecordlowframebattle")
        csend.fps = 1 / unscaleDeltaTime
        csend.roles = ""
        local strResult = ""
        local leftBattlers = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()
        for _,battler in pairs(leftBattlers) do
          local x, y, z = battler:GetPosition()
          strResult = strResult .. tostring(battler:GetConfigId()) .. "@[x" .. tostring(x) .. ",y" .. tostring(y) .. ",z" .. tostring(z) .. "]"
          csend.roles = csend.roles .. strResult
          strResult = ","
        end
        strResult = ","
        local rightBattlers = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()
        for _,battler in pairs(rightBattlers) do
          local x, y, z = battler:GetPosition()
          strResult = strResult .. tostring(battler:GetConfigId()) .. "@[x" .. tostring(x) .. ",y" .. tostring(y) .. ",z" .. tostring(z) .. "]"
          csend.roles = csend.roles .. strResult
          strResult = ","
        end
        csend.effect = ""
        strResult = ""
        local effectCount = ((((((CS.PixelNeko).P1).Scene).Battle).BattleSceneHelper).GetEffectCount)()
        for key,value in pairs(effectCount) do
          strResult = strResult .. tostring(key) .. "@" .. tostring(value)
          csend.effect = csend.effect .. strResult
          strResult = ","
        end
        csend:Send()
      end
    end
  end
  do
    if self._bsc_battleFSM and GlobalGameFSM and GlobalGameFSM:GetCurrentState() ~= "Init" then
      (self._bsc_battleFSM):Update()
      ;
      ((require("logic.fsm.battlefsm." .. (string.lower)((self._bsc_battleFSM):GetCurrentState()))).Update)(self, deltaTime)
    else
      self._bsc_battleFSM = nil
    end
    if self._bsc_canPlayStartTimeline then
      self._bsc_canPlayStartTimeline = false
      if (self._sceneRef):BSR_GetStartTimeLine() then
        (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "camState", 0)
        ;
        ((self._sceneRef):BSR_GetStartTimeLine()):Play()
        if self._bsc_timerForceStartBattle then
          if self._bsc_battleStartTimeTask then
            (GameTimer.RemoveTask)(self._bsc_battleStartTimeTask)
            self._bsc_battleStartTimeTask = nil
          end
          self._bsc_battleStartTimeTask = (GameTimer.AddTask)(2.5, -1, function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    self._bsc_hasStartBattleLogic = true
    LogInfo("NewBattleSceneController", "_bsc_battleStartTimeTask time bingo")
    self:BSC_BeginUpdateBattleWorld()
    local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
    if dialog then
      (dialog:GetRootWindow()):SetAlpha(1)
      self._bsc_battleNewMainUIActiveState = true
    end
  end
)
        end
      end
    end
    for entityId,v in pairs(self._alternateRoleEnterTask) do
      if (v.task):update(deltaTime) then
        local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(entityId)
        if battler and battler:IsAlive() then
          battler:PlayAnimation("BattleIdle")
        end
        ;
        (TransformStaticFunctions.SetPosition)(v.gameObject, v.x, v.y, v.z)
        -- DECOMPILER ERROR at PC239: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self._alternateRoleEnterTask)[entityId] = nil
      else
        do
          do
            ;
            (TransformStaticFunctions.SetPosition)(v.gameObject, ((v.task).subject).pos, v.y, v.z)
            -- DECOMPILER ERROR at PC249: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC249: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC249: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

NewBattleSceneController.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : NewBattleSceneController, _ENV, TimeSkillStaticFunctions
  ((NewBattleSceneController.super).OnDestroy)(self)
  if self._bsc_battleStartTimeTask then
    (GameTimer.RemoveTask)(self._bsc_battleStartTimeTask)
    self._bsc_battleStartTimeTask = nil
  end
  ;
  (TimeSkillStaticFunctions.RemoveTimeSkill)((self._sceneRef):BSR_GetBattleMainCamera())
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.battlecrossdialog")
  ;
  (DialogManager.DestroySingletonDialog)("newbattle.battlenewmaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("debug.battlegmdialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.teamtestgmdialog")
  ;
  ((NekoData.DataManager).DM_Battle):Clear()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

NewBattleSceneController.BSC_OnBattleAwardDialogClosed = function(self, notification)
  -- function num : 0_4
  if (notification.userInfo)._dialogKey == self._bsc_awardDialogKey then
    (self._bsc_battleFSM):SetBoolean("toBattleEnd", true)
  end
end

NewBattleSceneController.OnNPCChatEnd = function(self, notification)
  -- function num : 0_5
  if notification.userInfo == self._battle_pause_chatId then
    (self._bsc_battleFSM):SetBoolean("chatDialogEnd", true)
  else
    if notification.userInfo == self._bsc_resourceBattleEndDialogId then
      (self._bsc_battleFSM):SetBoolean("toAccounts", true)
      self._bsc_resourceBattleEndDialogId = nil
    end
  end
end

NewBattleSceneController.BSC_GetStepNum = function(self)
  -- function num : 0_6
  return self._bsc_stepNum
end

NewBattleSceneController.BSC_InitBattleScene = function(self, battleId, battleType)
  -- function num : 0_7 , upvalues : _ENV
  (((((CS.PixelNeko).Lua).Cinemachine).CinemachineVirtualCameraStaticFunctions).SetPriority)((self._sceneRef)._bsr_startCamera, 10)
  ;
  (((((CS.PixelNeko).Lua).Cinemachine).CinemachineVirtualCameraStaticFunctions).SetPriority)((self._sceneRef)._bsr_victoryCamera, 0)
  self._bsc_battleStepTimeCount = 0
  self._bsc_battleTime = 0
  self._bsc_stepNum = 0
  ;
  ((NekoData.DataManager).DM_Battle):Clear()
  ;
  ((NekoData.DataManager).DM_Battle):SetBattleId(battleId, self, battleType)
  self._bsc_soulTasks = 0
  self._bsc_ifOneBattleHasSendCBattleEnd = false
  self._bsc_battleFSM = (BattleFSM.Create)()
  ;
  (self._bsc_battleFSM):Init()
  ;
  (self._bsc_battleFSM):SetStateEnterCallBack(self.BSC_OnStateEnter, self)
  ;
  (self._bsc_battleFSM):SetStateExitCallBack(self.BSC_OnStateExit, self)
end

NewBattleSceneController.BSC_OnStateEnter = function(self, currentState, lastState)
  -- function num : 0_8 , upvalues : _ENV
  if self._bsc_battleFSM then
    ((require("logic.fsm.battlefsm." .. (string.lower)((self._bsc_battleFSM):GetCurrentState()))).OnEnter)(self, lastState)
  end
end

NewBattleSceneController.BSC_OnStateExit = function(self, currentState, nextState)
  -- function num : 0_9 , upvalues : _ENV
  if self._bsc_battleFSM then
    ((require("logic.fsm.battlefsm." .. (string.lower)((self._bsc_battleFSM):GetCurrentState()))).OnExit)(self, nextState)
  end
end

local OnSBattleStart = function(self, protocol)
  -- function num : 0_10 , upvalues : _ENV
  self._sendprotocolList = {}
  self:BSC_InitBattleScene(protocol.battleid, protocol.battleType)
  self._bsc_battleStartProtocol = protocol
  ;
  ((NekoData.DataManager).DM_Battle):SetAutoBattleInfo(protocol.auto)
  self:BSC_InitBattle()
  LogInfoFormat("NewBattleSceneController", "-OnSBattleStart- autoFight = %s, orderSKill.roleId = %s, orderSKill.skillId = %s, disorderSkill.roleId = %s, disorderSkill.skillId = %s ---", (protocol.auto).autoFight, ((protocol.auto).orderSKill).roleId, ((protocol.auto).orderSKill).skillId, ((protocol.auto).disorderSkill).roleId, ((protocol.auto).disorderSkill).skillId)
  LogInfo("NewBattleSceneController", "eruptSkill List---------")
  for roleId,skillId in pairs((protocol.auto).eruptSkill) do
    LogInfoFormat("NewBattleSceneController", "roleid %s skillid %s", roleId, skillId)
  end
end

NewBattleSceneController.OnStartTriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_11 , upvalues : _ENV, OnSBattleStart
  if stringValue == "CreateRole" then
    LogInfo("NewBattleSceneController", "OnStartTriggerBehaviourPlay CreateRole")
    local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
    OnSBattleStart(self, protocol)
  else
    do
      if stringValue == "Start" then
        if self._bsc_battleStartTimeTask then
          (GameTimer.RemoveTask)(self._bsc_battleStartTimeTask)
          self._bsc_battleStartTimeTask = nil
        end
        LogInfoFormat("NewBattleSceneController", "OnStartTriggerBehaviourPlay Start self._bsc_hasStartBattleLogic %s", self._bsc_hasStartBattleLogic)
        if not self._bsc_hasStartBattleLogic then
          self:BSC_BeginUpdateBattleWorld()
          local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
          if dialog then
            (dialog:GetRootWindow()):SetAlpha(1)
            self._bsc_battleNewMainUIActiveState = true
          end
        end
      end
    end
  end
end

NewBattleSceneController.BSC_InitBattle = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self._bsc_battleNewMainUIActiveState = false
  self:BSC_BeginCreatePlayer()
  if self._bsc_canWaitingForStartTimeline and not self._bsc_battleReconnectState then
    LogInfo("NewBattleSceneController", "Waiting for battle start timeline")
    local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
    if dialog then
      (dialog:GetRootWindow()):SetAlpha(0)
    else
      self._bsc_battleNewMainUIActiveState = true
    end
  else
    do
      self:BSC_BeginUpdateBattleWorld()
      self._bsc_battleNewMainUIActiveState = true
    end
  end
end

NewBattleSceneController.BSC_BeginCreatePlayer = function(self)
  -- function num : 0_13 , upvalues : _ENV, BattleWorld, LineUpStation, CBattleStartProtocol, CBattleGuideLinkConfig, CRoleConfigTable
  self._bsc_upBattleTime = (self._bsc_battleStartProtocol).battleDuration
  self._bsc_deltaTime_count = 0
  local Enum_Camp = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
  ;
  (self._bsc_localProtocolData):Clear()
  LogInfoFormat("NewBattleSceneController", "battleid %s guide %s battleDuration %s", (self._bsc_battleStartProtocol).battleid, (self._bsc_battleStartProtocol).guide, self._bsc_upBattleTime)
  if self._bsc_battleWorld then
    (self._bsc_battleWorld):Destroy()
  end
  self._bsc_battleWorld = (BattleWorld.Create)(function(protocol)
    -- function num : 0_13_0 , upvalues : self
    self:BSC_SendProtocolToViewController(protocol)
  end
, (self._bsc_battleStartProtocol).battleid, self._id, (self._bsc_battleStartProtocol).battleBuffs, self._bsc_battlePosList)
  ;
  (self._bsc_battleWorld):SetAssistData((self._bsc_battleStartProtocol).assist)
  ;
  (self._bsc_battleWorld):SetRandomSeed((self._bsc_battleStartProtocol).seed)
  local stationNumList = {LineUpStation.FRONT_ROW, LineUpStation.MIDDLE_ROW, LineUpStation.BACK_ROW}
  local initialTagType = {Not = 0, Is = 1}
  local leftRoleList = {}
  local leftAllRoleList = {}
  for _,i in ipairs(stationNumList) do
    local fighter = ((self._bsc_battleStartProtocol).left)[i]
    local alternateFighter, alternateI = nil, nil
    if i == LineUpStation.FRONT_ROW then
      alternateI = LineUpStation.ALTERNATE_FRONT_ROW
      alternateFighter = ((self._bsc_battleStartProtocol).left)[alternateI]
    else
      if i == LineUpStation.MIDDLE_ROW then
        alternateI = LineUpStation.ALTERNATE_MIDDLE_ROW
        alternateFighter = ((self._bsc_battleStartProtocol).left)[alternateI]
      else
        if i == LineUpStation.BACK_ROW then
          alternateI = LineUpStation.ALTERNATE_BACK_ROW
          alternateFighter = ((self._bsc_battleStartProtocol).left)[alternateI]
        end
      end
    end
    if fighter then
      LogInfoFormat("newbattlescenecontroller", "left role id %s", fighter.id)
      ;
      (table.insert)(leftRoleList, fighter.id)
      ;
      (table.insert)(leftAllRoleList, fighter.id)
      local fighterBean = (self:BSC_InitServerPlayer(Enum_Camp.LeftFighter, i, fighter, alternateFighter ~= nil))
      local alternateFighterBean = nil
      if alternateFighter and alternateI then
        (table.insert)(leftAllRoleList, alternateFighter.id)
        LogInfoFormat("NewBattleSceneController", "alternateleft role id %s", alternateFighter.id)
        alternateFighterBean = self:BSC_InitServerPlayer(Enum_Camp.LeftFighter, alternateI, alternateFighter)
      end
      ;
      (self._bsc_battleWorld):CreateLeftPlayer(fighterBean, {alternateFighterBean = alternateFighterBean, isInitial = initialTagType.Is})
    end
  end
  for i = 1, 5 do
    local fighter = ((self._bsc_battleStartProtocol).right)[i]
    if fighter then
      LogInfoFormat("NewBattleSceneController", "right role id %s", fighter.id)
      local fighterBean = self:BSC_InitServerPlayer(Enum_Camp.RightFighter, i, fighter)
      ;
      (self._bsc_battleWorld):CreateRightPlayer(fighterBean, {isInitial = initialTagType.Is})
    end
  end
  local dialog = (DialogManager.CreateSingletonDialog)("newbattle.battlenewmaindialog")
  if dialog then
    dialog:SetBattleWorld(self._bsc_battleWorld)
    local battleId = (self._bsc_battleStartProtocol).battleid
    if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AssistBattle) and battleId ~= 1120 and battleId ~= 1122 and (self._bsc_battleStartProtocol).assist and ((self._bsc_battleStartProtocol).assist).id ~= 0 and (self._bsc_battleStartProtocol).battleType ~= CBattleStartProtocol.BOSS_RUSH and (self._bsc_battleStartProtocol).battleType ~= CBattleStartProtocol.WEEK_BOSS and (self._bsc_battleStartProtocol).battleType ~= CBattleStartProtocol.TEST then
      LogInfoFormat("NewBattleSceneController", "assistroleid %s leftAssistNum %s totalAssistNum %s", ((self._bsc_battleStartProtocol).assist).id, (self._bsc_battleStartProtocol).leftAssistNum, (self._bsc_battleStartProtocol).totalAssistNum)
      dialog:AddAssistRole((self._bsc_battleStartProtocol).assist, (self._bsc_battleStartProtocol).leftAssistNum, (self._bsc_battleStartProtocol).totalAssistNum)
    end
    if battleId == 1184 then
      (DialogManager.CreateSingletonDialog)("teamedit.teamtestgmdialog")
    end
  end
  if (self._bsc_battleStartProtocol).guide ~= 0 then
    (LuaNotificationCenter.PostNotification)(Common.n_InBattleGuide, self, (CBattleGuideLinkConfig:GetRecorder((self._bsc_battleStartProtocol).guide)).time)
  end
  local leftLineupList = {}
  leftLineupList.element = {}
  leftLineupList.vocation = {}
  for _,id in ipairs(leftAllRoleList) do
    local recorder = CRoleConfigTable:GetRecorder(id)
    -- DECOMPILER ERROR at PC287: Confused about usage of register: R14 in 'UnsetPending'

    if recorder then
      if (leftLineupList.element)[recorder.element] then
        (leftLineupList.element)[recorder.element] = (leftLineupList.element)[recorder.element] + 1
      else
        -- DECOMPILER ERROR at PC291: Confused about usage of register: R14 in 'UnsetPending'

        (leftLineupList.element)[recorder.element] = 1
      end
      -- DECOMPILER ERROR at PC303: Confused about usage of register: R14 in 'UnsetPending'

      if (leftLineupList.vocation)[recorder.vocation] then
        (leftLineupList.vocation)[recorder.vocation] = (leftLineupList.vocation)[recorder.vocation] + 1
      else
        -- DECOMPILER ERROR at PC307: Confused about usage of register: R14 in 'UnsetPending'

        (leftLineupList.vocation)[recorder.vocation] = 1
      end
    else
      LogErrorFormat("NewBattleSceneController", "No Exist croleconfig ID: %s", id)
    end
  end
  ;
  (self._bsc_battleWorld):SetLeftLineupInfo(leftLineupList)
  ;
  (self._bsc_battleWorld):SetWorldState("start")
  ;
  (self._bsc_battleWorld):UpdataZero()
  self:BSC_UpdateLocalProtocol()
  self:PlayBattleStartVoice(leftRoleList)
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

NewBattleSceneController.BSC_BeginUpdateBattleWorld = function(self)
  -- function num : 0_14
  (self._bsc_battleFSM):SetBoolean("toBattle", true)
  ;
  (self._bsc_battleFSM):Update()
end

NewBattleSceneController.PlayBattleStartVoice = function(self, leftRoleList)
  -- function num : 0_15 , upvalues : _ENV
  local roleList = leftRoleList
  if #roleList == 0 then
    LogError("NewBattleSceneController", "there is no role in battle fighter list, play battlestart voice failed")
  else
    local i = (math.random)(1, #roleList)
    ;
    ((NekoData.BehaviorManager).BM_Voice):PlayBattleVoice(roleList[i], (((NekoData.BehaviorManager).BM_Voice).VoiceType).BattleStart, nil)
  end
end

NewBattleSceneController.BSC_UpdateBattleLogic = function(self, deltaTime)
  -- function num : 0_16 , upvalues : _ENV, CBattleStartProtocol, CBeatMelonConfig, BattleEndType
  self._bsc_battleStepTimeCount = self._bsc_battleStepTimeCount + deltaTime
  self._bsc_battleTime = self._bsc_battleTime + deltaTime
  if self._bsc_upBattleTime < self._bsc_battleTime then
    self._bsc_battleTime = 0
    local protocol = (BattleClientProtocolManager.CreateProtocol)("action.cbattlekill")
    local isSummerActivityTimeBattle = false
    local battleProtocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
    if battleProtocol.battleType == CBattleStartProtocol.SUMMER and (table.contain)(CBeatMelonConfig:GetAllIds(), battleProtocol.id) then
      isSummerActivityTimeBattle = true
    end
    local isSpringBattle = false
    if battleProtocol.battleType == CBattleStartProtocol.SPRING_FESTIVAL then
      isSpringBattle = true
    end
    local isAnniversaryLimitedBattle = false
    if battleProtocol.battleType == CBattleStartProtocol.ANNIVERSARY and ((NekoData.BehaviorManager).BM_Anniversary):IsDailyBossLevel(battleProtocol.id) then
      isAnniversaryLimitedBattle = true
    end
    if isSummerActivityTimeBattle or isSpringBattle or isAnniversaryLimitedBattle then
      protocol.type = BattleEndType.LeftWinOverTime
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100113)
      protocol.type = BattleEndType.RightWinOverTime
    end
    self:BSC_SendProtocolToLogicWorld(protocol)
  end
  do
    while self._bsc_battleStepTimeCount >= 0.033333333333333 do
      self._bsc_battleStepTimeCount = self._bsc_battleStepTimeCount - 0.033333333333333
      if (self._bsc_battleFSM):GetCurrentState() ~= "Battle" or not self._bsc_battleTimeLine then
        self:BSC_UpdateBattleLogicOneStep()
      end
    end
  end
end

NewBattleSceneController.BSC_BattleLogicEnd = function(self)
  -- function num : 0_17
  self:BSC_DestroyBattleWorld()
end

NewBattleSceneController.BSC_DestroyBattleWorld = function(self)
  -- function num : 0_18 , upvalues : _ENV
  ((NekoData.DataManager).DM_Battle):ClearProjectileEffects()
  ;
  ((NekoData.DataManager).DM_Battle):ClearSceneEffects()
  ;
  (self._bsc_battleWorld):Destroy()
  self._bsc_battleWorld = nil
end

NewBattleSceneController.BSC_SendBattleEndProtocol = function(self)
  -- function num : 0_19 , upvalues : _ENV, CBattleStartProtocol, BattleEndType, Enum_Camp, codeVersionFile, LuaCodeVersionManager
  if self._bsc_battleStartProtocol then
    local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.cbattleend")
    if (self._bsc_battleStartProtocol).battleType == CBattleStartProtocol.TOWER or (self._bsc_battleStartProtocol).battleType == CBattleStartProtocol.ANNIVERSARY then
      for k,v in pairs(((NekoData.BehaviorManager).BM_Battle):GetEnemySideRolesInfo()) do
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

        if v.key > 0 then
          (req.enemyStatuses)[v.key] = (LuaNetManager.CreateBean)("protocol.battle.status")
          if (self._bsc_battleStartProtocol).battleType == CBattleStartProtocol.ANNIVERSARY and v.hpmax < v.hp then
            v.hp = v.hpmax
          end
          -- DECOMPILER ERROR at PC65: Confused about usage of register: R8 in 'UnsetPending'

          if (self._bsc_battleStartProtocol).battleType == CBattleStartProtocol.ANNIVERSARY then
            ((req.enemyStatuses)[v.key]).leftHp = (math.ceil)(v.hp / v.hpmax * 100)
          else
            -- DECOMPILER ERROR at PC77: Confused about usage of register: R8 in 'UnsetPending'

            ;
            ((req.enemyStatuses)[v.key]).leftHp = (math.floor)(v.hp / v.hpmax * 100)
          end
          LogInfoFormat("NewBattleSceneController", "cbattleend enemyStatuses key %s roleid %s hp %s", v.key, v.id, v.hp)
        end
      end
    end
    do
      req.battletype = (self._bsc_battleStartProtocol).battleType
      req.id = (self._bsc_battleStartProtocol).id
      if BattleEndType.LeftWin == self._bsc_battleResult then
        req.result = req.BATTLE_SUCCESS
        if self._bsc_hasUsedGM then
          req.result = req.BATTLE_SUCCESS_GM
        end
      else
        if BattleEndType.RightWin == self._bsc_battleResult then
          req.result = req.BATTLE_FAIL
          if self._bsc_hasUsedGM then
            req.result = req.BATTLE_FAIL_GM
          end
        else
          if BattleEndType.Retreat == self._bsc_battleResult then
            req.result = req.BATTLE_RETREAT
          else
            if BattleEndType.Drawn == self._bsc_battleResult then
              req.result = req.BATTLE_TIE
            else
              if BattleEndType.LeftWinCBattleKill == self._bsc_battleResult then
                req.result = req.BATTLE_SUCCESS_GM
              else
                if BattleEndType.SkipWin == self._bsc_battleResult then
                  req.result = req.BATTLE_SUCCESS_SKIP
                else
                  if BattleEndType.RightWinCBattleKill == self._bsc_battleResult then
                    req.result = req.BATTLE_FAIL_GM
                  else
                    if BattleEndType.RightWinOverTime == self._bsc_battleResult then
                      req.result = req.BATTLE_FAIL_TIMEOUT
                    else
                      if BattleEndType.LeftWinOverTime == self._bsc_battleResult then
                        req.result = req.BATTLE_SUCCESS_TIMEOUT
                      else
                        if BattleEndType.LoseSettle == self._bsc_battleResult then
                          req.result = req.BATTLE_SETTLE
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
      for k,v in pairs(((NekoData.BehaviorManager).BM_Battle):GetOwnSideRolesInfo()) do
        -- DECOMPILER ERROR at PC189: Confused about usage of register: R8 in 'UnsetPending'

        if v.key > 0 then
          (req.statuses)[v.key] = (LuaNetManager.CreateBean)("protocol.battle.status")
          -- DECOMPILER ERROR at PC205: Confused about usage of register: R8 in 'UnsetPending'

          if (self._bsc_battleStartProtocol).battleType == CBattleStartProtocol.TOWER then
            ((req.statuses)[v.key]).leftHp = (math.floor)(v.hp * 100 / v.hpmax)
          else
            -- DECOMPILER ERROR at PC214: Confused about usage of register: R8 in 'UnsetPending'

            ;
            ((req.statuses)[v.key]).leftHp = (math.floor)(v.hp)
          end
          LogInfoFormat("NewBattleSceneController", "cbattleend statuses key %s roleid %s hp %s", v.key, v.id, v.hp)
          if #v.onceequipskills > 0 then
            local bean = (LuaNetManager.CreateBean)("protocol.battle.usedequipskills")
            bean.roleId = v.id
            for _,skillid in ipairs(v.onceequipskills) do
              (table.insert)(bean.skillIds, skillid)
            end
            ;
            (table.insert)(req.skills, bean)
          end
        end
      end
      req.isAssisted = self._bsc_isUsePartner
      for _,s in ipairs(self._sendprotocolList) do
        local battleverifyinfo = (LuaNetManager.CreateBean)("protocol.battle.battleverifyinfo")
        local battleverifyproparam = (LuaNetManager.CreateBean)("protocol.battle.battleverifyproparam")
        battleverifyproparam.entityId = (s.content).entityId or 0
        battleverifyproparam.skillid = (s.content).skillid or 0
        battleverifyproparam.gmresult = (s.content).gmresult or 0
        battleverifyinfo.content = battleverifyproparam
        battleverifyinfo.ptype = s.ptype
        battleverifyinfo.step = s.step
        ;
        (table.insert)((req.operate).beanList, battleverifyinfo)
      end
      req.stepNum = self._bsc_stepNum
      req.auto = ((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()
      LogInfoFormat("NewBattleSceneController", "-BSC_SendBattleEndProtocol- autoFight = %s, orderSKill.roleId = %s, orderSKill.skillId = %s, disorderSkill.roleId = %s, disorderSkill.skillId = %s; stepNum %s ---", (req.auto).autoFight, ((req.auto).orderSKill).roleId, ((req.auto).orderSKill).skillId, ((req.auto).disorderSkill).roleId, ((req.auto).disorderSkill).skillId, req.stepNum)
      LogInfo("NewBattleSceneController", "---------eruptSkill List---------")
      for roleId,skillId in pairs((req.auto).eruptSkill) do
        LogInfoFormat("NewBattleSceneController", "roleid %s skillid %s", roleId, skillId)
      end
      for k,v in pairs((self._bsc_battleWorld):GetRightPlayerList()) do
        if (((BattleECS.Utility).Utility).IsRoleDead)(v) then
          local id = (v:GetComponent((BattleECS.Components).TypeComponent))._roleID
          -- DECOMPILER ERROR at PC365: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (req.killMonsterNum)[id] = (req.killMonsterNum)[id] or 0
          -- DECOMPILER ERROR at PC370: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (req.killMonsterNum)[id] = (req.killMonsterNum)[id] + 1
        end
      end
      for _,v in pairs((self._bsc_battleWorld):GetLeftPlayerList()) do
        local id = (v:GetComponent((BattleECS.Components).TypeComponent))._roleID
        local skillList = (v:GetComponent((BattleECS.Components).SkillComponent))._useActSkillList
        local str = ""
        for skillid,times in pairs(skillList) do
          str = str .. tostring(skillid) .. "@" .. tostring(times) .. ";"
        end
        -- DECOMPILER ERROR at PC409: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (req.skillinfo)[id] = str
      end
      if (self._bsc_battleWorld):GetRightCampSkillInterruptedTime() > 0 then
        req.interrupt = 1
      else
        req.interrupt = 0
      end
      local damageList = ((NekoData.BehaviorManager).BM_Battle):GetCurrentBattleDamage()
      local totalDamage = 0
      for key,v in pairs(damageList) do
        if v.camp == Enum_Camp.LeftFighter then
          totalDamage = totalDamage + v.num
        end
      end
      req.totalDamage = totalDamage
      -- DECOMPILER ERROR at PC443: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (req.versions)[codeVersionFile.Lua_Code_Version] = (LuaCodeVersionManager.GetLuaCodeVersion)()
      -- DECOMPILER ERROR at PC448: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (req.versions)[codeVersionFile.Battle_Data_Version] = (LuaCodeVersionManager.GetBattleDataVersion)()
      -- DECOMPILER ERROR at PC453: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (req.versions)[codeVersionFile.Behavior_Version] = (LuaCodeVersionManager.GetBehaviorVersion)()
      -- DECOMPILER ERROR at PC458: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (req.versions)[codeVersionFile.Dungeon_Data_Version] = (LuaCodeVersionManager.GetDungeonDataVersion)()
      -- DECOMPILER ERROR at PC463: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (req.versions)[codeVersionFile.Excel_Data_Version] = (LuaCodeVersionManager.GetExcelDataVersion)()
      if ((NekoData.BehaviorManager).BM_Game):GetClosedClient() then
        req.reconnection = 1
        ;
        ((NekoData.DataManager).DM_Login):SetCBattleEndInfo(clone(req), self._bsc_battleResult, clone(self._bsc_battleStartProtocol))
      else
        req.reconnection = 0
        req:Send(true)
      end
      self._bsc_battleReconnectState = false
      self._bsc_hasUsedGM = false
      ;
      (self._bsc_battleWorld):SetRightCampSkillInterruptedTime(0)
    end
  end
end

NewBattleSceneController.BSC_UpdateBattleLogicOneStep = function(self)
  -- function num : 0_20 , upvalues : _ENV, NewBattleSceneController, TimeSkillStaticFunctions, AnimationHelper
  self._bsc_stepNum = self._bsc_stepNum + 1
  ;
  (self._bsc_battleWorld):Update()
  self:BSC_UpdateLocalProtocol()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_FrameNumUsed, NewBattleSceneController, self._bsc_stepNum)
  do
    if (self._actorTimeSkillChangeValueTask).timeCount then
      local allDataUseOver = true
      for key,v in pairs((self._actorTimeSkillChangeValueTask).dataValue) do
        allDataUseOver = false
        for index = #v, 1, -1 do
          local value = v[index]
          if value.timestamp == (self._actorTimeSkillChangeValueTask).timeCount then
            (TimeSkillStaticFunctions.AddTimeSkillPropertyValue)((self._sceneRef):BSR_GetBattleMainCamera(), key, value.value)
            ;
            (table.remove)(v, index)
          end
        end
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R7 in 'UnsetPending'

        if #v == 0 then
          ((self._actorTimeSkillChangeValueTask).dataValue)[key] = nil
        end
      end
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

      if allDataUseOver then
        (self._actorTimeSkillChangeValueTask).timeCount = nil
        if (self._actorTimeSkillChangeValueTask).isOver then
          (TimeSkillStaticFunctions.DisableTimeSkill)((self._sceneRef):BSR_GetBattleMainCamera())
        end
      else
        -- DECOMPILER ERROR at PC75: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (self._actorTimeSkillChangeValueTask).timeCount = (self._actorTimeSkillChangeValueTask).timeCount + 1
      end
    end
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R1 in 'UnsetPending'

    if (self._bsc_battleCameraAnimationInfo).moveDelayTime then
      (self._bsc_battleCameraAnimationInfo).currentTime = (self._bsc_battleCameraAnimationInfo).currentTime + 1
      -- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

      if (self._bsc_battleCameraAnimationInfo).moveDelayTime < (self._bsc_battleCameraAnimationInfo).currentTime then
        (self._bsc_battleCameraAnimationInfo).moveDelayTime = nil
        -- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (self._bsc_battleCameraAnimationInfo).skillId = 0
        ;
        (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "paraNum", (self._bsc_battleCameraAnimationInfo).cameraMoveType)
      end
    else
      -- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

      if (self._bsc_battleCameraAnimationInfo).resetDelayTime then
        (self._bsc_battleCameraAnimationInfo).currentTime = (self._bsc_battleCameraAnimationInfo).currentTime + 1
        -- DECOMPILER ERROR at PC121: Confused about usage of register: R1 in 'UnsetPending'

        if (self._bsc_battleCameraAnimationInfo).resetDelayTime < (self._bsc_battleCameraAnimationInfo).currentTime then
          (self._bsc_battleCameraAnimationInfo).resetDelayTime = nil
          ;
          (AnimationHelper.SetAnimatorBool2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "GoBack", true)
        end
      end
    end
  end
end

NewBattleSceneController.BSC_ShowSoulAnimation = function(self)
  -- function num : 0_21 , upvalues : _ENV, EventTriggerHelper
  local leftBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(self._bsc_leftSoulBattlerId)
  local rightBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(self._bsc_rightSoulBattlerId)
  if leftBattler and rightBattler then
    if (self._bsc_battleStartProtocol).battleid == 1120 then
      self._bsc_soulTasks = 2
      ;
      (self._bsc_battleFSM):SetNumber("soulNum", self._bsc_soulTasks)
      local args = {}
      args.Player1_att = leftBattler:GetGameObject()
      args.Monster_att = rightBattler:GetGameObject()
      args.Monster_Animation = rightBattler:GetGameObject()
      local obj = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self._sceneRef):GetRootGameObject(), "BehaviacTestTimeline")
      ;
      (((((CS.PixelNeko).P1).TimeLine).TimelineManager).PlayTimelineBindObjectDynamically)(obj, args)
      ;
      (EventTriggerHelper.AddGraphStopListener)(obj, function(self)
    -- function num : 0_21_0
    self._bsc_soulTasks = 0
    ;
    (self._bsc_battleFSM):SetNumber("soulNum", self._bsc_soulTasks)
  end
, self)
    else
      do
        if (self._bsc_battleStartProtocol).battleid == 1122 then
          self._bsc_soulTasks = 2
          ;
          (self._bsc_battleFSM):SetNumber("soulNum", self._bsc_soulTasks)
          local args = {}
          args.Player1_att = leftBattler:GetGameObject()
          args.Monster_Animation = rightBattler:GetGameObject()
          local obj = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self._sceneRef):GetRootGameObject(), "Base_FirstTimeline")
          ;
          (((((CS.PixelNeko).P1).TimeLine).TimelineManager).PlayTimelineBindObjectDynamically)(obj, args)
          ;
          (EventTriggerHelper.AddGraphStopListener)(obj, function(self)
    -- function num : 0_21_1
    self._bsc_soulTasks = 0
    ;
    (self._bsc_battleFSM):SetNumber("soulNum", self._bsc_soulTasks)
  end
, self)
        end
        do
          if leftBattler then
            leftBattler:PlayAnimation("DeadDisappear")
          end
          if rightBattler then
            rightBattler:PlayAnimation("DeadDisappear")
          end
        end
      end
    end
  end
end

NewBattleSceneController.BSC_ShowVictoryAnimation = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if not self._bsc_canWaitingForEndTimeline then
    (((((CS.PixelNeko).Lua).Cinemachine).CinemachineVirtualCameraStaticFunctions).SetPriority)((self._sceneRef)._bsr_startCamera, 0)
    ;
    (((((CS.PixelNeko).Lua).Cinemachine).CinemachineVirtualCameraStaticFunctions).SetPriority)((self._sceneRef)._bsr_victoryCamera, 10)
  end
  local battlers = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()
  for k,battler in pairs(battlers) do
    if battler:IsAlive() then
      battler:PlayAnimation("Victory")
    end
  end
end

NewBattleSceneController.OnEndBattleCameraAnimation = function(self, floatValue, intValue, stringValue, obj, clipName)
  -- function num : 0_23 , upvalues : _ENV, CResourceDungeonStageDialog
  if stringValue == "Slow" then
    LogInfo("NewBattleSceneController", "OnEndBattleCameraAnimator Slow")
    ;
    ((NekoData.DataManager).DM_TimeScale):SetBattleKillSpeed()
  else
    if stringValue == "Normal" then
      LogInfo("NewBattleSceneController", "OnEndBattleCameraAnimator Normal")
      ;
      ((NekoData.DataManager).DM_TimeScale):CancelBattleKillSpeed()
      ;
      (DialogManager.DestroySingletonDialog)("newbattle.battlenewmaindialog")
      ;
      (DialogManager.DestroySingletonDialog)("debug.battlegmdialog")
      ;
      (DialogManager.DestroySingletonDialog)("teamedit.teamtestgmdialog")
      if self._bsc_battleEndProtocol then
        local record = CResourceDungeonStageDialog:GetRecorder(((self._bsc_battleEndProtocol).battleResult).battleId)
        local WinType = {NotFirstWin = 0, FirstWin = 1}
        local resourceFirstWin = ((self._bsc_battleEndProtocol).battleResult).resourceFirstWin == WinType.FirstWin
        if record and resourceFirstWin then
          if record.popupID ~= 0 then
            local effect = (EffectFactory.CreateDialogEffect)(2, record.popupID)
            effect:Run()
            effect:Then(function()
    -- function num : 0_23_0 , upvalues : self
    (self._bsc_battleFSM):SetBoolean("toAccounts", true)
  end
)
          elseif record.dialogID ~= 0 then
            self._bsc_resourceBattleEndDialogId = record.dialogID
            local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
            dialog:SetDialogLibraryId(self._bsc_resourceBattleEndDialogId)
          else
            (self._bsc_battleFSM):SetBoolean("toAccounts", true)
          end
        else
          (self._bsc_battleFSM):SetBoolean("toAccounts", true)
        end
      else
        self._bsc_canEnterAccountsState = true
      end
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

NewBattleSceneController.BSR_OnBattleCameraStateEnter = function(self, handle, stateName, normalizedTime)
  -- function num : 0_24 , upvalues : AnimationHelper
  if stateName == "New State" then
    (AnimationHelper.SetAnimatorBool2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "SkillReset", false)
    ;
    (AnimationHelper.SetAnimatorBool2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "GoBack", false)
    ;
    (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "paraNum", 0)
  else
    if stateName == "RightToReset" or stateName == "LeftToReset" then
      (AnimationHelper.SetAnimatorBool2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "GoBack", false)
      ;
      (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "paraNum", 0)
    else
      if stateName == "MoveToLeft" or stateName == "MoveToRight" or stateName == "BattleCameraShock1" or stateName == "BattleCameraShock2" or stateName == "BattleCameraShock3" or stateName == "BattleCameraShock4" or stateName == "BattleCameraShock5" or stateName == "BattleCameraShock6" or stateName == "BattleCameraShock7" then
        (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "paraNum", 0)
      end
    end
  end
end

NewBattleSceneController.BSC_ShowAwards = function(self)
  -- function num : 0_25 , upvalues : CBattleInfoTable, _ENV, BattleResultType, CBattleStartProtocol
  local protocol = self._bsc_battleEndProtocol
  if not protocol then
    (self._bsc_battleFSM):SetBoolean("toBattleEnd", true)
  else
    local record = CBattleInfoTable:GetRecorder((protocol.battleResult).battleId)
    self._nextSceneId = protocol.id
    LogInfoFormat("NewBattleSceneController", "----- sceneId = %s -----", protocol.id)
    if record.result == 1 then
      local userinfo = {}
      userinfo.itemlist = protocol.itemList
      ;
      ((NekoData.DataManager).DM_Dungeon):SetBattleResult((protocol.battleResult).result)
      ;
      ((NekoData.DataManager).DM_Dungeon):SetBattleAccountData(protocol.itemList, protocol.money, protocol.roleExp, protocol.battleTime, protocol.roleGoodExp, protocol.rolesIndex, protocol.playerExp)
      if (protocol.battleResult).result == BattleResultType.SUCCESS or (protocol.battleResult).result == BattleResultType.SETTLE then
        local battleType = (self._bsc_battleFSM):GetParameter("battleType")
        if battleType == CBattleStartProtocol.PARTY_BOSS then
          (self._bsc_battleFSM):SetBoolean("toBattleEnd", true)
        else
          ;
          (DialogManager.DestroySingletonDialog)("battle.battleaccount.battlewinaccountdialog")
          local dialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlewinaccountdialog")
          if dialog then
            self._bsc_awardDialogKey = dialog._dialogKey
            dialog:Show(false)
          else
            ;
            (self._bsc_battleFSM):SetBoolean("toBattleEnd", true)
          end
        end
      else
        do
          do
            if (protocol.battleResult).result == -1 then
              (self._bsc_battleFSM):SetBoolean("toBattleEnd", true)
            else
              ;
              (self._bsc_battleFSM):SetBoolean("toBattleEnd", true)
            end
            ;
            (self._bsc_battleFSM):SetBoolean("toBattleEnd", true)
          end
        end
      end
    end
  end
end

NewBattleSceneController.BSC_BattleEnd = function(self)
  -- function num : 0_26 , upvalues : _ENV, CBattleStartProtocol, CSRChallengeBattle
  self._bsc_deltaTime_count = nil
  GlobalGameFSM:SetNumber("battleId", 0)
  if self._bsc_battleEndProtocol then
    local lastBattleType = (self._bsc_battleEndProtocol).battleType
    local lastBattleId = ((self._bsc_battleEndProtocol).battleResult).battleId
    local lastBattleResult = ((self._bsc_battleEndProtocol).battleResult).result
    local eventListData = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):GetEventListData()
    if lastBattleType == CBattleStartProtocol.SUMMER_ECHO and lastBattleResult == 1 and eventListData then
      local allIds = CSRChallengeBattle:GetAllIds()
      local cfg = CSRChallengeBattle:GetRecorder(lastBattleId)
      if cfg and lastBattleId ~= allIds[#allIds] then
        (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):OpenEventListDialog()
      end
    end
  end
end

NewBattleSceneController.BSC_Retreat = function(self)
  -- function num : 0_27 , upvalues : _ENV, BattleEndType
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.cbattlekill")
  protocol.type = BattleEndType.Retreat
  self:BSC_SendProtocolToLogicWorld(protocol)
end

NewBattleSceneController.OnSBattleStart = function(self, protocol)
  -- function num : 0_28 , upvalues : _ENV, OnSBattleStart, AnimationHelper
  GlobalGameFSM:SetBoolean("toBreakOrReconnect", false)
  if ((NekoData.BehaviorManager).BM_Login):IfCanUseLocalCBattleEnd(protocol) then
    self._bsc_battleReconnectState = true
  end
  if not self._bsc_canWaitingForStartTimeline then
    OnSBattleStart(self, protocol)
  else
    if self._bsc_battleReconnectState then
      if (self._sceneRef):BSR_GetStartTimeLine() then
        (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "camState", 0)
        ;
        ((self._sceneRef):BSR_GetStartTimeLine()).time = ((self._sceneRef):BSR_GetStartTimeLine()).duration
        ;
        ((self._sceneRef):BSR_GetStartTimeLine()):Play()
      end
      OnSBattleStart(self, protocol)
    else
      self._bsc_canPlayStartTimeline = true
      self._bsc_hasStartBattleLogic = false
    end
  end
end

NewBattleSceneController.OnSBattleEndProtocol = function(self, protocol, reconnect)
  -- function num : 0_29 , upvalues : _ENV, CResourceDungeonStageDialog
  self._bsc_battleEndProtocol = protocol
  if self._bsc_canEnterAccountsState or reconnect then
    (DialogManager.DestroySingletonDialog)("newbattle.battlenewmaindialog")
    ;
    (DialogManager.DestroySingletonDialog)("debug.battlegmdialog")
    ;
    (DialogManager.DestroySingletonDialog)("teamedit.teamtestgmdialog")
    local record = CResourceDungeonStageDialog:GetRecorder((protocol.battleResult).battleId)
    local WinType = {NotFirstWin = 0, FirstWin = 1}
    local resourceFirstWin = (protocol.battleResult).resourceFirstWin == WinType.FirstWin
    if record and resourceFirstWin then
      if record.popupID ~= 0 then
        local effect = (EffectFactory.CreateDialogEffect)(2, record.popupID)
        effect:Run()
        effect:Then(function()
    -- function num : 0_29_0 , upvalues : self
    (self._bsc_battleFSM):SetBoolean("toAccounts", true)
  end
)
      elseif record.dialogID ~= 0 then
        self._bsc_resourceBattleEndDialogId = record.dialogID
        local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
        dialog:SetDialogLibraryId(self._bsc_resourceBattleEndDialogId)
      else
        (self._bsc_battleFSM):SetBoolean("toAccounts", true)
      end
    else
      (self._bsc_battleFSM):SetBoolean("toAccounts", true)
    end
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

NewBattleSceneController.BSC_SendProtocolToViewController = function(self, protocol)
  -- function num : 0_30
  (self._bsc_localProtocolData):Push(protocol)
end

NewBattleSceneController.BSC_SendProtocolToLogicWorld = function(self, protocol)
  -- function num : 0_31 , upvalues : _ENV
  if self._bsc_battleWorld then
    local pTable = {}
    if protocol.ProtocolType == 5 then
      pTable.entityId = protocol.entityId
      pTable.skillid = protocol.skillid
    else
      if protocol.ProtocolType == 27 then
        pTable.gmresult = protocol.type
      else
      end
    end
    if (protocol.ProtocolType ~= 32 or protocol.ProtocolType == 10) then
      (table.insert)(self._sendprotocolList, {content = pTable, ptype = protocol.ProtocolType, step = self._bsc_stepNum})
      local result, error = xpcall(protocol.Process, function(err)
    -- function num : 0_31_0 , upvalues : _ENV
    LogErrorFormat("NewBattleSceneController", "BSC_SendProtocolToLogicWorld protocol process error %s", err)
  end
, protocol, self._bsc_battleWorld)
    end
  end
end

NewBattleSceneController.BSC_UpdateLocalProtocol = function(self)
  -- function num : 0_32 , upvalues : _ENV
  while not self._bsc_battleTimeLine and (self._bsc_localProtocolData):GetSize() > 0 do
    local protocol = (self._bsc_localProtocolData):Pop()
    local result, error = xpcall(protocol.Process, function(err)
    -- function num : 0_32_0 , upvalues : _ENV
    LogErrorFormat("NewBattleSceneController", "BSC_UpdateLocalProtocol protocol process error %s", err)
  end
, protocol, self)
  end
  do
    if not self._bsc_battleTimeLine then
    end
  end
end

NewBattleSceneController.BSC_UpdateAllLocalProtocol = function(self)
  -- function num : 0_33 , upvalues : _ENV
  while (self._bsc_localProtocolData):GetSize() > 0 do
    local protocol = (self._bsc_localProtocolData):Pop()
    local result, error = xpcall(protocol.Process, function(err)
    -- function num : 0_33_0 , upvalues : _ENV
    LogErrorFormat("NewBattleSceneController", "BSC_UpdateAllLocalProtocol protocol process error %s", err)
  end
, protocol, self)
  end
end

NewBattleSceneController.SetBattleTimelineTag = function(self, flag)
  -- function num : 0_34 , upvalues : _ENV, NewBattleSceneController
  if self._bsc_battleTimeLine and not flag then
    (LuaNotificationCenter.PostNotification)(Common.n_BattlePauseStateChange, NewBattleSceneController, false)
  end
  self._bsc_battleTimeLine = flag
end

NewBattleSceneController.BSC_InitServerPlayer = function(self, camp, posId, fighter, haveAlternate)
  -- function num : 0_35 , upvalues : _ENV, CSkin, CNpcShapeTable, CRoleConfigTable, CMonsterConfigTable, LineUpStation, CBattleConfig
  local Enum_Camp = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
  local bean = (BattleClientProtocolManager.CreateBean)("data.attribute")
  bean.id = fighter.id
  bean.key = posId
  bean.camp = camp
  local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
  bean.hp = (fighter.attrs)[AttrTypeEnum.HP]
  bean.hpmax = (fighter.attrs)[AttrTypeEnum.MAX_HP]
  bean.atk = (fighter.attrs)[AttrTypeEnum.ATTACK]
  bean.def = (fighter.attrs)[AttrTypeEnum.DEFEND]
  bean.mdef = (fighter.attrs)[AttrTypeEnum.MAGIC_DEFEND]
  bean.damage = (fighter.attrs)[AttrTypeEnum.DAMAGE] or 0
  bean.physicalbonus = (fighter.attrs)[AttrTypeEnum.PHYSICALBONUS] or 0
  bean.physicalreduce = (fighter.attrs)[AttrTypeEnum.PHYSICALREDUCE] or 0
  bean.magicbonus = (fighter.attrs)[AttrTypeEnum.MAGICBONUS] or 0
  bean.magicreduce = (fighter.attrs)[AttrTypeEnum.MAGICREDUCE] or 0
  bean.physicalcritrate = (fighter.attrs)[AttrTypeEnum.CRITRATE] or 0
  bean.physicalcritdegree = (fighter.attrs)[AttrTypeEnum.CRITDEGREE] or 0
  bean.attackspeed = (fighter.attrs)[AttrTypeEnum.ATTACKSPEED] or 0
  bean.magiclifesteal = (fighter.attrs)[AttrTypeEnum.MAGICLIFESTEAL] or 0
  bean.physicallifesteal = (fighter.attrs)[AttrTypeEnum.PHYSICALLIFESTEAL] or 0
  bean.physicalevasion = (fighter.attrs)[AttrTypeEnum.EVASION] or 0
  bean.physicalblock = (fighter.attrs)[AttrTypeEnum.PHYSICALBLOCK] or 0
  bean.magicblock = (fighter.attrs)[AttrTypeEnum.MAGICBLOCK] or 0
  bean.physicaldefbreak = (fighter.attrs)[AttrTypeEnum.PHYSICALDEFBREAK] or 0
  bean.magicdefbreak = (fighter.attrs)[AttrTypeEnum.MAGICDEFBREAK] or 0
  bean.critrateresistance = (fighter.attrs)[AttrTypeEnum.CRITRATERESISTANCE] or 0
  bean.critdegreeresistance = (fighter.attrs)[AttrTypeEnum.CRITDEGREERESISTANCE] or 0
  bean.extraphysicaldamage = (fighter.attrs)[AttrTypeEnum.EXTRAPHYSICALDAMAGE] or 0
  bean.extramagicdamage = (fighter.attrs)[AttrTypeEnum.EXTRAMAGICDAMAGE] or 0
  bean.curativebonus = (fighter.attrs)[AttrTypeEnum.CURATIVEBONUS] or 0
  bean.accuracy = (fighter.attrs)[AttrTypeEnum.ACCURACY] or 0
  bean.critratelevel = (fighter.attrs)[AttrTypeEnum.CRIT_LEVEL] or 0
  bean.critdegreelevel = (fighter.attrs)[AttrTypeEnum.CRIT_DEGREE_LEVEL] or 0
  bean.healingpower = (fighter.attrs)[AttrTypeEnum.HEALING_POWER] or 0
  bean.comborate1 = (fighter.attrs)[AttrTypeEnum.COMBORATE1] or 0
  bean.comborate2 = (fighter.attrs)[AttrTypeEnum.COMBORATE2] or 0
  bean.damagereduce = (fighter.attrs)[AttrTypeEnum.DAMAGE_REDUCE] or 0
  bean.runelv = (fighter.attrs)[AttrTypeEnum.RUNE_LV] or 0
  bean.baseskill = fighter.baseSkill or 0
  if not fighter.passiveSkills then
    bean.passiveskill = {}
    bean.bosshpstr = tostring(fighter.hpStrip)
    bean.level = fighter.level or 0
    bean.evolutionLevel = fighter.evolutionLevel or 0
    bean.exclusiveLevel = fighter.exclusiveLevel or 0
    if not fighter.equipSkills then
      bean.equipskilllist = {}
      if not fighter.runeSkill then
        bean.runeskilllist = {}
        if not fighter.autoExploreSkill then
          bean.autoExploreSkill = {}
          if haveAlternate then
            bean.havealternate = 1
          end
          for k,v in ipairs(fighter.skills) do
            (table.insert)(bean.skilllist, v)
          end
          local shapeRecorder = nil
          local cskinRecoder = CSkin:GetRecorder(fighter.skinId)
          LogInfoFormat("NewBattleSceneController", "skinId %s", fighter.skinId)
          if cskinRecoder then
            shapeRecorder = CNpcShapeTable:GetRecorder(cskinRecoder.shapeID)
          else
            local roleRecoder = CRoleConfigTable:GetRecorder(fighter.id)
            if not roleRecoder then
              roleRecoder = CMonsterConfigTable:GetRecorder(fighter.id)
            end
            if roleRecoder then
              shapeRecorder = CNpcShapeTable:GetRecorder(roleRecoder.shapeID)
            else
              LogErrorFormat("NewBattleSceneController", "fighter id %s dont have roleconfig or cmonsterconfig, so assetBundleName and prefabName are emptystring", fighter.id)
              shapeRecorder = {assetBundleName = "", prefabName = ""}
            end
          end
          do
            bean.assetbundlename = shapeRecorder.assetBundleName
            bean.prefabname = shapeRecorder.prefabName
            if Enum_Camp.LeftFighter == camp then
              if bean.key == LineUpStation.FRONT_ROW or bean.key == LineUpStation.ALTERNATE_FRONT_ROW then
                bean.pos = tonumber((CBattleConfig:GetRecorder(50)).attr)
              else
                if bean.key == LineUpStation.MIDDLE_ROW or bean.key == LineUpStation.ALTERNATE_MIDDLE_ROW then
                  bean.pos = tonumber((CBattleConfig:GetRecorder(51)).attr)
                else
                  if bean.key == LineUpStation.BACK_ROW or bean.key == LineUpStation.ALTERNATE_BACK_ROW then
                    bean.pos = tonumber((CBattleConfig:GetRecorder(52)).attr)
                  else
                    bean.pos = bean.key
                  end
                end
              end
            else
              if Enum_Camp.RightFighter == camp then
                if bean.key <= 3 then
                  bean.pos = tonumber((CBattleConfig:GetRecorder(bean.key + 52)).attr)
                else
                  if bean.key == 4 then
                    bean.pos = tonumber((CBattleConfig:GetRecorder(63)).attr)
                  else
                    if bean.key == 5 then
                      bean.pos = tonumber((CBattleConfig:GetRecorder(64)).attr)
                    else
                      bean.pos = bean.key
                    end
                  end
                end
              end
            end
            return bean
          end
        end
      end
    end
  end
end

NewBattleSceneController.OnSBattlePause = function(self, protocol)
  -- function num : 0_36 , upvalues : _ENV, NewBattleSceneController
  local TimeLineType = {WithStoryLoaing = 1, OnlyStory = 3}
  self._bsc_battleTimeLine = true
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_BattlePauseStateChange, NewBattleSceneController, true)
  local BattlePauseType = (BattleClientProtocolManager.GetBeanDef)("data.battlepausetype")
  if protocol.pauseType == BattlePauseType.NpcChat then
    self._battle_pause_chatId = tonumber(protocol.param)
    ;
    (self._bsc_battleFSM):SetNumber("chatDialogId", self._battle_pause_chatId)
  else
    if protocol.pauseType == BattlePauseType.TimeLine or protocol.pauseType == TimeLineType.OnlyStory then
      (self._bsc_battleFSM):SetString("timelineObjectName", protocol.param)
    end
  end
  ;
  (self._bsc_battleFSM):SetNumber("pauseType", protocol.pauseType)
  ;
  (self._bsc_battleFSM):SetBoolean("pasue", true)
end

NewBattleSceneController.OnSCreateFixPointSkillAttackedInfo = function(self, protocol)
  -- function num : 0_37 , upvalues : _ENV, CSkillBehaviorTable, CSkillEffectTable
  local DamageTypeEnum = {None = 0, Damage = 1, BreakBuff = 2, DamageCrit = 3, Heal = 4, HealCrit = 5, BreakBuffCrit = 6, Resist = 7}
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityId)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityId)
  end
  if battler then
    local hpDeltaValue = (math.abs)(battler:GetHp() - protocol.currentHp)
    hpDeltaValue = (math.floor)(hpDeltaValue)
    battler:SetHP(protocol.currentHp)
    battler:SetHpBarAnimationState(protocol.isPlayHpBarAnimation == 1)
    ;
    ((NekoData.DataManager).DM_Battle):OnRefreshBothSideRolesInfo(protocol)
    local skillRecord = CSkillBehaviorTable:GetRecorder(protocol.skillId)
    if skillRecord and skillRecord.EffectAtt ~= "" then
      for _,v in pairs((string.split)(skillRecord.EffectAtt, ";")) do
        local skillEffectId = tonumber(v)
        local damageFromBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.damageFrom)
        if not damageFromBattler then
          damageFromBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.damageFrom)
        end
        if not damageFromBattler then
          damageFromBattler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.damageFrom)
        end
        do
          if damageFromBattler then
            local curPrefabName = (damageFromBattler:GetShapeRecorder()).prefabName
            skillEffectId = (((BattleECS.Utility).Utility).GetSkinSkillChangeEffectId)(curPrefabName, skillEffectId)
          end
          do
            local effectRecord = CSkillEffectTable:GetRecorder(skillEffectId)
            if protocol.damageType == DamageTypeEnum.DamageCrit then
              effectRecord = CSkillEffectTable:GetRecorder(4)
            end
            if effectRecord and protocol.isPlayAttackedEffect == 1 then
              if battler:IsLeftCamp() then
                if protocol.isImaged == 1 then
                  battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, protocol.rad / 1000 + 180)
                else
                  battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, protocol.rad / 1000)
                end
              elseif battler:IsRightCamp() then
                battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, -protocol.rad / 1000 + 180)
              end
            end
            -- DECOMPILER ERROR at PC166: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
    if protocol.damageType == DamageTypeEnum.DamageCrit then
      battler:PlayAnimation("Attacked_Critical", true)
    elseif protocol.type == DamageTypeEnum.BreakBuff then
      battler:PlayAnimation("Attacked_RedOnly", true)
    end
    if protocol.damageType == DamageTypeEnum.Damage or protocol.damageType == DamageTypeEnum.BreakBuff or protocol.damageType == DamageTypeEnum.DamageCrit or protocol.damageType == DamageTypeEnum.Resist or protocol.damageType == DamageTypeEnum.BreakBuffCrit then
      battler:RefreshCurrentBattleInjury(hpDeltaValue)
      local battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleInjury(), isPartner = false, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
      ;
      ((NekoData.DataManager).DM_Battle):RecordCurrentBattleInjury(battleValueRecorderTable)
      local damageFromBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.damageFrom)
      if not damageFromBattler then
        damageFromBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.damageFrom)
      end
      local isPartner = false
      if not damageFromBattler then
        damageFromBattler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.damageFrom)
        isPartner = true
      end
      if damageFromBattler then
        damageFromBattler:RefreshCurrentBattleDamage(hpDeltaValue)
        local battleValueRecorderTable = {roleId = damageFromBattler:GetConfigId(), entityId = damageFromBattler:GetEntityId(), camp = damageFromBattler:GetCamp(), isInitial = damageFromBattler:IsInitialPlayer(), num = damageFromBattler:GetCurrentBattleDamage(), isPartner = isPartner, isRole = damageFromBattler:IsRole(), stationKey = damageFromBattler:GetKey(), nameTextId = damageFromBattler:GetNameTextId(), level = damageFromBattler:GetLevel()}
        ;
        ((NekoData.DataManager).DM_Battle):RecordCurrentBattleDamage(battleValueRecorderTable)
      end
    elseif protocol.damageType == DamageTypeEnum.Heal or protocol.damageType == DamageTypeEnum.HealCrit then
      local damageFromBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.damageFrom)
      if not damageFromBattler then
        damageFromBattler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.damageFrom)
      end
      local isPartner = false
      if not damageFromBattler then
        damageFromBattler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.damageFrom)
        isPartner = true
      end
      if damageFromBattler then
        damageFromBattler:RefreshCurrentBattleTreatment(protocol.damageNum)
        local battleValueRecorderTable = {roleId = damageFromBattler:GetConfigId(), entityId = damageFromBattler:GetEntityId(), camp = damageFromBattler:GetCamp(), isInitial = damageFromBattler:IsInitialPlayer(), num = damageFromBattler:GetCurrentBattleTreatment(), isPartner = isPartner, isRole = damageFromBattler:IsRole(), stationKey = damageFromBattler:GetKey(), nameTextId = damageFromBattler:GetNameTextId(), level = damageFromBattler:GetLevel()}
        ;
        ((NekoData.DataManager).DM_Battle):RecordCurrentBattleTreatment(battleValueRecorderTable)
      end
    end
    if protocol.isPost == 1 and self._bsc_battleNewMainUIActiveState then
      (LuaNotificationCenter.PostNotification)(Common.n_HpChanged, battler, {battler = battler, damageType = protocol.damageType, hpChanged = protocol.damageNum, realHpChanged = hpDeltaValue, skillid = protocol.skillId})
    end
  end
  -- DECOMPILER ERROR: 20 unprocessed JMP targets
end

NewBattleSceneController.OnSDamageMiss = function(self, protocol)
  -- function num : 0_38 , upvalues : _ENV, NewBattleSceneController
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
  if battler then
    (LuaNotificationCenter.PostNotification)(Common.n_DamageMiss, NewBattleSceneController, {battler = battler, damageType = protocol.damegetype})
  end
end

NewBattleSceneController.OnSChangeEntityHpCellVisible = function(self, protocol)
  -- function num : 0_39 , upvalues : _ENV, NewBattleSceneController
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityid)
  end
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.entityid)
  end
  if battler then
    (LuaNotificationCenter.PostNotification)(Common.n_HpVisible, NewBattleSceneController, {entityid = protocol.entityid, visible = protocol.visible})
    battler:SetGameObjectVisible(protocol.spritevisible)
  end
end

NewBattleSceneController.OnSCreateBuffEffect = function(self, protocol)
  -- function num : 0_40 , upvalues : _ENV, TransformStaticFunctions
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.entityid)
  end
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityid)
  end
  if battler then
    local effectGameobject = nil
    if battler:IsLeftCamp() then
      if protocol.isImaged == 1 then
        effectGameobject = battler:PlayEffect(protocol.packagename, protocol.effectname, protocol.point, protocol.rad / 1000 + 180)
      else
        effectGameobject = battler:PlayEffect(protocol.packagename, protocol.effectname, protocol.point, protocol.rad / 1000)
      end
    else
      if battler:IsRightCamp() then
        effectGameobject = battler:PlayEffect(protocol.packagename, protocol.effectname, protocol.point, protocol.rad / 1000 + 180)
      end
    end
    if effectGameobject then
      local battleLayer = (TransformStaticFunctions.GetLayer)(battler:GetGameObject())
      if battleLayer ~= -1 then
        (TransformStaticFunctions.SetLayer)(effectGameobject, battleLayer)
      end
    end
  end
end

NewBattleSceneController.OnSDestroyBuffEffect = function(self, protocol)
  -- function num : 0_41 , upvalues : _ENV
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityid)
  end
  if battler then
    battler:DestroyPointEffectByName(protocol.point, protocol.effectname)
  end
end

NewBattleSceneController.OnSDestroyEffectByName = function(self, protocol)
  -- function num : 0_42 , upvalues : _ENV, GameObjectHelper
  if protocol.camp == (((BattleECS.Components).TypeComponent).CampType).Left then
    local childList, len = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetSameNameChildren)((self._sceneRef):BSR_GetLeftEffectObject(), protocol.effectname .. "(Clone)(Clone)")
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        (GameObjectHelper.DestroyObject)(gameObj)
      end
    end
  else
    do
      if protocol.camp == (((BattleECS.Components).TypeComponent).CampType).Right then
        local childList, len = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetSameNameChildren)((self._sceneRef):BSR_GetRightEffectObject(), protocol.effectname .. "(Clone)(Clone)")
        for i = 0, len - 1 do
          local gameObj = childList[i]
          if gameObj then
            (GameObjectHelper.DestroyObject)(gameObj)
          end
        end
      end
      do
        local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
        if battler then
          battler:DestroyPointEffectByName(protocol.point, protocol.effectname)
        end
      end
    end
  end
end

NewBattleSceneController.OnSBattlerPlayAnimationByName = function(self, protocol)
  -- function num : 0_43 , upvalues : _ENV
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityid)
  end
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.entityid)
  end
  do
    if battler then
      local ifIgnorePriority = {No = 0, Yes = 1}
      battler:PlayAnimation(protocol.name, protocol.ignorePriority == ifIgnorePriority.Yes)
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

NewBattleSceneController.OnSDestroyObject = function(self, protocol)
  -- function num : 0_44 , upvalues : _ENV, NewBattleSceneController
  if not ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid) then
    if ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityid) then
      (LuaNotificationCenter.PostNotification)(Common.n_RoleDead, NewBattleSceneController, protocol)
    end
    if protocol.skillid == 0 then
      ((NekoData.DataManager).DM_Battle):RemoveEntity(protocol.entityid)
    end
  else
    if protocol.isimageentity == 1 then
      ((NekoData.DataManager).DM_Battle):RemoveEntity(protocol.entityid)
    end
  end
end

NewBattleSceneController.OnSBattleResult = function(self, protocol)
  -- function num : 0_45 , upvalues : _ENV, AnimationHelper, TimeSkillStaticFunctions, CBattleInfoTable, BattleEndType
  LogInfoFormat("NewBattleSceneController", "OnSBattleResult self._bsc_stepNum %s", self._bsc_stepNum)
  ;
  (AnimationHelper.SetAnimatorBool2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "GoBack", true)
  ;
  (TimeSkillStaticFunctions.DisableTimeSkill)((self._sceneRef):BSR_GetBattleMainCamera())
  local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
  if dialog then
    dialog:PlayBattleEndAnimation(protocol)
  end
  local record = CBattleInfoTable:GetRecorder((self._bsc_battleStartProtocol).battleid)
  if record and record.bgm then
    (LuaAudioManager.StopBGM)(record.bgm)
  end
  self._bsc_battleTime = 0
  local battleRes = nil
  local battleID = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).battleid
  if ((NekoData.BehaviorManager).BM_Battle):IsLoseSettle(battleID) and protocol.type ~= BattleEndType.RightWinCBattleKill then
    battleRes = BattleEndType.LoseSettle
  else
    battleRes = protocol.type
  end
  self._bsc_battleResult = battleRes
  if self._bsc_battleResult == BattleEndType.Retreat then
    self._bsc_isUsePartner = 0
  else
    self._bsc_isUsePartner = protocol.isjoin
  end
  if not self._bsc_ifOneBattleHasSendCBattleEnd then
    self._bsc_ifOneBattleHasSendCBattleEnd = true
    self:BSC_SendBattleEndProtocol()
  else
    LogError("NewBattleSceneController", "have send cbattleend dont send this time")
  end
  if self._bsc_canWaitingForEndTimeline then
    if BattleEndType.LeftWin == self._bsc_battleResult or BattleEndType.LoseSettle == self._bsc_battleResult then
      LogInfo("NewBattleSceneController", "play end BattleCamera animation")
      ;
      (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "camState", 1)
      self._bsc_canEnterAccountsState = false
    else
      self._bsc_canEnterAccountsState = true
    end
  else
    self._bsc_canEnterAccountsState = true
  end
end

NewBattleSceneController.OnSBattleWorldPowerShow = function(self, protocol)
  -- function num : 0_46 , upvalues : _ENV
  ((NekoData.DataManager).DM_Battle):SetBattlePower(protocol.redCurrentPower, protocol.redMaxPower, protocol.blueCurrentPower, protocol.blueMaxPower)
end

NewBattleSceneController.OnSCreateFlySkill = function(self, protocol)
  -- function num : 0_47 , upvalues : _ENV, CSkillEffectTable, BattleSceneHelper, TransformStaticFunctions
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.playerEntityId)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.playerEntityId)
  end
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.playerEntityId)
  end
  if battler then
    local effectGameObject = nil
    local effectRecord = CSkillEffectTable:GetRecorder(protocol.effectid)
    if effectRecord then
      if battler:IsLeftCamp() then
        if protocol.isImaged == 1 then
          effectGameObject = (BattleSceneHelper.CreateEffect)(effectRecord.packageName, effectRecord.effectName, (self._sceneRef):BSR_GetRightEffectObject())
          local angleX, angleY, angleZ = (TransformStaticFunctions.GetWorldEuler)(effectGameObject)
          ;
          (TransformStaticFunctions.SetWorldEuler)(effectGameObject, angleX, angleY, protocol.rad / 1000 + 180)
        else
          do
            effectGameObject = (BattleSceneHelper.CreateEffect)(effectRecord.packageName, effectRecord.effectName, (self._sceneRef):BSR_GetLeftEffectObject())
            do
              local angleX, angleY, angleZ = (TransformStaticFunctions.GetWorldEuler)(effectGameObject)
              if effectRecord.id == 601110103 then
                (TransformStaticFunctions.SetLocalScale)(effectGameObject, -1, 1, 1)
              end
              ;
              (TransformStaticFunctions.SetWorldEuler)(effectGameObject, angleX, angleY, protocol.rad / 1000)
              if battler:IsRightCamp() then
                if protocol.isImaged == 1 then
                  effectGameObject = (BattleSceneHelper.CreateEffect)(effectRecord.packageName, effectRecord.effectName, (self._sceneRef):BSR_GetLeftEffectObject())
                  local angleX, angleY, angleZ = (TransformStaticFunctions.GetWorldEuler)(effectGameObject)
                  ;
                  (TransformStaticFunctions.SetWorldEuler)(effectGameObject, angleX, angleY, protocol.rad / 1000)
                else
                  do
                    effectGameObject = (BattleSceneHelper.CreateEffect)(effectRecord.packageName, effectRecord.effectName, (self._sceneRef):BSR_GetRightEffectObject())
                    do
                      local angleX, angleY, angleZ = (TransformStaticFunctions.GetWorldEuler)(effectGameObject)
                      if effectRecord.id == 601110101 then
                        (TransformStaticFunctions.SetLocalScale)(effectGameObject, 1, -1, 1)
                      end
                      if effectRecord.id == 601110103 then
                        (TransformStaticFunctions.SetLocalScale)(effectGameObject, -1, -1, 1)
                      end
                      ;
                      (TransformStaticFunctions.SetWorldEuler)(effectGameObject, angleX, angleY, protocol.rad / 1000 + 180)
                      if effectGameObject then
                        ((NekoData.DataManager).DM_Battle):AddProjectileEffect(protocol.entityId, protocol.playerEntityId, protocol.skillId, battler._camp, effectGameObject)
                        ;
                        ((NekoData.BehaviorManager).BM_Battle):SetProjectileEffectPosition(protocol.entityId, protocol.posX, protocol.posY, protocol.posZ)
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

NewBattleSceneController.OnSCreateSceneEffect = function(self, protocol)
  -- function num : 0_48 , upvalues : CSkillEffectTable, CBuffEffectTable, _ENV, BattleSceneHelper, TransformStaticFunctions
  local effectGameObject = nil
  local effectRecord = CSkillEffectTable:GetRecorder(protocol.effectid)
  if not effectRecord then
    effectRecord = CBuffEffectTable:GetRecorder(protocol.effectid)
  end
  if effectRecord then
    if protocol.camp == (((BattleECS.Components).TypeComponent).CampType).Left then
      effectGameObject = (BattleSceneHelper.CreateEffect)(effectRecord.packageName, effectRecord.effectName, (self._sceneRef):BSR_GetLeftEffectObject())
      local angleX, angleY, angleZ = (TransformStaticFunctions.GetWorldEuler)(effectGameObject)
      ;
      (TransformStaticFunctions.SetWorldEuler)(effectGameObject, angleX, angleY, protocol.rad / 1000)
    else
      do
        if protocol.camp == (((BattleECS.Components).TypeComponent).CampType).Right then
          effectGameObject = (BattleSceneHelper.CreateEffect)(effectRecord.packageName, effectRecord.effectName, (self._sceneRef):BSR_GetRightEffectObject())
          local angleX, angleY, angleZ = (TransformStaticFunctions.GetWorldEuler)(effectGameObject)
          ;
          (TransformStaticFunctions.SetWorldEuler)(effectGameObject, angleX, angleY, protocol.rad / 1000 + 180)
        end
        do
          if effectGameObject then
            ((NekoData.DataManager).DM_Battle):AddSceneEffectData(effectGameObject)
            ;
            (TransformStaticFunctions.SetPosition)(effectGameObject, protocol.posX / 1000, protocol.posY / 1000, protocol.posZ / 1000)
          end
        end
      end
    end
  end
end

NewBattleSceneController.OnSSkillStart = function(self, skillID)
  -- function num : 0_49
end

NewBattleSceneController.OnSSkillEnd = function(self, skillID)
  -- function num : 0_50
end

NewBattleSceneController.OnSRoleCreate = function(self, protocol)
  -- function num : 0_51 , upvalues : _ENV, SRoleCreate, Enum_Camp, BattleSceneHelper, TransformStaticFunctions, LineUpStation, AnimationHelper, NewBattleSceneController
  if not ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid) then
    local gameObject = nil
    if protocol.type == SRoleCreate.Role then
      if (protocol.attribute).camp == Enum_Camp.LeftFighter then
        gameObject = (BattleSceneHelper.CreatePlayer)((protocol.attribute).assetbundlename, (protocol.attribute).prefabname, (self._sceneRef):BSR_GetLeftObject())
      else
        gameObject = (BattleSceneHelper.CreatePlayer)((protocol.attribute).assetbundlename, (protocol.attribute).prefabname, (self._sceneRef):BSR_GetRightObject())
      end
      local x, y, z = (TransformStaticFunctions.GetPosition)(gameObject)
      if (protocol.attribute).key == LineUpStation.ALTERNATE_FRONT_ROW or (protocol.attribute).key == LineUpStation.ALTERNATE_MIDDLE_ROW or (protocol.attribute).key == LineUpStation.ALTERNATE_BACK_ROW then
        (AnimationHelper.PlayAnimation)(gameObject, "Move", -1, 0)
        local beginXPos = {pos = -10}
        local endXPos = {pos = (protocol.attribute).x / 1000}
        -- DECOMPILER ERROR at PC94: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self._alternateRoleEnterTask)[protocol.entityid] = {task = (Tween.new)(0.5, beginXPos, endXPos, "linear"), gameObject = gameObject, x = (protocol.attribute).x / 1000, y = (protocol.attribute).y / 1000, z = (protocol.attribute).z / 1000}
      else
        do
          do
            ;
            (TransformStaticFunctions.SetPosition)(gameObject, (protocol.attribute).x / 1000, (protocol.attribute).y / 1000, (protocol.attribute).z / 1000)
            ;
            ((NekoData.DataManager).DM_Battle):AddLeftBattler(protocol.entityid, protocol.attribute, gameObject, protocol.isinitial)
            if (protocol.attribute).camp == Enum_Camp.LeftFighter then
              gameObject = (BattleSceneHelper.CreatePlayer)((protocol.attribute).assetbundlename, (protocol.attribute).prefabname, (self._sceneRef):BSR_GetLeftObject())
            else
              gameObject = (BattleSceneHelper.CreatePlayer)((protocol.attribute).assetbundlename, (protocol.attribute).prefabname, (self._sceneRef):BSR_GetRightObject())
            end
            do
              local x, y, z = (TransformStaticFunctions.GetPosition)(gameObject)
              ;
              (TransformStaticFunctions.SetPosition)(gameObject, (protocol.attribute).x / 1000, (protocol.attribute).y / 1000, (protocol.attribute).z / 1000)
              ;
              ((NekoData.DataManager).DM_Battle):AddRightBattler(protocol.entityid, protocol.attribute, gameObject, protocol.isinitial)
              if (protocol.attribute).camp == Enum_Camp.LeftFighter and (protocol.attribute).key > 0 then
                ((NekoData.DataManager).DM_Battle):OnAddOwnSideRolesInfo(protocol)
              else
                if (protocol.attribute).camp == Enum_Camp.RightFighter and (protocol.attribute).key > 0 then
                  ((NekoData.DataManager).DM_Battle):OnAddEnemySideRolesInfo(protocol)
                end
              end
              local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
              do
                if battler and battler:IsTypeStyle() then
                  local battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleInjury(), isPartner = false, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
                  ;
                  ((NekoData.DataManager).DM_Battle):RecordCurrentBattleInjury(battleValueRecorderTable)
                  battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleTreatment(), isPartner = false, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
                  ;
                  ((NekoData.DataManager).DM_Battle):RecordCurrentBattleTreatment(battleValueRecorderTable)
                  battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleDamage(), isPartner = false, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
                  ;
                  ((NekoData.DataManager).DM_Battle):RecordCurrentBattleDamage(battleValueRecorderTable)
                end
                do
                  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
                  battler:SetHP((protocol.attribute).hp, (protocol.attribute).hpmax)
                  protocol.attribute = battler:GetAttribute()
                  ;
                  (LuaNotificationCenter.PostNotification)(Common.n_RoleAdd, NewBattleSceneController, protocol)
                end
              end
            end
          end
        end
      end
    end
  end
end

NewBattleSceneController.OnSPartnerCreate = function(self, protocol)
  -- function num : 0_52 , upvalues : _ENV, BattleSceneHelper, TransformStaticFunctions
  if not ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.entityid) then
    local gameObject = nil
    if (protocol.attribute).camp == (((BattleECS.Components).TypeComponent).CampType).Left then
      gameObject = (BattleSceneHelper.CreatePlayer)((protocol.attribute).assetbundlename, (protocol.attribute).prefabname, (self._sceneRef):BSR_GetLeftObject())
    else
      gameObject = (BattleSceneHelper.CreatePlayer)((protocol.attribute).assetbundlename, (protocol.attribute).prefabname, (self._sceneRef):BSR_GetRightObject())
    end
    ;
    (TransformStaticFunctions.SetPosition)(gameObject, (protocol.attribute).x / 1000, (protocol.attribute).y / 1000, (protocol.attribute).z / 1000)
    ;
    ((NekoData.DataManager).DM_Battle):AddLeftPartnet(protocol.entityid, protocol.attribute, gameObject)
    local battler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.entityid)
    if battler and battler:IsTypeStyle() then
      local battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleInjury(), isPartner = true, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
      ;
      ((NekoData.DataManager).DM_Battle):RecordCurrentBattleInjury(battleValueRecorderTable)
      battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleTreatment(), isPartner = true, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
      ;
      ((NekoData.DataManager).DM_Battle):RecordCurrentBattleTreatment(battleValueRecorderTable)
      battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleDamage(), isPartner = true, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
      ;
      ((NekoData.DataManager).DM_Battle):RecordCurrentBattleDamage(battleValueRecorderTable)
    end
  end
end

NewBattleSceneController.ChangeRoleToImaged = function(self, entityid, camp)
  -- function num : 0_53 , upvalues : _ENV, CSkillEffectTable, TransformStaticFunctions
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(entityid)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(entityid)
  end
  if battler then
    local effectRecord = CSkillEffectTable:GetRecorder(3004105)
    ;
    (TransformStaticFunctions.SetLocalScale)(battler:GetGameObject(), -1, 1, 1)
    if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
      battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, 180)
    else
      if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
        battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, 0)
      end
    end
  end
end

NewBattleSceneController.ResetRoleToImage = function(self, entityid, camp)
  -- function num : 0_54 , upvalues : _ENV, CSkillEffectTable, TransformStaticFunctions
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(entityid)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(entityid)
  end
  if battler then
    local effectRecord = CSkillEffectTable:GetRecorder(3004105)
    battler:PlayAnimation("BattleIdle")
    ;
    (TransformStaticFunctions.SetLocalScale)(battler:GetGameObject(), 1, 1, 1)
    if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
      battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, 0)
    else
      if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
        battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, 180)
      end
    end
  end
end

NewBattleSceneController.OnSUseSkill = function(self, protocol)
  -- function num : 0_55 , upvalues : _ENV
  if (((BattleECS.Utility).Utility).IsYingXiSkill)(protocol.skillid) then
    local camp = protocol.camp
    if protocol.isImaged == 0 then
      self:ChangeRoleToImaged(protocol.entityid, camp)
    else
      self:ResetRoleToImage(protocol.entityid, camp)
    end
  end
end

NewBattleSceneController.OnSRoleSummonCreate = function(self, protocol)
  -- function num : 0_56 , upvalues : _ENV, SRoleSummon, CMonsterConfigTable, CNpcShapeTable, BattleSceneHelper, CSkillEffectTable, TransformStaticFunctions, NewBattleSceneController
  if not ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityid) then
    local gameObject = nil
    if (protocol.attribute).camp == SRoleSummon.Role then
      local roleRecoder = (CMonsterConfigTable:GetRecorder((protocol.attribute).id))
      local shapeRecorder = nil
      if roleRecoder then
        shapeRecorder = CNpcShapeTable:GetRecorder(roleRecoder.shapeID)
        gameObject = (BattleSceneHelper.CreatePlayer)(shapeRecorder.assetBundleName, shapeRecorder.prefabName, (self._sceneRef):BSR_GetLeftObject())
      else
        local effectRecord = CSkillEffectTable:GetRecorder((protocol.attribute).id)
        gameObject = (BattleSceneHelper.CreateEffect)(effectRecord.packageName, effectRecord.effectName, (self._sceneRef):BSR_GetLeftEffectObject())
      end
      do
        do
          local x, y, z = (TransformStaticFunctions.GetPosition)(gameObject)
          ;
          (TransformStaticFunctions.SetPosition)(gameObject, (protocol.attribute).x / 1000, (protocol.attribute).y / 1000, (protocol.attribute).z / 1000)
          ;
          ((NekoData.DataManager).DM_Battle):AddLeftBattlerSummon(protocol.entityid, protocol.attribute, gameObject)
          if (protocol.attribute).camp == SRoleSummon.Monster then
            local roleRecoder = (CMonsterConfigTable:GetRecorder((protocol.attribute).id))
            local shapeRecorder = nil
            if roleRecoder then
              shapeRecorder = CNpcShapeTable:GetRecorder(roleRecoder.shapeID)
              gameObject = (BattleSceneHelper.CreatePlayer)(shapeRecorder.assetBundleName, shapeRecorder.prefabName, (self._sceneRef):BSR_GetRightObject())
            else
              local effectRecord = CSkillEffectTable:GetRecorder((protocol.attribute).id)
              gameObject = (BattleSceneHelper.CreateEffect)(effectRecord.packageName, effectRecord.effectName, (self._sceneRef):BSR_GetRightEffectObject())
            end
            do
              do
                local x, y, z = (TransformStaticFunctions.GetPosition)(gameObject)
                ;
                (TransformStaticFunctions.SetPosition)(gameObject, (protocol.attribute).x / 1000, (protocol.attribute).y / 1000, (protocol.attribute).z / 1000)
                ;
                ((NekoData.DataManager).DM_Battle):AddRightBattlerSummon(protocol.entityid, protocol.attribute, gameObject)
                local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityid)
                battler:SetFatherEntityId(protocol.fatherEntityId)
                do
                  if battler and battler:IsTypeStyle() then
                    local battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleInjury(), isPartner = false, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
                    ;
                    ((NekoData.DataManager).DM_Battle):RecordCurrentBattleInjury(battleValueRecorderTable)
                    battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleTreatment(), isPartner = false, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
                    ;
                    ((NekoData.DataManager).DM_Battle):RecordCurrentBattleTreatment(battleValueRecorderTable)
                    battleValueRecorderTable = {roleId = battler:GetConfigId(), entityId = battler:GetEntityId(), camp = battler:GetCamp(), isInitial = battler:IsInitialPlayer(), num = battler:GetCurrentBattleDamage(), isPartner = false, isRole = battler:IsRole(), stationKey = battler:GetKey(), nameTextId = battler:GetNameTextId(), level = battler:GetLevel()}
                    ;
                    ((NekoData.DataManager).DM_Battle):RecordCurrentBattleDamage(battleValueRecorderTable)
                  end
                  ;
                  (LuaNotificationCenter.PostNotification)(Common.n_RoleAdd, NewBattleSceneController, protocol)
                end
              end
            end
          end
        end
      end
    end
  end
end

NewBattleSceneController.OnSRoleChangeShapeAndAttribute = function(self, protocol)
  -- function num : 0_57 , upvalues : _ENV, BattleSceneHelper, CNpcShapeTable, TransformStaticFunctions
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityid)
  end
  if battler then
    local gameObject = nil
    if battler:GetCamp() == 1 then
      if protocol.shapeid == 0 then
        gameObject = (BattleSceneHelper.CreatePlayer)(protocol.assetBundleName, protocol.prefabName, (self._sceneRef):BSR_GetLeftObject())
      else
        local shapeRecorder = CNpcShapeTable:GetRecorder(protocol.shapeid)
        gameObject = (BattleSceneHelper.CreatePlayer)(shapeRecorder.assetBundleName, shapeRecorder.prefabName, (self._sceneRef):BSR_GetLeftObject())
      end
      do
        do
          local x, y, z = battler:GetPosition()
          ;
          (TransformStaticFunctions.SetPosition)(gameObject, x / 1000, y / 1000, z / 1000)
          ;
          ((NekoData.DataManager).DM_Battle):ChangeLeftBattler(protocol.entityid, gameObject)
          if protocol.shapeid == 0 then
            gameObject = (BattleSceneHelper.CreatePlayer)(protocol.assetBundleName, protocol.prefabName, (self._sceneRef):BSR_GetRightObject())
          else
            local shapeRecorder = CNpcShapeTable:GetRecorder(protocol.shapeid)
            gameObject = (BattleSceneHelper.CreatePlayer)(shapeRecorder.assetBundleName, shapeRecorder.prefabName, (self._sceneRef):BSR_GetRightObject())
          end
          do
            local x, y, z = battler:GetPosition()
            ;
            (TransformStaticFunctions.SetPosition)(gameObject, x / 1000, y / 1000, z / 1000)
            ;
            ((NekoData.DataManager).DM_Battle):ChangeRightBattler(protocol.entityid, gameObject)
          end
        end
      end
    end
  end
end

NewBattleSceneController.OnSRoleDead = function(self, protocol)
  -- function num : 0_58 , upvalues : _ENV, NewBattleSceneController
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityId)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityId)
  end
  if battler then
    battler:SetHP(0)
    if battler:IsRightCamp() and battler:GetSoulQuantity() > 0 then
      local left, right = nil, battler
      for k,v in pairs(((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()) do
        if v:GetConfigId() == 1 then
          left = v
          break
        end
      end
      do
        for k,v in pairs(((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()) do
          if v:GetConfigId() == 10017 then
            right = v
            break
          end
          if v:GetConfigId() == 20003 then
            right = v
            break
          end
        end
        do
          do
            if left and right then
              (self._bsc_battleFSM):SetBoolean("toSoul", true)
              self._bsc_leftSoulBattlerId = left:GetEntityId()
              self._bsc_rightSoulBattlerId = right:GetEntityId()
            end
            if protocol.isrunaway == 0 then
              battler:PlayAnimation("DeadDisappear")
            end
            ;
            (LuaNotificationCenter.PostNotification)(Common.n_RoleDead, NewBattleSceneController, protocol)
          end
        end
      end
    end
  end
end

NewBattleSceneController.OnSRolePositionChange = function(self, protocol)
  -- function num : 0_59 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityId) then
    ((NekoData.BehaviorManager).BM_Battle):SetBattlerPosition(protocol.entityId, protocol.posX, protocol.posY)
  end
  if ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.entityId) then
    ((NekoData.BehaviorManager).BM_Battle):SetBattlerPosition(protocol.entityId, protocol.posX, protocol.posY)
  end
  if ((NekoData.BehaviorManager).BM_Battle):GetProjectileEffectByEntityId(protocol.entityId) then
    ((NekoData.BehaviorManager).BM_Battle):SetProjectileEffectPosition(protocol.entityId, protocol.posX, protocol.posY)
  end
end

NewBattleSceneController.OnSSkillPowerCost = function(self, protocol)
  -- function num : 0_60 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_SkillSuccess, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSSkillFail = function(self, protocol)
  -- function num : 0_61 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_SkillFail, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSBattleEnd = function(self, protocol)
  -- function num : 0_62 , upvalues : _ENV, BattleEndType
  LogInfoFormat("NewBattleSceneController", "OnSBattleEnd self._bsc_stepNum %s", self._bsc_stepNum)
  self._bsc_battleStepTimeCount = 0
  ;
  (self._bsc_battleFSM):SetBoolean("battleLogicEnd", true)
  local battleID = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).battleid
  if ((NekoData.BehaviorManager).BM_Battle):IsLoseSettle(battleID) then
    protocol.type = BattleEndType.LoseSettle
  end
  ;
  (self._bsc_battleFSM):SetNumber("battleResult", protocol.type)
end

NewBattleSceneController.OnSPartner = function(self, protocol)
  -- function num : 0_63 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_SupportRoleUsed, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSRoleIsCanUseSKill = function(self, protocol)
  -- function num : 0_64 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_BattlerUseSkill, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSUpdateRoleAttribute = function(self, protocol)
  -- function num : 0_65 , upvalues : _ENV
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityid)
  end
  if battler then
    battler:RefreshAttribute(protocol.attribute)
  end
end

NewBattleSceneController.OnSUpdateBossHpStage = function(self, protocol)
  -- function num : 0_66 , upvalues : _ENV
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityId)
  if battler then
    battler:SetBossHpStage(protocol.bosshpstage)
  end
end

NewBattleSceneController.OnSPlayAudio = function(self, protocol)
  -- function num : 0_67 , upvalues : _ENV
  if (LuaAudioManager.IfAudioIsVoice)(protocol.audioid) then
    (LuaAudioManager.PlayVoice)(protocol.audioid)
  else
    ;
    (LuaAudioManager.PlayBGM)(protocol.audioid)
  end
  if protocol.audiovalue ~= -1 then
    ((((CS.PixelNeko).Audio).AudioManager).SetAisac)(protocol.audioid, 0, protocol.audiovalue)
  end
end

NewBattleSceneController.OnSRoleUseEquipSkill = function(self, protocol)
  -- function num : 0_68 , upvalues : _ENV, NewBattleSceneController
  ((NekoData.DataManager).DM_Battle):AddOnceUseEquipSkill(protocol.entityid, protocol.skillid)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RoleEquipSkillUsed, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSUpdateRoleBuffs = function(self, protocol)
  -- function num : 0_69 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_BuffsUpdate, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSUpdateRoleSkillPowerReduce = function(self, protocol)
  -- function num : 0_70 , upvalues : _ENV
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
  if battler then
    battler:RefreshskillPowerCostReduce(protocol.order, protocol.chaos)
  end
end

NewBattleSceneController.OnSSkillBegin = function(self, protocol)
  -- function num : 0_71 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_SkillBegin, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSSkillInterrupted = function(self, protocol)
  -- function num : 0_72 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_SkillInterrupted, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSInvincibleStateChange = function(self, protocol)
  -- function num : 0_73 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_InvincibleStateChange, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSShieldValueChange = function(self, protocol)
  -- function num : 0_74 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_ShieldValueChange, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSBossIsInWeakState = function(self, protocol)
  -- function num : 0_75 , upvalues : CBattleGuideLinkConfig, _ENV
  local TimeType = {None = 0, BattleStart = 1, BattleWin = 2, BattleLose = 3, BOSSFirstWeak = 4}
  local guide = (self._bsc_battleStartProtocol).guide
  if guide ~= 0 then
    local timetype = (CBattleGuideLinkConfig:GetRecorder(guide)).time
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

    if timetype == TimeType.BOSSFirstWeak and not (self._bsc_battleGuideTag)[guide] then
      (self._bsc_battleGuideTag)[guide] = true
      ;
      ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(guide, true)
    end
  end
end

NewBattleSceneController.OnSAccumulatePowerStateChange = function(self, protocol)
  -- function num : 0_76 , upvalues : CBattleGuideLinkConfig, _ENV
  local TimeType = {None = 0, BattleStart = 1, BattleWin = 2, BattleLose = 3, BOSSFirstWeak = 4, PowerFirstFull = 1003}
  local guide = (self._bsc_battleStartProtocol).guide
  if guide ~= 0 then
    local timetype = (CBattleGuideLinkConfig:GetRecorder(guide)).time
    if timetype == TimeType.PowerFirstFull and not (self._bsc_battleGuideTag)[guide] and protocol.state == ((self._bsc_battleWorld).PowerAccumulateStateType).Full then
      local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
      if dialog then
        dialog:SetGuideFrame({guideTimeType = timetype}, nil, "Down", 2301124)
      end
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._bsc_battleGuideTag)[guide] = true
    end
  end
  do
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_AccumulatePowerState, self, {state = protocol.state})
  end
end

NewBattleSceneController.OnSCollaborativeSkillNumChange = function(self, protocol)
  -- function num : 0_77 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_CollaborativeSkillNumChange, self, {entityid = protocol.entityid, num = protocol.num})
end

NewBattleSceneController.OnSSetClipRectForShiKongZhiMen = function(self, protocol)
  -- function num : 0_78 , upvalues : _ENV, TransformStaticFunctions
  ((BattleClientProtocolManager.GetBeanDef)("data.enum_camp"))
  local Enum_Camp = nil
  local parentObj, shiKongZhiMenObject = nil, nil
  if protocol.camp == Enum_Camp.RightFighter then
    parentObj = (self._sceneRef):BSR_GetRightEffectObject()
    for i = 1, 5 do
      if not shiKongZhiMenObject then
        do
          shiKongZhiMenObject = (TransformStaticFunctions.GetChild)((self._sceneRef):BSR_GetLeftEffectObject(), "TX_Prefab_ShiKongZhiMen_" .. i .. "(Clone)(Clone)")
          -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  else
    if protocol.camp == Enum_Camp.LeftFighter then
      parentObj = (self._sceneRef):BSR_GetLeftEffectObject()
      for i = 1, 5 do
        if not shiKongZhiMenObject then
          do
            shiKongZhiMenObject = (TransformStaticFunctions.GetChild)((self._sceneRef):BSR_GetRightEffectObject(), "TX_Prefab_ShiKongZhiMen_" .. i .. "(Clone)(Clone)")
            -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  if shiKongZhiMenObject then
    local wx, wy, wz = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(shiKongZhiMenObject)
    local flag, x, y, w, h = ((((CS.PixelNeko).UI).UIManager).WorldToScreenRect01)("BattleMain", wx, wy, wz, protocol.w / 1000, protocol.h / 1000)
    local leftDownX, leftDownY, rightUpX, rightUpY = 0, 0, x, 1
    if protocol.camp == Enum_Camp.LeftFighter then
      leftDownX = x
    end
    if flag and parentObj then
      local childList, len = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetSameNameChildren)(parentObj, protocol.objectname .. "(Clone)(Clone)")
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          local particleMaterials = ((((CS.PixelNeko).Lua).MaterialStaticFunctions).CopyAndUseParticleSystemRendererMaterialsInChildren)(gameObj, true)
          local meshMaterials = ((((CS.PixelNeko).Lua).MaterialStaticFunctions).CopyAndUseMeshRendererMaterialsInChildren)(gameObj, true)
          if protocol.clipstate == "true" then
            if particleMaterials ~= nil then
              ((((CS.PixelNeko).Lua).MaterialStaticFunctions).SetClipRect)(particleMaterials, true, false, leftDownX, leftDownY, rightUpX, rightUpY)
            end
            if meshMaterials ~= nil then
              ((((CS.PixelNeko).Lua).MaterialStaticFunctions).SetClipRect)(meshMaterials, true, false, leftDownX, leftDownY, rightUpX, rightUpY)
            end
          else
            if protocol.clipstate == "false" then
              if particleMaterials ~= nil then
                ((((CS.PixelNeko).Lua).MaterialStaticFunctions).SetClipRect)(particleMaterials, false, false, leftDownX, leftDownY, rightUpX, rightUpY)
              end
              if meshMaterials ~= nil then
                ((((CS.PixelNeko).Lua).MaterialStaticFunctions).SetClipRect)(meshMaterials, false, false, leftDownX, leftDownY, rightUpX, rightUpY)
              end
            else
              LogError("NewBattleSceneController", "wrong \'clipstate\' in localprotocol SSetClipRectForShiKongZhiMen")
            end
          end
        end
      end
    end
  end
end

NewBattleSceneController.OnSActiveSkillStateChange = function(self, protocol)
  -- function num : 0_79 , upvalues : _ENV, NewBattleSceneController
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityid)
  if battler then
    battler:SetSkillIsInCD(protocol.skillid, protocol.isInCD)
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ActiveSkillStateChange, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSActorTimeSkillState = function(self, protocol)
  -- function num : 0_80 , upvalues : TimeSkillStaticFunctions, _ENV
  local StateType = {Begin = 0, Over = 1}
  ;
  (TimeSkillStaticFunctions.EnableTimeSkill)((self._sceneRef):BSR_GetBattleMainCamera())
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._actorTimeSkillChangeValueTask).timeCount = 0
  for key,value in pairs((self._actorTimeSkillChangeValueTask).dataValue) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

    ((self._actorTimeSkillChangeValueTask).dataValue)[key] = nil
  end
  local data = {}
  if protocol.state == StateType.Begin then
    data = require("data.battledata.animation.timeskillposttreatmenton")
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._actorTimeSkillChangeValueTask).isOver = false
  else
    if protocol.state == StateType.Over then
      data = require("data.battledata.animation.timeskillposttreatmentoff")
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._actorTimeSkillChangeValueTask).isOver = true
    end
  end
  for key,value in pairs(data) do
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'

    if not ((self._actorTimeSkillChangeValueTask).dataValue)[key] then
      ((self._actorTimeSkillChangeValueTask).dataValue)[key] = {}
      if not (self._actorTimeSkillChangeValueTask).isOver then
        (TimeSkillStaticFunctions.SetTimeSkillPropertyValue)((self._sceneRef):BSR_GetBattleMainCamera(), key, (value[1]).value)
      end
    end
    if key == "useChromaticAberration" or key == "useInverColor" or key == "useColorGrading" then
      for i,v in ipairs(value) do
        if i ~= 1 then
          (table.insert)(((self._actorTimeSkillChangeValueTask).dataValue)[key], {timestamp = v.timestamp, value = v.value})
        end
      end
    else
      do
        for i,v in ipairs(value) do
          if value[i - 1] then
            local deltaTime = (value[i]).timestamp - (value[i - 1]).timestamp
            local deltaValue = (value[i]).value / deltaTime
            for timeI = 1, deltaTime do
              (table.insert)(((self._actorTimeSkillChangeValueTask).dataValue)[key], {timestamp = (value[i - 1]).timestamp + timeI, value = deltaValue})
            end
          end
        end
        do
          -- DECOMPILER ERROR at PC130: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC130: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC130: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

NewBattleSceneController.OnSPlayBattleVoice = function(self, protocol)
  -- function num : 0_81 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Voice):PlayBattleVoice(protocol.roleId, protocol.voiceType, protocol.index)
end

NewBattleSceneController.OnSChangeAnimatorState = function(self, protocol)
  -- function num : 0_82
  local animator = (self._bsc_animatorGroup)[protocol.animatorType]
  if animator then
    animator:SetInteger(protocol.param, protocol.value)
  end
end

NewBattleSceneController.OnSChangeEntityName = function(self, protocol)
  -- function num : 0_83 , upvalues : _ENV, NewBattleSceneController
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityId)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetPartnerByEntityId(protocol.entityId)
  end
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityId)
  end
  if battler then
    battler:SetNameTextId(protocol.nameTextId)
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_EntityNameChanging, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSPlayBattleCameraAnimationName = function(self, protocol)
  -- function num : 0_84 , upvalues : AnimationHelper
  local MoveType = {Interrept = -2}
  if protocol.skillId ~= 0 and (self._bsc_battleCameraAnimationInfo).cameraMoveType ~= MoveType.Interrept and ((self._bsc_battleCameraAnimationInfo).moveDelayTime or (self._bsc_battleCameraAnimationInfo).resetDelayTime) then
    return 
  end
  if protocol.skillId == (self._bsc_battleCameraAnimationInfo).skillId and (self._bsc_battleCameraAnimationInfo).cameraMoveType == MoveType.Interrept then
    (AnimationHelper.SetAnimatorBool2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "SkillReset", true)
  end
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

  if protocol.moveDelayTime == -1 then
    (self._bsc_battleCameraAnimationInfo).moveDelayTime = nil
  else
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._bsc_battleCameraAnimationInfo).moveDelayTime = protocol.moveDelayTime
  end
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R3 in 'UnsetPending'

  if protocol.resetDelayTime == -1 then
    (self._bsc_battleCameraAnimationInfo).resetDelayTime = nil
  else
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._bsc_battleCameraAnimationInfo).resetDelayTime = protocol.resetDelayTime
  end
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._bsc_battleCameraAnimationInfo).cameraMoveType = protocol.cameraMoveType
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._bsc_battleCameraAnimationInfo).skillId = protocol.skillId
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._bsc_battleCameraAnimationInfo).currentTime = 0
end

NewBattleSceneController.OnSShowOrderPowerSpecialUIEffect = function(self, protocol)
  -- function num : 0_85 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_OrderPowerSpecialUIEffect, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSSActionWithActiveSkill = function(self, protocol)
  -- function num : 0_86 , upvalues : _ENV
  local battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerByEntityId(protocol.entityId)
  if not battler then
    battler = ((NekoData.BehaviorManager).BM_Battle):GetBattlerSummonByEntityId(protocol.entityId)
  end
  if battler then
    battler:PlayAnimation("Attacked", true)
  end
end

NewBattleSceneController.OnSBreakOutPowerNumber = function(self, protocol)
  -- function num : 0_87 , upvalues : _ENV, NewBattleSceneController
  (LuaNotificationCenter.PostNotification)(Common.n_BreakOutPowerNumberChange, NewBattleSceneController, protocol)
end

NewBattleSceneController.OnSBossEnterViolent = function(self, protocol)
  -- function num : 0_88 , upvalues : _ENV, NewBattleSceneController
  local battlerList = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()
  for entityId,battler in pairs(battlerList) do
    if battler:IsBoss() then
      self._bsc_isBossViolent = true
      battler:SetViolentState(true)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_BossViolentEnter, NewBattleSceneController, protocol)
    end
  end
end

NewBattleSceneController.GMSUpdateOneCampAttribute = function(self, data)
  -- function num : 0_89 , upvalues : _ENV
  self._bsc_hasUsedGM = true
  do
    if data.camp == (((BattleECS.Components).TypeComponent).CampType).Left then
      local battlerList = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()
      for entityId,battler in pairs(battlerList) do
        battler:RefreshAttribute(data.attribute)
        local entity = nil
        for i,e in ipairs((self._bsc_battleWorld)._entitys) do
          if e._entityId == entityId then
            entity = e
            break
          end
        end
        do
          do
            if entity then
              local defenseComponent = entity:GetComponent((BattleECS.Components).DefenseComponent)
              defenseComponent._attackDefenseAddition = fixedpoint((data.attribute).physicalreduce) / 1000
              defenseComponent._magicDefenseAddition = fixedpoint((data.attribute).magicreduce) / 1000
            end
            -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
      battlerList = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlersSummon()
      for entityId,battler in pairs(battlerList) do
        battler:RefreshAttribute(data.attribute)
        local entity = nil
        for i,e in ipairs((self._bsc_battleWorld)._entitys) do
          if e._entityId == entityId then
            entity = e
            break
          end
        end
        do
          do
            if entity then
              local defenseComponent = entity:GetComponent((BattleECS.Components).DefenseComponent)
              defenseComponent._attackDefenseAddition = fixedpoint((data.attribute).physicalreduce) / 1000
              defenseComponent._magicDefenseAddition = fixedpoint((data.attribute).magicreduce) / 1000
            end
            -- DECOMPILER ERROR at PC100: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
    if data.camp == (((BattleECS.Components).TypeComponent).CampType).Right then
      local battlerList = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()
      for entityId,battler in pairs(battlerList) do
        battler:RefreshAttribute(data.attribute)
        local entity = nil
        for i,e in ipairs((self._bsc_battleWorld)._entitys) do
          if e._entityId == entityId then
            entity = e
            break
          end
        end
        do
          do
            if entity then
              local defenseComponent = entity:GetComponent((BattleECS.Components).DefenseComponent)
              defenseComponent._attackDefenseAddition = fixedpoint((data.attribute).physicalreduce) / 1000
              defenseComponent._magicDefenseAddition = fixedpoint((data.attribute).magicreduce) / 1000
            end
            -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
      battlerList = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlersSummon()
      for entityId,battler in pairs(battlerList) do
        battler:RefreshAttribute(data.attribute)
        local entity = nil
        for i,e in ipairs((self._bsc_battleWorld)._entitys) do
          if e._entityId == entityId then
            entity = e
            break
          end
        end
        do
          do
            if entity then
              local defenseComponent = entity:GetComponent((BattleECS.Components).DefenseComponent)
              defenseComponent._attackDefenseAddition = fixedpoint((data.attribute).physicalreduce) / 1000
              defenseComponent._magicDefenseAddition = fixedpoint((data.attribute).magicreduce) / 1000
            end
            -- DECOMPILER ERROR at PC201: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
end

NewBattleSceneController.GMMakeLeftPlayerStatusFull = function(self)
  -- function num : 0_90 , upvalues : _ENV, LineUpStation
  self._bsc_hasUsedGM = true
  local battlerList = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()
  for entityId,battler in pairs(battlerList) do
    local entity = nil
    for i,e in ipairs((self._bsc_battleWorld)._entitys) do
      if e._entityId == entityId then
        entity = e
        break
      end
    end
    do
      do
        if entity then
          local hpComponent = entity:GetComponent((BattleECS.Components).HpComponent)
          battler:RefreshAttribute({hp = hpComponent._maxHp})
          hpComponent._currentHp = hpComponent._maxHp
          if (((BattleECS.Utility).Utility).IsRoleDead)(entity) and (not battler:IsHaveAlternate() or battler:GetKey() == LineUpStation.ALTERNATE_BACK_ROW or battler:GetKey() == LineUpStation.ALTERNATE_FRONT_ROW or battler:GetKey() == LineUpStation.ALTERNATE_MIDDLE_ROW) then
            (self._bsc_battleWorld):RevivePlayer(entityId)
            ;
            (((BattleECS.Utility).BuffUtility).RemoveEntityBuff)(entity, 20000)
          end
        end
        -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

NewBattleSceneController.GMRemoveBossOneHpStage = function(self)
  -- function num : 0_91 , upvalues : _ENV
  self._bsc_hasUsedGM = true
  local battlerList = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()
  for entityId,battler in pairs(battlerList) do
    if battler:IsBoss() then
      local entity = nil
      for i,e in ipairs((self._bsc_battleWorld)._entitys) do
        if e._entityId == entityId then
          entity = e
          break
        end
      end
      do
        local bossStage = battler:GetBossHpStage()
        local hpComponent = entity:GetComponent((BattleECS.Components).HpComponent)
        local currentHp = hpComponent._currentHp
        do
          local totalHp = fixedpoint_zero
          for i,v in ipairs(bossStage) do
            -- DECOMPILER ERROR at PC46: Confused about usage of register: R17 in 'UnsetPending'

            if currentHp > totalHp + v then
              do
                (((self._bsc_battleWorld)._bossHpStage)[i]).stage = true
                totalHp = totalHp + v
                -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
          currentHp = totalHp
          if currentHp <= 0 then
            currentHp = (fixedpoint.new)(1)
          end
          battler:RefreshAttribute({hp = (fixedpoint.tonumber)(currentHp)})
          hpComponent._currentHp = currentHp
          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

NewBattleSceneController.GMSetSelfPlayerInvincible = function(self, flag)
  -- function num : 0_92
  self._bsc_hasUsedGM = true
  ;
  (self._bsc_battleWorld):SetIsLeftGMInvincible(flag)
end

NewBattleSceneController.GMSetEnemyPlayerInvincible = function(self, flag)
  -- function num : 0_93
  self._bsc_hasUsedGM = true
  ;
  (self._bsc_battleWorld):SetIsRightGMInvincible(flag)
end

NewBattleSceneController.GMSetSecondHurtState = function(self, state, entityId)
  -- function num : 0_94 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_ChangeSecondHurtShowState, self, {state = state, entityId = entityId})
end

NewBattleSceneController.ChangeEntityBehavior = function(self, behaviorName, entityId)
  -- function num : 0_95 , upvalues : _ENV
  local entity = nil
  for i,e in ipairs((self._bsc_battleWorld)._entitys) do
    if e._entityId == entityId then
      entity = e
      break
    end
  end
  do
    local oldBehavior = (entity:GetComponent((BattleECS.Components).BehaviorComponent))._behavior
    local newBehavior = (BehaviorManager.NewBehavior)("newbattle/" .. behaviorName)
    newBehavior._behaviorSkillList = oldBehavior._behaviorSkillList
    newBehavior._data = oldBehavior._data
    newBehavior._entityId = oldBehavior._entityId
    newBehavior._battleworld = oldBehavior._battleworld
    newBehavior:SetTree()
    ;
    (entity:GetComponent((BattleECS.Components).BehaviorComponent))._behavior = newBehavior
  end
end

NewBattleSceneController.GMFullEnergyPower = function(self)
  -- function num : 0_96
  self._bsc_hasUsedGM = true
  ;
  (self._bsc_battleWorld):FullEnergyPower()
end

return NewBattleSceneController

