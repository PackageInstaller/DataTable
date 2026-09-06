-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/agent/DivineAresMomAgent.lua

module("logic.extensions.divinegasiri.agent.DivineAresMomAgent", package.seeall)

local DivineAresMomAgent = class("DivineAresMomAgent", BaseAgent)

function DivineAresMomAgent:sendPM_DivineAresMomGetInfoReq(activityId)
	local req = DivineAresMomExtension_pb.PM_DivineAresMomGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineAresMomAgent:handlePM_DivineAresMomGetInfoRes(status, msg)
	if status == 0 then
		DivineGasiriController.instance:handlePM_DivineAresMomGetInfoRes(msg)
	end
end

function DivineAresMomAgent:sendPM_DivineAresMomChallengeReq(activityId, form)
	local req = DivineAresMomExtension_pb.PM_DivineAresMomChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineAresMomAgent:handlePM_DivineAresMomChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineAresMomAgent:handlePM_Notify_DivineAresMomChallengeEndRes(status, msg)
	if status == 0 then
		DivineGasiriController.instance:handlePM_Notify_DivineAresMomChallengeEndRes(msg)
	end
end

DivineAresMomAgent.instance = DivineAresMomAgent.New()

return DivineAresMomAgent
