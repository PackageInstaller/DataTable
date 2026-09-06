-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/agent/DivineEmpressChallengeAgent.lua

module("logic.extensions.divineempresschallenge.agent.DivineEmpressChallengeAgent", package.seeall)

local DivineEmpressChallengeAgent = class("DivineEmpressChallengeAgent", BaseAgent)

function DivineEmpressChallengeAgent:sendPM_DivineEmpressClgGetInfoReq(activityId)
	local req = DivineEmpressChallengeExtension_pb.PM_DivineEmpressClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineEmpressChallengeAgent:handlePM_DivineEmpressClgGetInfoRes(status, msg)
	if status == 0 then
		DivineEmpressController.instance:handlePM_DivineEmpressClgGetInfoRes(msg)
	end
end

function DivineEmpressChallengeAgent:sendPM_DivineEmpressResetNormalClgBuffReq(activityId, stageId)
	local req = DivineEmpressChallengeExtension_pb.PM_DivineEmpressResetNormalClgBuffReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineEmpressChallengeAgent:handlePM_DivineEmpressResetNormalClgBuffRes(status, msg)
	if status == 0 then
		DivineEmpressController.instance:handlePM_DivineEmpressResetNormalClgBuffRes(msg)
	end
end

function DivineEmpressChallengeAgent:sendPM_DivineEmpressGainProgreePrizeReq(activityId, progressPrizeId)
	local req = DivineEmpressChallengeExtension_pb.PM_DivineEmpressGainProgreePrizeReq()

	req.activityId = activityId
	req.progressPrizeId = progressPrizeId

	self:sendMsg(req)
end

function DivineEmpressChallengeAgent:handlePM_DivineEmpressGainProgreePrizeRes(status, msg)
	if status == 0 then
		DivineEmpressController.instance:handlePM_DivineEmpressGainProgreePrizeRes(msg)
	end
end

function DivineEmpressChallengeAgent:sendPM_DivineEmpressExtremeClgReq(activityId, stageId, form, positiveBuffId, negativeBuffId)
	local req = DivineEmpressChallengeExtension_pb.PM_DivineEmpressExtremeClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.positiveBuffId = positiveBuffId
	req.negativeBuffId = negativeBuffId

	self:sendMsg(req)
end

function DivineEmpressChallengeAgent:handlePM_DivineEmpressExtremeClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineEmpressChallengeAgent:handlePM_DivineEmpressNotifyExtremeClgRes(status, msg)
	if status == 0 then
		DivineEmpressController.instance:handlePM_DivineEmpressNotifyExtremeClgRes(msg)
	end
end

function DivineEmpressChallengeAgent:sendPM_DivineEmpressNormalClgReq(activityId, stageId, form)
	local req = DivineEmpressChallengeExtension_pb.PM_DivineEmpressNormalClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineEmpressChallengeAgent:handlePM_DivineEmpressNormalClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineEmpressChallengeAgent:handlePM_DivineEmpressNotifyNormalClgRes(status, msg)
	if status == 0 then
		DivineEmpressController.instance:handlePM_DivineEmpressNotifyNormalClgRes(msg)
	end
end

function DivineEmpressChallengeAgent:sendPM_DivineEmpressResetExtremeStageReq(activityId, stageId)
	local req = DivineEmpressChallengeExtension_pb.PM_DivineEmpressResetExtremeStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineEmpressChallengeAgent:handlePM_DivineEmpressResetExtremeStageRes(status, msg)
	if status == 0 then
		DivineEmpressController.instance:handlePM_DivineEmpressResetExtremeStageRes(msg)
	end
end

DivineEmpressChallengeAgent.instance = DivineEmpressChallengeAgent.New()

return DivineEmpressChallengeAgent
