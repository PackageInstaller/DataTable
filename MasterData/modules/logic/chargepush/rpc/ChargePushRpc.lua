-- chunkname: @modules/logic/chargepush/rpc/ChargePushRpc.lua

module("modules.logic.chargepush.rpc.ChargePushRpc", package.seeall)

local ChargePushRpc = class("ChargePushRpc", BaseRpc)

function ChargePushRpc:sendGetChargePushInfoRequest(callback, callbackObj)
	local req = ChargePushModule_pb.GetChargePushInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function ChargePushRpc:onReceiveGetChargePushInfoReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ChargePushRpc:sendRecordchargePushRequest(id, callback, callbackObj)
	local req = ChargePushModule_pb.RecordChargePushRequest()

	req.id = id

	return self:sendMsg(req, callback, callbackObj)
end

function ChargePushRpc:onReceiveRecordChargePushReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ChargePushRpc:onReceiveGetChargePushPush(resultCode, msg)
	if resultCode == 0 then
		ChargePushModel.instance:onReceivePushInfo(msg)
	end
end

ChargePushRpc.instance = ChargePushRpc.New()

return ChargePushRpc
