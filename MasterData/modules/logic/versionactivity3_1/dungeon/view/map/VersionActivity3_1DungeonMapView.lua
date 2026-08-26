-- chunkname: @modules/logic/versionactivity3_1/dungeon/view/map/VersionActivity3_1DungeonMapView.lua

module("modules.logic.versionactivity3_1.dungeon.view.map.VersionActivity3_1DungeonMapView", package.seeall)

local VersionActivity3_1DungeonMapView = class("VersionActivity3_1DungeonMapView", VersionActivityFixedDungeonMapView)

function VersionActivity3_1DungeonMapView:_editableInitView()
	VersionActivity3_1DungeonMapView.super._editableInitView(self)

	self._goswitch = gohelper.findChild(self.viewGO, "#go_switch")
end

function VersionActivity3_1DungeonMapView:addEvents()
	VersionActivity3_1DungeonMapView.super.addEvents(self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivity3_1DungeonEvent.V3a1SceneAnimFinish, self._V3a1SceneAnimFinish, self)
end

function VersionActivity3_1DungeonMapView:removeEvents()
	VersionActivity3_1DungeonMapView.super.removeEvents(self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, self.onActivityDungeonMoChange, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivity3_1DungeonEvent.V3a1SceneAnimFinish, self._V3a1SceneAnimFinish, self)
end

function VersionActivity3_1DungeonMapView:onOpen()
	VersionActivity3_1DungeonMapView.super.onOpen(self)

	self._lastEpisodeId = self.activityDungeonMo.episodeId
end

function VersionActivity3_1DungeonMapView:onModeChange()
	self._lastEpisodeId = self.activityDungeonMo.episodeId

	VersionActivity3_1DungeonMapView.super.onModeChange(self)
end

function VersionActivity3_1DungeonMapView:onActivityDungeonMoChange()
	self._sceneAnimName = nil

	if self._lastEpisodeId and self.activityDungeonMo.episodeId ~= self._lastEpisodeId then
		local episodeId = self.activityDungeonMo.episodeId

		if episodeId > self._lastEpisodeId then
			self._sceneAnimName = VersionActivity3_1DungeonEnum.LevelAnim.left_close
		elseif episodeId < self._lastEpisodeId then
			self._sceneAnimName = VersionActivity3_1DungeonEnum.LevelAnim.right_close
		end
	end

	if not string.nilorempty(self._sceneAnimName) then
		self:_playSceneAnim(self._sceneAnimName)
	end

	self._lastEpisodeId = self.activityDungeonMo.episodeId
end

function VersionActivity3_1DungeonMapView:_V3a1SceneAnimFinish()
	local sceneName

	if not string.nilorempty(self._sceneAnimName) then
		if self._sceneAnimName == VersionActivity3_1DungeonEnum.LevelAnim.right_close then
			sceneName = VersionActivity3_1DungeonEnum.LevelAnim.right_open
		elseif self._sceneAnimName == VersionActivity3_1DungeonEnum.LevelAnim.left_close then
			sceneName = VersionActivity3_1DungeonEnum.LevelAnim.left_open
		end
	end

	if not string.nilorempty(sceneName) then
		self:_playSceneAnim(sceneName, self._hideSceneAnim)
	end

	self._sceneAnimName = nil
end

function VersionActivity3_1DungeonMapView:_playLoopAnim()
	self:_playSceneAnim(VersionActivity3_1DungeonEnum.LevelAnim.loop)
end

function VersionActivity3_1DungeonMapView:_hideSceneAnim()
	gohelper.setActive(self._goswitch, false)
end

function VersionActivity3_1DungeonMapView:_playSceneAnim(animName, callback)
	if string.nilorempty(animName) or not self._goswitch then
		return
	end

	self._sceneAnim = SLFramework.AnimatorPlayer.Get(self._goswitch.gameObject)

	if not self._sceneAnim then
		return
	end

	gohelper.setActive(self._goswitch, true)
	self._sceneAnim:Play(animName, callback, self)
end

return VersionActivity3_1DungeonMapView
