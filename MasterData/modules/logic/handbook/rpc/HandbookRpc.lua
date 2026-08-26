-- chunkname: @modules/logic/handbook/rpc/HandbookRpc.lua

module("modules.logic.handbook.rpc.HandbookRpc", package.seeall)

local HandbookRpc = class("HandbookRpc", BaseRpc)

function HandbookRpc:sendGetHandbookInfoRequest(callback, callbackObj)
	local req = HandbookModule_pb.GetHandbookInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HandbookRpc:onReceiveGetHandbookInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HandbookModel.instance:setReadInfos(msg.infos)
	HandbookModel.instance:setFragmentInfo(msg.elementInfo)
end

function HandbookRpc:sendHandbookReadRequest(type, id)
	local req = HandbookModule_pb.HandbookReadRequest()

	req.type = type
	req.id = id

	return self:sendMsg(req)
end

function HandbookRpc:onReceiveHandbookReadReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = {
		isRead = true,
		type = msg.type,
		id = msg.id
	}

	HandbookModel.instance:setReadInfo(info)
	HandbookController.instance:dispatchEvent(HandbookEvent.OnReadInfoChanged, info)
end

HandbookRpc.instance = HandbookRpc.New()

return HandbookRpc
