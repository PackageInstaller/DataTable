-- chunkname: @modules/logic/versionactivity3_2/cruise/rpc/Activity215Rpc.lua

module("modules.logic.versionactivity3_2.cruise.rpc.Activity215Rpc", package.seeall)

local Activity215Rpc = class("Activity215Rpc", BaseRpc)

Activity215Rpc.instance = Activity215Rpc.New()

function Activity215Rpc:sendGetAct215InfoRequest(activityId, callback, callbackObj)
	local req = Activity215Module_pb.GetAct215InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity215Rpc:onReceiveGetAct215InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity215Model.instance:setAct215Info(msg.info, msg.activityId)
	Activity215Controller.instance:dispatchEvent(Activity215Event.onGetInfo)
end

function Activity215Rpc:sendSubmitAct215ItemRequest(activityId, count, callback, callbackObj)
	local req = Activity215Module_pb.SubmitAct215ItemRequest()

	req.activityId = activityId
	req.submitCount = count

	self:sendMsg(req, callback, callbackObj)
end

function Activity215Rpc:onReceiveSubmitAct215ItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity215Model.instance:updateItemSubmitCount(msg.itemSubmitCount, msg.activityId)
	Activity215Controller.instance:dispatchEvent(Activity215Event.onItemSubmitCountChange)
end

function Activity215Rpc:sendGetAct215MilestoneBonusRequest(activityId, callback, callbackObj)
	local req = Activity215Module_pb.GetAct215MilestoneBonusRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity215Rpc:onReceiveGetAct215MilestoneBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity215Model.instance:updateAcceptedRewardId(msg.acceptedRewardId, msg.activityId)
	Activity215Controller.instance:dispatchEvent(Activity215Event.onAcceptedRewardIdChange)
end

function Activity215Rpc:onReceiveAct215InfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity215Model.instance:setAct215Info(msg.info, msg.activityId)
	Activity215Controller.instance:dispatchEvent(Activity215Event.OnInfoChanged)
end

function Activity215Rpc:sendRefreshAct215LastViewItemRequest(activityId, callback, callbackObj)
	local req = Activity215Module_pb.RefreshAct215LastViewItemRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity215Rpc:onReceiveRefreshAct215LastViewItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

return Activity215Rpc
