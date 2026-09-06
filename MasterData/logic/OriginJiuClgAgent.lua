-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/agent/OriginJiuClgAgent.lua

module("logic.extensions.originjiuclg.agent.OriginJiuClgAgent", package.seeall)

local OriginJiuClgAgent = class("OriginJiuClgAgent", BaseAgent)

function OriginJiuClgAgent:sendPM_OriginJiuClgInfoReq(activityId)
	local req = OriginJiuClgExtension_pb.PM_OriginJiuClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginJiuClgAgent:handlePM_OriginJiuClgInfoRes(status, msg)
	if status == 0 then
		OriginJiuController.instance:onGetInfo(msg)
	end
end

function OriginJiuClgAgent:sendPM_OriginJiuClgChallengeReq(activityId, modelId, phaseId, stageId, stageRoad, forms_pb_Ary)
	local req = OriginJiuClgExtension_pb.PM_OriginJiuClgChallengeReq()

	req.activityId = activityId
	req.modelId = modelId
	req.phaseId = phaseId
	req.stageId = stageId
	req.stageRoad = stageRoad

	if forms_pb_Ary ~= nil then
		for i, v1 in ipairs(forms_pb_Ary) do
			local forms = req.forms:add()

			forms:ParseFromString(v1:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function OriginJiuClgAgent:handlePM_OriginJiuClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginJiuClgAgent:handlePM_NotifyOriginJiuClgChallengeFinishRes(status, msg)
	if status == 0 then
		OriginJiuController.instance:handlePM_NotifyOriginJiuClgChallengeFinishRes(msg)
	end
end

function OriginJiuClgAgent:sendPM_OriginJiuClgBossChallengeReq(activityId, modelId, form_pb)
	local req = OriginJiuClgExtension_pb.PM_OriginJiuClgBossChallengeReq()

	req.activityId = activityId
	req.modelId = modelId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginJiuClgAgent:handlePM_OriginJiuClgBossChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginJiuClgAgent:handlePM_NotifyOriginJiuClgBossFinishRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginJiuClgAgent:sendPM_OriginJiuClgPhaseResetReq(activityId, modelId, phaseId)
	local req = OriginJiuClgExtension_pb.PM_OriginJiuClgPhaseResetReq()

	req.activityId = activityId
	req.modelId = modelId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function OriginJiuClgAgent:handlePM_OriginJiuClgPhaseResetRes(status, msg)
	if status == 0 then
		OriginJiuController.instance:handlePM_OriginJiuClgPhaseResetRes(msg)
	end
end

function OriginJiuClgAgent:sendPM_OriginJiuClgResetReq(activityId, modelId)
	local req = OriginJiuClgExtension_pb.PM_OriginJiuClgResetReq()

	req.activityId = activityId
	req.modelId = modelId

	self:sendMsg(req)
end

function OriginJiuClgAgent:handlePM_OriginJiuClgResetRes(status, msg)
	if status == 0 then
		OriginJiuController.instance:handlePM_OriginJiuClgResetRes(msg)
	end
end

OriginJiuClgAgent.instance = OriginJiuClgAgent.New()

return OriginJiuClgAgent
