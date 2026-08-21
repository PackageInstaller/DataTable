local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local SE = require("Common/SkillEffect")

function Start()
end

function SetData(actor, skill, skillLevel)
  if actor and skill and skillLevel then
    local skillData = SE.GetSkillDescBySkillLevel(actor, skill, skillLevel, "#0199e9")
    if skillData then
      REF.TextureSkill.UITexture.mainTexturePath = skillData.mainTexturePath
      REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", skillLevel)
      REF.LabelName.UILabel.text = skillData.skillName
      if skillData.describe then
        REF.LabelDesc.UIHtmlLabel.text = skillData.describe
      end
    end
    local actorCombo = PB.get("ActorCombo", actor.id, 0, 1)
    local superSkillId = actorCombo.skillList[1]
    REF.SpriteSkillBG.UISprite.spriteName = fif(superSkillId == skill.skillId, "skill_strong_bg", "skill_normal_bg")
    local skillCost = SE.GetActorSkillCost(skill.skillId)
    REF.WidgetTagSkillCost["$SetSkillCost"](skillCost.costSp, skillCost.costMp)
    REF.WidgetTagSkillKind["$SetSkillKind"](skill.skillId)
  end
end
