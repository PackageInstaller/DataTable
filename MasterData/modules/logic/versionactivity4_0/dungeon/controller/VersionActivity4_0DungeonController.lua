-- chunkname: @modules/logic/versionactivity4_0/dungeon/controller/VersionActivity4_0DungeonController.lua

module("modules.logic.versionactivity4_0.dungeon.controller.VersionActivity4_0DungeonController", package.seeall)

local VersionActivity4_0DungeonController = class("VersionActivity4_0DungeonController", VersionActivityMainFixedDungeonController)

function VersionActivity4_0DungeonController:_getModuleConfig()
	if not self._moduleConfig then
		local versionFormat1 = VersionActivityMainFixedHelper.getVersionActivityVerFormat1()
		local versionFormat3 = VersionActivityMainFixedHelper.getVersionActivityVerFormat3()
		local currency = VersionActivityMainFixedHelper.getActivityCurrency()
		local chapter = VersionActivityMainFixedHelper.getActivityChapter()
		local versionActivityEnum = VersionActivityMainFixedHelper.getVersionActivityEnum()

		self._moduleConfig = {
			EnterView = versionActivityEnum.ActivityId.EnterView,
			ChapterId = chapter,
			DungeonStore = versionActivityEnum.ActivityId.DungeonStore,
			Dungeon = versionActivityEnum.ActivityId.Dungeon,
			Currency = currency,
			TaskViewRes = string.format("ui/viewres/versionactivity_%s/%s_dungeon/%s_taskview.prefab", versionFormat1, versionFormat3, versionFormat3),
			TaskItemRes = string.format("ui/viewres/versionactivity_%s/%s_dungeon/%s_taskitem.prefab", versionFormat1, versionFormat3, versionFormat3),
			StoreViewRes = string.format("ui/viewres/versionactivity_%s/%s_dungeon/%s_storeview.prefab", versionFormat1, versionFormat3, versionFormat3),
			StoreCellClass = VersionActivity2_8StoreGoodsItem,
			TaskCellClass = VersionActivity2_8TaskItem
		}
	end

	return self._moduleConfig
end

VersionActivity4_0DungeonController.instance = VersionActivity4_0DungeonController.New()

return VersionActivity4_0DungeonController
