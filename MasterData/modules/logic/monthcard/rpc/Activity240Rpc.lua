-- chunkname: @modules/logic/monthcard/rpc/Activity240Rpc.lua

module("modules.logic.monthcard.rpc.Activity240Rpc", package.seeall)

local Activity240Rpc = class("Activity240Rpc", BaseRpc)

function Activity240Rpc:sendAct240GetInfoRequest(activityId, callback, callbackObj)
	local req = Activity240Module_pb.Act240GetInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity240Rpc:onReceiveAct240GetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity3_8FreeMonthCardModel.instance:set240Infos(msg)
	MonthCardController.instance:dispatchEvent(MonthCardEvent.onInfoChanged)
end

function Activity240Rpc:sendAct240SignInRequest(activityId)
	local req = Activity240Module_pb.Act240SignInRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity240Rpc:onReceiveAct240SignInReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity3_8FreeMonthCardModel.instance:setDaySignIn({
		msg.id
	})
	MonthCardController.instance:dispatchEvent(MonthCardEvent.onSignStateChanged)
end

function Activity240Rpc:sendAct240BackdateRequest(activityId)
	local req = Activity240Module_pb.Act240BackdateRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity240Rpc:onReceiveAct240BackdateReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VersionActivity3_8FreeMonthCardModel.instance:setDaySignIn(msg.ids)
	MonthCardController.instance:dispatchEvent(MonthCardEvent.onSignStateChanged)
end

Activity240Rpc.instance = Activity240Rpc.New()

return Activity240Rpc
