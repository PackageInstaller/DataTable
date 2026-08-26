-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/map/VersionActivity3_4DungeonMapEpisodeView.lua

module("modules.logic.versionactivity3_4.dungeon.view.map.VersionActivity3_4DungeonMapEpisodeView", package.seeall)

local VersionActivity3_4DungeonMapEpisodeView = class("VersionActivity3_4DungeonMapEpisodeView", VersionActivityFixedDungeonMapEpisodeView)

function VersionActivity3_4DungeonMapEpisodeView:_editableInitView()
	VersionActivity3_4DungeonMapEpisodeView.super._editableInitView(self)

	self._goStory = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_storymode")
	self._goHard = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode")
end

function VersionActivity3_4DungeonMapEpisodeView:refreshModeNode()
	VersionActivity3_4DungeonMapEpisodeView.super.refreshModeNode(self)
	self:_updateBtnStatus(self.activityDungeonMo.mode)
end

function VersionActivity3_4DungeonMapEpisodeView:_updateBtnStatus(curMode)
	local storyModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local hardModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Hard

	gohelper.setActive(self._goStory, curMode ~= storyModeEnum)
	gohelper.setActive(self._goHard, curMode ~= hardModeEnum)
end

function VersionActivity3_4DungeonMapEpisodeView:changeEpisodeMode(mode)
	VersionActivity3_4DungeonMapEpisodeView.super.changeEpisodeMode(self, mode)
	self:_updateBtnStatus(mode)
end

return VersionActivity3_4DungeonMapEpisodeView
