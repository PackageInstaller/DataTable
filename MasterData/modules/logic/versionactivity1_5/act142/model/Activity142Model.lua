-- chunkname: @modules/logic/versionactivity1_5/act142/model/Activity142Model.lua

module("modules.logic.versionactivity1_5.act142.model.Activity142Model", package.seeall)

local Activity142Model = class("Activity142Model", BaseModel)
local DEFAULT_EPISODE_ID = 1

function Activity142Model:onInit()
	self:clear()
end

function Activity142Model:reInit()
	self:clear()
end

function Activity142Model:clear()
	Activity142Model.super.clear(self)

	self._activityId = nil
	self._curEpisodeId = nil
	self._episodeInfoData = {}
	self._hasCollectionDict = {}

	self:clearCacheData()
end

function Activity142Model:onReceiveGetAct142InfoReply(msg)
	self._activityId = msg.activityId
	self._episodeInfoData = {}

	for _, v in ipairs(msg.episodes) do
		local id = v.id

		self._episodeInfoData[id] = {}
		self._episodeInfoData[id].id = v.id
		self._episodeInfoData[id].star = v.star
		self._episodeInfoData[id].totalCount = v.totalCount
	end
end

function Activity142Model:getRemainTimeStr(actId)
	local resultStr = ""
	local actMO = ActivityModel.instance:getActMO(actId)

	if actMO then
		local timeStr = actMO:getRemainTimeStr3()

		resultStr = string.format(luaLang("remain"), timeStr)
	else
		resultStr = string.format(luaLang("activity_warmup_remain_time"), "0")
	end

	return resultStr
end

function Activity142Model:getActivityId()
	return self._activityId or VersionActivity1_5Enum.ActivityId.Activity142
end

function Activity142Model:setCurEpisodeId(episodeId)
	self._curEpisodeId = episodeId
end

function Activity142Model:getCurEpisodeId()
	return self._curEpisodeId or DEFAULT_EPISODE_ID
end

function Activity142Model:getEpisodeData(episodeId)
	local result

	return (self._episodeInfoData or nil) and self._episodeInfoData[episodeId]
end

function Activity142Model:isEpisodeClear(episodeId)
	local episodeData = self:getEpisodeData(episodeId)

	return (episodeData or nil) and episodeData.star > 0
end

function Activity142Model:isOpenDay(actId, episodeId)
	local result = false
	local actMO = ActivityModel.instance:getActMO(actId)
	local openDay = Activity142Config.instance:getEpisodeOpenDay(actId, episodeId)

	if actMO and openDay then
		local openTime = actMO:getRealStartTimeStamp() + (openDay - 1) * TimeUtil.OneDaySecond

		if openTime < ServerTime.now() then
			result = true
		end
	end

	return result
end

function Activity142Model:isPreEpisodeClear(actId, episodeId)
	local preEpisodeId = Activity142Config.instance:getEpisodePreEpisode(actId, episodeId)

	return preEpisodeId == 0 and true or self:isEpisodeClear(preEpisodeId)
end

function Activity142Model:isEpisodeOpen(actId, episodeId)
	local isOpenDay = self:isOpenDay(actId, episodeId)
	local isPreEpisodeClear = self:isPreEpisodeClear(actId, episodeId)

	return isPreEpisodeClear and isOpenDay
end

function Activity142Model:onReceiveAct142StartEpisodeReply(msg)
	self:increaseCount(msg.map.id)
end

function Activity142Model:increaseCount(id)
	if self._episodeInfoData then
		if self._episodeInfoData then
			self._episodeInfoData.totalCount = self._episodeInfoData.totalCount + 1
		end
	end
end

function Activity142Model:setHasCollection(collectionId)
	self._hasCollectionDict = self._hasCollectionDict or {}
	self._hasCollectionDict[collectionId] = true
end

function Activity142Model:getHadCollectionCount()
	local count = 0
	local actId = self:getActivityId()
	local collectionList = Activity142Config.instance:getCollectionList(actId)

	for _, collectionId in ipairs(collectionList) do
		if self:isHasCollection(collectionId) then
			count = count + 1
		end
	end

	return count
end

function Activity142Model:getHadCollectionIdList()
	local result = {}
	local actId = self:getActivityId()
	local collectionList = Activity142Config.instance:getCollectionList(actId)

	for _, collectionId in ipairs(collectionList) do
		if self:isHasCollection(collectionId) then
			result[#result + 1] = collectionId
		end
	end

	return result
end

function Activity142Model:isHasCollection(collectId)
	return (self._hasCollectionDict and self._hasCollectionDict[collectId] or nil) and true
end

function Activity142Model:getPlayerCacheData()
	local userId = PlayerModel.instance:getMyUserId()

	if not userId or userId == 0 then
		return
	end

	local strUserId = tostring(userId)

	if not self.cacheData then
		local strCacheData = PlayerPrefsHelper.getString(PlayerPrefsKey.Version1_5_Act142ChessKey, "")

		if not string.nilorempty(strCacheData) then
			self.cacheData = cjson.decode(strCacheData)
			self.playerCacheData = self.cacheData[strUserId]
		end

		self.cacheData = self.cacheData or {}
	end

	if not self.playerCacheData then
		self.playerCacheData = {}
		self.cacheData[strUserId] = self.playerCacheData

		self:saveCacheData()
	end

	return self.playerCacheData
end

function Activity142Model:saveCacheData()
	if not self.cacheData then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.Version1_5_Act142ChessKey, cjson.encode(self.cacheData))
end

function Activity142Model:clearCacheData()
	self.cacheData = nil
	self.playerCacheData = nil
end

function Activity142Model:getStarCount()
	local count = 0
	local actId = Va3ChessGameModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if not actId or not episodeId then
		return count
	end

	local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)

	if not episodeCfg then
		return count
	end

	local isFinishAllMainCon = Activity142Helper.checkConditionIsFinish(episodeCfg.mainConfition, actId)

	if isFinishAllMainCon then
		count = count + 1
	end

	local isFinishAllSubCon = Activity142Helper.checkConditionIsFinish(episodeCfg.extStarCondition, actId)

	if isFinishAllSubCon then
		count = count + 1
	end

	return count
end

function Activity142Model:isChapterOpen(chapterId)
	local actId = self:getActivityId()
	local episodeIdList = Activity142Config.instance:getChapterEpisodeIdList(actId, chapterId)
	local episodeId = episodeIdList and episodeIdList[1]

	return (episodeId or nil) and self:isEpisodeOpen(actId, episodeId)
end

Activity142Model.instance = Activity142Model.New()

return Activity142Model
