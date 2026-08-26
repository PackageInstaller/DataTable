-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapEpisodeView.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapEpisodeView", package.seeall)

local VersionActivity3_2DungeonMapEpisodeView = class("VersionActivity3_2DungeonMapEpisodeView", VersionActivityFixedDungeonMapEpisodeView)

function VersionActivity3_2DungeonMapEpisodeView:_editableInitView()
	VersionActivity3_2DungeonMapEpisodeView.super._editableInitView(self)

	self._goStory = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_storymode")
	self._goHard = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode")
end

function VersionActivity3_2DungeonMapEpisodeView:refreshModeNode()
	VersionActivity3_2DungeonMapEpisodeView.super.refreshModeNode(self)
	self:_updateBtnStatus(self.activityDungeonMo.mode)
end

function VersionActivity3_2DungeonMapEpisodeView:_updateBtnStatus(curMode)
	local storyModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local hardModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Hard

	gohelper.setActive(self._goStory, curMode ~= storyModeEnum)
	gohelper.setActive(self._goHard, curMode ~= hardModeEnum)
end

function VersionActivity3_2DungeonMapEpisodeView:changeEpisodeMode(mode)
	VersionActivity3_2DungeonMapEpisodeView.super.changeEpisodeMode(self, mode)
	self:_updateBtnStatus(mode)
end

return VersionActivity3_2DungeonMapEpisodeView
