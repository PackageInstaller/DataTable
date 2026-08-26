-- chunkname: @modules/logic/video/AvProListPlayer.lua

module("modules.logic.video.AvProListPlayer", package.seeall)

local AvProListPlayer = class("AvProListPlayer", PlayerListMedia)

function AvProListPlayer:ctor(param)
	PlayerListMedia.ctor(self, param)

	if param then
		self._videoList = param.videoList or {}
	end

	self._currentIndex = 1
	self._player = nil
	self._go = nil
end

function AvProListPlayer:init(go)
	self._go = go
	self._player = go:GetComponentInChildren(typeof(ZProj.AvProUGUIListPlayer)) or gohelper.onceAddComponent(go, typeof(ZProj.AvProUGUIListPlayer))

	if self._videoList then
		self:SetMediaPaths(self._videoList)
	end

	self:setCurrentIndex(self._currentIndex)

	self._player.PlaylistMediaPlayer.AutoProgress = false
end

function AvProListPlayer:setVideoList(videoList)
	self._videoList = videoList or {}

	self:SetMediaPaths(self._videoList)
end

function AvProListPlayer:SetMediaPaths(videoList)
	self._videoList = videoList or {}

	for i = 1, #self._videoList do
		local url = VideoPlayerMgr.instance:SwitchUrl(self._videoList[i])

		self._player:SetMediaPath(url, i - 1)
	end
end

function AvProListPlayer:SetMediaPath(url, index)
	if not url or not index or index < 0 then
		return
	end

	self._videoList[index] = url
	url = VideoPlayerMgr.instance:SwitchUrl(url)

	self._player:SetMediaPath(url, index - 1)
end

function AvProListPlayer:setCurrentIndex(idx)
	if idx and idx >= 1 and idx <= #self._videoList then
		self._currentIndex = idx
	end

	self._player.PlaylistMediaPlayer:JumpToItem(self._currentIndex - 1)
end

function AvProListPlayer:play(idx, loop, callback, callbackObj)
	if idx then
		self._currentIndex = idx
	end

	local url = self._videoList[self._currentIndex]

	self._player.PlaylistMediaPlayer:JumpToItem(self._currentIndex - 1)

	if url and self._player then
		if callback and callbackObj then
			self._player:SetEventListener(callback, callbackObj)
		end

		local playlistMediaPlayer = self._player.PlaylistMediaPlayer

		playlistMediaPlayer.Loop = loop or false

		playlistMediaPlayer:Play()
	end
end

function AvProListPlayer:pause()
	if self._player then
		local playlistMediaPlayer = self._player.PlaylistMediaPlayer

		if playlistMediaPlayer then
			playlistMediaPlayer:Pause()
		end
	end
end

function AvProListPlayer:stop()
	if self._player then
		local playlistMediaPlayer = self._player.PlaylistMediaPlayer

		if playlistMediaPlayer then
			playlistMediaPlayer:Stop()
		end
	end
end

function AvProListPlayer:next()
	if self._currentIndex < #self._videoList then
		self._currentIndex = self._currentIndex + 1

		self:play(self._currentIndex)
	end
end

function AvProListPlayer:previous()
	if self._currentIndex > 1 then
		self._currentIndex = self._currentIndex - 1

		self:play(self._currentIndex)
	end
end

function AvProListPlayer:getCurrentIndex()
	return self._currentIndex
end

function AvProListPlayer:ondestroy()
	if self._player then
		self._player:Clear()

		self._player = nil
	end

	self._go = nil
end

return AvProListPlayer
