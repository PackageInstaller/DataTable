-- chunkname: @modules/logic/versionactivity3_0/dungeon/controller/VersionActivity3_0DungeonController.lua

module("modules.logic.versionactivity3_0.dungeon.controller.VersionActivity3_0DungeonController", package.seeall)

local VersionActivity3_0DungeonController = class("VersionActivity3_0DungeonController", BaseController)

function VersionActivity3_0DungeonController:onInit()
	return
end

function VersionActivity3_0DungeonController:reInit()
	return
end

function VersionActivity3_0DungeonController:_getModuleConfig()
	self._moduleConfig = self._moduleConfig or {
		TaskViewRes = "ui/viewres/versionactivity_3_0/v3a0_taskview.prefab",
		StoreViewRes = "ui/viewres/versionactivity_3_0/v3a0_storeview.prefab",
		TaskItemRes = "ui/viewres/versionactivity_3_0/v3a0_taskitem.prefab",
		EnterView = VersionActivity3_0Enum.ActivityId.EnterView,
		ChapterId = DungeonEnum.ChapterId.Main1_11,
		DungeonStore = VersionActivity3_0Enum.ActivityId.DungeonStore,
		Dungeon = VersionActivity3_0Enum.ActivityId.Dungeon,
		Currency = CurrencyEnum.CurrencyType.V3a0Dungeon,
		StoreCellClass = VersionActivity2_8StoreGoodsItem,
		TaskCellClass = VersionActivity2_8TaskItem
	}

	return self._moduleConfig
end

function VersionActivity3_0DungeonController:openVersionActivityDungeonMapView()
	local moduleConfig = self:_getModuleConfig()

	VersionActivity2_8DungeonTaskStoreController.instance:openVersionActivityDungeonMapView(moduleConfig.EnterView, moduleConfig.Dungeon, moduleConfig.ChapterId)
end

function VersionActivity3_0DungeonController:openTaskView()
	VersionActivity2_8DungeonTaskStoreController.instance:openTaskView(self:_getModuleConfig())
end

function VersionActivity3_0DungeonController:openStoreView()
	VersionActivity2_8DungeonTaskStoreController.instance:openStoreView(self:_getModuleConfig())
end

VersionActivity3_0DungeonController.instance = VersionActivity3_0DungeonController.New()

return VersionActivity3_0DungeonController
