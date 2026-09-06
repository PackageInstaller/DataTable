-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/agent/MasterFormAgent.lua

module("logic.extensions.masterform.agent.MasterFormAgent", package.seeall)

local MasterFormAgent = class("MasterFormAgent", BaseAgent)

function MasterFormAgent:sendPM_MasterFormViewFormReq(period, fmtType)
	local req = MasterFormExtension_pb.PM_MasterFormViewFormReq()

	req.period = period
	req.fmtType = fmtType

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormViewFormRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormViewFormRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormGetMyFormReq(period)
	local req = MasterFormExtension_pb.PM_MasterFormGetMyFormReq()

	req.period = period

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormGetMyFormRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormGetMyFormRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormGetCollectionFormReq(period)
	local req = MasterFormExtension_pb.PM_MasterFormGetCollectionFormReq()

	req.period = period

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormGetCollectionFormRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormGetCollectionFormRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormgetCommentsReq(period, formId)
	local req = MasterFormExtension_pb.PM_MasterFormgetCommentsReq()

	req.period = period
	req.formId = formId

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormgetCommentsRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormgetCommentsRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormKudoFormReq(period, formId)
	local req = MasterFormExtension_pb.PM_MasterFormKudoFormReq()

	req.period = period
	req.formId = formId

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormKudoFormRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormKudoFormRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormKudoCommentReq(period, formId, commentId)
	local req = MasterFormExtension_pb.PM_MasterFormKudoCommentReq()

	req.period = period
	req.formId = formId
	req.commentId = commentId

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormKudoCommentRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormKudoCommentRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormSubmitFormReq(period, formMsg)
	local req = MasterFormExtension_pb.PM_MasterFormSubmitFormReq()

	req.period = period

	req.formMsg:ParseFromString(formMsg:SerializeToString())
	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormSubmitFormRes(status, msg)
	MasterFormController.instance:handlePM_MasterFormSubmitFormRes(status, msg)
end

function MasterFormAgent:sendPM_MasterFormRevokeReq(period, formId)
	local req = MasterFormExtension_pb.PM_MasterFormRevokeReq()

	req.period = period
	req.formId = formId

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormRevokeRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormRevokeRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormCollectReq(period, formId, type)
	local req = MasterFormExtension_pb.PM_MasterFormCollectReq()

	req.period = period
	req.formId = formId
	req.type = type

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormCollectRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormCollectRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormCancelCollectReq(period, formId, type)
	local req = MasterFormExtension_pb.PM_MasterFormCancelCollectReq()

	req.period = period
	req.formId = formId
	req.type = type

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormCancelCollectRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormCancelCollectRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormGetBaseInfoReq(period)
	local req = MasterFormExtension_pb.PM_MasterFormGetBaseInfoReq()

	req.period = period

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormGetBaseInfoRes(status, msg)
	if status == 0 then
		MasterFormController.instance:handlePM_MasterFormGetBaseInfoRes(msg)
	end
end

function MasterFormAgent:sendPM_MasterFormCommentReq(period, formId, content)
	local req = MasterFormExtension_pb.PM_MasterFormCommentReq()

	req.period = period
	req.formId = formId
	req.content = content

	self:sendMsg(req)
end

function MasterFormAgent:handlePM_MasterFormCommentRes(status, msg)
	MasterFormController.instance:handlePM_MasterFormCommentRes(status, msg)
end

function MasterFormAgent:handlePM_MasterFormNotifyCommnetRes(status, msg)
	MasterFormController.instance:handlePM_MasterFormNotifyCommnetRes(status, msg)
end

function MasterFormAgent:handlePM_MasterFormNotifySubmitFormRes(status, msg)
	MasterFormController.instance:handlePM_MasterFormNotifySubmitFormRes(status, msg)
end

MasterFormAgent.instance = MasterFormAgent.New()

return MasterFormAgent
