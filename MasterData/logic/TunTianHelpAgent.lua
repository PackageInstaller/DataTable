-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/agent/TunTianHelpAgent.lua

module("logic.extensions.tuntianhelp.agent.TunTianHelpAgent", package.seeall)

local TunTianHelpAgent = class("TunTianHelpAgent", BaseAgent)

function TunTianHelpAgent:sendPM_TunTianHelpGetInfoReq(activityId)
	local req = TunTianHelpExtension_pb.PM_TunTianHelpGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TunTianHelpAgent:handlePM_TunTianHelpGetInfoRes(status, msg)
	if status == 0 then
		TunTianHelpController.instance:handlePM_TunTianHelpGetInfoRes(msg)
	end
end

function TunTianHelpAgent:sendPM_TunTianHelpLotteryReq(activityId)
	local req = TunTianHelpExtension_pb.PM_TunTianHelpLotteryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TunTianHelpAgent:handlePM_TunTianHelpLotteryRes(status, msg)
	if status == 0 then
		TunTianHelpController.instance:handlePM_TunTianHelpLotteryRes(msg)
	end
end

TunTianHelpAgent.instance = TunTianHelpAgent.New()

return TunTianHelpAgent
