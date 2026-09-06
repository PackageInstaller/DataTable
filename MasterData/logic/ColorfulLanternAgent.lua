-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/agent/ColorfulLanternAgent.lua

module("logic.extensions.colorfullantern.agent.ColorfulLanternAgent", package.seeall)

local ColorfulLanternAgent = class("ColorfulLanternAgent", BaseAgent)

ColorfulLanternAgent.PM_ColorfulLanternGetInfoRes = "ColorfulLanternAgent_PM_ColorfulLanternGetInfoRes"
ColorfulLanternAgent.PM_ColorfulLanternActivateRes = "ColorfulLanternAgent_PM_ColorfulLanternActivateRes"

function ColorfulLanternAgent:sendPM_ColorfulLanternGetInfoReq(activityId)
	local req = ColorfulLanternExtension_pb.PM_ColorfulLanternGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ColorfulLanternAgent:handlePM_ColorfulLanternGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(ColorfulLanternAgent.PM_ColorfulLanternGetInfoRes, status, msg)
	end
end

function ColorfulLanternAgent:sendPM_ColorfulLanternActivateReq(activityId, fragmentId)
	local req = ColorfulLanternExtension_pb.PM_ColorfulLanternActivateReq()

	req.activityId = activityId
	req.fragmentId = fragmentId

	self:sendMsg(req)
end

function ColorfulLanternAgent:handlePM_ColorfulLanternActivateRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(ColorfulLanternAgent.PM_ColorfulLanternActivateRes, status, msg)
	end
end

ColorfulLanternAgent.instance = ColorfulLanternAgent.New()

return ColorfulLanternAgent
