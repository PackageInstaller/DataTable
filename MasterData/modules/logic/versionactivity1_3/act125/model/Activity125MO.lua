-- chunkname: @modules/logic/versionactivity1_3/act125/model/Activity125MO.lua

module("modules.logic.versionactivity1_3.act125.model.Activity125MO", package.seeall)

local Activity125MO = pureTable("Activity125MO")
local kState_None = 0
local kState_Received = 1

function Activity125MO:ctor()
	self._userId = PlayerModel.instance:getMyUserId()
	self._episdoeInfos = {}
	self._oldDict = {}
end

function Activity125MO:setInfo(info)
	self._episdoeInfos = {}
	self.id = info.activityId

	self:initConfig()
	self:updateInfo(info.act125Episodes)
end

function Activity125MO:initConfig()
	if self.config then
		return
	end

	self.config = Activity125Config.instance:getAct125Config(self.id)
	self._episodeList = {}

	if self.config then
		for _, v in pairs(self.config) do
			table.insert(self._episodeList, v)
		end

		table.sort(self._episodeList, SortUtil.keyLower("id"))
	end
end

function Activity125MO:updateInfo(episodeList)
	if episodeList then
		for i = 1, #episodeList do
			local episode = episodeList[i]

			self._episdoeInfos[episode.id] = episode.state
		end
	end

	local reddotid = ActivityConfig.instance:getActivityCo(self.id).redDotId

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(reddotid)] = true
	})
end

function Activity125MO:isEpisodeFinished(episodeId)
	if not episodeId then
		return false
	end

	return self._episdoeInfos and self._episdoeInfos[episodeId] == kState_Received
end

function Activity125MO:getEpisodeConfig(episodeId)
	return self.config[episodeId]
end

function Activity125MO:isEpisodeUnLock(episodeId)
	local episodeCfg = self:getEpisodeConfig(episodeId)
	local preEpisodeId = episodeCfg.preId

	return (preEpisodeId and preEpisodeId > 0 or nil) and (self._episdoeInfos[preEpisodeId] == kState_Received or self:checkLocalIsPlay(preEpisodeId) and self._episdoeInfos[preEpisodeId] == kState_None) and self._episdoeInfos[episodeId] ~= nil
end

function Activity125MO:isEpisodeDayOpen(episodeId)
	local result = false
	local actMO = ActivityModel.instance:getActMO(self.id)
	local episodeCfg = self:getEpisodeConfig(episodeId)
	local openDay = episodeCfg.openDay
	local remainDay = 0
	local remainTime = 0

	if actMO and openDay then
		local openTime = actMO:getRealStartTimeStamp() + (openDay - 1) * TimeUtil.OneDaySecond

		remainTime = openTime - ServerTime.now()

		if remainTime < 0 then
			result = true
		else
			remainDay = math.floor(remainTime / TimeUtil.OneDaySecond)
		end
	end

	return result, remainDay, remainTime
end

function Activity125MO:isEpisodeReallyOpen(episodeId)
	local isEpisodeUnLock = self:isEpisodeUnLock(episodeId)
	local isOpenDay = self:isEpisodeDayOpen(episodeId)
	local episodeCfg = self:getEpisodeConfig(episodeId)

	if episodeCfg then
		if not episodeCfg.preId then
			local preEpisodeId

			if preEpisodeId and preEpisodeId > 0 and not self:isEpisodeFinished(preEpisodeId) then
				return false
			end

			return isEpisodeUnLock and isOpenDay
		end
	end
end

function Activity125MO:getLastEpisode()
	for i = #self._episodeList, 1, -1 do
		local value = self._episodeList[i]
		local episodeId = value.id

		if self:isEpisodeReallyOpen(episodeId) then
			return episodeId
		end
	end

	local lastEpisode = self._episodeList[1]

	return lastEpisode and lastEpisode.id
end

function Activity125MO:getFirstRewardEpisode()
	for _, value in ipairs(self._episodeList) do
		local episodeId = value.id

		if self:isEpisodeReallyOpen(episodeId) then
			if self._episdoeInfos[episodeId] == kState_None then
				return episodeId
			end
		else
			return value.preId
		end
	end

	local lastEpisode = self._episodeList[#self._episodeList]

	return lastEpisode and lastEpisode.id
end

function Activity125MO:setLocalIsPlay(id)
	local key = self:_PlayerPrefsKey_VersionActivityWarmUpView() .. tostring(id)

	self:_saveInt(key, 1)
end

function Activity125MO:checkLocalIsPlay(id)
	local key = self:_PlayerPrefsKey_VersionActivityWarmUpView() .. tostring(id)
	local value = self:_getInt(key, 0)

	return value == 1
end

function Activity125MO:setOldEpisode(id)
	self._oldDict[id] = true
end

function Activity125MO:checkIsOldEpisode(id)
	return self._oldDict[id]
end

function Activity125MO:getEpisodeCount()
	return #self._episodeList
end

function Activity125MO:getEpisodeList()
	return self._episodeList
end

function Activity125MO:setSelectEpisodeId(id)
	self._selectId = id
end

function Activity125MO:getSelectEpisodeId()
	self._selectId = self._selectId or self:getFirstRewardEpisode()

	return self._selectId
end

function Activity125MO:isAllEpisodeFinish()
	for _, value in ipairs(self._episodeList) do
		local episodeId = value.id
		local state = self._episdoeInfos[episodeId]

		if not state or state == kState_None then
			return false
		end
	end

	return true
end

function Activity125MO:isHasEpisodeCanReceiveReward(optEpisodeId)
	if optEpisodeId then
		return self._episdoeInfos[optEpisodeId] == kState_None
	end

	for _, value in ipairs(self._episodeList) do
		local episodeId = value.id
		local state = self._episdoeInfos[episodeId]

		if state == kState_None then
			return true
		end
	end

	return false
end

function Activity125MO:isFirstCheckEpisode(episodeId)
	local key = self:_PlayerPrefsKey_Activity125FirstCheckEpisode() .. tostring(episodeId)

	return self:_getInt(key, 0) == 0
end

function Activity125MO:setHasCheckEpisode(episodeId)
	local key = self:_PlayerPrefsKey_Activity125FirstCheckEpisode() .. tostring(episodeId)

	self:_saveInt(key, 1)
end

function Activity125MO:hasEpisodeCanCheck()
	for _, value in ipairs(self._episodeList) do
		local episodeId = value.id

		if self:isEpisodeReallyOpen(episodeId) and self:isFirstCheckEpisode(episodeId) then
			return true
		end
	end

	return false
end

function Activity125MO:hasEpisodeCanGetReward()
	for _, value in ipairs(self._episodeList) do
		local episodeId = value.id
		local state = self._episdoeInfos[episodeId]
		local localIsPlay = self:checkLocalIsPlay(episodeId)

		if state == kState_None and localIsPlay then
			return true
		end
	end

	return false
end

function Activity125MO:getRLOC(episodeId)
	local isRecevied = self:isEpisodeFinished(episodeId)
	local localIsPlay = self:checkLocalIsPlay(episodeId)
	local isOld = self:checkIsOldEpisode(episodeId)
	local canGetReward = not isRecevied and localIsPlay

	return isRecevied, localIsPlay, isOld, canGetReward
end

function Activity125MO:hasRedDot()
	for _, value in ipairs(self._episodeList) do
		local episodeId = value.id

		if self:isEpisodeReallyOpen(episodeId) and self:isHasEpisodeCanReceiveReward(episodeId) then
			return true
		end
	end

	return false
end

function Activity125MO:getLatestEpisode()
	local foundInex = -1

	for index, value in ipairs(self._episodeList) do
		local episodeId = value.id

		if self:isEpisodeReallyOpen(episodeId) then
			local isRecevied, _, _, canGetReward = self:getRLOC(episodeId)

			if not isRecevied then
				if foundInex == -1 or canGetReward then
					return episodeId
				else
					break
				end
			else
				foundInex = index
			end
		else
			return value.preId
		end
	end

	if foundInex ~= -1 then
		local foundEpisode = self._episodeList[foundInex]

		return foundEpisode.id
	end

	local lastEpisode = self._episodeList[#self._episodeList]

	return lastEpisode and lastEpisode.id
end

function Activity125MO:actId()
	return self.id
end

function Activity125MO:_saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function Activity125MO:_getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

function Activity125MO:_getPlayerPrefsKey(prefix)
	return prefix .. tostring(self:actId())
end

function Activity125MO:_PlayerPrefsKey_VersionActivityWarmUpView()
	return self:_getPlayerPrefsKey(PlayerPrefsKey.VersionActivityWarmUpView)
end

function Activity125MO:_PlayerPrefsKey_Activity125FirstCheckEpisode()
	return self:_getPlayerPrefsKey(PlayerPrefsKey.Activity125FirstCheckEpisode)
end

function Activity125MO:getPreTaskInfo(episodeId, optTaskType)
	local episodeCfg = self:getEpisodeConfig(episodeId)

	if not episodeCfg then
		return nil
	end

	local taskId = episodeCfg.taskId
	local taskCO = Activity125Config.instance:getTaskCO(taskId)

	if not taskCO then
		return nil
	end

	local taskMoList = TaskModel.instance:getTaskMoList(optTaskType or TaskEnum.TaskType.Activity125, self:actId())
	local taskMO

	for _, v in pairs(taskMoList) do
		if v.id == taskId then
			taskMO = v

			break
		end
	end

	if not taskMO then
		return nil
	end

	return {
		taskId = taskId,
		taskCO = taskCO,
		taskMO = taskMO,
		taskMoList = taskMoList
	}
end

function Activity125MO:checkPassedPreTask(episodeId, optTaskType)
	local taskInfo = self:getPreTaskInfo(episodeId, optTaskType)

	if not taskInfo then
		return false
	end

	local taskMO = taskInfo.taskMO

	return taskMO:isFinished()
end

return Activity125MO
