-- chunkname: @modules/logic/versionactivity1_3/va3chess/controller/Va3ChessRpcController.lua

module("modules.logic.versionactivity1_3.va3chess.controller.Va3ChessRpcController", package.seeall)

local Va3ChessRpcController = class("Va3ChessRpcController", BaseController)

function Va3ChessRpcController:onInit()
	return
end

function Va3ChessRpcController:onInitFinish()
	return
end

function Va3ChessRpcController:addConstEvents()
	return
end

function Va3ChessRpcController:reInit()
	return
end

function Va3ChessRpcController:_registerRcp()
	return {
		[Va3ChessEnum.ActivityId.Act120] = Activity120Rpc.instance,
		[Va3ChessEnum.ActivityId.Act122] = Activity122Rpc.instance,
		[Va3ChessEnum.ActivityId.Act142] = Activity142Rpc.instance
	}
end

function Va3ChessRpcController:_getActiviyXRcpIns(actId)
	if not self._acXRcpInsMap then
		self._acXRcpInsMap = self:_registerRcp()

		local funcNames = {
			"sendGetActInfoRequest",
			"sendActStartEpisodeRequest",
			"sendActAbortRequest",
			"sendActEventEndRequest",
			"sendActUseItemRequest",
			"sendActBeginRoundRequest"
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

function Va3ChessRpcController:sendGetActInfoRequest(actId, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendGetActInfoRequest(actId, callback, callbackObj)
	end
end

function Va3ChessRpcController:sendActStartEpisodeRequest(actId, id, callback, callbackObj)
	if not actId or not id then
		return
	end

	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActStartEpisodeRequest(actId, id, callback, callbackObj)
	end
end

function Va3ChessRpcController:onReceiveActStartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		Va3ChessController.instance:initMapData(msg.activityId, msg.map)
	end
end

function Va3ChessRpcController:sendActBeginRoundRequest(actId, optList, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActBeginRoundRequest(actId, optList, callback, callbackObj)
	end
end

function Va3ChessRpcController:onReceiveActBeginRoundReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end

	Va3ChessGameModel.instance:cleanOptList()
end

function Va3ChessRpcController:sendActUseItemRequest(actId, x, y, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActUseItemRequest(actId, x, y, callback, callbackObj)
	end
end

function Va3ChessRpcController:onReceiveActUseItemReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Va3ChessRpcController:onReceiveActStepPush(resultCode, msg)
	if resultCode == 0 and Va3ChessModel.instance:getActId() == msg.activityId then
		local evtMgr = Va3ChessGameController.instance.event

		if evtMgr then
			evtMgr:insertStepList(msg.steps)
		end
	end
end

function Va3ChessRpcController:sendActEventEndRequest(actId, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActEventEndRequest(actId, callback, callbackObj)
	end
end

function Va3ChessRpcController:onReceiveActEventEndReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Va3ChessRpcController:sendActAbortRequest(actId, callback, callbackObj)
	local acCRpc = self:_getActiviyXRcpIns(actId)

	if acCRpc then
		acCRpc:sendActAbortRequest(actId, callback, callbackObj)
	end
end

function Va3ChessRpcController:onReceiveActAbortReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

Va3ChessRpcController.instance = Va3ChessRpcController.New()

return Va3ChessRpcController
