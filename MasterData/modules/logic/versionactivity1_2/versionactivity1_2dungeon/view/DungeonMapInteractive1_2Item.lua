-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/DungeonMapInteractive1_2Item.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.DungeonMapInteractive1_2Item", package.seeall)

local DungeonMapInteractive1_2Item = class("DungeonMapInteractive1_2Item", BaseViewExtended)

function DungeonMapInteractive1_2Item:_OnClickElement(mapElement)
	self._config = mapElement._config

	local tarType = self._config.type

	if tarType == DungeonEnum.ElementType.DailyEpisode then
		local url = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapinteractiveitem16.prefab"

		self:openSubView(VersionActivity_1_2_DungeonMapInteractiveItem16, url, self.viewGO, self._config)
	elseif tarType == DungeonEnum.ElementType.Activity1_2Building_Repair then
		local url = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapinteractiveitem102.prefab"

		self:openSubView(VersionActivity_1_2_DungeonMapInteractiveItem102, url, self.viewGO, self._config, mapElement)
	elseif tarType == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
		local url = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmaplevelupitem.prefab"

		self:openSubView(VersionActivity_1_2_DungeonMapLevelUpItem, url, self.viewGO, self._config)
	elseif tarType == DungeonEnum.ElementType.Activity1_2Building_Trap then
		local url = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmaptrapitem.prefab"

		self:openSubView(VersionActivity_1_2_DungeonMapTrapItem, url, self.viewGO, self._config)
	elseif tarType == DungeonEnum.ElementType.Activity1_2Fight then
		local url = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapitem105.prefab"

		self:openSubView(VersionActivity_1_2_DungeonMapItem105, url, self.viewGO, self._config)
	elseif tarType == DungeonEnum.ElementType.Activity1_2Note then
		local url = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapitem105.prefab"

		self:openSubView(VersionActivity_1_2_DungeonMapItem107, url, self.viewGO, self._config)
	else
		self.viewContainer.mapScene:createInteractiveItem()
		self.viewContainer.mapScene._interactiveItem:_OnClickElement(mapElement)
	end
end

function DungeonMapInteractive1_2Item:destroySubView(handler)
	DungeonMapInteractive1_2Item.super.destroySubView(self, handler)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

return DungeonMapInteractive1_2Item
