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
local m_isMaxFloor = true
local m_startCountdown = false
local m_time = 10

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.BottomButtons, false)
  WU.ToggleRendering(REF.TopFloor, false)
  WU.BindButtonEvent(REF.ButtonDetail, OnButtonDetailClick)
  WU.BindButtonEvent(REF.ButtonFight, OnButtonContinueClick)
  WU.BindButtonEvent(REF.ButtonSwitchTeam, OnClickSwitchTeam)
  WU.BindButtonEvent(REF.ButtonBack, OnBackClick)
  WU.BindButtonEvent(REF.AnimMask, OnSkipAnimClick)
  REF.WidgetDungeonGroup.gameObject:SetActive(false)
end

function InitWindow()
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  REF.LabelDesc.UILabel.text = WU.GetString("DungeonBalanceDescribe_" .. dungeonId)
  m_balance = this:GetData("DungeonBalance/result")
  m_rewards = DU.GetDungeonBalanceRewards(m_balance)
  WU.ToggleRendering(REF.TitleLine1, false)
  WU.ToggleRendering(REF.AcquirementList, false)
  WU.ToggleRendering(REF.WidgetProfitBuffList, false)
  REF.LabelCurrentFloor.gameObject:SetActive(false)
  this:SetData("fci/tower/summary/", nil)
  this:BindRemote(DB:GameRequest("fci/tower/summary/"), OnTowerSummary)
  this:SetData("fci/tower/actorgroup-confirm/", nil)
  this:BindRemote(DB:GameRequest("fci/tower/actorgroup-confirm/"), OnActorGroupConfirm)
  BASE.InitAcquirement(m_balance)
  NU.UpdateRoleFavour(m_balance.favourChange)
  WU.ToggleRendering(REF.AnimMask, true)
  PlayAnim()
  if #BASE.m_rewards < 7 then
    REF.AcquirementScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.TopRight
    REF.AcquirementScrollView.UIScrollView:ResetPosition()
  end
end

function UpdateWindow(delta)
  if m_startCountdown then
    m_time = m_time - delta
    REF.LabelCountdown.UILabel.text = "(" .. math.ceil(m_time) .. "s)"
    if m_time < 0 then
      m_startCountdown = false
      EnterTowerDungeon()
    end
  end
end

function OnTowerSummary(result)
  if result == nil then
    return
  end
  local maxFloor = PB.all("TowerFloor"):last()
  local curFloor = result.towerFloor - 1
  m_isMaxFloor = curFloor >= maxFloor.floor
  if m_isMaxFloor then
    curFloor = maxFloor.floor
  end
  m_summary = result
  REF.LabelCurrentFloor.UILabel.text = WU.GetString("WindowTower_CurrentFloor", curFloor)
  REF.LabelCurrentFloor.gameObject:SetActive(true)
  if m_animFinished then
    SetFloorInfo()
  end
end

function OnActorGroupConfirm(result)
  if result == nil then
    return
  end
  WU.ToggleRendering(REF.WidgetDungeonGroup, true)
  REF.WidgetDungeonGroup.gameObject:SetActive(true)
  m_groups = result
  local selectGroupId = this:GetData("fci/SelectedGroupId/tower/").selectActorGroupId
  REF.WidgetDungeonGroup["$SetView"](m_groups[tostring(selectGroupId)])
  REF.WidgetDungeonGroup["$SetHp"](m_groups[tostring(selectGroupId)])
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
  if m_summary ~= nil then
    SetFloorInfo()
  end
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
  m_startCountdown = false
  WU.AcquireWindowAsync("DungeonBalanceTowerDetail")
end

function OnBackClick()
  m_startCountdown = false
  DU.LeaveDungeon(1)
end

function OnButtonContinueClick()
  m_startCountdown = false
  EnterTowerDungeon()
end

function SetFloorInfo()
  if m_isMaxFloor then
    WU.ToggleRendering(REF.TopFloor, true)
  else
    m_startCountdown = true
    WU.ToggleRendering(REF.BottomButtons, true)
  end
end

function EnterTowerDungeon()
  local floor = m_summary.towerFloor
  local members = m_groups[tostring(m_summary.selectActorGroupId)].members
  local membersDetail = {}
  for i = 1, #members do
    local member = members[i]
    membersDetail[member.index + 1] = member.actor or {}
  end
  local postData = {
    dungeonId = PB.get("TowerFloor", floor).dungeonId,
    selectActorGroupId = m_summary.selectActorGroupId,
    towerFloor = floor
  }
  DB:GameRequest("fci/tower-dungeon/"):Post(postData, function(result)
    DBH.ResChange(result.resChange)
    local fightActorInfo = {
      {
        playerId = DB:GetData("playerId"),
        actors = membersDetail
      }
    }
    DB:SetData("FightActorInfo", fightActorInfo)
    local hps = {}
    for _, member in ipairs(members) do
      if member.hp == nil then
        table.insert(hps, 0)
      elseif member.dead then
        table.insert(hps, -1)
      else
        table.insert(hps, member.hp)
      end
    end
    local enemyHps = result.enemyRecord.hp
    for i = 1, 6 do
      if enemyHps[i] == nil then
        enemyHps[i] = 0
      elseif enemyHps[i] == 0 then
        enemyHps[i] = -1
      end
    end
    local group = m_groups[tostring(m_summary.selectActorGroupId)]
    local groupInfo = {
      hp = hps,
      sp = group.energySp,
      mp = group.energyMp
    }
    local fightInitInfo = {
      groupInfo,
      result.enemyRecord
    }
    DB:SetData("FightInitInfo", fightInitInfo)
    WU.EnterGameLevel(result.dungeonUid, result.baseInfo, result.baseInfo.dungeonId, PB.enum.DungeonType.Tower, 1, false)
  end)
end

function OnClickSwitchTeam()
  m_startCountdown = false
  WU.AcquireWindowAsync("TowerActorGroup", function()
    WU.SetNaviationHomeCallback(function()
      DU.LeaveTower(1, "")
    end)
    WU.SetNaviationBackCallback(function()
      DU.LeaveDungeon(1)
    end)
    WU.FindWindow("Messenger").gameObject:SetActive(false)
  end)
end
