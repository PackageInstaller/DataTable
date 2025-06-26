-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/agent/skill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Skill = {Move = require("luabehavior.actions.skill.move"), PlayAttackerAction = require("luabehavior.actions.skill.playattackeraction"), PlayAttackerEffect = require("luabehavior.actions.skill.playattackereffect"), ProjectileEffect = require("luabehavior.actions.skill.projectileeffect"), PlayTargetEffect = require("luabehavior.actions.skill.playtargeteffect"), Result = require("luabehavior.actions.skill.result"), Banner = require("luabehavior.actions.noop"), NextStage = require("luabehavior.actions.skill.nextstage")}
return Skill

