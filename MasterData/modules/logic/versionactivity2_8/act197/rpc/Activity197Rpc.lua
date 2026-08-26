-- chunkname: @modules/logic/versionactivity2_8/act197/rpc/Activity197Rpc.lua

module("modules.logic.versionactivity2_8.act197.rpc.Activity197Rpc", package.seeall)

local Activity197Rpc = class("Activity197Rpc", BaseRpc)

function Activity197Rpc:sendGet197InfoRequest(activityId, callback, callbackObj)
	local req = Activity197Module_pb.Get197InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity197Rpc:onReceiveGet197InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity197Model.instance:setActInfo(msg)
end

function Activity197Rpc:sendAct197RummageRequest(activityId, poolId, callback, callbackObj)
	local req = Activity197Module_pb.Act197RummageRequest()

	req.activityId = activityId
	req.poolId = poolId

	self:sendMsg(req, callback, callbackObj)
end

function Activity197Rpc:onReceiveAct197RummageReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local poolId = msg.poolId
	local id = msg.id

	Activity197Model.instance:_initCurrency()
	Activity197Model.instance:updatePool(poolId, id)
end

function Activity197Rpc:sendAct197ExploreReqvest(activityId, type, callback, callbackObj)
	local req = Activity197Module_pb.Act197ExploreRequest()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req, callback, callbackObj)
end

function Activity197Rpc:onReceiveAct197ExploreReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity197Model.instance:_initCurrency()
	Activity197Controller.instance:dispatchEvent(Activity197Event.onReceiveAct197Explore)
end

Activity197Rpc.instance = Activity197Rpc.New()

return Activity197Rpc
