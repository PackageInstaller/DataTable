-- chunkname: @/tmp/or_script/lua_compile/cocos/network/DeprecatedNetworkFunc.lua

if cc.XMLHttpRequest == nil then
	return
end

local function deprecatedTip(old_name, new_name)
	print("\n********** \n" .. old_name .. " was deprecated please use " .. new_name .. " instead.\n**********")
end

local targetPlatform = CCApplication:getInstance():getTargetPlatform()

if kTargetIphone == targetPlatform or kTargetIpad == targetPlatform or kTargetAndroid == targetPlatform or kTargetWindows == targetPlatform then
	local WebSocketDeprecated = {}

	function WebSocketDeprecated:sendTextMsg(string)
		deprecatedTip("WebSocket:sendTextMsg", "WebSocket:sendString")

		return self:sendString(string)
	end

	WebSocket.sendTextMsg = WebSocketDeprecated.sendTextMsg

	function WebSocketDeprecated:sendBinaryMsg(table, tablesize)
		deprecatedTip("WebSocket:sendBinaryMsg", "WebSocket:sendString")
		string.char(unpack(table))

		return self:sendString(string.char(unpack(table)))
	end

	WebSocket.sendBinaryMsg = WebSocketDeprecated.sendBinaryMsg
end
