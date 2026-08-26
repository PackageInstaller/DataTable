-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondNormal.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondNormal", package.seeall)

local ArcadeSkillCondNormal = class("ArcadeSkillCondNormal", ArcadeSkillCondBase)

function ArcadeSkillCondNormal:onIsCondSuccess()
	return true
end

return ArcadeSkillCondNormal
