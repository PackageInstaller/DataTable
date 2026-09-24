-- chunkname: @modules/logic/character/config/CharacterRecommedConfig.lua

module("modules.logic.character.config.CharacterRecommedConfig", package.seeall)

local CharacterRecommedConfig = class("CharacterRecommedConfig", BaseConfig)

function CharacterRecommedConfig:reqConfigNames()
	return {
		"character_recommend",
		"team_recommend"
	}
end

function CharacterRecommedConfig:onInit()
	self._heroConfigDict = {}
end

function CharacterRecommedConfig:onConfigLoaded(configName, configTable)
	if configName == "character_recommend" then
		self._heroConfigDict = configTable.configDict

		self:_initHeroRecommendMap()
		CharacterRecommedModel.instance:initMO()
	end
end

function CharacterRecommedConfig:getAllHeroConfigs()
	return self._heroConfigDict
end

function CharacterRecommedConfig:getHeroConfig(heroId)
	return self._heroConfigDict[heroId]
end

function CharacterRecommedConfig:_initHeroRecommendMap()
	self._heroTeamList = {}
	self._allTeamHeroCoMap = {}

	for _, teamCo in ipairs(lua_team_recommend.configList) do
		local teamHeroCoMap = {}

		for i = 1, math.huge do
			local pos = teamCo["pos" .. i]

			if not pos then
				break
			end

			local heroCoList = GameUtil.splitString2(pos, true)

			if heroCoList then
				for j, heroCo in ipairs(heroCoList) do
					teamHeroCoMap[j] = teamHeroCoMap[j] or {}
					teamHeroCoMap[j][i] = heroCo

					local heroId = heroCo[1]

					self._heroTeamList[heroId] = self._heroTeamList[heroId] or {}

					table.insert(self._heroTeamList[heroId], teamCo)
				end
			end
		end

		self._allTeamHeroCoMap[teamCo.id] = teamHeroCoMap
	end
end

function CharacterRecommedConfig:getTeamHeroCoMap(teamId)
	return self._allTeamHeroCoMap and self._allTeamHeroCoMap[teamId]
end

function CharacterRecommedConfig:getTeamHeroCo(teamId, teamIndex, posIndex)
	local teamHeroCoMap = self:getTeamHeroCoMap(teamId)
	local teamHeroCo = teamHeroCoMap and teamHeroCoMap[teamIndex]

	return teamHeroCo and teamHeroCo[posIndex]
end

function CharacterRecommedConfig:getRecommendTeamListByHeroId(heroId)
	return self._heroTeamList and self._heroTeamList[heroId]
end

CharacterRecommedConfig.instance = CharacterRecommedConfig.New()

return CharacterRecommedConfig
