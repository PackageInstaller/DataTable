local Time = CS.UnityEngine.Time
local BattleTutorial1 = class("BattleTutorial1", Dialog)
BattleTutorial1.AssetBundleName = "ui/layouts.battlenew"
BattleTutorial1.AssetName = "BattleNewGuide1"

local function OnGuide1Update(self)
  if self._stage1UpdateHandler == nil then
    return
  end
  self._stage1Timer = self._stage1Timer + Time.unscaledDeltaTime
  if self._stage1Timer > self._stage1TotalTime and NekoData.BehaviorManager.BM_TimeScale:IsBattleGuidePause() then
    local userInfo = {}
    userInfo.guideID = 1
    LuaNotificationCenter.PostNotification(Common.n_NewBattleGuide1Stage1End, nil, userInfo)
  end
end

local function OnStage1Click(self)
  if self._stage1UpdateHandler == nil or not NekoData.BehaviorManager.BM_TimeScale:IsBattleGuidePause() then
    return
  end
  local userInfo = {}
  userInfo.guideID = 1
  LuaNotificationCenter.PostNotification(Common.n_NewBattleGuide1Stage1End, nil, userInfo)
end

function BattleTutorial1:Ctor(...)
  BattleTutorial1.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
  self._stage1UpdateHandler = nil
  self._stage1Timer = 0
  self._stage1TotalTime = 4
end

function BattleTutorial1:OnCreate()
  self._stage1 = self:GetChild("BattleNewTutorial1")
  self._stage1Click = self:GetChild("BattleNewTutorial1/Click")
  self._stage2 = self:GetChild("BattleNewTutorial2")
  self._stage3 = self:GetChild("BattleNewTutorial3")
  self._skillMask = self:GetChild("Empty")
  self._effect1 = self:GetChild("BattleNewTutorial1/Effect")
  self._skillPanelEffect1 = self:GetChild("BattleNewTutorial2/Effect")
  self._stage1Click:Subscribe_PointerClickEvent(OnStage1Click, self)
end

function BattleTutorial1:SetStage1Active()
  self._stage1:SetActive(true)
  self._stage2:SetActive(false)
  self._stage3:SetActive(false)
  self._stage1UpdateHandler = self._stage1:Subscribe_UpdateEvent(OnGuide1Update, self)
end

function BattleTutorial1:SetStage2Active()
  self._stage1:SetActive(false)
  self._stage2:SetActive(true)
  self._stage3:SetActive(false)
end

function BattleTutorial1:SetStage3Active()
  self._stage1:SetActive(false)
  self._stage2:SetActive(false)
  self._stage3:SetActive(true)
end

function BattleTutorial1:SetNoActive()
  self._stage1:SetActive(false)
  self._stage2:SetActive(false)
  self._stage3:SetActive(false)
end

function BattleTutorial1:SetSkillMaskState(isActive)
  self._skillMask:SetActive(isActive)
end

return BattleTutorial1
