-- chunkname: @modules/logic/versionactivity2_7/dungeon/controller/VersionActivity2_7DungeonController.lua

module("modules.logic.versionactivity2_7.dungeon.controller.VersionActivity2_7DungeonController", package.seeall)

local VersionActivity2_7DungeonController = class("VersionActivity2_7DungeonController", VersionActivityFixedDungeonController)

function VersionActivity2_7DungeonController:onInit()
	self._isShowLoading = false
	self._sceneGo = nil
end

function VersionActivity2_7DungeonController:reInit()
	self._isShowLoading = false
	self._sceneGo = nil
end

function VersionActivity2_7DungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
	VersionActivity2_7DungeonController.super.openVersionActivityDungeonMapView(self, chapterId, episodeId, callback, callbackObj)

	if self:_isSpaceScene(episodeId) and not self._sceneGo then
		self:showLoading()
	end
end

function VersionActivity2_7DungeonController:_isSpaceScene(episodeId)
	local cutSceneEpisodeIndex = VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs

	episodeId = episodeId or VersionActivityFixedDungeonModel.instance:getInitEpisodeId()

	local index = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(episodeId)

	for _, _index in ipairs(cutSceneEpisodeIndex) do
		if index == _index then
			return true
		end
	end
end

function VersionActivity2_7DungeonController:loadingFinish(episodeId, sceneGo)
	if self:_isSpaceScene(episodeId) or self._isShowLoading then
		self:hideLoading()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_loading_scene)

	self._sceneGo = sceneGo
end

function VersionActivity2_7DungeonController:showLoading()
	ViewMgr.instance:openView(ViewName.V2a7LoadingSpaceView, nil, true)

	self._isShowLoading = true
end

function VersionActivity2_7DungeonController:hideLoading()
	if ViewMgr.instance:isOpen(ViewName.V2a7LoadingSpaceView) then
		ViewMgr.instance:closeView(ViewName.V2a7LoadingSpaceView)
	end

	self._isShowLoading = false
end

function VersionActivity2_7DungeonController:resetLoading()
	self._isShowLoading = false
	self._sceneGo = nil
end

VersionActivity2_7DungeonController.instance = VersionActivity2_7DungeonController.New()

return VersionActivity2_7DungeonController
