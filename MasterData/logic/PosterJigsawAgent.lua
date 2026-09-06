-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/agent/PosterJigsawAgent.lua

module("logic.extensions.annualactivity.agent.PosterJigsawAgent", package.seeall)

local PosterJigsawAgent = class("PosterJigsawAgent", BaseAgent)

function PosterJigsawAgent:sendPM_PJGetTaskInfoReq(activityId)
	local req = PosterJigsawExtension_pb.PM_PJGetTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PosterJigsawAgent:handlePM_PJGetTaskInfoRes(status, msg)
	if status == 0 then
		AnnualActivityController.instance:scPushPJGetTaskInfo(msg)
	end
end

function PosterJigsawAgent:sendPM_PJGainTaskPrizeReq(activityId, taskId)
	local req = PosterJigsawExtension_pb.PM_PJGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function PosterJigsawAgent:handlePM_PJGainTaskPrizeRes(status, msg)
	if status == 0 then
		AnnualActivityController.instance:scPushPJGainTaskPrize(msg)
	end
end

function PosterJigsawAgent:sendPM_PJGetPosterInfoReq(activityId)
	local req = PosterJigsawExtension_pb.PM_PJGetPosterInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PosterJigsawAgent:handlePM_PJGetPosterInfoRes(status, msg)
	if status == 0 then
		AnnualActivityController.instance:scPushPJGetPosterInfo(msg)
	end
end

function PosterJigsawAgent:sendPM_PJActivateJigsawReq(activityId, posterId, jigsawId)
	local req = PosterJigsawExtension_pb.PM_PJActivateJigsawReq()

	req.activityId = activityId
	req.posterId = posterId
	req.jigsawId = jigsawId

	self:sendMsg(req)
end

function PosterJigsawAgent:handlePM_PJActivateJigsawRes(status, msg)
	if status == 0 then
		AnnualActivityController.instance:scPushPJActivateJigsaw(msg)
	end
end

function PosterJigsawAgent:sendPM_PJGainBigPrizeReq(activityId, posterId)
	local req = PosterJigsawExtension_pb.PM_PJGainBigPrizeReq()

	req.activityId = activityId
	req.posterId = posterId

	self:sendMsg(req)
end

function PosterJigsawAgent:handlePM_PJGainBigPrizeRes(status, msg)
	if status == 0 then
		AnnualActivityController.instance:scPushPJGainBigPrize(msg)
	end
end

function PosterJigsawAgent:sendPM_PJLotteryReq(activityId)
	local req = PosterJigsawExtension_pb.PM_PJLotteryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PosterJigsawAgent:handlePM_PJLotteryRes(status, msg)
	if status == 0 then
		AnnualActivityController.instance:scPushPJLottery()
	end
end

PosterJigsawAgent.instance = PosterJigsawAgent.New()

return PosterJigsawAgent
