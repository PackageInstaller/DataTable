-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/agent/OriMatGameAgent.lua

module("logic.extensions.orimatgame.agent.OriMatGameAgent", package.seeall)

local OriMatGameAgent = class("OriMatGameAgent", BaseAgent)

function OriMatGameAgent:sendPM_OriginMaterialGameInfoReq(seasonId)
	local req = OriginMaterialGameExtension_pb.PM_OriginMaterialGameInfoReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function OriMatGameAgent:handlePM_OriginMaterialGameInfoRes(status, msg)
	if status == 0 then
		OriMatGameController.instance:handlePM_OriginMaterialGameInfoRes(msg)
	end
end

function OriMatGameAgent:sendPM_OriginMaterialGameStartReq(seasonId, stageId, clientKey)
	local req = OriginMaterialGameExtension_pb.PM_OriginMaterialGameStartReq()

	req.seasonId = seasonId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function OriMatGameAgent:handlePM_OriginMaterialGameStartRes(status, msg)
	OriMatGameController.instance:handlePM_OriginMaterialGameStartRes(status, msg)
end

function OriMatGameAgent:sendPM_OriginMaterialGameEndReq(seasonId, stageId, isPass, waveId, encryptedKey)
	local req = OriginMaterialGameExtension_pb.PM_OriginMaterialGameEndReq()

	req.seasonId = seasonId
	req.stageId = stageId
	req.isPass = isPass
	req.waveId = waveId
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function OriMatGameAgent:handlePM_OriginMaterialGameEndRes(status, msg)
	OriMatGameController.instance:handlePM_OriginMaterialGameEndRes(status, msg)
end

function OriMatGameAgent:sendPM_OriginMaterialGameGainPrizeReq(seasonId)
	local req = OriginMaterialGameExtension_pb.PM_OriginMaterialGameGainPrizeReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function OriMatGameAgent:handlePM_OriginMaterialGameGainPrizeRes(status, msg)
	if status == 0 then
		OriMatGameController.instance:handlePM_OriginMaterialGameGainPrizeRes(msg)
	end
end

function OriMatGameAgent:sendPM_OriginMaterialGameUnlockTalentReq(seasonId, talentId)
	local req = OriginMaterialGameExtension_pb.PM_OriginMaterialGameUnlockTalentReq()

	req.seasonId = seasonId
	req.talentId = talentId

	self:sendMsg(req)
end

function OriMatGameAgent:handlePM_OriginMaterialGameUnlockTalentRes(status, msg)
	if status == 0 then
		OriMatGameController.instance:handlePM_OriginMaterialGameUnlockTalentRes(msg)
	end
end

function OriMatGameAgent:sendPM_OriginMaterialGameReOpenSeasonReq(seasonId, reOpenSeasonId)
	local req = OriginMaterialGameExtension_pb.PM_OriginMaterialGameReOpenSeasonReq()

	req.seasonId = seasonId
	req.reOpenSeasonId = reOpenSeasonId

	self:sendMsg(req)
end

function OriMatGameAgent:handlePM_OriginMaterialGameReOpenSeasonRes(status, msg)
	if status == 0 then
		OriMatGameController.instance:handlePM_OriginMaterialGameReOpenSeasonRes(msg)
	end
end

function OriMatGameAgent:sendPM_OriginMaterialGameAllSeasonReq()
	local req = OriginMaterialGameExtension_pb.PM_OriginMaterialGameAllSeasonReq()

	self:sendMsg(req)
end

function OriMatGameAgent:handlePM_OriginMaterialGameAllSeasonRes(status, msg)
	if status == 0 then
		OriMatGameController.instance:handlePM_OriginMaterialGameAllSeasonRes(msg)
	end
end

function OriMatGameAgent:sendPM_OriginMaterialGameOneKeyGainPrizeReq()
	local req = OriginMaterialGameExtension_pb.PM_OriginMaterialGameOneKeyGainPrizeReq()

	self:sendMsg(req)
end

function OriMatGameAgent:handlePM_OriginMaterialGameOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		OriMatGameController.instance:handlePM_OriginMaterialGameOneKeyGainPrizeRes(msg)
	end
end

OriMatGameAgent.instance = OriMatGameAgent.New()

return OriMatGameAgent
