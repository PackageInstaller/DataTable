-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/agent/CiyuanSigninAgent.lua

module("logic.extensions.ciyuansignin.agent.CiyuanSigninAgent", package.seeall)

local CiyuanSigninAgent = class("CiyuanSigninAgent", BaseAgent)

function CiyuanSigninAgent:sendPM_CiyuanSigninGetInfoReq(activityId)
	local req = CiyuanSigninExtension_pb.PM_CiyuanSigninGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CiyuanSigninAgent:handlePM_CiyuanSigninGetInfoRes(status, msg)
	if status == 0 then
		CiyuanSigninController.instance:handlePM_CiyuanSigninGetInfoRes(status, msg)
	end
end

function CiyuanSigninAgent:sendPM_CiyuanSigninGainPrizeReq(activityId)
	local req = CiyuanSigninExtension_pb.PM_CiyuanSigninGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CiyuanSigninAgent:handlePM_CiyuanSigninGainPrizeRes(status, msg)
	if status == 0 then
		CiyuanSigninController.instance:handlePM_CiyuanSigninGainPrizeRes(status, msg)
	end
end

function CiyuanSigninAgent:sendPM_CiyuanSigninBuyMakeUpReq(activityId, days)
	local req = CiyuanSigninExtension_pb.PM_CiyuanSigninBuyMakeUpReq()

	req.activityId = activityId
	req.days = days

	self:sendMsg(req)
end

function CiyuanSigninAgent:handlePM_CiyuanSigninBuyMakeUpRes(status, msg)
	if status == 0 then
		CiyuanSigninController.instance:handlePM_CiyuanSigninBuyMakeUpRes(status, msg)
	end
end

CiyuanSigninAgent.instance = CiyuanSigninAgent.New()

return CiyuanSigninAgent
