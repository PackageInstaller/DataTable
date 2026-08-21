local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local HU = require("Common/HtmlUtil")
local GU = require("Common/GroupUtil")
local U = require("Common/Util")
local m_config, m_activityInfo, m_asyncInfo, m_opponents, m_ticketInfo, m_effectOn

function SetupWindow()
  WU.BindButtonEvent(REF.BtnFindOpponent, OnFindOpponentClick)
  WU.BindButtonEvent(REF.BtnAdd, OnAddTimesClick)
  WU.BindButtonEvent(REF.BtnSetFight, OnSetFightClick)
  WU.BindButtonEvent(REF.BtnSetGuard, OnSetGuardClick)
  WU.BindButtonEvent(REF.BtnRecord, OnRecordClick)
  WU.BindButtonEvent(REF.BtnReward, OnRewardPreviewClick)
  WU.BindButtonEvent(REF.BtnRank, OnRankClick)
end

function InitWindow()
  m_effectOn = false
  m_config = PB.index("Misc", 1).asyncPvpV2Info
  m_activityInfo = this:GetData("AsyncPvpNew/ActivityInfo")
  WU.SetActive(REF.Main, false)
  this:GameRequest("fci/async_v2/base_info"):Get(function(res)
    this:SetData("AsyncPvpNew/BaseInfo", res)
    this:Bind("AsyncPvpNew/BaseInfo", InitView)
  end)
end

function Focus(on)
  if on then
    WU.SetWindowTitle("AsyncPvpNew", "AsyncPvp")
  end
end

function InitView(data)
  if data == nil then
    return
  end
  m_asyncInfo = data
  DBH.ResChange(m_asyncInfo.resChange)
  local playerId = this:GetData("playerId")
  local record = WU.GetGameDataCache("AsyncPvpNewConfirmFightGroup" .. playerId)
  if record ~= true then
    m_asyncInfo.setAttachGroup = false
  end
  m_asyncInfo.hasMatched = m_asyncInfo.opponents and m_asyncInfo.opponents[PB.enum.AsyncPvpV2TargetType.Simple]
  if m_asyncInfo.hasMatched then
    m_asyncInfo.setAttachGroup = true
    m_asyncInfo.setDefendGroup = true
    WU.SetGameDataCache("AsyncPvpNewConfirmFightGroup" .. playerId, true)
  end
  local monthDay = IsInBalanceTime()
  if monthDay == nil then
    InitTicket()
    InitMainView()
    this:DelayInvokeInFrames(1, function()
      if m_asyncInfo.oldSeg ~= 0 and m_asyncInfo.oldSeg ~= nil then
        local tag = "AsyncPvpNew" .. this:GetData("playerId") .. m_asyncInfo.curSeason
        local record = WU.GetGameDataCache(tag)
        if not record then
          WU.AcquireWindowAsync("AsyncPvpNewSegResult")
          WU.SetGameDataCache(tag, true)
        end
      end
    end)
  else
    InitBalanceView(monthDay)
    InitMainView()
  end
end

function InitMainView()
  local upActors = PB.get("AsyncPvpUpActor", m_asyncInfo.upActorWeekIndex + 1)
  if upActors == nil then
    warning("AsyncPvpUpActor.xlsx doesnt have info of upActorWeekIndex " .. m_asyncInfo.upActorWeekIndex + 1)
    return false
  end
  for i = 0, #REF.ListActor - 1 do
    local ref = REF.ListActor[i]
    local roleId = upActors.specialRoles[i + 1]
    WU.SetActive(ref["$gameObject"], roleId)
    if roleId then
      local animRes = PB.get("Role", roleId).animRes
      ref.SpriteActor.UISprite.spriteName = "actor_head_" .. animRes
    end
  end
  REF.ListActor.UIGrid:Reposition()
  local maxCTimes = m_config.maxContinueTimes
  REF.LabelContinueProgress.UILabel.text = WU.GetString("NAsyncPvp_ContinueWinProgress", m_asyncInfo.curContinueWinTimes, m_config.maxContinueWin)
  local rewards = PB.all("AsyncPvpWinningReward"):where(function(k, a)
    return a.weekNum == m_asyncInfo.cntRewardWeekIndex + 1
  end):toarray():sort(function(a, b)
    return a.winCount < b.winCount
  end)
  if #rewards < #REF.ListReward then
    warning("AsyncPvpWinningReward.xlsx doesnt have info of cntRewardWeekIndex " .. m_asyncInfo.cntRewardWeekIndex + 1)
  else
    for i = 0, #REF.ListReward - 1 do
      local ref = REF.ListReward[i]
      local index = i + 1
      local reward = rewards[i + 1].rewards[1]
      ref.LabelTarget.UILabel.text = WU.GetString("Tournament_WinTimes", index)
      ref.WidgetIconSlot["$ResetState"]()
      ref.WidgetIconSlot["$SetData"](reward.type, reward.id, reward.count, 1)
      if index <= m_asyncInfo.curAccWinTimes then
        ref.WidgetIconSlot["$SetTips"]("received")
      end
    end
  end
  REF.LabelMyAssessment.UILabel.text = WU.GetString("NAsyncPvp_AssessmentScore", m_asyncInfo.totalScore)
  local segInfo = PB.get("AsyncPvpRankReward", m_asyncInfo.curSeg)
  REF.SpriteMyRankName.UISprite.spriteName = "illusion_level_" .. segInfo.segRank
  REF.SpriteMySubRankName.UISprite.spriteName = "level_" .. segInfo.subSegRank
  REF.SpriteMyRank.UISprite.spriteName = "icon_" .. segInfo.segRank
  local segTex = WU.AcquireAsset("Texture/IllusionLand/IllusionLand_icon_" .. segInfo.segRank)
  _ENV["$"](REF.EffectBg).Icon.MeshRenderer.material:SetTexture("_MainTex", segTex)
  REF.EffectBg.EffectGenerator:Play()
  WU.SetActive(_ENV["$"](REF.BtnSetFight).SpriteRed, not m_asyncInfo.setAttachGroup)
  WU.SetActive(_ENV["$"](REF.BtnSetGuard).SpriteRed, not m_asyncInfo.setDefendGroup)
  WU.SetActive(REF.Main, true)
end

function InitBalanceView(monthDay)
  local beginTime = GetTimeStr(m_config.balanceBeginHour)
  local endTime = GetTimeStr(m_config.balanceEndHour)
  local balanceTimeStr = WU.GetString("NAsyncPvp_BalanceTime", monthDay, beginTime, endTime)
  REF.LabelInfo.UILabel.text = balanceTimeStr
  WU.SetActive(REF.NodeFight, false)
  WU.SetActive(REF.NodeBalance, true)
end

function InitTicket()
  this:GameRequest("fci/resbuyprice/" .. m_activityInfo.activityId):Get(function(response)
    if response then
      this:Unbind("fci/item/" .. response.buy.id, OnTicketChange)
      this:Bind("fci/item/" .. response.buy.id, OnTicketChange)
    end
  end)
  if m_asyncInfo.hasMatched then
    REF.LabelFindOpponent.UILabel.text = WU.GetString("NAsyncPvp_ChallengeOpponents")
  elseif not m_asyncInfo.setAttachGroup then
    REF.LabelFindOpponent.UILabel.text = WU.GetString("NAsyncPvp_SetFightGroup")
  elseif not m_asyncInfo.setDefendGroup then
    REF.LabelFindOpponent.UILabel.text = WU.GetString("NAsyncPvp_SetGuardGroup")
  else
    REF.LabelFindOpponent.UILabel.text = WU.GetString("NAsyncPvp_FindOpponents")
  end
  WU.SetActive(REF.NodeFight, true)
  WU.SetActive(REF.NodeBalance, false)
end

function OnTicketChange(ticket)
  m_ticketInfo = ticket
  local count = ticket and ticket.count
  local ls = fif(count == 0, HU.ApplyFontColor("0", HU.ColorDefines.Error), tostring(count))
  local rs = tostring(m_config.dailyBattleCnt)
  REF.LabelRemainTimes.UIHtmlLabel.text = ls .. "/" .. rs
  WU.SetActive(REF.BtnAdd, count == 0)
end

function IsInBalanceTime()
  local dayMonth
  local now = CS.GameTime.serverNow
  local day = U.ToInt(now.DayOfWeek)
  local hour = U.ToInt(now.Hour)
  if day == 0 then
    day = 7
  end
  if day == m_config.balanceWeekDay and hour >= m_config.balanceBeginHour and hour <= m_config.balanceEndHour - 1 then
    dayMonth = WU.RenderTime2(CS.GameTime.serverUtc)
  end
  return dayMonth
end

function GetTimeStr(hour)
  if hour < 10 then
    return "0" .. hour .. ":00"
  else
    return tostring(hour) .. ":00"
  end
end

function OnFindOpponentClick()
  local monthDay = IsInBalanceTime()
  if monthDay then
    WU.ShowHintText(WU.GetString("NAsyncPvp_NoOperatingInBalance"))
    WU.SetActive(REF.NodeFight, false)
    InitBalanceView(monthDay)
    return
  end
  if m_asyncInfo.hasMatched then
    WU.AcquireWindowAsync("AsyncPvpNewOpponents", function(window)
      _ENV["$"](window)["$$SetView"](false)
    end)
    return
  end
  if not m_asyncInfo.setAttachGroup then
    OnSetFightClick()
    return
  end
  if not m_asyncInfo.setDefendGroup then
    OnSetGuardClick()
    return
  end
  if m_ticketInfo == nil or m_ticketInfo.count <= 0 then
    OnAddTimesClick()
    return
  end
  WU.AcquireWindowAsync("AsyncPvpNewOpponents", function(window)
    _ENV["$"](window)["$$SetView"](true)
  end)
end

function OnAddTimesClick()
  WU.Exchange(PB.enum.ResourceType.ResItem, nil, true, m_ticketInfo.id)
end

function OnSetGuardClick()
  if IsInBalanceTime() then
    WU.ShowHintText(WU.GetString("NAsyncPvp_NoOperatingInBalance"))
    return
  end
  this:GameRequest("fci/async_v2/actor_group/"):Get(function(result)
    this:SetData("AsyncPvpNewGuard/SelectedPlayer", result)
    this:SetData("SpaceActorSelect/Mode", "AsyncPvpNewGuard")
    WU.AcquireWindowAsync("SpaceActorSelect")
  end)
end

function OnSetFightClick()
  if IsInBalanceTime() then
    WU.ShowHintText(WU.GetString("NAsyncPvp_NoOperatingInBalance"))
    return
  elseif m_asyncInfo.hasMatched then
    WU.ShowHintText(WU.GetString("NAsyncPvp_NoOperationAfterMatch"))
    return
  end
  GU.SetGroupMode(PB.enum.ActorGroupType.AsyncPvpNew)
  WU.AcquireWindowAsync("AsyncPvpNewActorGroup")
end

function OnRecordClick()
  WU.AcquireWindowAsync("AsyncPvpNewFightVideo")
end

function OnRewardPreviewClick()
  WU.AcquireWindowAsync("PrizePreview", function(window)
    _ENV["$"](window)["$$SetPrizePreview"]("AsyncPvpNewGrade")
  end)
end

function OnRankClick()
  WU.AcquireWindowAsync("AsyncPvpNewRanks")
end

function OnFightClick(go)
  local ref = _ENV["$"](go)
  local targetType = ref["@targetType"]
  local opponentInfo = m_opponents[targetType]
  GU.SetGroupMode(PB.enum.ActorGroupType.AsyncPvpNew)
  this:SetData("AsyncPvpNew/Opponent", opponentInfo)
  WU.AcquireWindowAsync("AsyncPvpNewActorGroup")
end
