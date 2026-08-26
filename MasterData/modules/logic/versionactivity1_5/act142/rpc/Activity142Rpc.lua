-- chunkname: @modules/logic/versionactivity1_5/act142/rpc/Activity142Rpc.lua

module("modules.logic.versionactivity1_5.act142.rpc.Activity142Rpc", package.seeall)

local Activity142Rpc = class("Activity142Rpc", BaseRpc)

function Activity142Rpc:sendGetActInfoRequest(actId, callback, callbackObj)
	local req = Activity142Module_pb.GetAct142InfoRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity142Rpc:onReceiveGetAct142InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity142Model.instance:onReceiveGetAct142InfoReply(msg)
	end
end

function Activity142Rpc:sendActStartEpisodeRequest(actId, id, callback, callbackObj)
	local req = Activity142Module_pb.Act142StartEpisodeRequest()

	req.activityId = actId
	req.id = id

	self:sendMsg(req, callback, callbackObj)
end

function Activity142Rpc:onReceiveAct142StartEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.map and (not msg.episodeId or msg.episodeId == 0) then
		Activity142Model.instance:onReceiveAct142StartEpisodeReply(msg)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(resultCode, msg)
	end
end

function Activity142Rpc:sendActAbortRequest(actId, callback, callbackObj)
	local req = Activity142Module_pb.Act142AbortRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity142Rpc:onReceiveAct142AbortReply(resultCode, msg)
	if resultCode == 0 then
		Va3ChessGameController.instance:gameOver()
	end
end

function Activity142Rpc:sendActEventEndRequest(actId, callback, callbackObj)
	local req = Activity142Module_pb.Act142EventEndRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity142Rpc:onReceiveAct142EventEndReply(resultCode, msg)
	return
end

function Activity142Rpc:sendActUseItemRequest(actId, x, y, callback, callbackObj)
	local req = Activity142Module_pb.Act142UseItemRequest()

	req.activityId = actId
	req.x = x
	req.y = y

	self:sendMsg(req, callback, callbackObj)
end

function Activity142Rpc:onReceiveAct142UseItemReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity142Rpc:sendAct142UseFireballRequest(actId, playerX, playerY, targetX, targetY, targetId, callback, callbackObj)
	local req = Activity142Module_pb.Act142UseFireballRequest()

	req.activityId = actId
	req.x = playerX
	req.y = playerY
	req.x2 = targetX
	req.y2 = targetY
	req.killedObjectId = targetId

	self:sendMsg(req, callback, callbackObj)
end

function Activity142Rpc:onReceiveAct142UseFireballReply(resultCode, msg)
	if resultCode == 0 then
		Va3ChessGameModel.instance:setFireBallCount(msg.fireballNum)
	end
end

function Activity142Rpc:sendActBeginRoundRequest(actId, optList, callback, callbackObj)
	local req = Activity142Module_pb.Act142BeginRoundRequest()

	req.activityId = actId

	for _, opt in ipairs(optList) do
		local optSvrData = req.operations:add()

		optSvrData.id = opt.id
		optSvrData.moveDirection = opt.dir
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity142Rpc:onReceiveAct142BeginRoundReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end

	Va3ChessGameModel.instance:cleanOptList()
end

function Activity142Rpc:onReceiveAct142StepPush(resultCode, msg)
	if resultCode == 0 and Va3ChessModel.instance:getActId() == msg.activityId then
		local evtMgr = Va3ChessGameController.instance.event

		if evtMgr then
			evtMgr:insertStepList(msg.steps)
		end
	end
end

function Activity142Rpc:sendAct142CheckPointRequest(actId, isRead, callback, callbackObj)
	local req = Activity142Module_pb.Act142CheckPointRequest()

	req.activityId = actId
	req.lastCheckPoint = isRead

	self:sendMsg(req, callback, callbackObj)
end

function Activity142Rpc:onReceiveAct142CheckPointReply(resultCode, msg)
	if resultCode == 0 then
		local map = msg.map
		local mapId = map.mapId
		local actId = msg.activityId

		Va3ChessController.instance:initMapData(actId, map)
		Va3ChessGameController.instance:enterChessGame(actId, mapId, ViewName.Activity142GameView)

		if map.fragileTilebases then
			Va3ChessGameModel.instance:updateFragileTilebases(actId, map.fragileTilebases)
		end

		if map.brokenTilebases then
			Va3ChessGameModel.instance:updateBrokenTilebases(actId, map.brokenTilebases)
		end

		Activity142Controller.instance:dispatchEvent(Activity142Event.Back2CheckPoint)
	end
end

function Activity142Rpc:sendGetAct142CollectionsRequest(actId, callback, callbackObj)
	local req = Activity142Module_pb.GetAct142CollectionsRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity142Rpc:onReceiveGetAct142CollectionsReply(resultCode, msg)
	if resultCode == 0 then
		local actId = Activity142Model.instance:getActivityId()

		if actId == msg.activityId then
			for _, collectionId in ipairs(msg.collectionIds) do
				Activity142Model.instance:setHasCollection(collectionId)
			end
		end
	end
end

Activity142Rpc.instance = Activity142Rpc.New()

return Activity142Rpc
