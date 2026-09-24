-- chunkname: @modules/logic/character/model/recommed/CharacterRecommedTeamGroupMO.lua

module("modules.logic.character.model.recommed.CharacterRecommedTeamGroupMO", package.seeall)

local CharacterRecommedTeamGroupMO = pureTable("CharacterRecommedTeamGroupMO")

function CharacterRecommedTeamGroupMO:init(teamId)
	self._teamId = teamId
	self._teamCo = lua_character_recommend.configDict[teamId]

	self:_initAllTeams()
end

function CharacterRecommedTeamGroupMO:_initAllTeams()
	self._allTeamList = {}
	self._mainTeam = nil
	self._remainTeam = {}
	self._teamHeroCoMap = CharacterRecommedConfig.instance:getTeamHeroCoMap(self._teamId)

	for teamIndex, heroMap in ipairs(self._teamHeroCoMap) do
		local teamMo = CharacterRecommedTeamMO.New()

		teamMo:init(self._teamId, teamIndex, heroMap)
		table.insert(self._allTeamList, teamMo)

		if not self._mainTeam then
			self._mainTeam = teamMo
		else
			table.insert(self._remainTeam, teamMo)
		end
	end
end

function CharacterRecommedTeamGroupMO:checkMainTeam()
	if self._mainTeam then
		local heroList = self._mainTeam:getHeroList()

		if not self._mainTeam then
			return
		end

		local tempReplaceList = {}

		for i, hero in ipairs(self._mainTeam) do
			if not hero:isPlayerChangePos() then
				local replaceTeamIndex

				if hero:isOwnerSourceHero() then
					local sourceHeroInfo = self:_findHeroInfoByHeroId(hero:getSourceHeroId())

					replaceTeamIndex = sourceHeroInfo and sourceHeroInfo:getCurPos()
				else
					local _, posIndex = hero:getCurPos()

					replaceTeamIndex = self:_findOwnerFromRemainTeam(posIndex)
				end

				if replaceTeamIndex then
					tempReplaceList[i] = replaceTeamIndex
				end
			end
		end

		local mainTeamIndex = self._mainTeam:getTeamIndex()

		for i, ownerTeamIndex in pairs(tempReplaceList) do
			self:swapTeamHero(mainTeamIndex, ownerTeamIndex, i, false)
		end
	end
end

function CharacterRecommedTeamGroupMO:_findHeroInfoByHeroId(heroId)
	if not self._allTeamList then
		return
	end

	for _, teamInfo in ipairs(self._allTeamList) do
		local heroInfo = teamInfo:getHeroById(heroId)

		if heroInfo then
			return heroInfo
		end
	end
end

function CharacterRecommedTeamGroupMO:_findOwnerFromRemainTeam(posIndex)
	for i, teamInfo in ipairs(self._remainTeam) do
		local heroInfo = teamInfo:getHero(posIndex)

		if heroInfo and heroInfo:isOwnerHero() then
			return teamInfo:getTeamIndex()
		end
	end
end

function CharacterRecommedTeamGroupMO:getAllTeamList()
	return self._allTeamList
end

function CharacterRecommedTeamGroupMO:getMainTeam()
	return self._mainTeam
end

function CharacterRecommedTeamGroupMO:getRemainTeam()
	return self._remainTeam
end

function CharacterRecommedTeamGroupMO:getTeamByIndex(teamIndex)
	return self._allTeamList[teamIndex]
end

function CharacterRecommedTeamGroupMO:swapTeamHero(teamIndex1, teamIndex2, posIndex, isSave)
	if teamIndex1 == teamIndex2 then
		return
	end

	local teamMo1 = self:getTeamByIndex(teamIndex1)
	local teamMo2 = self:getTeamByIndex(teamIndex2)
	local heroMo1 = teamMo1 and teamMo1:getHero(posIndex)
	local heroMo2 = teamMo2 and teamMo2:getHero(posIndex)
	local dataTeamIndex1, dataPosIndex1 = heroMo1:getData()
	local dataTeamIndex2, dataPosIndex2 = heroMo2:getData()

	teamMo1:replaceHero(posIndex, dataTeamIndex2, dataPosIndex2, isSave)
	teamMo2:replaceHero(posIndex, dataTeamIndex1, dataPosIndex1, isSave)
	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnReplaceTeam)
end

return CharacterRecommedTeamGroupMO
