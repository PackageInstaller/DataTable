local Skill = {
  Move = require("luabehavior.actions.skill.move"),
  PlayAttackerAction = require("luabehavior.actions.skill.playattackeraction"),
  PlayAttackerEffect = require("luabehavior.actions.skill.playattackereffect"),
  ProjectileEffect = require("luabehavior.actions.skill.projectileeffect"),
  PlayTargetEffect = require("luabehavior.actions.skill.playtargeteffect"),
  Result = require("luabehavior.actions.skill.result"),
  Banner = require("luabehavior.actions.noop"),
  NextStage = require("luabehavior.actions.skill.nextstage")
}
return Skill
