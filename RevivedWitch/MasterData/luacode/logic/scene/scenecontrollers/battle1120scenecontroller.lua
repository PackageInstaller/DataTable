-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/battle1120scenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Time = (CS.UnityEngine).Time
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local CBattleConfig = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local Battle1120SceneController = class("Battle1120SceneController", NewBattleSceneController)
local UpdateGuide = function(self, deltaTime)
  -- function num : 0_0 , upvalues : _ENV, CBattleConfig
  if self._guideStage == nil and self._battleDialogInited == false then
    return 
  end
  local stepNum = self._bsc_stepNum
  if self._guideStage == 0 and stepNum >= 60 then
    ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
    ;
    (self._guideDialog):SetStage1Active()
    ;
    (self._guideDialog):SetSkillMaskState(false)
    self._guideStage = 1
    self._bsc_battleTime = 0
    local userInfo = {}
    userInfo.guideID = 1
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1StartStage1, nil, userInfo)
  else
    do
      if self._guideStage == 1 and tonumber((CBattleConfig:GetRecorder(1)).attr) * 2 <= stepNum then
        ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
        ;
        (self._guideDialog):SetStage2Active()
        ;
        (self._guideDialog):SetSkillMaskState(false)
        self._guideStage = 2
        self._bsc_battleTime = 0
        ;
        ((NekoData.BehaviorManager).BM_Voice):PlayVoice(20010003)
        local userInfo = {}
        userInfo.guideID = 1
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1SpecialSkillEffect, nil, userInfo)
      end
    end
  end
end

local HandleNewBattleGuide1Stage1End = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV
  ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
  ;
  (self._guideDialog):SetNoActive()
  ;
  (self._guideDialog):SetSkillMaskState(true)
  ;
  ((self._guideDialog)._stage1):Unsubscribe_UpdateEvent((self._guideDialog)._stage1UpdateHandler)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._guideDialog)._stage1UpdateHandler = nil
end

local HandleNewBattleGuide1SpecialSkillClicked = function(self, notification)
  -- function num : 0_2 , upvalues : _ENV
  ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
  self._guideStage = nil
  ;
  (self._guideDialog):Destroy()
  self._guideDialog = nil
  self._hasPlayedGuide = true
  self._battleDialogInited = false
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_NewBattleGuide1SpecialSkillClicked)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuideEnd, self, {guideID = 1})
end

local HandleNewBattleGuide1BattleNewMainDialogCreated = function(self, notification)
  -- function num : 0_3
  self._battleDialogInited = true
end

Battle1120SceneController.Ctor = function(self, sceneRef)
  -- function num : 0_4 , upvalues : Battle1120SceneController
  ((Battle1120SceneController.super).Ctor)(self, sceneRef)
end

Battle1120SceneController.Init = function(self, ...)
  -- function num : 0_5 , upvalues : Battle1120SceneController, _ENV, HandleNewBattleGuide1BattleNewMainDialogCreated
  ((Battle1120SceneController.super).Init)(self, ...)
  self._guideDialog = nil
  self._guideStage = nil
  self._hasPlayedGuide = false
  self._battleDialogInited = false
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleNewBattleGuide1BattleNewMainDialogCreated, Common.n_NewBattleGuide1BattleNewMainDialogCreated, nil)
end

Battle1120SceneController.BSC_UpdateBattleLogicOneStep = function(self)
  -- function num : 0_6 , upvalues : Battle1120SceneController, UpdateGuide
  ((Battle1120SceneController.super).BSC_UpdateBattleLogicOneStep)(self)
  UpdateGuide(self)
end

Battle1120SceneController.OnDestroy = function(self)
  -- function num : 0_7 , upvalues : _ENV, Battle1120SceneController
  ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
  ;
  ((Battle1120SceneController.super).OnDestroy)(self)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

Battle1120SceneController.OnSBattleStart = function(self, protocol)
  -- function num : 0_8 , upvalues : Battle1120SceneController, _ENV, HandleNewBattleGuide1Stage1End, HandleNewBattleGuide1SpecialSkillClicked
  ((Battle1120SceneController.super).OnSBattleStart)(self, protocol)
  if self._hasPlayedGuide == true then
    return 
  end
  self._guideStage = 0
  self._guideDialog = (DialogManager.CreateSingletonDialog)("battle.battletutorial.battletutorial1dialog")
  ;
  (self._guideDialog):SetNoActive()
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleNewBattleGuide1Stage1End, Common.n_NewBattleGuide1Stage1End, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleNewBattleGuide1SpecialSkillClicked, Common.n_NewBattleGuide1SpecialSkillClicked, nil)
end

return Battle1120SceneController

