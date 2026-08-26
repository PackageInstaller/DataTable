-- chunkname: @modules/logic/activity/rpc/Activity109Rpc.lua

module("modules.logic.activity.rpc.Activity109Rpc", package.seeall)

local Activity109Rpc = class("Activity109Rpc", BaseRpc)

function Activity109Rpc:sendGetAct109InfoRequest(actId, callback, callbackObj)
	local req = Activity109Module_pb.GetAct109InfoRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity109Rpc:onReceiveGetAct109InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity109Model.instance:onReceiveGetAct109InfoReply(msg)
		Activity109ChessController.instance:initMapData(msg.activityId, msg.map)
	end
end

function Activity109Rpc:sendAct109StartEpisodeRequest(actId, id, callback, callbackObj)
	local req = Activity109Module_pb.Act109StartEpisodeRequest()

	req.activityId = actId
	req.id = id

	self:sendMsg(req, callback, callbackObj)
end

function Activity109Rpc:onReceiveAct109StartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		Activity109Model.instance:increaseCount(msg.map.id)
		Activity109ChessController.instance:initMapData(msg.activityId, msg.map)
	end
end

function Activity109Rpc:sendAct109BeginRoundRequest(actId, optList, callback, callbackObj)
	local req = Activity109Module_pb.Act109BeginRoundRequest()

	req.activityId = actId

	for _, opt in ipairs(optList) do
		local optSvrData = req.operations:add()

		optSvrData.id = opt.id
		optSvrData.moveDirection = opt.dir
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity109Rpc:onReceiveAct109BeginRoundReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end

	ActivityChessGameModel.instance:cleanOptList()
end

function Activity109Rpc:sendAct109UseItemRequest(actId, x, y, callback, callbackObj)
	local req = Activity109Module_pb.Act109UseItemRequest()

	req.activityId = actId
	req.x = x
	req.y = y

	self:sendMsg(req, callback, callbackObj)
end

function Activity109Rpc:onReceiveAct109UseItemReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity109Rpc:onReceiveAct109StepPush(resultCode, msg)
	if resultCode == 0 and Activity109ChessModel.instance:getActId() == msg.activityId then
		local evtMgr = ActivityChessGameController.instance.event

		if evtMgr then
			evtMgr:insertStepList(msg.steps)
		end
	end
end

function Activity109Rpc:sendAct109EventEndRequest(actId, callback, callbackObj)
	local req = Activity109Module_pb.Act109EventEndRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity109Rpc:onReceiveAct109EventEndReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity109Rpc:sendAct109AbortRequest(actId, callback, callbackObj)
	local req = Activity109Module_pb.Act109AbortRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity109Rpc:onReceiveAct109AbortReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

Activity109Rpc.instance = Activity109Rpc.New()

return Activity109Rpc
