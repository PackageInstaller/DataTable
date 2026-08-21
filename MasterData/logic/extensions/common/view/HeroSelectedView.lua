-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/HeroSelectedView.lua

module("logic.extensions.common.view.HeroSelectedView", package.seeall)

local M = class("HeroSelectedView", ViewComponent)

function M:buildUI()
	self._loopList = LoopListHelper.New(self:getGo("role_select_tips_-1770495577"))

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._btnConfirm = self:getBtn("role_select_tips_1020278346")
	self._btnCancel = self:getBtn("role_select_tips_-420470112")
	self._itemList = {}
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
	self._btnConfirm = nil
	self._btnCancel = nil
	self._itemList = nil
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickBtnConfirm, self)
	self._btnCancel:AddClickListener(self._onClickBtnCancel, self)
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function M:onEnter()
	self._paramData = self:getFirstParam() or {}

	local idList = self._paramData.heroIdList or {}

	self._loopList:SetListItemCount(#idList, true)
	self:_setSelectedHero(self._paramData.selectedHero)
end

function M:onExit()
	for _, item in ipairs(self._itemList) do
		item:unbindEvents()
	end

	self._loopList:ClearCells()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("hero_item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, HeroHeadItem)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, HeroHeadItem)

		shower:setHandler(self)
		shower:setNameTxtColor("#000000")
		table.insert(self._itemList, shower)
	end

	local heroId = self._paramData.heroIdList[curIndex]
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	shower:setHeroMO(heroMO)
	shower:showName(true)
	shower:setSelected(self._selectedHeroId and self._selectedHeroId == heroId)
	shower:bindEvents()

	return item
end

function M:_setSelectedHero(heroId)
	self._selectedHeroId = heroId

	self._loopList:RefreshAllShownItem()
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

function M:_onClickBtnConfirm()
	if self._paramData.confirmCallback then
		self._paramData.confirmCallback(self._paramData.confirmTarget, self._selectedHeroId)
	end

	self:close()
end

function M:_onClickBtnCancel()
	self:close()
end

return M
