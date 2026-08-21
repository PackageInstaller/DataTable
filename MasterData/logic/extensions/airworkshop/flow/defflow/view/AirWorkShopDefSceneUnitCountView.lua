-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefSceneUnitCountView.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefSceneUnitCountView", package.seeall)

local M = class("AirWorkShopDefSceneUnitCountView", ViewComponent)

function M:buildUI()
	self._countPanelList = {
		self:getGoByPath("maskTop/objMiddle/imgHighland"),
		self:getGoByPath("maskTop/objMiddle/imgRole"),
		self:getGoByPath("maskTop/objMiddle/imgBuild"),
		self:getGoByPath("maskTop/objMiddle/imgMessage")
	}
	self._txtHero = self:getTextByPath("maskTop/objMiddle/imgRole/txtRole")
	self._txtHighLand = self:getTextByPath("maskTop/objMiddle/imgHighland/txtHighland")
	self._txtBuilding = self:getTextByPath("maskTop/objMiddle/imgBuild/txtBuild")
	self._txtMessage = self:getTextByPath("maskTop/objMiddle/imgMessage/txtMessage")
	self._goHighlandTips = self:getGoByPath("maskTop/objMiddle/imgHighland/btnNotice")
end

function M:_setEvents(add)
	if add then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_ADD_OR_REMOVE_UNIT, self._onUnitCountUpdate, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_ADD_OR_REMOVE_UNIT, self._onUnitCountUpdate, self)
	end
end

function M:onEnter()
	self:_setEvents(true)
	self:_onSceneUpdate()
end

function M:onExit()
	self:_setEvents(false)
end

function M:_onSceneUpdate()
	self:_initLimit()
	self:_updateUnitCount()
	self:_updateCountPanel()
end

function M:_onUnitCountUpdate()
	self:_updateUnitCount()
	self:_updateCountPanel()
end

function M:_initLimit()
	local model = AirWorkShopDefMgr.instance:getModel()
	local levelCO = model:getLevelCO()

	self._unitLimit = AirWorkShopDefSceneModel.instance:getCurTabTypeLimit(AirWorkShopEnum.TabEnum.Hero)
	self._highlandLimit = AirWorkShopDefSceneModel.instance:getCurTabTypeLimit(AirWorkShopEnum.TabEnum.Highland)
	self._buildingLimit = AirWorkShopDefSceneModel.instance:getCurTabTypeLimit(AirWorkShopEnum.TabEnum.Building)
	self._messageLimit = AirWorkShopDefSceneModel.instance:getCurTabTypeLimit(AirWorkShopEnum.TabEnum.Message)
end

function M:_updateUnitCount()
	self._unitCount = AirWorkShopDefSceneModel.instance:getCurTabTypeCount(AirWorkShopEnum.TabEnum.Hero)
	self._highlandCount = AirWorkShopDefSceneModel.instance:getCurTabTypeCount(AirWorkShopEnum.TabEnum.Highland)
	self._buildingCount = AirWorkShopDefSceneModel.instance:getCurTabTypeCount(AirWorkShopEnum.TabEnum.Building)
	self._messageCount = AirWorkShopDefSceneModel.instance:getCurTabTypeCount(AirWorkShopEnum.TabEnum.Message)
end

function M:_updateCountPanel()
	self._txtHero.text = string.format("%d/%d", self._unitCount, self._unitLimit)
	self._txtHighLand.text = string.format("%d/%d", self._highlandCount, self._highlandLimit)
	self._txtBuilding.text = string.format("%d/%d", self._buildingCount, self._buildingLimit)
	self._txtMessage.text = string.format("%d/%d", self._messageCount, self._messageLimit)
end

return M
