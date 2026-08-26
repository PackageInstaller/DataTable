-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotTeamModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotTeamModel", package.seeall)

local V1a6_CachotTeamModel = class("V1a6_CachotTeamModel")

function V1a6_CachotTeamModel:setSelectLevel(value)
	self._selectLevel = value
	self._difficulty = lua_rogue_difficulty.configDict[self._selectLevel]
	self._seatLevel = string.splitToNumber(self._difficulty.initLevel, "#")
end

function V1a6_CachotTeamModel:getPrepareNum()
	return self._difficulty.initHeroCount - V1a6_CachotEnum.HeroCountInGroup
end

function V1a6_CachotTeamModel:getSelectLevel()
	return self._selectLevel
end

function V1a6_CachotTeamModel:getInitSeatLevel(index)
	return self._seatLevel[index]
end

function V1a6_CachotTeamModel:getSeatLevel(index)
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local teamInfo = rogueInfo.teamInfo

	return teamInfo.groupBoxStar[index]
end

function V1a6_CachotTeamModel:clearSeatInfos()
	self._seatInfo = {}
end

function V1a6_CachotTeamModel:setSeatInfo(index, level, mo)
	if not index or not level then
		return
	end

	self._seatInfo[mo] = {
		index,
		level
	}
end

function V1a6_CachotTeamModel:getSeatInfo(mo)
	return self._seatInfo and self._seatInfo[mo]
end

function V1a6_CachotTeamModel:getHeroMaxLevel(heroMO, seatLevel)
	if not seatLevel then
		return heroMO.level, heroMO.talent
	end

	local starCount = CharacterEnum.Star[heroMO.config.rare]
	local config = lua_rogue_field.configDict[seatLevel]

	if starCount > 4 then
		if not ("level" .. starCount) then
			local levelKey = "level4"
			local maxLevel = config[levelKey]
			local maxTalentLevel = config.talentLevel
			local heroTalentMaxLv = HeroResonanceConfig.instance:getHeroMaxTalentLv(heroMO.heroId)

			maxTalentLevel = math.min(maxTalentLevel, heroTalentMaxLv)

			if self:isNoLimitLevel() then
				return maxLevel, maxTalentLevel
			end

			return math.min(heroMO.level, maxLevel), math.min(heroMO.talent, maxTalentLevel)
		end
	end
end

function V1a6_CachotTeamModel:getEquipMaxLevel(equipMO, seatLevel)
	if not seatLevel then
		return equipMO.level, equipMO.breakLv
	end

	local config = lua_rogue_field.configDict[seatLevel]
	local equipLv = 0

	equipLv = self:isNoLimitLevel() and config.equipLevel or math.min(equipMO.level, config.equipLevel)

	return equipLv, equipMO:getBreakLvByLevel(equipLv)
end

function V1a6_CachotTeamModel:isNoLimitLevel()
	local difficulty = self._selectLevel

	if not difficulty then
		local rougeInfo = V1a6_CachotModel.instance:getRogueInfo()

		if not rougeInfo then
			return false
		end

		difficulty = rougeInfo.difficulty
	end

	local difficultyCo = lua_rogue_difficulty.configDict[difficulty]
	local list = string.split(difficultyCo.effect2, "|")

	for i, v in ipairs(list) do
		if v == V1a6_CachotEnum.NoLimit then
			return true
		end
	end

	return false
end

V1a6_CachotTeamModel.instance = V1a6_CachotTeamModel.New()

return V1a6_CachotTeamModel
