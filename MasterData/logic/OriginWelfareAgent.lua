-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/agent/OriginWelfareAgent.lua

module("logic.extensions.originwelfare.agent.OriginWelfareAgent", package.seeall)

local OriginWelfareAgent = class("OriginWelfareAgent", BaseAgent)

function OriginWelfareAgent:sendPM_OriginWelfareInfoReq(activityId)
	local req = OriginWelfareExtension_pb.PM_OriginWelfareInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginWelfareAgent:handlePM_OriginWelfareInfoRes(status, msg)
	if status == 0 then
		OriginWelfareController.instance:handlePM_OriginWelfareInfoRes(msg)
	end
end

function OriginWelfareAgent:sendPM_OriginWelfareLightUpReq(activityId)
	local req = OriginWelfareExtension_pb.PM_OriginWelfareLightUpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginWelfareAgent:handlePM_OriginWelfareLightUpRes(status, msg)
	if status == 0 then
		OriginWelfareController.instance:handlePM_OriginWelfareLightUpRes(msg)
	end
end

OriginWelfareAgent.instance = OriginWelfareAgent.New()

return OriginWelfareAgent
