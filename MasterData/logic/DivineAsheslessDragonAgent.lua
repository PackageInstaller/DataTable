-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/agent/DivineAsheslessDragonAgent.lua

module("logic.extensions.divineasheslessdragon.agent.DivineAsheslessDragonAgent", package.seeall)

local DivineAsheslessDragonAgent = class("DivineAsheslessDragonAgent", BaseAgent)

function DivineAsheslessDragonAgent:sendPM_DivineAsheslessDragonGetInfoReq(activityId)
	local req = DivineAsheslessDragonExtension_pb.PM_DivineAsheslessDragonGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineAsheslessDragonAgent:handlePM_DivineAsheslessDragonGetInfoRes(status, msg)
	if status == 0 then
		DivineasheslessdragonModel.instance:setInfo(msg)
		DivineasheslessdragonController.instance:calRedpoint()
		GlobalDispatcher:dispatch(GlobalNotify.DivineAsheslessDragonGetInfoRes)
	end
end

function DivineAsheslessDragonAgent:sendPM_DivineAsheslessDragonChallengeReq(activityId, stageId, form)
	local req = DivineAsheslessDragonExtension_pb.PM_DivineAsheslessDragonChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineAsheslessDragonAgent:handlePM_DivineAsheslessDragonChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineAsheslessDragonChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineAsheslessDragonAgent:handlePM_Notify_DivineAsheslessDragonChallengeRes(status, msg)
	if status == 0 then
		DivineasheslessdragonController.instance:handlePM_Notify_DivineAsheslessDragonChallengeRes(msg)
	end
end

DivineAsheslessDragonAgent.instance = DivineAsheslessDragonAgent.New()

return DivineAsheslessDragonAgent
