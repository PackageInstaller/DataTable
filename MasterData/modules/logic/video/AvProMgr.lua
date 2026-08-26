-- chunkname: @modules/logic/video/AvProMgr.lua

module("modules.logic.video.AvProMgr", package.seeall)

local AvProMgr = class("AvProMgr")

AvProMgr.Type_AvProUGUIPlayer = typeof(ZProj.AvProUGUIPlayer)
AvProMgr.Type_DisplayUGUI = typeof(RenderHeads.Media.AVProVideo.DisplayUGUI)

function AvProMgr:preload(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
	self._resDict = {}
	self._loader = MultiAbLoader.New()

	self._loader:setPathList(AvProMgrConfig.getPreloadList())
	self._loader:setOneFinishCallback(self._onOnePreloadCallback, self)
	self._loader:startLoad(self._onPreloadCallback, self)
end

function AvProMgr:_onOnePreloadCallback(loader, assetItem)
	self._resDict[assetItem.ResPath] = assetItem
end

function AvProMgr:_onPreloadCallback()
	if self._callback then
		self._callback(self._callbackObj)
	end

	self._callback = nil
	self._callbackObj = nil
end

function AvProMgr:_getGOInstance(prefabUrl, parentGO, name)
	local prefabAssetItem = self._resDict[prefabUrl]

	if prefabAssetItem then
		local prefab = prefabAssetItem:GetResource(prefabUrl)

		if prefab then
			return gohelper.clone(prefab, parentGO, name)
		else
			logError(prefabUrl .. " prefab not in ab")
		end
	end

	logError(prefabUrl .. " videoPrefab need preload")
end

function AvProMgr:swicthVideoUrl(url, urlCompatible)
	if SettingsModel.instance:getVideoCompatible() then
		return urlCompatible
	end

	return url
end

function AvProMgr:getVideoPlayer(parentGO, name)
	local prefabUrl = self:swicthVideoUrl(AvProMgrConfig.UrlVideo, AvProMgrConfig.UrlVideoCompatible)
	local videoGO = self:_getGOInstance(prefabUrl, parentGO, name)
	local videoPlayer = videoGO:GetComponent(AvProMgr.Type_AvProUGUIPlayer)
	local displayUGUI = videoGO:GetComponent(AvProMgr.Type_DisplayUGUI)

	displayUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop

	return videoPlayer, displayUGUI, videoGO
end

function AvProMgr:getFightUrl()
	return self:swicthVideoUrl(AvProMgrConfig.UrlFightVideo, AvProMgrConfig.UrlFightVideoCompatible)
end

function AvProMgr:getStoryUrl()
	return self:swicthVideoUrl(AvProMgrConfig.UrlStoryVideo, AvProMgrConfig.UrlStoryVideoCompatible)
end

function AvProMgr:getNicknameUrl()
	return self:swicthVideoUrl(AvProMgrConfig.UrlNicknameVideo, AvProMgrConfig.UrlNicknameVideoCompatible)
end

function AvProMgr:getRolesprefabUrl(url)
	if SettingsModel.instance:getVideoCompatible() then
		return AvProMgrConfig.URLRolesprefabDict[url] or url
	end

	return url
end

AvProMgr.instance = AvProMgr.New()

return AvProMgr
