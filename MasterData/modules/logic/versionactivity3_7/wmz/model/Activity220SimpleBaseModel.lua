-- chunkname: @modules/logic/versionactivity3_7/wmz/model/Activity220SimpleBaseModel.lua

module("modules.logic.versionactivity3_7.wmz.model.Activity220SimpleBaseModel", package.seeall)

local Activity220SimpleBaseModel = class("Activity220SimpleBaseModel", BaseModel)

function Activity220SimpleBaseModel:ctor(...)
	Activity220SimpleBaseModel.super.ctor(self, ...)
end

function Activity220SimpleBaseModel:onInit()
	self:reInit()
end

function Activity220SimpleBaseModel:reInit()
	self.__configInst = false
	self.__taskType = TaskEnum.TaskType.Activity220
end

function Activity220SimpleBaseModel:_internal_set_configInst(configInst)
	assert(isTypeOf(configInst, Activity220SimpleBaseConfig), debug.traceback())

	self.__configInst = configInst
	self.__taskType = configInst:taskType()
end

function Activity220SimpleBaseModel:actId()
	assert(self.__configInst, "please call self:_internal_set_configInst(configInst) first")

	return self.__configInst:actId()
end

function Activity220SimpleBaseModel:taskType()
	return assert(self.__taskType, "please call self:_internal_set_configInst(configInst) first")
end

function Activity220SimpleBaseModel:configInst()
	return assert(self.__configInst, "please call self:_internal_set_configInst(configInst) first")
end

function Activity220SimpleBaseModel:getTaskMoList()
	return TaskModel.instance:getTaskMoList(self:taskType(), self:actId())
end

function Activity220SimpleBaseModel:getActMO()
	return ActivityModel.instance:getActMO(self:actId())
end

function Activity220SimpleBaseModel:isActOnLine()
	return ActivityHelper.getActivityStatus(self:actId(), true) == ActivityEnum.ActivityStatus.Normal
end

function Activity220SimpleBaseModel:getRealStartTimeStamp()
	return self:getActMO():getRealStartTimeStamp()
end

function Activity220SimpleBaseModel:getRealEndTimeStamp()
	return self:getActMO():getRealEndTimeStamp()
end

function Activity220SimpleBaseModel:getRemainTimeStr()
	local second = ActivityModel.instance:getRemainTimeSec(self:actId())

	return TimeUtil.SecondToActivityTimeFormat(second)
end

function Activity220SimpleBaseModel:getActivity220MO()
	return Activity220Model.instance:getById(self:actId())
end

function Activity220SimpleBaseModel:getMaxUnlockEpisodeId()
	return Activity220Model.instance:getMaxUnlockEpisodeId(self:actId())
end

function Activity220SimpleBaseModel:setNewFinishEpisode(...)
	local mo = self:getActivity220MO()

	if mo then
		mo:setNewFinishEpisode(...)
	end
end

function Activity220SimpleBaseModel:clearFinishEpisode(...)
	local mo = self:getActivity220MO()

	if mo then
		mo:clearFinishEpisode(...)
	end
end

function Activity220SimpleBaseModel:getNewFinishEpisode(...)
	local mo = self:getActivity220MO()

	if mo then
		return mo:getNewFinishEpisode(...)
	end

	return 0
end

function Activity220SimpleBaseModel:getEpisodeInfo(episodeId)
	return Activity220Model.instance:getEpisodeInfo(self:actId(), episodeId)
end

function Activity220SimpleBaseModel:isEpisodeUnlock(episodeId)
	local mo = self:getActivity220MO()

	return mo and mo:isEpisodeUnlock(episodeId) or false
end

function Activity220SimpleBaseModel:isEpisodePass(episodeId)
	local mo = self:getActivity220MO()

	return mo and mo:isEpisodePass(episodeId) or false
end

function Activity220SimpleBaseModel:hasPassPreStory(episodeId)
	local preStoryId = self.__configInst:getPreStoryId(episodeId)

	if preStoryId > 0 then
		return StoryModel.instance:isStoryFinished(preStoryId)
	end

	return true
end

function Activity220SimpleBaseModel:hasPassPostStory(episodeId)
	local postStoryId = self.__configInst:getPostStoryId(episodeId)

	if postStoryId > 0 then
		return StoryModel.instance:isStoryFinished(postStoryId)
	end

	return true
end

function Activity220SimpleBaseModel:hasPassPrePostStory(episodeId)
	local ok = true
	local preStoryId, postStoryId = self.__configInst:getStoryIdPrePost(episodeId)

	if preStoryId > 0 then
		ok = ok and StoryModel.instance:isStoryFinished(preStoryId)
	end

	if postStoryId > 0 then
		ok = ok and StoryModel.instance:isStoryFinished(postStoryId)
	end

	return ok
end

function Activity220SimpleBaseModel:hasPassLevelAndStory(episodeId)
	if not self:isEpisodePass(episodeId) then
		return false
	end

	return self:hasPassPrePostStory(episodeId)
end

function Activity220SimpleBaseModel:_internal_hasPassEpisode(episodeId, isFromSvrSide)
	if isFromSvrSide then
		return self:isEpisodePass(episodeId)
	else
		return self:hasPassLevelAndStory(episodeId)
	end
end

function Activity220SimpleBaseModel:onReceiveGetAct220InfoReply(...)
	return
end

function Activity220SimpleBaseModel:onReceiveAct220SaveEpisodeProgressReply(...)
	return
end

function Activity220SimpleBaseModel:onReceiveAct220FinishEpisodeReply(...)
	return
end

function Activity220SimpleBaseModel:onReceiveAct220ChooseEpisodeBranchReply(...)
	return
end

function Activity220SimpleBaseModel:onReceiveAct220EpisodePush(...)
	return
end

return Activity220SimpleBaseModel
