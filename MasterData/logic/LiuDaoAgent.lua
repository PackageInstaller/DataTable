-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/agent/LiuDaoAgent.lua

module("logic.extensions.liudao.agent.LiuDaoAgent", package.seeall)

local LiuDaoAgent = class("LiuDaoAgent", BaseAgent)

LiuDaoAgent.handlePM_LiuDaoGetInfoRes = "LiuDaoAgent.handlePM_LiuDaoGetInfoRes"
LiuDaoAgent.handlePM_LiuDaoRefreshStageRes = "LiuDaoAgent.handlePM_LiuDaoRefreshStageRes"
LiuDaoAgent.handlePM_LiuDaoChallengeRes = "LiuDaoAgent.handlePM_LiuDaoChallengeRes"
LiuDaoAgent.handlePM_LiuDaoNotifyChallengeRes = "LiuDaoAgent.handlePM_LiuDaoNotifyChallengeRes"
LiuDaoAgent.handlePM_LiuDaoGetTaskInfoRes = "LiuDaoAgent.handlePM_LiuDaoGetTaskInfoRes"
LiuDaoAgent.handlePM_LiuDaoGainTaskPrizeRes = "LiuDaoAgent.handlePM_LiuDaoGainTaskPrizeRes"
LiuDaoAgent.handlePM_LiuDaoGainProgressPrizeRes = "LiuDaoAgent.handlePM_LiuDaoGainProgressPrizeRes"

function LiuDaoAgent:sendPM_LiuDaoGetInfoReq(activityId)
	local req = LiuDaoExtension_pb.PM_LiuDaoGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LiuDaoAgent:handlePM_LiuDaoGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LiuDaoAgent.handlePM_LiuDaoGetInfoRes, status, msg)
	end
end

function LiuDaoAgent:sendPM_LiuDaoRefreshStageReq(activityId, stageIndex, expectTimes)
	local req = LiuDaoExtension_pb.PM_LiuDaoRefreshStageReq()

	req.activityId = activityId
	req.stageIndex = stageIndex
	req.expectTimes = expectTimes

	self:sendMsg(req)
end

function LiuDaoAgent:handlePM_LiuDaoRefreshStageRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LiuDaoAgent.handlePM_LiuDaoRefreshStageRes, status, msg)
	end
end

function LiuDaoAgent:sendPM_LiuDaoChallengeReq(activityId, stageType, stageIndex, form)
	local req = LiuDaoExtension_pb.PM_LiuDaoChallengeReq()

	req.activityId = activityId
	req.stageType = stageType
	req.stageIndex = stageIndex

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function LiuDaoAgent:handlePM_LiuDaoChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LiuDaoAgent.handlePM_LiuDaoChallengeRes, status, msg)
	end
end

function LiuDaoAgent:handlePM_LiuDaoNotifyChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LiuDaoAgent.handlePM_LiuDaoNotifyChallengeRes, status, msg)
	end
end

function LiuDaoAgent:sendPM_LiuDaoGetTaskInfoReq(activityId)
	local req = LiuDaoExtension_pb.PM_LiuDaoGetTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LiuDaoAgent:handlePM_LiuDaoGetTaskInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LiuDaoAgent.handlePM_LiuDaoGetTaskInfoRes, status, msg)
	end
end

function LiuDaoAgent:sendPM_LiuDaoGainTaskPrizeReq(activityId, taskId)
	local req = LiuDaoExtension_pb.PM_LiuDaoGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function LiuDaoAgent:handlePM_LiuDaoGainTaskPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LiuDaoAgent.handlePM_LiuDaoGainTaskPrizeRes, status, msg)
	end
end

function LiuDaoAgent:sendPM_LiuDaoGainProgressPrizeReq(activityId, prizeId)
	local req = LiuDaoExtension_pb.PM_LiuDaoGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function LiuDaoAgent:handlePM_LiuDaoGainProgressPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LiuDaoAgent.handlePM_LiuDaoGainProgressPrizeRes, status, msg)
	end
end

LiuDaoAgent.instance = LiuDaoAgent.New()

return LiuDaoAgent
