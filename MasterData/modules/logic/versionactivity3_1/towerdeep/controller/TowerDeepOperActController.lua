-- chunkname: @modules/logic/versionactivity3_1/towerdeep/controller/TowerDeepOperActController.lua

module("modules.logic.versionactivity3_1.towerdeep.controller.TowerDeepOperActController", package.seeall)

local TowerDeepOperActController = class("TowerDeepOperActController", BaseController)

function TowerDeepOperActController:onInit()
	return
end

function TowerDeepOperActController:reInit()
	return
end

function TowerDeepOperActController:onInitFinish()
	return
end

function TowerDeepOperActController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
end

function TowerDeepOperActController:dailyRefresh()
	if not ActivityModel.instance:isActOnLine(VersionActivity3_1Enum.ActivityId.TowerDeep) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerDeep
	})
end

function TowerDeepOperActController:openTowerPanelView()
	ViewMgr.instance:openView(ViewName.TowerDeepOperActPanelView)
end

TowerDeepOperActController.instance = TowerDeepOperActController.New()

return TowerDeepOperActController
