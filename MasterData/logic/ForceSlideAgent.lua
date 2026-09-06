-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/agent/ForceSlideAgent.lua

module("logic.extensions.forceslide.agent.ForceSlideAgent", package.seeall)

local ForceSlideAgent = class("ForceSlideAgent", BaseAgent)

function ForceSlideAgent:setExtId(extId)
	ForceSlideAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ForceSlideAgent:sendPM_ForceSlideGetInfoReq(activityId)
	local req = ForceSlideExtension_pb.PM_ForceSlideGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ForceSlideAgent:handlePM_ForceSlideGetInfoRes(status, msg)
	ForceSlideController.instance:handleGetInfo(status, msg)
end

ForceSlideAgent.instance = ForceSlideAgent.New()

return ForceSlideAgent
