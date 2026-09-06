-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/agent/FormPredictionAgent.lua

module("logic.extensions.formprediction.agent.FormPredictionAgent", package.seeall)

local FormPredictionAgent = class("FormPredictionAgent", BaseAgent)

function FormPredictionAgent:sendPM_FormPredictionGetInfoReq(activityId)
	local req = FormPredictionExtension_pb.PM_FormPredictionGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FormPredictionAgent:handlePM_FormPredictionGetInfoRes(status, msg)
	if status == 0 then
		FormPredictionController.instance:onGetInfo(msg)
	end
end

function FormPredictionAgent:sendPM_FormPredictionSetFormReq(activityId, formId, petIdsOnForm_i32_Ary)
	local req = FormPredictionExtension_pb.PM_FormPredictionSetFormReq()

	req.activityId = activityId
	req.formId = formId

	for i, v1 in ipairs(petIdsOnForm_i32_Ary) do
		req.petIdsOnForm:append(v1)
	end

	self:sendMsg(req)
end

function FormPredictionAgent:handlePM_FormPredictionSetFormRes(status, msg)
	if status == 0 then
		FormPredictionController.instance:onSetForm(msg)
	end
end

function FormPredictionAgent:sendPM_FormPredictionGainPrizeReq(activityId, formId)
	local req = FormPredictionExtension_pb.PM_FormPredictionGainPrizeReq()

	req.activityId = activityId
	req.formId = formId

	self:sendMsg(req)
end

function FormPredictionAgent:handlePM_FormPredictionGainPrizeRes(status, msg)
	if status == 0 then
		FormPredictionController.instance:onGetPrize(msg)
	end
end

function FormPredictionAgent:sendPM_FormPredictionGetSelectRatioReq(activityId, formId)
	local req = FormPredictionExtension_pb.PM_FormPredictionGetSelectRatioReq()

	req.activityId = activityId
	req.formId = formId

	self:sendMsg(req)
end

function FormPredictionAgent:handlePM_FormPredictionGetSelectRatioRes(status, msg)
	if status == 0 then
		FormPredictionController.instance:onGetRatio(msg)
	end
end

function FormPredictionAgent:sendPM_FormPredictionRankViewReq(activityId, formId)
	local req = FormPredictionExtension_pb.PM_FormPredictionRankViewReq()

	req.activityId = activityId
	req.formId = formId

	self:sendMsg(req)
end

function FormPredictionAgent:handlePM_FormPredictionRankViewRes(status, msg)
	if status == 0 then
		FormPredictionController.instance:onGetRank(msg)
	end
end

FormPredictionAgent.instance = FormPredictionAgent.New()

return FormPredictionAgent
