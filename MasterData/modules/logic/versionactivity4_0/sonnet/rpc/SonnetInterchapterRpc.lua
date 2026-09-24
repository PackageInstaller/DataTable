-- chunkname: @modules/logic/versionactivity4_0/sonnet/rpc/SonnetInterchapterRpc.lua

module("modules.logic.versionactivity4_0.sonnet.rpc.SonnetInterchapterRpc", package.seeall)

local SonnetInterchapterRpc = class("SonnetInterchapterRpc", BaseRpc)

function SonnetInterchapterRpc:sendSonnetGetInfoRequest(callback, callbackObj)
	local req = SonnetModule_pb.SonnetGetInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function SonnetInterchapterRpc:onReceiveSonnetGetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local sonnet = msg.sonnet

	SonnetInterchapterModel.instance:initWords(sonnet.words)
end

function SonnetInterchapterRpc:sendSonnetUseWordRequest(id, callback, callbackObj)
	local req = SonnetModule_pb.SonnetUseWordRequest()

	req.id = id

	return self:sendMsg(req, callback, callbackObj)
end

function SonnetInterchapterRpc:onReceiveSonnetUseWordReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local id = msg.id

	SonnetInterchapterModel.instance:setWordStatus(id, SonnetInterchapterEnum.WordStatus.Used)
end

function SonnetInterchapterRpc:sendSonnetConsumeWordRequest(callback, callbackObj)
	local req = SonnetModule_pb.SonnetConsumeWordRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function SonnetInterchapterRpc:onReceiveSonnetConsumeWordReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local words = msg.words

	SonnetInterchapterModel.instance:consumeWords(words)
end

function SonnetInterchapterRpc:onReceiveSonnetWordPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SonnetInterchapterModel.instance:initWords(msg.words, true)
end

SonnetInterchapterRpc.instance = SonnetInterchapterRpc.New()

return SonnetInterchapterRpc
