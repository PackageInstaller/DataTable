local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local DU = require("Common/DungeonUtil")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local m_balance, m_skipAnim, m_dungeonId, m_rewards, costWin

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, false)
  WU.BindButtonEvent(REF.NodeContinue, function()
    BASE.OnButtonContinueClick()
  end)
  LU.Bind(REF.AcquirementContent, {
    updateRow = OnDropItemShow
  })
  SetDrops()
  WU.BindButtonEvent(REF.AnimMask, OnSkipAnimClick)
  WU.BindButtonEvent(REF.NodeAgain, OnClickFightAgain)
end

function OnClickFightAgain()
  local tickets = this:GetData("fci/item/" .. costWin.id).count
  if tickets <= 0 then
    WU.ShowHintText(WU.GetString("Error_NotEnoughGoldTicket"))
    return
  end
  local selectGroupId = this:GetData("fci/SelectedGroupId/gold-dungeon").selectActorGroupId
  selectGroupId = fif(tonumber(selectGroupId) == 0, 1, selectGroupId)
  local param = {selectActorGroupId = selectGroupId}
  DB:GameRequest("fci/gold-dungeon/{Dungeon/DungeonUid}"):Delete()
  this:GameRequest("fci/gold-dungeon/"):Post(param, function(response)
    DB:SetData("Dungeon/DungeonUid", response.dungeonUid)
    ReloadFightActor()
    WU.EnterGameLevel(response.dungeonUid, response.baseInfo, m_dungeonId, PB.enum.DungeonType.Gold, 1, false)
  end)
end

function ReloadFightActor()
  local fightData = this:GetData("FightAgainInfo")
  if fightData then
    local actorList = {}
    for i, v in ipairs(fightData[1].actors) do
      local actor
      if v.uid then
        actor = this:GetData("fci/actor/" .. v.uid)
      else
        actor = {}
      end
      actorList[i] = actor
    end
    fightData[1].actors = actorList
    this:SetData("FightActorInfo", fightData)
    this:BroadcastGameEvent("MedalAttrAppend")
  end
end

function SetDrops()
  local itemCount = 0
  if m_rewards ~= nil then
    itemCount = math.ceil(#m_rewards)
  end
  LU.Set(REF.AcquirementContent, itemCount)
  REF.AcquirementList.BoxCollider2D.enabled = false
  WU.TraverseChildren(REF.AcquirementContent, function(go)
    go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = false
  end)
end

function UpdateGoldLevelInfo()
  costWin = DU.GetDungeonGoldCost()
  local tickets = this:GetData("fci/item/" .. costWin.id).count
  if 0 < tickets then
    REF.resNumberLabel.UIHtmlLabel.text = tickets
  else
    REF.resNumberLabel.UIHtmlLabel.text = "<font color=#fd5454>" .. tickets .. "</font>"
  end
  local goldLevel = DU.GetDungeonGoldLevel()
  if goldLevel then
    m_dungeonId = goldLevel.dungeonId
  end
end

function InitWindow()
  m_balance = this:GetData("DungeonBalance/result")
  UpdateGoldLevelInfo()
  local baseInfo = this:GetData("fci/baseinfo")
  local goldDungeonLevel = PB.get("GoldDungeonLevel", baseInfo.level)
  WU.ToggleRendering(REF.TitleLine1, false)
  WU.ToggleRendering(REF.AcquirementList, false)
  WU.ToggleRendering(REF.WidgetProfitBuffList, false)
  local rewards = _ENV["!"]({})
  local otherRewards = {}
  for i = 1, #m_balance.resChange do
    local change = m_balance.resChange[i]
    if change.baseRes and change.baseRes.countDelta >= 0 then
      if change.baseRes.type == PB.enum.ResourceType.ResPlayerGold then
        table.insert(rewards, change)
      else
        table.insert(otherRewards, change.baseRes)
      end
    end
  end
  if rewards[1] and rewards[2] then
    local baseDrop = rewards[1].baseRes
    local beatGold = rewards[2].baseRes
    local beatcount = DB:GetData("FightBeatEnemyCount") or 0
    m_rewards = {}
    table.insert(m_rewards, baseDrop)
    if 0 < beatcount then
      local eachBeat = math.floor(beatGold.countDelta / beatcount)
      local beatDrop = _ENV["!"]({
        type = beatGold.type,
        id = beatGold.id,
        countDelta = eachBeat,
        showBeat = true
      })
      for i = 1, beatcount do
        table.insert(m_rewards, beatDrop)
      end
    end
    table.append(m_rewards, otherRewards)
    SetDrops()
  else
    m_rewards = {}
    error("Gold Balance received wrong data", table.dump(m_balance))
  end
  WU.ToggleRendering(REF.AnimMask, true)
  PlayAnim()
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
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
    REF.LabelDesc.UILabel.text = WU.GetString("DungeonBalanceDescribe_" .. dungeonId)
  end
  if #m_rewards < 7 then
    REF.DropScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.TopRight
    REF.DropScrollView.UIScrollView:ResetPosition()
  end
end

function OnDropItemShow(ref, wrapIndex, realIndex)
  if m_rewards ~= nil and realIndex < #m_rewards then
    local award = m_rewards[realIndex + 1]
    ref.root["$SetData"](award.type, award.id, award.countDelta)
    if award.showBeat then
      ref.root["$ShowCustom"]({showBeat = true})
    end
    ref.root["$SetClickCallback"](function()
      WU.ShowResourceDetail(award.type, award.id)
    end)
  end
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
  WU.ToggleRendering(REF.NodeContinue, true)
  if #m_rewards > #REF.AcquirementContent - 2 then
    REF.AcquirementList.BoxCollider2D.enabled = true
    WU.TraverseChildren(REF.AcquirementContent, function(go)
      go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = true
    end)
  end
  BASE.OnDungeonAnimFinished()
end
