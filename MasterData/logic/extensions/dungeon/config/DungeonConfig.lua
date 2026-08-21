-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/config/DungeonConfig.lua

module("logic.extensions.dungeon.config.DungeonConfig", package.seeall)

local M = class("DungeonConfig", BaseConfig)

function M:onInit()
	self._cfgDungeon = false
	self._cfgDungeonStar = false
	self._cfgDungeonScore = false
	self._cfgDungeonType = false
	self._cfgDungeonMainLineChapter = false
	self._cfgDungeonMaterialChapter = false
	self._cfgMaterialDungeon = false
	self._cfgMaterialDepthPos = false
	self._cfgTeachingChapter = false
	self._cfgTeachingDungeon = false
	self._cfgDungeonStarCOWrapper = {}
	self._cfgDungeonMainlineUnlock = false
	self._cfgDungeonMainlinePlot = false
	self._cfgDoomForecastCharacterName = false
	self._chapterId2ChapterCO = {}
end

function M:getNames()
	return {
		ConfigName.Dungeon,
		ConfigName.DungeonStar,
		ConfigName.DungeonType,
		ConfigName.DungeonScoreAssessment,
		ConfigName.DungeonMainLineChapter,
		ConfigName.DungeonMaterialChapter,
		ConfigName.MaterialDungeon,
		ConfigName.MaterialDungeonDepthPos,
		ConfigName.TeachingChapter,
		ConfigName.TeachingDungeon,
		ConfigName.DungeonMainlineUnlock,
		ConfigName.DungeonMainlinePlot,
		ConfigName.DoomForecastCharacterName
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.Dungeon then
		self._cfgDungeon = content
	elseif name == ConfigName.DungeonStar then
		self._cfgDungeonStar = content
	elseif name == ConfigName.DungeonType then
		self._cfgDungeonType = content
	elseif name == ConfigName.DungeonScoreAssessment then
		self._cfgDungeonScore = content
	elseif name == ConfigName.DungeonMainLineChapter then
		self._cfgDungeonMainLineChapter = content

		self:_addChapterId2CO(CommEnum.DungeonType.Mainline, content)
	elseif name == ConfigName.DungeonMaterialChapter then
		self._cfgDungeonMaterialChapter = content

		self:_addChapterId2CO(CommEnum.DungeonType.Material, content)
	elseif name == ConfigName.MaterialDungeon then
		self._cfgMaterialDungeon = content
	elseif name == ConfigName.MaterialDungeonDepthPos then
		self._cfgMaterialDepthPos = content
	elseif name == ConfigName.TeachingChapter then
		self._cfgTeachingChapter = content
	elseif name == ConfigName.TeachingDungeon then
		self._cfgTeachingDungeon = content
	elseif name == ConfigName.DungeonMainlineUnlock then
		self._cfgDungeonMainlineUnlock = content
	elseif name == ConfigName.DungeonMainlinePlot then
		self._cfgDungeonMainlinePlot = content
	elseif name == ConfigName.DoomForecastCharacterName then
		self._cfgDoomForecastCharacterName = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:_chaperTypeId2Key(chapterType, chapterId)
	return chapterType .. "_" .. tostring(chapterId)
end

function M:_addChapterId2CO(chapterType, chapterContent)
	for _, data in ipairs(chapterContent.dataList) do
		local key = self:_chaperTypeId2Key(chapterType, data.chapterId)

		self._chapterId2ChapterCO[key] = data
	end
end

function M:getCfgMainLineChapter()
	return self._cfgDungeonMainLineChapter.dataList
end

function M:getCfgMainLineByChapterId(chapterId)
	return self._cfgDungeonMainLineChapter[chapterId]
end

function M:getCfgMainLineChapterIncludePlot(dungeonId)
	for _, v in ipairs(self._cfgDungeonMainLineChapter.dataList) do
		if TableUtil.contains(v.dungeonIds, dungeonId) then
			return v
		end

		if v.branchlineDungeonIds then
			for _, k in ipairs(v.branchlineDungeonIds) do
				if TableUtil.contains(k, dungeonId) then
					return v
				end
			end
		end
	end

	return nil
end

function M:getCfgMainLineChapterByDungeonId(dungeonId)
	local isChapter = math.floor(dungeonId / 10000) == 11

	if isChapter then
		local difficulty = dungeonId % 10000
		local chapterId = math.floor(difficulty / 100)

		difficulty = math.floor((difficulty % 100 - 1) / 30) + 1
		difficulty = difficulty > 2 and 3 or difficulty

		local list = self._cfgDungeonMainLineChapter.dataList

		for _, v in ipairs(list) do
			if v.chapterId == chapterId and v.difficulty == difficulty then
				return v
			end
		end
	end

	return nil
end

function M:getCfgMaterialChapter()
	return self._cfgDungeonMaterialChapter.dataList
end

function M:getCfgTeachingChapter()
	return self._cfgTeachingChapter.dataList
end

function M:getTeachingDungeonCOByDungeonId(dungeonId)
	return self._cfgTeachingDungeon[dungeonId]
end

function M:getMainlineDungeonUnlockCOByDungeonId(dungeonId)
	return self._cfgDungeonMainlineUnlock[dungeonId]
end

function M:getMainlineDungeonUnlockCOByDungeonList()
	return self._cfgDungeonMainlineUnlock.dataList
end

function M:getDungeonHardModeId(dungeonId)
	local cfg = self:getMainlineDungeonUnlockCOByDungeonId(dungeonId)

	return cfg.hardId
end

function M:getMainlineDungeonUnlockCOByAnswer(answer)
	local hasFind = false

	for _, dungeonUnlockCO in pairs(self._cfgDungeonMainlineUnlock.dataList) do
		if dungeonUnlockCO.unlockCondition then
			for i, v in ipairs(dungeonUnlockCO.unlockCondition) do
				if v.type == "plot" and v.value == answer then
					hasFind = true

					break
				end
			end
		end
	end

	return hasFind
end

function M:getMainlinePlotDungeonCOByDungeonId(dungeonId)
	return self._cfgDungeonMainlinePlot[dungeonId]
end

function M:getMaterialDungeonCfgByMaterialDungoenId(materialDungeonId)
	return self._cfgMaterialDungeon[materialDungeonId]
end

function M:getCfgMaterialDungeon()
	return self._cfgMaterialDungeon.dataList
end

function M:getDungeonCfgById(dungeonId)
	local dungeonCO = self._cfgDungeon[dungeonId]

	return dungeonCO
end

function M:getDungeonStarByCode(code)
	local starCo = self._cfgDungeonStar[code]

	return starCo
end

function M:getMaterialDepthPosCO(index)
	return self._cfgMaterialDepthPos[index]
end

function M:getDungeonStarCOWrapper(code)
	local dungeonStarCOWrapper = self._cfgDungeonStarCOWrapper[code]

	if not dungeonStarCOWrapper then
		local dungeonStarCO = self:getDungeonStarByCode(code)

		dungeonStarCOWrapper = dungeonStarCO and DungeonStarCOWrapper.New(dungeonStarCO) or false
		self._cfgDungeonStarCOWrapper[code] = dungeonStarCOWrapper
	end

	return dungeonStarCOWrapper
end

function M:getDungeonScoreCOByScore(score, group)
	group = group or 101

	if score == 0 then
		return self._cfgDungeonScore[group][1]
	end

	local index = 2
	local scoreCo

	while self._cfgDungeonScore[group][index] and index < 99 do
		scoreCo = self._cfgDungeonScore[group][index]

		if score < scoreCo.scoreRange[1] then
			return self._cfgDungeonScore[group][index - 1]
		elseif scoreCo.scoreRange[2] == "max" then
			return self._cfgDungeonScore[group][index]
		elseif score <= scoreCo.scoreRange[2] then
			return self._cfgDungeonScore[group][index]
		end

		index = index + 1
	end
end

function M:getDoomForecastCharacterNameCO(code)
	return self._cfgDoomForecastCharacterName[code]
end

function M:getDungeonCodeByLevelCode(levelCode)
	local dataList = self._cfgDungeon.dataList

	for _, dungeonCO in ipairs(dataList) do
		if dungeonCO.levelID == levelCode then
			return dungeonCO.id
		end
	end

	return false
end

function M:getChapterCO(chapterType, chapterId)
	local key = self:_chaperTypeId2Key(chapterType, chapterId)

	return self._chapterId2ChapterCO[key]
end

function M:getDungeonIdByStoryId(storeyId)
	if not self._dungeonIds then
		self._dungeonIds = {}

		local dataList = self._cfgDungeon.dataList

		for _, dungeonCO in ipairs(dataList) do
			if dungeonCO.plotBeforeBattle ~= 0 then
				self._dungeonIds[dungeonCO.plotBeforeBattle] = dungeonCO.id
			end

			if dungeonCO.plotAfterReady ~= 0 then
				self._dungeonIds[dungeonCO.plotAfterReady] = dungeonCO.id
			end

			if dungeonCO.plotAfterBattle ~= 0 then
				self._dungeonIds[dungeonCO.plotAfterBattle] = dungeonCO.id
			end
		end
	end

	return self._dungeonIds[storeyId] or 0
end

function M:getDungeonTypeName(dungeonType)
	return self._cfgDungeonType[dungeonType] and self._cfgDungeonType[dungeonType].name or nil
end

function M:getCanRechallenge(dungeonType)
	return self._cfgDungeonType[dungeonType] and self._cfgDungeonType[dungeonType].reChallenge == 1 or false
end

M.instance = M.New()

return M
