-- chunkname: @modules/logic/unlockvoucher/rpc/UnlockVoucherRpc.lua

module("modules.logic.unlockvoucher.rpc.UnlockVoucherRpc", package.seeall)

local UnlockVoucherRpc = class("UnlockVoucherRpc", BaseRpc)

function UnlockVoucherRpc:sendGetUnlockVoucherInfoRequest(callback, callbackObj)
	local req = UnlockVoucherModule_pb.GetUnlockVoucherInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function UnlockVoucherRpc:onReceiveGetUnlockVoucherInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local vouchers = msg.vouchers

	UnlockVoucherController.instance:onGetVoucherInfos(vouchers)
end

function UnlockVoucherRpc:onReceiveUnlockVoucherInfoUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local vouchers = msg.vouchers

	UnlockVoucherController.instance:onGetVoucherInfosPush(vouchers)
end

UnlockVoucherRpc.instance = UnlockVoucherRpc.New()

return UnlockVoucherRpc
