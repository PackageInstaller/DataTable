-- chunkname: @modules/logic/toughbattle/rpc/SiegeBattleRpc.lua

module("modules.logic.toughbattle.rpc.SiegeBattleRpc", package.seeall)

local SiegeBattleRpc = class("SiegeBattleRpc", BaseRpc)

function SiegeBattleRpc:sendGetSiegeBattleInfoRequest(callback, callbackobj)
	local req = SiegeBattleModule_pb.GetSiegeBattleInfoRequest()

	return self:sendMsg(req, callback, callbackobj)
end

function SiegeBattleRpc:onReceiveGetSiegeBattleInfoReply(resultCode, msg)
	if resultCode == 0 then
		ToughBattleModel.instance:onGetStoryInfo(msg.info)
	end
end

function SiegeBattleRpc:sendStartSiegeBattleRequest(callback, callbackobj)
	local req = SiegeBattleModule_pb.StartSiegeBattleRequest()

	return self:sendMsg(req, callback, callbackobj)
end

function SiegeBattleRpc:onReceiveStartSiegeBattleReply(resultCode, msg)
	if resultCode == 0 then
		ToughBattleModel.instance:onGetStoryInfo(msg.info)
	end
end

function SiegeBattleRpc:sendAbandonSiegeBattleRequest(callback, callbackobj)
	local req = SiegeBattleModule_pb.AbandonSiegeBattleRequest()

	return self:sendMsg(req, callback, callbackobj)
end

function SiegeBattleRpc:onReceiveAbandonSiegeBattleReply(resultCode, msg)
	if resultCode == 0 then
		ToughBattleModel.instance:onGetStoryInfo(msg.info)
	end
end

SiegeBattleRpc.instance = SiegeBattleRpc.New()

return SiegeBattleRpc
