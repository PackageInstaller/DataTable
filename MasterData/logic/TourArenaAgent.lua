-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/agent/TourArenaAgent.lua

module("logic.extensions.tourarena.agent.TourArenaAgent", package.seeall)

local TourArenaAgent = class("TourArenaAgent", BaseAgent)

function TourArenaAgent:sendPM_TourArenaZoneInfoReq(termId)
	local req = TourArenaExtension_pb.PM_TourArenaZoneInfoReq()

	req.termId = termId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaZoneInfoRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaZoneInfoRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaZoneBindingReq(termId)
	local req = TourArenaExtension_pb.PM_TourArenaZoneBindingReq()

	req.termId = termId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaZoneBindingRes(status, msg)
	TourArenaController.instance:handlePM_TourArenaZoneBindingRes(status, msg)
end

function TourArenaAgent:sendPM_TourArenaZoneSelectBindingReq(termId, province)
	local req = TourArenaExtension_pb.PM_TourArenaZoneSelectBindingReq()

	req.termId = termId
	req.province = province

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaZoneSelectBindingRes(status, msg)
	TourArenaController.instance:handlePM_TourArenaZoneSelectBindingRes(status, msg)
end

function TourArenaAgent:sendPM_TourArenaGameInfoReq(activityId)
	local req = TourArenaExtension_pb.PM_TourArenaGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaGameInfoRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaGameInfoRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaGameStartGameReq(activityId, gameId, stageId, clientKey)
	local req = TourArenaExtension_pb.PM_TourArenaGameStartGameReq()

	req.activityId = activityId
	req.gameId = gameId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaGameStartGameRes(status, msg)
	TourArenaController.instance:handlePM_TourArenaGameStartGameRes(status, msg)
end

function TourArenaAgent:sendPM_TourArenaGameEndGameReq(activityId, gameId, stageId, isPass, progressIdx, encryptedKey)
	local req = TourArenaExtension_pb.PM_TourArenaGameEndGameReq()

	req.activityId = activityId
	req.gameId = gameId
	req.stageId = stageId
	req.isPass = isPass
	req.progressIdx = progressIdx
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaGameEndGameRes(status, msg)
	TourArenaController.instance:handlePM_TourArenaGameEndGameRes(status, msg)
end

function TourArenaAgent:sendPM_TourArenaGameGainPrizeReq(activityId, prizeId)
	local req = TourArenaExtension_pb.PM_TourArenaGameGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaGameGainPrizeRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaGameGainPrizeRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaGameTotalRankReq(activityId, zoneId)
	local req = TourArenaExtension_pb.PM_TourArenaGameTotalRankReq()

	req.activityId = activityId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaGameTotalRankRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaGameTotalRankRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaGameRankReq(activityId, gameId)
	local req = TourArenaExtension_pb.PM_TourArenaGameRankReq()

	req.activityId = activityId
	req.gameId = gameId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaGameRankRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaGameRankRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaFightInfoReq(activityId)
	local req = TourArenaExtension_pb.PM_TourArenaFightInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaFightInfoRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaFightInfoRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaFightGainPrizeReq(activityId, prizeId)
	local req = TourArenaExtension_pb.PM_TourArenaFightGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaFightGainPrizeRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaFightGainPrizeRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaFightTotalRankReq(activityId, zoneId)
	local req = TourArenaExtension_pb.PM_TourArenaFightTotalRankReq()

	req.activityId = activityId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaFightTotalRankRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaFightTotalRankRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaPeriodRankReq(activityId)
	local req = TourArenaExtension_pb.PM_TourArenaPeriodRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaPeriodRankRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaPeriodRankRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaFightGainPeriodPrizeReq(activityId, prizeId)
	local req = TourArenaExtension_pb.PM_TourArenaFightGainPeriodPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaFightGainPeriodPrizeRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaFightGainPeriodPrizeRes(msg)
	end
end

function TourArenaAgent:sendPM_TourArenaGameStageInfoReq(activityId, gameId)
	local req = TourArenaExtension_pb.PM_TourArenaGameStageInfoReq()

	req.activityId = activityId
	req.gameId = gameId

	self:sendMsg(req)
end

function TourArenaAgent:handlePM_TourArenaGameStageInfoRes(status, msg)
	if status == 0 then
		TourArenaController.instance:handlePM_TourArenaGameStageInfoRes(msg)
	end
end

TourArenaAgent.instance = TourArenaAgent.New()

return TourArenaAgent
