-- chunkname: @modules/logic/versionactivity1_3/jialabona/rpc/Activity120Rpc.lua

module("modules.logic.versionactivity1_3.jialabona.rpc.Activity120Rpc", package.seeall)

local Activity120Rpc = class("Activity120Rpc", BaseRpc)

function Activity120Rpc:sendGetActInfoRequest(actId, callback, callbackObj)
	local req = Activity120Module_pb.GetAct120InfoRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity120Rpc:onReceiveGetAct120InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity120Model.instance:onReceiveGetAct120InfoReply(msg)
		JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.Refresh120MapData)
	end
end

function Activity120Rpc:sendActStartEpisodeRequest(actId, id, callback, callbackObj)
	local req = Activity120Module_pb.Act120StartEpisodeRequest()

	req.activityId = actId
	req.id = id

	self:sendMsg(req, callback, callbackObj)
end

function Activity120Rpc:onReceiveAct120StartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		Va3ChessGameModel.instance:clearLastMapRound()
		Activity120Model.instance:increaseCount(msg.map.id)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(resultCode, msg)
	end
end

function Activity120Rpc:sendActBeginRoundRequest(actId, optList, callback, callbackObj)
	local req = Activity120Module_pb.Act120BeginRoundRequest()

	req.activityId = actId

	for _, opt in ipairs(optList) do
		local optSvrData = req.operations:add()

		optSvrData.id = opt.id
		optSvrData.moveDirection = opt.dir
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity120Rpc:onReceiveAct120BeginRoundReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end

	Va3ChessGameModel.instance:cleanOptList()
end

function Activity120Rpc:sendActUseItemRequest(actId, x, y, callback, callbackObj)
	local req = Activity120Module_pb.Act120UseItemRequest()

	req.activityId = actId
	req.x = x
	req.y = y

	self:sendMsg(req, callback, callbackObj)
end

function Activity120Rpc:onReceiveAct120UseItemReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity120Rpc:onReceiveAct120StepPush(resultCode, msg)
	if resultCode == 0 and Va3ChessModel.instance:getActId() == msg.activityId then
		local evtMgr = Va3ChessGameController.instance.event

		if evtMgr then
			evtMgr:insertStepList(msg.steps)
		end
	end
end

function Activity120Rpc:sendActEventEndRequest(actId, callback, callbackObj)
	local req = Activity120Module_pb.Act120EventEndRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity120Rpc:onReceiveAct120EventEndReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity120Rpc:sendActAbortRequest(actId, callback, callbackObj)
	local req = Activity120Module_pb.Act120AbortRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity120Rpc:onReceiveAct120AbortReply(resultCode, msg)
	if resultCode == 0 then
		Va3ChessGameController.instance:gameOver()
	end
end

function Activity120Rpc:sendActCheckPointRequest(actId, isLastCheckPoint, callback, callbackObj)
	local req = Activity120Module_pb.Act120CheckPointRequest()

	req.activityId = actId
	req.lastCheckPoint = not not isLastCheckPoint

	self:sendMsg(req, callback, callbackObj)
end

function Activity120Rpc:onReceiveAct120CheckPointReply(resultCode, msg)
	if resultCode == 0 then
		Activity120Model.instance:increaseCount(msg.map.id)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(resultCode, msg)
	end
end

Activity120Rpc.instance = Activity120Rpc.New()

return Activity120Rpc
