-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheelfortune/agent/WheelFortuneAgent.lua

module("logic.extensions.wheelfortune.agent.WheelFortuneAgent", package.seeall)

local WheelFortuneAgent = class("WheelFortuneAgent", BaseAgent)

WheelFortuneAgent.handlePM_WheelFortuneInfoRes = "WheelFortuneAgent.handlePM_WheelFortuneInfoRes"
WheelFortuneAgent.handlePM_WheelFortuneDrawRes = "WheelFortuneAgent.handlePM_WheelFortuneDrawRes"
WheelFortuneAgent.handlePM_WheelFortuneRecordsRes = "WheelFortuneAgent.handlePM_WheelFortuneRecordsRes"

function WheelFortuneAgent:sendPM_WheelFortuneInfoReq(activityId)
	local req = WheelFortuneExtension_pb.PM_WheelFortuneInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WheelFortuneAgent:handlePM_WheelFortuneInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(WheelFortuneAgent.handlePM_WheelFortuneInfoRes, msg)
	end
end

function WheelFortuneAgent:sendPM_WheelFortuneDrawReq(activityId)
	local req = WheelFortuneExtension_pb.PM_WheelFortuneDrawReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WheelFortuneAgent:handlePM_WheelFortuneDrawRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(WheelFortuneAgent.handlePM_WheelFortuneDrawRes, msg)
	end
end

function WheelFortuneAgent:sendPM_WheelFortuneRecordsReq(activityId)
	local req = WheelFortuneExtension_pb.PM_WheelFortuneRecordsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WheelFortuneAgent:handlePM_WheelFortuneRecordsRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(WheelFortuneAgent.handlePM_WheelFortuneRecordsRes, msg)
	end
end

WheelFortuneAgent.instance = WheelFortuneAgent.New()

return WheelFortuneAgent
