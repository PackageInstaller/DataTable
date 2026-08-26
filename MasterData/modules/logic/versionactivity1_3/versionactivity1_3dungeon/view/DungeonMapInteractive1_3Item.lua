-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/DungeonMapInteractive1_3Item.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.DungeonMapInteractive1_3Item", package.seeall)

local DungeonMapInteractive1_3Item = class("DungeonMapInteractive1_3Item", BaseViewExtended)

function DungeonMapInteractive1_3Item:_OnClickElement(mapElement)
	self._config = mapElement._config

	local tarType = self._config.type

	if tarType == DungeonEnum.ElementType.DailyEpisode then
		VersionActivity1_3DungeonController.instance.dailyFromEpisodeId = self.viewContainer.versionActivityDungeonBaseMo.episodeId

		local url = "ui/viewres/versionactivity_1_3/map/versionactivity_1_3_dungeonmapinteractiveitem16.prefab"

		if self._itemView then
			self._itemView:DESTROYSELF()

			self._itemView = nil

			DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)
		end

		self._itemView = self:openSubView(VersionActivity_1_3_DungeonMapInteractiveItem16, url, self.viewGO, self._config)
	else
		self.viewContainer.mapScene:createInteractiveItem()
		self.viewContainer.mapScene._interactiveItem:_OnClickElement(mapElement)
	end
end

function DungeonMapInteractive1_3Item:destroySubView(handler)
	DungeonMapInteractive1_3Item.super.destroySubView(self, handler)

	self._itemView = nil

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

return DungeonMapInteractive1_3Item
