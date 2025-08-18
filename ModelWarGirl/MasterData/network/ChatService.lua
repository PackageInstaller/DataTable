-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Network\\ChatService.lua

require("Network/protobuf")

local UrlConfig = require("Network/UrlConfig")
local WebSocket = require("Network/WebSocket")
local protobuf = protobuf
local Time = Time
local ChatService = {}
local self = ChatService

function ChatService.connect(token, successCB)
	self._token = token

	if self._ws == nil then
		self._ws = WebSocket()

		self._ws:setRecvCallback(self._recvMsg)
	end

	self._ws:setConnectSuccessCB(successCB)

	local url = self._getUrl(self._token)

	if url then
		self._ws:connect(url)
	end

	self.CHATRPC = CHATRPC
end

function ChatService.destroy()
	self._token = nil

	if self._ws then
		self._ws:destroy()

		self._ws = nil
	end
end

function ChatService.disconnect()
	self._token = nil

	if self._ws then
		self._ws:cancel()
	end
end

function ChatService.isConnected()
	return self._ws ~= nil and self._ws:isConnected()
end

function ChatService.resetConnectTime(...)
	if VersionUtils.getEngineVersion() < 84962 then
		return
	end

	if self._ws then
		self._ws:resetConnectTime()
	end
end

function ChatService.send(bytes)
	if self._ws then
		self._ws:send(bytes)
	end
end

function ChatService._getUrl(token)
	local url = SvrListManager.getChatSvr()

	if url ~= nil then
		local data = {
			token = token
		}

		url = ClientUtils.composeGetUrl(url, data)
	end

	return url
end

function ChatService._recvMsg(bytes)
	local msgTable = protobuf.decode("cscp.ServerPkg", bytes, string.len(bytes))

	if msgTable then
		ChatService._decodeAllSubTable(msgTable)
		ClientUtils.trycall(self.CHATRPC.dispatch, msgTable)
	end
end

function ChatService._decodeAllSubTable(msgTable)
	for k, v in pairs(msgTable) do
		if type(v) == "table" then
			if type(v[1]) == "string" and string.find(v[1], "cscp.") then
				local ret = protobuf.decode(v[1], v[2])

				if ret then
					msgTable[k] = ret
				end
			end

			ChatService._decodeAllSubTable(msgTable[k])
		end
	end
end

return ChatService
