local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local m_clickCallback, m_data

function Start()
  WU.BindButtonEvent(REF["$"], OnClick)
end

function OnClick()
  if m_clickCallback then
    m_clickCallback(REF["$gameObject"])
  end
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function SetTalent(talent, param)
  m_data = AU.GetTalentDisplayInfo(talent.talentId, talent.talentValue)
  if param.showEffect then
    REF.NodeEffectIcon.gameObject:SetActive(true)
    REF.NodeNormalIcon.gameObject:SetActive(false)
    REF.NodeEffectIconRatio.gameObject:SetActive(m_data.isRatio)
  else
    REF.NodeEffectIcon.gameObject:SetActive(false)
    REF.NodeNormalIcon.gameObject:SetActive(true)
  end
  REF.ScoreLabel.UILabel.text = m_data.score
  REF.LabelTitle.UIHtmlLabel.text = HU.ApplyFontColor(m_data.talentName, "#ffffff")
  if m_data.talentIcon and m_data.bgIdx then
    REF.TextureTalentIcon.UITexture.mainTexturePath = "Texture/ActorTalent/ActorTalent_" .. m_data.talentIcon
    AU.SetTalentBG(_ENV["$"](REF.SpriteTalentBGNode), m_data.bgIdx, m_data.isRatio)
  else
    error("Talent", "missing TalentIcon in Localization_Talent postfix")
  end
  if param.describe then
    if param.BGColor then
      REF.SpriteBG.UISprite.color = CS.NGUIMath.HexToColor(param.BGColor)
    end
    local color = fif(param.isYellowLabel, {"#FFFFFF", "#ffe65a"}, {"#3B578B", "#0199e9"})
    REF.LabelTalent.UIHtmlLabel.text = AU.GetActorTalentDesc(talent, color[1], color[2])
  end
  if param.showEffect then
    AU.ChangeTalentEffectTexture(REF.ACtortalent_bg, REF.ACtortalent, m_data)
  end
  WU.SetActive(REF.LabelClickToReset, param.resetMode)
end
