-- chunkname: @modules/logic/versionactivity2_8/act199/rpc/Activity199Rpc.lua

module("modules.logic.versionactivity2_8.act199.rpc.Activity199Rpc", package.seeall)

local Activity199Rpc = class("Activity199Rpc", BaseRpc)

function Activity199Rpc:sendGet199InfoRequest(activityId, callback, callbackObj)
	local req = Activity199Module_pb.Get199InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity199Rpc:onReceiveGet199InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity199Model.instance:setActInfo(msg)
end

function Activity199Rpc:sendAct199GainRequest(activityId, heroId, callback, callbackObj)
	local req = Activity199Module_pb.Act199GainRequest()

	req.activityId = activityId
	req.heroId = heroId

	self:sendMsg(req, callback, callbackObj)
end

function Activity199Rpc:onReceiveAct199GainReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local heroId = msg.heroId

	Activity199Model.instance:updateHeroId(heroId)
	V2a8_SelfSelectSix_PickChoiceController.instance:dispatchEvent(V2a8_SelfSelectSix_PickChoiceEvent.GetHero)
end

Activity199Rpc.instance = Activity199Rpc.New()

return Activity199Rpc
