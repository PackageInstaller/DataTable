local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local SDU = require("Common/SoundUtil")
local m_group, m_balance, m_rewards, m_skipAnim, m_triggeredEvent

function SetupWindow()
  WU.BindButtonEvent(REF.TriggeredEvent, function()
    this:SetData("TriggeredEvent/New", m_triggeredEvent)
    BASE.OnButtonContinueClick()
  end)
  WU.ToggleRendering(REF.AnimMask, false)
  WU.BindButtonEvent(REF.NodeContinue, function()
    BASE.OnButtonContinueClick()
  end)
  CS.EventDelegate.Add(REF.TweenerGroup1.UIPlayTween.onFinished, function()
    if not m_skipAnim then
      REF.WidgetDungeonGroup["$SetLevelupExp"](m_balance.expChange, m_group, true)
    end
  end)
  WU.BindButtonEvent(REF.AnimMask, OnSkipAnimClick)
end

function InitWindow()
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  BASE.SetActorTextureEffect(this:GetData("FightWinActor"))
  local result = this:GetData("DungeonBalance/result")
  m_balance = result.balanceInfo
  m_rewards = DU.GetDungeonBalanceRewards(m_balance)
  WU.ToggleRendering(REF.TitleLine1, false)
  WU.ToggleRendering(REF.AcquirementList, false)
  WU.ToggleRendering(REF.TitleLine2, false)
  WU.ToggleRendering(REF.WidgetDungeonGroup, false)
  WU.ToggleRendering(REF.WidgetProfitBuffList, false)
  WU.ToggleRendering(REF.NodeTween, false)
  BASE.ToggleTriggleEventEffect(false)
  m_triggeredEvent = m_balance.eventInfo
  if m_triggeredEvent then
    DBH.TriggeredEventChange(m_triggeredEvent)
  end
  local balanceInfo = this:GetData("DungeonTeam/BalanceInfo")
  local actors, groups = GetDungeonTeamActorGroup(balanceInfo)
  m_group = groups
  REF.WidgetDungeonGroup["$SetViewByActors"](actors)
  REF.WidgetDungeonGroup["$SetOldExp"](m_balance.expChange, m_group)
  REF.WidgetDungeonGroup["$SetFavourChangeIds"](BASE.GetFavourChangeRoles(m_balance.favourChange))
  InitDamages(balanceInfo, result.playerDamages)
  InitAddFriends(balanceInfo)
  BASE.InitAcquirement(m_balance)
  NU.UpdateRoleFavour(m_balance.favourChange)
  WU.ToggleRendering(REF.AnimMask, true)
  PlayOtherAnim()
  if #BASE.m_rewards < 7 then
    REF.AcquirementScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.TopRight
    REF.AcquirementScrollView.UIScrollView:ResetPosition()
  end
end

function GetDungeonTeamActorGroup(balanceInfo)
  local actors = {}
  local members = {}
  for i = 1, 6 do
    members[i] = {
      index = i - 1,
      actorUid = 0
    }
  end
  for playerId, v in pairs(balanceInfo) do
    local position = v.position + 1
    actors[position] = v.actors[1]
    actors[position + 3] = v.actors[2]
    if playerId == this:GetData("playerId") then
      members[position] = {
        index = v.position,
        actorUid = v.actors[1].uid
      }
      members[position + 3] = {
        index = v.position + 3,
        actorUid = v.actors[2].uid
      }
    end
  end
  local groups = {members = members}
  return actors, groups
end

function InitDamages(balanceInfo, damages)
  local infoTable = {}
  for playerId, v in pairs(balanceInfo) do
    local level = fif(playerId == this:GetData("playerId"), m_balance.playerLevel, v.playerInfo.level)
    infoTable[v.position + 1] = {
      level = level,
      damage = damages[playerId],
      name = v.playerInfo.name
    }
  end
  for i = 1, 3 do
    infoTable[i] = infoTable[i] or {}
  end
  local damageText = "<l width=100%>"
  for i = 3, 1, -1 do
    local info = infoTable[i]
    local damageLocalization = fif(info.damage ~= nil, WU.GetString("DungeonTeam_DamageCount"), "")
    if i < 3 then
      damageText = damageText .. "<c width=5%></c>"
    end
    damageText = damageText .. "<c width=15% align=left>" .. damageLocalization .. "</c><c width=15% align=right>" .. (info.damage or "") .. "</c>"
  end
  damageText = damageText .. "</l>"
  REF.DamageLabel.UIHtmlLabel.text = damageText
  local playerText = "<l width=100%>"
  for i = 3, 1, -1 do
    local info = infoTable[i]
    local level = fif(info.level ~= nil, WU.GetString("Window_Level", info.level), "")
    if i < 3 then
      playerText = playerText .. "<c width=5%></c>"
    end
    playerText = playerText .. "<c width=15% align=left>" .. (info.name or "") .. "</c><c width=15% align=right>" .. level .. "</c>"
  end
  playerText = playerText .. "</l>"
  REF.PlayerLabel.UIHtmlLabel.text = playerText
end

function InitAddFriends(balanceInfo)
  WU.TraverseChildren(REF.AddFriendGrid, function(go)
    go:SetActive(false)
    local ref = _ENV["$"](go)
    ref.Label.UILabel.text = WU.GetString("DungeonTeam_AddFriend")
    WU.BindButtonEvent(ref.AddFriendButton, function(go)
      local playerId = ref["@playerId"]
      if playerId ~= nil and U.trim(playerId) ~= "" then
        this:GameRequest("fci/applyfriend/"):Post({targetId = playerId}, function(result)
          if U.trim(result.playerId) == "" then
            WU.ShowHintText(WU.GetString("Window_SearchPlayerNotExist"))
            return
          end
          WU.ShowHintText(WU.GetString("Window_SendFriendApply"))
          ref.Label.UILabel.text = WU.GetString("DungeonTeam_FriendApplySend")
          ref.AddFriendButton.BoxCollider2D.enabled = false
        end)
      end
    end)
  end)
  for playerId, v in pairs(balanceInfo) do
    if playerId ~= this:GetData("playerId") then
      local ref = REF.AddFriendGrid[v.position]
      ref["$gameObject"]:SetActive(true)
      ref["@playerId"] = playerId
      local isFriend = table.find(this:GetData("fci/friendlist/"), function(_, v)
        return v.playerId == playerId
      end)
      ref.IsFriend.gameObject:SetActive(isFriend ~= nil)
      ref.AddFriendButton.gameObject:SetActive(isFriend == nil)
    end
  end
end

function OnWindowUninited(window)
  if window.name == "PlayerLevelupResult" then
    PlayOtherAnim()
  end
end

function OnSkipAnimClick()
  if m_skipAnim then
    return
  end
  m_skipAnim = true
  WU.ToggleRendering(REF.TitleLine1, true)
  BASE.SetProfitBuff(m_balance.profits, CS.UIWidget.Pivot.Left)
  WU.ToggleRendering(REF.TitleLine2, true)
  WU.ToggleRendering(REF.WidgetDungeonGroup, true)
  WU.ToggleRendering(REF.NodeTween, true)
  REF.TweenerGroup1.UIPlayTween:Play(true)
  REF.TweenerGroup1.UIPlayTween:Finish()
  REF.WidgetDungeonGroup["$SetLevelupExp"](m_balance.expChange, m_group, false)
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
      WU.ToggleRendering(REF.TitleLine2, true)
      REF.TitleLine2.UIPlayTween:Play(true)
      this:DelayInvokeInSeconds(BASE.TitleAnimTime, function()
        if m_skipAnim then
          return
        end
        WU.ToggleRendering(REF.WidgetDungeonGroup, true)
        REF.TweenerGroup1.UIPlayTween:Play(true)
        this:DelayInvokeInSeconds(BASE.GroupAnimTime, function()
          if m_skipAnim then
            return
          end
          WU.ToggleRendering(REF.NodeTween, true)
          REF.NodeTween.UIPlayTween:Play(true)
          this:DelayInvokeInSeconds(BASE.DungeonTeamDamageAnimTime, function()
            if m_skipAnim then
              return
            end
            OnAnimFinished()
          end)
        end)
      end)
    end)
  end)
end

function OnAnimFinished()
  local delayTime = 0
  if m_triggeredEvent then
    BASE.ToggleTriggleEventEffect(true)
    delayTime = 2
  end
  this:DelayInvokeInSeconds(delayTime, function()
    WU.ToggleRendering(REF.AnimMask, false)
    if #m_rewards > #REF.AcquirementContent - 2 then
      REF.AcquirementList.BoxCollider2D.enabled = true
      WU.TraverseChildren(REF.AcquirementContent, function(go)
        go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = true
      end)
    end
    BASE.OnDungeonAnimFinished()
  end)
end

function OnDestroy()
  BASE.OnDestroy()
end
