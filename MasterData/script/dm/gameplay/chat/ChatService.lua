-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/ChatService.lua

ChatService = class("ChatService", Service, _M)

local opType = {
	getHistory = 30001,
	sendMsg = 30002,
	pushMsg = 1004,
	removeMessage = 30008,
	blockUser = 30006,
	readMsg = 30003,
	changeBubble = 30009,
	getBlockList = 30007
}

function ChatService:initialize()
	super.initialize(self)
end

function ChatService:dispose()
	super.dispose(self)
end

function ChatService:requestHistory(params, callback, notShowWaiting)
	local request = self:newRequest(opType.getHistory, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function ChatService:requestSendMessage(params, callback, notShowWaiting)
	local request = self:newRequest(opType.sendMsg, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function ChatService:requestReadMessage(params, callback, notShowWaiting)
	local request = self:newRequest(opType.readMsg, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function ChatService:listenPushMessage(callback)
	self:addPushHandler(opType.pushMsg, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function ChatService:requestBlockUser(params, callback, notShowWaiting)
	local request = self:newRequest(opType.blockUser, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function ChatService:requestGetBlockList(params, callback, notShowWaiting)
	local request = self:newRequest(opType.getBlockList, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function ChatService:requestRemoveMessage(params, callback, notShowWaiting)
	local request = self:newRequest(opType.removeMessage, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function ChatService:requestChangeBubble(params, callback, notShowWaiting)
	local request = self:newRequest(opType.changeBubble, params, callback)

	self:sendRequest(request, not notShowWaiting)
end
