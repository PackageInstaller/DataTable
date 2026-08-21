-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSelectHeroView.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSelectHeroView", package.seeall)

local M = class("AirWorkSelectHeroView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._selectedHeroId = false
end

function M:buildUI()
	self._scrollRectGo = self:getGo("air_workshop_select_hero_tips_-1800497984")
	self._loopGridView = LoopGridViewHelper.New(self._scrollRectGo)

	self._loopGridView:InitGridView(0, self._updateCell, self)

	self._btnClose = self:getBtn("4&universal_second_tips_common_bg_1201003252")
	self._btnSure = Astral.SimpleLuaComponentContainer.Add(self:getGo("6&btn_right_1251431307"), CommButton)
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("5&btn_left_-1571983320"), CommButton)
	self._txtEmptyGo = self:getGo("air_workshop_select_hero_tips_-287997088")
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function M:onEnter()
	local currModel = AirWorkShopDefMgr.instance:getModel()
	local mapData = currModel:getModiedMapMO()
	local airworkHeroMoList = mapData:getHeroMOList()

	self._moList = {}

	for i, v in ipairs(airworkHeroMoList) do
		table.insert(self._moList, v)
	end

	self:_setData()
end

function M:onExitFinished()
	self._selectedHeroId = false

	for _, item in ipairs(self._itemViewList or {}) do
		item:unbindEvents()
	end

	self._itemViewList = {}
end

function M:destroyUI()
	return
end

function M:_setData()
	goutil.setActive(self._txtEmptyGo, #self._moList == 0)

	self._itemViewList = {}

	local itemCount = #self._moList

	self._loopGridView:SetListItemCount(itemCount)
	self._loopGridView:RefreshAllShownItem()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopGridView:NewListViewItem("hero_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, HeroHeadItem)
	local heroId = self._moList[curIndex]:getId()
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	shower:bindEvents()
	shower:setHandler(self)
	shower:setHeroMO(heroData, curIndex)
	shower:showName(true)
	shower:setSelected(self._selectedHeroId and self._selectedHeroId == heroId)
	table.insert(self._itemViewList, shower)

	return item
end

function M:_setSelectedHero(heroId)
	self._selectedHeroId = heroId

	self._loopGridView:RefreshAllShownItem()
end

function M:onClickHeroItem(heroItem)
	local clickHeroMO = heroItem:getHeroMO()
	local clickHeroId = clickHeroMO:getId()
	local selectedId = clickHeroId

	if self._selectedHeroId and self._selectedHeroId == clickHeroId then
		selectedId = nil
	end

	self:_setSelectedHero(selectedId)
end

function M:_onClickSure()
	if #self._moList == 0 then
		self:_onClickClose()

		return
	end

	if not self._selectedHeroId then
		return
	end

	local param = {}

	param.isDelete = false
	param.id = 2
	param.type = AirWorkShopEnum.ConditionType.Kill
	param.heroId = self._selectedHeroId

	GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_CONDITION_CHANGE, param)
	self:_onClickClose()
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickClose()
	self:close()
end

return M
