local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function SetSkill(skillId)
  if 0 < skillId then
    REF.LabelSkill.UILabel.text = WU.GetString("SkillName_" .. skillId)
    local actorSkill = PB.get("ActorSkill", skillId)
    local actorConfig = PB.get("ActorConfig", actorSkill.actorId)
    local index = fif(actorConfig.kind == PB.enum.ActorType.Sub, actorSkill.resIndex + 2, actorSkill.resIndex)
    REF.TextureSkill.UITexture.mainTexturePath = "Texture/ActorSkillBig/actor_skill_" .. index
  end
  REF["$UITable"]:Reposition()
end
