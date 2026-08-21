inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GuildUtil")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_activityManager = S:Get("ActivityManager")
local m_configDataManager = S:Get("ConfigDataManager")
local m_summary, m_myPlayerId, m_guildId, m_oldSortOrder, m_oldDepth

function SetupWindow()
  WU.BindButtonEvent(REF.BtnTipConfirm, OnBtnTipConfirmClick)
  WU.BindButtonEvent(REF.BtnScoreReward, OnBtnScoreRewardClick)
  WU.BindButtonEvent(REF.BtnRank, OnBtnRankClick)
  WU.BindButtonEvent(REF.BtnContributionReward, OnBtnContributionRewardClick)
  WU.BindButtonEvent(REF.BtnSetHelper, OnBtnSetHelperClick)
  WU.BindButtonEvent(REF.BtnShop, OnBtnShopClick)
  WU.TraverseChildren(REF.BuffList, function(go)
    WU.BindButtonEvent(go, OnBuffClick)
  end)
  WU.TraverseChildren(REF.ListAssist, function(go)
    WU.BindButtonEvent(go, OnDungeonClick)
  end)
  WU.BindPressEvent(REF.DungeonChallenge, function(go)
    WU.BindButtonEvent(go, OnDungeonClick)
  end)
  WU.BindButtonEvent(REF.BtnRuleContribution, function(go)
    WU.SetActive(REF.RuleContribution, true)
    WU.SetActive(REF.BtnMask, true)
  end)
  WU.BindButtonEvent(REF.BtnMask, function(go)
    WU.SetActive(REF.RuleContribution, false)
    WU.SetActive(REF.BtnMask, false)
  end)
end

function InitWindow()
  SetOriginUI()
  this:Bind("guildId", function(guildId)
    m_guildId = guildId
    ValidateRestrictions(guildId)
  end)
  this:RegisterGameEvent("DungeonGuildFighterSet", GetSummaryInfo)
  this:RegisterGameEvent("DungeonGuildRewardGot", GU.UpdateGuildDungeonRedPoint)
  RU.BindRedMark(this, "Relation/Guild/Dungeon/Contribution", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnContributionReward).SpriteRed, flag)
  end)
  RU.BindRedMark(this, "Relation/Guild/Dungeon/ChallengeScore", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnScoreReward).SpriteRed, flag)
  end)
  this:Bind("fci/item/71714", function(item)
    local money = item or {}
    REF.LabelMoney.UIHtmlLabel.text = "<img src='ResIcon_s.ResItem_71714'/>&nbsp;" .. (money.count or 0)
  end)
  m_myPlayerId = this:GetData("playerId")
  GetSummaryInfo()
end

function UninitWindow()
  this:UnregisterGameEvent("DungeonGuildFighterSet", GetSummaryInfo)
  this:UnregisterGameEvent("DungeonGuildRewardGot", GU.UpdateGuildDungeonRedPoint)
end

function GetSummaryInfo()
  local summaryPath = "fci/guild-dungeon/v2/summary/" .. m_guildId
  this:GameRequest(summaryPath):Get(function(res)
    if res == nil then
      return
    end
    if GU.HandleGuildDungeonSummary(res) ~= true then
      warning("DungeonGuild", "Handle summary info failed")
      return
    end
    this:SetData("DungeonGuild/Summary", res)
  end)
  this:Bind("DungeonGuild/Summary", function(res)
    if res == nil then
      return
    end
    GU.UpdateGuildDungeonRedPoint()
    m_summary = res
    UpdateUI(res)
    ShowTip()
  end)
end

function SetOriginUI()
  WU.SetActive(REF.NodeRight, false)
  WU.SetActive(REF.NodeBottom, false)
  WU.SetActive(REF.NodeTip, false)
  for i = 0, #REF.ListAssist - 1 do
    local ref = REF.ListAssist[i]
    WU.SetActive(ref.NodeProgress, false)
  end
  WU.SetActive(_ENV["$"](REF.DungeonChallenge).NodeProgress, false)
  WU.SetActive(REF.RuleContribution, false)
  WU.SetActive(REF.BtnMask, false)
end

function UpdateUI(res)
  UpdateDungeonsUI()
  UpdateBottomUI()
  UpdateRightUI()
end

function UpdateDungeonsUI()
  local dungeonCount = #m_summary.dungeonRecords
  for i = 1, dungeonCount do
    local dungeonRecord = m_summary.dungeonRecords[i]
    local ref
    if i < dungeonCount then
      ref = REF.ListAssist[i - 1]
    else
      ref = _ENV["$"](REF.DungeonChallenge)
    end
    ref["@dungeonInfo"] = dungeonRecord
    ref["@index"] = i
    if dungeonRecord.dungeonType == PB.enum.DungeonType.AssistGuild then
      WU.SetActive(ref.EffectFight, false)
      WU.SetActive(ref.EffectFight, not dungeonRecord.isFinished)
      WU.SetActive(ref.EffectOn, false)
      WU.SetActive(ref.EffectOn, dungeonRecord.isFinished)
    else
      WU.SetActive(ref.EffectNoSignal, false)
      WU.SetActive(ref.EffectNoSignal, not dungeonRecord.isOpen)
      WU.SetActive(ref.EffectFight, false)
      WU.SetActive(ref.EffectFight, dungeonRecord.isOpen)
      WU.SetActive(ref.NodePass, dungeonRecord.isOpen and dungeonRecord.isFinished)
    end
    WU.SetActive(ref.NodeProgress, dungeonRecord.isOpen and not dungeonRecord.isFinished)
    if ref.NodeProgress.gameObject.activeSelf then
      ref.LabelProgress.UILabel.text = WU.GetString("DungeonGuild_ProgressDesc", dungeonRecord.progress)
    end
  end
end

function UpdateBottomUI()
  for i = 0, #REF.BuffList - 1 do
    local ref = REF.BuffList[i]
    local buffId = m_summary.dungeonRecords[i + 1].config.assistBuffId
    local fightBuffInfo = PB.get("FightBuff", buffId)
    local affixInfo = PB.get("AffixInfo", fightBuffInfo.team1[1].affixList[1])
    local buffIndex = PB.get("BuffIndex", affixInfo.index)
    local buffInfo = PB.get("BuffData", buffIndex.buffId[1], buffIndex.owner[1])
    ref.LabelDungeon.UILabel.text = WU.GetString("DungeonGuild_NthDungeon", i + 1)
    ref.SpriteBuff.UISprite.spriteName = buffInfo.iconName .. "_x"
    ref.SpriteMask.UISprite.fillAmount = 1 - (m_summary.dungeonRecords[i + 1].progress or 0) / 100
  end
  REF.LabelScore.UILabel.text = m_summary.challengeTotalScore or 0
  WU.SetActive(REF.NodeBottom, true)
end

function UpdateRightUI()
  local cRank = m_summary.playerContributionRank or 0
  if cRank == 0 then
    cRank = "--"
  end
  local cDegree = m_summary.contribution.contributionDegree or 0
  REF.LabelRank.UILabel.text = WU.GetString("DungeonGuild_RankIndex", cRank)
  REF.LabelContribution.UIHtmlLabel.text = "<img src='ResIcon_s.guild_coin_2'/>&nbsp;" .. cDegree
  SetMyFighterUI()
  WU.SetActive(REF.NodeRight, true)
end

function SetMyFighterUI()
  local fighter = m_summary.playerRentInfo
  local hasSetHelper = fighter.loanActorId and fighter.loanActorId ~= 0
  WU.SetActive(REF.LabelCount, hasSetHelper)
  WU.SetActive(REF.SpriteActor, hasSetHelper)
  WU.SetActive(REF.LabelFighterSetTip, not hasSetHelper)
  local buttonText
  if hasSetHelper then
    buttonText = WU.GetString("DungeonGuild_CheckFighter")
  else
    buttonText = WU.GetString("DungeonGuild_SetFighter")
  end
  REF.LabelSetHelper.UILabel.text = buttonText
  if hasSetHelper then
    REF.LabelCount.UILabel.text = fighter.fightTimes or 0
    local actorConfig = PB.get("ActorConfig", fighter.loanActorId)
    REF.SpriteActor.UISprite.spriteName = "actor_head_" .. actorConfig.animRes
  end
end

function ShowTip()
  if WU.IsFirstTimeInClient("showDungeonGuildHelp2") then
    ChangeTheDepth(true)
    WU.SetActive(REF.NodeTip, true)
    WU.RecordFirstTimeInClient("showDungeonGuildHelp2")
  end
end

function OnBtnTipConfirmClick()
  WU.SetActive(REF.NodeTip, false)
  ChangeTheDepth(false)
end

function OnBuffClick()
  WU.AcquireWindowAsync("DungeonGuildFightBuff")
end

function OnDungeonClick(go)
  local info = _ENV["$"](go)["@dungeonInfo"]
  if info == nil then
    return
  end
  local index = _ENV["$"](go)["@index"]
  if info.dungeonType == PB.enum.DungeonType.ChallengeGuild and not info.isOpen then
    WU.ShowHintText(WU.GetString("DungeonGuild_DungeonLock"))
    return
  end
  this:SetData("WindowDungeon/DungeonId", info.dungeonId)
  this:SetData("DungeonGuild/DungeonType", info.dungeonType)
  this:SetData("DungeonGuild/Index", index)
  WU.AcquireWindowAsync("DungeonGuildPrepare", function(window)
    _ENV["$"](window)["$$ShowEnter"]()
  end)
end

function OnBtnScoreRewardClick()
  WU.AcquireWindowAsync("DungeonGuildScorePrize")
end

function OnBtnRankClick()
  local rankList
  this:GameRequest("fci/guild-dungeon/v2/contribution/" .. m_guildId):Get(function(res)
    if res == nil or res.contribution == nil or #res.contribution == 0 then
      WU.ShowHintText(WU.GetString("DungeonGuild_NoRankInfo"))
      return
    end
    local rankList = res.contribution
    local memberList = this:GetData("fci/guild/members/")
    for i = #rankList, 1, -1 do
      local member = rankList[i]
      local _, v = table.find(memberList, function(k1, v1)
        return v1.playerId == member.playerId
      end)
      if v == nil then
        member.baseInfo = {
          headPhoto = -1,
          headFrame = -1,
          name = WU.GetString("DungeonGuild_AlreadyExit"),
          level = 0
        }
      else
        member.baseInfo = v
      end
    end
    local title = WU.GetString("DungeonGuild_ContributionRankTitle")
    WU.AcquireWindowAsync("DialogRank", function(window)
      _ENV["$"](window)["$$SetRankList"](title, rankList)
      _ENV["$"](window)["$$SetGuildValidate"]()
    end)
  end)
end

function OnBtnContributionRewardClick()
  local cRank = m_summary.playerContributionRank or 0
  if cRank == 0 then
    cRank = "--"
  end
  local cRankStr = WU.GetString("DungeonGuild_RankIndex", cRank)
  local cDegree = m_summary.contribution.contributionDegree or 0
  local data = this:GetData("fci/guild-dungeon/v2/contribution/reward/")
  if data then
    WU.AcquireWindowAsync("PrizePreview", function(window)
      _ENV["$"](window)["$$SetPrizePreview"]("DungeonGuildContribution", {myRank = cRankStr, playerRecord = cDegree})
    end)
  else
    this:GameRequest("fci/guild-dungeon/v2/contribution/reward/"):Get(function(res)
      local data = res or _ENV["!"]({})
      this:SetData("fci/guild-dungeon/v2/contribution/reward/", data)
      WU.AcquireWindowAsync("PrizePreview", function(window)
        _ENV["$"](window)["$$SetPrizePreview"]("DungeonGuildContribution", {myRank = cRankStr, playerRecord = cDegree})
      end)
    end)
  end
end

function OnBtnSetHelperClick()
  local playerRentInfo = m_summary.playerRentInfo
  local hasSetHelper = playerRentInfo.loanActorId and playerRentInfo.loanActorId ~= 0
  if hasSetHelper then
    WU.AcquireWindowAsync("DungeonGuildHelperSet")
  else
    local lastLoanActorUid = playerRentInfo.lastLoanActorUid or 0
    local actor = this:GetData("fci/actor/" .. lastLoanActorUid)
    if actor == nil then
      WU.AcquireWindowAsync("DungeonGuildHelperSet")
    else
      WU.AcquireWindowAsync("DungeonGuildFighterReuse", function(window)
        _ENV["$"](window)["$$SetActor"](actor)
      end)
    end
  end
end

function OnBtnShopClick()
  WU.AcquireWindowAsync("Shop", function(window)
    _ENV["$"](window)["$$SetSelected"](U.GuildShopId)
  end)
end

function ChangeTheDepth(flag)
  if flag then
    m_oldDepth = REF.NodeTip.UIPanel.depth
    m_oldSortOrder = REF.NodeTip.UIPanel.sortingOrder
    REF.NodeTip.UIPanel.depth = 22799
    REF.NodeTip.UIPanel.sortingOrder = 29960
  else
    REF.NodeTip.UIPanel.depth = m_oldDepth
    REF.NodeTip.UIPanel.sortingOrder = m_oldSortOrder
  end
end
