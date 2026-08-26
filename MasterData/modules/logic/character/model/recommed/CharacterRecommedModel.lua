-- chunkname: @modules/logic/character/model/recommed/CharacterRecommedModel.lua

module("modules.logic.character.model.recommed.CharacterRecommedModel", package.seeall)

local CharacterRecommedModel = class("CharacterRecommedModel", BaseModel)

function CharacterRecommedModel:onInit()
	self:reInit()
end

function CharacterRecommedModel:reInit()
	return
end

function CharacterRecommedModel:initMO(configDict)
	self._heroRecommendMos = {}

	if not configDict then
		return
	end

	for heroId, config in pairs(configDict) do
		local heroRecommendMO = CharacterRecommedMO.New()

		heroRecommendMO:init(config)

		self._heroRecommendMos[heroId] = heroRecommendMO
	end
end

function CharacterRecommedModel:getAllHeroRecommendMos()
	return self._heroRecommendMos
end

function CharacterRecommedModel:isShowRecommedView(heroId)
	local mo = self:getHeroRecommendMo(heroId)

	return mo ~= nil
end

function CharacterRecommedModel:getHeroRecommendMo(heroId)
	if not self._heroRecommendMos then
		return
	end

	return self._heroRecommendMos[heroId]
end

function CharacterRecommedModel:initTracedHeroDevelopGoalsMO()
	local value = GameUtil.playerPrefsGetStringByUserId(CharacterRecommedEnum.TraceHeroPref, "")

	if string.nilorempty(value) then
		self._heroDevelopGoalsMO = nil
	else
		local split = string.splitToNumber(value, "_")
		local heroId = split[1]
		local type = split[2]
		local mo = self:getHeroRecommendMo(heroId)
		local heroDevelopGoalsMO = mo and mo:getDevelopGoalsMO(type)

		if heroDevelopGoalsMO then
			heroDevelopGoalsMO:setTraced(true)
		end

		self._heroDevelopGoalsMO = heroDevelopGoalsMO
	end
end

function CharacterRecommedModel:getTracedHeroDevelopGoalsMO()
	return self._heroDevelopGoalsMO
end

function CharacterRecommedModel:setTracedHeroDevelopGoalsMO(mo)
	if self._heroDevelopGoalsMO == mo then
		return
	end

	if self._heroDevelopGoalsMO then
		self._heroDevelopGoalsMO:setTraced(false)
	end

	self._heroDevelopGoalsMO = mo

	local preValue = mo and string.format("%s_%s", mo._heroId, mo._developGoalsType) or ""

	GameUtil.playerPrefsSetStringByUserId(CharacterRecommedEnum.TraceHeroPref, preValue)
	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnRefreshTraced)
end

function CharacterRecommedModel:isTradeChapter(chapterId)
	local item = self:getChapterTracedItem(chapterId)

	if item then
		return true
	end

	return self:getChapterTradeEpisodeId(chapterId) ~= nil
end

function CharacterRecommedModel:isTradeEpisode(episodeId)
	local item = self:getEpisodeTracedItem(episodeId)

	if item then
		return true
	end

	local hardEpisode = DungeonConfig.instance:getHardEpisode(episodeId)

	if hardEpisode then
		local hardItem = self:getEpisodeTracedItem(hardEpisode.id)

		if hardItem then
			return true
		end
	end

	return false
end

function CharacterRecommedModel:getEpisodeOrChapterTracedItem(episodeId)
	local item = self:getEpisodeTracedItem(episodeId)

	if not item then
		local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

		item = self:getChapterTracedItem(episodeCO.chapterId)
	end

	return item
end

function CharacterRecommedModel:getChapterTracedItem(chapterId)
	if not self._heroDevelopGoalsMO then
		return
	end

	local tracedItems = self._heroDevelopGoalsMO:getTracedItems()

	if not tracedItems or #tracedItems == 0 then
		return
	end

	for _, item in ipairs(tracedItems) do
		local bestSource = self:getBestSource(item.materilType, item.materilId)

		if bestSource and bestSource.chapterId == chapterId then
			return item
		end
	end
end

function CharacterRecommedModel:getEpisodeTracedItem(episodeId)
	if not self._heroDevelopGoalsMO then
		return
	end

	local tracedItems = self._heroDevelopGoalsMO:getTracedItems()

	if not tracedItems or #tracedItems == 0 then
		return
	end

	for _, item in ipairs(tracedItems) do
		local bestSource = self:getBestSource(item.materilType, item.materilId)

		if bestSource and bestSource.episodeId == episodeId then
			return item
		end
	end
end

function CharacterRecommedModel:getChapterTradeEpisodeId(chapterId)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	if episodeList then
		for _, episodeCo in ipairs(episodeList) do
			if self:isTradeEpisode(episodeCo.id) then
				return episodeCo.id
			end
		end
	end
end

function CharacterRecommedModel:_getItemSourceList(materilType, materilId)
	self._itemSourceDict = self._itemSourceDict or {}
	self._itemSourceDict[materilType] = self._itemSourceDict[materilType] or {}

	local list = self._itemSourceDict[materilType][materilId]

	if not list then
		list = DungeonConfig.instance:getMaterialSource(materilType, materilId) or {}

		local itemCo = ItemConfig.instance:getItemConfig(materilType, materilId)

		if not string.nilorempty(itemCo.sources) then
			local sources = string.split(itemCo.sources, "|")

			for i, source in ipairs(sources) do
				local sourceParam = string.splitToNumber(source, "#")
				local sourceTable = {}
				local sourceId = sourceParam[1]

				if sourceId then
					local jumpCo = JumpConfig.instance:getJumpConfig(sourceId)
					local jumpParam = string.splitToNumber(jumpCo.param, "#")

					if jumpParam[1] == JumpEnum.JumpView.DungeonViewWithChapter then
						sourceTable.chapterId = jumpParam[2]
						sourceTable.probability = sourceParam[2] or 0
					elseif jumpParam[1] == JumpEnum.JumpView.DungeonViewWithEpisode then
						sourceTable.episodeId = jumpParam[2]
						sourceTable.probability = sourceParam[2] or 0
					end

					table.insert(list, sourceTable)
				end
			end
		end

		self._itemSourceDict[materilType][materilId] = list
	end

	return list
end

function CharacterRecommedModel:getBestSource(materilType, materilId)
	local sourceList = self:_getItemSourceList(materilType, materilId)
	local bestSource

	if sourceList then
		for _, source in ipairs(sourceList) do
			if source.chapterId and DungeonController.instance:canJumpDungeonChapter(source.chapterId) then
				if bestSource then
					if bestSource.probability > source.probability then
						bestSource = source
					elseif bestSource.probability == source.probability and bestSource.chapterId < source.chapterId then
						bestSource = source
					end
				else
					bestSource = source
				end
			end

			if source.episodeId and DungeonModel.instance:hasPassLevel(source.episodeId) then
				if bestSource then
					if bestSource.probability > source.probability then
						bestSource = source
					elseif bestSource.probability == source.probability and bestSource.episodeId < source.episodeId then
						bestSource = source
					end
				else
					bestSource = source
				end
			end
		end
	end

	return bestSource
end

function CharacterRecommedModel:isTradeStory()
	if not self._heroDevelopGoalsMO then
		return
	end

	for i, v in ipairs(lua_chapter_divide.configList) do
		local isTrade = CharacterRecommedModel.instance:isTradeSection(v.sectionId)

		if isTrade then
			return true
		end
	end
end

function CharacterRecommedModel:isTradeSection(sectionId)
	if not self._heroDevelopGoalsMO then
		return
	end

	local chapterList = DungeonMainStoryModel.instance:getChapterList(sectionId)

	if chapterList then
		for _, characterCo in ipairs(chapterList) do
			if self:isTradeChapter(characterCo.id) then
				return true
			end
		end
	end
end

function CharacterRecommedModel:isTradeResDungeon()
	if not self._heroDevelopGoalsMO then
		return
	end

	for type, params in pairs(CharacterRecommedEnum.ResDungeon) do
		if OpenModel.instance:isFuncBtnShow(params.UnlockFunc) then
			local config = DungeonConfig.instance:getChapterCO(type)

			if self:isTradeChapter(config.id) then
				return true
			end
		end
	end
end

function CharacterRecommedModel:isTradeRankResDungeon()
	if not self._heroDevelopGoalsMO then
		return
	end

	for _, type in pairs(CharacterRecommedEnum.RankResDungeon) do
		if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon) then
			local config = DungeonConfig.instance:getChapterCO(type)

			if self:isTradeChapter(config.id) then
				return true
			end
		end
	end
end

function CharacterRecommedModel:getHeroName(name, size)
	self._heroName = self._heroName or {}

	local heroName = self._heroName[name]

	if not heroName and not string.nilorempty(name) then
		local ucharArr = LuaUtil.getUCharArr(name)

		if ucharArr then
			heroName = ""

			for i = 2, #ucharArr do
				heroName = heroName .. ucharArr[i]
			end

			size = size or 52
			heroName = ucharArr[1] .. string.format("<size=%s>%s</size>", size, heroName)
			self._heroName[name] = heroName
		end
	end

	return heroName
end

CharacterRecommedModel.instance = CharacterRecommedModel.New()

return CharacterRecommedModel
