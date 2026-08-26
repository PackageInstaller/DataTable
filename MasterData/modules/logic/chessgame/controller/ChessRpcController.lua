-- chunkname: @modules/logic/chessgame/controller/ChessRpcController.lua

module("modules.logic.chessgame.controller.ChessRpcController", package.seeall)

local ChessRpcController = class("ChessRpcController", BaseController)

function ChessRpcController:onInit()
	return
end

function ChessRpcController:onInitFinish()
	return
end

function ChessRpcController:addConstEvents()
	return
end

function ChessRpcController:reInit()
	return
end

function ChessRpcController:_registerRcp()
	return {
		[VersionActivity2_1Enum.ActivityId.LanShouPa] = Activity164Rpc.instance
	}
end

function ChessRpcController:_getActiviyXRcpIns(actId)
	if not self._acXRcpInsMap then
		self._acXRcpInsMap = self:_registerRcp()

		local funcNames = {
			"sendGetActInfoRequest",
			"sendActStartEpisodeRequest",
			"sendActReStartEpisodeRequest",
			"sendActBeginRoundRequest",
			"sendActAbortRequest",
			"sendActRollBackRequest"
		}

		for _, rpc in pairs(self._acXRcpInsMap) do
			for __, funName in ipairs(funcNames) do
				if not rpc[funName] or type(rpc[funName]) ~= "function" then
					logError(string.format("[%s] can not find function [%s]", rpc.__cname, funName))
				end
			end
		end
	end

	local acCRpc = self._acXRcpInsMap[actId]

	if not acCRpc then
		logError(string.format("棋盘小游戏Rpc没注册，activityId[%s]", actId))
	end

	return acCRpc
end

function ChessRpcController:sendGetActInfoRequest(actId, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendGetActInfoRequest(actId, callback, callbackObj)
	end
end

function ChessRpcController:sendActStartEpisodeRequest(actId, episodeId, callback, callbackObj)
	if not actId or not episodeId then
		return
	end

	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActStartEpisodeRequest(actId, episodeId, callback, callbackObj)
	end
end

function ChessRpcController:onReceiveActStartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		ChessController.instance:initMapData(msg.activityId, msg.episodeId, msg.scene)
	end
end

function ChessRpcController:sendActReStartEpisodeRequest(actId, episodeId, callback, callbackObj)
	if not actId or not episodeId then
		return
	end

	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActReStartEpisodeRequest(actId, episodeId, callback, callbackObj)
	end
end

function ChessRpcController:sendActBeginRoundRequest(actId, episodeId, optList, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActBeginRoundRequest(actId, episodeId, optList, callback, callbackObj)
	end
end

function ChessRpcController:onReceiveActBeginRoundReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end

	ChessGameModel.instance:cleanOptList()
end

function ChessRpcController:onReceiveActStepPush(resultCode, msg)
	if resultCode == 0 and Va3ChessModel.instance:getActId() == msg.activityId then
		local evtMgr = Va3ChessGameController.instance.event

		if evtMgr then
			evtMgr:insertStepList(msg.steps)
		end
	end
end

function ChessRpcController:sendActEventEndRequest(actId, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActEventEndRequest(actId, callback, callbackObj)
	end
end

function ChessRpcController:onReceiveActEventEndReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ChessRpcController:sendActAbortRequest(actId, episodeId, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId, episodeId)

	if acCRpc then
		acCRpc:sendActAbortRequest(actId, episodeId, callback, callbackObj)
	end
end

function ChessRpcController:onReceiveActAbortReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ChessRpcController:sendActRollBackRequest(actId, episodeId, rollBackType, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActRollBackRequest(actId, episodeId, rollBackType, callback, callbackObj)
	end
end

ChessRpcController.instance = ChessRpcController.New()

return ChessRpcController
