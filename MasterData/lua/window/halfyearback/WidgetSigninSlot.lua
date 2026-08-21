local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local GotoUtil = require("Common/GotoUtil")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local NU = require("Common/NotepadUtil")

function Awake()
  WU.BindButtonEvent(REF.BtnGetReward, OnClickBtnGetReward)
end

function SetView(rewardInfo)
  if rewardInfo then
    local rewardCount = #rewardInfo.reward
    local rewardList
    for i = 0, #REF.Rewards - 1 do
      REF.Rewards[i].root.gameObject:SetActive(i == rewardCount - 1)
      if i == rewardCount - 1 then
        rewardList = REF.Rewards[i]
      end
    end
    for i = 0, #rewardList.root - 1 do
      if rewardCount < i + 1 then
        rewardList.root[i].WidgetIconSlotTask.gameObject:SetActive(false)
      else
        local data = rewardInfo.reward[i + 1]
        rewardList.root[i].WidgetIconSlotTask["$SetData"](data.type, data.id, data.count)
        rewardList.root[i].WidgetIconSlotTask.gameObject:SetActive(true)
      end
    end
    REF.LabelDays.UIHtmlLabel.text = WU.GetString("WindowTenCheckin_WhichDay", rewardInfo.days)
    if rewardInfo.canGet then
      REF.BtnGetReward.gameObject:SetActive(true)
      REF.SpriteSlotBG_glow.gameObject:SetActive(true)
      REF.SpriteSlotBGlight.gameObject:SetActive(true)
      REF.Card.TweenScale.enabled = true
      REF["$AnimatedAlpha"].alpha = 1
    elseif rewardInfo.hasGet then
      REF.BtnGetReward.gameObject:SetActive(false)
      REF.SpriteSlotBG_glow.gameObject:SetActive(false)
      REF.SpriteSlotBGlight.gameObject:SetActive(false)
      REF.Card.TweenScale.enabled = false
      REF["$AnimatedAlpha"].alpha = 0.5
    elseif rewardInfo.cantGet then
      REF.BtnGetReward.gameObject:SetActive(false)
      REF.SpriteSlotBG_glow.gameObject:SetActive(false)
      REF.SpriteSlotBGlight.gameObject:SetActive(false)
      REF.Card.TweenScale.enabled = false
      REF["$AnimatedAlpha"].alpha = 1
    end
  end
end

function OnClickBtnGetReward()
  this:GameRequest("fci/half-year-back-activity/sign/"):Post({}, function(response)
    warning("response", table.dump(response))
    DBH.ResChange(response.resChange)
    WU.ShowRewards(response.resChange)
    local activityInfo = this:GetData("fci/half-year-back-activity/")
    activityInfo.signStep = response.signStep
    activityInfo.lastSignTime = response.lastSignTime
    activityInfo.signAwardId = response.signAwardId
    this:SetData("fci/half-year-back-activity/", activityInfo)
  end)
end
