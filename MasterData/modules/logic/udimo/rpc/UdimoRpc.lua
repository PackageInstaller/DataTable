-- chunkname: @modules/logic/udimo/rpc/UdimoRpc.lua

module("modules.logic.udimo.rpc.UdimoRpc", package.seeall)

local UdimoRpc = class("UdimoRpc", BaseRpc)

function UdimoRpc:sendGetUdimoInfoRequest(lat, lon, callback, callbackObj)
	local req = UdimoModule_pb.GetUdimoInfoRequest()

	req.lat = lat and string.format("%.2f", lat) or ""
	req.lon = lon and string.format("%.2f", lon) or ""

	self:sendMsg(req, callback, callbackObj)
end

function UdimoRpc:onReceiveGetUdimoInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	UdimoController.instance:onGetUdimoInfo(msg)
end

function UdimoRpc:sendUseUdimoRequest(useUdimoIds, callback, callbackObj)
	local req = UdimoModule_pb.UseUdimoRequest()

	for _, udimoId in ipairs(useUdimoIds) do
		table.insert(req.useUdimoIds, udimoId)
	end

	self:sendMsg(req, callback, callbackObj)
end

function UdimoRpc:onReceiveUseUdimoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	UdimoController.instance:onUseUdimo(msg)
end

function UdimoRpc:sendUseBackgroundRequest(useBackgroundId, callback, callbackObj)
	local req = UdimoModule_pb.UseBackgroundRequest()

	req.useBackgroundId = useBackgroundId

	self:sendMsg(req, callback, callbackObj)
end

function UdimoRpc:onReceiveUseBackgroundReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	UdimoController.instance:onUseBg(msg)
end

function UdimoRpc:sendUseDecorationRequest(useDecorationId, removeDecorationId, callback, callbackObj)
	local req = UdimoModule_pb.UseDecorationRequest()

	req.useDecorationId = useDecorationId or 0
	req.removeDecorationId = removeDecorationId or 0

	self:sendMsg(req, callback, callbackObj)
end

function UdimoRpc:onReceiveUseDecorationReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	UdimoController.instance:onUseDecoration(msg)
end

function UdimoRpc:onReceiveWeathInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	UdimoController.instance:onGetWeatherInfo(msg)
end

UdimoRpc.instance = UdimoRpc.New()

return UdimoRpc
