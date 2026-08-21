-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonMainLineChapterModel.lua

module("logic.extensions.dungeon.model.DungeonMainLineChapterModel", package.seeall)

local M = class("DungeonMainLineChapterModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._chapterList = {}
	self._dungeonPreDungeonIdList = {}
	self._dungeonToChapterId = {}
end

function M:onInit()
	self:onReset()

	local chapterCfg = DungeonConfig.instance:getCfgMainLineChapter()

	for k, chapterCo in ipairs(chapterCfg) do
		local chapterMo = MainlineChapterMO.New(chapterCo)

		if not self._chapterList[chapterCo.chapterId] then
			self._chapterList[chapterCo.chapterId] = {}
		end

		self._chapterList[chapterCo.chapterId][chapterCo.difficulty] = chapterMo

		local preDungeonId

		for i, v in ipairs(chapterCo.dungeonIds) do
			self._dungeonPreDungeonIdList[v] = preDungeonId
			preDungeonId = v
			self._dungeonToChapterId[v] = chapterCo.chapterId * 100 + chapterCo.difficulty
		end

		for _, list in ipairs(chapterCo.branchlineDungeonIds or {}) do
			preDungeonId = nil

			for i, id in ipairs(list) do
				self._dungeonPreDungeonIdList[id] = preDungeonId
				preDungeonId = id
				self._dungeonToChapterId[id] = chapterCo.chapterId * 100 + chapterCo.difficulty
			end
		end
	end
end

function M:onReset()
	self._dungeonMoList = {}
	self._difficultTimesRemain = 0
	self._starBoxTaken = {}
	self._dungeonCellShowInScene = nil
	self._dungeonCellUnlockCache = nil
	self._dungeonChapterCache = nil

	DungeonAgent.instance:_onReset()
end

function M:checkAllUnlockStatus()
	for i, v in ipairs(self._chapterList) do
		v[1]:recordIsUnlock()
	end
end

function M:initDungeonPassData()
	for k, v in pairs(self._dungeonMoList) do
		v:initByAgent(DungeonModel.instance:getDungeonPassDataByDungeonId(v:getId()))
	end

	self:initNewUnlockData()
end

function M:initNewUnlockData()
	local playerId = PlayerModel.instance:getId()
	local unlockStr = Astral.LocalStorage.Instance:GetString("newUnlock" .. playerId, "")
	local param = string.split(unlockStr, "_")

	self._newUnlockChapterId = {}

	for i, v in ipairs(param) do
		if v ~= "" then
			self._newUnlockChapterId[tonumber(v)] = true
		end
	end

	self:checkAllUnlockStatus()
end

function M:setDifficultTimesRemain(times)
	self._difficultTimesRemain = times
end

function M:getDifficultTimesRemain()
	return self._difficultTimesRemain
end

function M:updateWhenDungeonWin(dungeonId)
	local dungeonMo = self:getDungeonMoById(dungeonId)

	if dungeonMo and dungeonMo:getType() == CommEnum.DungeonType.Mainline and dungeonMo:getDifficulty() == 2 then
		self._difficultTimesRemain = self._difficultTimesRemain - 1
	end
end

function M:initStarBoxTakenData(starTakenMainlines)
	for i, v in ipairs(starTakenMainlines) do
		self._starBoxTaken[v.chapter * 100 + v.difficulty] = v.stars
	end
end

function M:takeOneStarBox(chapter, difficulty, index)
	local star = self._starBoxTaken[chapter * 100 + difficulty] or 0
	local num = 1

	for i = 1, index - 1 do
		num = num * 2
	end

	self._starBoxTaken[chapter * 100 + difficulty] = num + star
end

function M:getStarBoxTakenData(chapter, difficulty)
	local star = self._starBoxTaken[chapter * 100 + difficulty] or 0
	local starList = {}

	starList[1] = star % 2 == 1
	starList[2] = star % 4 >= 2
	starList[3] = star % 8 >= 4

	return starList
end

function M:getChapterMoByIdAndDifficulty(chapterId, difficulty)
	if not self._chapterList[chapterId] then
		return nil
	end

	return self._chapterList[chapterId][difficulty]
end

function M:getAllMainlineChapter()
	return self._chapterList
end

function M:recordDungeonSceneChpaterInfo(info)
	self._dungeonSceneInfo = info
end

function M:getDungeonSceneChpaterInfo()
	return self._dungeonSceneInfo
end

function M:getAllUnlockChapterList()
	local chapterList = {}

	for i, v in ipairs(self._chapterList) do
		local chapterMo = v[1]

		if chapterMo:getIsChapterUnlock() then
			chapterList[i] = v
		end
	end

	return chapterList
end

function M:getLatestUnlockChapterMo(difficulty)
	local theChapterId = 0

	for chapterId, diffMoMap in pairs(self._chapterList) do
		local chapterMo = diffMoMap[difficulty]

		if chapterMo:getIsChapterUnlock() and theChapterId <= chapterId then
			theChapterId = chapterId
		end
	end

	if theChapterId > 0 then
		return self._chapterList[theChapterId][difficulty]
	else
		return nil
	end
end

function M:tryEnterChapterScene(jumpId, chapterInfo1)
	local chapterInfo = {}

	if chapterInfo1 then
		chapterInfo = chapterInfo1
	end

	if jumpId then
		local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

		if jumpInfo then
			if jumpInfo.extValue1 == "difficulty" then
				local strList = string.split(jumpInfo.extValue2, "-")
				local chapterId = tonumber(strList[1])
				local difficulty = tonumber(strList[2])
				local chapterMo = self._chapterList[chapterId][difficulty]

				chapterInfo.chapterId = chapterId
				chapterInfo.dungeonIndex = chapterMo:getLastUnlockDungeonIndex() or 1
				chapterInfo.difficulty = difficulty
			elseif jumpInfo.extValue1 == "level" then
				local strList = string.split(jumpInfo.extValue2, "-")

				chapterInfo.difficulty = tonumber(strList[1])
				chapterInfo.chapterId = tonumber(strList[2])
				chapterInfo.dungeonIndex = tonumber(strList[3])
				chapterInfo.clickDungeon = true
			end
		end

		if chapterInfo.chapterId then
			local chapterMo = self._chapterList[chapterInfo.chapterId][chapterInfo.difficulty]
			local isChaperUnlock = chapterMo:getIsChapterUnlock()

			if not isChaperUnlock then
				FloatWordMgr.instance:show(lang("mainline_chapter_is_lock"))

				return
			end

			local dungeonId = chapterMo:getDungeonIds()[chapterInfo.dungeonIndex]
			local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonId)

			if not dungeonMo:getIsUnlock() and chapterInfo.clickDungeon then
				chapterInfo.clickDungeon = false
			end
		end
	end

	if not chapterInfo.chapterId then
		for i = #self._chapterList, 1, -1 do
			local chapterMo = self._chapterList[i][1]

			if chapterMo:getIsChapterUnlock() then
				chapterInfo.chapterId = chapterMo:getChapterId()
				chapterInfo.dungeonIndex = chapterMo:getLastUnlockDungeonIndex()
				chapterInfo.difficulty = 1

				break
			end
		end
	end

	if not chapterInfo.dungeonIndex then
		-- block empty
	end

	if not chapterInfo.chapterId then
		FloatWordMgr.instance:show(lang("tip_not_open_condition"))

		return
	end

	self:recordDungeonSceneChpaterInfo(chapterInfo)
	ViewMgr.instance:open(ViewName.MainlineDungeonView)
end

function M:checkLocalStorageLastLevelIlegal(lastStr)
	local info = string.split(lastStr, ",")
	local chapterId = tonumber(info[1])
	local dungeonIndex = tonumber(info[2])
	local difficulty = tonumber(info[3])

	if not self._chapterList[chapterId] or not self._chapterList[chapterId][difficulty] then
		return false
	end

	local chapterMO = self._chapterList[chapterId][difficulty]

	if not chapterMO:getIsChapterUnlock() then
		return false
	end

	local dungeonIds = chapterMO:getDungeonIds()
	local dungeonId = dungeonIds[dungeonIndex]
	local dungeonMO = self:getDungeonMoById(dungeonId)

	if dungeonMO and dungeonMO:getIsUnlock() then
		return true
	end

	return false
end

function M:getChapterMoByChapterId(id)
	return self._chapterList[id]
end

function M:getDungeonMoById(dungeonId)
	local isPlot = false

	if not self._dungeonMoList[dungeonId] then
		local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)

		if not dungeonCo then
			dungeonCo = DungeonConfig.instance:getMainlinePlotDungeonCOByDungeonId(dungeonId)

			if dungeonCo then
				isPlot = true
			else
				return
			end
		end

		local dungeonMo

		if dungeonCo.type == CommEnum.DungeonType.Branchline then
			dungeonMo = BranchlineDungeonMO.New()
		else
			dungeonMo = DungeonMo.New()
		end

		if isPlot then
			dungeonMo:initByPlotConfig(dungeonCo)
		else
			dungeonMo:initByConfig(dungeonCo)
		end

		dungeonMo:initByAgent(DungeonModel.instance:getDungeonPassDataByDungeonId(dungeonId))
		dungeonMo:setPreDungeonId(self._dungeonPreDungeonIdList[dungeonId])
		dungeonMo:setChapterIdAndDifficulty(self._dungeonToChapterId[dungeonId])

		self._dungeonMoList[dungeonId] = dungeonMo
	end

	return self._dungeonMoList[dungeonId]
end

function M:localStorageNewUnlockChapterId(chapterId)
	self._newUnlockChapterId[chapterId] = true

	self:_storageNewUnlockChapterId()
end

function M:removeStorageNewUnlockChapterId(chapterId)
	self._newUnlockChapterId[chapterId] = false

	self:_storageNewUnlockChapterId()
end

function M:_storageNewUnlockChapterId()
	local playerId = PlayerModel.instance:getId()
	local storageStr = ""

	for k, v in pairs(self._newUnlockChapterId) do
		if v == true then
			if string.nilorempty(storageStr) then
				storageStr = tostring(k)
			else
				storageStr = string.format("%s_%s", storageStr, k)
			end
		end
	end

	Astral.LocalStorage.Instance:SetString("newUnlock" .. playerId, storageStr)
end

function M:getIfNewUnlockChapter(chapterId)
	return self._newUnlockChapterId[chapterId]
end

function M:getLastUnlockChapter()
	local lastMO

	for _, molist in ipairs(self._chapterList) do
		local mo = molist[1]

		if mo:getIsChapterUnlock() then
			lastMO = mo
		else
			break
		end
	end

	return lastMO
end

function M:isLastUnlockChapterNeedShow()
	local needShow = false
	local lastMO = self:getLastUnlockChapter()

	if lastMO:getChapterId() == 1 then
		needShow = not self:isFirstDungeonFinishGuide()
	else
		needShow = self:getIfNewUnlockChapter(lastMO:getChapterId())
	end

	return needShow, lastMO:getChapterId()
end

function M:isFirstDungeonFinishGuide()
	local mo = GuideModel.instance:getGuideMO(ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.MainLineDungeonGuideId))

	return mo.isFinish
end

function M:getChapterNameStrById(chapterId, difficulty)
	local chapterList = self:getChapterMoByChapterId(chapterId)

	if chapterList then
		local chapterName = chapterList[difficulty]:getName()

		if chapterId < 10 then
			return string.format("0%d %s", chapterId, chapterName)
		else
			return string.format("%d %s", chapterId, chapterName)
		end
	end

	return ""
end

function M:setAnimStatus(status)
	self._isPlayAnim = status
end

function M:getAnimStatus()
	return self._isPlayAnim
end

function M:hasDungeonPassed(dungeonId)
	local dungeonMO = self:getDungeonMoById(dungeonId)

	return dungeonMO and dungeonMO:hasPassed() or false
end

function M:getChapter1FirstUnlockDungeonId()
	local chapterMo = self._chapterList[1][1]
	local dungeonIds = chapterMo:getNormalDungeonIds()
	local index = chapterMo:getLastUnlockDungeonIndex()

	return dungeonIds[index]
end

function M:getChapter1FirstUnlockDungeonIndex()
	local chapterMo = self._chapterList[1][1]
	local index = chapterMo:getLastUnlockDungeonIndex()

	return index
end

function M:hasUnlockDungeon(dungeonId)
	local hasUnlockTarget = false
	local unlock = false
	local cfgList = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonList()

	for _, cfg in ipairs(cfgList) do
		if cfg.unlockCondition then
			local hasDungeonCondi = false
			local hasPlotCondi = false
			local isCondiDungeonPassed = true
			local isCondiDungeonPassed2 = true
			local isCondiPlotPassed = true
			local hasShowUnlockCondition = false

			if cfg.showUnlockCondition then
				hasShowUnlockCondition = true

				for i, v in ipairs(cfg.showUnlockCondition) do
					if v.type == "dungeon" then
						local id = tonumber(v.value)

						hasDungeonCondi = id == dungeonId

						local preDungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(id)

						isCondiDungeonPassed2 = preDungeonMo:hasPassed()
					end
				end
			end

			for i, v in ipairs(cfg.unlockCondition) do
				if v.type == "dungeon" then
					local id = tonumber(v.value)

					if not hasShowUnlockCondition then
						hasDungeonCondi = id == dungeonId
					end

					local preDungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(id)

					if not preDungeonMo:hasPassed() then
						isCondiDungeonPassed = false
					end
				elseif v.type == "plot" then
					hasPlotCondi = true

					local str = string.split(v.value, "#")

					if not GuideModel.instance:hasPlotAnswer(tonumber(str[1]), tonumber(str[2])) then
						isCondiPlotPassed = false
					end
				end
			end

			hasUnlockTarget = hasDungeonCondi and hasPlotCondi
			unlock = isCondiDungeonPassed and isCondiPlotPassed and isCondiDungeonPassed2

			if hasUnlockTarget then
				break
			end
		end
	end

	return hasUnlockTarget, unlock
end

function M:isDungeonHardModeUnlock(dungeonId)
	local unlock = false
	local hardId = DungeonConfig.instance:getDungeonHardModeId(dungeonId)

	if hardId > 0 then
		local dungeonMO = self:getDungeonMoById(hardId)

		unlock = dungeonMO:getIsUnlock()
	end

	return unlock
end

function M:isTeachDungeon(dungeonId)
	local dungeonUnlockCO = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(dungeonId)

	return dungeonUnlockCO.isTeach == 1
end

function M:isBossDungeon(dungeonId)
	local dungeonUnlockCO = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(dungeonId)

	return dungeonUnlockCO.isBoss == 1
end

function M:getLastDungeonId()
	local chapterMO = self:getLastUnlockChapter()
	local idx = chapterMO:getLastUnlockDungeonIndex()
	local dungeonIds = chapterMO:getDungeonIds()

	return dungeonIds[idx]
end

M._CacheSceneKey = "DungeonCacheSceneKey"

function M:getShowInSceneCache(dungeonId)
	if not self._dungeonCellShowInScene then
		self._dungeonCellShowInScene = self:_readUnlockCache(self._CacheSceneKey)
	end

	return self._dungeonCellShowInScene[dungeonId]
end

function M:setShowInSceneCache(dungeonId)
	if not self._dungeonCellShowInScene then
		self._dungeonCellShowInScene = self:_readUnlockCache(self._CacheSceneKey)
	end

	if not self._dungeonCellShowInScene[dungeonId] then
		self._dungeonCellShowInScene[dungeonId] = dungeonId

		self:_writeUnlockCache(self._CacheSceneKey, self._dungeonCellShowInScene)
	end
end

M._CacheOtherKey = "DungeonCacheOtherKey"

function M:getDungeonCellUnlockCache(dungeonId)
	if not self._dungeonCellUnlockCache then
		self._dungeonCellUnlockCache = self:_readUnlockCache(self._CacheOtherKey)
	end

	return self._dungeonCellUnlockCache[dungeonId]
end

function M:setDungeonCellUnlockCache(dungeonId)
	if not self._dungeonCellUnlockCache then
		self._dungeonCellUnlockCache = self:_readUnlockCache(self._CacheOtherKey)
	end

	if not self._dungeonCellUnlockCache[dungeonId] then
		self._dungeonCellUnlockCache[dungeonId] = dungeonId

		self:_writeUnlockCache(self._CacheOtherKey, self._dungeonCellUnlockCache)
	end
end

M._CacheChapterKey = "DungeonCacheChapterKey"

function M:getDungeonChapterCache(chapterId)
	if not self._dungeonChapterCache then
		self._dungeonChapterCache = self:_readUnlockCache(self._CacheChapterKey)
	end

	return self._dungeonChapterCache[chapterId]
end

function M:setDungeonChapterCache(chapterId)
	if not self._dungeonChapterCache then
		self._dungeonChapterCache = self:_readUnlockCache(self._CacheChapterKey)
	end

	if not self._dungeonChapterCache[chapterId] then
		self._dungeonChapterCache[chapterId] = chapterId

		self:_writeUnlockCache(self._CacheChapterKey, self._dungeonChapterCache)
	end
end

function M:_readUnlockCache(key)
	local list = {}
	local strData = PlayerModel.instance:getLocalStorageString(key)

	if not string.nilorempty(strData) then
		local datas = string.split(strData, "#")

		for i = 1, #datas do
			local id = checknumber(datas[i])

			list[id] = id
		end
	end

	return list
end

function M:_writeUnlockCache(key, list)
	local strData = ""

	for k, v in pairs(list) do
		strData = strData .. "#" .. v
	end

	PlayerModel.instance:setLocalStorageString(key, strData)
end

M.instance = M.New()

return M
