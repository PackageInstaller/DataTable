local BattleSceneHelper = CS.PixelNeko.P1.Scene.Battle.BattleSceneHelper
local EventTriggerHelper = CS.PixelNeko.P1.TimeLine.EventTriggerHelper
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local TimeSkillStaticFunctions = CS.PixelNeko.Lua.TimeSkillStaticFunctions
local GameObjectHelper = CS.PixelNeko.Common.GameObjectHelper
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local StateEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local Queue = require("framework.queue")
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local BattleWorld = require("logic.newbattle.battleworld")
local SoulTask = require("logic.scene.types.soultask")
local LuaCodeVersionManager = require("logic.manager.luacodeversionmanager")
local SystemType = require("protocols.bean.protocol.common.systemtype")
local codeVersionFile = require("protocols.def.protocol.battle.cbattleend")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local BattleResultType = require("protocols.bean.protocol.battle.battleresult")
local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
local CRoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSkillBehaviorTable = BeanManager.GetTableByName("skill.cskillbehavior")
local CBattleConfig = BeanManager.GetTableByName("battle.cbattleconstcfg")
local CSkillEffectTable = BeanManager.GetTableByName("skill.cskilleffect")
local CBuffEffectTable = BeanManager.GetTableByName("buff.cbuffeffect")
local CBattleGuideLinkConfig = BeanManager.GetTableByName("guide.cbattleguidelinkconfig")
local SoundLevelTable = BeanManager.GetTableByName("setting.csoundlevel")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CResourceDungeonStageDialog = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstagedialog")
local CBattleSceneCfg = BeanManager.GetTableByName("scene.cbattlescenecfg")
local CBeatMelonConfig = BeanManager.GetTableByName("activity.cbeatmelonconfig")
local SRoleCreate = BattleClientProtocolManager.GetProtocolDef("action.srolecreate")
local SRoleChangeShapeAndAttribute = BattleClientProtocolManager.GetProtocolDef("action.srolechangeshapeandattribute")
local SRoleSummon = BattleClientProtocolManager.GetProtocolDef("action.srolesummoncreate")
local BattleEndType = BattleClientProtocolManager.GetBeanDef("data.battleendtype")
local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
local LineUpStation = BattleClientProtocolManager.GetBeanDef("data.lineupstation")
local CSRChallengeBattle = BeanManager.GetTableByName("activity.csrchallengebattle")
local NewBattleSceneController = class("NewBattleSceneController", SceneController)
local AnimatorListTypeEnum = {EMengAnimator = 1}

function NewBattleSceneController:Ctor(sceneRef)
  NewBattleSceneController.super.Ctor(self, sceneRef)
  self._bsc_localProtocolData = Queue.Create()
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
  self._actorTimeSkillChangeValueTask = {
    timeCount = nil,
    dataValue = {},
    isOver = false
  }
  self._bsc_animatorGroup = {}
  self._bsc_battleCameraAnimationInfo = {
    cameraMoveType,
    moveDelayTime,
    resetDelayTime,
    currentTime,
    skillId
  }
  self._bsc_battleNewMainUIActiveState = false
  self._bsc_canEnterAccountsState = false
  self._bsc_isBossViolent = false
end

function NewBattleSceneController:Init()
  NewBattleSceneController.super.Init(self)
  LuaNotificationCenter.AddObserver(self, self.BSC_OnBattleAwardDialogClosed, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  local battleSceneCfgRecorder = CBattleSceneCfg:GetRecorder(self:GetSceneID())
  if battleSceneCfgRecorder and battleSceneCfgRecorder.hasBulletTime == 1 then
    if not self._sceneRef:BSR_GetEndTimeLineTransform() then
      LogWarning("NewBattleSceneController", "Maybe There is no End Camera Parameter for Bullet Time")
    end
    self._bsc_canWaitingForEndTimeline = true
    StateEventTriggerHelper.AddAnimationEventListener(self._sceneRef:BSR_GetBattleCamera().gameObject, "CameraBlendKill", self.OnEndBattleCameraAnimation, self)
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
  if self._sceneRef:BSR_GetStartTimeLineTransform() then
    self._bsc_canWaitingForStartTimeline = true
    EventTriggerHelper.AddTriggerBehaviourPlayListener(self._sceneRef:BSR_GetStartTimeLineTransform(), self.OnStartTriggerBehaviourPlay, self)
  else
    self._bsc_canWaitingForStartTimeline = false
  end
  local categoryRecord = SoundLevelTable:GetRecorder(4)
  if categoryRecord then
    LuaAudioManager.PauseCategory(tonumber(categoryRecord.categoryID), false)
  end
  self._bsc_animatorGroup[AnimatorListTypeEnum.EMengAnimator] = AnimatorStaticFunctions.Get(self._sceneRef:BSR_GetEMengAnimatorGameObject())
  self._bsc_battlePosList = {}
  local posFile = require("data.battledata.scenepos." .. string.lower(self:GetSceneName()))
  for i = 1, #posFile do
    local currentIndexPos = posFile[i]
    local x, y, z = currentIndexPos.x, currentIndexPos.y, currentIndexPos.z
    if x and y and z then
      self._bsc_battlePosList[i] = {
        x = fixedpoint(x) * 1000,
        y = fixedpoint(y) * 1000,
        z = fixedpoint(z) * 1000
      }
    else
      LogErrorFormat("NewBattleSceneController", "pos index %s get x %s y %s z %s", i, x, y, z)
    end
  end
  if self._sceneRef:BSR_GetBattleCamera() then
    StateEventTriggerHelper.AddStateEnterListener(self._sceneRef:BSR_GetBattleCamera().gameObject, self.BSR_OnBattleCameraStateEnter, self)
  end
end

function NewBattleSceneController:Update(deltaTime, unscaleDeltaTime)
  if self._bsc_deltaTime_count then
    if 0.05 < unscaleDeltaTime then
      self._bsc_deltaTime_count = self._bsc_deltaTime_count + 1
    else
      self._bsc_deltaTime_count = 0
    end
    if self._bsc_deltaTime_count >= 5 then
      local plat = CS.PixelNeko.LuaManager.GetSystemType()
      self._bsc_deltaTime_count = nil
      if plat ~= SystemType.UNITY then
        local csend = LuaNetManager.CreateProtocol("protocol.user.crecordlowframebattle")
        csend.fps = 1 / unscaleDeltaTime
        csend.roles = ""
        local strResult = ""
        local leftBattlers = NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()
        for _, battler in pairs(leftBattlers) do
          local x, y, z = battler:GetPosition()
          strResult = strResult .. tostring(battler:GetConfigId()) .. "@[x" .. tostring(x) .. ",y" .. tostring(y) .. ",z" .. tostring(z) .. "]"
          csend.roles = csend.roles .. strResult
          strResult = ","
        end
        strResult = ","
        local rightBattlers = NekoData.BehaviorManager.BM_Battle:GetRightBattlers()
        for _, battler in pairs(rightBattlers) do
          local x, y, z = battler:GetPosition()
          strResult = strResult .. tostring(battler:GetConfigId()) .. "@[x" .. tostring(x) .. ",y" .. tostring(y) .. ",z" .. tostring(z) .. "]"
          csend.roles = csend.roles .. strResult
          strResult = ","
        end
        csend.effect = ""
        strResult = ""
        local effectCount = CS.PixelNeko.P1.Scene.Battle.BattleSceneHelper.GetEffectCount()
        for key, value in pairs(effectCount) do
          strResult = strResult .. tostring(key) .. "@" .. tostring(value)
          csend.effect = csend.effect .. strResult
          strResult = ","
        end
        csend:Send()
      end
    end
  end
  if self._bsc_battleFSM then
    if GlobalGameFSM and GlobalGameFSM:GetCurrentState() ~= "Init" then
      self._bsc_battleFSM:Update()
      require("logic.fsm.battlefsm." .. string.lower(self._bsc_battleFSM:GetCurrentState())).Update(self, deltaTime)
    else
      self._bsc_battleFSM = nil
    end
  end
  if self._bsc_canPlayStartTimeline then
    self._bsc_canPlayStartTimeline = false
    if self._sceneRef:BSR_GetStartTimeLine() then
      AnimationHelper.SetAnimatorInteger2(self._sceneRef:BSR_GetBattleCamera().gameObject, "camState", 0)
      self._sceneRef:BSR_GetStartTimeLine():Play()
      if self._bsc_timerForceStartBattle then
        if self._bsc_battleStartTimeTask then
          GameTimer.RemoveTask(self._bsc_battleStartTimeTask)
          self._bsc_battleStartTimeTask = nil
        end
        self._bsc_battleStartTimeTask = GameTimer.AddTask(2.5, -1, function()
          self._bsc_hasStartBattleLogic = true
          LogInfo("NewBattleSceneController", "_bsc_battleStartTimeTask time bingo")
          self:BSC_BeginUpdateBattleWorld()
          local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
          if dialog then
            dialog:GetRootWindow():SetAlpha(1)
            self._bsc_battleNewMainUIActiveState = true
          end
        end)
      end
    end
  end
  for entityId, v in pairs(self._alternateRoleEnterTask) do
    if v.task:update(deltaTime) then
      local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(entityId)
      if battler and battler:IsAlive() then
        battler:PlayAnimation("BattleIdle")
      end
      TransformStaticFunctions.SetPosition(v.gameObject, v.x, v.y, v.z)
      self._alternateRoleEnterTask[entityId] = nil
    else
      TransformStaticFunctions.SetPosition(v.gameObject, v.task.subject.pos, v.y, v.z)
    end
  end
end

function NewBattleSceneController:OnDestroy()
  NewBattleSceneController.super.OnDestroy(self)
  if self._bsc_battleStartTimeTask then
    GameTimer.RemoveTask(self._bsc_battleStartTimeTask)
    self._bsc_battleStartTimeTask = nil
  end
  TimeSkillStaticFunctions.RemoveTimeSkill(self._sceneRef:BSR_GetBattleMainCamera())
  DialogManager.DestroySingletonDialog("dungeon.battlecrossdialog")
  DialogManager.DestroySingletonDialog("newbattle.battlenewmaindialog")
  DialogManager.DestroySingletonDialog("debug.battlegmdialog")
  DialogManager.DestroySingletonDialog("teamedit.teamtestgmdialog")
  NekoData.DataManager.DM_Battle:Clear()
  LuaNotificationCenter.RemoveObserver(self)
end

function NewBattleSceneController:BSC_OnBattleAwardDialogClosed(notification)
  if notification.userInfo._dialogKey == self._bsc_awardDialogKey then
    self._bsc_battleFSM:SetBoolean("toBattleEnd", true)
  end
end

function NewBattleSceneController:OnNPCChatEnd(notification)
  if notification.userInfo == self._battle_pause_chatId then
    self._bsc_battleFSM:SetBoolean("chatDialogEnd", true)
  elseif notification.userInfo == self._bsc_resourceBattleEndDialogId then
    self._bsc_battleFSM:SetBoolean("toAccounts", true)
    self._bsc_resourceBattleEndDialogId = nil
  end
end

function NewBattleSceneController:BSC_GetStepNum()
  return self._bsc_stepNum
end

function NewBattleSceneController:BSC_InitBattleScene(battleId, battleType)
  CS.PixelNeko.Lua.Cinemachine.CinemachineVirtualCameraStaticFunctions.SetPriority(self._sceneRef._bsr_startCamera, 10)
  CS.PixelNeko.Lua.Cinemachine.CinemachineVirtualCameraStaticFunctions.SetPriority(self._sceneRef._bsr_victoryCamera, 0)
  self._bsc_battleStepTimeCount = 0
  self._bsc_battleTime = 0
  self._bsc_stepNum = 0
  NekoData.DataManager.DM_Battle:Clear()
  NekoData.DataManager.DM_Battle:SetBattleId(battleId, self, battleType)
  self._bsc_soulTasks = 0
  self._bsc_ifOneBattleHasSendCBattleEnd = false
  self._bsc_battleFSM = BattleFSM.Create()
  self._bsc_battleFSM:Init()
  self._bsc_battleFSM:SetStateEnterCallBack(self.BSC_OnStateEnter, self)
  self._bsc_battleFSM:SetStateExitCallBack(self.BSC_OnStateExit, self)
end

function NewBattleSceneController:BSC_OnStateEnter(currentState, lastState)
  if self._bsc_battleFSM then
    require("logic.fsm.battlefsm." .. string.lower(self._bsc_battleFSM:GetCurrentState())).OnEnter(self, lastState)
  end
end

function NewBattleSceneController:BSC_OnStateExit(currentState, nextState)
  if self._bsc_battleFSM then
    require("logic.fsm.battlefsm." .. string.lower(self._bsc_battleFSM:GetCurrentState())).OnExit(self, nextState)
  end
end

local function OnSBattleStart(self, protocol)
  self._sendprotocolList = {}
  self:BSC_InitBattleScene(protocol.battleid, protocol.battleType)
  self._bsc_battleStartProtocol = protocol
  NekoData.DataManager.DM_Battle:SetAutoBattleInfo(protocol.auto)
  self:BSC_InitBattle()
  LogInfoFormat("NewBattleSceneController", "-OnSBattleStart- autoFight = %s, orderSKill.roleId = %s, orderSKill.skillId = %s, disorderSkill.roleId = %s, disorderSkill.skillId = %s ---", protocol.auto.autoFight, protocol.auto.orderSKill.roleId, protocol.auto.orderSKill.skillId, protocol.auto.disorderSkill.roleId, protocol.auto.disorderSkill.skillId)
  LogInfo("NewBattleSceneController", "eruptSkill List---------")
  for roleId, skillId in pairs(protocol.auto.eruptSkill) do
    LogInfoFormat("NewBattleSceneController", "roleid %s skillid %s", roleId, skillId)
  end
end

function NewBattleSceneController:OnStartTriggerBehaviourPlay(doubleValue, longValue, stringValue, objectValue)
  if stringValue == "CreateRole" then
    LogInfo("NewBattleSceneController", "OnStartTriggerBehaviourPlay CreateRole")
    local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
    OnSBattleStart(self, protocol)
  elseif stringValue == "Start" then
    if self._bsc_battleStartTimeTask then
      GameTimer.RemoveTask(self._bsc_battleStartTimeTask)
      self._bsc_battleStartTimeTask = nil
    end
    LogInfoFormat("NewBattleSceneController", "OnStartTriggerBehaviourPlay Start self._bsc_hasStartBattleLogic %s", self._bsc_hasStartBattleLogic)
    if not self._bsc_hasStartBattleLogic then
      self:BSC_BeginUpdateBattleWorld()
      local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
      if dialog then
        dialog:GetRootWindow():SetAlpha(1)
        self._bsc_battleNewMainUIActiveState = true
      end
    end
  end
end

function NewBattleSceneController:BSC_InitBattle()
  self._bsc_battleNewMainUIActiveState = false
  self:BSC_BeginCreatePlayer()
  if self._bsc_canWaitingForStartTimeline and not self._bsc_battleReconnectState then
    LogInfo("NewBattleSceneController", "Waiting for battle start timeline")
    local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
    if dialog then
      dialog:GetRootWindow():SetAlpha(0)
    else
      self._bsc_battleNewMainUIActiveState = true
    end
  else
    self:BSC_BeginUpdateBattleWorld()
    self._bsc_battleNewMainUIActiveState = true
  end
end

function NewBattleSceneController:BSC_BeginCreatePlayer()
  self._bsc_upBattleTime = self._bsc_battleStartProtocol.battleDuration
  self._bsc_deltaTime_count = 0
  local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  self._bsc_localProtocolData:Clear()
  LogInfoFormat("NewBattleSceneController", "battleid %s guide %s battleDuration %s", self._bsc_battleStartProtocol.battleid, self._bsc_battleStartProtocol.guide, self._bsc_upBattleTime)
  if self._bsc_battleWorld then
    self._bsc_battleWorld:Destroy()
  end
  self._bsc_battleWorld = BattleWorld.Create(function(protocol)
    self:BSC_SendProtocolToViewController(protocol)
  end, self._bsc_battleStartProtocol.battleid, self._id, self._bsc_battleStartProtocol.battleBuffs, self._bsc_battlePosList)
  self._bsc_battleWorld:SetAssistData(self._bsc_battleStartProtocol.assist)
  self._bsc_battleWorld:SetRandomSeed(self._bsc_battleStartProtocol.seed)
  local stationNumList = {
    LineUpStation.FRONT_ROW,
    LineUpStation.MIDDLE_ROW,
    LineUpStation.BACK_ROW
  }
  local initialTagType = {Not = 0, Is = 1}
  local leftRoleList = {}
  local leftAllRoleList = {}
  for _, i in ipairs(stationNumList) do
    local fighter = self._bsc_battleStartProtocol.left[i]
    local alternateFighter, alternateI
    if i == LineUpStation.FRONT_ROW then
      alternateI = LineUpStation.ALTERNATE_FRONT_ROW
      alternateFighter = self._bsc_battleStartProtocol.left[alternateI]
    elseif i == LineUpStation.MIDDLE_ROW then
      alternateI = LineUpStation.ALTERNATE_MIDDLE_ROW
      alternateFighter = self._bsc_battleStartProtocol.left[alternateI]
    elseif i == LineUpStation.BACK_ROW then
      alternateI = LineUpStation.ALTERNATE_BACK_ROW
      alternateFighter = self._bsc_battleStartProtocol.left[alternateI]
    end
    if fighter then
      LogInfoFormat("newbattlescenecontroller", "left role id %s", fighter.id)
      table.insert(leftRoleList, fighter.id)
      table.insert(leftAllRoleList, fighter.id)
      local fighterBean = self:BSC_InitServerPlayer(Enum_Camp.LeftFighter, i, fighter, alternateFighter ~= nil)
      local alternateFighterBean
      if alternateFighter and alternateI then
        table.insert(leftAllRoleList, alternateFighter.id)
        LogInfoFormat("NewBattleSceneController", "alternateleft role id %s", alternateFighter.id)
        alternateFighterBean = self:BSC_InitServerPlayer(Enum_Camp.LeftFighter, alternateI, alternateFighter)
      end
      self._bsc_battleWorld:CreateLeftPlayer(fighterBean, {
        alternateFighterBean = alternateFighterBean,
        isInitial = initialTagType.Is
      })
    end
  end
  for i = 1, 5 do
    local fighter = self._bsc_battleStartProtocol.right[i]
    if fighter then
      LogInfoFormat("NewBattleSceneController", "right role id %s", fighter.id)
      local fighterBean = self:BSC_InitServerPlayer(Enum_Camp.RightFighter, i, fighter)
      self._bsc_battleWorld:CreateRightPlayer(fighterBean, {
        isInitial = initialTagType.Is
      })
    end
  end
  local dialog = DialogManager.CreateSingletonDialog("newbattle.battlenewmaindialog")
  if dialog then
    dialog:SetBattleWorld(self._bsc_battleWorld)
    local battleId = self._bsc_battleStartProtocol.battleid
    if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AssistBattle) and battleId ~= 1120 and battleId ~= 1122 and self._bsc_battleStartProtocol.assist and self._bsc_battleStartProtocol.assist.id ~= 0 and self._bsc_battleStartProtocol.battleType ~= CBattleStartProtocol.BOSS_RUSH and self._bsc_battleStartProtocol.battleType ~= CBattleStartProtocol.WEEK_BOSS and self._bsc_battleStartProtocol.battleType ~= CBattleStartProtocol.TEST then
      LogInfoFormat("NewBattleSceneController", "assistroleid %s leftAssistNum %s totalAssistNum %s", self._bsc_battleStartProtocol.assist.id, self._bsc_battleStartProtocol.leftAssistNum, self._bsc_battleStartProtocol.totalAssistNum)
      dialog:AddAssistRole(self._bsc_battleStartProtocol.assist, self._bsc_battleStartProtocol.leftAssistNum, self._bsc_battleStartProtocol.totalAssistNum)
    end
    if battleId == 1184 then
      DialogManager.CreateSingletonDialog("teamedit.teamtestgmdialog")
    end
  end
  if self._bsc_battleStartProtocol.guide ~= 0 then
    LuaNotificationCenter.PostNotification(Common.n_InBattleGuide, self, CBattleGuideLinkConfig:GetRecorder(self._bsc_battleStartProtocol.guide).time)
  end
  local leftLineupList = {}
  leftLineupList.element = {}
  leftLineupList.vocation = {}
  for _, id in ipairs(leftAllRoleList) do
    local recorder = CRoleConfigTable:GetRecorder(id)
    if recorder then
      if leftLineupList.element[recorder.element] then
        leftLineupList.element[recorder.element] = leftLineupList.element[recorder.element] + 1
      else
        leftLineupList.element[recorder.element] = 1
      end
      if leftLineupList.vocation[recorder.vocation] then
        leftLineupList.vocation[recorder.vocation] = leftLineupList.vocation[recorder.vocation] + 1
      else
        leftLineupList.vocation[recorder.vocation] = 1
      end
    else
      LogErrorFormat("NewBattleSceneController", "No Exist croleconfig ID: %s", id)
    end
  end
  self._bsc_battleWorld:SetLeftLineupInfo(leftLineupList)
  self._bsc_battleWorld:SetWorldState("start")
  self._bsc_battleWorld:UpdataZero()
  self:BSC_UpdateLocalProtocol()
  self:PlayBattleStartVoice(leftRoleList)
end

function NewBattleSceneController:BSC_BeginUpdateBattleWorld()
  self._bsc_battleFSM:SetBoolean("toBattle", true)
  self._bsc_battleFSM:Update()
end

function NewBattleSceneController:PlayBattleStartVoice(leftRoleList)
  local roleList = leftRoleList
  if #roleList == 0 then
    LogError("NewBattleSceneController", "there is no role in battle fighter list, play battlestart voice failed")
  else
    local i = math.random(1, #roleList)
    NekoData.BehaviorManager.BM_Voice:PlayBattleVoice(roleList[i], NekoData.BehaviorManager.BM_Voice.VoiceType.BattleStart, nil)
  end
end

function NewBattleSceneController:BSC_UpdateBattleLogic(deltaTime)
  self._bsc_battleStepTimeCount = self._bsc_battleStepTimeCount + deltaTime
  self._bsc_battleTime = self._bsc_battleTime + deltaTime
  if self._bsc_battleTime > self._bsc_upBattleTime then
    self._bsc_battleTime = 0
    local protocol = BattleClientProtocolManager.CreateProtocol("action.cbattlekill")
    local isSummerActivityTimeBattle = false
    local battleProtocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
    if battleProtocol.battleType == CBattleStartProtocol.SUMMER and table.contain(CBeatMelonConfig:GetAllIds(), battleProtocol.id) then
      isSummerActivityTimeBattle = true
    end
    local isSpringBattle = false
    if battleProtocol.battleType == CBattleStartProtocol.SPRING_FESTIVAL then
      isSpringBattle = true
    end
    local isAnniversaryLimitedBattle = false
    if battleProtocol.battleType == CBattleStartProtocol.ANNIVERSARY and NekoData.BehaviorManager.BM_Anniversary:IsDailyBossLevel(battleProtocol.id) then
      isAnniversaryLimitedBattle = true
    end
    if isSummerActivityTimeBattle or isSpringBattle or isAnniversaryLimitedBattle then
      protocol.type = BattleEndType.LeftWinOverTime
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100113)
      protocol.type = BattleEndType.RightWinOverTime
    end
    self:BSC_SendProtocolToLogicWorld(protocol)
  end
  while self._bsc_battleStepTimeCount >= 0.03333333333333333 do
    self._bsc_battleStepTimeCount = self._bsc_battleStepTimeCount - 0.03333333333333333
    if self._bsc_battleFSM:GetCurrentState() == "Battle" and not self._bsc_battleTimeLine then
      self:BSC_UpdateBattleLogicOneStep()
    end
  end
end

function NewBattleSceneController:BSC_BattleLogicEnd()
  self:BSC_DestroyBattleWorld()
end

function NewBattleSceneController:BSC_DestroyBattleWorld()
  NekoData.DataManager.DM_Battle:ClearProjectileEffects()
  NekoData.DataManager.DM_Battle:ClearSceneEffects()
  self._bsc_battleWorld:Destroy()
  self._bsc_battleWorld = nil
end

function NewBattleSceneController:BSC_SendBattleEndProtocol()
  if self._bsc_battleStartProtocol then
    local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
    local req = LuaNetManager.CreateProtocol("protocol.battle.cbattleend")
    if self._bsc_battleStartProtocol.battleType == CBattleStartProtocol.TOWER or self._bsc_battleStartProtocol.battleType == CBattleStartProtocol.ANNIVERSARY then
      for k, v in pairs(NekoData.BehaviorManager.BM_Battle:GetEnemySideRolesInfo()) do
        if v.key > 0 then
          req.enemyStatuses[v.key] = LuaNetManager.CreateBean("protocol.battle.status")
          if self._bsc_battleStartProtocol.battleType == CBattleStartProtocol.ANNIVERSARY and v.hp > v.hpmax then
            v.hp = v.hpmax
          end
          if self._bsc_battleStartProtocol.battleType == CBattleStartProtocol.ANNIVERSARY then
            req.enemyStatuses[v.key].leftHp = math.ceil(v.hp / v.hpmax * 100)
          else
            req.enemyStatuses[v.key].leftHp = math.floor(v.hp / v.hpmax * 100)
          end
          LogInfoFormat("NewBattleSceneController", "cbattleend enemyStatuses key %s roleid %s hp %s", v.key, v.id, v.hp)
        end
      end
    end
    req.battletype = self._bsc_battleStartProtocol.battleType
    req.id = self._bsc_battleStartProtocol.id
    if BattleEndType.LeftWin == self._bsc_battleResult then
      req.result = req.BATTLE_SUCCESS
      if self._bsc_hasUsedGM then
        req.result = req.BATTLE_SUCCESS_GM
      end
    elseif BattleEndType.RightWin == self._bsc_battleResult then
      req.result = req.BATTLE_FAIL
      if self._bsc_hasUsedGM then
        req.result = req.BATTLE_FAIL_GM
      end
    elseif BattleEndType.Retreat == self._bsc_battleResult then
      req.result = req.BATTLE_RETREAT
    elseif BattleEndType.Drawn == self._bsc_battleResult then
      req.result = req.BATTLE_TIE
    elseif BattleEndType.LeftWinCBattleKill == self._bsc_battleResult then
      req.result = req.BATTLE_SUCCESS_GM
    elseif BattleEndType.SkipWin == self._bsc_battleResult then
      req.result = req.BATTLE_SUCCESS_SKIP
    elseif BattleEndType.RightWinCBattleKill == self._bsc_battleResult then
      req.result = req.BATTLE_FAIL_GM
    elseif BattleEndType.RightWinOverTime == self._bsc_battleResult then
      req.result = req.BATTLE_FAIL_TIMEOUT
    elseif BattleEndType.LeftWinOverTime == self._bsc_battleResult then
      req.result = req.BATTLE_SUCCESS_TIMEOUT
    elseif BattleEndType.LoseSettle == self._bsc_battleResult then
      req.result = req.BATTLE_SETTLE
    end
    for k, v in pairs(NekoData.BehaviorManager.BM_Battle:GetOwnSideRolesInfo()) do
      if v.key > 0 then
        req.statuses[v.key] = LuaNetManager.CreateBean("protocol.battle.status")
        if self._bsc_battleStartProtocol.battleType == CBattleStartProtocol.TOWER then
          req.statuses[v.key].leftHp = math.floor(v.hp * 100 / v.hpmax)
        else
          req.statuses[v.key].leftHp = math.floor(v.hp)
        end
        LogInfoFormat("NewBattleSceneController", "cbattleend statuses key %s roleid %s hp %s", v.key, v.id, v.hp)
        if 0 < #v.onceequipskills then
          local bean = LuaNetManager.CreateBean("protocol.battle.usedequipskills")
          bean.roleId = v.id
          for _, skillid in ipairs(v.onceequipskills) do
            table.insert(bean.skillIds, skillid)
          end
          table.insert(req.skills, bean)
        end
      end
    end
    req.isAssisted = self._bsc_isUsePartner
    for _, s in ipairs(self._sendprotocolList) do
      local battleverifyinfo = LuaNetManager.CreateBean("protocol.battle.battleverifyinfo")
      local battleverifyproparam = LuaNetManager.CreateBean("protocol.battle.battleverifyproparam")
      battleverifyproparam.entityId = s.content.entityId or 0
      battleverifyproparam.skillid = s.content.skillid or 0
      battleverifyproparam.gmresult = s.content.gmresult or 0
      battleverifyinfo.content = battleverifyproparam
      battleverifyinfo.ptype = s.ptype
      battleverifyinfo.step = s.step
      table.insert(req.operate.beanList, battleverifyinfo)
    end
    req.stepNum = self._bsc_stepNum
    req.auto = NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo()
    LogInfoFormat("NewBattleSceneController", "-BSC_SendBattleEndProtocol- autoFight = %s, orderSKill.roleId = %s, orderSKill.skillId = %s, disorderSkill.roleId = %s, disorderSkill.skillId = %s; stepNum %s ---", req.auto.autoFight, req.auto.orderSKill.roleId, req.auto.orderSKill.skillId, req.auto.disorderSkill.roleId, req.auto.disorderSkill.skillId, req.stepNum)
    LogInfo("NewBattleSceneController", "---------eruptSkill List---------")
    for roleId, skillId in pairs(req.auto.eruptSkill) do
      LogInfoFormat("NewBattleSceneController", "roleid %s skillid %s", roleId, skillId)
    end
    for k, v in pairs(self._bsc_battleWorld:GetRightPlayerList()) do
      if BattleECS.Utility.Utility.IsRoleDead(v) then
        local id = v:GetComponent(BattleECS.Components.TypeComponent)._roleID
        req.killMonsterNum[id] = req.killMonsterNum[id] or 0
        req.killMonsterNum[id] = req.killMonsterNum[id] + 1
      end
    end
    for _, v in pairs(self._bsc_battleWorld:GetLeftPlayerList()) do
      local id = v:GetComponent(BattleECS.Components.TypeComponent)._roleID
      local skillList = v:GetComponent(BattleECS.Components.SkillComponent)._useActSkillList
      local str = ""
      for skillid, times in pairs(skillList) do
        str = str .. tostring(skillid) .. "@" .. tostring(times) .. ";"
      end
      req.skillinfo[id] = str
    end
    if 0 < self._bsc_battleWorld:GetRightCampSkillInterruptedTime() then
      req.interrupt = 1
    else
      req.interrupt = 0
    end
    local damageList = NekoData.BehaviorManager.BM_Battle:GetCurrentBattleDamage()
    local totalDamage = 0
    for key, v in pairs(damageList) do
      if v.camp == Enum_Camp.LeftFighter then
        totalDamage = totalDamage + v.num
      end
    end
    req.totalDamage = totalDamage
    req.versions[codeVersionFile.Lua_Code_Version] = LuaCodeVersionManager.GetLuaCodeVersion()
    req.versions[codeVersionFile.Battle_Data_Version] = LuaCodeVersionManager.GetBattleDataVersion()
    req.versions[codeVersionFile.Behavior_Version] = LuaCodeVersionManager.GetBehaviorVersion()
    req.versions[codeVersionFile.Dungeon_Data_Version] = LuaCodeVersionManager.GetDungeonDataVersion()
    req.versions[codeVersionFile.Excel_Data_Version] = LuaCodeVersionManager.GetExcelDataVersion()
    if NekoData.BehaviorManager.BM_Game:GetClosedClient() then
      req.reconnection = 1
      NekoData.DataManager.DM_Login:SetCBattleEndInfo(clone(req), self._bsc_battleResult, clone(self._bsc_battleStartProtocol))
    else
      req.reconnection = 0
      req:Send(true)
    end
    self._bsc_battleReconnectState = false
    self._bsc_hasUsedGM = false
    self._bsc_battleWorld:SetRightCampSkillInterruptedTime(0)
  end
end

function NewBattleSceneController:BSC_UpdateBattleLogicOneStep()
  self._bsc_stepNum = self._bsc_stepNum + 1
  self._bsc_battleWorld:Update()
  self:BSC_UpdateLocalProtocol()
  LuaNotificationCenter.PostNotification(Common.n_FrameNumUsed, NewBattleSceneController, self._bsc_stepNum)
  if self._actorTimeSkillChangeValueTask.timeCount then
    local allDataUseOver = true
    for key, v in pairs(self._actorTimeSkillChangeValueTask.dataValue) do
      allDataUseOver = false
      for index = #v, 1, -1 do
        local value = v[index]
        if value.timestamp == self._actorTimeSkillChangeValueTask.timeCount then
          TimeSkillStaticFunctions.AddTimeSkillPropertyValue(self._sceneRef:BSR_GetBattleMainCamera(), key, value.value)
          table.remove(v, index)
        end
      end
      if #v == 0 then
        self._actorTimeSkillChangeValueTask.dataValue[key] = nil
      end
    end
    if allDataUseOver then
      self._actorTimeSkillChangeValueTask.timeCount = nil
      if self._actorTimeSkillChangeValueTask.isOver then
        TimeSkillStaticFunctions.DisableTimeSkill(self._sceneRef:BSR_GetBattleMainCamera())
      end
    else
      self._actorTimeSkillChangeValueTask.timeCount = self._actorTimeSkillChangeValueTask.timeCount + 1
    end
  end
  if self._bsc_battleCameraAnimationInfo.moveDelayTime then
    self._bsc_battleCameraAnimationInfo.currentTime = self._bsc_battleCameraAnimationInfo.currentTime + 1
    if self._bsc_battleCameraAnimationInfo.currentTime > self._bsc_battleCameraAnimationInfo.moveDelayTime then
      self._bsc_battleCameraAnimationInfo.moveDelayTime = nil
      self._bsc_battleCameraAnimationInfo.skillId = 0
      AnimationHelper.SetAnimatorInteger2(self._sceneRef:BSR_GetBattleCamera().gameObject, "paraNum", self._bsc_battleCameraAnimationInfo.cameraMoveType)
    end
  elseif self._bsc_battleCameraAnimationInfo.resetDelayTime then
    self._bsc_battleCameraAnimationInfo.currentTime = self._bsc_battleCameraAnimationInfo.currentTime + 1
    if self._bsc_battleCameraAnimationInfo.currentTime > self._bsc_battleCameraAnimationInfo.resetDelayTime then
      self._bsc_battleCameraAnimationInfo.resetDelayTime = nil
      AnimationHelper.SetAnimatorBool2(self._sceneRef:BSR_GetBattleCamera().gameObject, "GoBack", true)
    end
  end
end

function NewBattleSceneController:BSC_ShowSoulAnimation()
  local leftBattler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(self._bsc_leftSoulBattlerId)
  local rightBattler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(self._bsc_rightSoulBattlerId)
  if leftBattler and rightBattler then
    if self._bsc_battleStartProtocol.battleid == 1120 then
      self._bsc_soulTasks = 2
      self._bsc_battleFSM:SetNumber("soulNum", self._bsc_soulTasks)
      local args = {}
      args.Player1_att = leftBattler:GetGameObject()
      args.Monster_att = rightBattler:GetGameObject()
      args.Monster_Animation = rightBattler:GetGameObject()
      local obj = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._sceneRef:GetRootGameObject(), "BehaviacTestTimeline")
      CS.PixelNeko.P1.TimeLine.TimelineManager.PlayTimelineBindObjectDynamically(obj, args)
      EventTriggerHelper.AddGraphStopListener(obj, function(self)
        self._bsc_soulTasks = 0
        self._bsc_battleFSM:SetNumber("soulNum", self._bsc_soulTasks)
      end, self)
    elseif self._bsc_battleStartProtocol.battleid == 1122 then
      self._bsc_soulTasks = 2
      self._bsc_battleFSM:SetNumber("soulNum", self._bsc_soulTasks)
      local args = {}
      args.Player1_att = leftBattler:GetGameObject()
      args.Monster_Animation = rightBattler:GetGameObject()
      local obj = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._sceneRef:GetRootGameObject(), "Base_FirstTimeline")
      CS.PixelNeko.P1.TimeLine.TimelineManager.PlayTimelineBindObjectDynamically(obj, args)
      EventTriggerHelper.AddGraphStopListener(obj, function(self)
        self._bsc_soulTasks = 0
        self._bsc_battleFSM:SetNumber("soulNum", self._bsc_soulTasks)
      end, self)
    end
  else
    if leftBattler then
      leftBattler:PlayAnimation("DeadDisappear")
    end
    if rightBattler then
      rightBattler:PlayAnimation("DeadDisappear")
    end
  end
end

function NewBattleSceneController:BSC_ShowVictoryAnimation()
  if not self._bsc_canWaitingForEndTimeline then
    CS.PixelNeko.Lua.Cinemachine.CinemachineVirtualCameraStaticFunctions.SetPriority(self._sceneRef._bsr_startCamera, 0)
    CS.PixelNeko.Lua.Cinemachine.CinemachineVirtualCameraStaticFunctions.SetPriority(self._sceneRef._bsr_victoryCamera, 10)
  end
  local battlers = NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()
  for k, battler in pairs(battlers) do
    if battler:IsAlive() then
      battler:PlayAnimation("Victory")
    end
  end
end

function NewBattleSceneController:OnEndBattleCameraAnimation(floatValue, intValue, stringValue, obj, clipName)
  if stringValue == "Slow" then
    LogInfo("NewBattleSceneController", "OnEndBattleCameraAnimator Slow")
    NekoData.DataManager.DM_TimeScale:SetBattleKillSpeed()
  elseif stringValue == "Normal" then
    LogInfo("NewBattleSceneController", "OnEndBattleCameraAnimator Normal")
    NekoData.DataManager.DM_TimeScale:CancelBattleKillSpeed()
    DialogManager.DestroySingletonDialog("newbattle.battlenewmaindialog")
    DialogManager.DestroySingletonDialog("debug.battlegmdialog")
    DialogManager.DestroySingletonDialog("teamedit.teamtestgmdialog")
    if self._bsc_battleEndProtocol then
      local record = CResourceDungeonStageDialog:GetRecorder(self._bsc_battleEndProtocol.battleResult.battleId)
      local WinType = {NotFirstWin = 0, FirstWin = 1}
      local resourceFirstWin = self._bsc_battleEndProtocol.battleResult.resourceFirstWin == WinType.FirstWin
      if record and resourceFirstWin then
        if record.popupID ~= 0 then
          local effect = EffectFactory.CreateDialogEffect(2, record.popupID)
          effect:Run()
          effect:Then(function()
            self._bsc_battleFSM:SetBoolean("toAccounts", true)
          end)
        elseif record.dialogID ~= 0 then
          self._bsc_resourceBattleEndDialogId = record.dialogID
          local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
          dialog:SetDialogLibraryId(self._bsc_resourceBattleEndDialogId)
        else
          self._bsc_battleFSM:SetBoolean("toAccounts", true)
        end
      else
        self._bsc_battleFSM:SetBoolean("toAccounts", true)
      end
    else
      self._bsc_canEnterAccountsState = true
    end
  end
end

function NewBattleSceneController:BSR_OnBattleCameraStateEnter(handle, stateName, normalizedTime)
  if stateName == "New State" then
    AnimationHelper.SetAnimatorBool2(self._sceneRef:BSR_GetBattleCamera().gameObject, "SkillReset", false)
    AnimationHelper.SetAnimatorBool2(self._sceneRef:BSR_GetBattleCamera().gameObject, "GoBack", false)
    AnimationHelper.SetAnimatorInteger2(self._sceneRef:BSR_GetBattleCamera().gameObject, "paraNum", 0)
  elseif stateName == "RightToReset" or stateName == "LeftToReset" then
    AnimationHelper.SetAnimatorBool2(self._sceneRef:BSR_GetBattleCamera().gameObject, "GoBack", false)
    AnimationHelper.SetAnimatorInteger2(self._sceneRef:BSR_GetBattleCamera().gameObject, "paraNum", 0)
  elseif stateName == "MoveToLeft" or stateName == "MoveToRight" or stateName == "BattleCameraShock1" or stateName == "BattleCameraShock2" or stateName == "BattleCameraShock3" or stateName == "BattleCameraShock4" or stateName == "BattleCameraShock5" or stateName == "BattleCameraShock6" or stateName == "BattleCameraShock7" then
    AnimationHelper.SetAnimatorInteger2(self._sceneRef:BSR_GetBattleCamera().gameObject, "paraNum", 0)
  end
end

function NewBattleSceneController:BSC_ShowAwards()
  local protocol = self._bsc_battleEndProtocol
  if not protocol then
    self._bsc_battleFSM:SetBoolean("toBattleEnd", true)
  else
    local record = CBattleInfoTable:GetRecorder(protocol.battleResult.battleId)
    self._nextSceneId = protocol.id
    LogInfoFormat("NewBattleSceneController", "----- sceneId = %s -----", protocol.id)
    if record.result == 1 then
      local userinfo = {}
      userinfo.itemlist = protocol.itemList
      NekoData.DataManager.DM_Dungeon:SetBattleResult(protocol.battleResult.result)
      NekoData.DataManager.DM_Dungeon:SetBattleAccountData(protocol.itemList, protocol.money, protocol.roleExp, protocol.battleTime, protocol.roleGoodExp, protocol.rolesIndex, protocol.playerExp)
      if protocol.battleResult.result == BattleResultType.SUCCESS or protocol.battleResult.result == BattleResultType.SETTLE then
        local battleType = self._bsc_battleFSM:GetParameter("battleType")
        if battleType == CBattleStartProtocol.PARTY_BOSS then
          self._bsc_battleFSM:SetBoolean("toBattleEnd", true)
        else
          DialogManager.DestroySingletonDialog("battle.battleaccount.battlewinaccountdialog")
          local dialog = DialogManager.CreateSingletonDialog("battle.battleaccount.battlewinaccountdialog")
          if dialog then
            self._bsc_awardDialogKey = dialog._dialogKey
            dialog:Show(false)
          else
            self._bsc_battleFSM:SetBoolean("toBattleEnd", true)
          end
        end
      elseif protocol.battleResult.result == -1 then
        self._bsc_battleFSM:SetBoolean("toBattleEnd", true)
      else
        self._bsc_battleFSM:SetBoolean("toBattleEnd", true)
      end
    else
      self._bsc_battleFSM:SetBoolean("toBattleEnd", true)
    end
  end
end

function NewBattleSceneController:BSC_BattleEnd()
  self._bsc_deltaTime_count = nil
  GlobalGameFSM:SetNumber("battleId", 0)
  if self._bsc_battleEndProtocol then
    local lastBattleType = self._bsc_battleEndProtocol.battleType
    local lastBattleId = self._bsc_battleEndProtocol.battleResult.battleId
    local lastBattleResult = self._bsc_battleEndProtocol.battleResult.result
    local eventListData = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):GetEventListData()
    if lastBattleType == CBattleStartProtocol.SUMMER_ECHO and lastBattleResult == 1 and eventListData then
      local allIds = CSRChallengeBattle:GetAllIds()
      local cfg = CSRChallengeBattle:GetRecorder(lastBattleId)
      if cfg and lastBattleId ~= allIds[#allIds] then
        NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):OpenEventListDialog()
      end
    end
  end
end

function NewBattleSceneController:BSC_Retreat()
  local protocol = BattleClientProtocolManager.CreateProtocol("action.cbattlekill")
  protocol.type = BattleEndType.Retreat
  self:BSC_SendProtocolToLogicWorld(protocol)
end

function NewBattleSceneController:OnSBattleStart(protocol)
  GlobalGameFSM:SetBoolean("toBreakOrReconnect", false)
  if NekoData.BehaviorManager.BM_Login:IfCanUseLocalCBattleEnd(protocol) then
    self._bsc_battleReconnectState = true
  end
  if not self._bsc_canWaitingForStartTimeline then
    OnSBattleStart(self, protocol)
  elseif self._bsc_battleReconnectState then
    if self._sceneRef:BSR_GetStartTimeLine() then
      AnimationHelper.SetAnimatorInteger2(self._sceneRef:BSR_GetBattleCamera().gameObject, "camState", 0)
      self._sceneRef:BSR_GetStartTimeLine().time = self._sceneRef:BSR_GetStartTimeLine().duration
      self._sceneRef:BSR_GetStartTimeLine():Play()
    end
    OnSBattleStart(self, protocol)
  else
    self._bsc_canPlayStartTimeline = true
    self._bsc_hasStartBattleLogic = false
  end
end

function NewBattleSceneController:OnSBattleEndProtocol(protocol, reconnect)
  self._bsc_battleEndProtocol = protocol
  if self._bsc_canEnterAccountsState or reconnect then
    DialogManager.DestroySingletonDialog("newbattle.battlenewmaindialog")
    DialogManager.DestroySingletonDialog("debug.battlegmdialog")
    DialogManager.DestroySingletonDialog("teamedit.teamtestgmdialog")
    local record = CResourceDungeonStageDialog:GetRecorder(protocol.battleResult.battleId)
    local WinType = {NotFirstWin = 0, FirstWin = 1}
    local resourceFirstWin = protocol.battleResult.resourceFirstWin == WinType.FirstWin
    if record and resourceFirstWin then
      if record.popupID ~= 0 then
        local effect = EffectFactory.CreateDialogEffect(2, record.popupID)
        effect:Run()
        effect:Then(function()
          self._bsc_battleFSM:SetBoolean("toAccounts", true)
        end)
      elseif record.dialogID ~= 0 then
        self._bsc_resourceBattleEndDialogId = record.dialogID
        local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
        dialog:SetDialogLibraryId(self._bsc_resourceBattleEndDialogId)
      else
        self._bsc_battleFSM:SetBoolean("toAccounts", true)
      end
    else
      self._bsc_battleFSM:SetBoolean("toAccounts", true)
    end
  end
end

function NewBattleSceneController:BSC_SendProtocolToViewController(protocol)
  self._bsc_localProtocolData:Push(protocol)
end

function NewBattleSceneController:BSC_SendProtocolToLogicWorld(protocol)
  if self._bsc_battleWorld then
    local pTable = {}
    if protocol.ProtocolType == 5 then
      pTable.entityId = protocol.entityId
      pTable.skillid = protocol.skillid
    elseif protocol.ProtocolType == 27 then
      pTable.gmresult = protocol.type
    elseif protocol.ProtocolType == 32 then
    elseif protocol.ProtocolType == 10 then
    end
    table.insert(self._sendprotocolList, {
      content = pTable,
      ptype = protocol.ProtocolType,
      step = self._bsc_stepNum
    })
    local result, error = xpcall(protocol.Process, function(err)
      LogErrorFormat("NewBattleSceneController", "BSC_SendProtocolToLogicWorld protocol process error %s", err)
    end, protocol, self._bsc_battleWorld)
  end
end

function NewBattleSceneController:BSC_UpdateLocalProtocol()
  while not self._bsc_battleTimeLine and self._bsc_localProtocolData:GetSize() > 0 do
    local protocol = self._bsc_localProtocolData:Pop()
    local result, error = xpcall(protocol.Process, function(err)
      LogErrorFormat("NewBattleSceneController", "BSC_UpdateLocalProtocol protocol process error %s", err)
    end, protocol, self)
    if self._bsc_battleTimeLine then
      break
    end
  end
end

function NewBattleSceneController:BSC_UpdateAllLocalProtocol()
  while self._bsc_localProtocolData:GetSize() > 0 do
    local protocol = self._bsc_localProtocolData:Pop()
    local result, error = xpcall(protocol.Process, function(err)
      LogErrorFormat("NewBattleSceneController", "BSC_UpdateAllLocalProtocol protocol process error %s", err)
    end, protocol, self)
  end
end

function NewBattleSceneController:SetBattleTimelineTag(flag)
  if self._bsc_battleTimeLine and not flag then
    LuaNotificationCenter.PostNotification(Common.n_BattlePauseStateChange, NewBattleSceneController, false)
  end
  self._bsc_battleTimeLine = flag
end

function NewBattleSceneController:BSC_InitServerPlayer(camp, posId, fighter, haveAlternate)
  local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  local bean = BattleClientProtocolManager.CreateBean("data.attribute")
  bean.id = fighter.id
  bean.key = posId
  bean.camp = camp
  local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
  bean.hp = fighter.attrs[AttrTypeEnum.HP]
  bean.hpmax = fighter.attrs[AttrTypeEnum.MAX_HP]
  bean.atk = fighter.attrs[AttrTypeEnum.ATTACK]
  bean.def = fighter.attrs[AttrTypeEnum.DEFEND]
  bean.mdef = fighter.attrs[AttrTypeEnum.MAGIC_DEFEND]
  bean.damage = fighter.attrs[AttrTypeEnum.DAMAGE] or 0
  bean.physicalbonus = fighter.attrs[AttrTypeEnum.PHYSICALBONUS] or 0
  bean.physicalreduce = fighter.attrs[AttrTypeEnum.PHYSICALREDUCE] or 0
  bean.magicbonus = fighter.attrs[AttrTypeEnum.MAGICBONUS] or 0
  bean.magicreduce = fighter.attrs[AttrTypeEnum.MAGICREDUCE] or 0
  bean.physicalcritrate = fighter.attrs[AttrTypeEnum.CRITRATE] or 0
  bean.physicalcritdegree = fighter.attrs[AttrTypeEnum.CRITDEGREE] or 0
  bean.attackspeed = fighter.attrs[AttrTypeEnum.ATTACKSPEED] or 0
  bean.magiclifesteal = fighter.attrs[AttrTypeEnum.MAGICLIFESTEAL] or 0
  bean.physicallifesteal = fighter.attrs[AttrTypeEnum.PHYSICALLIFESTEAL] or 0
  bean.physicalevasion = fighter.attrs[AttrTypeEnum.EVASION] or 0
  bean.physicalblock = fighter.attrs[AttrTypeEnum.PHYSICALBLOCK] or 0
  bean.magicblock = fighter.attrs[AttrTypeEnum.MAGICBLOCK] or 0
  bean.physicaldefbreak = fighter.attrs[AttrTypeEnum.PHYSICALDEFBREAK] or 0
  bean.magicdefbreak = fighter.attrs[AttrTypeEnum.MAGICDEFBREAK] or 0
  bean.critrateresistance = fighter.attrs[AttrTypeEnum.CRITRATERESISTANCE] or 0
  bean.critdegreeresistance = fighter.attrs[AttrTypeEnum.CRITDEGREERESISTANCE] or 0
  bean.extraphysicaldamage = fighter.attrs[AttrTypeEnum.EXTRAPHYSICALDAMAGE] or 0
  bean.extramagicdamage = fighter.attrs[AttrTypeEnum.EXTRAMAGICDAMAGE] or 0
  bean.curativebonus = fighter.attrs[AttrTypeEnum.CURATIVEBONUS] or 0
  bean.accuracy = fighter.attrs[AttrTypeEnum.ACCURACY] or 0
  bean.critratelevel = fighter.attrs[AttrTypeEnum.CRIT_LEVEL] or 0
  bean.critdegreelevel = fighter.attrs[AttrTypeEnum.CRIT_DEGREE_LEVEL] or 0
  bean.healingpower = fighter.attrs[AttrTypeEnum.HEALING_POWER] or 0
  bean.comborate1 = fighter.attrs[AttrTypeEnum.COMBORATE1] or 0
  bean.comborate2 = fighter.attrs[AttrTypeEnum.COMBORATE2] or 0
  bean.damagereduce = fighter.attrs[AttrTypeEnum.DAMAGE_REDUCE] or 0
  bean.runelv = fighter.attrs[AttrTypeEnum.RUNE_LV] or 0
  bean.baseskill = fighter.baseSkill or 0
  bean.passiveskill = fighter.passiveSkills or {}
  bean.bosshpstr = tostring(fighter.hpStrip)
  bean.level = fighter.level or 0
  bean.evolutionLevel = fighter.evolutionLevel or 0
  bean.exclusiveLevel = fighter.exclusiveLevel or 0
  bean.equipskilllist = fighter.equipSkills or {}
  bean.runeskilllist = fighter.runeSkill or {}
  bean.autoExploreSkill = fighter.autoExploreSkill or {}
  if haveAlternate then
    bean.havealternate = 1
  end
  for k, v in ipairs(fighter.skills) do
    table.insert(bean.skilllist, v)
  end
  local shapeRecorder
  local cskinRecoder = CSkin:GetRecorder(fighter.skinId)
  LogInfoFormat("NewBattleSceneController", "skinId %s", fighter.skinId)
  if cskinRecoder then
    shapeRecorder = CNpcShapeTable:GetRecorder(cskinRecoder.shapeID)
  else
    local roleRecoder = CRoleConfigTable:GetRecorder(fighter.id)
    roleRecoder = roleRecoder or CMonsterConfigTable:GetRecorder(fighter.id)
    if roleRecoder then
      shapeRecorder = CNpcShapeTable:GetRecorder(roleRecoder.shapeID)
    else
      LogErrorFormat("NewBattleSceneController", "fighter id %s dont have roleconfig or cmonsterconfig, so assetBundleName and prefabName are emptystring", fighter.id)
      shapeRecorder = {assetBundleName = "", prefabName = ""}
    end
  end
  bean.assetbundlename = shapeRecorder.assetBundleName
  bean.prefabname = shapeRecorder.prefabName
  if Enum_Camp.LeftFighter == camp then
    if bean.key == LineUpStation.FRONT_ROW or bean.key == LineUpStation.ALTERNATE_FRONT_ROW then
      bean.pos = tonumber(CBattleConfig:GetRecorder(50).attr)
    elseif bean.key == LineUpStation.MIDDLE_ROW or bean.key == LineUpStation.ALTERNATE_MIDDLE_ROW then
      bean.pos = tonumber(CBattleConfig:GetRecorder(51).attr)
    elseif bean.key == LineUpStation.BACK_ROW or bean.key == LineUpStation.ALTERNATE_BACK_ROW then
      bean.pos = tonumber(CBattleConfig:GetRecorder(52).attr)
    else
      bean.pos = bean.key
    end
  elseif Enum_Camp.RightFighter == camp then
    if bean.key <= 3 then
      bean.pos = tonumber(CBattleConfig:GetRecorder(bean.key + 52).attr)
    elseif bean.key == 4 then
      bean.pos = tonumber(CBattleConfig:GetRecorder(63).attr)
    elseif bean.key == 5 then
      bean.pos = tonumber(CBattleConfig:GetRecorder(64).attr)
    else
      bean.pos = bean.key
    end
  end
  return bean
end

function NewBattleSceneController:OnSBattlePause(protocol)
  local TimeLineType = {WithStoryLoaing = 1, OnlyStory = 3}
  self._bsc_battleTimeLine = true
  LuaNotificationCenter.PostNotification(Common.n_BattlePauseStateChange, NewBattleSceneController, true)
  local BattlePauseType = BattleClientProtocolManager.GetBeanDef("data.battlepausetype")
  if protocol.pauseType == BattlePauseType.NpcChat then
    self._battle_pause_chatId = tonumber(protocol.param)
    self._bsc_battleFSM:SetNumber("chatDialogId", self._battle_pause_chatId)
  elseif protocol.pauseType == BattlePauseType.TimeLine or protocol.pauseType == TimeLineType.OnlyStory then
    self._bsc_battleFSM:SetString("timelineObjectName", protocol.param)
  end
  self._bsc_battleFSM:SetNumber("pauseType", protocol.pauseType)
  self._bsc_battleFSM:SetBoolean("pasue", true)
end

function NewBattleSceneController:OnSCreateFixPointSkillAttackedInfo(protocol)
  local DamageTypeEnum = {
    None = 0,
    Damage = 1,
    BreakBuff = 2,
    DamageCrit = 3,
    Heal = 4,
    HealCrit = 5,
    BreakBuffCrit = 6,
    Resist = 7
  }
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityId)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityId)
  if battler then
    local hpDeltaValue = math.abs(battler:GetHp() - protocol.currentHp)
    hpDeltaValue = math.floor(hpDeltaValue)
    battler:SetHP(protocol.currentHp)
    battler:SetHpBarAnimationState(protocol.isPlayHpBarAnimation == 1)
    NekoData.DataManager.DM_Battle:OnRefreshBothSideRolesInfo(protocol)
    local skillRecord = CSkillBehaviorTable:GetRecorder(protocol.skillId)
    if skillRecord and skillRecord.EffectAtt ~= "" then
      for _, v in pairs(string.split(skillRecord.EffectAtt, ";")) do
        local skillEffectId = tonumber(v)
        local damageFromBattler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.damageFrom)
        damageFromBattler = damageFromBattler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.damageFrom)
        damageFromBattler = damageFromBattler or NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.damageFrom)
        if damageFromBattler then
          local curPrefabName = damageFromBattler:GetShapeRecorder().prefabName
          skillEffectId = BattleECS.Utility.Utility.GetSkinSkillChangeEffectId(curPrefabName, skillEffectId)
        end
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
      end
    end
    if protocol.damageType == DamageTypeEnum.DamageCrit then
      battler:PlayAnimation("Attacked_Critical", true)
    elseif protocol.type == DamageTypeEnum.BreakBuff then
      battler:PlayAnimation("Attacked_RedOnly", true)
    end
    if protocol.damageType == DamageTypeEnum.Damage or protocol.damageType == DamageTypeEnum.BreakBuff or protocol.damageType == DamageTypeEnum.DamageCrit or protocol.damageType == DamageTypeEnum.Resist or protocol.damageType == DamageTypeEnum.BreakBuffCrit then
      battler:RefreshCurrentBattleInjury(hpDeltaValue)
      local battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleInjury(),
        isPartner = false,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleInjury(battleValueRecorderTable)
      local damageFromBattler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.damageFrom)
      damageFromBattler = damageFromBattler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.damageFrom)
      local isPartner = false
      if not damageFromBattler then
        damageFromBattler = NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.damageFrom)
        isPartner = true
      end
      if damageFromBattler then
        damageFromBattler:RefreshCurrentBattleDamage(hpDeltaValue)
        local battleValueRecorderTable = {
          roleId = damageFromBattler:GetConfigId(),
          entityId = damageFromBattler:GetEntityId(),
          camp = damageFromBattler:GetCamp(),
          isInitial = damageFromBattler:IsInitialPlayer(),
          num = damageFromBattler:GetCurrentBattleDamage(),
          isPartner = isPartner,
          isRole = damageFromBattler:IsRole(),
          stationKey = damageFromBattler:GetKey(),
          nameTextId = damageFromBattler:GetNameTextId(),
          level = damageFromBattler:GetLevel()
        }
        NekoData.DataManager.DM_Battle:RecordCurrentBattleDamage(battleValueRecorderTable)
      end
    elseif protocol.damageType == DamageTypeEnum.Heal or protocol.damageType == DamageTypeEnum.HealCrit then
      local damageFromBattler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.damageFrom)
      damageFromBattler = damageFromBattler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.damageFrom)
      local isPartner = false
      if not damageFromBattler then
        damageFromBattler = NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.damageFrom)
        isPartner = true
      end
      if damageFromBattler then
        damageFromBattler:RefreshCurrentBattleTreatment(protocol.damageNum)
        local battleValueRecorderTable = {
          roleId = damageFromBattler:GetConfigId(),
          entityId = damageFromBattler:GetEntityId(),
          camp = damageFromBattler:GetCamp(),
          isInitial = damageFromBattler:IsInitialPlayer(),
          num = damageFromBattler:GetCurrentBattleTreatment(),
          isPartner = isPartner,
          isRole = damageFromBattler:IsRole(),
          stationKey = damageFromBattler:GetKey(),
          nameTextId = damageFromBattler:GetNameTextId(),
          level = damageFromBattler:GetLevel()
        }
        NekoData.DataManager.DM_Battle:RecordCurrentBattleTreatment(battleValueRecorderTable)
      end
    end
    if protocol.isPost == 1 and self._bsc_battleNewMainUIActiveState then
      LuaNotificationCenter.PostNotification(Common.n_HpChanged, battler, {
        battler = battler,
        damageType = protocol.damageType,
        hpChanged = protocol.damageNum,
        realHpChanged = hpDeltaValue,
        skillid = protocol.skillId
      })
    end
  end
end

function NewBattleSceneController:OnSDamageMiss(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  if battler then
    LuaNotificationCenter.PostNotification(Common.n_DamageMiss, NewBattleSceneController, {
      battler = battler,
      damageType = protocol.damegetype
    })
  end
end

function NewBattleSceneController:OnSChangeEntityHpCellVisible(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.entityid)
  if battler then
    LuaNotificationCenter.PostNotification(Common.n_HpVisible, NewBattleSceneController, {
      entityid = protocol.entityid,
      visible = protocol.visible
    })
    battler:SetGameObjectVisible(protocol.spritevisible)
  end
end

function NewBattleSceneController:OnSCreateBuffEffect(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityid)
  if battler then
    local effectGameobject
    if battler:IsLeftCamp() then
      if protocol.isImaged == 1 then
        effectGameobject = battler:PlayEffect(protocol.packagename, protocol.effectname, protocol.point, protocol.rad / 1000 + 180)
      else
        effectGameobject = battler:PlayEffect(protocol.packagename, protocol.effectname, protocol.point, protocol.rad / 1000)
      end
    elseif battler:IsRightCamp() then
      effectGameobject = battler:PlayEffect(protocol.packagename, protocol.effectname, protocol.point, protocol.rad / 1000 + 180)
    end
    if effectGameobject then
      local battleLayer = TransformStaticFunctions.GetLayer(battler:GetGameObject())
      if battleLayer ~= -1 then
        TransformStaticFunctions.SetLayer(effectGameobject, battleLayer)
      end
    end
  end
end

function NewBattleSceneController:OnSDestroyBuffEffect(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityid)
  if battler then
    battler:DestroyPointEffectByName(protocol.point, protocol.effectname)
  end
end

function NewBattleSceneController:OnSDestroyEffectByName(protocol)
  if protocol.camp == BattleECS.Components.TypeComponent.CampType.Left then
    local childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetSameNameChildren(self._sceneRef:BSR_GetLeftEffectObject(), protocol.effectname .. "(Clone)(Clone)")
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        GameObjectHelper.DestroyObject(gameObj)
      end
    end
  elseif protocol.camp == BattleECS.Components.TypeComponent.CampType.Right then
    local childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetSameNameChildren(self._sceneRef:BSR_GetRightEffectObject(), protocol.effectname .. "(Clone)(Clone)")
    for i = 0, len - 1 do
      local gameObj = childList[i]
      if gameObj then
        GameObjectHelper.DestroyObject(gameObj)
      end
    end
  end
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  if battler then
    battler:DestroyPointEffectByName(protocol.point, protocol.effectname)
  end
end

function NewBattleSceneController:OnSBattlerPlayAnimationByName(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.entityid)
  if battler then
    local ifIgnorePriority = {No = 0, Yes = 1}
    battler:PlayAnimation(protocol.name, protocol.ignorePriority == ifIgnorePriority.Yes)
  end
end

function NewBattleSceneController:OnSDestroyObject(protocol)
  if not NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid) then
    if NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityid) then
      LuaNotificationCenter.PostNotification(Common.n_RoleDead, NewBattleSceneController, protocol)
    end
    if protocol.skillid == 0 then
      NekoData.DataManager.DM_Battle:RemoveEntity(protocol.entityid)
    end
  elseif protocol.isimageentity == 1 then
    NekoData.DataManager.DM_Battle:RemoveEntity(protocol.entityid)
  end
end

function NewBattleSceneController:OnSBattleResult(protocol)
  LogInfoFormat("NewBattleSceneController", "OnSBattleResult self._bsc_stepNum %s", self._bsc_stepNum)
  AnimationHelper.SetAnimatorBool2(self._sceneRef:BSR_GetBattleCamera().gameObject, "GoBack", true)
  TimeSkillStaticFunctions.DisableTimeSkill(self._sceneRef:BSR_GetBattleMainCamera())
  local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
  if dialog then
    dialog:PlayBattleEndAnimation(protocol)
  end
  local record = CBattleInfoTable:GetRecorder(self._bsc_battleStartProtocol.battleid)
  if record and record.bgm then
    LuaAudioManager.StopBGM(record.bgm)
  end
  self._bsc_battleTime = 0
  local battleRes
  local battleID = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().battleid
  if NekoData.BehaviorManager.BM_Battle:IsLoseSettle(battleID) and protocol.type ~= BattleEndType.RightWinCBattleKill then
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
      AnimationHelper.SetAnimatorInteger2(self._sceneRef:BSR_GetBattleCamera().gameObject, "camState", 1)
      self._bsc_canEnterAccountsState = false
    else
      self._bsc_canEnterAccountsState = true
    end
  else
    self._bsc_canEnterAccountsState = true
  end
end

function NewBattleSceneController:OnSBattleWorldPowerShow(protocol)
  NekoData.DataManager.DM_Battle:SetBattlePower(protocol.redCurrentPower, protocol.redMaxPower, protocol.blueCurrentPower, protocol.blueMaxPower)
end

function NewBattleSceneController:OnSCreateFlySkill(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.playerEntityId)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.playerEntityId)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.playerEntityId)
  if battler then
    local effectGameObject
    local effectRecord = CSkillEffectTable:GetRecorder(protocol.effectid)
    if effectRecord then
      if battler:IsLeftCamp() then
        if protocol.isImaged == 1 then
          effectGameObject = BattleSceneHelper.CreateEffect(effectRecord.packageName, effectRecord.effectName, self._sceneRef:BSR_GetRightEffectObject())
          local angleX, angleY, angleZ = TransformStaticFunctions.GetWorldEuler(effectGameObject)
          TransformStaticFunctions.SetWorldEuler(effectGameObject, angleX, angleY, protocol.rad / 1000 + 180)
        else
          effectGameObject = BattleSceneHelper.CreateEffect(effectRecord.packageName, effectRecord.effectName, self._sceneRef:BSR_GetLeftEffectObject())
          local angleX, angleY, angleZ = TransformStaticFunctions.GetWorldEuler(effectGameObject)
          if effectRecord.id == 601110103 then
            TransformStaticFunctions.SetLocalScale(effectGameObject, -1, 1, 1)
          end
          TransformStaticFunctions.SetWorldEuler(effectGameObject, angleX, angleY, protocol.rad / 1000)
        end
      elseif battler:IsRightCamp() then
        if protocol.isImaged == 1 then
          effectGameObject = BattleSceneHelper.CreateEffect(effectRecord.packageName, effectRecord.effectName, self._sceneRef:BSR_GetLeftEffectObject())
          local angleX, angleY, angleZ = TransformStaticFunctions.GetWorldEuler(effectGameObject)
          TransformStaticFunctions.SetWorldEuler(effectGameObject, angleX, angleY, protocol.rad / 1000)
        else
          effectGameObject = BattleSceneHelper.CreateEffect(effectRecord.packageName, effectRecord.effectName, self._sceneRef:BSR_GetRightEffectObject())
          local angleX, angleY, angleZ = TransformStaticFunctions.GetWorldEuler(effectGameObject)
          if effectRecord.id == 601110101 then
            TransformStaticFunctions.SetLocalScale(effectGameObject, 1, -1, 1)
          end
          if effectRecord.id == 601110103 then
            TransformStaticFunctions.SetLocalScale(effectGameObject, -1, -1, 1)
          end
          TransformStaticFunctions.SetWorldEuler(effectGameObject, angleX, angleY, protocol.rad / 1000 + 180)
        end
      end
    end
    if effectGameObject then
      NekoData.DataManager.DM_Battle:AddProjectileEffect(protocol.entityId, protocol.playerEntityId, protocol.skillId, battler._camp, effectGameObject)
      NekoData.BehaviorManager.BM_Battle:SetProjectileEffectPosition(protocol.entityId, protocol.posX, protocol.posY, protocol.posZ)
    end
  end
end

function NewBattleSceneController:OnSCreateSceneEffect(protocol)
  local effectGameObject
  local effectRecord = CSkillEffectTable:GetRecorder(protocol.effectid)
  effectRecord = effectRecord or CBuffEffectTable:GetRecorder(protocol.effectid)
  if effectRecord then
    if protocol.camp == BattleECS.Components.TypeComponent.CampType.Left then
      effectGameObject = BattleSceneHelper.CreateEffect(effectRecord.packageName, effectRecord.effectName, self._sceneRef:BSR_GetLeftEffectObject())
      local angleX, angleY, angleZ = TransformStaticFunctions.GetWorldEuler(effectGameObject)
      TransformStaticFunctions.SetWorldEuler(effectGameObject, angleX, angleY, protocol.rad / 1000)
    elseif protocol.camp == BattleECS.Components.TypeComponent.CampType.Right then
      effectGameObject = BattleSceneHelper.CreateEffect(effectRecord.packageName, effectRecord.effectName, self._sceneRef:BSR_GetRightEffectObject())
      local angleX, angleY, angleZ = TransformStaticFunctions.GetWorldEuler(effectGameObject)
      TransformStaticFunctions.SetWorldEuler(effectGameObject, angleX, angleY, protocol.rad / 1000 + 180)
    end
  end
  if effectGameObject then
    NekoData.DataManager.DM_Battle:AddSceneEffectData(effectGameObject)
    TransformStaticFunctions.SetPosition(effectGameObject, protocol.posX / 1000, protocol.posY / 1000, protocol.posZ / 1000)
  end
end

function NewBattleSceneController:OnSSkillStart(skillID)
end

function NewBattleSceneController:OnSSkillEnd(skillID)
end

function NewBattleSceneController:OnSRoleCreate(protocol)
  if not NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid) then
    local gameObject
    if protocol.type == SRoleCreate.Role then
      if protocol.attribute.camp == Enum_Camp.LeftFighter then
        gameObject = BattleSceneHelper.CreatePlayer(protocol.attribute.assetbundlename, protocol.attribute.prefabname, self._sceneRef:BSR_GetLeftObject())
      else
        gameObject = BattleSceneHelper.CreatePlayer(protocol.attribute.assetbundlename, protocol.attribute.prefabname, self._sceneRef:BSR_GetRightObject())
      end
      local x, y, z = TransformStaticFunctions.GetPosition(gameObject)
      if protocol.attribute.key == LineUpStation.ALTERNATE_FRONT_ROW or protocol.attribute.key == LineUpStation.ALTERNATE_MIDDLE_ROW or protocol.attribute.key == LineUpStation.ALTERNATE_BACK_ROW then
        AnimationHelper.PlayAnimation(gameObject, "Move", -1, 0)
        local beginXPos = {pos = -10}
        local endXPos = {
          pos = protocol.attribute.x / 1000
        }
        self._alternateRoleEnterTask[protocol.entityid] = {
          task = Tween.new(0.5, beginXPos, endXPos, "linear"),
          gameObject = gameObject,
          x = protocol.attribute.x / 1000,
          y = protocol.attribute.y / 1000,
          z = protocol.attribute.z / 1000
        }
      else
        TransformStaticFunctions.SetPosition(gameObject, protocol.attribute.x / 1000, protocol.attribute.y / 1000, protocol.attribute.z / 1000)
      end
      NekoData.DataManager.DM_Battle:AddLeftBattler(protocol.entityid, protocol.attribute, gameObject, protocol.isinitial)
    else
      if protocol.attribute.camp == Enum_Camp.LeftFighter then
        gameObject = BattleSceneHelper.CreatePlayer(protocol.attribute.assetbundlename, protocol.attribute.prefabname, self._sceneRef:BSR_GetLeftObject())
      else
        gameObject = BattleSceneHelper.CreatePlayer(protocol.attribute.assetbundlename, protocol.attribute.prefabname, self._sceneRef:BSR_GetRightObject())
      end
      local x, y, z = TransformStaticFunctions.GetPosition(gameObject)
      TransformStaticFunctions.SetPosition(gameObject, protocol.attribute.x / 1000, protocol.attribute.y / 1000, protocol.attribute.z / 1000)
      NekoData.DataManager.DM_Battle:AddRightBattler(protocol.entityid, protocol.attribute, gameObject, protocol.isinitial)
    end
    if protocol.attribute.camp == Enum_Camp.LeftFighter and protocol.attribute.key > 0 then
      NekoData.DataManager.DM_Battle:OnAddOwnSideRolesInfo(protocol)
    elseif protocol.attribute.camp == Enum_Camp.RightFighter and protocol.attribute.key > 0 then
      NekoData.DataManager.DM_Battle:OnAddEnemySideRolesInfo(protocol)
    end
    local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
    if battler and battler:IsTypeStyle() then
      local battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleInjury(),
        isPartner = false,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleInjury(battleValueRecorderTable)
      battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleTreatment(),
        isPartner = false,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleTreatment(battleValueRecorderTable)
      battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleDamage(),
        isPartner = false,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleDamage(battleValueRecorderTable)
    end
  else
    local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
    battler:SetHP(protocol.attribute.hp, protocol.attribute.hpmax)
    protocol.attribute = battler:GetAttribute()
  end
  LuaNotificationCenter.PostNotification(Common.n_RoleAdd, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSPartnerCreate(protocol)
  if not NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.entityid) then
    local gameObject
    if protocol.attribute.camp == BattleECS.Components.TypeComponent.CampType.Left then
      gameObject = BattleSceneHelper.CreatePlayer(protocol.attribute.assetbundlename, protocol.attribute.prefabname, self._sceneRef:BSR_GetLeftObject())
    else
      gameObject = BattleSceneHelper.CreatePlayer(protocol.attribute.assetbundlename, protocol.attribute.prefabname, self._sceneRef:BSR_GetRightObject())
    end
    TransformStaticFunctions.SetPosition(gameObject, protocol.attribute.x / 1000, protocol.attribute.y / 1000, protocol.attribute.z / 1000)
    NekoData.DataManager.DM_Battle:AddLeftPartnet(protocol.entityid, protocol.attribute, gameObject)
    local battler = NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.entityid)
    if battler and battler:IsTypeStyle() then
      local battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleInjury(),
        isPartner = true,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleInjury(battleValueRecorderTable)
      battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleTreatment(),
        isPartner = true,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleTreatment(battleValueRecorderTable)
      battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleDamage(),
        isPartner = true,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleDamage(battleValueRecorderTable)
    end
  end
end

function NewBattleSceneController:ChangeRoleToImaged(entityid, camp)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(entityid)
  if battler then
    local effectRecord = CSkillEffectTable:GetRecorder(3004105)
    TransformStaticFunctions.SetLocalScale(battler:GetGameObject(), -1, 1, 1)
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, 180)
    elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
      battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, 0)
    end
  end
end

function NewBattleSceneController:ResetRoleToImage(entityid, camp)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(entityid)
  if battler then
    local effectRecord = CSkillEffectTable:GetRecorder(3004105)
    battler:PlayAnimation("BattleIdle")
    TransformStaticFunctions.SetLocalScale(battler:GetGameObject(), 1, 1, 1)
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, 0)
    elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
      battler:PlayEffect(effectRecord.packageName, effectRecord.effectName, effectRecord.socket, 180)
    end
  end
end

function NewBattleSceneController:OnSUseSkill(protocol)
  if BattleECS.Utility.Utility.IsYingXiSkill(protocol.skillid) then
    local camp = protocol.camp
    if protocol.isImaged == 0 then
      self:ChangeRoleToImaged(protocol.entityid, camp)
    else
      self:ResetRoleToImage(protocol.entityid, camp)
    end
  end
end

function NewBattleSceneController:OnSRoleSummonCreate(protocol)
  if not NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityid) then
    local gameObject
    if protocol.attribute.camp == SRoleSummon.Role then
      local roleRecoder = CMonsterConfigTable:GetRecorder(protocol.attribute.id)
      local shapeRecorder
      if roleRecoder then
        shapeRecorder = CNpcShapeTable:GetRecorder(roleRecoder.shapeID)
        gameObject = BattleSceneHelper.CreatePlayer(shapeRecorder.assetBundleName, shapeRecorder.prefabName, self._sceneRef:BSR_GetLeftObject())
      else
        local effectRecord = CSkillEffectTable:GetRecorder(protocol.attribute.id)
        gameObject = BattleSceneHelper.CreateEffect(effectRecord.packageName, effectRecord.effectName, self._sceneRef:BSR_GetLeftEffectObject())
      end
      local x, y, z = TransformStaticFunctions.GetPosition(gameObject)
      TransformStaticFunctions.SetPosition(gameObject, protocol.attribute.x / 1000, protocol.attribute.y / 1000, protocol.attribute.z / 1000)
      NekoData.DataManager.DM_Battle:AddLeftBattlerSummon(protocol.entityid, protocol.attribute, gameObject)
    elseif protocol.attribute.camp == SRoleSummon.Monster then
      local roleRecoder = CMonsterConfigTable:GetRecorder(protocol.attribute.id)
      local shapeRecorder
      if roleRecoder then
        shapeRecorder = CNpcShapeTable:GetRecorder(roleRecoder.shapeID)
        gameObject = BattleSceneHelper.CreatePlayer(shapeRecorder.assetBundleName, shapeRecorder.prefabName, self._sceneRef:BSR_GetRightObject())
      else
        local effectRecord = CSkillEffectTable:GetRecorder(protocol.attribute.id)
        gameObject = BattleSceneHelper.CreateEffect(effectRecord.packageName, effectRecord.effectName, self._sceneRef:BSR_GetRightEffectObject())
      end
      local x, y, z = TransformStaticFunctions.GetPosition(gameObject)
      TransformStaticFunctions.SetPosition(gameObject, protocol.attribute.x / 1000, protocol.attribute.y / 1000, protocol.attribute.z / 1000)
      NekoData.DataManager.DM_Battle:AddRightBattlerSummon(protocol.entityid, protocol.attribute, gameObject)
    end
    local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityid)
    battler:SetFatherEntityId(protocol.fatherEntityId)
    if battler and battler:IsTypeStyle() then
      local battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleInjury(),
        isPartner = false,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleInjury(battleValueRecorderTable)
      battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleTreatment(),
        isPartner = false,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleTreatment(battleValueRecorderTable)
      battleValueRecorderTable = {
        roleId = battler:GetConfigId(),
        entityId = battler:GetEntityId(),
        camp = battler:GetCamp(),
        isInitial = battler:IsInitialPlayer(),
        num = battler:GetCurrentBattleDamage(),
        isPartner = false,
        isRole = battler:IsRole(),
        stationKey = battler:GetKey(),
        nameTextId = battler:GetNameTextId(),
        level = battler:GetLevel()
      }
      NekoData.DataManager.DM_Battle:RecordCurrentBattleDamage(battleValueRecorderTable)
    end
    LuaNotificationCenter.PostNotification(Common.n_RoleAdd, NewBattleSceneController, protocol)
  end
end

function NewBattleSceneController:OnSRoleChangeShapeAndAttribute(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityid)
  if battler then
    local gameObject
    if battler:GetCamp() == 1 then
      if protocol.shapeid == 0 then
        gameObject = BattleSceneHelper.CreatePlayer(protocol.assetBundleName, protocol.prefabName, self._sceneRef:BSR_GetLeftObject())
      else
        local shapeRecorder = CNpcShapeTable:GetRecorder(protocol.shapeid)
        gameObject = BattleSceneHelper.CreatePlayer(shapeRecorder.assetBundleName, shapeRecorder.prefabName, self._sceneRef:BSR_GetLeftObject())
      end
      local x, y, z = battler:GetPosition()
      TransformStaticFunctions.SetPosition(gameObject, x / 1000, y / 1000, z / 1000)
      NekoData.DataManager.DM_Battle:ChangeLeftBattler(protocol.entityid, gameObject)
    else
      if protocol.shapeid == 0 then
        gameObject = BattleSceneHelper.CreatePlayer(protocol.assetBundleName, protocol.prefabName, self._sceneRef:BSR_GetRightObject())
      else
        local shapeRecorder = CNpcShapeTable:GetRecorder(protocol.shapeid)
        gameObject = BattleSceneHelper.CreatePlayer(shapeRecorder.assetBundleName, shapeRecorder.prefabName, self._sceneRef:BSR_GetRightObject())
      end
      local x, y, z = battler:GetPosition()
      TransformStaticFunctions.SetPosition(gameObject, x / 1000, y / 1000, z / 1000)
      NekoData.DataManager.DM_Battle:ChangeRightBattler(protocol.entityid, gameObject)
    end
  end
end

function NewBattleSceneController:OnSRoleDead(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityId)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityId)
  if battler then
    battler:SetHP(0)
    if battler:IsRightCamp() and 0 < battler:GetSoulQuantity() then
      local left, right = nil, battler
      for k, v in pairs(NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()) do
        if v:GetConfigId() == 1 then
          left = v
          break
        end
      end
      for k, v in pairs(NekoData.BehaviorManager.BM_Battle:GetRightBattlers()) do
        if v:GetConfigId() == 10017 then
          right = v
          break
        end
        if v:GetConfigId() == 20003 then
          right = v
          break
        end
      end
      if left and right then
        self._bsc_battleFSM:SetBoolean("toSoul", true)
        self._bsc_leftSoulBattlerId = left:GetEntityId()
        self._bsc_rightSoulBattlerId = right:GetEntityId()
      end
    elseif protocol.isrunaway == 0 then
      battler:PlayAnimation("DeadDisappear")
    end
    LuaNotificationCenter.PostNotification(Common.n_RoleDead, NewBattleSceneController, protocol)
  end
end

function NewBattleSceneController:OnSRolePositionChange(protocol)
  if NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityId) then
    NekoData.BehaviorManager.BM_Battle:SetBattlerPosition(protocol.entityId, protocol.posX, protocol.posY)
  end
  if NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.entityId) then
    NekoData.BehaviorManager.BM_Battle:SetBattlerPosition(protocol.entityId, protocol.posX, protocol.posY)
  end
  if NekoData.BehaviorManager.BM_Battle:GetProjectileEffectByEntityId(protocol.entityId) then
    NekoData.BehaviorManager.BM_Battle:SetProjectileEffectPosition(protocol.entityId, protocol.posX, protocol.posY)
  end
end

function NewBattleSceneController:OnSSkillPowerCost(protocol)
  LuaNotificationCenter.PostNotification(Common.n_SkillSuccess, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSSkillFail(protocol)
  LuaNotificationCenter.PostNotification(Common.n_SkillFail, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSBattleEnd(protocol)
  LogInfoFormat("NewBattleSceneController", "OnSBattleEnd self._bsc_stepNum %s", self._bsc_stepNum)
  self._bsc_battleStepTimeCount = 0
  self._bsc_battleFSM:SetBoolean("battleLogicEnd", true)
  local battleID = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().battleid
  if NekoData.BehaviorManager.BM_Battle:IsLoseSettle(battleID) then
    protocol.type = BattleEndType.LoseSettle
  end
  self._bsc_battleFSM:SetNumber("battleResult", protocol.type)
end

function NewBattleSceneController:OnSPartner(protocol)
  LuaNotificationCenter.PostNotification(Common.n_SupportRoleUsed, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSRoleIsCanUseSKill(protocol)
  LuaNotificationCenter.PostNotification(Common.n_BattlerUseSkill, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSUpdateRoleAttribute(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityid)
  if battler then
    battler:RefreshAttribute(protocol.attribute)
  end
end

function NewBattleSceneController:OnSUpdateBossHpStage(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityId)
  if battler then
    battler:SetBossHpStage(protocol.bosshpstage)
  end
end

function NewBattleSceneController:OnSPlayAudio(protocol)
  if LuaAudioManager.IfAudioIsVoice(protocol.audioid) then
    LuaAudioManager.PlayVoice(protocol.audioid)
  else
    LuaAudioManager.PlayBGM(protocol.audioid)
  end
  if protocol.audiovalue ~= -1 then
    CS.PixelNeko.Audio.AudioManager.SetAisac(protocol.audioid, 0, protocol.audiovalue)
  end
end

function NewBattleSceneController:OnSRoleUseEquipSkill(protocol)
  NekoData.DataManager.DM_Battle:AddOnceUseEquipSkill(protocol.entityid, protocol.skillid)
  LuaNotificationCenter.PostNotification(Common.n_RoleEquipSkillUsed, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSUpdateRoleBuffs(protocol)
  LuaNotificationCenter.PostNotification(Common.n_BuffsUpdate, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSUpdateRoleSkillPowerReduce(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  if battler then
    battler:RefreshskillPowerCostReduce(protocol.order, protocol.chaos)
  end
end

function NewBattleSceneController:OnSSkillBegin(protocol)
  LuaNotificationCenter.PostNotification(Common.n_SkillBegin, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSSkillInterrupted(protocol)
  LuaNotificationCenter.PostNotification(Common.n_SkillInterrupted, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSInvincibleStateChange(protocol)
  LuaNotificationCenter.PostNotification(Common.n_InvincibleStateChange, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSShieldValueChange(protocol)
  LuaNotificationCenter.PostNotification(Common.n_ShieldValueChange, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSBossIsInWeakState(protocol)
  local TimeType = {
    None = 0,
    BattleStart = 1,
    BattleWin = 2,
    BattleLose = 3,
    BOSSFirstWeak = 4
  }
  local guide = self._bsc_battleStartProtocol.guide
  if guide ~= 0 then
    local timetype = CBattleGuideLinkConfig:GetRecorder(guide).time
    if timetype == TimeType.BOSSFirstWeak and not self._bsc_battleGuideTag[guide] then
      self._bsc_battleGuideTag[guide] = true
      DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(guide, true)
    end
  end
end

function NewBattleSceneController:OnSAccumulatePowerStateChange(protocol)
  local TimeType = {
    None = 0,
    BattleStart = 1,
    BattleWin = 2,
    BattleLose = 3,
    BOSSFirstWeak = 4,
    PowerFirstFull = 1003
  }
  local guide = self._bsc_battleStartProtocol.guide
  if guide ~= 0 then
    local timetype = CBattleGuideLinkConfig:GetRecorder(guide).time
    if timetype == TimeType.PowerFirstFull and not self._bsc_battleGuideTag[guide] and protocol.state == self._bsc_battleWorld.PowerAccumulateStateType.Full then
      local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
      if dialog then
        dialog:SetGuideFrame({guideTimeType = timetype}, nil, "Down", 2301124)
      end
      self._bsc_battleGuideTag[guide] = true
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_AccumulatePowerState, self, {
    state = protocol.state
  })
end

function NewBattleSceneController:OnSCollaborativeSkillNumChange(protocol)
  LuaNotificationCenter.PostNotification(Common.n_CollaborativeSkillNumChange, self, {
    entityid = protocol.entityid,
    num = protocol.num
  })
end

function NewBattleSceneController:OnSSetClipRectForShiKongZhiMen(protocol)
  local Enum_Camp = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  local parentObj, shiKongZhiMenObject
  if protocol.camp == Enum_Camp.RightFighter then
    parentObj = self._sceneRef:BSR_GetRightEffectObject()
    for i = 1, 5 do
      if shiKongZhiMenObject then
        break
      end
      shiKongZhiMenObject = TransformStaticFunctions.GetChild(self._sceneRef:BSR_GetLeftEffectObject(), "TX_Prefab_ShiKongZhiMen_" .. i .. "(Clone)(Clone)")
    end
  elseif protocol.camp == Enum_Camp.LeftFighter then
    parentObj = self._sceneRef:BSR_GetLeftEffectObject()
    for i = 1, 5 do
      if shiKongZhiMenObject then
        break
      end
      shiKongZhiMenObject = TransformStaticFunctions.GetChild(self._sceneRef:BSR_GetRightEffectObject(), "TX_Prefab_ShiKongZhiMen_" .. i .. "(Clone)(Clone)")
    end
  end
  if shiKongZhiMenObject then
    local wx, wy, wz = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(shiKongZhiMenObject)
    local flag, x, y, w, h = CS.PixelNeko.UI.UIManager.WorldToScreenRect01("BattleMain", wx, wy, wz, protocol.w / 1000, protocol.h / 1000)
    local leftDownX, leftDownY, rightUpX, rightUpY = 0, 0, x, 1
    if protocol.camp == Enum_Camp.LeftFighter then
      leftDownX, leftDownY, rightUpX, rightUpY = x, 0, 1, 1
    end
    if flag and parentObj then
      local childList, len = CS.PixelNeko.Lua.TransformStaticFunctions.GetSameNameChildren(parentObj, protocol.objectname .. "(Clone)(Clone)")
      for i = 0, len - 1 do
        local gameObj = childList[i]
        if gameObj then
          local particleMaterials = CS.PixelNeko.Lua.MaterialStaticFunctions.CopyAndUseParticleSystemRendererMaterialsInChildren(gameObj, true)
          local meshMaterials = CS.PixelNeko.Lua.MaterialStaticFunctions.CopyAndUseMeshRendererMaterialsInChildren(gameObj, true)
          if protocol.clipstate == "true" then
            if particleMaterials ~= nil then
              CS.PixelNeko.Lua.MaterialStaticFunctions.SetClipRect(particleMaterials, true, false, leftDownX, leftDownY, rightUpX, rightUpY)
            end
            if meshMaterials ~= nil then
              CS.PixelNeko.Lua.MaterialStaticFunctions.SetClipRect(meshMaterials, true, false, leftDownX, leftDownY, rightUpX, rightUpY)
            end
          elseif protocol.clipstate == "false" then
            if particleMaterials ~= nil then
              CS.PixelNeko.Lua.MaterialStaticFunctions.SetClipRect(particleMaterials, false, false, leftDownX, leftDownY, rightUpX, rightUpY)
            end
            if meshMaterials ~= nil then
              CS.PixelNeko.Lua.MaterialStaticFunctions.SetClipRect(meshMaterials, false, false, leftDownX, leftDownY, rightUpX, rightUpY)
            end
          else
            LogError("NewBattleSceneController", "wrong 'clipstate' in localprotocol SSetClipRectForShiKongZhiMen")
          end
        end
      end
    end
  end
end

function NewBattleSceneController:OnSActiveSkillStateChange(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityid)
  if battler then
    battler:SetSkillIsInCD(protocol.skillid, protocol.isInCD)
  end
  LuaNotificationCenter.PostNotification(Common.n_ActiveSkillStateChange, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSActorTimeSkillState(protocol)
  local StateType = {Begin = 0, Over = 1}
  TimeSkillStaticFunctions.EnableTimeSkill(self._sceneRef:BSR_GetBattleMainCamera())
  self._actorTimeSkillChangeValueTask.timeCount = 0
  for key, value in pairs(self._actorTimeSkillChangeValueTask.dataValue) do
    self._actorTimeSkillChangeValueTask.dataValue[key] = nil
  end
  local data = {}
  if protocol.state == StateType.Begin then
    data = require("data.battledata.animation.timeskillposttreatmenton")
    self._actorTimeSkillChangeValueTask.isOver = false
  elseif protocol.state == StateType.Over then
    data = require("data.battledata.animation.timeskillposttreatmentoff")
    self._actorTimeSkillChangeValueTask.isOver = true
  end
  for key, value in pairs(data) do
    if not self._actorTimeSkillChangeValueTask.dataValue[key] then
      self._actorTimeSkillChangeValueTask.dataValue[key] = {}
      if not self._actorTimeSkillChangeValueTask.isOver then
        TimeSkillStaticFunctions.SetTimeSkillPropertyValue(self._sceneRef:BSR_GetBattleMainCamera(), key, value[1].value)
      end
    end
    if key == "useChromaticAberration" or key == "useInverColor" or key == "useColorGrading" then
      for i, v in ipairs(value) do
        if i ~= 1 then
          table.insert(self._actorTimeSkillChangeValueTask.dataValue[key], {
            timestamp = v.timestamp,
            value = v.value
          })
        end
      end
    else
      for i, v in ipairs(value) do
        if value[i - 1] then
          local deltaTime = value[i].timestamp - value[i - 1].timestamp
          local deltaValue = value[i].value / deltaTime
          for timeI = 1, deltaTime do
            table.insert(self._actorTimeSkillChangeValueTask.dataValue[key], {
              timestamp = value[i - 1].timestamp + timeI,
              value = deltaValue
            })
          end
        end
      end
    end
  end
end

function NewBattleSceneController:OnSPlayBattleVoice(protocol)
  NekoData.BehaviorManager.BM_Voice:PlayBattleVoice(protocol.roleId, protocol.voiceType, protocol.index)
end

function NewBattleSceneController:OnSChangeAnimatorState(protocol)
  local animator = self._bsc_animatorGroup[protocol.animatorType]
  if animator then
    animator:SetInteger(protocol.param, protocol.value)
  end
end

function NewBattleSceneController:OnSChangeEntityName(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityId)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetPartnerByEntityId(protocol.entityId)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityId)
  if battler then
    battler:SetNameTextId(protocol.nameTextId)
  end
  LuaNotificationCenter.PostNotification(Common.n_EntityNameChanging, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSPlayBattleCameraAnimationName(protocol)
  local MoveType = {Interrept = -2}
  if protocol.skillId ~= 0 and self._bsc_battleCameraAnimationInfo.cameraMoveType ~= MoveType.Interrept and (self._bsc_battleCameraAnimationInfo.moveDelayTime or self._bsc_battleCameraAnimationInfo.resetDelayTime) then
    return
  end
  if protocol.skillId == self._bsc_battleCameraAnimationInfo.skillId and self._bsc_battleCameraAnimationInfo.cameraMoveType == MoveType.Interrept then
    AnimationHelper.SetAnimatorBool2(self._sceneRef:BSR_GetBattleCamera().gameObject, "SkillReset", true)
  end
  if protocol.moveDelayTime == -1 then
    self._bsc_battleCameraAnimationInfo.moveDelayTime = nil
  else
    self._bsc_battleCameraAnimationInfo.moveDelayTime = protocol.moveDelayTime
  end
  if protocol.resetDelayTime == -1 then
    self._bsc_battleCameraAnimationInfo.resetDelayTime = nil
  else
    self._bsc_battleCameraAnimationInfo.resetDelayTime = protocol.resetDelayTime
  end
  self._bsc_battleCameraAnimationInfo.cameraMoveType = protocol.cameraMoveType
  self._bsc_battleCameraAnimationInfo.skillId = protocol.skillId
  self._bsc_battleCameraAnimationInfo.currentTime = 0
end

function NewBattleSceneController:OnSShowOrderPowerSpecialUIEffect(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OrderPowerSpecialUIEffect, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSSActionWithActiveSkill(protocol)
  local battler = NekoData.BehaviorManager.BM_Battle:GetBattlerByEntityId(protocol.entityId)
  battler = battler or NekoData.BehaviorManager.BM_Battle:GetBattlerSummonByEntityId(protocol.entityId)
  if battler then
    battler:PlayAnimation("Attacked", true)
  end
end

function NewBattleSceneController:OnSBreakOutPowerNumber(protocol)
  LuaNotificationCenter.PostNotification(Common.n_BreakOutPowerNumberChange, NewBattleSceneController, protocol)
end

function NewBattleSceneController:OnSBossEnterViolent(protocol)
  local battlerList = NekoData.BehaviorManager.BM_Battle:GetRightBattlers()
  for entityId, battler in pairs(battlerList) do
    if battler:IsBoss() then
      self._bsc_isBossViolent = true
      battler:SetViolentState(true)
      LuaNotificationCenter.PostNotification(Common.n_BossViolentEnter, NewBattleSceneController, protocol)
    end
  end
end

function NewBattleSceneController:GMSUpdateOneCampAttribute(data)
  self._bsc_hasUsedGM = true
  if data.camp == BattleECS.Components.TypeComponent.CampType.Left then
    local battlerList = NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()
    for entityId, battler in pairs(battlerList) do
      battler:RefreshAttribute(data.attribute)
      local entity
      for i, e in ipairs(self._bsc_battleWorld._entitys) do
        if e._entityId == entityId then
          entity = e
          break
        end
      end
      if entity then
        local defenseComponent = entity:GetComponent(BattleECS.Components.DefenseComponent)
        defenseComponent._attackDefenseAddition = fixedpoint(data.attribute.physicalreduce) / 1000
        defenseComponent._magicDefenseAddition = fixedpoint(data.attribute.magicreduce) / 1000
      end
    end
    battlerList = NekoData.BehaviorManager.BM_Battle:GetLeftBattlersSummon()
    for entityId, battler in pairs(battlerList) do
      battler:RefreshAttribute(data.attribute)
      local entity
      for i, e in ipairs(self._bsc_battleWorld._entitys) do
        if e._entityId == entityId then
          entity = e
          break
        end
      end
      if entity then
        local defenseComponent = entity:GetComponent(BattleECS.Components.DefenseComponent)
        defenseComponent._attackDefenseAddition = fixedpoint(data.attribute.physicalreduce) / 1000
        defenseComponent._magicDefenseAddition = fixedpoint(data.attribute.magicreduce) / 1000
      end
    end
  end
  if data.camp == BattleECS.Components.TypeComponent.CampType.Right then
    local battlerList = NekoData.BehaviorManager.BM_Battle:GetRightBattlers()
    for entityId, battler in pairs(battlerList) do
      battler:RefreshAttribute(data.attribute)
      local entity
      for i, e in ipairs(self._bsc_battleWorld._entitys) do
        if e._entityId == entityId then
          entity = e
          break
        end
      end
      if entity then
        local defenseComponent = entity:GetComponent(BattleECS.Components.DefenseComponent)
        defenseComponent._attackDefenseAddition = fixedpoint(data.attribute.physicalreduce) / 1000
        defenseComponent._magicDefenseAddition = fixedpoint(data.attribute.magicreduce) / 1000
      end
    end
    battlerList = NekoData.BehaviorManager.BM_Battle:GetRightBattlersSummon()
    for entityId, battler in pairs(battlerList) do
      battler:RefreshAttribute(data.attribute)
      local entity
      for i, e in ipairs(self._bsc_battleWorld._entitys) do
        if e._entityId == entityId then
          entity = e
          break
        end
      end
      if entity then
        local defenseComponent = entity:GetComponent(BattleECS.Components.DefenseComponent)
        defenseComponent._attackDefenseAddition = fixedpoint(data.attribute.physicalreduce) / 1000
        defenseComponent._magicDefenseAddition = fixedpoint(data.attribute.magicreduce) / 1000
      end
    end
  end
end

function NewBattleSceneController:GMMakeLeftPlayerStatusFull()
  self._bsc_hasUsedGM = true
  local battlerList = NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()
  for entityId, battler in pairs(battlerList) do
    local entity
    for i, e in ipairs(self._bsc_battleWorld._entitys) do
      if e._entityId == entityId then
        entity = e
        break
      end
    end
    if entity then
      local hpComponent = entity:GetComponent(BattleECS.Components.HpComponent)
      battler:RefreshAttribute({
        hp = hpComponent._maxHp
      })
      hpComponent._currentHp = hpComponent._maxHp
      if BattleECS.Utility.Utility.IsRoleDead(entity) and (not battler:IsHaveAlternate() or battler:GetKey() == LineUpStation.ALTERNATE_BACK_ROW or battler:GetKey() == LineUpStation.ALTERNATE_FRONT_ROW or battler:GetKey() == LineUpStation.ALTERNATE_MIDDLE_ROW) then
        self._bsc_battleWorld:RevivePlayer(entityId)
        BattleECS.Utility.BuffUtility.RemoveEntityBuff(entity, 20000)
      end
    end
  end
end

function NewBattleSceneController:GMRemoveBossOneHpStage()
  self._bsc_hasUsedGM = true
  local battlerList = NekoData.BehaviorManager.BM_Battle:GetRightBattlers()
  for entityId, battler in pairs(battlerList) do
    if battler:IsBoss() then
      local entity
      for i, e in ipairs(self._bsc_battleWorld._entitys) do
        if e._entityId == entityId then
          entity = e
          break
        end
      end
      local bossStage = battler:GetBossHpStage()
      local hpComponent = entity:GetComponent(BattleECS.Components.HpComponent)
      local currentHp = hpComponent._currentHp
      local totalHp = fixedpoint_zero
      for i, v in ipairs(bossStage) do
        if currentHp <= totalHp + v then
          break
        end
        self._bsc_battleWorld._bossHpStage[i].stage = true
        totalHp = totalHp + v
      end
      currentHp = totalHp
      if currentHp <= 0 then
        currentHp = fixedpoint.new(1)
      end
      battler:RefreshAttribute({
        hp = fixedpoint.tonumber(currentHp)
      })
      hpComponent._currentHp = currentHp
    end
  end
end

function NewBattleSceneController:GMSetSelfPlayerInvincible(flag)
  self._bsc_hasUsedGM = true
  self._bsc_battleWorld:SetIsLeftGMInvincible(flag)
end

function NewBattleSceneController:GMSetEnemyPlayerInvincible(flag)
  self._bsc_hasUsedGM = true
  self._bsc_battleWorld:SetIsRightGMInvincible(flag)
end

function NewBattleSceneController:GMSetSecondHurtState(state, entityId)
  LuaNotificationCenter.PostNotification(Common.n_ChangeSecondHurtShowState, self, {state = state, entityId = entityId})
end

function NewBattleSceneController:ChangeEntityBehavior(behaviorName, entityId)
  local entity
  for i, e in ipairs(self._bsc_battleWorld._entitys) do
    if e._entityId == entityId then
      entity = e
      break
    end
  end
  local oldBehavior = entity:GetComponent(BattleECS.Components.BehaviorComponent)._behavior
  local newBehavior = BehaviorManager.NewBehavior("newbattle/" .. behaviorName)
  newBehavior._behaviorSkillList = oldBehavior._behaviorSkillList
  newBehavior._data = oldBehavior._data
  newBehavior._entityId = oldBehavior._entityId
  newBehavior._battleworld = oldBehavior._battleworld
  newBehavior:SetTree()
  entity:GetComponent(BattleECS.Components.BehaviorComponent)._behavior = newBehavior
end

function NewBattleSceneController:GMFullEnergyPower()
  self._bsc_hasUsedGM = true
  self._bsc_battleWorld:FullEnergyPower()
end

return NewBattleSceneController
