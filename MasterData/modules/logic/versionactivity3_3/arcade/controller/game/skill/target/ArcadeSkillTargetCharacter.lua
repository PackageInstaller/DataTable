-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetCharacter.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetCharacter", package.seeall)

local ArcadeSkillTargetCharacter = class("ArcadeSkillTargetCharacter", ArcadeSkillTargetBase)

function ArcadeSkillTargetCharacter:onConfigParams()
	self._targetCanOutsideRoom = true
end

function ArcadeSkillTargetCharacter:onFindTarget()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	self:addTarget(characterMO)
end

return ArcadeSkillTargetCharacter
