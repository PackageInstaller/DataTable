local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_rewardInfo, m_clickCallback

function Start()
  if REF.BtnGet then
    WU.BindButtonEvent(REF.BtnGet, function(go)
      if m_clickCallback then
        m_clickCallback(go)
      end
    end)
  end
end

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

function SetTitleView(content1, content2)
  if REF.LabelTitle then
    REF.LabelTitle.UIHtmlLabel.text = content1
  end
  if REF.LabelTitle2 then
    REF.LabelTitle2.UIHtmlLabel.text = content2
  end
end

function SetStateView(config)
  WU.SetActive(REF.StateNode, config.showState)
  if not config.showState then
    return
  end
  local showGet = REF.BtnGet and config.showGet
  local showProgress = REF.Progress and config.showProgress
  local realState = m_rewardInfo.rewardState
  if not showGet and realState == PB.enum.RewardState.CanGet then
    realState = PB.enum.RewardState.HasGot
  end
  if not showProgress and realState == PB.enum.RewardState.IsDoing then
    realState = PB.enum.RewardState.WillDo
  end
  if REF.BtnGet then
    REF.BtnGet.gameObject:SetActive(realState == PB.enum.RewardState.CanGet)
    if realState == PB.enum.RewardState.CanGet then
      _ENV["$"](REF.BtnGet)["@data"] = m_rewardInfo
    end
  end
  if REF.SpriteGot then
    REF.SpriteGot.gameObject:SetActive(realState == PB.enum.RewardState.HasGot)
  end
  if REF.Progress then
    REF.Progress.gameObject:SetActive(realState == PB.enum.RewardState.IsDoing)
    if realState == PB.enum.RewardState.IsDoing then
      REF.LabelProgress.UILabel.text = m_rewardInfo.progressText
      REF.ProgressBar.UIProgressBar.value = m_rewardInfo.progressValue
    end
  end
  if REF.LabelTarget then
    REF.LabelTarget.gameObject:SetActive(realState == PB.enum.RewardState.WillDo)
    if realState == PB.enum.RewardState.WillDo then
      REF.LabelTarget.UILabel.text = m_rewardInfo.rewardTarget
    end
  end
  if REF.SpriteNotComplete then
    REF.SpriteNotComplete.gameObject:SetActive(realState == PB.enum.RewardState.WillDo)
  end
  if REF.SpriteWillGet then
    REF.SpriteWillGet.gameObject:SetActive(realState == PB.enum.RewardState.WillDo)
  end
end

function SetClickCallback(func)
  m_clickCallback = func
end
