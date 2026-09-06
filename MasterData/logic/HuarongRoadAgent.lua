-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huarongroad/agent/HuarongRoadAgent.lua

module("logic.extensions.huarongroad.agent.HuarongRoadAgent", package.seeall)

local HuarongRoadAgent = class("HuarongRoadAgent", BaseAgent)

HuarongRoadAgent.PM_HuarongRoadGetInfoRes = "HuarongRoadAgent_PM_HuarongRoadGetInfoRes"
HuarongRoadAgent.PM_HuarongRoadPassRes = "HuarongRoadAgent_PM_HuarongRoadPassRes"
HuarongRoadAgent.PM_HuarongRoadIncreaseSecondRes = "HuarongRoadAgent_PM_HuarongRoadIncreaseSecondRes"
HuarongRoadAgent.PM_HuarongRoadBuyQuickPassRes = "HuarongRoadAgent_PM_HuarongRoadBuyQuickPassRes"

function HuarongRoadAgent:sendPM_HuarongRoadGetInfoReq(activityId)
	local req = HuarongRoadExtension_pb.PM_HuarongRoadGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HuarongRoadAgent:handlePM_HuarongRoadGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HuarongRoadAgent.PM_HuarongRoadGetInfoRes, status, msg)
	end
end

function HuarongRoadAgent:sendPM_HuarongRoadPassReq(activityId, stageId)
	local req = HuarongRoadExtension_pb.PM_HuarongRoadPassReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function HuarongRoadAgent:handlePM_HuarongRoadPassRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HuarongRoadAgent.PM_HuarongRoadPassRes, status, msg)
	end
end

function HuarongRoadAgent:sendPM_HuarongRoadIncreaseSecondReq(activityId, stageId)
	local req = HuarongRoadExtension_pb.PM_HuarongRoadIncreaseSecondReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function HuarongRoadAgent:handlePM_HuarongRoadIncreaseSecondRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HuarongRoadAgent.PM_HuarongRoadIncreaseSecondRes, status, msg)
	end
end

function HuarongRoadAgent:sendPM_HuarongRoadBuyQuickPassReq(activityId, stageId)
	local req = HuarongRoadExtension_pb.PM_HuarongRoadBuyQuickPassReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function HuarongRoadAgent:handlePM_HuarongRoadBuyQuickPassRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HuarongRoadAgent.PM_HuarongRoadBuyQuickPassRes, status, msg)
	end
end

HuarongRoadAgent.instance = HuarongRoadAgent.New()

return HuarongRoadAgent
