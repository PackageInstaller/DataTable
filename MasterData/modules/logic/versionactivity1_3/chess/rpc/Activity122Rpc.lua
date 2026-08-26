-- chunkname: @modules/logic/versionactivity1_3/chess/rpc/Activity122Rpc.lua

module("modules.logic.versionactivity1_3.chess.rpc.Activity122Rpc", package.seeall)

local Activity122Rpc = class("Activity122Rpc", BaseRpc)

function Activity122Rpc:sendGetActInfoRequest(actId, callback, callbackObj)
	local req = Activity122Module_pb.GetAct122InfosRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity122Rpc:onReceiveGetAct122InfosReply(resultCode, msg)
	if resultCode == 0 then
		Activity122Model.instance:onReceiveGetAct122InfoReply(msg)
	end
end

function Activity122Rpc:sendActStartEpisodeRequest(actId, id, callback, callbackObj)
	local req = Activity122Module_pb.Act122StartEpisodeRequest()

	req.activityId = actId
	req.id = id

	self:sendMsg(req, callback, callbackObj)
end

function Activity122Rpc:onReceiveAct122StartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		Activity122Model.instance:onReceiveAct122StartEpisodeReply(msg)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(resultCode, msg)
	end
end

function Activity122Rpc:sendActBeginRoundRequest(actId, optList, callback, callbackObj)
	local req = Activity122Module_pb.Act122BeginRoundRequest()

	req.activityId = actId

	for _, opt in ipairs(optList) do
		local optSvrData = req.operations:add()

		optSvrData.id = opt.id
		optSvrData.moveDirection = opt.dir
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity122Rpc:onReceiveAct122BeginRoundReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end

	Va3ChessGameModel.instance:cleanOptList()
end

function Activity122Rpc:sendActUseItemRequest(actId, x, y, callback, callbackObj)
	local req = Activity122Module_pb.Act122UseItemRequest()

	req.activityId = actId
	req.x = x
	req.y = y

	self:sendMsg(req, callback, callbackObj)
end

function Activity122Rpc:onReceiveAct122UseItemReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity122Rpc:onReceiveAct122StepPush(resultCode, msg)
	if resultCode == 0 and Va3ChessModel.instance:getActId() == msg.activityId then
		local evtMgr = Va3ChessGameController.instance.event

		if evtMgr then
			evtMgr:insertStepList(msg.steps)
		end
	end
end

function Activity122Rpc:sendActEventEndRequest(actId, callback, callbackObj)
	local req = Activity122Module_pb.Act122EventEndRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity122Rpc:onReceiveAct122EventEndReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity122Rpc:sendActAbortRequest(actId, callback, callbackObj)
	local req = Activity122Module_pb.Act122AbortRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity122Rpc:onReceiveAct122AbortReply(resultCode, msg)
	if resultCode == 0 then
		Va3ChessGameController.instance:gameOver()
	end
end

function Activity122Rpc:sendAct122CheckPointRequest(actId, isRead, callback, callbackObj)
	local req = Activity122Module_pb.Act122CheckPointRequest()

	req.activityId = actId
	req.lastCheckPoint = isRead

	self:sendMsg(req, callback, callbackObj)
end

function Activity122Rpc:onReceiveAct122CheckPointReply(resultCode, msg)
	return
end

Activity122Rpc.instance = Activity122Rpc.New()

return Activity122Rpc
