-- chunkname: @modules/logic/versionactivity2_8/dungeon/controller/VersionActivity2_8DungeonController.lua

module("modules.logic.versionactivity2_8.dungeon.controller.VersionActivity2_8DungeonController", package.seeall)

local VersionActivity2_8DungeonController = class("VersionActivity2_8DungeonController", BaseController)

function VersionActivity2_8DungeonController:onInit()
	return
end

function VersionActivity2_8DungeonController:reInit()
	return
end

function VersionActivity2_8DungeonController:_getModuleConfig()
	self._moduleConfig = self._moduleConfig or {
		TaskViewRes = "ui/viewres/versionactivity_2_8/v2a8_dungeon/v2a8_taskview.prefab",
		StoreViewRes = "ui/viewres/versionactivity_2_8/v2a8_dungeon/v2a8_storeview.prefab",
		TaskItemRes = "ui/viewres/versionactivity_2_8/v2a8_dungeon/v2a8_taskitem.prefab",
		EnterView = VersionActivity2_8Enum.ActivityId.EnterView,
		ChapterId = DungeonEnum.ChapterId.Main1_10,
		DungeonStore = VersionActivity2_8Enum.ActivityId.DungeonStore,
		Dungeon = VersionActivity2_8Enum.ActivityId.Dungeon,
		Currency = CurrencyEnum.CurrencyType.V2a8Dungeon,
		StoreCellClass = VersionActivity2_8StoreGoodsItem,
		TaskCellClass = VersionActivity2_8TaskItem
	}

	return self._moduleConfig
end

function VersionActivity2_8DungeonController:openVersionActivityDungeonMapView()
	local moduleConfig = self:_getModuleConfig()

	VersionActivity2_8DungeonTaskStoreController.instance:openVersionActivityDungeonMapView(moduleConfig.EnterView, moduleConfig.Dungeon, moduleConfig.ChapterId)
end

function VersionActivity2_8DungeonController:openTaskView()
	VersionActivity2_8DungeonTaskStoreController.instance:openTaskView(self:_getModuleConfig())
end

function VersionActivity2_8DungeonController:openStoreView()
	VersionActivity2_8DungeonTaskStoreController.instance:openStoreView(self:_getModuleConfig())
end

VersionActivity2_8DungeonController.instance = VersionActivity2_8DungeonController.New()

return VersionActivity2_8DungeonController
