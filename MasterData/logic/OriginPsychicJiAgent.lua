-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/agent/OriginPsychicJiAgent.lua

module("logic.extensions.originpsychicji.agent.OriginPsychicJiAgent", package.seeall)

local OriginPsychicJiAgent = class("OriginPsychicJiAgent", BaseAgent)

function OriginPsychicJiAgent:sendPM_OriginPsychicJiInfoReq(activityId)
	local req = OriginPsychicJiExtension_pb.PM_OriginPsychicJiInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginPsychicJiAgent:handlePM_OriginPsychicJiInfoRes(status, msg)
	if status == 0 then
		OriginpsychicjiModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginPsychicJiInfoRes)
	end
end

function OriginPsychicJiAgent:sendPM_OriginPsychicJiResetExtStageReq(activityId)
	local req = OriginPsychicJiExtension_pb.PM_OriginPsychicJiResetExtStageReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginPsychicJiAgent:handlePM_OriginPsychicJiResetExtStageRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginPsychicJiResetExtStageRes)
	end
end

function OriginPsychicJiAgent:sendPM_OriginPsyChicJiCommonClgReq(activityId, form, stageId)
	local req = OriginPsychicJiExtension_pb.PM_OriginPsyChicJiCommonClgReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.stageId = stageId

	self:sendMsg(req)
end

function OriginPsychicJiAgent:handlePM_OriginPsyChicJiCommonClgRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginPsyChicJiCommonClgRes)
	end
end

function OriginPsychicJiAgent:handlePM_OriginPsychicJiNotifyCommonClgRes(status, msg)
	if status == 0 then
		OriginpsychicjiModel.instance:onNotifyCommonClgRes(msg)
		OriginpsychicjiController.instance:onNotifyCommonClgRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginPsychicJiNotifyCommonClgRes)
	end
end

function OriginPsychicJiAgent:sendPM_OriginPsyChicJiExtClgReq(activityId, form, stageId)
	local req = OriginPsychicJiExtension_pb.PM_OriginPsyChicJiExtClgReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.stageId = stageId

	self:sendMsg(req)
end

function OriginPsychicJiAgent:handlePM_OriginPsyChicJiExtClgRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginPsyChicJiExtClgRes)
	end
end

function OriginPsychicJiAgent:handlePM_OriginPsychicJiNotifyExtClgRes(status, msg)
	if status == 0 then
		OriginpsychicjiController.instance:onNotifyExtClgRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginPsychicJiNotifyExtClgRes)
	end
end

function OriginPsychicJiAgent:sendPM_OriginPsychicJiSaveReq(activityId, isSave)
	local req = OriginPsychicJiExtension_pb.PM_OriginPsychicJiSaveReq()

	req.activityId = activityId
	req.isSave = isSave

	self:sendMsg(req)
end

function OriginPsychicJiAgent:handlePM_OriginPsychicJiSaveRes(status, msg)
	if status == 0 then
		OriginpsychicjiController.instance:onSaveRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginPsychicJiSaveRes)
	end
end

OriginPsychicJiAgent.instance = OriginPsychicJiAgent.New()

return OriginPsychicJiAgent
