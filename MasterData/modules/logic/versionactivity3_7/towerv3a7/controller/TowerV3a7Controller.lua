-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/controller/TowerV3a7Controller.lua

module("modules.logic.versionactivity3_7.towerv3a7.controller.TowerV3a7Controller", package.seeall)

local TowerV3a7Controller = class("TowerV3a7Controller", BaseController)

function TowerV3a7Controller:onInit()
	self:reInit()
end

function TowerV3a7Controller:onInitFinish()
	return
end

function TowerV3a7Controller:reInit()
	self._curFinishStoryId = nil
end

function TowerV3a7Controller:addConstEvents()
	self.registerCallback(self, TowerV3a7Event.DeadChessMan, self._onDeadChessMan, self, LuaEventSystem.Low)
	StoryController.instance:registerCallback(StoryEvent.FinishFromServer, self._finishStoryFromServer, self, LuaEventSystem.High)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.High)
end

function TowerV3a7Controller:_onOpenViewFinish(viewName)
	if viewName == ViewName.DungeonMapView and self._curFinishStoryId then
		local storyId = self._curFinishStoryId

		self._curFinishStoryId = nil

		DungeonController.openStoryElementView(storyId)
	end
end

function TowerV3a7Controller:_finishStoryFromServer(storyId)
	if not DungeonMapModel.instance:checkStoryElementFinished(storyId) then
		if GameSceneMgr.instance:isFightScene() then
			self._curFinishStoryId = storyId

			return
		end

		DungeonController.openStoryElementView(storyId)
	end
end

function TowerV3a7Controller:_onDeadChessMan(mo)
	TowerV3a7ChessManModel.instance:chessDie(mo)
end

function TowerV3a7Controller:openTowerV3a7MapView(param)
	local mapConfig = TowerV3a7Config.getMapConfig(param.elementId)

	TowerV3a7Model.instance:initMapParams(param.elementId, mapConfig)
	ViewMgr.instance:openView(ViewName.TowerV3a7MapView)
end

function TowerV3a7Controller:openTowerV3a7MapViewFromMain(mapConfig)
	TowerV3a7Model.instance:initMapParams(nil, mapConfig)
	ViewMgr.instance:openView(ViewName.TowerV3a7MapView)
end

function TowerV3a7Controller:openTowerV3a7MainView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.TowerV3a7MainView, param, isImmediate)
end

TowerV3a7Controller.instance = TowerV3a7Controller.New()

return TowerV3a7Controller
