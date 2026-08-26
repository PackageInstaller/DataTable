-- chunkname: @modules/logic/versionactivity2_8/act196/rpc/Activity196Rpc.lua

module("modules.logic.versionactivity2_8.act196.rpc.Activity196Rpc", package.seeall)

local Activity196Rpc = class("Activity196Rpc", BaseRpc)

function Activity196Rpc:sendGet196InfoRequest(activityId, callback, callbackObj)
	local req = Activity196Module_pb.Get196InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity196Rpc:onReceiveGet196InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rewardIdList = msg.hasGain

	Activity196Model.instance:setActInfo(rewardIdList)
end

function Activity196Rpc:sendAct196GainRequest(activityId, id, callback, callbackObj)
	local req = Activity196Module_pb.Act196GainRequest()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req, callback, callbackObj)
end

function Activity196Rpc:onReceiveAct196GainReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local id = msg.id

	Activity196Model.instance:updateRewardIdList(id)
end

Activity196Rpc.instance = Activity196Rpc.New()

return Activity196Rpc
