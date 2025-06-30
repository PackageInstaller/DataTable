-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battletutorial/battletutorial1dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Time = (CS.UnityEngine).Time
local BattleTutorial1 = class("BattleTutorial1", Dialog)
BattleTutorial1.AssetBundleName = "ui/layouts.battlenew"
BattleTutorial1.AssetName = "BattleNewGuide1"
local OnGuide1Update = function(self)
  -- function num : 0_0 , upvalues : Time, _ENV
  if self._stage1UpdateHandler == nil then
    return 
  end
  self._stage1Timer = self._stage1Timer + Time.unscaledDeltaTime
  if self._stage1TotalTime < self._stage1Timer and ((NekoData.BehaviorManager).BM_TimeScale):IsBattleGuidePause() then
    local userInfo = {}
    userInfo.guideID = 1
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1Stage1End, nil, userInfo)
  end
end

local OnStage1Click = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._stage1UpdateHandler == nil or not ((NekoData.BehaviorManager).BM_TimeScale):IsBattleGuidePause() then
    return 
  end
  local userInfo = {}
  userInfo.guideID = 1
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1Stage1End, nil, userInfo)
end

BattleTutorial1.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : BattleTutorial1
  ((BattleTutorial1.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
  self._stage1UpdateHandler = nil
  self._stage1Timer = 0
  self._stage1TotalTime = 4
end

BattleTutorial1.OnCreate = function(self)
  -- function num : 0_3 , upvalues : OnStage1Click
  self._stage1 = self:GetChild("BattleNewTutorial1")
  self._stage1Click = self:GetChild("BattleNewTutorial1/Click")
  self._stage2 = self:GetChild("BattleNewTutorial2")
  self._stage3 = self:GetChild("BattleNewTutorial3")
  self._skillMask = self:GetChild("Empty")
  self._effect1 = self:GetChild("BattleNewTutorial1/Effect")
  self._skillPanelEffect1 = self:GetChild("BattleNewTutorial2/Effect")
  ;
  (self._stage1Click):Subscribe_PointerClickEvent(OnStage1Click, self)
end

BattleTutorial1.SetStage1Active = function(self)
  -- function num : 0_4 , upvalues : OnGuide1Update
  (self._stage1):SetActive(true)
  ;
  (self._stage2):SetActive(false)
  ;
  (self._stage3):SetActive(false)
  self._stage1UpdateHandler = (self._stage1):Subscribe_UpdateEvent(OnGuide1Update, self)
end

BattleTutorial1.SetStage2Active = function(self)
  -- function num : 0_5
  (self._stage1):SetActive(false)
  ;
  (self._stage2):SetActive(true)
  ;
  (self._stage3):SetActive(false)
end

BattleTutorial1.SetStage3Active = function(self)
  -- function num : 0_6
  (self._stage1):SetActive(false)
  ;
  (self._stage2):SetActive(false)
  ;
  (self._stage3):SetActive(true)
end

BattleTutorial1.SetNoActive = function(self)
  -- function num : 0_7
  (self._stage1):SetActive(false)
  ;
  (self._stage2):SetActive(false)
  ;
  (self._stage3):SetActive(false)
end

BattleTutorial1.SetSkillMaskState = function(self, isActive)
  -- function num : 0_8
  (self._skillMask):SetActive(isActive)
end

return BattleTutorial1

