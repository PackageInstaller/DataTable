-- chunkname: @modules/logic/character/model/recommed/CharacterRecommedHeroMO.lua

module("modules.logic.character.model.recommed.CharacterRecommedHeroMO", package.seeall)

local CharacterRecommedHeroMO = pureTable("CharacterRecommedHeroMO")

function CharacterRecommedHeroMO:init(teamId, teamIndex, posIndex)
	self._teamId = teamId
	self._teamIndex = teamIndex
	self._posIndex = posIndex
	self._sourceHeroInfo = CharacterRecommedConfig.instance:getTeamHeroCo(self._teamId, self._teamIndex, self._posIndex)

	if self._sourceHeroInfo then
		self._sourceHeroId = self._sourceHeroInfo[1] or 0
	end
end

function CharacterRecommedHeroMO:updateData(dataTeamIndex, dataPosIndex, isPrefs)
	if self._dataTeamIndex == dataTeamIndex and self._dataPosIndex == dataPosIndex then
		return
	end

	self._isPrefs = isPrefs
	self._dataTeamIndex = dataTeamIndex
	self._dataPosIndex = dataPosIndex
	self._heroInfo = CharacterRecommedConfig.instance:getTeamHeroCo(self._teamId, self._dataTeamIndex, self._dataPosIndex)
	self._heroId = self._heroInfo and self._heroInfo[1]
	self._destinyId = self._heroInfo and self._heroInfo[2]
end

function CharacterRecommedHeroMO:getData()
	return self._dataTeamIndex, self._dataPosIndex
end

function CharacterRecommedHeroMO:getHeroId()
	return self._heroId
end

function CharacterRecommedHeroMO:getSourceHeroId()
	return self._sourceHeroId
end

function CharacterRecommedHeroMO:getDestinyId()
	return self._destinyId
end

function CharacterRecommedHeroMO:getCurPos()
	return self._teamIndex, self._posIndex
end

function CharacterRecommedHeroMO:isPlayerChangePos()
	return self._isPrefs
end

function CharacterRecommedHeroMO:isSwapHero()
	return self._teamIndex ~= self._dataTeamIndex or self._posIndex ~= self._dataPosIndex
end

function CharacterRecommedHeroMO:isOwnerHero()
	return HeroModel.instance:getByHeroId(self._heroId) ~= nil
end

function CharacterRecommedHeroMO:isOwnerSourceHero()
	return HeroModel.instance:getByHeroId(self._sourceHeroId) ~= nil
end

return CharacterRecommedHeroMO
