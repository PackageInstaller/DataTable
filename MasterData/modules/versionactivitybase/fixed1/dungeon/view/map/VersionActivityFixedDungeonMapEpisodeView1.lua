-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/VersionActivityFixedDungeonMapEpisodeView1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.VersionActivityFixedDungeonMapEpisodeView1", package.seeall)

local VersionActivityFixedDungeonMapEpisodeView1 = class("VersionActivityFixedDungeonMapEpisodeView1", VersionActivityFixedDungeonMapEpisodeView)

function VersionActivityFixedDungeonMapEpisodeView1:_editableInitView()
	VersionActivityFixedDungeonMapEpisodeView1.super._editableInitView(self)

	self._goStory = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_storymode")
	self._goHard = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hardmode")
end

function VersionActivityFixedDungeonMapEpisodeView1:refreshModeNode()
	VersionActivityFixedDungeonMapEpisodeView1.super.refreshModeNode(self)
	self:_updateBtnStatus(self.activityDungeonMo.mode)
end

function VersionActivityFixedDungeonMapEpisodeView1:_updateBtnStatus(curMode)
	local storyModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local hardModeEnum = VersionActivityDungeonBaseEnum.DungeonMode.Hard

	gohelper.setActive(self._goStory, curMode ~= storyModeEnum)
	gohelper.setActive(self._goHard, curMode ~= hardModeEnum)
end

function VersionActivityFixedDungeonMapEpisodeView1:changeEpisodeMode(mode)
	VersionActivityFixedDungeonMapEpisodeView1.super.changeEpisodeMode(self, mode)
	self:_updateBtnStatus(mode)
end

return VersionActivityFixedDungeonMapEpisodeView1
