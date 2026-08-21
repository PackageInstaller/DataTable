-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/sort/AirWorkshopSortView.lua

module("logic.extensions.airworkshop.view.sort.AirWorkshopSortView", package.seeall)

local M = class("AirWorkshopSortView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._inputParam = UIComponentType.InputFieldAdapter(self:getGo("air_workshop_sort_view_1093689631"))
	self._btnSort = self:getBtn("2&btn_right_1251431307")
	self._goEmpty = self:getGo("4&empty_unit_-1401348703")
	self._btnToHot = self:getBtn("4&empty_unit_-1492724947")
	self._scroll = self:getUIComponent("air_workshop_sort_view_86130750", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnSort:AddClickListener(self._onClickSort, self)
	self._btnToHot:AddClickListener(self._onClickToHot, self)
end

function M:unbindEvents()
	self._btnSort:RemoveClickListener()
	self._btnToHot:RemoveClickListener()
end

function M:onEnter(reasonTyp)
	local isNormalOpen = not self._viewPresentor:getIsBackOpen() and reasonTyp ~= WindowType.WindowOpenReasonType.QuickOpenType

	self:setEvent(true)

	if isNormalOpen then
		self._sortMapId = nil

		self._inputParam:SetText("")
		self._loopList:ClearCells()
	elseif self._sortMapId then
		AirWorkShopAtkAgent.instance:sendFreeSelectRequest(self._sortMapId)
	end
end

function M:onExit(reasonType)
	local isNormalClose = reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:setEvent(false)

	if isNormalClose then
		self._loopList:ClearCells()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_FREE_SELECT_REPLY, self._handleOnFreeSelectReply, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_FREE_SELECT_REPLY, self._handleOnFreeSelectReply, self)
	end
end

function M:_handleOnFreeSelectReply(e, mapInfo)
	self._moLst = {}

	self._loopList:ClearCells()

	if mapInfo then
		table.insert(self._moLst, mapInfo)
	end

	self:refreshScroll(true)
end

function M:_onClickSort()
	local strParam = self._inputParam:GetText()

	if string.nilorempty(strParam) then
		self._sortMapId = nil

		ToolTipsMgr.showCharacterTopToast(lang("tip_air_level_sort_empty"), CommEnum.CharacterTopToastIcon.Info, 1)

		return
	end

	self._sortMapId = tonumber(strParam)

	AirWorkShopAtkAgent.instance:sendFreeSelectRequest(self._sortMapId)
end

function M:_onClickToHot()
	ViewMgr.instance:open(ViewName.AirWorkShopHotRecommendView)
end

function M:_onCellClickCheck(airMapRecordNO, mapId, airPlayType)
	if not mapId then
		printError("mapId is nil")

		return
	end

	AirWorkShopAtkAgent.instance:sendFreeStartRequest(airPlayType, mapId)
end

function M:refreshScroll(resetPos)
	local len = self._moLst and #self._moLst or 0

	if len > 0 then
		if resetPos then
			self._loopList:ClearCells()
		end

		self._loopList:SetListItemCount(len, resetPos)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
	end

	goutil.setActive(self._goEmpty, len == 0)
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._moLst[curIndex]
	local prefabName = "air_workshop_level_item"
	local item = self._loopList:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, AirWorkshopLevelItemCell)

	shower:updateData(data, AirAtkExtension_pb.AirPlayType.ID)
	shower:setClickCheckFunc(self._onCellClickCheck, self)

	return item
end

return M
