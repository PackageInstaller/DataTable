-- chunkname: @modules/logic/versionactivity3_3/dungeon/controller/VersionActivity3_3DungeonController.lua

module("modules.logic.versionactivity3_3.dungeon.controller.VersionActivity3_3DungeonController", package.seeall)

local VersionActivity3_3DungeonController = class("VersionActivity3_3DungeonController", BaseController)

function VersionActivity3_3DungeonController:onInit()
	return
end

function VersionActivity3_3DungeonController:reInit()
	return
end

function VersionActivity3_3DungeonController:_getModuleConfig()
	self._moduleConfig = self._moduleConfig or {
		TaskViewRes = "ui/viewres/versionactivity_3_3/v3a3_taskview.prefab",
		StoreViewRes = "ui/viewres/versionactivity_3_3/v3a3_storeview.prefab",
		TaskItemRes = "ui/viewres/versionactivity_3_3/v3a3_taskitem.prefab",
		EnterView = VersionActivity3_3Enum.ActivityId.EnterView,
		ChapterId = DungeonEnum.ChapterId.Main1_12,
		DungeonStore = VersionActivity3_3Enum.ActivityId.DungeonStore,
		Dungeon = VersionActivity3_3Enum.ActivityId.Dungeon,
		Currency = CurrencyEnum.CurrencyType.V3a3Dungeon,
		StoreCellClass = VersionActivity2_8StoreGoodsItem,
		TaskCellClass = VersionActivity2_8TaskItem
	}

	return self._moduleConfig
end

function VersionActivity3_3DungeonController:openVersionActivityDungeonMapView()
	local moduleConfig = self:_getModuleConfig()

	VersionActivity2_8DungeonTaskStoreController.instance:openVersionActivityDungeonMapView(moduleConfig.EnterView, moduleConfig.Dungeon, moduleConfig.ChapterId)
end

function VersionActivity3_3DungeonController:openTaskView()
	VersionActivity2_8DungeonTaskStoreController.instance:openTaskView(self:_getModuleConfig())
end

function VersionActivity3_3DungeonController:openStoreView()
	VersionActivity2_8DungeonTaskStoreController.instance:openStoreView(self:_getModuleConfig())
end

VersionActivity3_3DungeonController.instance = VersionActivity3_3DungeonController.New()

return VersionActivity3_3DungeonController
