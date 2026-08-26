-- chunkname: @modules/logic/versionactivity2_1/activity165/rpc/Activity165Rpc.lua

module("modules.logic.versionactivity2_1.activity165.rpc.Activity165Rpc", package.seeall)

local Activity165Rpc = class("Activity165Rpc", BaseRpc)

function Activity165Rpc:onReceiveAct165StoryInfo(resultCode, msg)
	if resultCode == 0 then
		Activity165Model.instance:onGetStoryInfo(msg)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165StoryInfo, msg)
	end
end

function Activity165Rpc:sendAct165GetInfoRequest(activityId, callback, callbackObj)
	local req = Activity165Module_pb.Act165GetInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity165Rpc:onReceiveAct165GetInfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity165Model.instance:onGetInfo(msg.activityId, msg.storyInfos)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165GetInfoReply, msg)
		Activity165Controller.instance:dispatchEvent(Activity165Event.refreshStoryReddot)
	end
end

function Activity165Rpc:sendAct165ModifyKeywordRequest(activityId, storyId, keywordIds)
	local req = Activity165Module_pb.Act165ModifyKeywordRequest()

	req.activityId = activityId
	req.storyId = storyId

	for i, id in pairs(keywordIds) do
		req.keywordIds:append(id)
	end

	self:sendMsg(req)
end

function Activity165Rpc:onReceiveAct165ModifyKeywordReply(resultCode, msg)
	if resultCode == 0 then
		Activity165Model.instance:onModifyKeywordCallback(msg.activityId, msg.storyInfo)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165ModifyKeywordReply, msg)
	end
end

function Activity165Rpc:sendAct165GenerateEndingRequest(activityId, storyId)
	local req = Activity165Module_pb.Act165GenerateEndingRequest()

	req.activityId = activityId
	req.storyId = storyId

	self:sendMsg(req)
end

function Activity165Rpc:onReceiveAct165GenerateEndingReply(resultCode, msg)
	if resultCode == 0 then
		Activity165Model.instance:onGenerateEnding(msg.activityId, msg.storyId, msg.endingInfo)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165GenerateEndingReply, msg)
	end
end

function Activity165Rpc:sendAct165RestartRequest(activityId, storyId, stepId)
	local req = Activity165Module_pb.Act165RestartRequest()

	req.activityId = activityId
	req.storyId = storyId
	req.stepId = stepId

	self:sendMsg(req)
end

function Activity165Rpc:onReceiveAct165RestartReply(resultCode, msg)
	if resultCode == 0 then
		Activity165Model.instance:onRestart(msg.activityId, msg.storyInfo)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165RestartReply, msg)
	end
end

function Activity165Rpc:sendAct165GainMilestoneRewardRequest(activityId, storyId)
	local req = Activity165Module_pb.Act165GainMilestoneRewardRequest()

	req.activityId = activityId
	req.storyId = storyId

	self:sendMsg(req)
end

function Activity165Rpc:onReceiveAct165GainMilestoneRewardReply(resultCode, msg)
	if resultCode == 0 then
		Activity165Model.instance:onGetReward(msg.activityId, msg.storyId, msg.gainedEndingCount)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165GainMilestoneRewardReply, msg)
		Activity165Controller.instance:dispatchEvent(Activity165Event.refreshStoryReddot)
	end
end

Activity165Rpc.instance = Activity165Rpc.New()

return Activity165Rpc
