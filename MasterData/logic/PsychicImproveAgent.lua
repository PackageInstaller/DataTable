-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/agent/PsychicImproveAgent.lua

module("logic.extensions.psychicimprove.agent.PsychicImproveAgent", package.seeall)

local PsychicImproveAgent = class("PsychicImproveAgent", BaseAgent)

function PsychicImproveAgent:sendPM_PsychicImproveGetInfoReq(activityId)
	local req = PsychicImproveExtension_pb.PM_PsychicImproveGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PsychicImproveAgent:handlePM_PsychicImproveGetInfoRes(status, msg)
	if status == 0 then
		PsychicImproveController.instance:handleGetInfo(msg)
	end
end

function PsychicImproveAgent:sendPM_PsychicImproveHirePetReq(activityId, hireId)
	local req = PsychicImproveExtension_pb.PM_PsychicImproveHirePetReq()

	req.activityId = activityId
	req.hireId = hireId

	self:sendMsg(req)
end

function PsychicImproveAgent:handlePM_PsychicImproveHirePetRes(status, msg)
	if status == 0 then
		PsychicImproveController.instance:handleHidePet(msg)
	end
end

PsychicImproveAgent.instance = PsychicImproveAgent.New()

return PsychicImproveAgent
