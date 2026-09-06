-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalkingsignin/agent/SurvivalKingSignInAgent.lua

module("logic.extensions.survivalkingsignin.agent.SurvivalKingSignInAgent", package.seeall)

local SurvivalKingSignInAgent = class("SurvivalKingSignInAgent", BaseAgent)

function SurvivalKingSignInAgent:sendPM_SurvivalKingSignInInfoReq(activityId)
	local req = SurvivalKingSignInExtension_pb.PM_SurvivalKingSignInInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurvivalKingSignInAgent:handlePM_SurvivalKingSignInInfoRes(status, msg)
	if status == 0 then
		SurvivalKingSignInController.instance:handleGetInfo(msg)
	end
end

function SurvivalKingSignInAgent:sendPM_SurvivalKingSignInReq(activityId, zoneId)
	local req = SurvivalKingSignInExtension_pb.PM_SurvivalKingSignInReq()

	req.activityId = activityId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function SurvivalKingSignInAgent:handlePM_SurvivalKingSignInRes(status, msg)
	if status == 0 then
		SurvivalKingSignInController.instance:handleSignIn(msg)
	end
end

function SurvivalKingSignInAgent:sendPM_SurvivalKingSignInGainPrizeReq(activityId)
	local req = SurvivalKingSignInExtension_pb.PM_SurvivalKingSignInGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurvivalKingSignInAgent:handlePM_SurvivalKingSignInGainPrizeRes(status, msg)
	if status == 0 then
		SurvivalKingSignInController.instance:handleGainPrize(msg)
	end
end

SurvivalKingSignInAgent.instance = SurvivalKingSignInAgent.New()

return SurvivalKingSignInAgent
