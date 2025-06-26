-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battletutorial/battletutorial2dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Time = (CS.UnityEngine).Time
local BattleTutorial2 = class("BattleTutorial2", Dialog)
BattleTutorial2.AssetBundleName = "ui/layouts.battlenew"
BattleTutorial2.AssetName = "BattleNewGuide2"
local OnGuide1Update = function(self)
  -- function num : 0_0 , upvalues : Time, _ENV
  if self._stage1UpdateHandler == nil then
    return 
  end
  self._stage1Timer = self._stage1Timer + Time.unscaledDeltaTime
  if self._stage1TotalTime < self._stage1Timer and ((NekoData.BehaviorManager).BM_TimeScale):IsBattleGuidePause() then
    local userInfo = {}
    userInfo.guideID = 2
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
  userInfo.guideID = 2
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1Stage1End, nil, userInfo)
end

BattleTutorial2.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : BattleTutorial2
  ((BattleTutorial2.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
  self._stage1UpdateHandler = nil
  self._stage1Timer = 0
  self._stage1TotalTime = 4
end

BattleTutorial2.OnCreate = function(self)
  -- function num : 0_3 , upvalues : OnStage1Click
  self._stage1 = self:GetChild("BattleNewTutorial4")
  self._stage2 = self:GetChild("BattleNewTutorial5")
  self._stageLingHunJian = self:GetChild("BattleNewTutorial6")
  self._stage1Click = self:GetChild("BattleNewTutorial4/Click")
  self._skillMask = self:GetChild("Empty")
  self._effect2 = self:GetChild("BattleNewTutorial4/Effect")
  self._skillPanelEffect2 = self:GetChild("BattleNewTutorial5/Effect")
  self._skillPanelEffect6 = self:GetChild("BattleNewTutorial6/Effect")
  self._stageLingHunJian1 = self:GetChild("BattleNewTutorial6/Back1")
  self._stageLingHunJian2 = self:GetChild("BattleNewTutorial6/Back2")
  ;
  (self._stage1Click):Subscribe_PointerClickEvent(OnStage1Click, self)
end

BattleTutorial2.SetStage1Active = function(self)
  -- function num : 0_4 , upvalues : OnGuide1Update
  (self._stage1):SetActive(true)
  ;
  (self._stage2):SetActive(false)
  ;
  (self._stageLingHunJian):SetActive(false)
  self._stage1UpdateHandler = (self._stage1):Subscribe_UpdateEvent(OnGuide1Update, self)
end

BattleTutorial2.SetStage2Active = function(self)
  -- function num : 0_5
  (self._stage1):SetActive(false)
  ;
  (self._stage2):SetActive(true)
  ;
  (self._stageLingHunJian):SetActive(false)
end

BattleTutorial2.SetLingHunJianActive = function(self, lingHunJianStage)
  -- function num : 0_6
  (self._stageLingHunJian):SetActive(true)
  ;
  (self._stage1):SetActive(false)
  ;
  (self._stage2):SetActive(false)
  ;
  (self._stageLingHunJian1):SetActive(lingHunJianStage == 1)
  ;
  (self._stageLingHunJian2):SetActive(lingHunJianStage == 2)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BattleTutorial2.SetNoActive = function(self)
  -- function num : 0_7
  (self._stage1):SetActive(false)
  ;
  (self._stage2):SetActive(false)
  ;
  (self._stageLingHunJian):SetActive(false)
end

BattleTutorial2.SetSkillMaskState = function(self, isActive)
  -- function num : 0_8
  (self._skillMask):SetActive(isActive)
end

return BattleTutorial2

