local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local m_displayInfo, m_talent

function Start()
  WU.BindButtonEvent(REF.ButtonBG, OnSelect)
end

function OnSelect()
  this:BroadcastGameEvent("SelectTalentResetResult", m_talent.index)
end

function SetTalent(talent)
  m_talent = talent
  WU.SetActive(REF.NodeEmpty, m_talent.talentId == 0)
  WU.SetActive(REF.NodeNormal, m_talent.talentId > 0)
  if m_talent.talentId > 0 then
    m_displayInfo = AU.GetTalentDisplayInfo(m_talent.talentId, m_talent.talentValue)
    REF.ScoreLabel.UILabel.text = m_displayInfo.score
    REF.LabelTitle.UIHtmlLabel.text = HU.ApplyFontColor(m_displayInfo.talentName, "#ffffff")
    REF.LabelTalent.UIHtmlLabel.text = AU.GetActorTalentDesc(m_talent, "#FFFFFF", "#ffe65a")
    REF.SpriteNew.gameObject:SetActive(false)
    REF.LabelIndex.UILabel.text = tostring(m_talent.index)
    if m_displayInfo.talentIcon and m_displayInfo.bgIdx then
      REF.TextureTalentIcon.UITexture.mainTexturePath = "Texture/ActorTalent/ActorTalent_" .. m_displayInfo.talentIcon
      AU.SetTalentBG(_ENV["$"](REF.SpriteTalentBGNode), m_displayInfo.bgIdx, m_displayInfo.isRatio)
    else
      error("Talent", "missing TalentIcon in Localization_Talent postfix")
    end
  end
end
