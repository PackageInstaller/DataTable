-- chunkname: @modules/versionactivitybase/mainfixed/VersionActivityMainFixedDungeonController.lua

module("modules.versionactivitybase.mainfixed.VersionActivityMainFixedDungeonController", package.seeall)

local VersionActivityMainFixedDungeonController = class("VersionActivityMainFixedDungeonController", BaseController)

function VersionActivityMainFixedDungeonController:onInit()
	return
end

function VersionActivityMainFixedDungeonController:reInit()
	return
end

function VersionActivityMainFixedDungeonController:_getModuleConfig()
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
			TaskViewRes = string.format("ui/viewres/versionactivity_%s/%s_taskview.prefab", versionFormat1, versionFormat3),
			TaskItemRes = string.format("ui/viewres/versionactivity_%s/%s_taskitem.prefab", versionFormat1, versionFormat3),
			StoreViewRes = string.format("ui/viewres/versionactivity_%s/%s_storeview.prefab", versionFormat1, versionFormat3),
			StoreCellClass = VersionActivity2_8StoreGoodsItem,
			TaskCellClass = VersionActivity2_8TaskItem
		}
	end

	return self._moduleConfig
end

function VersionActivityMainFixedDungeonController:openVersionActivityDungeonMapView()
	local moduleConfig = self:_getModuleConfig()

	VersionActivity2_8DungeonTaskStoreController.instance:openVersionActivityDungeonMapView(moduleConfig.EnterView, moduleConfig.Dungeon, moduleConfig.ChapterId)
end

function VersionActivityMainFixedDungeonController:openTaskView()
	VersionActivity2_8DungeonTaskStoreController.instance:openTaskView(self:_getModuleConfig())
end

function VersionActivityMainFixedDungeonController:openStoreView()
	VersionActivity2_8DungeonTaskStoreController.instance:openStoreView(self:_getModuleConfig())
end

VersionActivityMainFixedDungeonController.instance = VersionActivityMainFixedDungeonController.New()

return VersionActivityMainFixedDungeonController
