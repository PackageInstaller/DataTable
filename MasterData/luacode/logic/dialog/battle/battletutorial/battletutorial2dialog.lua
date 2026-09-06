local Time = CS.UnityEngine.Time
local BattleTutorial2 = class("BattleTutorial2", Dialog)
BattleTutorial2.AssetBundleName = "ui/layouts.battlenew"
BattleTutorial2.AssetName = "BattleNewGuide2"

local function OnGuide1Update(self)
  if self._stage1UpdateHandler == nil then
    return
  end
  self._stage1Timer = self._stage1Timer + Time.unscaledDeltaTime
  if self._stage1Timer > self._stage1TotalTime and NekoData.BehaviorManager.BM_TimeScale:IsBattleGuidePause() then
    local userInfo = {}
    userInfo.guideID = 2
    LuaNotificationCenter.PostNotification(Common.n_NewBattleGuide1Stage1End, nil, userInfo)
  end
end

local function OnStage1Click(self)
  if self._stage1UpdateHandler == nil or not NekoData.BehaviorManager.BM_TimeScale:IsBattleGuidePause() then
    return
  end
  local userInfo = {}
  userInfo.guideID = 2
  LuaNotificationCenter.PostNotification(Common.n_NewBattleGuide1Stage1End, nil, userInfo)
end

function BattleTutorial2:Ctor(...)
  BattleTutorial2.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
  self._stage1UpdateHandler = nil
  self._stage1Timer = 0
  self._stage1TotalTime = 4
end

function BattleTutorial2:OnCreate()
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
  self._stage1Click:Subscribe_PointerClickEvent(OnStage1Click, self)
end

function BattleTutorial2:SetStage1Active()
  self._stage1:SetActive(true)
  self._stage2:SetActive(false)
  self._stageLingHunJian:SetActive(false)
  self._stage1UpdateHandler = self._stage1:Subscribe_UpdateEvent(OnGuide1Update, self)
end

function BattleTutorial2:SetStage2Active()
  self._stage1:SetActive(false)
  self._stage2:SetActive(true)
  self._stageLingHunJian:SetActive(false)
end

function BattleTutorial2:SetLingHunJianActive(lingHunJianStage)
  self._stageLingHunJian:SetActive(true)
  self._stage1:SetActive(false)
  self._stage2:SetActive(false)
  self._stageLingHunJian1:SetActive(lingHunJianStage == 1)
  self._stageLingHunJian2:SetActive(lingHunJianStage == 2)
end

function BattleTutorial2:SetNoActive()
  self._stage1:SetActive(false)
  self._stage2:SetActive(false)
  self._stageLingHunJian:SetActive(false)
end

function BattleTutorial2:SetSkillMaskState(isActive)
  self._skillMask:SetActive(isActive)
end

return BattleTutorial2
