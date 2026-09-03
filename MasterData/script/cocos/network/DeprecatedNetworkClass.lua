-- chunkname: @/tmp/or_script/lua_compile/cocos/network/DeprecatedNetworkClass.lua

if cc.XMLHttpRequest == nil then
	return
end

DeprecatedNetworkClass = {} or DeprecatedNetworkClass

local function deprecatedTip(old_name, new_name)
	print("\n********** \n" .. old_name .. " was deprecated please use " .. new_name .. " instead.\n**********")
end

function DeprecatedNetworkClass.WebSocket()
	deprecatedTip("WebSocket", "cc.WebSocket")

	return cc.WebSocket
end

_G.WebSocket = DeprecatedNetworkClass.WebSocket()
