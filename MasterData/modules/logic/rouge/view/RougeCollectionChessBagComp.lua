-- chunkname: @modules/logic/rouge/view/RougeCollectionChessBagComp.lua

module("modules.logic.rouge.view.RougeCollectionChessBagComp", package.seeall)

local RougeCollectionChessBagComp = class("RougeCollectionChessBagComp", BaseView)

function RougeCollectionChessBagComp:onInitView()
	self._golistbag = gohelper.findChild(self.viewGO, "chessboard/#go_listbag")
	self._golistbagitem = gohelper.findChild(self.viewGO, "chessboard/#go_listbag/#go_listbagitem")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_pagearea/#btn_next")
	self._btnlast = gohelper.findChildButtonWithAudio(self.viewGO, "#go_pagearea/#btn_last")
	self._txtcurpage = gohelper.findChildText(self.viewGO, "#go_pagearea/#txt_curpage")
	self._gosizebag = gohelper.findChild(self.viewGO, "chessboard/#go_sizebag")
	self._gosizeitem = gohelper.findChild(self.viewGO, "chessboard/#go_sizebag/#go_sizecollections/#go_sizeitem")
	self._btnlayout = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_layout")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_filter")
	self._gosizecellcontainer = gohelper.findChild(self.viewGO, "chessboard/#go_sizebag/#go_sizecellcontainer")
	self._gosizecell = gohelper.findChild(self.viewGO, "chessboard/#go_sizebag/#go_sizecellcontainer/#go_sizecell")
	self._gosizecollections = gohelper.findChild(self.viewGO, "chessboard/#go_sizebag/#go_sizecellcontainer/#go_sizecollections")
	self._goempty = gohelper.findChild(self.viewGO, "chessboard/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionChessBagComp:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnlast:AddClickListener(self._btnlastOnClick, self)
	self._btnlayout:AddClickListener(self._btnlayoutOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
end

function RougeCollectionChessBagComp:removeEvents()
	self._btnnext:RemoveClickListener()
	self._btnlast:RemoveClickListener()
	self._btnlayout:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
end

function RougeCollectionChessBagComp:_btnnextOnClick()
	self:switchPage(true)
end

function RougeCollectionChessBagComp:_btnlastOnClick()
	self:switchPage(false)
end

function RougeCollectionChessBagComp:_btnlayoutOnClick()
	self:onSwitchLayoutType(not self._isListLayout)
	self:playSwitchLayoutAnim()
	RougeCollectionChessController.instance:closeCollectionTipView()
end

function RougeCollectionChessBagComp:_btnfilterOnClick()
	RougeCollectionChessController.instance:closeCollectionTipView()

	local params = {
		confirmCallback = self.onConfirmTagFilterCallback,
		confirmCallbackObj = self,
		baseSelectMap = self._baseTagSelectMap,
		extraSelectMap = self._extraTagSelectMap
	}

	RougeController.instance:openRougeCollectionFilterView(params)
end

function RougeCollectionChessBagComp:onConfirmTagFilterCallback(baseTagMap, extraTagMap)
	self:onFilterCollectionBag(baseTagMap, extraTagMap)
	self:refreshFilterButtonUI()
end

function RougeCollectionChessBagComp:_editableInitView()
	self._sizeCollections = {}
	self._sizePlaceCollectionCache = {}
	self._listCollections = {}
	self._isListLayout = true
	self._baseTagSelectMap = {}
	self._extraTagSelectMap = {}

	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.UpdateCollectionBag, self.updateCollectionBag, self)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	gohelper.setActive(self._golistbagitem, false)
	gohelper.setActive(self._gosizeitem, false)
end

function RougeCollectionChessBagComp:onOpen()
	self._curPageIndex = 1

	self:buildCollectionSizeBagPlaceInfo()
	self:onSwitchLayoutType(true)
end

local listCountPerPage = 4

function RougeCollectionChessBagComp:updateBagList(pageIndex, totalPageCount)
	pageIndex = pageIndex or 0
	totalPageCount = totalPageCount or 0

	local collections = RougeCollectionBagListModel.instance:getList()
	local collectionCount = collections and #collections
	local useMap = {}

	if collectionCount > 0 then
		local startIndex = (pageIndex - 1) * listCountPerPage + 1
		local endIndex = pageIndex * listCountPerPage

		endIndex = collectionCount < endIndex and collectionCount or endIndex

		if startIndex <= endIndex then
			for i = startIndex, endIndex do
				local collectionMO = RougeCollectionBagListModel.instance:getByIndex(i)
				local useItemIndex = i - startIndex + 1
				local collectionItem = self._listCollections[useItemIndex]

				if not collectionItem then
					local collectionGO = gohelper.cloneInPlace(self._golistbagitem, "bagItem_" .. useItemIndex)

					collectionItem = RougeCollectionBagItem.New()

					collectionItem:onInitView(self, collectionGO)

					self._listCollections[useItemIndex] = collectionItem
				end

				collectionItem:reset()
				collectionItem:onUpdateMO(collectionMO)

				useMap[collectionItem] = true
			end
		end
	end

	if useMap and self._listCollections then
		for _, collectionItem in pairs(self._listCollections) do
			if not useMap[collectionItem] then
				collectionItem:reset()
			end
		end
	end

	self._curPageIndex = pageIndex
	self._txtcurpage.text = string.format("%s / %s", pageIndex, totalPageCount)
end

function RougeCollectionChessBagComp:switchPage(isNext)
	if isNext then
		if not (self._curPageIndex + 1) then
			local targetPageIndex = self._curPageIndex - 1
			local totalPageCount = self:getTotalPageCount()
			local minPageIndex = totalPageCount > 0 and 1 or 0

			targetPageIndex = Mathf.Clamp(targetPageIndex, minPageIndex, totalPageCount)

			if targetPageIndex == self._curPageIndex then
				return
			end

			if self._isListLayout then
				self:updateBagList(targetPageIndex, totalPageCount)
			else
				self:updateSizeList(targetPageIndex, totalPageCount)
			end

			self:refreshButtonUI(targetPageIndex, minPageIndex, totalPageCount)
			self:playSwitchLayoutAnim()
			RougeCollectionChessController.instance:closeCollectionTipView()
		end
	end
end

function RougeCollectionChessBagComp:getTotalPageCount()
	return self._isListLayout and math.ceil(RougeCollectionBagListModel.instance:getCount() / listCountPerPage) or tabletool.len(self._sizePlaceCollectionCache)
end

function RougeCollectionChessBagComp:updateSizeList(pageIndex, totalPageCount)
	self._curPageIndex = pageIndex

	self:placeCollection2SizeBag(pageIndex)

	self._txtcurpage.text = string.format("%s / %s", pageIndex, totalPageCount)
end

function RougeCollectionChessBagComp:buildCollectionSizeBagPlaceInfo()
	local originCollections = RougeCollectionBagListModel.instance:getList()

	self._unplaceCollections = tabletool.copy(originCollections)

	table.sort(self._unplaceCollections, self.sortCollectionByRare)

	local pageIndex = 1

	self._sizePlaceCollectionCache = {}

	local errorBreakCount = 200
	local startPlacePos = Vector2(0, 0)

	while #self._unplaceCollections > 0 and errorBreakCount > 0 do
		self:buildPlaceCollectionInfo(startPlacePos, RougeEnum.MaxCollectionBagSize, self._unplaceCollections, pageIndex)

		pageIndex = pageIndex + 1
		errorBreakCount = errorBreakCount - 1
	end

	if errorBreakCount <= 0 then
		logError("构建肉鸽造物背包摆放数据时循环执行超过< %s >次,请检查!!!", errorBreakCount)
	end
end

function RougeCollectionChessBagComp:buildPlaceCollectionInfo(startPlacePos, bagSize, collections, pageIndex, index)
	index = index or 1

	if not collections or not collections[index] or bagSize.x < 1 or bagSize.y < 1 then
		return
	end

	local readyPlaceCollection = collections[index]
	local collectionWidth, collectionHeight = RougeCollectionConfig.instance:getShapeSize(readyPlaceCollection.cfgId)

	if collectionWidth <= 0 or collectionHeight <= 0 then
		table.remove(collections, index)
		logError("获取造物形状范围不可小于0, id = " .. tostring(readyPlaceCollection.cfgId))

		return
	end

	if collectionWidth > bagSize.x or collectionHeight > bagSize.y then
		return self:buildPlaceCollectionInfo(startPlacePos, bagSize, collections, pageIndex, index + 1)
	end

	table.remove(collections, index)

	self._sizePlaceCollectionCache[pageIndex] = self._sizePlaceCollectionCache[pageIndex] or {}

	table.insert(self._sizePlaceCollectionCache[pageIndex], {
		id = readyPlaceCollection.id,
		startPlacePos = startPlacePos
	})

	local splitY = bagSize.y - collectionHeight
	local splitX = bagSize.x - collectionWidth
	local newBagSizeA = Vector2(splitX, collectionHeight)
	local newBagSizeB = Vector2(bagSize.x, splitY)
	local newBagStartPlacePosA = startPlacePos + Vector2(collectionWidth, 0)
	local newBagStartPlacePosB = startPlacePos + Vector2(0, collectionHeight)

	self:buildPlaceCollectionInfo(newBagStartPlacePosA, newBagSizeA, collections, pageIndex)
	self:buildPlaceCollectionInfo(newBagStartPlacePosB, newBagSizeB, collections, pageIndex)
end

local realSlotCellSize = Vector2(104, 104)

function RougeCollectionChessBagComp:placeCollection2SizeBag(pageIndex)
	if self._sizePlaceCollectionCache then
		local infos = self._sizePlaceCollectionCache[pageIndex]
		local useMap = {}

		if infos then
			for index = 1, #infos do
				local collectionItem = self._sizeCollections[index]

				if not collectionItem then
					local luaObjPool = self.viewContainer:getRougePoolComp()

					collectionItem = luaObjPool:getCollectionItem(RougeCollectionSizeBagItem.__cname)

					local collectionGO = gohelper.cloneInPlace(self._gosizeitem, "item_" .. index)

					collectionItem:onInit(collectionGO)

					self._sizeCollections[index] = collectionItem
				end

				useMap[collectionItem] = true

				local collectionMO = RougeCollectionModel.instance:getCollectionByUid(infos[index].id)

				collectionItem:reset()
				collectionItem:setPerCellWidthAndHeight(realSlotCellSize.x, realSlotCellSize.y)
				collectionItem:onUpdateMO(collectionMO)

				local startPlacePos = infos[index].startPlacePos

				recthelper.setAnchor(collectionItem.viewGO.transform, startPlacePos.x * realSlotCellSize.x, -startPlacePos.y * realSlotCellSize.y)
			end
		end

		if useMap and self._sizeCollections then
			for _, collectionItem in pairs(self._sizeCollections) do
				if not useMap[collectionItem] then
					collectionItem:reset()
				end
			end
		end
	end
end

function RougeCollectionChessBagComp:onSwitchLayoutType(isListLayout)
	self._isListLayout = isListLayout

	local totalPageCount = self:getTotalPageCount()
	local minPageIndex = totalPageCount > 0 and 1 or 0

	gohelper.setActive(self._golistbag, self._isListLayout)
	gohelper.setActive(self._gosizebag, not self._isListLayout)
	gohelper.setActive(self._goempty, totalPageCount <= 0)

	self._curPageIndex = Mathf.Clamp(self._curPageIndex, minPageIndex, totalPageCount)

	if self._isListLayout then
		self:updateBagList(self._curPageIndex, totalPageCount)
	else
		self:updateSizeList(self._curPageIndex, totalPageCount)
	end

	self:refreshButtonUI(self._curPageIndex, minPageIndex, totalPageCount)
	self:refreshLayoutButtonUI()
end

function RougeCollectionChessBagComp:refreshButtonUI(curPageIndex, minPageIndex, maxPageIndex)
	local nextLightBtn = gohelper.findChild(self._btnnext.gameObject, "light")
	local nextLightDark = gohelper.findChild(self._btnnext.gameObject, "dark")
	local lastLightBtn = gohelper.findChild(self._btnlast.gameObject, "light")
	local lastLightDark = gohelper.findChild(self._btnlast.gameObject, "dark")
	local isCanNext = maxPageIndex >= curPageIndex + 1
	local isCanLast = minPageIndex <= curPageIndex - 1

	gohelper.setActive(nextLightBtn, isCanNext)
	gohelper.setActive(nextLightDark, not isCanNext)
	gohelper.setActive(lastLightBtn, isCanLast)
	gohelper.setActive(lastLightDark, not isCanLast)
end

function RougeCollectionChessBagComp:playSwitchLayoutAnim()
	local animStateName = self._isListLayout and "switch_listbg" or "switch_sizebag"

	self._animator:Play(animStateName, 0, 0)
end

function RougeCollectionChessBagComp.sortCollectionByRare(a, b)
	local aCfg = RougeCollectionConfig.instance:getCollectionCfg(a.cfgId)
	local bCfg = RougeCollectionConfig.instance:getCollectionCfg(b.cfgId)

	if aCfg.showRare ~= bCfg.showRare then
		return aCfg.showRare > bCfg.showRare
	end

	return aCfg.id < bCfg.id
end

function RougeCollectionChessBagComp:onFilterCollectionBag(baseTagMap, extraTagMap)
	RougeCollectionBagListModel.instance:onInitData(baseTagMap, extraTagMap)
	self:updateCollectionBag()
end

function RougeCollectionChessBagComp:updateCollectionBag()
	RougeCollectionBagListModel.instance:filterCollection()
	self:buildCollectionSizeBagPlaceInfo()
	self:onSwitchLayoutType(self._isListLayout)
end

function RougeCollectionChessBagComp:refreshFilterButtonUI()
	local isFiltering = RougeCollectionBagListModel.instance:isFiltering()
	local goUnselect = gohelper.findChild(self._btnfilter.gameObject, "unselect")
	local goSelect = gohelper.findChild(self._btnfilter.gameObject, "select")

	gohelper.setActive(goSelect, isFiltering)
	gohelper.setActive(goUnselect, not isFiltering)
end

function RougeCollectionChessBagComp:refreshLayoutButtonUI()
	local goUnselect = gohelper.findChild(self._btnlayout.gameObject, "unselect")
	local goSelect = gohelper.findChild(self._btnlayout.gameObject, "select")

	gohelper.setActive(goSelect, not self._isListLayout)
	gohelper.setActive(goUnselect, self._isListLayout)
end

function RougeCollectionChessBagComp:onClose()
	return
end

function RougeCollectionChessBagComp:onDestroyView()
	if self._listCollections then
		for _, list in pairs(self._listCollections) do
			list:destroy()
		end
	end

	if self._sizeCollections then
		for _, list in pairs(self._sizeCollections) do
			list:destroy()
		end
	end
end

return RougeCollectionChessBagComp
