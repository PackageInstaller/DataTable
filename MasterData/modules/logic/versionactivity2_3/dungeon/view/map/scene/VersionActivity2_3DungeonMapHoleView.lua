-- chunkname: @modules/logic/versionactivity2_3/dungeon/view/map/scene/VersionActivity2_3DungeonMapHoleView.lua

module("modules.logic.versionactivity2_3.dungeon.view.map.scene.VersionActivity2_3DungeonMapHoleView", package.seeall)

local VersionActivity2_3DungeonMapHoleView = class("VersionActivity2_3DungeonMapHoleView", DungeonMapHoleView)

function VersionActivity2_3DungeonMapHoleView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3DungeonMapHoleView:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self.addEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.addEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_3DungeonMapHoleView:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self.removeEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.removeEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.removeEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.removeEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_3DungeonMapHoleView:_editableInitView()
	return
end

function VersionActivity2_3DungeonMapHoleView:loadSceneFinish(param)
	local holeParam = {
		param.mapConfig,
		param.mapSceneGo
	}

	VersionActivity2_3DungeonMapHoleView.super.loadSceneFinish(self, holeParam)
end

function VersionActivity2_3DungeonMapHoleView:onMapPosChanged(targetPos, isTween)
	VersionActivity2_3DungeonMapHoleView.super.onMapPosChanged(self, targetPos, isTween)
end

function VersionActivity2_3DungeonMapHoleView:initCameraParam()
	VersionActivity2_3DungeonMapHoleView.super.initCameraParam(self)
end

function VersionActivity2_3DungeonMapHoleView:onAddOneElement(elementComp)
	if elementComp then
		local elementId = elementComp:getElementId()

		self:_onAddElement(elementId)
	end
end

function VersionActivity2_3DungeonMapHoleView:onRemoveElement(elementComp)
	if elementComp and elementComp._config.fragment == 0 then
		local elementId = elementComp:getElementId()

		self:_onRemoveElement(elementId)
	end
end

function VersionActivity2_3DungeonMapHoleView:onRecycleAllElement()
	self:refreshHoles()
end

return VersionActivity2_3DungeonMapHoleView
