-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/agent/DivineJiClgAgent.lua

module("logic.extensions.divinejiclg.agent.DivineJiClgAgent", package.seeall)

local DivineJiClgAgent = class("DivineJiClgAgent", BaseAgent)

function DivineJiClgAgent:sendPM_DivineJiClgGetInfoReq(activityId)
	local req = DivineJiClgExtension_pb.PM_DivineJiClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineJiClgAgent:handlePM_DivineJiClgGetInfoRes(status, msg)
	if status == 0 then
		DivineJiClgModel.instance:onDivineJiClgGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineJiClgGetInfoRes)
	end
end

function DivineJiClgAgent:sendPM_DivineJiExtremeFightReq(activityId, stageId, form)
	local req = DivineJiClgExtension_pb.PM_DivineJiExtremeFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineJiClgAgent:handlePM_DivineJiExtremeFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineJiClgAgent:handlePM_DivineJiNotifyExtremeFightResultRes(status, msg)
	if status == 0 then
		DivineJiClgController.instance:onDivineJiNotifyExtremeFightResultRes(msg)
	end
end

function DivineJiClgAgent:sendPM_DivineJiResetExtremeClgStageReq(activityId, stageId)
	local req = DivineJiClgExtension_pb.PM_DivineJiResetExtremeClgStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineJiClgAgent:handlePM_DivineJiResetExtremeClgStageRes(status, msg)
	if status == 0 then
		DivineJiClgModel.instance:onDivineJiClgResetExtremeClgStageRes(msg)
	end
end

function DivineJiClgAgent:sendPM_DivineJiNormalFightReq(activityId, teamOrderId, form)
	local req = DivineJiClgExtension_pb.PM_DivineJiNormalFightReq()

	req.activityId = activityId
	req.teamOrderId = teamOrderId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineJiClgAgent:handlePM_DivineJiNormalFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineJiClgAgent:handlePM_DivineJiNotifyNormalFightResultRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineJiClgAgent:sendPM_DivineJiGainNormalClgPrizeReq(activityId, dataBitId)
	local req = DivineJiClgExtension_pb.PM_DivineJiGainNormalClgPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function DivineJiClgAgent:handlePM_DivineJiGainNormalClgPrizeRes(status, msg)
	if status == 0 then
		DivineJiClgModel.instance:onDivineJiGainNormalClgPrizeRes(msg)
	end
end

DivineJiClgAgent.instance = DivineJiClgAgent.New()

return DivineJiClgAgent
