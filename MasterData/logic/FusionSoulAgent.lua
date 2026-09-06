-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/agent/FusionSoulAgent.lua

module("logic.extensions.fusionsoul.agent.FusionSoulAgent", package.seeall)

local FusionSoulAgent = class("FusionSoulAgent", BaseAgent)

function FusionSoulAgent:sendPM_FusionSoulGetInfoReq(activityId)
	local req = FusionSoulExtension_pb.PM_FusionSoulGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FusionSoulAgent:handlePM_FusionSoulGetInfoRes(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_FusionSoulGetInfoRes(msg)
	end
end

function FusionSoulAgent:sendPM_FusionSoulGainProgressPrizeReq(activityId, prizeId)
	local req = FusionSoulExtension_pb.PM_FusionSoulGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FusionSoulAgent:handlePM_FusionSoulGainProgressPrizeRes(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_FusionSoulGainProgressPrizeRes(msg)
	end
end

function FusionSoulAgent:sendPM_FusionSoulStartDispatchReq(eventKey)
	local req = FusionSoulExtension_pb.PM_FusionSoulStartDispatchReq()

	if eventKey ~= nil then
		req.eventKey:ParseFromString(eventKey:SerializeToString())
	end

	self:sendMsg(req)
end

function FusionSoulAgent:handlePM_FusionSoulStartDispatchRes(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_FusionSoulStartDispatchRes(msg)
	end
end

function FusionSoulAgent:sendPM_FusionSoulFinishDispatchReq(eventKey)
	local req = FusionSoulExtension_pb.PM_FusionSoulFinishDispatchReq()

	if eventKey ~= nil then
		req.eventKey:ParseFromString(eventKey:SerializeToString())
	end

	self:sendMsg(req)
end

function FusionSoulAgent:handlePM_FusionSoulFinishDispatchRes(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_FusionSoulFinishDispatchRes(msg)
	end
end

function FusionSoulAgent:sendPM_FusionSoulBattleReq(eventKey, form)
	local req = FusionSoulExtension_pb.PM_FusionSoulBattleReq()

	if eventKey ~= nil then
		req.eventKey:ParseFromString(eventKey:SerializeToString())
	end

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FusionSoulAgent:handlePM_FusionSoulBattleRes(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_FusionSoulBattleRes(msg)
	end
end

function FusionSoulAgent:sendPM_FusionSoulFinishMissionReq(eventKey)
	local req = FusionSoulExtension_pb.PM_FusionSoulFinishMissionReq()

	if eventKey ~= nil then
		req.eventKey:ParseFromString(eventKey:SerializeToString())
	end

	self:sendMsg(req)
end

function FusionSoulAgent:handlePM_FusionSoulFinishMissionRes(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_FusionSoulFinishMissionRes(msg)
	end
end

function FusionSoulAgent:sendPM_FusionSoulSelectAnswerReq(eventKey, answerId)
	local req = FusionSoulExtension_pb.PM_FusionSoulSelectAnswerReq()

	if eventKey ~= nil then
		req.eventKey:ParseFromString(eventKey:SerializeToString())
	end

	req.answerId = answerId

	self:sendMsg(req)
end

function FusionSoulAgent:handlePM_FusionSoulSelectAnswerRes(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_FusionSoulSelectAnswerRes(msg)
	end
end

function FusionSoulAgent:sendPM_FusionSoulFinishFinalEventReq(eventKey)
	local req = FusionSoulExtension_pb.PM_FusionSoulFinishFinalEventReq()

	if eventKey ~= nil then
		req.eventKey:ParseFromString(eventKey:SerializeToString())
	end

	self:sendMsg(req)
end

function FusionSoulAgent:handlePM_FusionSoulFinishFinalEventRes(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_FusionSoulFinishFinalEventRes(msg)
	end
end

function FusionSoulAgent:sendPM_FusionSoulCombineClueReq(activityId, clueId)
	local req = FusionSoulExtension_pb.PM_FusionSoulCombineClueReq()

	req.activityId = activityId

	for i, v in ipairs(clueId) do
		req.clueId:append(v)
	end

	self:sendMsg(req)
end

function FusionSoulAgent:handlePM_FusionSoulCombineClueRes(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_FusionSoulCombineClueRes(msg)
	end
end

function FusionSoulAgent:handlePM_Notify_FusionSoulChallengeResult(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_Notify_FusionSoulChallengeResult(msg)
	end
end

function FusionSoulAgent:handlePM_Notify_FusionSoulClueGain(status, msg)
	if status == 0 then
		FusionSoulController.instance:handlePM_Notify_FusionSoulClueGain(msg)
	end
end

FusionSoulAgent.instance = FusionSoulAgent.New()

return FusionSoulAgent
