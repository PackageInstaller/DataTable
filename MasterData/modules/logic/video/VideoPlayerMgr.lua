-- chunkname: @modules/logic/video/VideoPlayerMgr.lua

module("modules.logic.video.VideoPlayerMgr", package.seeall)

local VideoPlayerMgr = class("VideoPlayerMgr")

VideoPlayerMgr.UrlVideo = "ui/viewres/video/videoplayer.prefab"
VideoPlayerMgr.Type_AvProUGUIPlayer = typeof(ZProj.AvProUGUIPlayer)
VideoPlayerMgr.Type_DisplayUGUI = typeof(RenderHeads.Media.AVProVideo.DisplayUGUI)
VideoPlayerMgr.DEFAULT_WIDTH = 2592
VideoPlayerMgr.DEFAULT_HEIGHT = 1080

function VideoPlayerMgr:init()
	self._resDict = {}
end

function VideoPlayerMgr:createVideoPlayer(go, loop, width, height, needRawImage, needVideoAdapter)
	local param = {
		width = width,
		height = height,
		loop = loop,
		needRawImage = needRawImage,
		needVideoAdapter = needVideoAdapter
	}

	if SettingsModel.instance:isAvproVideo() then
		return MonoHelper.addNoUpdateLuaComOnceToGo(go, AvProPlayer, param)
	else
		return MonoHelper.addNoUpdateLuaComOnceToGo(go, UnityVideoPlayer, param)
	end
end

function VideoPlayerMgr:createGoAndVideoPlayer(parent, name, loop, width, height, prefabUrl)
	local go = self:createGo(prefabUrl, parent, name)
	local videoPlayer = self:createVideoPlayer(go, loop, width, height, true)

	return videoPlayer, go
end

function VideoPlayerMgr:createGo(prefabUrl, parent, name)
	if not prefabUrl then
		if SettingsModel.instance:isAvproVideo() then
			return self:_createGoByPrefab(self:swicthVideoUrl(AvProMgrConfig.UrlVideo, AvProMgrConfig.UrlVideoCompatible), parent, name)
		else
			return gohelper.create2d(parent, name)
		end
	else
		return self:_createGoByPrefab(prefabUrl, parent, name)
	end
end

function VideoPlayerMgr:_createGoByPrefab(prefabUrl, parent, name)
	local prefabAssetItem = self._resDict[prefabUrl]

	if prefabAssetItem then
		local prefab = prefabAssetItem:GetResource(prefabUrl)

		if prefab then
			return gohelper.clone(prefab, parent, name)
		else
			logError(prefabUrl .. " prefab not in ab")
		end
	end

	logError(prefabUrl .. " videoPrefab need preload")
end

function VideoPlayerMgr:preload(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
	self._resDict = {}
	self._loader = MultiAbLoader.New()

	self._loader:setPathList(AvProMgrConfig.getPreloadList())
	self._loader:setOneFinishCallback(self._onOnePreloadCallback, self)
	self._loader:startLoad(self._onPreloadCallback, self)
end

function VideoPlayerMgr:_onOnePreloadCallback(loader, assetItem)
	self._resDict[assetItem.ResPath] = assetItem
end

function VideoPlayerMgr:_onPreloadCallback()
	if self._callback then
		self._callback(self._callbackObj)
	end

	self._callback = nil
	self._callbackObj = nil
end

function VideoPlayerMgr:getStateCode(status)
	if status == AvProEnum.PlayerStatus.MetaDataReady then
		status = VideoEnum.PlayerStatus.MetaDataReady
	elseif status == AvProEnum.PlayerStatus.FinishedPlaying then
		status = VideoEnum.PlayerStatus.FinishedPlaying
	elseif status == AvProEnum.PlayerStatus.Error then
		status = VideoEnum.PlayerStatus.Error
	elseif status == AvProEnum.PlayerStatus.ReadyToPlay then
		status = VideoEnum.PlayerStatus.ReadyToPlay
	elseif status == AvProEnum.PlayerStatus.Closing then
		status = VideoEnum.PlayerStatus.Closing
	elseif status == AvProEnum.PlayerStatus.Started then
		status = VideoEnum.PlayerStatus.Started
	elseif status == AvProEnum.PlayerStatus.FirstFrameReady then
		status = VideoEnum.PlayerStatus.FirstFrameReady
	else
		logWarn("VideoPlayerMgr:_callback status not found : " .. status)
	end

	return status
end

function VideoPlayerMgr:swicthVideoUrl(url, urlCompatible)
	if SettingsModel.instance:getVideoCompatible() then
		return urlCompatible
	end

	return url
end

function VideoPlayerMgr:createPlayerListMedia(go, videoList)
	local param = {
		videoList = videoList
	}
	local player = SettingsModel.instance:isAvproVideo() and AvProListPlayer.New(param) or UnityListPlayer.New(param)

	player:init(go)

	return player
end

function VideoPlayerMgr:SwitchUrl(url)
	if SLFramework.FrameworkSettings.IsEditor then
		if GameResMgr.IsFromEditorDir then
			return UnityEngine.Application.dataPath .. "/../../" .. ZProj.VideoHelp.GetVideoHDPath(langVideoUrl(url))
		else
			return UnityEngine.Application.dataPath .. "/../ResLib/" .. SLFramework.FrameworkSettings.CurPlatformName .. "/" .. ZProj.VideoHelp.GetVideoHDPath(langVideoUrl(url))
		end
	else
		return SLFramework.FrameworkSettings.GetAssetFullPathForWWW(ZProj.VideoHelp.GetVideoHDPath(langVideoUrl(url)))
	end
end

VideoPlayerMgr.instance = VideoPlayerMgr.New()

return VideoPlayerMgr
