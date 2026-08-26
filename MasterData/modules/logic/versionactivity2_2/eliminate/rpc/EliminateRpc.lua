-- chunkname: @modules/logic/versionactivity2_2/eliminate/rpc/EliminateRpc.lua

module("modules.logic.versionactivity2_2.eliminate.rpc.EliminateRpc", package.seeall)

local EliminateRpc = class("EliminateRpc", BaseRpc)

function EliminateRpc:sendStartMatch3WarChessInfoRequest(levelId, warChessCharacterId, pieceIds, callback, callbackobj)
	local msg = Match3WarChessModule_pb.StartMatch3WarChessInfoRequest()

	msg.id = levelId
	msg.WarChessCharacterId = warChessCharacterId

	for _, v in ipairs(pieceIds) do
		msg.WarChessPieceId:append(v)
	end

	self:sendMsg(msg, callback, callbackobj)
end

function EliminateRpc:onReceiveStartMatch3WarChessInfoReply(resultCode, msg)
	if resultCode == 0 then
		EliminateChessController.instance:handleEliminateChessInfo(msg.info)
		EliminateChessController.instance:handleMatch3Tips(msg.match3tips)
	end
end

function EliminateRpc:sendMatch3ChessBoardSwapRequest(startX, startY, endX, endY, callback, callbackobj)
	local msg = Match3WarChessModule_pb.Match3ChessBoardSwapRequest()

	msg.from.x = startX - 1
	msg.from.y = startY - 1
	msg.to.x = endX - 1
	msg.to.y = endY - 1

	self:sendMsg(msg, callback, callbackobj)
end

function EliminateRpc:onReceiveMatch3ChessBoardSwapReply(resultCode, msg)
	if resultCode == 0 then
		if msg.success then
			EliminateChessController.instance:handleMovePoint(msg.movePoint)
			EliminateChessController.instance:handleMatch3Tips(msg.match3tips)
		end

		EliminateChessController.instance:handleTurnInfo(msg.turn, msg.success)
		EliminateLevelController.instance:updatePlayerExtraWinCondition(msg.extraWinCondition)
	end
end

function EliminateRpc:sendGetMatch3WarChessFacadeInfoRequest(callback, callbackobj)
	local msg = Match3WarChessModule_pb.GetMatch3WarChessFacadeInfoRequest()

	self:sendMsg(msg, callback, callbackobj)
end

function EliminateRpc:onReceiveGetMatch3WarChessFacadeInfoReply(resultCode, msg)
	if resultCode == 0 then
		local ownedWarChessCharacterId = msg.ownedWarChessCharacterId
		local ownedWarChessPieceId = msg.ownedWarChessPieceId
		local episodeInfo = msg.episodeInfo
		local unlockSlotId = msg.unlockSlotId
		local totalStar = msg.totalStar
		local gainedTaskId = msg.gainedTaskId

		EliminateOutsideModel.instance:initTaskInfo(totalStar, gainedTaskId)
		EliminateOutsideModel.instance:initMapInfo(ownedWarChessCharacterId, ownedWarChessPieceId, episodeInfo, unlockSlotId)
	end
end

function EliminateRpc:sendGetMatch3WarChessTaskRewardRequest(taskId)
	local req = Match3WarChessModule_pb.GetMatch3WarChessTaskRewardRequest()

	req.taskId = taskId

	self:sendMsg(req)
end

function EliminateRpc:onReceiveGetMatch3WarChessTaskRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local taskId = msg.taskId

	EliminateOutsideModel.instance:addGainedTask(taskId)
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.UpdateTask)
end

function EliminateRpc:sendGetMatch3WarChessInfoRequest(type, callback, callbackobj)
	local req = Match3WarChessModule_pb.GetMatch3WarChessInfoRequest()

	req.type = type

	self:sendMsg(req, callback, callbackobj)
end

function EliminateRpc:onReceiveGetMatch3WarChessInfoReply(resultCode, msg)
	if resultCode == 0 then
		local type = msg.type
		local info = msg.info

		EliminateChessController.instance:handleEliminateChessInfo(info)

		if type == EliminateEnum.GetInfoType.All then
			EliminateChessController.instance:handleMatch3Tips(msg.match3tips)
		end
	end
end

function EliminateRpc:sendRefreshMatch3WarChessInfoRequest(callback, callbackobj)
	logNormal("EliminateRpc:sendRefreshMatch3WarChessInfoRequest")

	local req = Match3WarChessModule_pb.RefreshMatch3WarChessInfoRequest()

	self:sendMsg(req, callback, callbackobj)
end

function EliminateRpc:onReceiveRefreshMatch3WarChessInfoReply(resultCode, msg)
	if resultCode == 0 then
		EliminateChessController.instance:checkAndSetNeedResetData(msg)
	end
end

EliminateRpc.instance = EliminateRpc.New()

return EliminateRpc
