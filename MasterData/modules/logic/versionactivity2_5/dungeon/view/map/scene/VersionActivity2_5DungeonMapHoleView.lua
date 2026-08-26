-- chunkname: @modules/logic/versionactivity2_5/dungeon/view/map/scene/VersionActivity2_5DungeonMapHoleView.lua

module("modules.logic.versionactivity2_5.dungeon.view.map.scene.VersionActivity2_5DungeonMapHoleView", package.seeall)

local VersionActivity2_5DungeonMapHoleView = class("VersionActivity2_5DungeonMapHoleView", DungeonMapHoleView)

function VersionActivity2_5DungeonMapHoleView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_5DungeonMapHoleView:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self.addEventCb(self, VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.addEventCb(self, VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_5DungeonMapHoleView:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self.removeEventCb(self, VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.removeEventCb(self, VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.removeEventCb(self, VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.removeEventCb(self, VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_5DungeonMapHoleView:_editableInitView()
	return
end

function VersionActivity2_5DungeonMapHoleView:loadSceneFinish(param)
	local holeParam = {
		param.mapConfig,
		param.mapSceneGo
	}

	VersionActivity2_5DungeonMapHoleView.super.loadSceneFinish(self, holeParam)
end

function VersionActivity2_5DungeonMapHoleView:onMapPosChanged(targetPos, isTween)
	VersionActivity2_5DungeonMapHoleView.super.onMapPosChanged(self, targetPos, isTween)
end

function VersionActivity2_5DungeonMapHoleView:initCameraParam()
	VersionActivity2_5DungeonMapHoleView.super.initCameraParam(self)
end

function VersionActivity2_5DungeonMapHoleView:onAddOneElement(elementComp)
	if elementComp then
		local elementId = elementComp:getElementId()

		self:_onAddElement(elementId)
	end
end

function VersionActivity2_5DungeonMapHoleView:onRemoveElement(elementComp)
	if elementComp and elementComp._config.fragment == 0 then
		local elementId = elementComp:getElementId()

		self:_onRemoveElement(elementId)
	end
end

function VersionActivity2_5DungeonMapHoleView:onRecycleAllElement()
	self:refreshHoles()
end

return VersionActivity2_5DungeonMapHoleView
