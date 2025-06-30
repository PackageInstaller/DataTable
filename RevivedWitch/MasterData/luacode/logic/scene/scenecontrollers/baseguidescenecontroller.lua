-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/baseguidescenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local PhysicsStaticFunctions = ((CS.PixelNeko).Lua).PhysicsStaticFunctions
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local BattleSceneHelper = ((((CS.PixelNeko).P1).Scene).Battle).BattleSceneHelper
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local Time = (CS.UnityEngine).Time
local GameObjectAudio = ((CS.PixelNeko).Audio).GameObjectAudio
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CBattleConfig = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CSoundSourceTable = (BeanManager.GetTableByName)("sound.csoundsource")
local CCostSkill = (BeanManager.GetTableByName)("skill.ccostskill")
local BaseFirstBattleSceneController = class("BaseFirstBattleSceneController", NewBattleSceneController)
local UpdateGuide = function(self, deltaTime)
  -- function num : 0_0 , upvalues : _ENV, CBattleConfig, GameObjectAudio, CSoundSourceTable
  if self._guideStage == nil and self._battleDialogInited == false then
    return 
  end
  local stepNum = self._bsc_stepNum
  if self._guideStage == 0 and stepNum >= 60 then
    ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
    ;
    (self._guideDialog):SetStage1Active()
    self._guideStage = 1
    self._bsc_battleTime = 0
    local userInfo = {}
    userInfo.guideID = 2
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1StartStage1, nil, userInfo)
  else
    do
      if self._guideStage == 1 and tonumber((CBattleConfig:GetRecorder(56)).attr) - 20 <= stepNum then
        local power1, power1Max = ((NekoData.BehaviorManager).BM_Battle):GetPower1()
        local power2, power2Max = ((NekoData.BehaviorManager).BM_Battle):GetPower2()
        local canUseSkill = self._linghunjianCost1 <= power2 and self._linghunjianCost2 <= power1
        if canUseSkill then
          self._guideStage = 2
          ;
          ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
          ;
          (self._guideDialog):SetLingHunJianActive(1)
          self._bsc_battleTime = 0
          local userInfo = {}
          userInfo.guideID = 2
          userInfo.stageID = "linghunjian1"
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1SpecialSkillEffect, nil, userInfo)
        end
      elseif self._guideStage == 2 and tonumber((CBattleConfig:GetRecorder(57)).attr) - 20 <= stepNum then
        local power1, power1Max = ((NekoData.BehaviorManager).BM_Battle):GetPower1()
        local power2, power2Max = ((NekoData.BehaviorManager).BM_Battle):GetPower2()
        local canUseSkill = self._linghunjianCost1 <= power2 and self._linghunjianCost2 <= power1
        if canUseSkill then
          self._guideStage = 3
          ;
          ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
          ;
          (self._guideDialog):SetLingHunJianActive(2)
          self._bsc_battleTime = 0
          local userInfo = {}
          userInfo.guideID = 2
          userInfo.stageID = "linghunjian2"
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1SpecialSkillEffect, nil, userInfo)
        end
      elseif self._guideStage == 3 and tonumber((CBattleConfig:GetRecorder(3)).attr) <= stepNum then
        ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
        ;
        (self._guideDialog):SetStage2Active()
        ;
        (self._guideDialog):SetSkillMaskState(false)
        self._guideStage = 4
        self._bsc_battleTime = 0
        local userInfo = {}
        userInfo.guideID = 2
        userInfo.stageID = "shanbi"
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1SpecialSkillEffect, nil, userInfo)
        local skillEffectTransform = (((self._sceneRef):GetRootGameObject()).transform):Find("GameObject/RightEffect/Mon_TX_T1_01_SiWangGuangXian(Clone)")
        if skillEffectTransform ~= nil then
          local gameObjectAudio = (GameObjectAudio.GetSelf)(skillEffectTransform)
          if gameObjectAudio ~= nil then
            local record = CSoundSourceTable:GetRecorder(81)
            if record then
              gameObjectAudio:PauseBGM(record.cueSheet, record.cueName, true)
            end
          end
        end
      end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

local HandleNewBattleGuide1Stage1End = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV
  ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
  ;
  (self._guideDialog):SetNoActive()
  ;
  ((self._guideDialog)._stage1):Unsubscribe_UpdateEvent((self._guideDialog)._stage1UpdateHandler)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._guideDialog)._stage1UpdateHandler = nil
end

local HandleNewBattleGuide1SpecialSkillClicked = function(self, notification)
  -- function num : 0_2 , upvalues : _ENV, GameObjectAudio, CSoundSourceTable
  ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
  ;
  (self._guideDialog):SetNoActive()
  if self._guideStage == 4 then
    self._guideStage = nil
    ;
    (self._guideDialog):Destroy()
    self._guideDialog = nil
    self._hasPlayedGuide = true
    self._battleDialogInited = false
    ;
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_NewBattleGuide1SpecialSkillClicked)
    local skillEffectTransform = (((self._sceneRef):GetRootGameObject()).transform):Find("GameObject/RightEffect/Mon_TX_T1_01_SiWangGuangXian(Clone)")
    if skillEffectTransform ~= nil then
      local gameObjectAudio = (GameObjectAudio.GetSelf)(skillEffectTransform)
      if gameObjectAudio ~= nil then
        local record = CSoundSourceTable:GetRecorder(81)
        if record then
          gameObjectAudio:PauseBGM(record.cueSheet, record.cueName, false)
        end
      end
    end
    do
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuideEnd, self, {guideID = 2})
    end
  end
end

local HandleNewBattleGuide1BattleNewMainDialogCreated = function(self, notification)
  -- function num : 0_3
  self._battleDialogInited = true
end

BaseFirstBattleSceneController.Init = function(self, ...)
  -- function num : 0_4 , upvalues : BaseFirstBattleSceneController, PhysicsStaticFunctions, _ENV, StateEventTriggerHelper, CCostSkill, HandleNewBattleGuide1BattleNewMainDialogCreated
  ((BaseFirstBattleSceneController.super).Init)(self, ...)
  self._actorMove = 0
  self._userControl = false
  self._actorMoveSpeed = 0.9
  self._npcChatId = 0
  self._npcChatId_ShiXiangGui = 0
  self._chatDuration_ShiXiangGui = 0
  self._gachaChatId = 0
  self._gachaDraw = false
  self._intoMaze = false
  self._battleEndMove = false
  self._guideBattleStart = false
  self._raycastHits = (PhysicsStaticFunctions.CreateRaycastHits)(1)
  if ((NekoData.BehaviorManager).BM_Game):IsFirstGachaEnd() then
    self._timeline = (self._sceneRef)._timeline3
    self._gachaDraw = true
    ;
    ((((((CS.PixelNeko).P1).TimeLine).TimelineManager).GetPlayableDirector)(self._timeline)):Play()
    ;
    (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)(self._timeline, self.OnTriggerBehaviourPlay, self)
    ;
    (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPauseListener)(self._timeline, self.OnTriggerBehaviourPause, self)
  else
    if ((NekoData.BehaviorManager).BM_Game):IsSecondGuideBattleEnd() then
      self._timeline = (self._sceneRef)._timeline2
      ;
      ((((((CS.PixelNeko).P1).TimeLine).TimelineManager).GetPlayableDirector)(self._timeline)):Play()
      ;
      (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)(self._timeline, self.OnTriggerBehaviourPlay, self)
      ;
      (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPauseListener)(self._timeline, self.OnTriggerBehaviourPause, self)
      ;
      (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", 0.5)
    else
      self._timeline = (self._sceneRef)._timeline1
      ;
      ((((((CS.PixelNeko).P1).TimeLine).TimelineManager).GetPlayableDirector)(self._timeline)):Play()
      ;
      (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)(self._timeline, self.OnTriggerBehaviourPlay, self)
      ;
      (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPauseListener)(self._timeline, self.OnTriggerBehaviourPause, self)
    end
  end
  self._timeline16 = (self._sceneRef)._timeline16
  ;
  (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)(self._timeline16, self.OnTriggerBehaviourPlay, self)
  ;
  (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPauseListener)(self._timeline16, self.OnTriggerBehaviourPause, self)
  ;
  (StateEventTriggerHelper.AddStateEnterListener)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, self.BSR_OnBattleCameraStateEnter, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerMove, Common.n_RockerMove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGuideGetSkillEnd, Common.n_GuideGetSkill, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGuideGachaTipsClosed, Common.n_GuideGachaTips, nil)
  self._guideDialog = nil
  self._guideStage = nil
  self._hasPlayedGuide = false
  self._battleDialogInited = false
  self._linghunjianCost1 = (CCostSkill:GetRecorder(6001101)).ChaosCost
  self._linghunjianCost2 = (CCostSkill:GetRecorder(6001101)).OrderCost
  self._shanbiCost1 = (CCostSkill:GetRecorder(6000501)).ChaosCost
  self._shanbiCost2 = (CCostSkill:GetRecorder(6000501)).OrderCost
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleNewBattleGuide1BattleNewMainDialogCreated, Common.n_NewBattleGuide1BattleNewMainDialogCreated, nil)
end

BaseFirstBattleSceneController.OnDestroy = function(self)
  -- function num : 0_5 , upvalues : _ENV, BaseFirstBattleSceneController
  ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
  ;
  ((BaseFirstBattleSceneController.super).OnDestroy)(self)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
  ;
  (DialogManager.DestroySingletonDialog)("newbattle.battlenewmaindialog")
  if self._guideDialog then
    (self._guideDialog):Destroy()
    self._guideDialog = nil
  end
end

BaseFirstBattleSceneController.BSC_UpdateBattleLogicOneStep = function(self)
  -- function num : 0_6 , upvalues : BaseFirstBattleSceneController, UpdateGuide
  ((BaseFirstBattleSceneController.super).BSC_UpdateBattleLogicOneStep)(self)
  UpdateGuide(self)
end

BaseFirstBattleSceneController.OnRockerMove = function(self, notification)
  -- function num : 0_7
  local axisVector = (notification.userInfo).axisVector
  if (notification.userInfo).axisOffset > 0.01 then
    -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

    if self._userControl and axisVector.x > 0 then
      self._actorMove = 2
    else
      self._actorMove = -2
    end
  end
end

BaseFirstBattleSceneController.OnRockerEnd = function(self, notification)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC6: Unhandled construct in 'MakeBoolean' P1

  if self._userControl and self._actorMove > 0 then
    self._actorMove = 0.5
  else
    self._actorMove = -0.5
  end
end

BaseFirstBattleSceneController.OnDialogDestroy = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV
  if (notification.userInfo)._dialogName == "bag.itemaccountdialog" then
    (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
  end
end

BaseFirstBattleSceneController.OnNPCChatEnd = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV
  if notification.userInfo == self._npcChatId then
    self._npcChatId = 0
    ;
    (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
  else
    if notification.userInfo == self._gachaChatId then
      self._gachaChatId = 0
      ;
      (DialogManager.CreateSingletonDialog)("guide.baseguide2dialog")
    else
      if notification.userInfo == self._npcChatId_ShiXiangGui then
        (LuaNotificationCenter.RemoveObserver)(self, Common.n_Update)
        self._npcChatId_ShiXiangGui = 0
        ;
        (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
      end
    end
  end
end

BaseFirstBattleSceneController.OnGuideGetSkillEnd = function(self, notification)
  -- function num : 0_11 , upvalues : _ENV
  (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
end

BaseFirstBattleSceneController.OnGuideGachaTipsClosed = function(self, notification)
  -- function num : 0_12 , upvalues : _ENV
  local dlg = (DialogManager.CreateSingletonDialog)("base.baseguideoperator")
  if dlg then
    dlg:SetSceneController(self)
    dlg:ShowGuideEffect((self._sceneRef)._spring, "spring")
  end
end

BaseFirstBattleSceneController.OnUpdate = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if self._chatDuration_ShiXiangGui <= (ServerGameTimer.GetServerTimeForecast)() - self._startTime then
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_Update)
    self._npcChatId_ShiXiangGui = 0
    ;
    (DialogManager.DestroySingletonDialog)("npcchat.newnpcchatdialog")
    ;
    (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
  end
end

BaseFirstBattleSceneController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_14 , upvalues : BaseFirstBattleSceneController, _ENV
  ((BaseFirstBattleSceneController.super).Update)(self, deltaTime, unscaleDeltaTime)
  local moveDist = self._actorMoveSpeed * ((CS.UnityEngine).Time).deltaTime
  if self._battleEndMove then
    local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)((self._sceneRef)._acter1)
    if x + moveDist >= 0.5 then
      ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition)((self._sceneRef)._acter1, 0.5, y, z)
      ;
      (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", 0.5)
      self._battleEndMove = false
      self._actorMove = 0
      ;
      (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
    else
      ;
      ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition)((self._sceneRef)._acter1, x + moveDist, y, z)
    end
  else
    do
      if self._actorMove == 2 then
        local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)((self._sceneRef)._acter1)
        if x + moveDist > 14 then
          ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition)((self._sceneRef)._acter1, 14, y, z)
        else
          if x + moveDist > 8 then
            self._userControl = false
            self._actorMove = 0
            ;
            (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
            ;
            (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", -0.5)
            ;
            ((((((CS.PixelNeko).P1).TimeLine).TimelineManager).GetPlayableDirector)(self._timeline16)):Play()
          else
            ;
            ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition)((self._sceneRef)._acter1, x + moveDist, y, z)
          end
        end
      else
        do
          do
            if self._actorMove == -2 then
              local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)((self._sceneRef)._acter1)
              if x > 4 and x - moveDist <= 4 then
                self._userControl = false
                self._actorMove = 0
                ;
                (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
                ;
                ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition)((self._sceneRef)._acter1, 4, y, z)
                ;
                (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", -0.5)
                ;
                (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
              else
                ;
                ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition)((self._sceneRef)._acter1, x - moveDist, y, z)
              end
            end
            if self._actorMove ~= 0 then
              (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", self._actorMove)
            end
          end
        end
      end
    end
  end
end

BaseFirstBattleSceneController.OnTriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_15 , upvalues : _ENV
  if stringValue == "freeMove" then
    (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
    self._userControl = true
    ;
    (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
  else
    if stringValue == "tapMirror" then
      local dlg = (DialogManager.CreateSingletonDialog)("base.baseguideoperator")
      if dlg then
        dlg:SetSceneController(self)
        dlg:ShowGuideEffect((self._sceneRef)._mirror, "mirror")
        ;
        (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
      end
    else
      do
        if stringValue == "BaseCharacterInfoSkillChange2" then
          (DialogManager.CreateSingletonDialog)("guide.baseguide1dialog")
          ;
          (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
        else
          if stringValue == "battleStart" then
            (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
            local req = (LuaNetManager.CreateProtocol)("protocol.battle.cbattlestart")
            req.battleType = req.DUNGEON
            req.id = longValue
            req:Send()
          else
            do
              if stringValue == "battle" then
                (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
                self._guideBattleStart = true
                if self._battleStartProtocol then
                  self:OnSBattleStart(self._battleStartProtocol)
                end
              else
                if stringValue == "StartNPCChat" then
                  (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
                  self._npcChatId = longValue
                  ;
                  ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(longValue)
                else
                  if stringValue == "StartNPCChat_ShiXiangGui" then
                    (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
                    self._npcChatId_ShiXiangGui = longValue
                    self._chatDuration_ShiXiangGui = (math.ceil)(doubleValue)
                    self._startTime = (ServerGameTimer.GetServerTimeForecast)()
                    ;
                    ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(longValue)
                    ;
                    (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
                  else
                    if stringValue == "firstGaCha" then
                      (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
                      self._gachaChatId = longValue
                      ;
                      ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(longValue)
                    else
                      if stringValue == "inToMaze" then
                        local dlg = (DialogManager.CreateSingletonDialog)("base.baseguideoperator")
                        if dlg then
                          (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Pause)(self._timeline)
                          dlg:SetSceneController(self)
                          dlg:ShowGuideEffect((self._sceneRef)._gate, "gate")
                        end
                      else
                        do
                          if stringValue == "StopTimeline16" then
                            (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
                            self._actorMove = -0.5
                            self._userControl = true
                            ;
                            (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Stop)(self._timeline16)
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

BaseFirstBattleSceneController.OnTriggerBehaviourPause = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_16
end

BaseFirstBattleSceneController.OnGuideBaseMove = function(self, beginValue, endValue, normalizedTime)
  -- function num : 0_17 , upvalues : _ENV
  local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)((self._sceneRef)._acter1)
  ;
  ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetPosition)((self._sceneRef)._acter1, beginValue + (endValue - beginValue) * normalizedTime, y, z)
  if normalizedTime == 1 then
    if endValue - beginValue < 0 then
      (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", -0.5)
    else
      ;
      (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", 0.5)
    end
  else
    if endValue - beginValue < 0 then
      (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", -2)
    else
      ;
      (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", 2)
    end
  end
end

BaseFirstBattleSceneController.OnClick = function(self, uiPosition)
  -- function num : 0_18 , upvalues : _ENV, GlobalCameras, PhysicsStaticFunctions, SceneObjectClick
  local ray = ((self._sceneRef)._mainCameraComponent):ScreenPointToRay(((CS.UnityEngine).Vector3)((GlobalCameras.ScreenToScreenPoint)("UICamera", "BattleMain", uiPosition.x, uiPosition.y, 0)))
  local count = 0
  self._raycastHits = (PhysicsStaticFunctions.RaycastNonAlloc)(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return 
  end
  local raycastHit = (self._raycastHits)[0]
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)((raycastHit.collider).gameObject)
  if sceneObjectClick == nil then
    return 
  end
  local functionID = sceneObjectClick.IntData
  if functionID == 3 then
    (DialogManager.DestroySingletonDialog)("base.baseguideoperator")
    ;
    (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
  else
    if functionID == 2 and self._gachaDraw == false then
      self._gachaDraw = true
      ;
      (DialogManager.DestroySingletonDialog)("base.baseguideoperator")
      LogInfo("BaseSceneController", "跳转抽卡")
      local csend = (LuaNetManager.CreateProtocol)("protocol.card.cnewdrawcard")
      csend:Send()
    else
      do
        if functionID == 1 and self._intoMaze == false and self._gachaDraw then
          self._intoMaze = true
          ;
          (DialogManager.DestroySingletonDialog)("base.baseguideoperator")
          ;
          ((DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")):FirstEnterDungeon()
        end
      end
    end
  end
end

BaseFirstBattleSceneController.OnSBattleStart = function(self, protocol)
  -- function num : 0_19 , upvalues : BaseFirstBattleSceneController, _ENV, HandleNewBattleGuide1Stage1End, HandleNewBattleGuide1SpecialSkillClicked
  if self._guideBattleStart then
    ((BaseFirstBattleSceneController.super).OnSBattleStart)(self, protocol)
    ;
    ((self._sceneRef)._acter1):SetActive(false)
    if self._hasPlayedGuide == true then
      return 
    end
    self._guideStage = 0
    self._guideDialog = (DialogManager.CreateSingletonDialog)("battle.battletutorial.battletutorial2dialog")
    ;
    (self._guideDialog):SetNoActive()
    ;
    (self._guideDialog):SetSkillMaskState(true)
    ;
    (LuaNotificationCenter.AddObserver)(self, HandleNewBattleGuide1Stage1End, Common.n_NewBattleGuide1Stage1End, nil)
    ;
    (LuaNotificationCenter.AddObserver)(self, HandleNewBattleGuide1SpecialSkillClicked, Common.n_NewBattleGuide1SpecialSkillClicked, nil)
  else
    ;
    (((((CS.PixelNeko).P1).TimeLine).TimelineManager).Resume)(self._timeline)
    self._battleStartProtocol = protocol
  end
end

BaseFirstBattleSceneController.BSC_BattleEnd = function(self)
  -- function num : 0_20 , upvalues : BaseFirstBattleSceneController, _ENV
  ((BaseFirstBattleSceneController.super).BSC_BattleEnd)(self)
  if self._bsc_battleEndProtocol and ((self._bsc_battleEndProtocol).battleResult).result == 1 then
    ((self._sceneRef)._acter1):SetActive(true)
    ;
    (((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)((self._sceneRef)._acter1)):SetFloat("dirX", 1)
    self._battleEndMove = true
  end
end

BaseFirstBattleSceneController.OnSBattleResult = function(self, protocol)
  -- function num : 0_21 , upvalues : BaseFirstBattleSceneController, _ENV
  ((BaseFirstBattleSceneController.super).OnSBattleResult)(self, protocol)
  ;
  ((((CS.PixelNeko).Animation).AnimationHelper).SetAnimatorInteger2)(((self._sceneRef):BSR_GetBattleCamera()).gameObject, "camState", 1)
end

return BaseFirstBattleSceneController

