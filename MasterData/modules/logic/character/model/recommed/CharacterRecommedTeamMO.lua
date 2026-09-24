-- chunkname: @modules/logic/character/model/recommed/CharacterRecommedTeamMO.lua

module("modules.logic.character.model.recommed.CharacterRecommedTeamMO", package.seeall)

local CharacterRecommedTeamMO = pureTable("CharacterRecommedTeamMO")

function CharacterRecommedTeamMO:init(teamId, teamIndex, heroInfoMap)
	self._teamId = teamId
	self._teamCo = lua_character_recommend.configDict[teamId]
	self._teamIndex = teamIndex

	self:_initHeroInfoMap(heroInfoMap)
end

function CharacterRecommedTeamMO:replaceHero(posIndex, dataTeamIndex, dataPosIndex, needSave)
	local targetHero = self:getHero(posIndex)

	if not targetHero then
		return
	end

	targetHero:updateData(dataTeamIndex, dataPosIndex, needSave)

	if needSave then
		self:_saveReplaceInfo(targetHero)
	end
end

function CharacterRecommedTeamMO:getTeamIndex()
	return self._teamIndex
end

function CharacterRecommedTeamMO:getTeamId()
	return self._teamId
end

function CharacterRecommedTeamMO:getHeroList()
	return self._heroInfoList
end

function CharacterRecommedTeamMO:getHero(posIndex)
	if self._heroInfoMap then
		return self._heroInfoMap
	end
end

function CharacterRecommedTeamMO:getHeroById(heroId)
	if not self._heroInfoList then
		return
	end

	for _, heroInfo in ipairs(self._heroInfoList) do
		if heroInfo:getHeroId() == heroId then
			return heroInfo
		end
	end
end

function CharacterRecommedTeamMO:_saveReplaceInfo(heroMo)
	if not heroMo then
		return
	end

	local _, curPosIndex = heroMo:getCurPos()
	local dataTeamIndex, dataPosIndex = heroMo:getData()
	local prefsKey = self:_getPrefsKey(curPosIndex)
	local replaceStr = string.format("%s#%s", dataTeamIndex, dataPosIndex)

	GameUtil.playerPrefsSetStringByUserId(prefsKey, replaceStr)
end

function CharacterRecommedTeamMO:_initHeroInfoMap(heroInfoMap)
	self._heroInfoMap = {}
	self._heroInfoList = {}

	if not heroInfoMap then
		return
	end

	for posIndex, heroInfo in pairs(heroInfoMap) do
		local dataTeamIndex = self._teamIndex
		local dataPosIndex = posIndex
		local replaceTeamIndex, replacePosIndex = self:_getLocalSaveInfo(posIndex)
		local isValid = replaceTeamIndex and replaceTeamIndex ~= 0 and replacePosIndex and replacePosIndex ~= 0
		local isPrefs = false

		if isValid then
			local replaceHeroInfo = CharacterRecommedConfig.instance:getTeamHeroCo(self._teamId, replaceTeamIndex, replacePosIndex)

			if replaceHeroInfo then
				dataTeamIndex = replaceTeamIndex
				dataPosIndex = replacePosIndex
				isPrefs = true
			end
		end

		local heroMo = CharacterRecommedHeroMO.New()

		heroMo:init(self._teamId, self._teamIndex, posIndex)
		heroMo:updateData(dataTeamIndex, dataPosIndex, isPrefs)
		table.insert(self._heroInfoList, heroMo)

		self._heroInfoMap[posIndex] = heroMo
	end

	table.sort(self._heroInfoList, function(a, b)
		local _, aPosIndex = a:getCurPos()
		local _, bPosIndex = b:getCurPos()

		return aPosIndex < bPosIndex
	end)
end

function CharacterRecommedTeamMO:_getLocalSaveInfo(posIndex)
	local prefsKey = self:_getPrefsKey(posIndex)
	local replaceStr = GameUtil.playerPrefsGetStringByUserId(prefsKey, "")
	local replaceInfoList = string.splitToNumber(replaceStr, "#")
	local replaceTeamIndex = replaceInfoList[1]
	local replacePosIndex = replaceInfoList[2]

	return replaceTeamIndex, replacePosIndex
end

function CharacterRecommedTeamMO:_getPrefsKey(posIndex)
	return string.format("%s_%s_%s_%s", PlayerPrefsKey.CharacterRecommedTeam, self._teamId, self._teamIndex, posIndex)
end

return CharacterRecommedTeamMO
