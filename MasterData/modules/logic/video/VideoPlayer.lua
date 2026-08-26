-- chunkname: @modules/logic/video/VideoPlayer.lua

module("modules.logic.video.VideoPlayer", package.seeall)

local VideoPlayer = class("VideoPlayer", LuaCompBase)

function VideoPlayer:ctor(param)
	if param then
		self._width = param.width or 2592
		self._height = param.height or 1080
		self._loop = param.loop or false
	else
		self._width = 2592
		self._height = 1080
		self._loop = false
	end
end

function VideoPlayer:init(go)
	return
end

function VideoPlayer:play(url, loop, callback, callbackObj)
	return
end

function VideoPlayer:SetRaycast(v)
	return
end

function VideoPlayer:pause()
	return
end

function VideoPlayer:isPaused()
	return
end

function VideoPlayer:stop()
	return
end

function VideoPlayer:rewind(isPause)
	return
end

function VideoPlayer:isPlaying()
	return
end

function VideoPlayer:canPlay()
	return
end

function VideoPlayer:setSize(width, height)
	self._width = width
	self._height = height
end

function VideoPlayer:ondestroy()
	return
end

function VideoPlayer:clear()
	return
end

function VideoPlayer:loadMedia(url)
	return
end

function VideoPlayer:setScaleMode(scaleMode)
	return
end

function VideoPlayer:setPlaybackSpeed(speed)
	return
end

function VideoPlayer:setSkipOnDrop(skipOnDrop)
	return
end

function VideoPlayer:resetEyeModeMat()
	return
end

return VideoPlayer
