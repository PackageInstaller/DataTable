-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/agent/HalloweenBossChallengeAgent.lua

module("logic.extensions.halloweenguest.agent.HalloweenBossChallengeAgent", package.seeall)

local HalloweenBossChallengeAgent = class("HalloweenBossChallengeAgent", BaseAgent)

function HalloweenBossChallengeAgent:sendPM_HalloweenBossChallengeGetInfoReq(activityId)
	local req = HalloweenBossChallengeExtension_pb.PM_HalloweenBossChallengeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HalloweenBossChallengeAgent:handlePM_HalloweenBossChallengeGetInfoRes(status, msg)
	if status == 0 then
		HalloweenGuestController.instance:scSendHalloweenBossChallengeGetInfo(msg)
	end
end

function HalloweenBossChallengeAgent:sendPM_HalloweenBossChallengeReq(activityId, bossId)
	local req = HalloweenBossChallengeExtension_pb.PM_HalloweenBossChallengeReq()

	req.activityId = activityId
	req.bossId = bossId

	self:sendMsg(req)
end

function HalloweenBossChallengeAgent:handlePM_HalloweenBossChallengeRes(status, msg)
	if status == 0 then
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.HalloweenBoss)
	elseif ViewMgr.instance:isOpen(ViewName.HalloweenMission) then
		UIStateManager.instance:clear(true)
	end
end

function HalloweenBossChallengeAgent:handlePM_HalloweenBossChallengeEndRes(status, msg)
	if status == 0 then
		HalloweenGuestController.instance:scSendBossNotifyChallengeEnd(msg)
	end
end

function HalloweenBossChallengeAgent:sendPM_HalloweenBossChallengeGainDailyPrizeReq(activityId)
	local req = HalloweenBossChallengeExtension_pb.PM_HalloweenBossChallengeGainDailyPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HalloweenBossChallengeAgent:handlePM_HalloweenBossChallengeGainDailyPrizeRes(status, msg)
	if status == 0 then
		HalloweenGuestController.instance:scSendHalloweenBossChallengeGainDailyPrize(msg)
	end
end

function HalloweenBossChallengeAgent:sendPM_HalloweenBossChallengeGainDamagePrizeReq(activityId, damgePrizeId)
	local req = HalloweenBossChallengeExtension_pb.PM_HalloweenBossChallengeGainDamagePrizeReq()

	req.activityId = activityId
	req.damgePrizeId = damgePrizeId

	self:sendMsg(req)
end

function HalloweenBossChallengeAgent:handlePM_HalloweenBossChallengeGainDamagePrizeRes(status, msg)
	if status == 0 then
		HalloweenGuestController.instance:scSendHalloweenBossChallengeGainDamagePrize(msg)
	end
end

function HalloweenBossChallengeAgent:sendPM_HalloweenBossChallengeRankReq(activityId)
	local req = HalloweenBossChallengeExtension_pb.PM_HalloweenBossChallengeRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HalloweenBossChallengeAgent:handlePM_HalloweenBossChallengeRankRes(status, msg)
	if status == 0 then
		HalloweenGuestController.instance:scSendHalloweenBossChallengeRank(msg)
	end
end

HalloweenBossChallengeAgent.instance = HalloweenBossChallengeAgent.New()

return HalloweenBossChallengeAgent
