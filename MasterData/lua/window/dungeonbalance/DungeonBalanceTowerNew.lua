local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local m_balance, m_rewards, m_skipAnim
local m_animFinished = false
local m_summary, m_groups

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.TopFloor, false)
  WU.BindButtonEvent(REF.ButtonContinue, OnButtonContinueClick)
  WU.BindButtonEvent(REF.AnimMask, OnSkipAnimClick)
  REF.WidgetDungeonGroup.gameObject:SetActive(false)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    this:SetData("ShareConfig", {
      shareName = "TowerNewPrepare",
      fromWindow = WU.TopWindow() and WU.TopWindow().name
    })
    local data = {
      selectActors = DB:GetData("fci/extreme-challenge/select-actors/").actors,
      curFloor = m_summary.curFloor - 1
    }
    this:SetData("Share/TowerNewPrepare", data)
    WU.AcquireWindowAsync("Share")
  end)
end

function InitWindow()
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  m_balance = this:GetData("DungeonBalance/result")
  m_rewards = DU.GetDungeonBalanceRewards(m_balance.result)
  DBH.ResChange(m_balance.result.resChange)
  WU.ToggleRendering(REF.TitleLine1, false)
  WU.ToggleRendering(REF.AcquirementList, false)
  WU.ToggleRendering(REF.WidgetProfitBuffList, false)
  REF.LabelCurrentFloor.gameObject:SetActive(false)
  this:SetData("fci/extreme-challenge/summary/", nil)
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/summary/"), OnTowerSummary)
  this:SetData("fci/extreme-challenge/actorgroup/", nil)
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/actorgroup/"), OnActorGroup)
  BASE.InitAcquirement(m_balance.result)
  UpdateActors(m_balance.actors)
  NU.UpdateRoleFavour(m_balance.result.favourChange)
  WU.ToggleRendering(REF.AnimMask, true)
  PlayAnim()
  if #BASE.m_rewards < 7 then
    REF.AcquirementScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.TopRight
    REF.AcquirementScrollView.UIScrollView:ResetPosition()
  end
end

function UpdateActors(actors)
  local curActors = this:GetData("fci/extreme-challenge/select-actors/")
  for k, v in pairs(curActors.actors) do
    local index, data = table.find(actors, function(key, val)
      return v.actor.uid == val.actor.uid
    end)
    if data then
      v.hp = data.hp
      v.index = data.index
      v.dragfast = data.dragfast
    end
  end
end

function OnTowerSummary(result)
  if result == nil then
    return
  end
  local curFloor = result.curFloor - 1
  m_summary = result
  REF.LabelCurrentFloor.UILabel.text = WU.GetString("WindowTower_CurrentFloor", curFloor)
  REF.LabelCurrentFloor.gameObject:SetActive(true)
end

function OnActorGroup(result)
  if result == nil then
    return
  end
  WU.ToggleRendering(REF.WidgetDungeonGroup, true)
  REF.WidgetDungeonGroup.gameObject:SetActive(true)
  m_groups = result
  local tempGroup = {
    members = m_groups.actorGroup
  }
  REF.WidgetDungeonGroup["$SetView"](tempGroup)
  REF.WidgetDungeonGroup["$SetHp"](tempGroup)
end

function OnSkipAnimClick()
  m_skipAnim = true
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.TitleLine1, true)
  BASE.SetProfitBuff(m_balance.profits, CS.UIWidget.Pivot.Left)
  WU.ToggleRendering(REF.AcquirementList, true)
  if 0 < #m_rewards then
    REF.AcquirementContent.UIPlayTween:Play(true)
    REF.AcquirementContent.UIPlayTween:Finish()
  end
  OnAnimFinished()
end

function PlayAnim()
  this:DelayInvokeInSeconds(0.5, function()
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
      this:DelayInvokeInSeconds(#m_rewards * BASE.RewardAnimTime, function()
        if m_skipAnim then
          return
        end
        this:DelayInvokeInSeconds(0.5, function()
          if m_skipAnim then
            return
          end
          OnAnimFinished()
        end)
      end)
    end)
  end)
end

function OnAnimFinished()
  WU.ToggleRendering(REF.AnimMask, false)
  if #m_rewards > #REF.AcquirementContent - 2 then
    REF.AcquirementList.BoxCollider2D.enabled = true
    WU.TraverseChildren(REF.AcquirementContent, function(go)
      go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = true
    end)
  end
  m_animFinished = true
  BASE.OnDungeonAnimFinished()
end

function OnButtonDetailClick()
  WU.AcquireWindowAsync("DungeonBalanceTowerNewDetail")
end

function OnBackClick()
  DU.LeaveTowerNew(1)
end

function OnButtonContinueClick()
  DU.LeaveTowerNew(1)
end
