-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/agent/XingJiangFutureAgent.lua

module("logic.extensions.xingjiangfuture.agent.XingJiangFutureAgent", package.seeall)

local XingJiangFutureAgent = class("XingJiangFutureAgent", BaseAgent)

function XingJiangFutureAgent:sendPM_XingJiangFutureInfoReq(activityId)
	local req = XingJiangFutureExtension_pb.PM_XingJiangFutureInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XingJiangFutureAgent:handlePM_XingJiangFutureInfoRes(status, msg)
	if status == 0 then
		XingJiangModel.instance:getInfos2(msg)
	end
end

function XingJiangFutureAgent:sendPM_XingJiangFutureChallengeReq(activityId)
	local req = XingJiangFutureExtension_pb.PM_XingJiangFutureChallengeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XingJiangFutureAgent:handlePM_XingJiangFutureChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function XingJiangFutureAgent:handlePM_NotifyXingJiangFutureChallengeResultRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

XingJiangFutureAgent.instance = XingJiangFutureAgent.New()

return XingJiangFutureAgent
