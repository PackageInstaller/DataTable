-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclemultiplied/agent/MiracleMultipliedAgent.lua

module("logic.extensions.miraclemultiplied.agent.MiracleMultipliedAgent", package.seeall)

local MiracleMultipliedAgent = class("MiracleMultipliedAgent", BaseAgent)

function MiracleMultipliedAgent:sendPM_MiracleMultipliedGetInfoReq(activityId)
	local req = MiracleMultipliedExtension_pb.PM_MiracleMultipliedGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleMultipliedAgent:handlePM_MiracleMultipliedGetInfoRes(status, msg)
	if status == 0 then
		MiracleMultipliedController.instance:handlePM_MiracleMultipliedGetInfoRes(msg)
	end
end

function MiracleMultipliedAgent:sendPM_MiracleMultipliedUnlockReq(activityId, collectId)
	local req = MiracleMultipliedExtension_pb.PM_MiracleMultipliedUnlockReq()

	req.activityId = activityId
	req.collectId = collectId

	self:sendMsg(req)
end

function MiracleMultipliedAgent:handlePM_MiracleMultipliedUnlockRes(status, msg)
	if status == 0 then
		MiracleMultipliedController.instance:handlePM_MiracleMultipliedUnlockRes(msg)
	end
end

function MiracleMultipliedAgent:sendPM_MiracleMultipliedGainPrizeReq(activityId, collectId)
	local req = MiracleMultipliedExtension_pb.PM_MiracleMultipliedGainPrizeReq()

	req.activityId = activityId
	req.collectId = collectId

	self:sendMsg(req)
end

function MiracleMultipliedAgent:handlePM_MiracleMultipliedGainPrizeRes(status, msg)
	if status == 0 then
		MiracleMultipliedController.instance:handlePM_MiracleMultipliedGainPrizeRes(msg)
	end
end

MiracleMultipliedAgent.instance = MiracleMultipliedAgent.New()

return MiracleMultipliedAgent
