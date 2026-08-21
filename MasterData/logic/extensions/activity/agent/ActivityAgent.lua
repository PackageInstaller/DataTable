-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activity/agent/ActivityAgent.lua

module("logic.extensions.activity.agent.ActivityAgent", package.seeall)

local M = class("ActivityAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGetActivityInfoRequest()
	local msg = ActivityExtension_pb.GetActivityInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetActivityInfoReply(status, msg)
	if status == 0 then
		local activities = msg.activities

		ActivityController.instance:refreshActivity(activities)
	end
end

function M:handleChangeActivityPush(status, msg)
	if status == 0 then
		local opened = msg.opened
		local closed = msg.closed

		ActivityController.instance:refreshActivity(opened, closed)
	end
end

function M:sendGetScoreActivityInfoRequest()
	local msg = ActivityExtension_pb.GetScoreActivityInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetScoreActivityInfoReply(status, msg)
	if status == 0 then
		ActivityIntegralDropController.instance:handleIntegralDropRewardReply(msg.infos)
	end
end

function M:sendGainScoreActivityRewardRequest(msgTable)
	local msg = ActivityExtension_pb.GainScoreActivityRewardRequest()

	msg.index = msgTable.index
	msg.activity = msgTable.activity

	self:sendMsg(msg)

	self._integralDropIndex = msgTable.index + 1
end

function M:handleGainScoreActivityRewardReply(status, msg)
	if status == 0 then
		ActivityIntegralDropController.instance:handleIntegralDropRewardReceivingReply(self._integralDropIndex)
	end
end

function M:sendTakeWeekendSuppliesRequest(actConfigId, Day)
	local cfg = ActivityExtension_pb.TakeWeekendSuppliesRequest()

	cfg.actConfigId = actConfigId
	cfg.day = Day

	self:sendMsg(cfg)
end

function M:handleTakeWeekendSuppliesReply(status, msg)
	if status == 0 then
		local activityData = ActivityController.instance:getActivityByLogicTypeAndCode(ActivityEnum.LogicType.WEEKEND_SUPPLIES, msg.actConfigId)

		if activityData then
			activityData:setOneFinish(msg.day)
			GlobalDispatcher:dispatchEvent(EventType.WEEKEND_SUPPLIES)
		end
	end
end

function M:handleDungeonRewardUpCountPush(status, msg)
	if status then
		MultipleDropController.instance:setMultipleDropController(msg)
	end
end

M.instance = M.New()

return M
