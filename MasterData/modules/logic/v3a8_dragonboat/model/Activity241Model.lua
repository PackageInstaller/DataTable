-- chunkname: @modules/logic/v3a8_dragonboat/model/Activity241Model.lua

module("modules.logic.v3a8_dragonboat.model.Activity241Model", package.seeall)

local Activity241Model = class("Activity241Model", BaseModel)

function Activity241Model:ctor()
	Activity241Model.super.ctor(self)

	self._svrInfo = {}
end

function Activity241Model:onInit()
	self:reInit()
end

function Activity241Model:reInit()
	self.__config = false
	self._svrInfo = {}
end

function Activity241Model:_internal_set_config(config)
	assert(isTypeOf(config, Activity241Config), debug.traceback())

	self.__config = config
end

function Activity241Model:actId()
	assert(self.__config, "pleaes call self:_internal_set_config(config) first")

	return self.__config:actId()
end

function Activity241Model:config()
	return assert(self.__config, "pleaes call self:_internal_set_config(config) first")
end

function Activity241Model:voteId()
	return self:config():voteId()
end

function Activity241Model:getActMO()
	return ActivityModel.instance:getActMO(self:actId())
end

function Activity241Model:isActOnLine()
	return ActivityHelper.getActivityStatus(self:actId(), true) == ActivityEnum.ActivityStatus.Normal
end

function Activity241Model:getRealStartTimeStamp()
	return self:getActMO():getRealStartTimeStamp()
end

function Activity241Model:getRealEndTimeStamp()
	return self:getActMO():getRealEndTimeStamp()
end

function Activity241Model:getRemainTimeStr()
	local second = ActivityModel.instance:getRemainTimeSec(self:actId())

	return TimeUtil.SecondToActivityTimeFormat(second)
end

function Activity241Model:activityId()
	return self._svrInfo.activityId or 0
end

function Activity241Model:loginCount()
	return self._svrInfo.loginCount or 0
end

function Activity241Model:votedCount()
	return self._svrInfo.votedCount or 0
end

function Activity241Model:getBonusVotes()
	return self._svrInfo.getBonusVotes or -1
end

function Activity241Model:isDayOpen(day)
	return day <= self:loginCount()
end

function Activity241Model:onReceiveAct241GetInfoReply(msg)
	self._svrInfo = msg

	self:_onReceiveAct241GetInfoReply(msg)
end

function Activity241Model:onReceiveAct241VoteReply(msg)
	if isDebugBuild then
		assert(self:activityId() == msg.activityId)
	end

	rawset(self._svrInfo, "votedCount", self:votedCount() + msg.voteNum)
	self:_onReceiveAct241VoteReply(msg)
end

function Activity241Model:onReceiveAct241GetBonusReply(msg)
	if isDebugBuild then
		assert(self:activityId() == msg.activityId)
	end

	rawset(self._svrInfo, "getBonusVotes", msg.getBonusVotes)
	self:_onReceiveAct241GetBonusReply(msg)
end

function Activity241Model:_onReceiveAct241GetInfoReply(...)
	return
end

function Activity241Model:_onReceiveAct241VoteReply(...)
	return
end

function Activity241Model:_onReceiveAct241GetBonusReply(...)
	return
end

return Activity241Model
