-- chunkname: @modules/logic/matchgame/model/MatchGameHeroGroupModel.lua

module("modules.logic.matchgame.model.MatchGameHeroGroupModel", package.seeall)

local MatchGameHeroGroupModel = class("MatchGameHeroGroupModel", BaseModel)

function MatchGameHeroGroupModel:onInit()
	self:reInit()
end

function MatchGameHeroGroupModel:reInit()
	self._curTeamId = 1
	self._teamHeroMap = {}
	self._isInitDone = false
	self._editHeroUid = nil
end

function MatchGameHeroGroupModel:initEpisodeId(episodeId)
	self._episodeId = episodeId
end

function MatchGameHeroGroupModel:initTeamList()
	if self._isInitDone then
		return
	end

	local snapshotCount = MatchGameModel.instance:getMaxHeroGroupSnapshotCount()

	for teamId = 1, snapshotCount do
		self:_initTeamHeroMap(teamId)
	end

	self._curTeamId = MatchGameModel.instance:getCurTeamIndex()
	self._isInitDone = true
end

function MatchGameHeroGroupModel:checkTeachTeam()
	self._curTeamId = MatchGameModel.instance:getCurTeamIndex()

	local curEpisodeId = self._episodeId
	local isTeachEpisode = MatchGameConfig.instance:isTeachEpisode(curEpisodeId)

	if not isTeachEpisode then
		self:_initTeamHeroCache()

		return
	end

	local teamId = tonumber(-curEpisodeId)

	if not self._teamHeroMap[teamId] then
		self._teamHeroMap[teamId] = {}

		local trialHeroList = MatchGameConfig.instance:getTrialHeroInfoList(curEpisodeId) or {}

		for i, heroInfo in ipairs(trialHeroList) do
			local heroId = heroInfo[1]
			local level = heroInfo[2]
			local id = tonumber(-heroId)
			local groupMo = MatchGameHeroSingleGroupMo.New()
			local heroMo = MatchGameCharacterMo.New()

			heroMo:initByLocal(heroId, level)
			groupMo:initData(i, id, heroMo)

			self._teamHeroMap[teamId][i] = groupMo
		end
	end

	self._curTeamId = teamId

	self:_initTeamHeroCache()
end

function MatchGameHeroGroupModel:_initTeamHeroCache()
	self._curTeamHeroCache = {}

	local curEpisodeId = self._episodeId
	local maxRoleNum = MatchGameConfig.instance:getEpisodeRoleNum(curEpisodeId)
	local heroMap = self:getCurTeamHeroes(true)

	for i = 1, maxRoleNum do
		local singleMo = heroMap and heroMap[i]

		if singleMo then
			self._curTeamHeroCache[i] = singleMo
		end
	end
end

function MatchGameHeroGroupModel:getCurTeamId()
	return self._curTeamId
end

function MatchGameHeroGroupModel:getCurTeamHeroes(source)
	if source then
		return self._teamHeroMap[self._curTeamId]
	end

	return self._curTeamHeroCache
end

function MatchGameHeroGroupModel:isInCurTeam(heroId)
	local teamHeroes = self:getCurTeamHeroes()

	if teamHeroes then
		for posIndex, singleMo in pairs(teamHeroes) do
			if singleMo and singleMo.id == heroId then
				return true, posIndex
			end
		end
	end

	return false, 0
end

function MatchGameHeroGroupModel:getTeamHeroes(teamId)
	return self._teamHeroMap[teamId]
end

function MatchGameHeroGroupModel:getCurTeamTotalHp()
	local totalHp = 0
	local teamHeroes = self:getCurTeamHeroes()

	if teamHeroes then
		for _, singleMo in pairs(teamHeroes) do
			local hp = singleMo:getTotalAttrValue(MatchGameEnum.CharacterAttrType.Hp)

			totalHp = totalHp + hp
		end
	end

	return totalHp
end

function MatchGameHeroGroupModel:getCurTeamCharacterCount()
	local teamHeroes = self:getCurTeamHeroes()
	local heroCount = 0

	if teamHeroes then
		for _, heroMo in pairs(teamHeroes) do
			if heroMo:hasHero() then
				heroCount = heroCount + 1
			end
		end
	end

	return heroCount
end

function MatchGameHeroGroupModel:_initTeamHeroMap(teamId)
	self._teamHeroMap[teamId] = self._teamHeroMap[teamId] or {}

	local teamMo = MatchGameModel.instance:getTeamMo(teamId)

	if teamMo and teamMo.heroIds then
		for posIndex, heroId in ipairs(teamMo.heroIds) do
			self:_updateSingleGroupMo(teamId, posIndex, heroId)
		end
	end

	if teamId == self._curTeamId then
		self:_initTeamHeroCache()
	end
end

function MatchGameHeroGroupModel:_updateSingleGroupMo(teamId, posIndex, heroId)
	local singleMo = self._teamHeroMap[teamId][posIndex]

	if not singleMo then
		singleMo = MatchGameHeroSingleGroupMo.New()
		self._teamHeroMap[teamId][posIndex] = singleMo
	end

	if heroId then
		::label_14_0::

		local heroMo = MatchGameModel.instance:getCharacterMo(heroId)

		singleMo:initData(posIndex, heroId, heroMo)
	end
end

function MatchGameHeroGroupModel:onModifyTeamSuccess(teamId)
	self:_initTeamHeroMap(teamId)
	self:_initTeamHeroCache()
	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnSaveTeamSuccess, teamId)
end

function MatchGameHeroGroupModel:onSwitchTeamSuccess()
	self._curTeamId = MatchGameModel.instance:getCurTeamIndex()

	self:_initTeamHeroCache()
	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnSwitchTeam)
end

function MatchGameHeroGroupModel:setCurEditPosHeroUid(heroUid)
	self._editHeroUid = heroUid
end

function MatchGameHeroGroupModel:getCurEditPosHeroUid()
	return self._editHeroUid
end

MatchGameHeroGroupModel.instance = MatchGameHeroGroupModel.New()

return MatchGameHeroGroupModel
