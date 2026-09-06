-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/agent/KingArenaAgent.lua

module("logic.extensions.kingarena.agent.KingArenaAgent", package.seeall)

local KingArenaAgent = class("KingArenaAgent", BaseAgent)

function KingArenaAgent:sendPM_KingArenaGetInfoReq(seasonId)
	local req = KingArenaExtension_pb.PM_KingArenaGetInfoReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaGetInfoRes(status, msg)
	KingArenaController.instance:handlePM_KingArenaGetInfoRes(status, msg)
end

function KingArenaAgent:sendPM_KingArenaFightReq(seasonId, targetRankId, form, useSystemPro)
	local req = KingArenaExtension_pb.PM_KingArenaFightReq()

	req.seasonId = seasonId
	req.targetRankId = targetRankId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.useSystemPro = useSystemPro

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaFightRes(status, msg)
	KingArenaController.instance:handlePM_KingArenaFightRes(status, msg)
end

function KingArenaAgent:sendPM_KingArenaViewFormReq(playerId)
	local req = KingArenaExtension_pb.PM_KingArenaViewFormReq()

	req.playerId = playerId

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaViewFormRes(status, msg)
	KingArenaController.instance:handlePM_KingArenaViewFormRes(status, msg)

	if status ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseSaveFmtFailed)
	end
end

function KingArenaAgent:sendPM_KingArenaSetDefenseFormReq(form)
	local req = KingArenaExtension_pb.PM_KingArenaSetDefenseFormReq()

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaSetDefenseFormRes(status, msg)
	KingArenaController.instance:handlePM_KingArenaSetDefenseFormRes(status, msg)
end

function KingArenaAgent:sendPM_KingArenaRefreshOpReq(seasonId)
	local req = KingArenaExtension_pb.PM_KingArenaRefreshOpReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaRefreshOpRes(status, msg)
	KingArenaController.instance:handlePM_KingArenaRefreshOpRes(status, msg)
end

function KingArenaAgent:sendPM_KingArenaBuyFightTimesReq(seasonId, wantBuyTimes)
	local req = KingArenaExtension_pb.PM_KingArenaBuyFightTimesReq()

	req.seasonId = seasonId
	req.wantBuyTimes = wantBuyTimes

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaBuyFightTimesRes(status, msg)
	KingArenaController.instance:handlePM_KingArenaBuyFightTimesRes(status, msg)
end

function KingArenaAgent:sendPM_KingArenaGainSeasonPrizeReq(seasonId)
	local req = KingArenaExtension_pb.PM_KingArenaGainSeasonPrizeReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaGainSeasonPrizeRes(status, msg)
	if status == 0 then
		KingArenaController.instance:handlePM_KingArenaGainSeasonPrizeRes(msg)
	end
end

function KingArenaAgent:sendPM_KingArenaResetZoneReq(seasonId, newZoneId)
	local req = KingArenaExtension_pb.PM_KingArenaResetZoneReq()

	req.seasonId = seasonId
	req.newZoneId = newZoneId

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaResetZoneRes(status, msg)
	KingArenaController.instance:handlePM_KingArenaResetZoneRes(status, msg)
end

function KingArenaAgent:sendPM_KingArenaGetRecordsReq(seasonId)
	local req = KingArenaExtension_pb.PM_KingArenaGetRecordsReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaGetRecordsRes(status, msg)
	if status == 0 then
		KingArenaController.instance:handlePM_KingArenaGetRecordsRes(msg)
	end
end

function KingArenaAgent:sendPM_KingArenaBattleVideoReq(battleId)
	local req = KingArenaExtension_pb.PM_KingArenaBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaBattleVideoRes(status, msg)
	if status == 0 then
		KingArenaController.instance:handlePM_KingArenaBattleVideoRes(msg)
	end
end

function KingArenaAgent:sendPM_KingArenaRankViewReq(type, zoneId)
	local req = KingArenaExtension_pb.PM_KingArenaRankViewReq()

	req.type = type
	req.zoneId = zoneId

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaRankViewRes(status, msg)
	if status == 0 then
		KingArenaController.instance:handlePM_KingArenaRankViewRes(msg)
	end
end

function KingArenaAgent:sendPM_KingArenaPetRankViewReq(seasonId, type, side)
	local req = KingArenaExtension_pb.PM_KingArenaPetRankViewReq()

	req.seasonId = seasonId
	req.type = type
	req.side = side

	self:sendMsg(req)
end

function KingArenaAgent:handlePM_KingArenaPetRankViewRes(status, msg)
	if status == 0 then
		KingArenaController.instance:handlePM_KingArenaPetRankViewRes(msg)
	end
end

KingArenaAgent.instance = KingArenaAgent.New()

return KingArenaAgent
