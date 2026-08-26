-- chunkname: @modules/logic/explore/model/ExploreSimpleModel.lua

module("modules.logic.explore.model.ExploreSimpleModel", package.seeall)

local ExploreSimpleModel = class("ExploreSimpleModel", BaseModel)

function ExploreSimpleModel:onInit()
	self.nowMapId = 0
	self.chapterInfos = {}
	self.mapInfos = {}
	self.unLockMaps = {}
	self.unLockChapters = {}
	self.localData = nil
	self.taskRed = nil
	self.isShowBag = false
end

function ExploreSimpleModel:reInit()
	self:onInit()
end

function ExploreSimpleModel:onGetInfo(msg)
	self.nowMapId = msg.lastMapId
	self.isShowBag = msg.isShowBag

	for _, v in ipairs(msg.chapterSimple) do
		local mo = ExploreChapterSimpleMo.New()

		mo:init(v)

		self.chapterInfos[v.chapterId] = mo
	end

	for _, v in ipairs(msg.unlockMapIds) do
		self.unLockMaps[v] = true

		local mapCo = ExploreConfig.instance:getMapIdConfig(v)

		if mapCo then
			self.unLockChapters[mapCo.chapterId] = true
		end
	end

	for _, v in ipairs(msg.mapSimple) do
		local mo = ExploreMapSimpleMo.New()

		mo:init(v)

		self.mapInfos[v.mapId] = mo
	end
end

function ExploreSimpleModel:setShowBag()
	if not self.isShowBag then
		self.isShowBag = true

		if isDebugBuild then
			ExploreController.instance:dispatchEvent(ExploreEvent.ShowBagBtn)
		end
	end
end

function ExploreSimpleModel:getChapterIndex(chapterId, episodeId)
	if not chapterId or not episodeId then
		return 1, 1
	end

	local list = DungeonConfig.instance:getExploreChapterList()

	for i = #list, 1, -1 do
		local episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(list[i].id)

		for j = #episodeCoList, 1, -1 do
			if not chapterId or not episodeId then
				local mapCo = lua_explore_scene.configDict[list[i].id][episodeCoList[j].id]

				if self:getMapIsUnLock(mapCo.id) then
					return i, j, list[i].id, episodeCoList[j].id
				end
			elseif list[i].id == chapterId and episodeCoList[j].id == episodeId then
				return i, j, chapterId, episodeId
			end
		end
	end

	return 1, 1
end

function ExploreSimpleModel:getMapIsUnLock(mapId)
	return self.unLockMaps[mapId] or false
end

function ExploreSimpleModel:setNowMapId(mapId)
	self.nowMapId = mapId
end

function ExploreSimpleModel:onGetArchive(id)
	local mapCo = self:getMapConfig()

	if not mapCo then
		logError("没有地图数据？？")

		return
	end

	if not self.chapterInfos[mapCo.chapterId] then
		return
	end

	self:markArchive(mapCo.chapterId, true, id)
	self.chapterInfos[mapCo.chapterId]:onGetArchive(id)
end

function ExploreSimpleModel:getChapterMo(chapterId)
	return self.chapterInfos[chapterId]
end

function ExploreSimpleModel:isChapterFinish(chapterId)
	local mo = self:getChapterMo(chapterId)

	return (mo or nil) and (mo.isFinish or false)
end

function ExploreSimpleModel:onGetBonus(id, options)
	local mapCo = self:getMapConfig()

	if not mapCo then
		logError("没有地图数据？？")

		return
	end

	if not self.chapterInfos[mapCo.chapterId] then
		return
	end

	self.chapterInfos[mapCo.chapterId]:onGetBonus(id, options)
end

function ExploreSimpleModel:onGetCoin(coinType, nowCount)
	local mapId = ExploreModel.instance:getMapId()

	self.mapInfos[mapId] = self.mapInfos[mapId] or ExploreMapSimpleMo.New()

	self.mapInfos[mapId]:onGetCoin(coinType, nowCount)
end

function ExploreSimpleModel:getMapConfig()
	return (ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId()))
end

function ExploreSimpleModel:getBonusIsGet(mapId, bonusId)
	if not self.mapInfos[mapId] then
		return false
	end

	return self.mapInfos[mapId].bonusIds[bonusId] or false
end

function ExploreSimpleModel:setBonusIsGet(mapId, bonusId)
	self.mapInfos[mapId] = self.mapInfos[mapId] or ExploreMapSimpleMo.New()
	self.mapInfos[mapId].bonusIds[bonusId] = true
end

function ExploreSimpleModel:getCoinCountByMapId(mapId)
	local bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal = 0, 0, 0, 0, 0, 0
	local mo = self.mapInfos[mapId]

	if mo then
		bonusNum = mo.bonusNum
		goldCoin = mo.goldCoin
		purpleCoin = mo.purpleCoin
		bonusNumTotal = mo.bonusNumTotal
		goldCoinTotal = mo.goldCoinTotal
		purpleCoinTotal = mo.purpleCoinTotal
	end

	return bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal
end

function ExploreSimpleModel:getChapterCoinCount(chapterId)
	local mapIds = ExploreConfig.instance:getMapIdsByChapter(chapterId)
	local bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal = 0, 0, 0, 0, 0, 0

	for _, mapId in pairs(mapIds) do
		local mo = self.mapInfos[mapId]

		if mo then
			bonusNum = bonusNum + mo.bonusNum
			goldCoin = goldCoin + mo.goldCoin
			purpleCoin = purpleCoin + mo.purpleCoin
			bonusNumTotal = bonusNumTotal + mo.bonusNumTotal
			goldCoinTotal = goldCoinTotal + mo.goldCoinTotal
			purpleCoinTotal = purpleCoinTotal + mo.purpleCoinTotal
		end
	end

	return bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal
end

function ExploreSimpleModel:isChapterCoinFull(chapterId)
	local bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal = self:getChapterCoinCount(chapterId)

	return bonusNum == bonusNumTotal and goldCoin == goldCoinTotal and purpleCoin == purpleCoinTotal
end

function ExploreSimpleModel:getMapCoinCount(mapId)
	mapId = mapId or ExploreModel.instance:getMapId()

	local mo = self.mapInfos[mapId]

	if not mo then
		return 0, 0, 0, 0, 0, 0
	end

	return mo.bonusNum, mo.goldCoin, mo.purpleCoin, mo.bonusNumTotal, mo.goldCoinTotal, mo.purpleCoinTotal
end

function ExploreSimpleModel:getChapterIsUnLock(chapterId)
	return self.unLockChapters[chapterId] or false
end

function ExploreSimpleModel:checkTaskRed()
	self.taskRed = {}

	local tasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Explore)

	if not tasks then
		return
	end

	for _, taskMo in pairs(tasks) do
		local co = lua_task_explore.configDict[taskMo.id]

		if co and taskMo.progress >= co.maxProgress and taskMo.finishCount <= 0 then
			local taskParam = string.splitToNumber(co.listenerParam, "#")

			self.taskRed[taskParam[1]] = self.taskRed[taskParam[1]] or {}
			self.taskRed[taskParam[1]][taskParam[2]] = true
		end
	end

	self:refreshRedPoint()
end

function ExploreSimpleModel:getTaskRed(chapterId, coinType)
	return (self.taskRed and self.taskRed[chapterId] or nil) and (self.taskRed[chapterId][coinType] or false)
end

function ExploreSimpleModel:markChapterNew(chapterId)
	self:_getLocalData()

	if self:getChapterIsNew(chapterId) then
		local key = tostring(chapterId)

		if self.localData[key] then
			self.localData[key].isMark = true
		else
			self.localData[key] = {
				isMark = true
			}
		end

		self:savePrefData()
	end
end

function ExploreSimpleModel:markChapterShowUnlock(chapterId)
	self:_getLocalData()

	if not self:getChapterIsShowUnlock(chapterId) then
		local key = tostring(chapterId)

		if self.localData[key] then
			self.localData[key].isShowUnlock = true
		else
			self.localData[key] = {
				isShowUnlock = true
			}
		end

		self:savePrefData()
	end
end

function ExploreSimpleModel:markEpisodeShowUnlock(chapterId, episodeId)
	self:_getLocalData()

	if not self:getEpisodeIsShowUnlock(chapterId, episodeId) then
		local key = tostring(chapterId)
		local data = self.localData[key]

		if not data then
			data = {}
			self.localData[key] = data
		end

		local unLockEpisodes = data.unLockEpisodes

		if not unLockEpisodes then
			unLockEpisodes = {}
			data.unLockEpisodes = unLockEpisodes
		end

		table.insert(data.unLockEpisodes, episodeId)
		self:savePrefData()
	end
end

function ExploreSimpleModel:markArchive(chapterId, isNew, id)
	self:_getLocalData()

	if isNew or not isNew and self:getHaveNewArchive(chapterId) ~= isNew then
		local key = tostring(chapterId)

		if isNew then
			self.localData[key] = self.localData[key] or {}
			self.localData[key].archive = self.localData[key].archive or {}

			table.insert(self.localData[key].archive, id)
		elseif self.localData[key] then
			self.localData[key].archive = nil
		end

		self:savePrefData()
	end

	self:refreshRedPoint()
end

function ExploreSimpleModel:getChapterIsNew(chapterId)
	if not self:getChapterIsUnLock(chapterId) then
		return false
	end

	self:_getLocalData()

	local key = tostring(chapterId)

	return not self.localData[key] or not self.localData[key].isMark
end

function ExploreSimpleModel:getChapterIsShowUnlock(chapterId)
	if not self:getChapterIsUnLock(chapterId) then
		return false
	end

	self:_getLocalData()

	local key = tostring(chapterId)

	return self.localData[key] and self.localData[key].isShowUnlock
end

function ExploreSimpleModel:getEpisodeIsShowUnlock(chapterId, episodeId)
	if not self:getChapterIsUnLock(chapterId) then
		return false
	end

	self:_getLocalData()

	local key = tostring(chapterId)
	local data = self.localData[key]

	if not data or not data.unLockEpisodes then
		return false
	end

	return not not tabletool.indexOf(data.unLockEpisodes, episodeId)
end

function ExploreSimpleModel:getCollectFullIsShow(chapterId, collectType, episodeId)
	if not self:getChapterIsUnLock(chapterId) then
		return false
	end

	self:_getLocalData()

	local key = tostring(chapterId)
	local data = self.localData[key]

	if data and episodeId then
		data = data[tostring(episodeId)]
	end

	if not data then
		return false
	end

	collectType = string.format("collect%d", collectType)

	return data[collectType] or false
end

function ExploreSimpleModel:markCollectFullIsShow(chapterId, collectType, episodeId)
	if not self:getChapterIsUnLock(chapterId) then
		return false
	end

	if not self:getCollectFullIsShow(chapterId, collectType, episodeId) then
		local key = tostring(chapterId)
		local data = self.localData[key]

		if not data then
			data = {}
			self.localData[key] = {}
		end

		collectType = string.format("collect%d", collectType)

		if episodeId then
			episodeId = tostring(episodeId)
			data = self.localData[key][episodeId]

			if not self.localData[key][episodeId] then
				data = {}
				self.localData[key][episodeId] = data
			end
		end

		data[collectType] = true

		self:savePrefData()
	end
end

function ExploreSimpleModel:getLastSelectMap()
	self:_getLocalData()

	local chapterId, episodeId = self.localData.lastChapterId, self.localData.lastEpisodeId

	return chapterId, episodeId
end

function ExploreSimpleModel:setLastSelectMap(chapterId, episodeId)
	self:_getLocalData()

	self.localData.lastChapterId, self.localData.lastEpisodeId = chapterId, episodeId

	self:savePrefData()
end

function ExploreSimpleModel:getHaveNewArchive(chapterId)
	self:_getLocalData()

	local key = tostring(chapterId)

	return (self.localData[key] or nil) and (self.localData[key].archive or false)
end

function ExploreSimpleModel:getNewArchives(chapterId)
	self:_getLocalData()

	local key = tostring(chapterId)

	return (self.localData[key] or nil) and (self.localData[key].archive or {})
end

function ExploreSimpleModel:_getLocalData()
	if not self.localData then
		local data = PlayerPrefsHelper.getString(PlayerPrefsKey.ExploreRedDotData .. PlayerModel.instance:getMyUserId(), "")

		self.localData = string.nilorempty(data) and {} or cjson.decode(data)
	end

	return self.localData
end

function ExploreSimpleModel:setDelaySave(isDelaySave)
	self._delaySave = isDelaySave

	if not self._delaySave then
		self:savePrefData()
	end
end

function ExploreSimpleModel:savePrefData()
	if self._delaySave then
		return
	end

	local str = cjson.encode(self.localData)

	PlayerPrefsHelper.setString(PlayerPrefsKey.ExploreRedDotData .. PlayerModel.instance:getMyUserId(), str)
end

function ExploreSimpleModel:refreshRedPoint()
	local chapterCoList = DungeonConfig.instance:getExploreChapterList()

	for i, chapterCo in ipairs(chapterCoList) do
		local num = 0

		if self:getHaveNewArchive(chapterCo.id) then
			num = num + 1
		end

		for coinType = 1, 2 do
			if ExploreSimpleModel.instance:getTaskRed(chapterCo.id, coinType) then
				num = num + 1
			end
		end

		local redDotInfoList = {}
		local str = "Explore_Chapter" .. i
		local red = RedDotEnum.DotNode[str]

		table.insert(redDotInfoList, {
			id = red,
			value = num
		})
		RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
	end
end

function ExploreSimpleModel:isShowExplore()
	local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Explore)

	if not isOpen then
		return false
	end

	local isForbid = GuideController.instance:isForbidGuides()

	if isForbid then
		return true
	end

	if VersionValidator.instance:isInReviewing() then
		return true
	end

	return true
end

ExploreSimpleModel.instance = ExploreSimpleModel.New()

return ExploreSimpleModel
