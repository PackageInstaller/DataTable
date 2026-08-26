-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/rpc/Activity164Rpc.lua

module("modules.logic.versionactivity2_1.lanshoupa.rpc.Activity164Rpc", package.seeall)

local Activity164Rpc = class("Activity164Rpc", BaseRpc)

function Activity164Rpc:sendGetActInfoRequest(actId, callback, callbackObj)
	local req = Activity164Module_pb.GetAct164InfoRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity164Rpc:onReceiveGetAct164InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity164Model.instance:onReceiveGetAct164InfoReply(msg)
		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.Refresh164MapData)
	end
end

function Activity164Rpc:sendActStartEpisodeRequest(actId, episodeId, callback, callbackObj)
	local req = Activity164Module_pb.Act164StartEpisodeRequest()

	req.activityId = actId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity164Rpc:onReceiveAct164StartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		ChessRpcController.instance:onReceiveActStartEpisodeReply(resultCode, msg)
	end
end

function Activity164Rpc:sendActReStartEpisodeRequest(actId, episodeId, callback, callbackObj)
	local req = Activity164Module_pb.Act164ReStartEpisodeRequest()

	req.activityId = actId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity164Rpc:onReceiveAct164ReStartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		ChessGameModel.instance:setGameState(nil)
		ChessGameController.instance:abortGame()
		ChessRpcController.instance:onReceiveActStartEpisodeReply(resultCode, msg)
	end
end

function Activity164Rpc:sendActBeginRoundRequest(actId, episodeId, optList, callback, callbackObj)
	local req = Activity164Module_pb.Act164BeginRoundRequest()

	req.activityId = actId
	req.episodeId = episodeId

	for _, opt in ipairs(optList) do
		local optSvrData = req.operations:add()

		optSvrData.type = opt.type
		optSvrData.id = opt.id
		optSvrData.direction = opt.direction
		optSvrData.param = opt.param
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity164Rpc:onReceiveAct164BeginRoundReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end

	ChessGameModel.instance:addRound()
	ChessGameModel.instance:cleanOptList()
end

function Activity164Rpc:onReceiveAct164StepPush(resultCode, msg)
	if resultCode == 0 and ChessModel.instance:getActId() == msg.activityId then
		local evtMgr = ChessGameController.instance.eventMgr

		if evtMgr then
			evtMgr:insertStepList(msg.steps)
		end
	end
end

function Activity164Rpc:sendActAbortRequest(actId, episodeId, callback, callbackObj)
	local req = Activity164Module_pb.Act164AbortRequest()

	req.activityId = actId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity164Rpc:onReceiveAct164AbortReply(resultCode, msg)
	if resultCode == 0 then
		ChessGameController.instance:gameOver()
	end
end

function Activity164Rpc:sendActRollBackRequest(actId, episodeId, rollBackType, callback, callbackObj)
	local req = Activity164Module_pb.Act164RollbackRequest()

	req.activityId = actId
	req.episodeId = episodeId
	req.type = rollBackType

	self:sendMsg(req, callback, callbackObj)
end

function Activity164Rpc:onReceiveAct164RollbackReply(resultCode, msg)
	if resultCode == 0 then
		ChessRpcController.instance:onReceiveActStartEpisodeReply(resultCode, msg)
		ChessGameModel.instance:setGameState(nil)
		ChessGameController.instance:dispatchEvent(ChessGameEvent.RollBack)
		ChessGameModel.instance:addRollBackNum()
	end
end

Activity164Rpc.instance = Activity164Rpc.New()

return Activity164Rpc
