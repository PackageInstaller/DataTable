-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/agent/MiracleHeroAgent.lua

module("logic.extensions.miraclehero.agent.MiracleHeroAgent", package.seeall)

local MiracleHeroAgent = class("MiracleHeroAgent", BaseAgent)

function MiracleHeroAgent:sendPM_MiracleHeroInfoReq(activityId)
	local req = MiracleHeroExtension_pb.PM_MiracleHeroInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleHeroAgent:handlePM_MiracleHeroInfoRes(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_MiracleHeroInfoRes(msg)
	end
end

function MiracleHeroAgent:sendPM_MiracleHeroRankInfoReq(activityId)
	local req = MiracleHeroExtension_pb.PM_MiracleHeroRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleHeroAgent:handlePM_MiracleHeroRankInfoRes(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_MiracleHeroRankInfoRes(msg)
	end
end

function MiracleHeroAgent:sendPM_MiracleHeroUpgradePositionReq(activityId, posId)
	local req = MiracleHeroExtension_pb.PM_MiracleHeroUpgradePositionReq()

	req.activityId = activityId
	req.posId = posId

	self:sendMsg(req)
end

function MiracleHeroAgent:handlePM_MiracleHeroUpgradePositionRes(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_MiracleHeroUpgradePositionRes(msg)
	end
end

function MiracleHeroAgent:sendPM_MiracleHeroGetFormationReq(activityId)
	local req = MiracleHeroExtension_pb.PM_MiracleHeroGetFormationReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleHeroAgent:handlePM_MiracleHeroGetFormationRes(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_MiracleHeroGetFormationRes(msg)
	end
end

function MiracleHeroAgent:sendPM_MiracleHeroSetFormationReq(activityId, formation)
	local req = MiracleHeroExtension_pb.PM_MiracleHeroSetFormationReq()

	req.activityId = activityId

	if formation then
		req.formation:ParseFromString(formation:SerializeToString())
	end

	self:sendMsg(req)
end

function MiracleHeroAgent:handlePM_MiracleHeroSetFormationRes(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_MiracleHeroSetFormationRes(msg)
	end
end

function MiracleHeroAgent:sendPM_MiracleHeroChallengeReq(activityId, challengeId, stageId, formation)
	local req = MiracleHeroExtension_pb.PM_MiracleHeroChallengeReq()

	req.activityId = activityId
	req.challengeId = challengeId
	req.stageId = stageId

	if formation then
		req.formation:ParseFromString(formation:SerializeToString())
	end

	self:sendMsg(req)
end

function MiracleHeroAgent:handlePM_MiracleHeroChallengeRes(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_MiracleHeroChallengeRes(msg)
	end
end

function MiracleHeroAgent:handlePM_NotifyMiracleHeroChallengeEndRes(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_NotifyMiracleHeroChallengeEndRes(msg)
	end
end

function MiracleHeroAgent:handlePM_NotifyMiracleHeroBattleReadyStart(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_NotifyMiracleHeroBattleReadyStart(msg)
	end
end

function MiracleHeroAgent:sendPM_MiracleHeroBattleStartReq(actionId, clientKey, teamViews, firstTeamId)
	local req = MiracleHeroExtension_pb.PM_MiracleHeroBattleStartReq()

	req.actionId = actionId
	req.clientKey = clientKey

	for i, v1 in ipairs(teamViews) do
		local views = req.teamViews:add()

		views:ParseFromString(v1:SerializeToString())
	end

	req.firstTeamId = firstTeamId

	self:sendMsg(req)
end

function MiracleHeroAgent:handlePM_MiracleHeroBattleStartRes(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_MiracleHeroBattleStartRes(msg)
	end
end

function MiracleHeroAgent:sendPM_MiracleHeroSyncBattleReq(actionId, encryptedKey, isWin, oneCircle)
	local req = MiracleHeroExtension_pb.PM_MiracleHeroSyncBattleReq()

	req.actionId = actionId
	req.encryptedKey = encryptedKey

	if isWin ~= nil then
		req.isWin = isWin
	end

	req.oneCircle:ParseFromString(oneCircle:SerializeToString())
	self:sendMsg(req)
end

function MiracleHeroAgent:handlePM_MiracleHeroSyncBattleRes(status, msg)
	if status == 0 then
		MiracleHeroController.instance:handlePM_MiracleHeroSyncBattleRes(msg)
	end
end

MiracleHeroAgent.instance = MiracleHeroAgent.New()

return MiracleHeroAgent
