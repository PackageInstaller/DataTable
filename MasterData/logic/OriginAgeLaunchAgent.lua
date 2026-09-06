-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/agent/OriginAgeLaunchAgent.lua

module("logic.extensions.originagelaunch.agent.OriginAgeLaunchAgent", package.seeall)

local OriginAgeLaunchAgent = class("OriginAgeLaunchAgent", BaseAgent)

function OriginAgeLaunchAgent:sendPM_OriginAgeLaunchGetInfoReq(activityId)
	local req = OriginAgeLaunchExtension_pb.PM_OriginAgeLaunchGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginAgeLaunchAgent:handlePM_OriginAgeLaunchGetInfoRes(status, msg)
	if status == 0 then
		OriginAgeController.instance:onGetInfo(msg)
	end
end

function OriginAgeLaunchAgent:sendPM_OriginAgeLaunchGainPrizeReq(activityId, prizeType)
	local req = OriginAgeLaunchExtension_pb.PM_OriginAgeLaunchGainPrizeReq()

	req.activityId = activityId
	req.prizeType = prizeType

	self:sendMsg(req)
end

function OriginAgeLaunchAgent:handlePM_OriginAgeLaunchGainPrizeRes(status, msg)
	if status == 0 then
		OriginAgeController.instance:onGetPrize(msg)
	end
end

function OriginAgeLaunchAgent:sendPM_OriginAgeLaunchBindCodeReq(activityId, code)
	local req = OriginAgeLaunchExtension_pb.PM_OriginAgeLaunchBindCodeReq()

	req.activityId = activityId
	req.code = code

	self:sendMsg(req)
end

function OriginAgeLaunchAgent:handlePM_OriginAgeLaunchBindCodeRes(status, msg)
	if status == 0 then
		OriginAgeController.instance:onBindCode(msg)
	end
end

OriginAgeLaunchAgent.instance = OriginAgeLaunchAgent.New()

return OriginAgeLaunchAgent
