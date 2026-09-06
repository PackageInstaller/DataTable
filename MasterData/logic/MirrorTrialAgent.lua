-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/agent/MirrorTrialAgent.lua

module("logic.extensions.mirrortrial.agent.MirrorTrialAgent", package.seeall)

local MirrorTrialAgent = class("MirrorTrialAgent", BaseAgent)

function MirrorTrialAgent:sendPM_GetMirrorTrialInfoReq(activityId)
	local req = MirrorTrialExtension_pb.PM_GetMirrorTrialInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MirrorTrialAgent:handlePM_GetMirrorTrialInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	MirrorTrialController.instance:handleGetInfo(status, msg)
end

function MirrorTrialAgent:sendPM_MirrorTrialFightReq(activityId, stageId)
	local req = MirrorTrialExtension_pb.PM_MirrorTrialFightReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function MirrorTrialAgent:handlePM_MirrorTrialFightRes(status, msg)
	if status == 0 then
		-- block empty
	end

	MirrorTrialController.instance:handleStartFight(status, msg)
end

function MirrorTrialAgent:sendPM_MirrorTrialGainPrizeReq(activityId)
	local req = MirrorTrialExtension_pb.PM_MirrorTrialGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MirrorTrialAgent:handlePM_MirrorTrialGainPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	MirrorTrialController.instance:handleGainPrize(status, msg)
end

function MirrorTrialAgent:sendPM_MirrorTrialBuyScoreReq(activityId, buyCount)
	local req = MirrorTrialExtension_pb.PM_MirrorTrialBuyScoreReq()

	req.activityId = activityId
	req.buyCount = buyCount

	self:sendMsg(req)
end

function MirrorTrialAgent:handlePM_MirrorTrialBuyScoreRes(status, msg)
	if status == 0 then
		-- block empty
	end

	MirrorTrialController.instance:handleBuyScore(status, msg)
end

function MirrorTrialAgent:handlePM_MirrorTrialNotifyFightResult(status, msg)
	if status == 0 then
		-- block empty
	end

	MirrorTrialController.instance:notifyFightResult(status, msg)
end

function MirrorTrialAgent:handlePM_MirrorTrialNotifyPaySucRes(status, msg)
	if status == 0 then
		-- block empty
	end

	MirrorTrialController.instance:notifyPaySuc(status, msg)
end

MirrorTrialAgent.instance = MirrorTrialAgent.New()

return MirrorTrialAgent
