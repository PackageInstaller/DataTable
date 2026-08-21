local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local RU = require("Common/RedMarkUtil")
local m_reward, m_chapterRecord, m_condition
local m_canGetReward = false
local m_CanGetRewardList, m_rewardhist, m_rewardGotList
local m_status = {
  canGetReward = 1,
  gotReward = 2,
  canNotGetReward = 3
}
local status = m_status.canNotGetReward

function Start()
  WU.BindButtonEvent(REF.ButtonDraw, OnDrawClick)
end

function SetReward(rewardsInfo)
  if rewardsInfo == nil then
    return
  end
  m_CanGetRewardList = DB:GetData("cultivationpvp/canrewardList")
  m_rewardhist = DB:GetData("fci/challenge-mode/reward")
  m_rewardGotList = m_rewardhist.rewardRecords
  m_reward = rewardsInfo
  m_condition = rewardsInfo.score
  for i = 0, #REF.Grid - 1 do
    local itemSlotRef = REF.Grid[i]
    itemSlotRef["$gameObject"]:SetActive(i < #m_reward.reward)
    if i < #m_reward.reward then
      local reward = m_reward.reward[i + 1]
      itemSlotRef["$$SetData"](reward.type, reward.id, reward.count)
      if reward.type == PB.enum.ResourceType.ResMedal then
        itemSlotRef["$$SetNameVisible"](false)
      end
      itemSlotRef["$$SetCountFontSize"](46)
    end
  end
  REF.ConditionDesc.UILabel.text = WU.GetString("CultivationPvP_RewardCondition", m_condition)
  CheckStatus()
  RewardStatusChange()
end

function RewardStatusChange()
  REF.SpriteGot.gameObject:SetActive(status == m_status.gotReward)
  REF.ButtonNotGet.gameObject:SetActive(status == m_status.canNotGetReward)
  REF.ButtonDraw.gameObject:SetActive(status == m_status.canGetReward)
  if REF.ButtonDraw.gameObject.activeSelf then
    REF.EffectBox.UIPlayTween:Play(true)
  end
end

function OnDrawClick()
  if status ~= m_status.canGetReward then
    return
  end
  DB:GameRequest("fci/challenge-mode/reward"):Post({
    score = m_reward.score,
    dungeonId = m_reward.dungeonId
  }, function(resp)
    if resp then
      OnRewardResponse(resp)
    end
  end)
end

function CheckStatus()
  if #m_CanGetRewardList < 1 then
    if IsCultivationRewardGot(m_reward.dungeonId, m_reward.score, m_rewardGotList) then
      status = m_status.gotReward
    else
      status = m_status.canNotGetReward
    end
  else
    for _, v in pairs(m_CanGetRewardList) do
      if v.dungeonId == m_reward.dungeonId and m_reward.score == v.score then
        status = m_status.canGetReward
        return
      end
    end
    if IsCultivationRewardGot(m_reward.dungeonId, m_reward.score, m_rewardGotList) then
      status = m_status.gotReward
    else
      status = m_status.canNotGetReward
    end
  end
end

function OnRewardResponse(result)
  DBH.ResChange(result.resChange)
  WU.ShowRewards(result.resChange)
  status = m_status.gotReward
  RewardStatusChange()
  for _, v in pairs(m_CanGetRewardList) do
    if v.dungeonId == m_reward.dungeonId and m_reward.score == v.dungeonId then
      v = nil
    end
  end
  m_rewardhist.rewardRecords = result.rewardRecords
  this:SetData("fci/challenge-mode/reward", m_rewardhist)
  this:BroadcastGameEvent("CultivationPVP/LocateReward")
end

function IsCultivationRewardGot(id, score, rewardGotList)
  if rewardGotList[tostring(id)] == nil then
    return false
  end
  local data = rewardGotList[tostring(id)].rewardGot
  return table.has(data, score)
end
