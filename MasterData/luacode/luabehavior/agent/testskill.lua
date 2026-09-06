local TestSkill = {
  AttackerMove = require("luabehavior.actions.testskill.attackermove"),
  PlayAttackerAction = require("luabehavior.actions.testskill.playattackeraction"),
  PlayAttackerEffect = require("luabehavior.actions.testskill.playattackereffect"),
  PlayTargetEffect = require("luabehavior.actions.testskill.playtargeteffect"),
  Result = require("luabehavior.actions.testskill.result"),
  HasNextStage = require("luabehavior.actions.testskill.hasnextstage"),
  NextStage = require("luabehavior.actions.testskill.nextstage")
}
return TestSkill
