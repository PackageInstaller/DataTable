-- chunkname: @modules/logic/v3a8_dragonboat/rpc/V3a8_DragonBoatRpc.lua

module("modules.logic.v3a8_dragonboat.rpc.V3a8_DragonBoatRpc", package.seeall)

local V3a8_DragonBoatRpc = class("V3a8_DragonBoatRpc", Activity241Rpc)

function V3a8_DragonBoatRpc:ctor(...)
	V3a8_DragonBoatRpc.super.ctor(self, ...)
end

function V3a8_DragonBoatRpc:actId()
	return V3a8_DragonBoatConfig.instance:actId()
end

function V3a8_DragonBoatRpc:onInit()
	V3a8_DragonBoatRpc.super.onInit(self)
	Activity241Rpc.instance:registerCallback(Activity241Event.onReceiveAct241GetInfoReply, self._onReceiveAct241GetInfoReply, self)
	Activity241Rpc.instance:registerCallback(Activity241Event.onReceiveAct241VoteReply, self._onReceiveAct241VoteReply, self)
	Activity241Rpc.instance:registerCallback(Activity241Event.onReceiveAct241GetBonusReply, self._onReceiveAct241GetBonusReply, self)
end

function V3a8_DragonBoatRpc:_onReceiveAct241GetInfoReply(resultCode, msg)
	if resultCode == 0 then
		if msg.activityId ~= self:actId() then
			return
		end

		V3a8_DragonBoatModel.instance:onReceiveAct241GetInfoReply(msg)
	end
end

function V3a8_DragonBoatRpc:_onReceiveAct241VoteReply(resultCode, msg)
	if resultCode == 0 then
		if msg.activityId ~= self:actId() then
			return
		end

		V3a8_DragonBoatModel.instance:onReceiveAct241VoteReply(msg)
	end
end

function V3a8_DragonBoatRpc:_onReceiveAct241GetBonusReply(resultCode, msg)
	if resultCode == 0 then
		if msg.activityId ~= self:actId() then
			return
		end

		V3a8_DragonBoatModel.instance:onReceiveAct241GetBonusReply(msg)
	end
end

V3a8_DragonBoatRpc.instance = V3a8_DragonBoatRpc.New()

return V3a8_DragonBoatRpc
