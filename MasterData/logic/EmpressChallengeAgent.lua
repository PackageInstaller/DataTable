-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/agent/EmpressChallengeAgent.lua

module("logic.extensions.empresschallenge.agent.EmpressChallengeAgent", package.seeall)

local EmpressChallengeAgent = class("EmpressChallengeAgent", BaseAgent)

function EmpressChallengeAgent:ctor()
	return
end

function EmpressChallengeAgent:setExtId(extId)
	EmpressChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function EmpressChallengeAgent:sendPM_EmpressClgGetInfoReq(activityId)
	local req = EmpressChallengeExtension_pb.PM_EmpressClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EmpressChallengeAgent:handlePM_EmpressClgGetInfoRes(status, msg)
	if status == 0 then
		NvdiChallengeController.instance:onGetInfo(msg)
	end
end

function EmpressChallengeAgent:sendPM_EmpressExtremeFightReq(activityId, stageId, buffIdUsed, form_pb)
	local req = EmpressChallengeExtension_pb.PM_EmpressExtremeFightReq()

	req.activityId = activityId
	req.stageId = stageId
	req.buffIdUsed = buffIdUsed

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function EmpressChallengeAgent:handlePM_EmpressExtremeFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function EmpressChallengeAgent:sendPM_EmpressResetExtremeClgStageReq(activityId, stageId)
	local req = EmpressChallengeExtension_pb.PM_EmpressResetExtremeClgStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function EmpressChallengeAgent:handlePM_EmpressResetExtremeClgStageRes(status, msg)
	if status == 0 then
		NvdiChallengeController.instance:onResetExtStage(msg)
	end
end

function EmpressChallengeAgent:sendPM_EmpressClgGainExtremePrizeReq(activityId)
	local req = EmpressChallengeExtension_pb.PM_EmpressClgGainExtremePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EmpressChallengeAgent:handlePM_EmpressClgGainExtremePrizeRes(status, msg)
	if status == 0 then
		NvdiChallengeController.instance:ondGetExtPrize(msg)
	end
end

function EmpressChallengeAgent:sendPM_EmpressNormalFightReq(activityId, dataBitId, form_pb)
	local req = EmpressChallengeExtension_pb.PM_EmpressNormalFightReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function EmpressChallengeAgent:handlePM_EmpressNormalFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function EmpressChallengeAgent:sendPM_EmpressGainNormalClgProgressPrizeReq(activityId, dataBitId)
	local req = EmpressChallengeExtension_pb.PM_EmpressGainNormalClgProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function EmpressChallengeAgent:handlePM_EmpressGainNormalClgProgressPrizeRes(status, msg)
	if status == 0 then
		NvdiChallengeController.instance:onGetProgressPrize(msg)
	end
end

function EmpressChallengeAgent:handlePM_EmpressNotifyExtremeFightResultRes(status, msg)
	NvdiChallengeController.instance:onExtFightMsg(msg)
end

function EmpressChallengeAgent:handlePM_EmpressNotifyNormalFightResultRes(status, msg)
	NvdiChallengeController.instance:onNoramlFightMsg(msg)
end

EmpressChallengeAgent.instance = EmpressChallengeAgent.New()

return EmpressChallengeAgent
