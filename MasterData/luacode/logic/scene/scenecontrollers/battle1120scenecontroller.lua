local Time = CS.UnityEngine.Time
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CBattleConfig = BeanManager.GetTableByName("battle.cbattleconstcfg")
local Battle1120SceneController = class("Battle1120SceneController", NewBattleSceneController)

local function UpdateGuide(self, deltaTime)
  if self._guideStage == nil and self._battleDialogInited == false then
    return
  end
  local stepNum = self._bsc_stepNum
  if self._guideStage == 0 and 60 <= stepNum then
    NekoData.DataManager.DM_TimeScale:SetBattleGuidePause()
    self._guideDialog:SetStage1Active()
    self._guideDialog:SetSkillMaskState(false)
    self._guideStage = 1
    self._bsc_battleTime = 0
    local userInfo = {}
    userInfo.guideID = 1
    LuaNotificationCenter.PostNotification(Common.n_NewBattleGuide1StartStage1, nil, userInfo)
  elseif self._guideStage == 1 and stepNum >= tonumber(CBattleConfig:GetRecorder(1).attr) * 2 then
    NekoData.DataManager.DM_TimeScale:SetBattleGuidePause()
    self._guideDialog:SetStage2Active()
    self._guideDialog:SetSkillMaskState(false)
    self._guideStage = 2
    self._bsc_battleTime = 0
    NekoData.BehaviorManager.BM_Voice:PlayVoice(20010003)
    local userInfo = {}
    userInfo.guideID = 1
    LuaNotificationCenter.PostNotification(Common.n_NewBattleGuide1SpecialSkillEffect, nil, userInfo)
  end
end

local function HandleNewBattleGuide1Stage1End(self, notification)
  NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
  self._guideDialog:SetNoActive()
  self._guideDialog:SetSkillMaskState(true)
  self._guideDialog._stage1:Unsubscribe_UpdateEvent(self._guideDialog._stage1UpdateHandler)
  self._guideDialog._stage1UpdateHandler = nil
end

local function HandleNewBattleGuide1SpecialSkillClicked(self, notification)
  NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
  self._guideStage = nil
  self._guideDialog:Destroy()
  self._guideDialog = nil
  self._hasPlayedGuide = true
  self._battleDialogInited = false
  LuaNotificationCenter.RemoveObserver(self, Common.n_NewBattleGuide1SpecialSkillClicked)
  LuaNotificationCenter.PostNotification(Common.n_NewBattleGuideEnd, self, {guideID = 1})
end

local function HandleNewBattleGuide1BattleNewMainDialogCreated(self, notification)
  self._battleDialogInited = true
end

function Battle1120SceneController:Ctor(sceneRef)
  Battle1120SceneController.super.Ctor(self, sceneRef)
end

function Battle1120SceneController:Init(...)
  Battle1120SceneController.super.Init(self, ...)
  self._guideDialog = nil
  self._guideStage = nil
  self._hasPlayedGuide = false
  self._battleDialogInited = false
  LuaNotificationCenter.AddObserver(self, HandleNewBattleGuide1BattleNewMainDialogCreated, Common.n_NewBattleGuide1BattleNewMainDialogCreated, nil)
end

function Battle1120SceneController:BSC_UpdateBattleLogicOneStep()
  Battle1120SceneController.super.BSC_UpdateBattleLogicOneStep(self)
  UpdateGuide(self)
end

function Battle1120SceneController:OnDestroy()
  NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
  Battle1120SceneController.super.OnDestroy(self)
  LuaNotificationCenter.RemoveObserver(self)
end

function Battle1120SceneController:OnSBattleStart(protocol)
  Battle1120SceneController.super.OnSBattleStart(self, protocol)
  if self._hasPlayedGuide == true then
    return
  end
  self._guideStage = 0
  self._guideDialog = DialogManager.CreateSingletonDialog("battle.battletutorial.battletutorial1dialog")
  self._guideDialog:SetNoActive()
  LuaNotificationCenter.AddObserver(self, HandleNewBattleGuide1Stage1End, Common.n_NewBattleGuide1Stage1End, nil)
  LuaNotificationCenter.AddObserver(self, HandleNewBattleGuide1SpecialSkillClicked, Common.n_NewBattleGuide1SpecialSkillClicked, nil)
end

return Battle1120SceneController
