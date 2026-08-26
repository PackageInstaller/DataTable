-- chunkname: @modules/common/global/screen/GameMsgTooOftenCheck.lua

module("modules.common.global.screen.GameMsgTooOftenCheck", package.seeall)

local GameMsgTooOftenCheck = class("GameMsgTooOftenCheck", BasePreSender)
local StatDuration = 1
local TooOftenThreshold = 90
local TooOftenSameThreshold = 3
local IgnoreCmds = {}

function GameMsgTooOftenCheck:ctor()
	self._sendProtoTime = {}
	self._sendProtoList = {}
	self._toSendProtoTime = {}
	self._toSendProtoList = {}

	self:addConstEvents()
end

function GameMsgTooOftenCheck:addConstEvents()
	if isDebugBuild then
		LuaSocketMgr.instance:registerPreSender(self)
	end
end

function GameMsgTooOftenCheck:blockSendProto(cmd, proto, socketId)
	if not proto then
		return
	end

	if IgnoreCmds[cmd] then
		return
	end

	self:_removeOutdatedProto(self._sendProtoTime, self._sendProtoList)
	self:_removeOutdatedProto(self._toSendProtoTime, self._toSendProtoList)

	local now = Time.realtimeSinceStartup

	table.insert(self._toSendProtoTime, now)
	table.insert(self._toSendProtoList, proto)

	local sameProtoCount = 0
	local protoStr

	for _, protoToSend in ipairs(self._toSendProtoList) do
		if proto.__cname == protoToSend.__cname then
			protoStr = protoStr or tostring(proto)

			if protoStr == tostring(protoToSend) then
				sameProtoCount = sameProtoCount + 1

				if sameProtoCount > TooOftenSameThreshold then
					local msg = proto.__cname .. "{\n" .. protoStr .. "}"

					logError(string.format("发完全相同的包过于频繁，%d秒%d个\n%s", StatDuration, sameProtoCount, msg))

					break
				end
			end
		end
	end

	if #self._sendProtoList > TooOftenThreshold then
		local msg = proto.__cname .. "{\n" .. protoStr .. "}"

		logError(string.format("发包过于频繁，%d秒%d个，请求已被拦截\n%s", StatDuration, #self._toSendProtoList, msg))

		return true
	end

	table.insert(self._sendProtoTime, now)
	table.insert(self._sendProtoList, proto)
end

function GameMsgTooOftenCheck:_removeOutdatedProto(timeList, protoList)
	local protoCount = #timeList
	local now = Time.realtimeSinceStartup

	for i = 1, protoCount do
		local sendTime = timeList[1]

		if now - sendTime >= StatDuration then
			table.remove(timeList, 1)
			table.remove(protoList, 1)
		else
			break
		end
	end
end

return GameMsgTooOftenCheck
