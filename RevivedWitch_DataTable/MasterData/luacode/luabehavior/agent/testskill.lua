-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/agent/testskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TestSkill = {AttackerMove = require("luabehavior.actions.testskill.attackermove"), PlayAttackerAction = require("luabehavior.actions.testskill.playattackeraction"), PlayAttackerEffect = require("luabehavior.actions.testskill.playattackereffect"), PlayTargetEffect = require("luabehavior.actions.testskill.playtargeteffect"), Result = require("luabehavior.actions.testskill.result"), HasNextStage = require("luabehavior.actions.testskill.hasnextstage"), NextStage = require("luabehavior.actions.testskill.nextstage")}
return TestSkill

