-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/personal/AirWorkShopPersonalSubViewLevel.lua

module("logic.extensions.airworkshop.view.personal.AirWorkShopPersonalSubViewLevel", package.seeall)

local M = class("AirWorkShopPersonalSubViewLevel")

M.EmptyTextLangKey = {
	[AirWorkShopEnum.PersonalPageType.LevelPublish] = "暂无发布的关卡",
	[AirWorkShopEnum.PersonalPageType.LevelLike] = "暂无点赞的关卡",
	[AirWorkShopEnum.PersonalPageType.LevelHistory] = "暂无历史关卡"
}

function M:ctor(compContainer)
	self._registry = ViewElementsRegistry.New(compContainer.gameObject)
end

function M:isPageTypeMatch(pageType)
	return pageType == AirWorkShopEnum.PersonalPageType.LevelPublish or pageType == AirWorkShopEnum.PersonalPageType.LevelLike or pageType == AirWorkShopEnum.PersonalPageType.LevelHistory
end

function M:setActive(active, pageIndex)
	self._isActive = active

	self._loopList:ClearCells()
	goutil.setActive(self:getPageGo(), active)

	if active then
		self:_tryGetNewFormServer(pageIndex)
	end
end

function M:getActive()
	return self._isActive
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	self._goPage = registry:findUIElement("air_workshop_personal_page_view_-156529855")
	self._goEmptyNode = registry:findUIElement("air_workshop_personal_page_view_-813717536")
	self._txtEmptyScroll = registry:findUIElement("air_workshop_personal_page_view_1093978446", UIComponentType.Text)
	self._scroll = registry:findUIElement("air_workshop_personal_page_view_-1145612185", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self:setHandler(nil)

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end

	self._loopList:Dispose()

	self._loopList = nil
	self._moLst = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getPageGo()
	return self._goPage
end

function M:getRegistry()
	return self._registry
end

function M:getIsInMyPage()
	local inMyPage = false
	local handler = self:getHandler()

	if handler then
		inMyPage = handler:getIsInMyPage()
	else
		printError("handler is nil")
	end

	return inMyPage
end

function M:refreshView(msg, pageIndex)
	self._moLst = nil

	if pageIndex == AirWorkShopEnum.PersonalPageType.LevelPublish then
		self._moLst = msg.map
	elseif pageIndex == AirWorkShopEnum.PersonalPageType.LevelLike then
		self._moLst = msg.map
	elseif pageIndex == AirWorkShopEnum.PersonalPageType.LevelHistory then
		self._moLst = msg.map
	end

	self:refreshLoopList()
end

function M:refreshLoopList()
	local moLst = self._moLst or {}
	local len = #moLst

	if len > 0 then
		goutil.setActive(self._scroll.gameObject, true)

		if self._loopList:GetLoopListView().ItemTotalCount ~= len then
			self._loopList:SetListItemCount(len, true)
		else
			self._loopList:RefreshAllShownItem()
		end

		self._scroll.verticalNormalizedPosition = 1
	else
		self._loopList:ClearCells()
		goutil.setActive(self._scroll.gameObject, false)

		local handler = self:getHandler()
		local pageIndex = handler:getPageIndex()

		self._txtEmptyScroll.text = M.EmptyTextLangKey[pageIndex]
	end

	goutil.setActive(self._goEmptyNode, len == 0)
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local handler = self:getHandler()
	local pageIndex = handler:getPageIndex()
	local isMyPage = self:getIsInMyPage()
	local data = self._moLst[curIndex]
	local prefabName = "air_workshop_level_item"
	local item = self._loopList:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, AirWorkshopLevelItemCell)

	shower:setClickEditFunc(nil, nil)
	shower:setClickCheckFunc(nil, nil)

	if pageIndex == AirWorkShopEnum.PersonalPageType.LevelPublish then
		shower:updateDataByLevelPublish(data, AirAtkExtension_pb.AirPlayType.ID)

		if isMyPage then
			shower:setCheckBtnShow(false)
			shower:setEditBtnShow(true)
			shower:setClickEditFunc(self._onCellClickEdit, self)
		else
			shower:setCheckBtnShow(true)
			shower:setEditBtnShow(false)
			shower:setClickCheckFunc(self._onCellClickCheck, self)
		end
	elseif pageIndex == AirWorkShopEnum.PersonalPageType.LevelLike then
		shower:updateData(data, AirAtkExtension_pb.AirPlayType.ID)
		shower:setCheckBtnShow(true)
		shower:setEditBtnShow(false)
		shower:setClickCheckFunc(self._onCellClickCheck, self)
	elseif pageIndex == AirWorkShopEnum.PersonalPageType.LevelHistory then
		shower:updateDataByAirWorkShopRecordMo(AirWorkShopRecordMo.New(data), AirAtkExtension_pb.AirPlayType.ID)
		shower:setCheckBtnShow(true)
		shower:setEditBtnShow(false)
		shower:setClickCheckFunc(self._onCellClickCheck, self)
	end

	return item
end

function M:_tryGetNewFormServer(pageIndex)
	local handler = self:getHandler()
	local userId = handler:getUserId()

	if pageIndex == AirWorkShopEnum.PersonalPageType.LevelPublish then
		AirWorkShopAtkAgent.instance:sendGetCreatedMapPageRequest(userId, 1)
	elseif pageIndex == AirWorkShopEnum.PersonalPageType.LevelLike then
		AirWorkShopAtkAgent.instance:sendGetLikedMapPageRequest(userId, 1)
	elseif pageIndex == AirWorkShopEnum.PersonalPageType.LevelHistory then
		AirWorkShopAtkAgent.instance:sendGetHistoryPageRequest(userId, 1)
	end
end

function M:_onCellClickEdit(dataAnyway, mapId, airPlayType)
	if not mapId then
		printError("mapId is nil")

		return
	end

	AirWorkShopDefMgr.instance:enter(mapId)
end

function M:_onCellClickCheck(dataAnyway, mapId, airPlayType)
	if not mapId then
		printError("mapId is nil")

		return
	end

	AirWorkShopAtkAgent.instance:sendFreeStartRequest(airPlayType, mapId)
end

return M
