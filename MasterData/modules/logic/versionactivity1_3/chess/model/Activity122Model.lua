-- chunkname: @modules/logic/versionactivity1_3/chess/model/Activity122Model.lua

module("modules.logic.versionactivity1_3.chess.model.Activity122Model", package.seeall)

local Activity122Model = class("Activity122Model", BaseModel)
local defaultEpisodeId = 1

function Activity122Model:onInit()
	self.cacheData = nil
	self.playerCacheData = nil
end

function Activity122Model:reInit()
	self.cacheData = nil
	self.playerCacheData = nil
end

function Activity122Model:getCurActivityID()
	return self._curActivityId
end

function Activity122Model:setCurEpisodeId(value)
	self._curEpisodeId = value
end

function Activity122Model:getCurEpisodeId()
	return self._curEpisodeId
end

function Activity122Model:getCurEpisodeSightMap()
	return self._curEpisodeSightMap
end

function Activity122Model:checkPosIndexInSight(posIndex)
	return self._curEpisodeSightMap[posIndex]
end

function Activity122Model:getCurEpisodeFireMap()
	return self._curEpisodeFireMap
end

function Activity122Model:checkPosIndexInFire(posIndex)
	return self._curEpisodeFireMap[posIndex]
end

function Activity122Model:onReceiveGetAct122InfoReply(msg)
	self._curActivityId = msg.activityId

	if msg.lastEpisodeId > 0 then
		self._curEpisodeId = msg.lastEpisodeId or defaultEpisodeId
	end

	self._episodeInfoData = {}

	for i, v in ipairs(msg.act122Episodes) do
		local id = v.id

		self._episodeInfoData[id] = {}
		self._episodeInfoData[id].id = v.id
		self._episodeInfoData[id].star = v.star
		self._episodeInfoData[id].totalCount = v.totalCount
	end

	if msg.map and msg.map.allFinishInteracts then
		Va3ChessGameModel.instance:updateFinishInteracts(msg.map.finishInteracts)
		Va3ChessGameModel.instance:updateAllFinishInteracts(msg.map.allFinishInteracts)
	end
end

function Activity122Model:onReceiveAct122StartEpisodeReply(msg)
	self:increaseCount(msg.map.id)

	local sightInfo = msg.map.act122Sight

	self:initSight(sightInfo)

	local fireInfo = msg.map.act122Fire

	self:initFire(fireInfo)
end

function Activity122Model:initSight(addSights)
	self._curEpisodeSightMap = {}

	local newSight = addSights

	if not newSight then
		return
	end

	local len = #newSight

	for i = 1, len do
		local sightData = newSight[i]
		local tileIndex = Va3ChessMapUtils.calPosIndex(sightData.x, sightData.y)

		self._curEpisodeSightMap[tileIndex] = true
	end
end

function Activity122Model:updateSight(addSights)
	local newSight = addSights

	if not newSight then
		return
	end

	local len = #newSight

	for i = 1, len do
		local sightData = newSight[i]
		local tileIndex = Va3ChessMapUtils.calPosIndex(sightData.x, sightData.y)

		self._curEpisodeSightMap[tileIndex] = true
	end
end

function Activity122Model:initFire(addFires)
	self._curEpisodeFireMap = {}

	local newFires = addFires

	if not newFires then
		return
	end

	local len = #newFires

	for i = 1, len do
		local fireData = newFires[i]
		local tileIndex = Va3ChessMapUtils.calPosIndex(fireData.x, fireData.y)

		self._curEpisodeFireMap[tileIndex] = true
	end
end

function Activity122Model:updateFire(addFires)
	local newFires = addFires

	if not newFires then
		return
	end

	local len = #newFires

	for i = 1, len do
		local fireData = newFires[i]
		local tileIndex = Va3ChessMapUtils.calPosIndex(fireData.x, fireData.y)

		self._curEpisodeFireMap[tileIndex] = true
	end
end

function Activity122Model:getEpisodeData(id)
	return self._episodeInfoData and self._episodeInfoData[id]
end

function Activity122Model:isEpisodeClear(id)
	local episodeData = self:getEpisodeData(id)

	if episodeData then
		return episodeData.star > 0
	end

	return false
end

function Activity122Model:isEpisodeOpen(id)
	local episodeData = self:getEpisodeData(id)

	if not episodeData then
		return false
	end

	local episodeCfg = Activity122Config.instance:getEpisodeCo(self:getCurActivityID(), episodeData.id)

	return episodeCfg.preEpisode == 0 or self:isEpisodeClear(episodeCfg.preEpisode)
end

function Activity122Model:getTaskData(id)
	return TaskModel.instance:getTaskById(id)
end

function Activity122Model:increaseCount(id)
	if self._episodeInfoData then
		if self._episodeInfoData then
			self._episodeInfoData.totalCount = self._episodeInfoData.totalCount + 1
		end
	end
end

function Activity122Model:getPlayerCacheData()
	if not self.cacheData then
		local playerId = tostring(PlayerModel.instance:getMyUserId())
		local str = PlayerPrefsHelper.getString(PlayerPrefsKey.Version1_3_Roel2ChessKey, "")

		if not string.nilorempty(str) then
			self.cacheData = cjson.decode(str)
			self.playerCacheData = self.cacheData[playerId]
		end

		self.cacheData = self.cacheData or {}

		if not self.playerCacheData then
			self.playerCacheData = {}
			self.playerCacheData.isNextChapterLock = true
			self.playerCacheData.lockNodeList = {}
			self.cacheData[playerId] = self.playerCacheData

			self:saveCacheData()
		end
	end

	return self.playerCacheData
end

function Activity122Model:saveCacheData()
	if not self.cacheData then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.Version1_3_Roel2ChessKey, cjson.encode(self.cacheData))
end

Activity122Model.instance = Activity122Model.New()

return Activity122Model
