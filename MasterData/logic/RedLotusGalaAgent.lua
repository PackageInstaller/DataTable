-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/agent/RedLotusGalaAgent.lua

module("logic.extensions.redlotusgala.agent.RedLotusGalaAgent", package.seeall)

local RedLotusGalaAgent = class("RedLotusGalaAgent", BaseAgent)

function RedLotusGalaAgent:ctor()
	return
end

function RedLotusGalaAgent:setExtId(extId)
	RedLotusGalaAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function RedLotusGalaAgent:sendPM_RedLotusGalaGetInfoReq(actId, gameId)
	local req = RedLotusGalaExtension_pb.PM_RedLotusGalaGetInfoReq()

	req.actId = actId
	req.gameId = gameId

	self:sendMsg(req)
end

function RedLotusGalaAgent:handlePM_RedLotusGalaGetInfoRes(status, msg)
	if status == 0 then
		RedLotusDinnerPartyController.instance:onGetInfo(msg)
	end
end

function RedLotusGalaAgent:sendPM_RedLotusGalaStartGameReq(actId, gameId, stageId, clientKey)
	local req = RedLotusGalaExtension_pb.PM_RedLotusGalaStartGameReq()

	req.actId = actId
	req.gameId = gameId

	if stageId ~= nil then
		req.stageId = stageId
	end

	req.clientKey = clientKey

	self:sendMsg(req)
end

function RedLotusGalaAgent:handlePM_RedLotusGalaStartGameRes(status, msg)
	if status == 0 then
		RedLotusDinnerPartyController.instance:onStartGame(msg)
	end
end

function RedLotusGalaAgent:sendPM_RedLotusGalaEndGameReq(actId, gameId, isPass, score, encryptedKey)
	local req = RedLotusGalaExtension_pb.PM_RedLotusGalaEndGameReq()

	req.actId = actId
	req.gameId = gameId
	req.isPass = isPass

	if score ~= nil then
		req.score = score
	end

	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function RedLotusGalaAgent:handlePM_RedLotusGalaEndGameRes(status, msg)
	if status == 0 then
		RedLotusDinnerPartyController.instance:onEndGame(msg)
	end
end

function RedLotusGalaAgent:sendPM_RedLotusGalaGainPrizeReq(actId, gameId, prizeId)
	local req = RedLotusGalaExtension_pb.PM_RedLotusGalaGainPrizeReq()

	req.actId = actId
	req.gameId = gameId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function RedLotusGalaAgent:handlePM_RedLotusGalaGainPrizeRes(status, msg)
	if status == 0 then
		RedLotusDinnerPartyController.instance:onGainPrize(msg)
	end
end

function RedLotusGalaAgent:sendPM_RedLotusGalaBuyTimesReq(actId, gameId)
	local req = RedLotusGalaExtension_pb.PM_RedLotusGalaBuyTimesReq()

	req.actId = actId
	req.gameId = gameId

	self:sendMsg(req)
end

function RedLotusGalaAgent:handlePM_RedLotusGalaBuyTimesRes(status, msg)
	if status == 0 then
		RedLotusDinnerPartyController.instance:onBuyTimes(msg)
	end
end

RedLotusGalaAgent.instance = RedLotusGalaAgent.New()

return RedLotusGalaAgent
