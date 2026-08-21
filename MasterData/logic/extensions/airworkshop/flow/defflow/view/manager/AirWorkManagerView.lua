-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/manager/AirWorkManagerView.lua

module("logic.extensions.airworkshop.flow.defflow.view.manager.AirWorkManagerView", package.seeall)

local M = class("AirWorkManagerView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._panelGo = self:getGo("air_workshop_level_manage_view_84320315")
	self._scrollRectGo = self:getGo("air_workshop_level_manage_view_86130750")
	self._loopGridView = LoopGridViewHelper.New(self._scrollRectGo)

	self._loopGridView:InitGridView(0, self._updateCell, self)
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
	GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_MANAGER_RIGHT_UPDATE, self._refresh, self)
	GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_MANAGER_STATUS_UPDATE, self._onlineStatus, self)
	GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_MANAGER_DELETE, self._onDelete, self)
	AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_GET_MAPLIST_DONE, self._onGetMapListDone, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
	GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_MANAGER_RIGHT_UPDATE, self._refresh, self)
	GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_MANAGER_STATUS_UPDATE, self._onlineStatus, self)
	GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_MANAGER_DELETE, self._onDelete, self)
	AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_GET_MAPLIST_DONE, self._onGetMapListDone, self)
end

function M:onEnter()
	self._isEnter = true

	AirWorkShopDefAgent.instance:sendGetAirMapListRequest()
	AirWorkMapModel.instance:requestSelfLevelImages()
	self:_bindEvents()
	goutil.setActive(self._panelGo, false)
	self:_setListContent()
end

function M:_setListContent()
	self._clickIndex = 0
	self._itemView = {}

	self:_getGuanQiaData()
	self:_fixLoopGrid()
	self:_setData()

	local lastLevelMo = AirWorkShopModel.instance:getLastEditLevelMo()

	if not lastLevelMo then
		for i, v in ipairs(self._moList) do
			if v.data then
				lastLevelMo = v.data

				break
			end
		end
	end

	if lastLevelMo then
		settimer(0.1, function()
			for i, v in ipairs(self._itemView) do
				v:selectClick(lastLevelMo)
			end
		end, self, false)
	end
end

function M:onExit()
	self._isEnter = false

	self:_unbindEvents()
	AirWorkBattleResultController.instance:clearResultData()
	GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_MANAGER_EXIT)
end

function M:destroyUI()
	return
end

function M:_onGetMapListDone()
	self:_setListContent()
end

function M:_refreshRedDot()
	if not self._isEnter then
		return
	end

	for i, v in pairs(self._itemView) do
		v:refreshRedDot()
	end
end

function M:_getGuanQiaData()
	local maxCount = AirWorkMapModel.instance:getPlanCount()
	local maxUnLockCount = AirWorkMapModel.instance:getCurUnlockPlanCount()

	self._moList = {}

	for i = 1, maxCount do
		local mo = {}

		mo.itemIndex = i
		mo.unLock = false
		mo.created = false
		mo.data = nil

		local isCreate, levelMo = self:_isCreate(i)

		if isCreate then
			mo.unLock = true
			mo.created = true
			mo.data = levelMo
		elseif i <= maxUnLockCount then
			mo.unLock = true
		end

		table.insert(self._moList, mo)
	end
end

function M:_isCreate(index)
	local isCreate = false
	local levelMo
	local leveMoDic = AirWorkMapModel.instance:getAllLevelMO()

	for k, v in pairs(leveMoDic) do
		-- block empty
	end

	for k, v in pairs(leveMoDic) do
		if index == v:getIndex() then
			isCreate = true
			levelMo = v

			break
		end
	end

	return isCreate, levelMo
end

function M:_setData()
	self._itemView = {}

	local itemCount = #self._moList

	self._loopGridView:SetListItemCount(itemCount)
	self._loopGridView:RefreshAllShownItem()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopGridView:NewListViewItem("air_workshop_level_grid_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkManageItem)
	local mo = self._moList[curIndex]

	itemView:updateData(mo)
	itemView:setSeleted(curIndex == self._clickIndex)
	table.insert(self._itemView, itemView)

	return item
end

function M:_refresh(e, mo)
	if not mo.created then
		return
	end

	goutil.setActive(self._panelGo, mo.created)

	if mo.created then
		local panelView = Astral.LuaComponentContainer.Add(self._panelGo, AirWorkManagePanel)

		panelView:updateData(mo.data)
	end

	for i, v in ipairs(self._moList) do
		if mo.itemIndex == v.itemIndex then
			self._clickIndex = i
		end
	end

	self._itemView = {}

	self._loopGridView:RefreshAllShownItem()
end

function M:_onlineStatus(e, params)
	self:_getGuanQiaData()
	self:_refresh(nil, self._moList[self._clickIndex])
end

function M:_onDelete(e, params)
	AirWorkShopModel.instance:clearLastEditLevelMo()
	goutil.setActive(self._panelGo, false)
	self:_setListContent()
end

function M:_fixLoopGrid()
	local loopGridView = self._loopGridView:GetLoopGridView()

	GridAdaptUtil.fixLoopGridCount(loopGridView)
end

return M
