local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local SE = require("Common/SkillEffect")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")

function SetData(actorAssitantItem, hostActor)
  REF.LabelAssistantName.UILabel.text = WU.GetString("Window_ActorLinkName_" .. actorAssitantItem.linkID)
  local slogonText = WU.GetString("Window_ActorLinkSlogon_" .. actorAssitantItem.linkID)
  if slogonText ~= "" then
    slogonText = slogonText .. "\n"
  end
  REF.LabelAssistantSlogon.UILabel.text = slogonText
  local assistDesc = WU.GetString("Window_ActorLinkSimplifyDesc_" .. actorAssitantItem.linkID)
  REF.WidgetTagSkillCost["$SetSkillCost"](actorAssitantItem.costSp, actorAssitantItem.costMp)
  for _, link in pairs(actorAssitantItem.link) do
    local actorConfig = PB.get("ActorConfig", link.actorID)
    REF["ActorTexture" .. actorConfig.kind].UITexture.mainTexturePath = "Texture/ActorHeadBig/actor_head_big_" .. actorConfig.animRes
    if actorConfig.isLimited == 1 then
    else
      REF.LabelAssistantDesc.UIHtmlLabel.text = assistDesc
    end
  end
  if actorAssitantItem.costSp > 0 then
    REF.SkillBg.UISprite.spriteName = "skill_strong"
  else
    REF.SkillBg.UISprite.spriteName = "skill_normal"
  end
  REF.AssistantIconTexture.UITexture.mainTexturePath = "Texture/ActorRelationSkill/actor_relation_" .. actorAssitantItem.linkID
end

function ShowCustomRelationSlot(data)
  REF.SpriteDecoration.gameObject:SetActive(data.showBg ~= nil and data.showBg)
end
