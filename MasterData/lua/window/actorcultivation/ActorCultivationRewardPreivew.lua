local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_activityId, m_rewards, m_actor

function SetupWindow()
  LU.Bind(REF.WrapContentReward, {
    updateRow = updateReward,
    delta = 0.01
  })
  local wrap = REF.WrapContentReward
  WU.TraverseChildren(wrap, function(g)
    WU.BindButtonEvent(_ENV["$"](g).CG, OnclickSpecialReward)
  end)
end

function SetData(activityId)
  if activityId == nil then
    return
  end
  m_activityId = activityId
  local infos = PB.get("ActorCultivation", m_activityId)
  m_actor = infos.actorId
  local rewards = PB.all("ActorCultivationProgressReward")
  m_rewards = {}
  for _, v in pairs(rewards) do
    if v.activityId == m_activityId then
      table.insert(m_rewards, v)
    end
  end
  LU.Set(REF.WrapContentReward, #m_rewards)
end

function updateReward(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil then
    local rewardIndex = realIndex
    rowRef.CG.UITexture.mainTexturePath = "Texture/Welfare/ActorCultivation_small_" .. m_actor .. "a"
    if m_rewards and rewardIndex < #m_rewards - 1 then
      WU.ToggleRendering(rowRef.RewardNode, true)
      WU.ToggleRendering(rowRef.SpecialReward, false)
      local rewardInfo = m_rewards[rewardIndex + 1]
      rowRef.LabelIndex.UILabel.text = rewardInfo.progress .. "%"
      local reward = rewardInfo.reward[1]
      local vipRewards = rewardInfo.rewardVip
      rowRef.RewardList[0]["$$SetData"](reward.type, reward.id, reward.count)
      WU.ToggleRendering(rowRef.RewardList[1].root, false)
      WU.ToggleRendering(rowRef.RewardList[2].root, false)
      for i = 1, #vipRewards do
        rowRef.RewardList[i]["$$SetData"](vipRewards[i].type, vipRewards[i].id, vipRewards[i].count)
        WU.ToggleRendering(rowRef.RewardList[i].root, true)
      end
    elseif m_rewards and rewardIndex == #m_rewards - 1 then
      rowRef.LabelIndex.UILabel.text = "100%"
      WU.ToggleRendering(rowRef.RewardNode, false)
      WU.ToggleRendering(rowRef.SpecialReward, true)
    end
  end
end

function OnclickSpecialReward()
  local special = PB.get("ActorCultivationProgressReward", m_activityId, 100).reward[1]
  WU.ShowResourceDetail(special.type, special.id)
end
