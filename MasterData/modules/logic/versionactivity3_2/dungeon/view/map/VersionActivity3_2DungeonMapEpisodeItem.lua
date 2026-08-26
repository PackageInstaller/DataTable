-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapEpisodeItem.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapEpisodeItem", package.seeall)

local VersionActivity3_2DungeonMapEpisodeItem = class("VersionActivity3_2DungeonMapEpisodeItem", VersionActivityFixedDungeonMapEpisodeItem)

function VersionActivity3_2DungeonMapEpisodeItem:addEvents()
	VersionActivity3_2DungeonMapEpisodeItem.super.addEvents(self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivity3_2DungeonEvent.V3a2ClickEpisodeItem, self._onV3a2ClickEpisodeItem, self)
end

function VersionActivity3_2DungeonMapEpisodeItem:_onV3a2ClickEpisodeItem(episodeId)
	if episodeId == self._config.id then
		self:onClick()
	end
end

function VersionActivity3_2DungeonMapEpisodeItem:_showAllElementTipView()
	gohelper.setActive(self._gotipcontent, false)
end

return VersionActivity3_2DungeonMapEpisodeItem
