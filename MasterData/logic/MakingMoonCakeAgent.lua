-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/agent/MakingMoonCakeAgent.lua

module("logic.extensions.makingmooncake.agent.MakingMoonCakeAgent", package.seeall)

local MakingMoonCakeAgent = class("MakingMoonCakeAgent", BaseAgent)

function MakingMoonCakeAgent:sendPM_MakingMoonCakeInfoReq(activityId)
	local req = MakingMoonCakeExtension_pb.PM_MakingMoonCakeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MakingMoonCakeAgent:handlePM_MakingMoonCakeInfoRes(status, msg)
	if status == 0 then
		MakingMoonCakeController.instance:handlePM_MakingMoonCakeInfoRes(msg)
	end
end

function MakingMoonCakeAgent:sendPM_MakingMoonCakeStartGameReq(activityId, clientKey)
	local req = MakingMoonCakeExtension_pb.PM_MakingMoonCakeStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function MakingMoonCakeAgent:handlePM_MakingMoonCakeStartGameRes(status, msg)
	if status == 0 then
		MakingMoonCakeController.instance:handlePM_MakingMoonCakeStartGameRes(msg)
	end
end

function MakingMoonCakeAgent:sendPM_MakingMoonCakeEndGameReq(score, encryptedKey)
	local req = MakingMoonCakeExtension_pb.PM_MakingMoonCakeEndGameReq()

	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function MakingMoonCakeAgent:handlePM_MakingMoonCakeEndGameRes(status, msg)
	if status == 0 then
		MakingMoonCakeController.instance:handlePM_MakingMoonCakeEndGameRes(msg)
	end
end

function MakingMoonCakeAgent:sendPM_MakingMoonCakeBuyTimesReq(activityId)
	local req = MakingMoonCakeExtension_pb.PM_MakingMoonCakeBuyTimesReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MakingMoonCakeAgent:handlePM_MakingMoonCakeBuyTimesRes(status, msg)
	if status == 0 then
		MakingMoonCakeController.instance:handlePM_MakingMoonCakeBuyTimesRes(msg)
	end
end

function MakingMoonCakeAgent:sendPM_MakingMoonCakeReceiveCumulativePrizeReq(activityId, cumulativePrizeId)
	local req = MakingMoonCakeExtension_pb.PM_MakingMoonCakeReceiveCumulativePrizeReq()

	req.activityId = activityId
	req.cumulativePrizeId = cumulativePrizeId

	self:sendMsg(req)
end

function MakingMoonCakeAgent:handlePM_MakingMoonCakeReceiveCumulativePrizeRes(status, msg)
	if status == 0 then
		MakingMoonCakeController.instance:handlePM_MakingMoonCakeReceiveCumulativePrizeRes(msg)
	end
end

function MakingMoonCakeAgent:sendPM_MakingMoonCakeReceiveAllPrizeReq(activityId)
	local req = MakingMoonCakeExtension_pb.PM_MakingMoonCakeReceiveAllPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MakingMoonCakeAgent:handlePM_MakingMoonCakeReceiveAllPrizeRes(status, msg)
	if status == 0 then
		MakingMoonCakeController.instance:handlePM_MakingMoonCakeReceiveAllPrizeRes(msg)
	end
end

function MakingMoonCakeAgent:sendPM_MakingMoonCakeGainRoleProgressPrizeReq(activityId, roleId)
	local req = MakingMoonCakeExtension_pb.PM_MakingMoonCakeGainRoleProgressPrizeReq()

	req.activityId = activityId
	req.roleId = roleId

	self:sendMsg(req)
end

function MakingMoonCakeAgent:handlePM_MakingMoonCakeGainRoleProgressPrizeRes(status, msg)
	if status == 0 then
		MakingMoonCakeController.instance:handlePM_MakingMoonCakeGainRoleProgressPrizeRes(msg)
	end
end

MakingMoonCakeAgent.instance = MakingMoonCakeAgent.New()

return MakingMoonCakeAgent
