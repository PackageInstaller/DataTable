-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefScenePreviewSelectView.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefScenePreviewSelectView", package.seeall)

local M = class("AirWorkShopDefScenePreviewSelectView", ViewComponent)

function M:buildUI()
	self._previewPanelGo = self:getGoByPath("objShow")
	self._previewToggleList = {
		[0] = self:getGoByPath("objShow/itemGroup/tabItem"):GetComponent(UIComponentType.SpaceXToggle),
		[AirWorkShopEnum.TabEnum.Hero] = self:getGoByPath("objShow/itemGroup/tabItem2"):GetComponent(UIComponentType.SpaceXToggle),
		[AirWorkShopEnum.TabEnum.Highland] = self:getGoByPath("objShow/itemGroup/tabItem3"):GetComponent(UIComponentType.SpaceXToggle),
		[AirWorkShopEnum.TabEnum.Building] = self:getGoByPath("objShow/itemGroup/tabItem4"):GetComponent(UIComponentType.SpaceXToggle),
		[AirWorkShopEnum.TabEnum.Message] = self:getGoByPath("objShow/itemGroup/tabItem5"):GetComponent(UIComponentType.SpaceXToggle)
	}

	goutil.setActive(self._previewPanelGo, false)
end

function M:bindEvents()
	for k, v in pairs(self._previewToggleList) do
		v:AddListener(function(_, isOn)
			self:_dealToggleClick(k, isOn)
		end, nil)
	end
end

function M:unbindEvents()
	for k, v in pairs(self._previewToggleList) do
		v:RemoveListener()
	end
end

function M:_setEvents(isAdd)
	if isAdd then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_UNIT_VISIBLE_UPDATE, self._setTabVisible, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_UNIT_VISIBLE_UPDATE, self._setTabVisible, self)
	end
end

function M:_dealToggleClick(tab, isOn)
	if self._isChanging then
		return
	end

	if tab == 0 then
		for type = 1, 4 do
			self._isChanging = true
			self._previewToggleList[type].IsOn = isOn

			AirWorkShopDefSceneModel.instance:setPreviewSelect(type, isOn)

			self._isChanging = false
		end
	else
		AirWorkShopDefSceneModel.instance:setPreviewSelect(tab, isOn)
		self:_checkForAllSelect()
	end

	AirWorkShopDefOperateUtil.updateUnitVisible()
end

function M:_setTabVisible(_, type)
	if not self._previewToggleList[type] then
		return
	end

	FloatWordMgr.instance:show(string.format(lang("tip_airwork_visible_open"), AirWorkShopEnum.TabName[type]))

	self._isChanging = true
	self._previewToggleList[type].IsOn = true

	AirWorkShopDefSceneModel.instance:setPreviewSelect(type, true)
	self:_checkForAllSelect()
	AirWorkShopDefOperateUtil.updateUnitVisible()

	self._isChanging = false
end

function M:_checkForAllSelect()
	local isAll = true

	for type = 1, 4 do
		local isSelect = AirWorkShopDefSceneModel.instance:getPreviewSelect(type)

		if not isSelect then
			isAll = false

			break
		end
	end

	self._isChanging = true
	self._previewToggleList[0].IsOn = isAll
	self._isChanging = false
end

function M:onEnter()
	self:_setEvents(true)

	self._isChanging = true

	self:_refreshView()

	self._isChanging = false
end

function M:onExit()
	self:_setEvents(false)
end

function M:_refreshView()
	local isAll = true

	for type = 1, 4 do
		local isSelect = AirWorkShopDefSceneModel.instance:getPreviewSelect(type)

		self._previewToggleList[type].IsOn = isSelect

		if not isSelect then
			isAll = false
		end
	end

	self._previewToggleList[0].IsOn = isAll
end

return M
