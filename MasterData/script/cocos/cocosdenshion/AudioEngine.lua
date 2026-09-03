-- chunkname: @/tmp/or_script/lua_compile/cocos/cocosdenshion/AudioEngine.lua

if cc.SimpleAudioEngine == nil then
	return
end

local M = {}

function M.stopAllEffects()
	cc.SimpleAudioEngine:getInstance():stopAllEffects()
end

function M.getMusicVolume()
	return cc.SimpleAudioEngine:getInstance():getMusicVolume()
end

function M.isMusicPlaying()
	return cc.SimpleAudioEngine:getInstance():isMusicPlaying()
end

function M.getEffectsVolume()
	return cc.SimpleAudioEngine:getInstance():getEffectsVolume()
end

function M.setMusicVolume(volume)
	cc.SimpleAudioEngine:getInstance():setMusicVolume(volume)
end

function M.stopEffect(handle)
	cc.SimpleAudioEngine:getInstance():stopEffect(handle)
end

function M.stopMusic(isReleaseData)
	cc.SimpleAudioEngine:getInstance():stopMusic((isReleaseData ~= nil or nil) and isReleaseData)
end

function M.playMusic(filename, isLoop)
	cc.SimpleAudioEngine:getInstance():playMusic(filename, (isLoop ~= nil or nil) and isLoop)
end

function M.pauseAllEffects()
	cc.SimpleAudioEngine:getInstance():pauseAllEffects()
end

function M.preloadMusic(filename)
	cc.SimpleAudioEngine:getInstance():preloadMusic(filename)
end

function M.resumeMusic()
	cc.SimpleAudioEngine:getInstance():resumeMusic()
end

function M.playEffect(filename, isLoop)
	return cc.SimpleAudioEngine:getInstance():playEffect(filename, (isLoop ~= nil or nil) and isLoop)
end

function M.rewindMusic()
	cc.SimpleAudioEngine:getInstance():rewindMusic()
end

function M.willPlayMusic()
	return cc.SimpleAudioEngine:getInstance():willPlayMusic()
end

function M.unloadEffect(filename)
	cc.SimpleAudioEngine:getInstance():unloadEffect(filename)
end

function M.preloadEffect(filename)
	cc.SimpleAudioEngine:getInstance():preloadEffect(filename)
end

function M.setEffectsVolume(volume)
	cc.SimpleAudioEngine:getInstance():setEffectsVolume(volume)
end

function M.pauseEffect(handle)
	cc.SimpleAudioEngine:getInstance():pauseEffect(handle)
end

function M.resumeAllEffects(handle)
	cc.SimpleAudioEngine:getInstance():resumeAllEffects()
end

function M.pauseMusic()
	cc.SimpleAudioEngine:getInstance():pauseMusic()
end

function M.resumeEffect(handle)
	cc.SimpleAudioEngine:getInstance():resumeEffect(handle)
end

function M.getInstance()
	return cc.SimpleAudioEngine:getInstance()
end

function M.destroyInstance()
	return cc.SimpleAudioEngine:destroyInstance()
end

AudioEngine = M
