-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineqingguclg/agent/DivineQingGuClgAgent.lua

module("logic.extensions.divineqingguclg.agent.DivineQingGuClgAgent", package.seeall)

local DivineQingGuClgAgent = class("DivineQingGuClgAgent", BaseAgent)

function DivineQingGuClgAgent:sendPM_DivineQingGuClgGetInfoReq(activityId)
	local req = DivineQingGuClgExtension_pb.PM_DivineQingGuClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineQingGuClgAgent:handlePM_DivineQingGuClgGetInfoRes(status, msg)
	if status == 0 then
		DivineQingGuClgModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineQingGuClgGetInfoRes)
	end
end

function DivineQingGuClgAgent:sendPM_DivineQingGuClgFightReq(activityId, stageId, form)
	local req = DivineQingGuClgExtension_pb.PM_DivineQingGuClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineQingGuClgAgent:handlePM_DivineQingGuClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineQingGuClgAgent:handlePM_DivineQingGuClgNotifyFightResultRes(status, msg)
	if status == 0 then
		DivineQingGuClgModel.instance:onNotifyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineQingGuClgNotifyFightResultRes, msg.activityId)
	end
end

DivineQingGuClgAgent.instance = DivineQingGuClgAgent.New()

return DivineQingGuClgAgent
