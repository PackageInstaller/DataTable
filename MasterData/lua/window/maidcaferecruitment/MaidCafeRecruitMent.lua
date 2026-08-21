local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local m_configDataManager = S:Get("ConfigDataManager")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local m_rankModeInfoAll, m_groupInfo, m_rankRewards, m_rankModeInfo
local m_selectedRankType = 1
local m_currentRankTypeInfo
local m_theme = 1
local m_passRewardInfo, m_legendRank, m_latestUnlockedType, m_legendRankP, m_ticketCost
local m_voices = {
  "Voice/taiga/Tgr00_2000",
  "Voice/kuroko/Krk00_8100_s0",
  "Voice/kouko/Kgk00_2101",
  "Voice/kuroneko/Kro_kanban_05",
  "Voice/ako/Ako00_2079",
  "Voice/taiga/maid_voice"
}
local m_audioSource, m_currentVoice, m_selectedGroupId

function SetupWindow()
  WU.TraverseChildren(REF.Activities, function(go, index)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref.root, function()
      if not ref["@unlocked"] then
        WU.ShowHintText(WU.GetString("MaidCafe_RankMode_UnlockHint"))
        REF.Activities[m_selectedRankType - 1].root.UIToggle.value = true
      else
        m_selectedRankType = index + 1
        this:SetData("MaidCafe/RankType", index + 1)
      end
    end)
  end)
  WU.TraverseChildren(REF.RewardsGrid, function(go, index)
    WU.BindButtonEvent(_ENV["$"](go).root, OnClickPassCountReward)
  end)
  WU.BindButtonEvent(REF.ButtonReward, OnClickRewardPreview)
  WU.BindButtonEvent(REF.ButtonRank, OnClickRank)
  WU.SetActive(REF.RewardsProgress, false)
  WU.BindButtonEvent(REF.ButtonPrepare, OnClickButtonPrepare)
  WU.BindButtonEvent(REF.UnlockNextType, OnClickNextType)
  WU.BindButtonEvent(REF.ForceSync, OnSync)
  WU.BindButtonEvent(_ENV["$"](REF.Tickets).LabelCost, OnClickTickets)
  WU.BindButtonEvent(REF.ButtonRule, OnClickRule)
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/activity-dun"), function(data)
    if data then
      m_selectedGroupId = data.selectActorGroupId or 1
      if m_selectedGroupId == 0 then
        m_selectedGroupId = 1
      end
    end
  end)
end

function InitWindow()
  this:BindRemote(DB:GameRequest("fci/maidcafe/rank-mode"), OnRankModeInfoChange)
  this:Bind("fci/maidcafe/rank-mode/legend-rank/my-rank/", OnPlayerRankChange)
  if m_rankModeInfo[PB.enum.MaidCafeRankModeType.Legend].unlocked == true then
    DB:SyncRemote(DB:GameRequest("fci/maidcafe/rank-mode/legend-rank/my-rank/"))
  end
  this:Bind("MaidCafe/RankType", OnRankTypeChange)
  this:BindRemote(DB:GameRequest("fci/maidcafe/rank-mode/pass-reward"), OnPassRewardChage)
end

function SetShareInfo()
  this:SetData("ShareConfig", {
    shareName = "MaidCafeRecruitMent",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  local groups = DB:GetData("fci/ActorGroup/")
  local allActors = DB:GetData("fci/actor/")
  local members = groups[tostring(m_selectedGroupId)].members
  local actorIds = {}
  for i = 1, #members do
    local _, actor = table.find(allActors, function(k, actor)
      return actor.uid == members[i].actorUid
    end)
    if actor then
      local index = 1
      if i <= 3 then
        index = 6 - (i - 1) * 2
      else
        index = 5 - (i - 4) * 2
      end
      actorIds[index] = actor.id
    end
  end
  local data = {
    highScore = REF.LabelRankScore.UILabel.text,
    theme = m_theme,
    coffeeLevel = m_selectedRankType,
    actorIds = actorIds
  }
  this:SetData("Share/MaidCafeRecruitMent", data)
end

function UninitWindow()
  this:SetData("Share/MaidCafeRecruitMent", nil)
  if m_audioSource then
    m_audioSource = nil
  end
end

function OnRankModeInfoChange(rankModeInfoAll)
  if rankModeInfoAll == nil then
    return
  end
  WU.SetActive(REF.RewardsProgress, false)
  m_rankModeInfoAll = rankModeInfoAll
  m_groupInfo = rankModeInfoAll.rankModeGroupInfo
  m_rankModeInfo = rankModeInfoAll.rankModeInfo
  m_rankRewards = rankModeInfoAll.rankModeRewardInfo
  m_theme = rankModeInfoAll.theme or PB.enum.MaidCafeRankModeActivityThemeType.A
  DB:SetData("MaidCafe/Theme", m_theme)
  for i = 0, #REF.Activities - 1 do
    local ref = REF.Activities[i]
    ref["@unlocked"] = m_rankModeInfo[i + 1].unlocked
    WU.SetActive(ref.SpriteLock, not m_rankModeInfo[i + 1].unlocked)
  end
  m_latestUnlockedType = PB.enum.MaidCafeRankModeType.Free
  for k, v in pairs(m_rankModeInfo) do
    if v.unlocked and v.rankModeType > m_latestUnlockedType then
      m_latestUnlockedType = v.rankModeType
    end
  end
  m_selectedRankType = m_latestUnlockedType
  this:SetData("MaidCafe/RankType", m_latestUnlockedType)
end

function OnRankTypeChange(type)
  if type == nil then
    return
  end
  local maxScore = 0
  local maxReward, nextScore, nextReward, nextIndex
  local imgIndex = type + (m_theme - 1) * 3
  REF.TextureStage.UITexture.mainTexturePath = "Texture/Background/maid_coffee_test_" .. imgIndex
  local voice = m_voices[imgIndex]
  if m_currentVoice ~= voice then
    CS.SoundManager.Instance:StopSound(m_currentVoice)
  end
  if m_currentVoice == voice and m_audioSource and m_audioSource.isPlaying then
    m_currentVoice = voice
  else
    m_currentVoice = voice
    if WU.TopWindow().name == "MaidCafeRecruitMent" then
      m_audioSource = CS.SoundManager.Instance:PlaySound(m_currentVoice, 1.0)
    end
  end
  WU.SetActive(REF.RewardsProgress, type ~= PB.enum.MaidCafeRankModeType.Free)
  REF.Activities[type - 1].root.UIToggle.value = true
  m_currentRankTypeInfo = m_rankModeInfo[m_selectedRankType]
  local group = m_groupInfo[m_currentRankTypeInfo.rankModeGroupId]
  REF.LabelGroup.UILabel.text = WU.GetString("MaidCafe_RankMode_HighestScore", group.levelMin, group.levelMax)
  REF.LabelRankScore.UILabel.text = m_currentRankTypeInfo.rankModeValue
  DB:SetData("MaidCafe/HighScore", m_currentRankTypeInfo.rankModeValue)
  local selected_rankRewards = _ENV["!"]({})
  for k, v in pairs(m_rankRewards) do
    if v.rankModeType == type then
      table.insert(selected_rankRewards, v)
    end
  end
  if type == PB.enum.MaidCafeRankModeType.Legend then
    WU.SetActive(REF.LabelNextRankModeHint, false)
    WU.SetActive(REF.NextRewardNode, m_legendRank)
    if m_legendRank then
      if m_legendRank == 0 then
        nextReward = selected_rankRewards:first()
      else
        nextIndex, nextReward = table.find(selected_rankRewards, function(k, v)
          return v.rankModeValue < m_legendRankP
        end)
        nextReward = nextReward or selected_rankRewards:last()
      end
      nextScore = nextReward.rankModeValue
      if m_legendRankP == 0 then
        REF.LabelScoreReward.UILabel.text = WU.GetString("MaidCafe_RankMode_initReward")
      else
        REF.LabelScoreReward.UILabel.text = fif(math.ceil(m_legendRankP / 100) > 60, WU.GetString("MaidCafe_RankMode_RankReward2", nextScore / 100), WU.GetString("MaidCafe_RankMode_RankReward", nextScore / 100, math.ceil(m_legendRankP / 100)))
      end
      WU.SetActive(REF.LabelAllRewardGot, false)
    end
  else
    for k, v in pairs(selected_rankRewards) do
      if maxScore < v.rankModeValue then
        maxScore = v.rankModeValue
        maxReward = v
      end
    end
    WU.SetActive(REF.LabelNextRankModeHint, maxScore > m_currentRankTypeInfo.rankModeValue)
    REF.LabelNextRankModeHint.UILabel.text = WU.GetString("MaidCafe_RankMode_NextRankTypeHint" .. m_selectedRankType, maxScore)
    nextIndex, nextReward = table.find(selected_rankRewards, function(k, v)
      return v.rankModeValue > m_currentRankTypeInfo.rankModeValue
    end)
    nextReward = nextReward or maxReward
    nextScore = nextReward.rankModeValue
    REF.LabelScoreReward.UILabel.text = WU.GetString("MaidCafe_RankMode_ScoreReward", nextScore)
    WU.SetActive(REF.NextRewardNode, nextScore > m_currentRankTypeInfo.rankModeValue)
    REF.LabelAllRewardGot.UILabel.text = WU.GetString("MaidCafe_RankMode_AllRewardsGot" .. type)
    WU.SetActive(REF.LabelAllRewardGot, nextScore <= m_currentRankTypeInfo.rankModeValue)
  end
  for i = 0, #REF.RewardGrid - 1 do
    local ref = REF.RewardGrid[i]
    WU.SetActive(ref.root, nextReward and i < #nextReward.reward)
    if nextReward and i < #nextReward.reward then
      ref.WidgetIconSlot["$SetData"](nextReward.reward[i + 1].type, nextReward.reward[i + 1].id, nextReward.reward[i + 1].count)
    end
  end
  REF.RewardGrid.UIGrid:Reposition()
  WU.SetActive(REF.LabelCost, type ~= PB.enum.MaidCafeRankModeType.Free)
  local dungeonId = m_currentRankTypeInfo.dungeonId
  local balanceDungeonId = DU.GetBalanceDungeon(dungeonId)
  local price1 = DU.GetDungeonPrice(dungeonId)
  local price2 = DU.GetDungeonPrice(balanceDungeonId)
  if price2.count == 0 then
    WU.SetActive(REF.LabelCost, false)
    m_ticketCost = {
      type = PB.enum.ResNone
    }
  else
    m_ticketCost = {
      type = price2.type,
      id = price2.id,
      count = price1.count + price2.count
    }
    REF.LabelCost.ResourcePrinter:SetResource(m_ticketCost.type, m_ticketCost.id, m_ticketCost.count)
  end
  local newUnlocked = this:GetData("MaidCafe/NewUnlocked")
  if newUnlocked then
    local effectname = fif(newUnlocked == PB.enum.MaidCafeRankModeType.Legend, "result_title_29", "result_title_28")
    WU.AcquireWindowAsync("SimpleTitleEffect", function(win)
      _ENV["$"](win)["$$SetEffect"](effectname, "UI_round_start_02", function()
        WU.RecycleWindow("SimpleTitleEffect")
      end)
      this:SetData("MaidCafe/NewUnlocked", nil)
    end)
  end
end

function OnPassRewardChage(rewardInfo)
  if rewardInfo == nil then
    return
  end
  m_passRewardInfo = rewardInfo
  local currentPassCount = rewardInfo.currentPassCount
  local passRewardInfo = rewardInfo.passRewardInfo
  local count = _ENV["!"](passRewardInfo):count()
  local maxPassCount = _ENV["!"](passRewardInfo):last().passCount
  if currentPassCount > maxPassCount then
    currentPassCount = maxPassCount
  end
  local nextIndex, next = table.find(passRewardInfo, function(k, v)
    return v.passCount >= currentPassCount
  end)
  local nextCount = next.passCount
  local preIndex = nextIndex - 1
  local preCount
  if nextIndex == 1 then
    preCount = 0
  else
    preCount = passRewardInfo[nextIndex - 1].passCount
  end
  local progress = preIndex / count + 1 / count * (currentPassCount - preCount) / (nextCount - preCount)
  REF.Progress.UIProgressBar.value = progress
  for i = 0, #REF.RewardsGrid - 1 do
    local ref = REF.RewardsGrid[i]
    WU.SetActive(ref.root, i < count)
    if i < count then
      local x = REF.Progress.UISprite.width / count * (i + 1)
      local y = ref.root.transform.localPosition.y
      ref.root.transform.localPosition = {
        x = x,
        y = y,
        z = 1
      }
      SetPassRewardsView(ref, rewardInfo, i + 1)
    end
  end
end

function SetPassRewardsView(ref, rewardsInfo, index)
  local currentCount = rewardsInfo.currentPassCount
  local rewardInfo = rewardsInfo.passRewardInfo[index]
  local rewardGot = rewardInfo.got
  local canReward = currentCount >= rewardInfo.passCount and not rewardGot
  ref["@canReward"] = canReward
  ref["@rewardGot"] = rewardGot
  ref["@count"] = rewardInfo.passCount
  ref["@index"] = index
  if canReward then
    ref.Glow.EffectGenerator.m_EffectName = "UI_Cafe"
  end
  WU.SetActive(ref.Glow, canReward)
  WU.SetActive(ref.Icon, not canReward)
  if rewardGot then
    ref.Icon.UISprite.spriteName = "coffee_01"
  else
    ref.Icon.UISprite.spriteName = "coffee_03"
  end
  ref.Icon.UISprite:MakePixelPerfect()
  ref.Label.UILabel.text = rewardInfo.passCount
end

function OnClickPassCountReward(go)
  local ref = _ENV["$"](go)
  local path = "fci/maidcafe/rank-mode/pass-reward/"
  if ref["@canReward"] then
    this:GameRequest(path):Post({
      rewardPassCount = ref["@count"]
    }, function(resp)
      local info = resp.passRewardGotInfo[1]
      local resChange = info.resChange
      for k, v in pairs(m_passRewardInfo.passRewardInfo) do
        if v.passCount == info.passCount then
          v.got = true
          break
        end
      end
      this:SetData(path, m_passRewardInfo)
      DBH.ResChange(resChange)
      WU.ShowRewards(resChange)
    end)
  elseif ref["@index"] then
    local reward = m_passRewardInfo.passRewardInfo[ref["@index"]].reward
    local title = WU.GetString("MaidCafe_RankMode_PassRewardTitle")
    local buttonTitle
    local content = ""
    if ref["@rewardGot"] then
      buttonTitle = WU.GetString("WindowGacha_Close")
    else
      content = WU.GetString("MaidCafe_RankMode_PassRewardHint", m_passRewardInfo.currentPassCount, ref["@count"])
    end
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](reward, title, content, ref["@rewardGot"], buttonTitle)
    end)
  end
end

function OnClickRewardPreview()
  if m_audioSource then
    m_audioSource:Stop()
  end
  WU.AcquireWindowAsync("MaidCafeRankRewardPreview")
end

function OnPlayerRankChange(rankData)
  if rankData == nil then
    return
  end
  if m_rankModeInfo[PB.enum.MaidCafeRankModeType.Legend].unlocked == true then
    if rankData.rank == 0 then
      m_legendRank = 0
      m_legendRankP = 0
    else
      m_legendRank = rankData.rank
      m_legendRankP = rankData.rank * 10000 / rankData.rankTotal
    end
    this:SetData("MaidCafe/RankType", this:GetData("MaidCafe/RankType"))
  end
end

function OnClickRank()
  local legend = m_rankModeInfo[PB.enum.MaidCafeRankModeType.Legend]
  this:SetData("MaidCafe/SelectedGroupId", fif(legend.unlocked, legend.rankModeGroupId, 1))
  if m_audioSource then
    m_audioSource:Stop()
  end
  WU.AcquireWindowAsync("MaidCafeRanks")
end

function OnClickNextType()
  local currentType = 1
  for i = 1, 3 do
    if m_rankModeInfo[i].unlocked then
      currentType = i
    end
  end
  if currentType < 3 then
    this:SetData("MaidCafe/NewUnlocked", currentType + 1)
    m_rankModeInfoAll.rankModeInfo[currentType + 1].unlocked = true
    this:SetData("fci/maidcafe/rank-mode", m_rankModeInfoAll)
  end
end

function OnClickButtonPrepare()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_RankMode, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        local status = ACU.GetStatus(activity)
        if status == PB.enum.ActivityStatus.Started then
          if CheckTicket(m_ticketCost) then
            local dungeonId = m_rankModeInfo[m_selectedRankType].dungeonId
            this:SetData("MaidCafe/RankActivityId", activity.activityId)
            this:SetData("WindowDungeon/DungeonId", dungeonId)
            this:SetData("WindowDungeon/MaidRankType", m_selectedRankType)
            if m_audioSource then
              m_audioSource:Stop()
            end
            WU.AcquireWindowAsync("MaidCafeDungeonPrepare")
            return
          else
            WU.ShowHintText(WU.GetString("MaidCafe_RankMode_NotEnoughTickets"))
            return
          end
        elseif status == PB.enum.ActivityStatus.Finished then
          WU.ShowHintText(WU.GetString("MaidCafe_RankMode_End"))
          return
        end
      end
    end
    WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
  end)
end

function CheckTicket(cost)
  if cost.type == PB.enum.ResNone then
    return true
  end
  local stock = 0
  if cost.type == PB.enum.ResourceType.ResItem then
    stock = this:GetData("fci/item/" .. cost.id).count or 0
  else
    stock = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[cost.type] .. "_" .. cost.id) or 0
  end
  return stock >= cost.count
end

function OnSync()
  DB:SyncRemote(DB:GameRequest("fci/maidcafe/rank-mode"))
end

function OnClickTickets()
  if m_ticketCost.type == PB.enum.ResourceType.ResItem then
    WU.ShowItemDetail(m_ticketCost.id)
  else
    WU.ShowHintText(WU.GetString("ResourceTypeName_" .. m_ticketCost.type))
  end
end

function OnClickRule()
  WU.AcquireWindowAsync("RuleCommon", function(win)
    _ENV["$"](win)["$$SetTitle"](WU.GetString("MaidCafe_RankMode_RankRuleTitle"))
    _ENV["$"](win)["$$SetLabel"](WU.GetString("MaidCafe_RankMode_RankRule"))
  end)
end
