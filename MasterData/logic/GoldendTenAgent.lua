-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/agent/GoldendTenAgent.lua

module("logic.extensions.goldendten.agent.GoldendTenAgent", package.seeall)

local GoldendTenAgent = class("GoldendTenAgent", BaseAgent)

function GoldendTenAgent:sendPM_GoldenTenGetInfoReq(activityId)
	local req = GoldendTenExtension_pb.PM_GoldenTenGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoldendTenAgent:handlePM_GoldenTenGetInfoRes(status, msg)
	if status == 0 then
		GoldendTenController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoldendTenError, status)
	end
end

function GoldendTenAgent:sendPM_GoldenTenBecomeLeaderReq(activityId, code)
	local req = GoldendTenExtension_pb.PM_GoldenTenBecomeLeaderReq()

	req.activityId = activityId
	req.code = code

	self:sendMsg(req)
end

function GoldendTenAgent:handlePM_GoldenTenBecomeLeaderRes(status, msg)
	if status == 0 then
		GoldendTenController.instance:handleBecomeLeader(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoldendTenError, status)
	end
end

function GoldendTenAgent:sendPM_GoldenTenBecomeFollowerReq(activityId, code)
	local req = GoldendTenExtension_pb.PM_GoldenTenBecomeFollowerReq()

	req.activityId = activityId
	req.code = code

	self:sendMsg(req)
end

function GoldendTenAgent:handlePM_GoldenTenBecomeFollowerRes(status, msg)
	if status == 0 then
		GoldendTenController.instance:handleBecomeMember(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoldendTenError, status)
	end
end

function GoldendTenAgent:sendPM_GoldenTenGainPrizeReq(activityId, prizeId, anotherPrize)
	local req = GoldendTenExtension_pb.PM_GoldenTenGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	if anotherPrize ~= nil then
		req.anotherPrize = anotherPrize
	end

	self:sendMsg(req)
end

function GoldendTenAgent:handlePM_GoldenTenGainPrizeRes(status, msg)
	if status == 0 then
		GoldendTenController.instance:handleGainPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoldendTenError, status)
	end
end

GoldendTenAgent.instance = GoldendTenAgent.New()

return GoldendTenAgent
