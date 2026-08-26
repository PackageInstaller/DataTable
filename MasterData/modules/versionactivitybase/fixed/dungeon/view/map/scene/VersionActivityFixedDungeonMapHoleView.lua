-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/map/scene/VersionActivityFixedDungeonMapHoleView.lua

module("modules.versionactivitybase.fixed.dungeon.view.map.scene.VersionActivityFixedDungeonMapHoleView", package.seeall)

local VersionActivityFixedDungeonMapHoleView = class("VersionActivityFixedDungeonMapHoleView", DungeonMapHoleView)

function VersionActivityFixedDungeonMapHoleView:onInitView()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedDungeonMapHoleView:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivityFixedDungeonMapHoleView:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivityFixedDungeonMapHoleView:_editableInitView()
	return
end

function VersionActivityFixedDungeonMapHoleView:loadSceneFinish(param)
	local holeParam = {
		param.mapConfig,
		param.mapSceneGo
	}

	VersionActivityFixedDungeonMapHoleView.super.loadSceneFinish(self, holeParam)
end

function VersionActivityFixedDungeonMapHoleView:onMapPosChanged(targetPos, isTween)
	VersionActivityFixedDungeonMapHoleView.super.onMapPosChanged(self, targetPos, isTween)
end

function VersionActivityFixedDungeonMapHoleView:initCameraParam()
	VersionActivityFixedDungeonMapHoleView.super.initCameraParam(self)
end

function VersionActivityFixedDungeonMapHoleView:onAddOneElement(elementComp)
	if elementComp then
		local elementId = elementComp:getElementId()

		self:_onAddElement(elementId)
	end
end

function VersionActivityFixedDungeonMapHoleView:onRemoveElement(elementComp)
	if elementComp and elementComp._config.fragment == 0 then
		local elementId = elementComp:getElementId()

		self:_onRemoveElement(elementId)
	end
end

function VersionActivityFixedDungeonMapHoleView:onRecycleAllElement()
	self:refreshHoles()
end

return VersionActivityFixedDungeonMapHoleView
