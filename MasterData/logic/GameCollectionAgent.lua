-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minigamecollection/agent/GameCollectionAgent.lua

module("logic.extensions.gamecollection.agent.GameCollectionAgent", package.seeall)

local GameCollectionAgent = class("GameCollectionAgent", BaseAgent)

GameCollectionAgent.PM_GameECollectionGetInfoRes = "GameCollectionAgent_PM_GameECollectionGetInfoRes"
GameCollectionAgent.PM_GameECollectionBuyTimesRes = "GameCollectionAgent_PM_GameECollectionBuyTimesRes"

function GameCollectionAgent:ctor()
	return
end

function GameCollectionAgent:setExtId(extId)
	GameCollectionAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function GameCollectionAgent:sendPM_GameECollectionGetInfoReq(handler, handlerObj, errHandler)
	local req = GameCollectionExtension_pb.PM_GameECollectionGetInfoReq()

	self:sendMsg(req)
	self:addEventOnce(GameCollectionAgent.PM_GameECollectionGetInfoRes, handler, handlerObj, errHandler)
end

function GameCollectionAgent:handlePM_GameECollectionGetInfoRes(status, msg)
	self:dispatch(GameCollectionAgent.PM_GameECollectionGetInfoRes, status, msg)
end

function GameCollectionAgent:sendPM_GameECollectionBuyTimesReq(handler, handlerObj, errHandler)
	local req = GameCollectionExtension_pb.PM_GameECollectionBuyTimesReq()

	self:sendMsg(req)
	self:addEventOnce(GameCollectionAgent.PM_GameECollectionBuyTimesRes, handler, handlerObj, errHandler)
end

function GameCollectionAgent:handlePM_GameECollectionBuyTimesRes(status, msg)
	self:dispatch(GameCollectionAgent.PM_GameECollectionBuyTimesRes, status, msg)
end

GameCollectionAgent.instance = GameCollectionAgent.New()

return GameCollectionAgent
