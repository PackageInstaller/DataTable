-- chunkname: @modules/logic/explore/view/unit/ExploreUnitBaseView.lua

module("modules.logic.explore.view.unit.ExploreUnitBaseView", package.seeall)

local ExploreUnitBaseView = class("ExploreUnitBaseView", LuaCompBase)

function ExploreUnitBaseView:ctor(unit, url)
	self.unit = unit
	self.url = url
	self.viewGO = nil
	self.isInitDone = false

	self:startLoad()
end

function ExploreUnitBaseView:startLoad()
	if self._uiLoader or not self.url then
		return
	end

	self._containerGO = gohelper.create2d(GameSceneMgr.instance:getCurScene().view:getRoot(), self.unit.id)
	self._uiLoader = PrefabInstantiate.Create(self._containerGO)

	self._uiLoader:startLoad(self.url, self._onLoaded, self)
end

function ExploreUnitBaseView:_onLoaded()
	self.isInitDone = true

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self.viewGO = self._uiLoader:getInstGO()
	self._uiFollower = gohelper.onceAddComponent(self._containerGO, typeof(ZProj.UIFollower))

	self._uiFollower:Set(mainCamera, uiCamera, plane, self.unit._displayTr or self.unit.trans, 0, 0, 0, 0, self._offsetY2d or 15)
	self._uiFollower:SetEnable(true)
	self:onInit()
	self:addEventListeners()
	self:onOpen()
end

function ExploreUnitBaseView:setTarget(go)
	if not self.isInitDone then
		return
	end

	self._uiFollower:SetTarget3d(go.transform)
end

function ExploreUnitBaseView:onInit()
	return
end

function ExploreUnitBaseView:onOpen()
	return
end

function ExploreUnitBaseView:onClose()
	return
end

function ExploreUnitBaseView:closeThis()
	self.unit.uiComp:removeUI(self.class)
end

function ExploreUnitBaseView:tryDispose()
	if self.isInitDone then
		self:removeEventListeners()
		self:onClose()
		self:onDestroy()
		gohelper.destroy(self._containerGO)

		self.isInitDone = false
	end

	self._containerGO = nil
	self._uiFollower = nil

	if self._uiLoader then
		self._uiLoader:dispose()

		self._uiLoader = nil
	end

	self.viewGO = nil
	self.unit = nil
	self.url = nil
end

return ExploreUnitBaseView
