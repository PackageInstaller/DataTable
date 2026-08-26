-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitEnergyAdd.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitEnergyAdd", package.seeall)

local ArcadeSkillHitEnergyAdd = class("ArcadeSkillHitEnergyAdd", ArcadeSkillHitBase)

function ArcadeSkillHitEnergyAdd:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._rate = tonumber(params[2])
end

function ArcadeSkillHitEnergyAdd:onHit()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local skillEnergyResMO = characterMO and characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.SkillEnergy)

	if skillEnergyResMO then
		local characterId = characterMO:getId()
		local needEnergy = ArcadeConfig.instance:getCharacterSkillCost(characterId) or 0
		local energy = math.floor(needEnergy * self._rate / 1000)

		skillEnergyResMO:addCount(energy)
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnCharacterResourceCountUpdate, ArcadeGameEnum.CharacterResource.SkillEnergy)
	end

	self:addHiter(characterMO)
end

function ArcadeSkillHitEnergyAdd:onHitPrintLog()
	logNormal(string.format("%s ==> 角色补充自身大招能量需求一定百分比的能量", self:getLogPrefixStr()))
end

return ArcadeSkillHitEnergyAdd
