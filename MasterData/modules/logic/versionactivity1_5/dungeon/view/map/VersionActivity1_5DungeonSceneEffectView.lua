-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonSceneEffectView.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonSceneEffectView", package.seeall)

local VersionActivity1_5DungeonSceneEffectView = class("VersionActivity1_5DungeonSceneEffectView", BaseView)

function VersionActivity1_5DungeonSceneEffectView:onInitView(go)
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5DungeonSceneEffectView:addEvents()
	return
end

function VersionActivity1_5DungeonSceneEffectView:removeEvents()
	return
end

function VersionActivity1_5DungeonSceneEffectView:_editableInitView()
	self.dayTimeEffectGoPool = nil
	self.nightEffectGoPool = nil

	self:createScenePoolRoot()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.onLoadSceneFinish, self)
end

function VersionActivity1_5DungeonSceneEffectView:createScenePoolRoot()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	sceneRoot = gohelper.findChild(sceneRoot, VersionActivity1_5DungeonEnum.SceneRootName)
	self.effectPoolRoot = UnityEngine.GameObject.New("effectPoolRoot")

	gohelper.addChild(sceneRoot, self.effectPoolRoot)
	gohelper.setActive(self.effectPoolRoot, false)
	transformhelper.setLocalPos(self.effectPoolRoot.transform, 0, 0, 0)
end

function VersionActivity1_5DungeonSceneEffectView:onDisposeOldMap()
	self:recycleEffectGo()
end

function VersionActivity1_5DungeonSceneEffectView:onLoadSceneFinish(param)
	self.sceneGo = param.mapSceneGo
	self.mapConfig = param.mapConfig
	self.goEffectRoot = gohelper.findChild(self.sceneGo, "SceneEffect")

	self:addSceneEffect()
end

function VersionActivity1_5DungeonSceneEffectView:addSceneEffect()
	if not self.activityDungeonMo:isHardMode() then
		gohelper.setActive(self.goEffectRoot, false)

		return
	end

	gohelper.setActive(self.goEffectRoot, true)

	local isDayTime = VersionActivity1_5DungeonEnum.MapId2Light[self.mapConfig.id]

	if isDayTime then
		if not self.dayTimeEffectGo then
			self:createDayTimeGo()
		else
			self:refreshEffect()
		end
	elseif not self.nightEffectGo then
		self:createNightTimeGo()
	else
		self:refreshEffect()
	end
end

function VersionActivity1_5DungeonSceneEffectView:getEffectLoader()
	if self.effectLoader then
		return self.effectLoader
	end

	self.effectLoader = MultiAbLoader.New()

	self.effectLoader:addPath(VersionActivity1_5DungeonEnum.SceneEffect.DayTime)
	self.effectLoader:addPath(VersionActivity1_5DungeonEnum.SceneEffect.Night)
	self.effectLoader:startLoad(self.onEffectLoadDone, self)

	return self.effectLoader
end

function VersionActivity1_5DungeonSceneEffectView:onEffectLoadDone()
	self:createDayTimeGo()
	self:createNightTimeGo()
end

function VersionActivity1_5DungeonSceneEffectView:createDayTimeGo()
	if not VersionActivity1_5DungeonEnum.MapId2Light[self.mapConfig.id] then
		return
	end

	if self.dayTimeEffectGoPool then
		self.dayTimeEffectGo = self.dayTimeEffectGoPool
		self.dayTimeEffectGoPool = nil

		gohelper.addChild(self.goEffectRoot, self.dayTimeEffectGo)
		self:refreshEffect()

		return
	end

	local loader = self:getEffectLoader()

	if loader.isLoading then
		return
	end

	local assetItem = loader:getAssetItem(VersionActivity1_5DungeonEnum.SceneEffect.DayTime)
	local prefab = assetItem:GetResource()

	self.dayTimeEffectGo = gohelper.clone(prefab, self.goEffectRoot)

	self:refreshEffect()
end

function VersionActivity1_5DungeonSceneEffectView:createNightTimeGo()
	if VersionActivity1_5DungeonEnum.MapId2Light[self.mapConfig.id] then
		return
	end

	if self.nightEffectGoPool then
		self.nightEffectGo = self.nightEffectGoPool
		self.nightEffectGoPool = nil

		gohelper.addChild(self.goEffectRoot, self.nightEffectGo)
		self:refreshEffect()

		return
	end

	local loader = self:getEffectLoader()

	if loader.isLoading then
		return
	end

	local assetItem = loader:getAssetItem(VersionActivity1_5DungeonEnum.SceneEffect.Night)
	local prefab = assetItem:GetResource()

	self.nightEffectGo = gohelper.clone(prefab, self.goEffectRoot)

	self:refreshEffect()
end

function VersionActivity1_5DungeonSceneEffectView:refreshEffect()
	if not self.activityDungeonMo:isHardMode() then
		gohelper.setActive(self.goEffectRoot, false)

		return
	end

	local isDayTime = VersionActivity1_5DungeonEnum.MapId2Light[self.mapConfig.id]

	if self.dayTimeEffectGo then
		gohelper.setActive(self.dayTimeEffectGo, isDayTime)
	end

	if self.nightEffectGo then
		gohelper.setActive(self.nightEffectGo, not isDayTime)
	end
end

function VersionActivity1_5DungeonSceneEffectView:recycleEffectGo()
	if self.dayTimeEffectGo then
		gohelper.addChild(self.effectPoolRoot, self.dayTimeEffectGo)

		self.dayTimeEffectGoPool = self.dayTimeEffectGo
		self.dayTimeEffectGo = nil
	end

	if self.nightEffectGo then
		gohelper.addChild(self.effectPoolRoot, self.nightEffectGo)

		self.nightEffectGoPool = self.nightEffectGo
		self.nightEffectGo = nil
	end
end

function VersionActivity1_5DungeonSceneEffectView:onDestroy()
	if self.effectLoader then
		self.effectLoader:dispose()
	end
end

return VersionActivity1_5DungeonSceneEffectView
