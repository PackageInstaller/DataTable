-- chunkname: @modules/logic/common/rpc/CommonRpc.lua

module("modules.logic.common.rpc.CommonRpc", package.seeall)

local CommonRpc = class("CommonRpc", BaseRpc)

function CommonRpc:sendGetServerTimeRequest(callback, callbackObj)
	local req = CommonModule_pb.GetServerTimeRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function CommonRpc:onReceiveGetServerTimeReply(resultCode, msg)
	local offsetTime = tonumber(msg.offsetTime)
	local offsetTimeSecond = math.floor(offsetTime / 1000)

	ServerTime.init(offsetTimeSecond)

	local serverTimeStamp = tonumber(msg.serverTime)
	local serverTimeStampSecond = math.floor(serverTimeStamp / 1000)

	ServerTime.update(serverTimeStampSecond)
end

CommonRpc.instance = CommonRpc.New()

return CommonRpc
