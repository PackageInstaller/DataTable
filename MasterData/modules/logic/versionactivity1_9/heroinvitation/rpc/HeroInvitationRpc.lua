-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/rpc/HeroInvitationRpc.lua

module("modules.logic.versionactivity1_9.heroinvitation.rpc.HeroInvitationRpc", package.seeall)

local HeroInvitationRpc = class("HeroInvitationRpc", BaseRpc)

function HeroInvitationRpc:sendGetHeroInvitationInfoRequest(callback, callbackObj)
	local req = HeroInvitationModule_pb.GetHeroInvitationInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HeroInvitationRpc:onReceiveGetHeroInvitationInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HeroInvitationModel.instance:onGetHeroInvitationInfoReply(msg)
	HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.UpdateInfo)
end

function HeroInvitationRpc:sendGainInviteRewardRequest(id, callback, callbackObj)
	local req = HeroInvitationModule_pb.GainInviteRewardRequest()

	req.id = id

	return self:sendMsg(req, callback, callbackObj)
end

function HeroInvitationRpc:onReceiveGainInviteRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HeroInvitationModel.instance:onGainInviteRewardReply(msg)
	HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.UpdateInfo)
end

function HeroInvitationRpc:sendGainFinalInviteRewardRequest(callback, callbackObj)
	local req = HeroInvitationModule_pb.GainFinalInviteRewardRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HeroInvitationRpc:onReceiveGainFinalInviteRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HeroInvitationModel.instance:onGainFinalInviteRewardReply(msg)
	HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.UpdateInfo)
end

HeroInvitationRpc.instance = HeroInvitationRpc.New()

return HeroInvitationRpc
