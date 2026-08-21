-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoCheckRecordTips.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoCheckRecordTips", package.seeall)

local M = class("AirWorkShopRodeoCheckRecordTips", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._btnExit = self:getBtnByPath("middle_tips_common_bg/clickExit")
	self._scroll = self:getUIComponent("sports_check_record_tips_-1077034103", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._goEmpty = self:getGo("sports_check_record_tips_-302947541")
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnExit:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnExit:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local info = self:getFirstParam() or {}

	self._type = info.type or AirAtkExtension_pb.RecordType.RECORD_ALL
	self._page = 1

	AirWorkShopAtkAgent.instance:sendPlayRecordRequest(self._type, self._page)
end

function M:onExit()
	self:setEvent(false)
	self._loopList:ClearCells()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_QUALIFYING_RECORD_CHANGE, self._handleOnRecordChange, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_QUALIFYING_RECORD_CHANGE, self._handleOnRecordChange, self)
	end
end

function M:_handleOnRecordChange(e)
	local recordMoLst = AirWorkShopRecordModel.instance:getRecordLstByTypeAndPage(self._type, self._page)

	self:refreshLst(recordMoLst, true)
end

function M:_onClickClose()
	self:close()
end

function M:_onCellClickCheck(airWorkShopRecordMo, mapId, airPlayType)
	if not mapId then
		printError("mapId is nil")

		return
	end

	AirWorkShopAtkAgent.instance:sendFreeStartRequest(airPlayType, mapId)
end

function M:refreshLst(moLst, resetPos)
	self._recordMoLst = moLst

	local len = self._recordMoLst and #self._recordMoLst or 0

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

	local data = self._recordMoLst[curIndex]
	local prefabName = "item"
	local item = self._loopList:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(item.gameObject, "air_workshop_level_item").gameObject, AirWorkshopLevelItemCell)
	local hideScore = self._type == AirAtkExtension_pb.RecordType.RECORD_FREE

	shower:updateDataByAirWorkShopRecordMo(data, AirAtkExtension_pb.AirPlayType.RECORD, hideScore)
	shower:setClickCheckFunc(self._onCellClickCheck, self)

	return item
end

return M
