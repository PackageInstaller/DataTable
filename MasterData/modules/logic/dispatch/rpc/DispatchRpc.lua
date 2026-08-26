-- chunkname: @modules/logic/dispatch/rpc/DispatchRpc.lua

module("modules.logic.dispatch.rpc.DispatchRpc", package.seeall)

local DispatchRpc = class("DispatchRpc", BaseRpc)

function DispatchRpc:sendGetDispatchInfoRequest(cb, cbObj)
	local req = DispatchModule_pb.GetDispatchInfoRequest()

	return self:sendMsg(req, cb, cbObj)
end

function DispatchRpc:onReceiveGetDispatchInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	DispatchModel.instance:initDispatchInfos(msg.dispatchInfos)
end

function DispatchRpc:sendDispatchRequest(elementId, dispatchId, heroIds, cb, cbObj)
	local req = DispatchModule_pb.DispatchRequest()

	req.elementId = elementId
	req.dispatchId = dispatchId

	if heroIds then
		for _, heroId in ipairs(heroIds) do
			req.heroIds:append(heroId)
		end
	end

	return self:sendMsg(req, cb, cbObj)
end

function DispatchRpc:onReceiveDispatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local serverTimeStamp = tonumber(msg.startTime)
	local serverTimeStampSecond = math.floor(serverTimeStamp / 1000)

	ServerTime.update(serverTimeStampSecond)
	DispatchModel.instance:addDispatch(msg)
end

function DispatchRpc:sendInterruptDispatchRequest(elementId, dispatchId, cb, cbObj)
	local req = DispatchModule_pb.InterruptDispatchRequest()

	req.elementId = elementId
	req.dispatchId = dispatchId

	return self:sendMsg(req, cb, cbObj)
end

function DispatchRpc:onReceiveInterruptDispatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	DispatchModel.instance:removeDispatch(msg)
end

DispatchRpc.instance = DispatchRpc.New()

return DispatchRpc
