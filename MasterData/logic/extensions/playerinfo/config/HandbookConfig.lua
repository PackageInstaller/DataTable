-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/config/HandbookConfig.lua

module("logic.extensions.playerinfo.config.HandbookConfig", package.seeall)

local M = class("HandbookConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.GalleryCg,
		ConfigName.GalleryConstant,
		ConfigName.GalleryEchoItem,
		ConfigName.GalleryProtomer,
		ConfigName.GalleryMonster,
		ConfigName.GalleryCommentTag,
		ConfigName.GalleryEvent,
		ConfigName.GalleryWord,
		ConfigName.GalleryWordTyp,
		ConfigName.GalleryMusic,
		ConfigName.GalleryPlotTab,
		ConfigName.GalleryPlotMemory,
		ConfigName.GalleryEventTime,
		ConfigName.GalleryCampInfo,
		ConfigName.GalleryOrganisationInfo,
		ConfigName.GalleryHero,
		ConfigName.HeroRelation,
		ConfigName.HeroRelationTyp
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.GalleryPlotTab then
		for _, cfg in pairs(content.dataList or {}) do
			if not self._cfgPlotTab then
				self._cfgPlotTab = {}
			end

			if not self._cfgPlotTab[cfg.id] then
				self._cfgPlotTab[cfg.id] = {}
			end

			self._cfgPlotTab[cfg.id][cfg.page] = cfg
		end
	elseif name == ConfigName.HeroRelation then
		for _, cfg in pairs(content.dataList or {}) do
			if not self._heroId2Relation then
				self._heroId2Relation = {}
			end

			if not self._heroId2Relation[cfg.heroId] then
				self._heroId2Relation[cfg.heroId] = {}
			end

			if not self._heroId2Relation[cfg.heroId][cfg.targetId] then
				self._heroId2Relation[cfg.heroId][cfg.targetId] = {}
			end

			table.insert(self._heroId2Relation[cfg.heroId][cfg.targetId], cfg)
		end
	elseif name == ConfigName.HeroRelationTyp then
		self._heroRelationTyp = {}

		for _, cfg in pairs(content.dataList or {}) do
			self._heroRelationTyp[cfg.id] = cfg.priority
		end
	end
end

function M:getConst(key)
	local data = self:getConfig(ConfigName.GalleryConstant)

	return data[key]
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s, key %s", cfgName, key))
end

function M:getEntriesTypTitle(entriesTyp)
	local cfg = self:getConfigByKey(ConfigName.GalleryWordTyp, entriesTyp)

	return cfg and cfg.name or "???"
end

function M:getMaxNum(galleryTypeEnum)
	if not self._maxNum then
		self._maxNum = {}
	end

	if not self._maxNum[galleryTypeEnum] then
		local dataLst

		if galleryTypeEnum == GameEnum.UnlockTypeEnum.Hero then
			dataLst = self:getConfigList(ConfigName.GalleryHero)
		elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.Monster then
			dataLst = self:getConfigList(ConfigName.GalleryMonster)
		elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.CG then
			dataLst = self:getConfigList(ConfigName.GalleryCg)
		elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.Music then
			dataLst = self:getConfigList(ConfigName.GalleryMusic)
		elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.PlotMemory then
			dataLst = self:getConfigList(ConfigName.GalleryPlotMemory)
		elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.Event then
			dataLst = self:getConfigList(ConfigName.GalleryEvent)
		elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.Word then
			dataLst = self:getConfigList(ConfigName.GalleryWord)
		elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.Protomer then
			dataLst = self:getConfigList(ConfigName.GalleryProtomer)
		elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.EchoItem then
			dataLst = self:getConfigList(ConfigName.GalleryEchoItem)
		elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.HeroRelation then
			dataLst = self:getConfigList(ConfigName.HeroRelation)
		end

		self._maxNum[galleryTypeEnum] = dataLst and #dataLst or 0
	end

	return self._maxNum[galleryTypeEnum]
end

function M:getAllUnlockTyp()
	if not self._allUnlockTyp then
		self._allUnlockTyp = {
			GameEnum.UnlockTypeEnum.Hero,
			GameEnum.UnlockTypeEnum.Monster,
			GameEnum.UnlockTypeEnum.CG,
			GameEnum.UnlockTypeEnum.Music,
			GameEnum.UnlockTypeEnum.PlotMemory,
			GameEnum.UnlockTypeEnum.Event,
			GameEnum.UnlockTypeEnum.Word,
			GameEnum.UnlockTypeEnum.Protomer,
			GameEnum.UnlockTypeEnum.EchoItem,
			GameEnum.UnlockTypeEnum.HeroRelation
		}
	end

	return self._allUnlockTyp
end

function M:getAllTypMaxCount()
	if not self._allTypMaxNum then
		self._allTypMaxNum = 0

		for _, typVal in ipairs(self:getAllUnlockTyp()) do
			self._allTypMaxNum = self._allTypMaxNum + self:getMaxNum(typVal)
		end
	end

	return self._allTypMaxNum
end

function M:getPlotTabs(plotTyp)
	if self._cfgPlotTab[plotTyp] then
		return self._cfgPlotTab[plotTyp]
	end

	printError(string.format("无法从t_%s中获取id为[%s]的数据", ConfigName.GalleryPlotTab, plotTyp))

	return nil
end

function M:getPlotTab(plotTyp, page)
	local tabs = self:getPlotTabs(plotTyp)

	if tabs and tabs[page] then
		return tabs[page]
	end

	printError(string.format("无法从t_%s中获取id为[%s],page[%s]的数据", ConfigName.GalleryPlotTab, plotTyp, page))
end

function M:getPlotIdsMemory()
	if not self._plotIdsMemory then
		self._plotIdsMemory = self:_getPlotIdsByTyp(1)
	end

	return self._plotIdsMemory
end

function M:getPlotIdsOutOfChapter()
	if not self._plotIdsOutOfChapter then
		self._plotIdsOutOfChapter = self:_getPlotIdsByTyp(2)
	end

	return self._plotIdsOutOfChapter
end

function M:getPlotIdsActivity()
	if not self._plotIdsActivity then
		self._plotIdsActivity = self:_getPlotIdsByTyp(3)
	end

	return self._plotIdsActivity
end

function M:_getPlotIdsByTyp(typ)
	local theTable = {}
	local cfgLst = self:getConfigList(ConfigName.GalleryPlotMemory)

	if cfgLst and #cfgLst > 0 then
		for _, cfg in ipairs(cfgLst) do
			if cfg.typ == typ then
				table.insert(theTable, cfg.id)
			end
		end
	end

	return theTable
end

function M:getCampHeroIds(camp)
	if not self._campHeroIds then
		self._campHeroIds = {}

		local cfgLst = self:getConfigList(ConfigName.GalleryHero)

		if cfgLst and #cfgLst > 0 then
			for _, cfg in ipairs(cfgLst) do
				local cfgHero = CharacterConfig.instance:getCharacterItemInfo(cfg.id)

				if cfgHero then
					local _camp = cfgHero.camp

					if not self._campHeroIds[_camp] then
						self._campHeroIds[_camp] = {}
					end

					table.insert(self._campHeroIds[_camp], cfg.id)
				end
			end
		end
	end

	return self._campHeroIds[camp] or {}
end

function M:getHeroRelation(heroId)
	if not self._heroRelation then
		self._heroRelation = {}
	end

	if not self._heroRelation[heroId] then
		self._heroRelation[heroId] = HandbookHeroRelationCO.New(heroId, self._heroId2Relation[heroId])
	end

	self._heroRelation[heroId]:update()

	return self._heroRelation[heroId]
end

function M:getHeroRelationIds(heroId)
	local _heroRelationsCO = self:getHeroRelation(heroId)

	return _heroRelationsCO:getHeroRelationsIds()
end

function M:getHeroToOtherHeroRelation(heroId, targetHeroId)
	local _heroRelationsCO = self:getHeroRelation(heroId)

	return _heroRelationsCO:getHeroRelation(targetHeroId)
end

function M:getWordIdsByTyp(wordTyp)
	if not self._wordTypIds then
		self._wordTypIds = {}

		local cfgLst = HandbookConfig.instance:getConfigList(ConfigName.GalleryWord)

		table.sort(cfgLst, function(cfgA, cfgB)
			if cfgA.typ ~= cfgB.typ then
				return cfgA.typ < cfgB.typ
			end

			if cfgA.sortType ~= cfgB.sortType then
				return cfgA.sortType > cfgB.sortType
			end

			return cfgA.id < cfgB.id
		end)

		for index, cfg in ipairs(cfgLst) do
			if not self._wordTypIds[cfg.typ] then
				self._wordTypIds[cfg.typ] = {}
			end

			table.insert(self._wordTypIds[cfg.typ], cfg.id)
		end
	end

	return self._wordTypIds[wordTyp] or {}
end

function M:getHeroRelationTyp()
	return self._heroRelationTyp
end

function M:getRecordIdsEvent()
	if not self._recordIdsEvent then
		self._recordIdsEvent = self:_getRecordIdsByTyp(1)
	end

	return self._recordIdsEvent
end

function M:getRecordIdsTranscendency()
	if not self._recordIdsTranscendency then
		self._recordIdsTranscendency = self:_getRecordIdsByTyp(2)
	end

	return self._recordIdsTranscendency
end

function M:_getRecordIdsByTyp(typ)
	local theTable = {}
	local cfgLst = self:getConfigList(ConfigName.GalleryEvent)

	if cfgLst and #cfgLst > 0 then
		for _, cfg in ipairs(cfgLst) do
			if cfg.typ == typ then
				table.insert(theTable, cfg.id)
			end
		end

		if #theTable > 0 then
			table.sort(theTable, function(a, b)
				local cfgA = self:getConfigByKey(ConfigName.GalleryEvent, a)
				local cfgB = self:getConfigByKey(ConfigName.GalleryEvent, b)

				if cfgA.sortType ~= cfgB.sortType then
					return cfgB.sortType > cfgB.sortType
				end

				return cfgA.id < cfgB.id
			end)
		end
	end

	return theTable
end

function M:getEventTimeSortLst()
	if not self._eventTimeSortLst then
		self._eventTimeSortLst = {}

		local cfgLst = self:getConfigList(ConfigName.GalleryEventTime)

		if cfgLst and #cfgLst > 0 then
			table.sort(cfgLst, function(cfgA, cfgB)
				if cfgA.sortType ~= cfgB.sortType then
					return cfgA.sortType > cfgB.sortType
				end

				return cfgA.sortType < cfgB.sortType
			end)

			self._eventTimeSortLst = cfgLst
		end
	end

	return self._eventTimeSortLst
end

function M:getEventSortLst()
	if not self._eventSortLst then
		self._eventSortLst = {}

		local yearMap = {}
		local cfgLst = self:getConfigList(ConfigName.GalleryEvent)

		if cfgLst and #cfgLst > 0 then
			for _, cfg in ipairs(cfgLst) do
				if cfg.typ == 1 then
					local timeType = cfg.timetype

					if not yearMap[timeType] then
						yearMap[timeType] = {}
					end

					table.insert(yearMap[timeType], cfg)
				end
			end
		end

		for year, cfgLst in pairs(yearMap) do
			table.sort(cfgLst, self.sortCfgDataBySortType)
		end

		for _, eventTimeCfg in ipairs(self:getEventTimeSortLst()) do
			local timeTyp = eventTimeCfg.id

			if yearMap[timeTyp] then
				table.insert(self._eventSortLst, yearMap[timeTyp])
			end
		end
	end

	return self._eventSortLst
end

function M:getTimeStrYear(dateTimeStr)
	local year

	if not string.nilorempty(dateTimeStr) then
		for item in string.gmatch(dateTimeStr, "%d+") do
			year = tonumber(item)

			break
		end
	end

	return year or 0
end

function M.timeStr2timeStamp(dateTimeStr)
	local _, _, y, m, d, _hour, _min, _sec = string.find(dateTimeStr, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
	local timestamp = os.time({
		year = y,
		month = m,
		day = d,
		hour = _hour,
		min = _min,
		sec = _sec
	})

	return timestamp
end

function M.sortCfgDataByTime(cfgA, cfgB)
	local ascending = true
	local tsA, tsB = 0, 0

	if not string.nilorempty(cfgA.time) then
		tsA = M.timeStr2timeStamp(cfgA.time)
	end

	if not string.nilorempty(cfgB.time) then
		tsB = M.timeStr2timeStamp(cfgB.time)
	end

	if tsA == tsB then
		if ascending then
			return cfgA.id < cfgB.id
		else
			return cfgB.id < cfgA.id
		end
	end

	if ascending then
		return tsA < tsB
	else
		return tsB < tsA
	end
end

function M.sortCfgDataBySortType(cfgA, cfgB)
	if cfgA.sortType ~= cfgB.sortType then
		return cfgA.sortType > cfgB.sortType
	end

	return cfgA.id < cfgB.id
end

M.instance = M.New()

return M
