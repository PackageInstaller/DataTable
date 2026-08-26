-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/Activity210Model.lua

module("modules.logic.versionactivity3_1.gaosiniao.model.Activity210Model", package.seeall)

local Activity210Model = class("Activity210Model", BaseModel)

function Activity210Model:onInit()
	self:reInit()
end

function Activity210Model:reInit()
	self.__config = false
	self.__taskType = false
	self.__episodeId2Act210EpisodeRecord = {}
	self.__episodeId2UnlockBranchIds = {}
end

function Activity210Model:_internal_set_taskType(taskType)
	self.__taskType = taskType or TaskEnum.TaskType.Activity210
end

function Activity210Model:_internal_set_config(config)
	assert(isTypeOf(config, Activity210Config), debug.traceback())

	self.__config = config
end

function Activity210Model:actId()
	assert(self.__config, "pleaes call self:_internal_set_config(config) first")

	return self.__config:actId()
end

function Activity210Model:taskType()
	return assert(self.__taskType, "pleaes call self:_internal_set_taskType(taskType) first")
end

function Activity210Model:config()
	return assert(self.__config, "pleaes call self:_internal_set_config(config) first")
end

function Activity210Model:getTaskMoList()
	return TaskModel.instance:getTaskMoList(self:taskType(), self:actId())
end

function Activity210Model:getActMO()
	return ActivityModel.instance:getActMO(self:actId())
end

function Activity210Model:isActOnLine()
	return ActivityHelper.getActivityStatus(self:actId(), true) == ActivityEnum.ActivityStatus.Normal
end

function Activity210Model:getRealStartTimeStamp()
	return self:getActMO():getRealStartTimeStamp()
end

function Activity210Model:getRealEndTimeStamp()
	return self:getActMO():getRealEndTimeStamp()
end

function Activity210Model:getRemainTimeStr()
	local second = ActivityModel.instance:getRemainTimeSec(self:actId())

	return TimeUtil.SecondToActivityTimeFormat(second)
end

function Activity210Model:isEpisodeOpen(episodeId)
	local preEpisodeId = self.__config:getPreEpisodeId(episodeId)

	if not preEpisodeId or preEpisodeId == 0 then
		return true
	end

	return self:hasPassLevelAndStory(preEpisodeId)
end

function Activity210Model:hasPassEpisode(episodeId)
	local act210EpisodeRecord = self.__episodeId2Act210EpisodeRecord[episodeId]

	if not act210EpisodeRecord then
		return false
	end

	return act210EpisodeRecord.isFinished
end

function Activity210Model:hasPassPreStory(episodeId)
	local preStoryId = self.__config:getPreStoryId(episodeId)

	if preStoryId > 0 then
		return StoryModel.instance:isStoryFinished(preStoryId)
	end

	return true
end

function Activity210Model:hasPassPostStory(episodeId)
	local postStoryId = self.__config:getPostStoryId(episodeId)

	if postStoryId > 0 then
		return StoryModel.instance:isStoryFinished(postStoryId)
	end

	return true
end

function Activity210Model:hasPassPrePostStory(episodeId)
	local ok = true
	local preStoryId, postStoryId = self.__config:getStoryIdPrePost(episodeId)

	if preStoryId > 0 then
		ok = ok and StoryModel.instance:isStoryFinished(preStoryId)
	end

	if postStoryId > 0 then
		ok = ok and StoryModel.instance:isStoryFinished(postStoryId)
	end

	return ok
end

function Activity210Model:hasPassLevelAndStory(episodeId)
	if not self:hasPassEpisode(episodeId) then
		return false
	end

	return self:hasPassPrePostStory(episodeId)
end

function Activity210Model:_internal_hasPassEpisode(episodeId, isFromSvrSide)
	if isFromSvrSide then
		return self:hasPassEpisode(episodeId)
	else
		return self:hasPassLevelAndStory(episodeId)
	end
end

function Activity210Model:_updateUnlockBranchIds(episodeId, unlockBranchIds)
	self.__episodeId2UnlockBranchIds[episodeId] = {}

	local tmp = self.__episodeId2UnlockBranchIds[episodeId]

	for _, v in ipairs(unlockBranchIds or {}) do
		tmp[v] = true
	end
end

function Activity210Model:_dirtyEpisodesUpdate(episodes)
	for _, v in ipairs(episodes) do
		local episodeId = v.episodeId

		self.__episodeId2Act210EpisodeRecord[episodeId] = v

		self:_updateUnlockBranchIds(episodeId, v.unlockBranchIds)
	end
end

function Activity210Model:_updateAll(msg)
	self.__episodeId2Act210EpisodeRecord = {}
	self.__episodeId2UnlockBranchIds = {}

	self:_dirtyEpisodesUpdate(msg.episodes)
end

function Activity210Model:onReceiveGetAct210InfoReply(msg)
	self:_updateAll(msg)
	self:_onReceiveGetAct210InfoReply(msg)
end

function Activity210Model:_onReceiveGetAct210InfoReply(msg)
	return
end

function Activity210Model:onReceiveAct210SaveEpisodeProgressReply(msg)
	self:_onReceiveAct210SaveEpisodeProgressReply(msg)
end

function Activity210Model:_onReceiveAct210SaveEpisodeProgressReply(msg)
	return
end

function Activity210Model:onReceiveAct210FinishEpisodeReply(msg)
	local episodeId = msg.episodeId
	local act210EpisodeRecord = self.__episodeId2Act210EpisodeRecord[episodeId]

	if not act210EpisodeRecord then
		return
	end

	rawset(act210EpisodeRecord, "isFinished", true)
	self:_onReceiveAct210FinishEpisodeReply(msg)
end

function Activity210Model:_onReceiveAct210FinishEpisodeReply(msg)
	return
end

function Activity210Model:onReceiveAct210ChooseEpisodeBranchReply(msg)
	self:_onReceiveAct210ChooseEpisodeBranchReply(msg)
end

function Activity210Model:_onReceiveAct210ChooseEpisodeBranchReply(msg)
	return
end

function Activity210Model:onReceiveAct210EpisodePush(msg)
	if msg.episodes then
		self:_dirtyEpisodesUpdate(msg.episodes)
	end

	self:_onReceiveAct210EpisodePush(msg)
end

function Activity210Model:_onReceiveAct210EpisodePush(msg)
	return
end

return Activity210Model
