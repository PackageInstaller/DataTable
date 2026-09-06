-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/agent/KunWuAgent.lua

module("logic.extensions.kunwuclg.agent.KunWuClgAgent", package.seeall)

local KunWuClgAgent = class("KunWuClgAgent", BaseAgent)

function KunWuClgAgent:sendPM_KunWuClgGetInfoReq(activityId)
	local req = KunWuClgExtension_pb.PM_KunWuClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KunWuClgAgent:handlePM_KunWuClgGetInfoRes(status, msg)
	if status == 0 then
		KunWuController.instance:handlePM_KunWuClgGetInfoRes(msg)
	end
end

function KunWuClgAgent:sendPM_KunWuNormalFightReq(activityId, teamIndex, form)
	local req = KunWuClgExtension_pb.PM_KunWuNormalFightReq()

	req.activityId = activityId
	req.teamIndex = teamIndex

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KunWuClgAgent:handlePM_KunWuNormalFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function KunWuClgAgent:handlePM_NotifyKunWuNormalFightEndRes(status, msg)
	if status == 0 then
		KunWuController.instance:handlePM_NotifyKunWuNormalFightEndRes(msg)
	end
end

function KunWuClgAgent:sendPM_KunWuClgGainProgressPrizeReq(activityId, dataBitId)
	local req = KunWuClgExtension_pb.PM_KunWuClgGainProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function KunWuClgAgent:handlePM_KunWuClgGainProgressPrizeRes(status, msg)
	if status == 0 then
		KunWuController.instance:handlePM_KunWuClgGainProgressPrizeRes(msg)
	end
end

function KunWuClgAgent:sendPM_KunWuExtremeFightReq(activityId, phaseId, stageId, form)
	local req = KunWuClgExtension_pb.PM_KunWuExtremeFightReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KunWuClgAgent:handlePM_KunWuExtremeFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function KunWuClgAgent:handlePM_NotifyKunWuExtremeFightEndRes(status, msg)
	if status == 0 then
		KunWuController.instance:handlePM_NotifyKunWuExtremeFightEndRes(msg)
	end
end

function KunWuClgAgent:sendPM_KunWuClgConfirmReq(activityId, confirmNum, save)
	local req = KunWuClgExtension_pb.PM_KunWuClgConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function KunWuClgAgent:handlePM_KunWuClgConfirmRes(status, msg)
	if status == 0 then
		KunWuController.instance:handlePM_KunWuClgConfirmRes(msg)
	end
end

function KunWuClgAgent:sendPM_KunWuResetExtremeClgPhaseReq(activityId, phaseId)
	local req = KunWuClgExtension_pb.PM_KunWuResetExtremeClgPhaseReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function KunWuClgAgent:handlePM_KunWuResetExtremeClgPhaseRes(status, msg)
	if status == 0 then
		KunWuController.instance:handlePM_KunWuResetExtremeClgPhaseRes(msg)
	end
end

KunWuClgAgent.instance = KunWuClgAgent.New()

return KunWuClgAgent
