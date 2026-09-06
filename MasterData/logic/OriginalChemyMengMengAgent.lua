-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/agent/OriginalChemyMengMengAgent.lua

module("logic.extensions.originalchemymengmeng.agent.OriginalChemyMengMengAgent", package.seeall)

local OriginalChemyMengMengAgent = class("OriginalChemyMengMengAgent", BaseAgent)

function OriginalChemyMengMengAgent:sendPM_OriginAlchemyMengMengGetInfoReq(activityId)
	local req = OriginAlchemyMengMengExtension_pb.PM_OriginAlchemyMengMengGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginalChemyMengMengAgent:handlePM_OriginAlchemyMengMengGetInfoRes(status, msg)
	if status == 0 then
		OriginalChemyMengMengController.instance:handlePM_OriginAlchemyMengMengGetInfoRes(msg)
	end
end

function OriginalChemyMengMengAgent:sendPM_OriginAlchemyMengMengResetReq(activityId)
	local req = OriginAlchemyMengMengExtension_pb.PM_OriginAlchemyMengMengResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginalChemyMengMengAgent:handlePM_OriginAlchemyMengMengResetRes(status, msg)
	if status == 0 then
		OriginalChemyMengMengController.instance:handlePM_OriginAlchemyMengMengResetRes(msg)
	end
end

function OriginalChemyMengMengAgent:sendPM_OriginAlchemyMengMengChallengeReq(activityId, stageId, useReagentId, form)
	local req = OriginAlchemyMengMengExtension_pb.PM_OriginAlchemyMengMengChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.useReagentId = useReagentId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginalChemyMengMengAgent:handlePM_OriginAlchemyMengMengChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginalChemyMengMengAgent:sendPM_OriginAlchemyMengMengSmeltReagentReq(activityId, reagentId)
	local req = OriginAlchemyMengMengExtension_pb.PM_OriginAlchemyMengMengSmeltReagentReq()

	req.activityId = activityId
	req.reagentId = reagentId

	self:sendMsg(req)
end

function OriginalChemyMengMengAgent:handlePM_OriginAlchemyMengMengSmeltReagentRes(status, msg)
	if status == 0 then
		OriginalChemyMengMengController.instance:handlePM_OriginAlchemyMengMengSmeltReagentRes(msg)
	end
end

function OriginalChemyMengMengAgent:handlePM_OriginAlchemyMengMengNotifyClgRes(status, msg)
	if status == 0 then
		OriginalChemyMengMengController.instance:handlePM_OriginAlchemyMengMengNotifyClgRes(msg)
	end
end

OriginalChemyMengMengAgent.instance = OriginalChemyMengMengAgent.New()

return OriginalChemyMengMengAgent
