local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local mRewards, mRegularRewards, mSpecialRewards, mActivityId, mActivityInfos
local mRewardWrapContent = REF.RewardWrapContent
local mCurrentIndex = 1
local mPlayerRankInfos = {}
local mAllScoreRewards, mAllSpecialRewards, m_Seasons4
local mSpecialClass = {
  1,
  2,
  3,
  10,
  50
}

function SetupWindow()
  LU.Bind(mRewardWrapContent, {
    updateRow = UpdateRewardSlot
  })
  mAllScoreRewards = PB.all("ChallengeModeScoreReward")
  mAllSpecialRewards = PB.all("ChallengeModeRankReward")
  for i = 0, #REF.TabGrid - 1 do
    local TabRef = REF.TabGrid[i]
    TabRef["@index"] = i + 1
    CS.EventDelegate.Add(TabRef.root.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        mCurrentIndex = TabRef["@index"]
        OnDungeonChanged(TabRef["@index"])
      end
    end)
  end
end

function InitWindow()
  this:RegisterGameEvent("CultivationPVP/LocateReward", OnUpdateRewardList)
  this:Bind("cultivationPVPDungeonIds", OnActivityChanged)
  GetCurrentSeasonRank()
  this:Bind("CultivationPvP/RankInfo", OnRankChanged)
end

function OnUpdateRewardList()
  if mRegularRewards == nil or mActivityInfos == nil then
    return
  end
  local dungeonId = mActivityInfos.dungeonId[mCurrentIndex]
  local rewardList = this:GetData("cultivationpvp/canrewardList")
  local score = 0
  if rewardList == nil or #rewardList < 1 then
    return
  end
  for _, v in pairs(rewardList) do
    if dungeonId == v.dungeonId and score < v.score then
      score = v.score
    end
  end
  if score == 0 then
    return
  end
  local gotoIndex = 1
  for _, v in pairs(mRegularRewards) do
    if v.score == score then
      break
    end
    gotoIndex = gotoIndex + 1
  end
  LU.Set(mRewardWrapContent, #mRegularRewards)
  local moveDistance = mRewardWrapContent.UIWrapContent.itemSize * (gotoIndex - 1)
  REF.RewardScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, moveDistance, 0))
  REF.RewardScrollView.UIScrollView:RestrictWithinBounds(true)
end

function OnActivityChanged(data)
  if data == nil then
    return
  end
  m_Seasons4 = {}
  for k, v in pairs(data) do
    table.insert(m_Seasons4, k)
  end
  table.sort(m_Seasons4, function(a, b)
    return b < a
  end)
  mActivityId = m_Seasons4[1]
  mActivityInfos = PB.get("ChallengeModeDungeon", mActivityId)
  for i = 0, #REF.TabGrid - 1 do
    local ref = REF.TabGrid[i]
    local dungeonId = mActivityInfos.dungeonId[i + 1]
    ref["@dungeonId"] = dungeonId
    ref.LabelButton.UIHtmlLabel.text = WU.GetString("ChallengeName_" .. dungeonId)
    RU.BindRedMark(this, "Welfare/CultivationPvP/Reward/" .. i, function(flag)
      WU.SetActive(ref.SpriteNew, flag)
    end)
  end
  OnDungeonChanged(mCurrentIndex)
end

function OnRankChanged(rankData)
  if rankData == nil or rankData[1] == nil then
    return
  end
  if rankData[mCurrentIndex] then
    local info = rankData[mCurrentIndex]
    WU.SetActive(REF.RankNode, true)
    REF.PlayerRank.UILabel.text = WU.GetString("CultivationPvP_PlayerRank", info.rank)
    REF.PlayerCultivation.UILabel.text = WU.GetString("CultivationPvP_PlayerCultivation", info.cultivation)
  end
end

function GetCurrentSeasonRank()
  local dungeonInIds = PB.get("ChallengeModeDungeon", mActivityId).dungeonId
  for i = 0, #dungeonInIds - 1 do
    local dungeonId = dungeonInIds[i + 1]
    local url = "fci/challenge-mode-rank/top/50/dungeon/" .. dungeonId
    DB:GameRequest(url):Get(function(response)
      local rankData = response.rankInfo
      local rank = 0
      local cultivation = 0
      local inRank = false
      if response == nil or rankData[1] == nil then
        mPlayerRankInfos[i + 1] = {cultivation = "--", rank = "--"}
        return
      end
      local recordList = this:GetData("CultivationPvP/scoreRecord")
      if recordList[tostring(dungeonId)] ~= nil then
        cultivation = recordList[tostring(dungeonId)]
      end
      for _, rankinfo in pairs(rankData) do
        rank = rank + 1
        if rankinfo.playerId == DB:GetData("playerId") then
          inRank = true
          break
        end
      end
      rank = fif(inRank, rank, "--")
      cultivation = fif(cultivation == 0, "--", cultivation)
      mPlayerRankInfos[i + 1] = {cultivation = cultivation, rank = rank}
      DB:SetData("CultivationPvP/RankInfo", mPlayerRankInfos)
    end)
  end
end

function OnDungeonChanged(index)
  if index == nil or mActivityInfos == nil then
    return
  end
  local dungeonId = mActivityInfos.dungeonId[index]
  mRegularRewards = {}
  for _, reward in pairs(mAllScoreRewards) do
    if reward.dungeonId == dungeonId then
      table.insert(mRegularRewards, reward)
    end
  end
  LU.Set(mRewardWrapContent, #mRegularRewards)
  mSpecialRewards = {}
  for i = 1, #mSpecialClass do
    local type = mActivityInfos.dungeonReward[index]
    local rank = mSpecialClass[i]
    local reward = PB.get("ChallengeModeRankReward", type, rank)
    if reward then
      table.insert(mSpecialRewards, reward)
    else
      error("No Rank reward with rank" .. mSpecialClass[i], dungeonId)
    end
  end
  UpdateSpecialRewards(mSpecialRewards, index)
  this:BroadcastGameEvent("CultivationPVP/LocateReward")
end

function UpdateSpecialRewards(specialRewards, index)
  if specialRewards ~= nil then
    for i = 0, #REF.SpecialRewardGrid - 1 do
      local pairRef = REF.SpecialRewardGrid[i]
      UpdateSpecialRewardPair(pairRef.Slot1, specialRewards[i + 1].reward[1])
      UpdateSpecialRewardPair(pairRef.Slot2, specialRewards[i + 1].reward[2])
    end
  else
    warning("no specialReward ")
  end
  OnRankChanged(mPlayerRankInfos)
end

function UpdateRewardSlot(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil then
    local rewardIndex = realIndex
    if mRegularRewards and rewardIndex < #mRegularRewards then
      local rewardInfo = mRegularRewards[realIndex + 1]
      rowRef["$$SetReward"](rewardInfo)
    end
  end
end

function UpdateSpecialRewardPair(slotWidget, reward)
  local slot = _ENV["$"](slotWidget).WidgetIconSlot
  if reward == nil then
    WU.SetActive(slot, false)
  end
  slot["$SetData"](reward.type, reward.id, reward.count)
  if reward.type == PB.enum.ResourceType.ResMedal then
    slot["$SetNameVisible"](false)
  end
  slot["$SetCountFontSize"](46)
end
