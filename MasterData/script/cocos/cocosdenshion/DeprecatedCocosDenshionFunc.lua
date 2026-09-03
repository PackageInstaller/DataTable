-- chunkname: @/tmp/or_script/lua_compile/cocos/cocosdenshion/DeprecatedCocosDenshionFunc.lua

if cc.SimpleAudioEngine == nil then
	return
end

local function deprecatedTip(old_name, new_name)
	print("\n********** \n" .. old_name .. " was deprecated please use " .. new_name .. " instead.\n**********")
end

local SimpleAudioEngineDeprecated = {}

function SimpleAudioEngineDeprecated.sharedEngine()
	deprecatedTip("SimpleAudioEngine:sharedEngine", "SimpleAudioEngine:getInstance")

	return cc.SimpleAudioEngine:getInstance()
end

SimpleAudioEngine.sharedEngine = SimpleAudioEngineDeprecated.sharedEngine

function SimpleAudioEngineDeprecated:playBackgroundMusic(...)
	deprecatedTip("SimpleAudioEngine:playBackgroundMusic", "SimpleAudioEngine:playMusic")

	return self:playMusic(...)
end

SimpleAudioEngine.playBackgroundMusic = SimpleAudioEngineDeprecated.playBackgroundMusic
