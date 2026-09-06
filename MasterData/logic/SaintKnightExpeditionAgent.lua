-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/agent/SaintKnightExpeditionAgent.lua

module("logic.extensions.saintknightexpedition.agent.SaintKnightExpeditionAgent", package.seeall)

local SaintKnightExpeditionAgent = class("SaintKnightExpeditionAgent", BaseAgent)

function SaintKnightExpeditionAgent:sendPM_SaintKnightExpeditionInfoReq(activityId)
	local req = SaintKnightExpeditionExtension_pb.PM_SaintKnightExpeditionInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SaintKnightExpeditionAgent:handlePM_SaintKnightExpeditionInfoRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_SaintKnightExpeditionInfoRes(msg)
	end
end

function SaintKnightExpeditionAgent:sendPM_SaintKnightExpeditionMiningReq(activityId)
	local req = SaintKnightExpeditionExtension_pb.PM_SaintKnightExpeditionMiningReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SaintKnightExpeditionAgent:handlePM_SaintKnightExpeditionMiningRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_SaintKnightExpeditionMiningRes(msg)
	end
end

function SaintKnightExpeditionAgent:sendPM_SaintKnightExpeditionUpgardeIslandReq(activityId, islandIdAndNum)
	local req = SaintKnightExpeditionExtension_pb.PM_SaintKnightExpeditionUpgardeIslandReq()

	req.activityId = activityId

	if islandIdAndNum then
		for i, v in ipairs(islandIdAndNum) do
			local value = req.islandIdAndNum:add()

			value.left = v.left
			value.right = v.right
		end
	end

	self:sendMsg(req)
end

function SaintKnightExpeditionAgent:handlePM_SaintKnightExpeditionUpgardeIslandRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_SaintKnightExpeditionUpgardeIslandRes(msg)
	end
end

function SaintKnightExpeditionAgent:sendPM_SaintKnightExpeditionChallengeReq(activityId, zoneId, stageId, form)
	local req = SaintKnightExpeditionExtension_pb.PM_SaintKnightExpeditionChallengeReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function SaintKnightExpeditionAgent:handlePM_SaintKnightExpeditionChallengeRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_SaintKnightExpeditionChallengeRes(msg)
	end
end

function SaintKnightExpeditionAgent:sendPM_SaintKnightExpeditionBossChallengeReq(activityId, zoneId, simulate, form, saintKnightBuffIds)
	local req = SaintKnightExpeditionExtension_pb.PM_SaintKnightExpeditionBossChallengeReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.simulate = simulate

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	if saintKnightBuffIds then
		for _, v in ipairs(saintKnightBuffIds) do
			req.saintKnightBuffIds:append(v)
		end
	end

	self:sendMsg(req)
end

function SaintKnightExpeditionAgent:handlePM_SaintKnightExpeditionBossChallengeRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_SaintKnightExpeditionBossChallengeRes(msg)
	end
end

function SaintKnightExpeditionAgent:sendPM_SaintKnightExpeditionGainBossPrizeReq(activityId, zoneId, prizeId)
	local req = SaintKnightExpeditionExtension_pb.PM_SaintKnightExpeditionGainBossPrizeReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SaintKnightExpeditionAgent:handlePM_SaintKnightExpeditionGainBossPrizeRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_SaintKnightExpeditionGainBossPrizeRes(msg)
	end
end

function SaintKnightExpeditionAgent:sendPM_SaintKnightExpeditionStageRankInfoReq(activityId, zoneId)
	local req = SaintKnightExpeditionExtension_pb.PM_SaintKnightExpeditionStageRankInfoReq()

	req.activityId = activityId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function SaintKnightExpeditionAgent:handlePM_SaintKnightExpeditionStageRankInfoRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_SaintKnightExpeditionStageRankInfoRes(msg)
	end
end

function SaintKnightExpeditionAgent:sendPM_SaintKnightExpeditionBossRankInfoReq(activityId, zoneId)
	local req = SaintKnightExpeditionExtension_pb.PM_SaintKnightExpeditionBossRankInfoReq()

	req.activityId = activityId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function SaintKnightExpeditionAgent:handlePM_SaintKnightExpeditionBossRankInfoRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_SaintKnightExpeditionBossRankInfoRes(msg)
	end
end

function SaintKnightExpeditionAgent:handlePM_NotifySaintKnightExpeditionChallengeEndRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_NotifySaintKnightExpeditionChallengeEndRes(msg)
	end
end

function SaintKnightExpeditionAgent:handlePM_NotifySaintKnightExpeditionBossChallengeEndRes(status, msg)
	if status == 0 then
		StKnExpController.instance:handlePM_NotifySaintKnightExpeditionBossChallengeEndRes(msg)
	end
end

SaintKnightExpeditionAgent.instance = SaintKnightExpeditionAgent.New()

return SaintKnightExpeditionAgent
