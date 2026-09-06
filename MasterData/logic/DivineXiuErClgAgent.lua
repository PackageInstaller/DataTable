-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/agent/DivineXiuErClgAgent.lua

module("logic.extensions.divinexiuerclg.agent.DivineXiuErClgAgent", package.seeall)

local DivineXiuErClgAgent = class("DivineXiuErClgAgent", BaseAgent)

function DivineXiuErClgAgent:sendPM_DivineXiuErClgGetInfoReq(activityId)
	local req = DivineXiuErChallengeExtension_pb.PM_DivineXiuErClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineXiuErClgAgent:handlePM_DivineXiuErClgGetInfoRes(status, msg)
	if status == 0 then
		DivineXiuErClgController.instance:handlePM_DivineXiuErClgGetInfoRes(msg)
	end
end

function DivineXiuErClgAgent:sendPM_DivineXiuErClgNormalFightReq(activityId, dataBitId, form)
	local req = DivineXiuErChallengeExtension_pb.PM_DivineXiuErClgNormalFightReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineXiuErClgAgent:handlePM_DivineXiuErClgNormalFightRes(status, msg)
	DivineXiuErClgController.instance:handlePM_DivineXiuErClgNormalFightRes(status, msg)
end

function DivineXiuErClgAgent:handlePM_DivineXiuErClgNotifyNormalFightResultRes(status, msg)
	if status == 0 then
		DivineXiuErClgController.instance:handlePM_DivineXiuErClgNotifyNormalFightResultRes(msg)
	end
end

function DivineXiuErClgAgent:sendPM_DivineXiuErClgExtremeFightReq(activityId, dataBitId, form)
	local req = DivineXiuErChallengeExtension_pb.PM_DivineXiuErClgExtremeFightReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineXiuErClgAgent:handlePM_DivineXiuErClgExtremeFightRes(status, msg)
	DivineXiuErClgController.instance:handlePM_DivineXiuErClgExtremeFightRes(status, msg)
end

function DivineXiuErClgAgent:handlePM_DivineXiuErClgNotifyExtremeFightResultRes(status, msg)
	if status == 0 then
		DivineXiuErClgController.instance:handlePM_DivineXiuErClgNotifyExtremeFightResultRes(msg)
	end
end

function DivineXiuErClgAgent:sendPM_DivineXiuErExtremeFightConfirmReq(activityId, confirmNum, save)
	local req = DivineXiuErChallengeExtension_pb.PM_DivineXiuErExtremeFightConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function DivineXiuErClgAgent:handlePM_DivineXiuErExtremeFightConfirmRes(status, msg)
	if status == 0 then
		DivineXiuErClgController.instance:handlePM_DivineXiuErExtremeFightConfirmRes(msg)
	end
end

function DivineXiuErClgAgent:sendPM_DivineXiuErResetExtremeClgStageReq(activityId, dataBitId)
	local req = DivineXiuErChallengeExtension_pb.PM_DivineXiuErResetExtremeClgStageReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function DivineXiuErClgAgent:handlePM_DivineXiuErResetExtremeClgStageRes(status, msg)
	if status == 0 then
		DivineXiuErClgController.instance:handlePM_DivineXiuErResetExtremeClgStageRes(msg)
	end
end

function DivineXiuErClgAgent:sendPM_DivineXiuErGainNormalClgPrizeReq(activityId)
	local req = DivineXiuErChallengeExtension_pb.PM_DivineXiuErGainNormalClgPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineXiuErClgAgent:handlePM_DivineXiuErGainNormalClgPrizeRes(status, msg)
	if status == 0 then
		DivineXiuErClgController.instance:handlePM_DivineXiuErGainNormalClgPrizeRes(msg)
	end
end

function DivineXiuErClgAgent:sendPM_DivineXiuErGainExtremeClgPrizeReq(activityId)
	local req = DivineXiuErChallengeExtension_pb.PM_DivineXiuErGainExtremeClgPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineXiuErClgAgent:handlePM_DivineXiuErGainExtremeClgPrizeRes(status, msg)
	if status == 0 then
		DivineXiuErClgController.instance:handlePM_DivineXiuErGainExtremeClgPrizeRes(msg)
	end
end

DivineXiuErClgAgent.instance = DivineXiuErClgAgent.New()

return DivineXiuErClgAgent
