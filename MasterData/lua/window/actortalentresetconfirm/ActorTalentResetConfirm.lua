local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local m_confirmCallback

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonCancel, function()
    WU.RecordButtonClick(105038)
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    WU.RecordButtonClick(105037)
    WU.RecycleWindow(this)
    if m_confirmCallback then
      m_confirmCallback()
    end
  end)
end

function UninitWindow()
  m_confirmCallback = nil
end

function SetTalents(talentOld, talentNew, callback)
  m_confirmCallback = callback
  if talentOld then
    UpdateTalent(_ENV["$"](REF.TalentOld), talentOld)
  end
  local tips = WU.GetString("Talent_ResetKeepOld")
  local confirmLabelText = WU.GetString("WindowSystem_Confirm")
  if talentNew then
    UpdateTalent(_ENV["$"](REF.TalentNew), talentNew)
    tips = WU.GetString("Talent_ResetReplaceWithNew")
    confirmLabelText = WU.GetString("Talent_ResetReplace")
  end
  REF.TalentNew.gameObject:SetActive(talentNew)
  REF.SpriteArrow.gameObject:SetActive(talentNew)
  REF.LabelTips.UIHtmlLabel.text = tips
  _ENV["$"](REF.ButtonConfirm).Label.UILabel.text = confirmLabelText
  REF.TalentGrid.UIGrid:Reposition()
end

function UpdateTalent(slotRef, talent)
  local displayInfo = AU.GetTalentDisplayInfo(talent.talentId, talent.talentValue)
  slotRef.LabelScore.UILabel.text = displayInfo.score
  slotRef.LabelTitle.UIHtmlLabel.text = displayInfo.talentName
  if displayInfo.talentIcon and displayInfo.bgIdx then
    slotRef.TextureTalentIcon.UITexture.mainTexturePath = "Texture/ActorTalent/ActorTalent_" .. displayInfo.talentIcon
    AU.SetTalentBG(_ENV["$"](slotRef.SpriteTalentBGNode), displayInfo.bgIdx, displayInfo.isRatio)
  else
    error("Talent", "missing TalentIcon in Localization_Talent postfix")
  end
end

function Focus()
  WU.RecordWindowFocus(100105, true)
end
