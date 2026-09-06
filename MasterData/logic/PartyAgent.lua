-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/party/agent/PartyAgent.lua

module("logic.extensions.party.agent.PartyAgent", package.seeall)

local PartyAgent = class("PartyAgent", BaseAgent)

function PartyAgent:sendPM_PartyGetInfoReq(activityId)
	local req = PartyExtension_pb.PM_PartyGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PartyAgent:handlePM_PartyGetInfoRes(status, msg)
	if status == 0 then
		PartyController.instance:handleGetInfo(msg)
	end
end

function PartyAgent:sendPM_PartyGainPrizeReq(activityId)
	local req = PartyExtension_pb.PM_PartyGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PartyAgent:handlePM_PartyGainPrizeRes(status, msg)
	if status == 0 then
		PartyController.instance:handleGainPrize(msg)
	end
end

PartyAgent.instance = PartyAgent.New()

return PartyAgent
