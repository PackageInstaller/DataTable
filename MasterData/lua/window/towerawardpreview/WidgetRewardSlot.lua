local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_rewardInfo

function SetData(data)
  m_rewardInfo = data
end

function GetData()
  return m_rewardInfo
end

function SetRewardView()
  if m_rewardInfo == nil then
    return
  end
  for i = 0, #REF.RewardList - 1 do
    if m_rewardInfo.reward == nil then
      REF.RewardList[i].root.gameObject:SetActive(true)
      REF.RewardList[i].root["$SetClickCallback"](nil)
    else
      REF.RewardList[i].root.gameObject:SetActive(i < #m_rewardInfo.reward)
      if i < #m_rewardInfo.reward then
        local reward = m_rewardInfo.reward[i + 1]
        REF.RewardList[i].root["$SetData"](reward.type, reward.id, reward.count)
        REF.RewardList[i].root["$SetClickCallback"](function()
          WU.ShowResourceDetail(reward.type, reward.id)
        end)
      end
    end
  end
  REF.RewardList.UIGrid:Reposition()
end

function SetTitleView()
end

function SetStateView()
  if REF.BtnGet then
    REF.BtnGet.gameObject:SetActive(m_rewardInfo.rewardState == PB.enum.RewardState.CanGet)
    if m_rewardInfo.rewardState == PB.enum.RewardState.CanGet then
      _ENV["$"](REF.BtnGet)["@data"] = m_rewardInfo
    end
  end
  if REF.SpriteGot then
    REF.SpriteGot.gameObject:SetActive(m_rewardInfo.rewardState == PB.enum.RewardState.HasGot)
  end
  if REF.LabelTarget then
    REF.LabelTarget.gameObject:SetActive(m_rewardInfo.rewardState == PB.enum.RewardState.WillDo)
    if m_rewardInfo.rewardState == PB.enum.RewardState.WillDo then
      REF.LabelTarget.UILabel.text = m_rewardInfo.rewardTarget
    end
  end
  if REF.SpriteNotComplete then
    REF.SpriteNotComplete.gameObject:SetActive(m_rewardInfo.rewardState == PB.enum.RewardState.WillDo)
  end
  if REF.Progress then
    REF.Progress.gameObject:SetActive(m_rewardInfo.rewardState == PB.enum.RewardState.IsDoing)
    if m_rewardInfo.rewardState == PB.enum.RewardState.IsDoing then
      REF.LabelProgress.UILabel.text = WU.GetString("Window_TowerReward2", m_rewardInfo.currentValue, m_rewardInfo.rewardTarget)
      REF.ProgressBar.UIProgressBar.value = m_rewardInfo.currentValue / m_rewardInfo.rewardTarget
    end
  end
  if REF.SpriteWillGet then
    REF.SpriteWillGet.gameObject:SetActive(m_rewardInfo.rewardState == PB.enum.RewardState.WillDo)
  end
end

function SetTwoRewardsLeftStyle()
  REF.BgLeft.UISprite.width = 363
  REF.BgRight.UISprite.width = 470
  local t = REF.StateNode.transform.localPosition
  REF.StateNode.transform.localPosition = {
    x = 291,
    y = t.y,
    z = t.z
  }
end

function SetThreeRewardsLeftStyle()
  REF.BgLeft.UISprite.width = 503
  REF.BgRight.UISprite.width = 330
  local t = REF.StateNode.transform.localPosition
  REF.StateNode.transform.localPosition = {
    x = 262,
    y = t.y,
    z = t.z
  }
end
