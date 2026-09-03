-- chunkname: @/tmp/or_script/lua_compile/cocos/cocosdenshion/DeprecatedCocosDenshionClass.lua

if cc.SimpleAudioEngine == nil then
	return
end

DeprecatedCocosDenshionClass = {} or DeprecatedCocosDenshionClass

local function deprecatedTip(old_name, new_name)
	print("\n********** \n" .. old_name .. " was deprecated please use " .. new_name .. " instead.\n**********")
end

function DeprecatedCocosDenshionClass.SimpleAudioEngine()
	deprecatedTip("SimpleAudioEngine", "cc.SimpleAudioEngine")

	return cc.SimpleAudioEngine
end

_G.SimpleAudioEngine = DeprecatedCocosDenshionClass.SimpleAudioEngine()
