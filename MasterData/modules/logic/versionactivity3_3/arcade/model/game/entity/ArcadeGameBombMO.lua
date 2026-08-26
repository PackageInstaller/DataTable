-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameBombMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameBombMO", package.seeall)

local ArcadeGameBombMO = class("ArcadeGameBombMO", ArcadeGameBaseUnitMO)

function ArcadeGameBombMO:onCtor(extraParam)
	local skillSetMO = self:getSkillSetMO()
	local id = self:getId()
	local skillIdList = {}
	local skill = ArcadeConfig.instance:getBombSkill(id)

	if skill and skill ~= 0 then
		skillIdList[#skillIdList + 1] = skill
	end

	local skills = ArcadeConfig.instance:getBombSkills(id)

	if skillSetMO and not string.nilorempty(skills) then
		local skillIds = string.splitToNumber(skills, "#")

		for _, skillId in ipairs(skillIds) do
			skillIdList[#skillIdList + 1] = skillId
		end
	end

	for _, skillId in ipairs(skillIdList) do
		skillSetMO:addSkillById(skillId)
	end

	self._liveRound = 0

	if extraParam then
		self._bounceCount = extraParam.bounceCount

		self:setDirection(extraParam.direction)

		self._isCharacterBomb = extraParam.isCharacterBomb
	end
end

function ArcadeGameBombMO:addLiveRound()
	self._liveRound = self._liveRound + 1
end

function ArcadeGameBombMO:getCfg()
	return (ArcadeConfig.instance:getBombCfg(self.id, true))
end

function ArcadeGameBombMO:getSize()
	if not self._sizeX then
		self._sizeX, self._sizeY = ArcadeConfig.instance:getBombSize(self.id)
	end

	return self._sizeX, self._sizeY
end

function ArcadeGameBombMO:getRes()
	return ArcadeConfig.instance:getBombRes(self.id)
end

function ArcadeGameBombMO:getDesc()
	local cfgDesc = ArcadeConfig.instance:getBombDesc(self.id)

	return ArcadeGameHelper.phraseDesc(cfgDesc, true)
end

function ArcadeGameBombMO:getIdleShowEffectId()
	local stateShowEffectId = ArcadeConfig.instance:getBombIdleShowEffectId(self.id)

	if not stateShowEffectId or stateShowEffectId == 0 then
		stateShowEffectId = ArcadeConfig.instance:getStateShowEffectId(ArcadeGameEnum.StateShowId.Idle)
	end

	return stateShowEffectId
end

function ArcadeGameBombMO:getLiveRound()
	return self._liveRound
end

function ArcadeGameBombMO:getIsCharacterBomb()
	if type(self._isCharacterBomb) == "boolean" then
		return self._isCharacterBomb
	else
		local characterMO = ArcadeGameModel.instance:getCharacterMO()
		local characterId = characterMO and characterMO:getId()
		local characterBombId = ArcadeConfig.instance:getCharacterBomb(characterId)

		return self.id == characterBombId
	end
end

function ArcadeGameBombMO:getBounceCount()
	return self._bounceCount or 0
end

return ArcadeGameBombMO
