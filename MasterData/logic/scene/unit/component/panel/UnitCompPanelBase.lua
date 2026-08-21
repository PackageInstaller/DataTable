-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/panel/UnitCompPanelBase.lua

module("logic.scene.unit.component.panel.UnitCompPanelBase", package.seeall)

local M = class("UnitCompPanelBase", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = false
	self._followUIComp = false
	self._mainGo = false
	self._viewElementsRegistry = false
end

function M:onInit()
	local rootGo = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)
	local talkGo = goutil.create("talk", true)

	goutil.addChildToParent(talkGo, rootGo)

	self._resLoader = PrefabLoader.Get(talkGo)
	self._followUIComp = self._unit.uiFollow
	self._viewElementsRegistry = ViewElementsRegistry.New()
end

function M:onReuse()
	return
end

function M:onReset()
	if self._resLoader then
		self._resLoader:clear()
	end

	self._viewElementsRegistry:cleanRegistry()

	self._mainGo = false
end

function M:onDestroy()
	if self._resLoader then
		self._resLoader:clear()
	end

	self._viewElementsRegistry = nil
	self._followUIComp = nil
end

function M:setPanelResPath(resPath)
	if self._resLoader then
		self._resLoader:load(resPath, self._onResLoaded, self, true)
	end
end

function M:_onResLoaded(loader)
	self._mainGo = self._resLoader:getInst()

	self._followUIComp:addTopFollowGameObject(self._mainGo)
	self._viewElementsRegistry:setMainGO(self._mainGo)
	self:onBuildUI()
end

function M:onBuildUI()
	return
end

return M
