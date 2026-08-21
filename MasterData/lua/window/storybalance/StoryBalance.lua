local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local S = require("Common/Singleton")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local m_balance, m_rewards, m_skipAnim

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, false)
  WU.BindButtonEvent(REF.buttonback, function()
    BASE.OnButtonContinueClick()
  end)
  WU.BindButtonEvent(REF.AnimMask, OnSkipAnimClick)
end

function InitWindow()
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  BASE.SetActorTextureEffect(this:GetData("FightWinActor"))
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  m_balance = this:GetData("DungeonBalance/result")
  m_rewards = DU.GetDungeonBalanceRewards(m_balance)
  WU.ToggleRendering(REF.Targets, false)
  WU.ToggleRendering(REF.TitleLine1, false)
  WU.ToggleRendering(REF.AcquirementList, false)
  WU.ToggleRendering(REF.WidgetProfitBuffList, false)
  local chapterId = this:GetData("WindowDungeon/ChapterId")
  local chapterInfo = this:GetData("fci/dungeon/chapter/" .. chapterId)
  if chapterInfo then
    local balance = chapterInfo.recordDungeons[dungeonId]
    if balance then
      BASE.InitTargets(balance, dungeonId)
    end
  end
  BASE.InitAcquirement(m_balance)
  BASE.InitPlayerInfo(m_balance)
  WU.ToggleRendering(REF.AnimMask, true)
  PlayPlayerExpAnim()
  this:DelayInvokeInSeconds(0.2, function()
    local tutorialId = this:GetData("CurrentTutorial")
    if tutorialId == 2 and dungeonId == 2012 or tutorialId == 3 and dungeonId == 2013 or tutorialId == 21 and dungeonId == 2011 or tutorialId == 22 and dungeonId == 2012 or tutorialId == 27 and dungeonId == 2013 or tutorialId == 24 or tutorialId == 101 and dungeonId == 2 or tutorialId == 102 and dungeonId == 5 or tutorialId == 103 and dungeonId == 7 or tutorialId == 104 and dungeonId == 9 or tutorialId == 105 and dungeonId == 13 or tutorialId == 106 and dungeonId == 15 then
      local tutorialMgr = S:Get("TutorialManager")
      local isDone = tutorialMgr.IsTutorialDone(tutorialId)
      tutorialMgr.DoTutorial()
      if tutorialId == 3 and not isDone then
        this:SetData("Tutorial/ToCity", true)
      end
    end
  end)
  local isShowStar = DU.IsShowStar(dungeonId)
  if isShowStar then
    if REF.LabelDesc then
      REF.LabelDesc.gameObject:SetActive(false)
    end
    if REF.Targets then
      REF.Targets.gameObject:SetActive(true)
    end
  else
    if REF.LabelDesc then
      REF.LabelDesc.gameObject:SetActive(true)
    end
    if REF.Targets then
      REF.Targets.gameObject:SetActive(false)
    end
    if REF.RightPanel then
      local curps = REF.RightPanel.transform.localPosition
      REF.RightPanel.transform.localPosition = CS.UnityEngine.Vector3(curps.x, REF.LabelDesc.transform.localPosition.y - 190, 0)
    end
    REF.LabelDesc.UILabel.text = WU.GetString("DungeonBalanceDescribe_" .. dungeonId)
  end
  if #BASE.m_rewards < 7 then
    REF.AcquirementScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.TopRight
    REF.AcquirementScrollView.UIScrollView:ResetPosition()
  end
end

function OnWindowUninited(window)
  if window.name == "PlayerLevelupResult" then
    PlayOtherAnim()
  end
end

function OnSkipAnimClick()
  m_skipAnim = true
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.Targets, true)
  WU.ToggleRendering(REF.TitleLine1, true)
  BASE.SetProfitBuff(m_balance.profits, CS.UIWidget.Pivot.Left)
  BASE.ShiningStars(true)
  REF.Targets.UIPlayTween:Play(true)
  REF.Targets.UIPlayTween:Finish()
  WU.ToggleRendering(REF.AcquirementList, true)
  if 0 < #m_rewards then
    REF.AcquirementContent.UIPlayTween:Play(true)
    REF.AcquirementContent.UIPlayTween:Finish()
  end
  OnAnimFinished()
end

function PlayPlayerExpAnim()
  this:DelayInvokeInSeconds(0.5, function()
    if m_skipAnim then
      return
    end
    REF.SpriteExpAdd.TweenFillAmount.enabled = true
    if m_balance.playerLevelBeforeBalance == m_balance.playerLevel then
      this:DelayInvokeInSeconds(1, function()
        if m_skipAnim then
          return
        end
        PlayOtherAnim()
      end)
    end
  end)
end

function PlayOtherAnim()
  if m_skipAnim then
    return
  end
  WU.ToggleRendering(REF.Targets, true)
  REF.Targets.UIPlayTween:Play(true)
  BASE.ShiningStars()
  this:DelayInvokeInSeconds(BASE.ShiningStarDelay * #m_balance.targetsDone, function()
    if m_skipAnim then
      return
    end
    WU.ToggleRendering(REF.TitleLine1, true)
    REF.TitleLine1.UIPlayTween:Play(true)
    BASE.SetProfitBuff(m_balance.profits, CS.UIWidget.Pivot.Left)
    this:DelayInvokeInSeconds(BASE.TitleAnimTime, function()
      if m_skipAnim then
        return
      end
      WU.ToggleRendering(REF.AcquirementList, true)
      REF.AcquirementContent.UIPlayTween:Play(true)
      local rewards = DU.GetDungeonBalanceRewards(m_balance)
      this:DelayInvokeInSeconds(#rewards * BASE.RewardAnimTime, function()
        if m_skipAnim then
          return
        end
        OnAnimFinished()
      end)
    end)
  end)
end

function OnAnimFinished()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, true)
  if 7 <= #m_rewards then
    REF.AcquirementList.BoxCollider2D.enabled = true
    WU.TraverseChildren(REF.AcquirementContent, function(go)
      go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = true
    end)
  end
  WU.TraverseChildren(REF.AcquirementContent, function(go)
    go:SetActive(true)
  end)
  BASE.OnDungeonAnimFinished()
end

function OnDestroy()
  BASE.OnDestroy()
end
