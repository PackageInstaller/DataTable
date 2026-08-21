local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local m_selectIndex, m_rewardList

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirmClick)
end

function InitWindow()
  m_selectIndex = nil
  WU.ToggleRendering(REF.Content, false)
end

function SetView(result, selectIndex)
  if #result[1].reward ~= #REF.SelectList then
    error("ActivitySigninGift.xlsx has not 3 rewards")
    return
  end
  m_rewardList = result[1].reward
  for i = 0, #REF.SelectList - 1 do
    REF.SelectList[i]["$$SetData"](m_rewardList[i + 1].type, m_rewardList[i + 1].id, m_rewardList[i + 1].count * #result)
    REF.SelectList[i]["$$SetClickCallback"](function()
      SetHighlighted(i)
    end)
  end
  SetHighlighted(selectIndex - 1)
  WU.ToggleRendering(REF.Content, true)
end

function OnConfirmClick()
  if m_selectIndex then
    this:GameRequest("fci/half-year-back-activity/sign"):Patch({signAwardId = m_selectIndex}, function(response)
      local activityInfo = this:GetData("fci/half-year-back-activity/")
      activityInfo.signAwardId = m_selectIndex
      this:SetData("fci/half-year-back-activity/", activityInfo)
      WU.RecycleWindow(this)
    end)
  else
    WU.ShowHintText(WU.GetString("Welfare_PleaseSelectReward"))
  end
end

function SetHighlighted(index)
  for i = 0, #REF.SelectList - 1 do
    if i == index then
      REF.SelectList[i].SpriteSelected.gameObject:SetActive(true)
      m_selectIndex = i + 1
    else
      REF.SelectList[i].SpriteSelected.gameObject:SetActive(false)
    end
  end
end
