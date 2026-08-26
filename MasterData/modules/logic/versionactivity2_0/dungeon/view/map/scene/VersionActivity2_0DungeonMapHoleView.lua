-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/map/scene/VersionActivity2_0DungeonMapHoleView.lua

module("modules.logic.versionactivity2_0.dungeon.view.map.scene.VersionActivity2_0DungeonMapHoleView", package.seeall)

local VersionActivity2_0DungeonMapHoleView = class("VersionActivity2_0DungeonMapHoleView", DungeonMapHoleView)

function VersionActivity2_0DungeonMapHoleView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_0DungeonMapHoleView:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self.addEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.addEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_0DungeonMapHoleView:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self.removeEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.removeEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.removeEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.removeEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_0DungeonMapHoleView:_editableInitView()
	self.graffitiActId = Activity161Model.instance:getActId()
end

function VersionActivity2_0DungeonMapHoleView:loadSceneFinish(param)
	local holeParam = {
		param.mapConfig,
		param.mapSceneGo
	}

	VersionActivity2_0DungeonMapHoleView.super.loadSceneFinish(self, holeParam)
end

function VersionActivity2_0DungeonMapHoleView:onMapPosChanged(targetPos, isTween)
	VersionActivity2_0DungeonMapHoleView.super.onMapPosChanged(self, targetPos, isTween)
end

function VersionActivity2_0DungeonMapHoleView:initCameraParam()
	VersionActivity2_0DungeonMapHoleView.super.initCameraParam(self)
end

function VersionActivity2_0DungeonMapHoleView:onAddOneElement(elementComp)
	local elementId = elementComp:getElementId()
	local graffitiConfig = Activity161Config.instance:getGraffitiCo(self.graffitiActId, elementId)

	if not graffitiConfig then
		self:_onAddElement(elementId)
	end
end

function VersionActivity2_0DungeonMapHoleView:onRemoveElement(elementComp)
	if elementComp then
		local elementId = elementComp:getElementId()

		self:_onRemoveElement(elementId)
	end
end

function VersionActivity2_0DungeonMapHoleView:onRecycleAllElement()
	self:refreshHoles()
end

return VersionActivity2_0DungeonMapHoleView
