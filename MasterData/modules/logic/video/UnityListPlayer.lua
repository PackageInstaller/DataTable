-- chunkname: @modules/logic/video/UnityListPlayer.lua

module("modules.logic.video.UnityListPlayer", package.seeall)

local UnityListPlayer = class("UnityListPlayer", PlayerListMedia)

function UnityListPlayer:ctor(param)
	PlayerListMedia.ctor(self, param)

	if param then
		self._videoList = param.videoList or {}
	end

	self._currentIndex = 1
	self._player = nil
	self._players = {}

	if param then
		self._poolSize = param.poolSize or 2
	end

	self._go = nil
	self._indexCallbacks = {}
	self._activeEntry = nil
end

function UnityListPlayer:init(go)
	local UnityVideoPlayer = require("modules.logic.video.UnityVideoPlayer")

	self._go = go

	gohelper.destroyAllChildren(go)

	self._rts = {}

	for i = 1, self._poolSize do
		local name = "VideoPlayer_" .. tostring(i)
		local child = UnityEngine.GameObject(name)

		child.transform:SetParent(go.transform, false)
		gohelper.setActive(child, false)

		local player = UnityVideoPlayer.New()

		player:init(child)

		local rt = UnityEngine.RenderTexture.GetTemporary(player._width or 2592, player._height or 1080, 0, UnityEngine.RenderTextureFormat.Default)

		player:setVideoPlayRenderTexture(rt)

		local entry = {
			preparing = false,
			player = player,
			go = child,
			rt = rt
		}

		table.insert(self._players, entry)
		table.insert(self._rts, rt)
	end
end

function UnityListPlayer:setVideoList(videoList)
	self._videoList = videoList or {}

	if #self._videoList > 0 then
		for i = 1, math.min(#self._videoList, #self._players) do
			local url = self._videoList[i]

			if url then
				local entry = self._players[i]

				entry.assignedIndex = i
				entry.preparing = true

				entry.player:loadMedia(url)
			end
		end
	end
end

function UnityListPlayer:SetMediaPaths(videoList)
	self:setVideoList(videoList)
end

function UnityListPlayer:SetMediaPath(url, index)
	if not url or not index then
		return
	end

	self._videoList[index] = url

	for _, entry in ipairs(self._players) do
		if entry.assignedIndex == index then
			entry.preparing = true

			entry.player:loadMedia(url)

			return
		end
	end
end

function UnityListPlayer:setCurrentIndex(idx)
	if idx and idx >= 1 and idx <= #self._videoList then
		self._currentIndex = idx
	end
end

function UnityListPlayer:_findEntryByIndex(idx)
	for _, entry in ipairs(self._players) do
		if entry.assignedIndex == idx then
			return entry
		end
	end

	return nil
end

function UnityListPlayer:_pickEntryForIndex(idx)
	local e = self:_findEntryByIndex(idx)

	if e then
		return e
	end

	for _, entry in ipairs(self._players) do
		if not entry.assignedIndex then
			return entry
		end
	end

	for _, entry in ipairs(self._players) do
		if entry ~= self._activeEntry then
			return entry
		end
	end

	return self._players[1]
end

function UnityListPlayer:play(idx, loop, callback, callbackObj)
	local curentry = self:_pickEntryForIndex(self._currentIndex)

	if curentry then
		self.lastEntry = curentry
	end

	if idx then
		self._currentIndex = idx
	end

	local url = self._videoList[self._currentIndex]

	if not url or #url == 0 then
		return
	end

	self._indexCallbacks[self._currentIndex] = callback and callbackObj and {
		callback = callback,
		callbackObj = callbackObj,
		loop = loop
	} or {
		loop = loop
	}

	local entry = self:_pickEntryForIndex(self._currentIndex)

	gohelper.setActive(entry.go, false)

	if not entry.rt then
		local p = entry.player
		local rt = UnityEngine.RenderTexture.GetTemporary(p._width or 2592, p._height or 1080, 0, UnityEngine.RenderTextureFormat.Default)

		entry.rt = rt

		p:setVideoPlayRenderTexture(rt)
	else
		entry.player:setVideoPlayRenderTexture(entry.rt)
	end

	entry.assignedIndex = self._currentIndex
	entry.preparing = true
	self._activeEntry = entry
	self._indexCallbacks[self._currentIndex].loop = loop or false

	entry.player:play(url, loop, self._onPlayerEvent, self)
end

function UnityListPlayer:pause()
	local entry = self:_pickEntryForIndex(self._currentIndex)

	if entry then
		entry.player:pause()
	end
end

function UnityListPlayer:stop()
	local entry = self:_pickEntryForIndex(self._currentIndex)

	if entry then
		entry.player:stop()
	end
end

function UnityListPlayer:next()
	if self._currentIndex < #self._videoList then
		self._currentIndex = self._currentIndex + 1

		self:play(self._currentIndex)
	end
end

function UnityListPlayer:previous()
	if self._currentIndex > 1 then
		self._currentIndex = self._currentIndex - 1

		self:play(self._currentIndex)
	end
end

function UnityListPlayer:getCurrentIndex()
	return self._currentIndex
end

function UnityListPlayer:_onPlayerEvent(path, eventType, msg)
	local idx = self._currentIndex

	if eventType == VideoEnum.PlayerStatus.Error then
		logError("video play failed : " .. tostring(msg))
	end

	if eventType == VideoEnum.PlayerStatus.Started then
		gohelper.setAsLastSibling(self._activeEntry.go)
	end

	local cbdata = idx and self._indexCallbacks[idx]

	if cbdata and cbdata.callback and cbdata.callbackObj then
		cbdata.callback(cbdata.callbackObj, path, eventType, msg)
	end
end

function UnityListPlayer:ondestroy()
	for _, entry in ipairs(self._players) do
		if entry.player then
			if entry.rt and entry.player._rt then
				entry.player._rt = nil
			end

			entry.player:ondestroy()

			entry.player = nil
		end

		if entry.go then
			gohelper.destroy(entry.go)

			entry.go = nil
		end

		if entry.rt then
			pcall(function()
				UnityEngine.RenderTexture.ReleaseTemporary(entry.rt)
			end)

			entry.rt = nil
		end
	end

	if self._rts then
		for _, rt in ipairs(self._rts) do
			if rt then
				pcall(function()
					UnityEngine.RenderTexture.ReleaseTemporary(rt)
				end)
			end
		end

		self._rts = nil
	end

	self._players = {}
	self._activeEntry = nil
	self._indexCallbacks = {}
end

return UnityListPlayer
