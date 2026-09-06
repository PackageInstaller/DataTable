-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/agent/DualTrialAgent.lua

module("logic.extensions.dualtrial.agent.DualTrialAgent", package.seeall)

local DualTrialAgent = class("DualTrialAgent", BaseAgent)

function DualTrialAgent:sendPM_DualTrialGetInfoReq(activityId)
	local req = DualTrialExtension_pb.PM_DualTrialGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DualTrialAgent:handlePM_DualTrialGetInfoRes(status, msg)
	if status == 0 then
		DualTrialController.instance:handleGetInfo(msg)
	end
end

function DualTrialAgent:sendPM_DualTrialBeginEventReq(activityId)
	local req = DualTrialExtension_pb.PM_DualTrialBeginEventReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DualTrialAgent:handlePM_DualTrialBeginEventRes(status, msg)
	if status == 0 then
		DualTrialController.instance:handleBeginEvent(msg)
	end
end

function DualTrialAgent:sendPM_DualTrialEndEventReq(activityId)
	local req = DualTrialExtension_pb.PM_DualTrialEndEventReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DualTrialAgent:handlePM_DualTrialEndEventRes(status, msg)
	if status == 0 then
		DualTrialController.instance:handleEndEvent(msg)
	end
end

function DualTrialAgent:sendPM_DualTrialVisitBlockReq(activityId)
	local req = DualTrialExtension_pb.PM_DualTrialVisitBlockReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DualTrialAgent:handlePM_DualTrialVisitBlockRes(status, msg)
	if status == 0 then
		DualTrialController.instance:handleVisitBlock(msg)
	end
end

function DualTrialAgent:sendPM_DualTrialFightReq(activityId, form)
	local req = DualTrialExtension_pb.PM_DualTrialFightReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DualTrialAgent:handlePM_DualTrialFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DualTrialAgent:handlePM_DualTrialNotifyFightRes(status, msg)
	if status == 0 then
		DualTrialController.instance:handleNotifyFightRes(msg)
	end
end

function DualTrialAgent:sendPM_DualTrialGainPrizeReq(activityId, prizeId)
	local req = DualTrialExtension_pb.PM_DualTrialGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DualTrialAgent:handlePM_DualTrialGainPrizeRes(status, msg)
	if status == 0 then
		DualTrialController.instance:handleGainPrize(msg)
	end
end

DualTrialAgent.instance = DualTrialAgent.New()

return DualTrialAgent
