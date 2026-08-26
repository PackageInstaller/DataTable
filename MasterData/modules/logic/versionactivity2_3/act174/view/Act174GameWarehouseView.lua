-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174GameWarehouseView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174GameWarehouseView", package.seeall)

local Act174GameWarehouseView = class("Act174GameWarehouseView", BaseView)

function Act174GameWarehouseView:onInitView()
	self._goEditTeam = gohelper.findChild(self.viewGO, "#go_EditTeam")
	self._goWarehouse = gohelper.findChild(self.viewGO, "go_Warehouse")
	self._goWareItemRoot = gohelper.findChild(self.viewGO, "go_Warehouse/go_WareItemRoot")
	self._btnLastPage = gohelper.findChildButtonWithAudio(self.viewGO, "go_Warehouse/btn_LastPage")
	self._txtPage = gohelper.findChildText(self.viewGO, "go_Warehouse/Page/txt_Page")
	self._btnNextPage = gohelper.findChildButtonWithAudio(self.viewGO, "go_Warehouse/btn_NextPage")
	self._btnHeroBage = gohelper.findChildButtonWithAudio(self.viewGO, "go_Warehouse/btn_HeroBag")
	self._btnCollectionBag = gohelper.findChildButtonWithAudio(self.viewGO, "go_Warehouse/btn_CollectionBag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174GameWarehouseView:addEvents()
	self.addClickCb(self, self._btnCollectionBag, self._btnCollectionBagOnClick, self)
	self.addClickCb(self, self._btnHeroBage, self._btnHeroBageOnClick, self)
	self.addClickCb(self, self._btnLastPage, self._btnLastPageOnClick, self)
	self.addClickCb(self, self._btnNextPage, self._btnNextPageOnClick, self)
end

function Act174GameWarehouseView:_btnCollectionBagOnClick()
	if self.wareType == Activity174Enum.WareType.Collection then
		return
	end

	self.animWareHouse:Play("switch", 0, 0)
	gohelper.setActive(self.goBtnHeroS, false)
	gohelper.setActive(self.goBtnHeroU, true)
	gohelper.setActive(self.goBtnCollectionS, true)
	gohelper.setActive(self.goBtnCollectionU, false)

	self.wareType = Activity174Enum.WareType.Collection

	local wareDatas = self.wareHouseMo:getItemData()

	self.maxPage = math.ceil(#wareDatas / self.maxWareCnt)

	self:setPage(1)
	TaskDispatcher.cancelTask(self.refreshWareItem, self)
	TaskDispatcher.runDelay(self.refreshWareItem, self, 0.16)
	Activity174Controller.instance:dispatchEvent(Activity174Event.WareHouseTypeChange, self.wareType)
end

function Act174GameWarehouseView:_btnHeroBageOnClick()
	if self.wareType == Activity174Enum.WareType.Hero then
		return
	end

	self.animWareHouse:Play("switch", 0, 0)
	gohelper.setActive(self.goBtnHeroS, true)
	gohelper.setActive(self.goBtnHeroU, false)
	gohelper.setActive(self.goBtnCollectionS, false)
	gohelper.setActive(self.goBtnCollectionU, true)

	self.wareType = Activity174Enum.WareType.Hero

	local wareDatas = self.wareHouseMo:getHeroData()

	self.maxPage = math.ceil(#wareDatas / self.maxWareCnt)

	self:setPage(1)
	TaskDispatcher.cancelTask(self.refreshWareItem, self)
	TaskDispatcher.runDelay(self.refreshWareItem, self, 0.16)
	Activity174Controller.instance:dispatchEvent(Activity174Event.WareHouseTypeChange, self.wareType)
end

function Act174GameWarehouseView:_btnLastPageOnClick()
	if self.curPage - 1 < 1 then
		return
	end

	self.animWareHouse:Play("switch", 0, 0)
	self:setPage(self.curPage - 1)
	TaskDispatcher.cancelTask(self.refreshWareItem, self)
	TaskDispatcher.runDelay(self.refreshWareItem, self, 0.16)
end

function Act174GameWarehouseView:_btnNextPageOnClick()
	if self.curPage + 1 > self.maxPage then
		return
	end

	self.animWareHouse:Play("switch", 0, 0)
	self:setPage(self.curPage + 1)
	TaskDispatcher.cancelTask(self.refreshWareItem, self)
	TaskDispatcher.runDelay(self.refreshWareItem, self, 0.16)
end

function Act174GameWarehouseView:updateWareHouseInfo()
	self.wareHouseMo = self.gameInfo:getWarehouseInfo()

	local wareDatas

	self.maxPage = math.ceil(#(self.wareType == Activity174Enum.WareType.Hero and self.wareHouseMo:getHeroData() or self.wareHouseMo:getItemData()) / self.maxWareCnt)

	self:setPage(self.curPage)
	self:refreshWareItem(true)
end

function Act174GameWarehouseView:_editableInitView()
	self.maxWareCnt = Activity174Enum.MaxWareItemSinglePage
	self.goware = gohelper.findChild(self._goWareItemRoot, "ware")
	self.goBtnHeroS = gohelper.findChild(self._btnHeroBage.gameObject, "select")
	self.goBtnHeroU = gohelper.findChild(self._btnHeroBage.gameObject, "unselect")
	self.goBtnCollectionS = gohelper.findChild(self._btnCollectionBag.gameObject, "select")
	self.goBtnCollectionU = gohelper.findChild(self._btnCollectionBag.gameObject, "unselect")
	self.goBtnLastL = gohelper.findChild(self._btnLastPage.gameObject, "lock")
	self.goBtnNextL = gohelper.findChild(self._btnNextPage.gameObject, "lock")
	self.animWareHouse = self._goWarehouse:GetComponent(gohelper.Type_Animator)

	self:initWareItem()
end

function Act174GameWarehouseView:onOpen()
	self.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	self.wareHouseMo = self.gameInfo:getWarehouseInfo()

	self:_btnHeroBageOnClick()
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.UpdateGameInfo, self.updateWareHouseInfo, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.BuyInShopReply, self.updateWareHouseInfo, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.ChangeLocalTeam, self.onChangeLocalTeam, self)
end

function Act174GameWarehouseView:onClose()
	self.removeEventCb(self, Activity174Controller.instance, Activity174Event.UpdateGameInfo, self.updateWareHouseInfo, self)
	self.removeEventCb(self, Activity174Controller.instance, Activity174Event.BuyInShopReply, self.updateWareHouseInfo, self)
	self.removeEventCb(self, Activity174Controller.instance, Activity174Event.ChangeLocalTeam, self.onChangeLocalTeam, self)
end

function Act174GameWarehouseView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshWareItem, self)
	self.wareHouseMo:clearNewSign()
end

function Act174GameWarehouseView:initWareItem()
	self.wareItemList = {}

	for i = 1, self.maxWareCnt do
		local go = gohelper.clone(self.goware, self._goWareItemRoot, "wareItem" .. i)

		self.wareItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act174GameWareItem, self)

		self.wareItemList[i]:setIndex(i)
	end
end

function Act174GameWarehouseView:refreshWareItem(isNew)
	local wareDatas

	if self.wareType == Activity174Enum.WareType.Hero then
		wareDatas = self.wareHouseMo:getHeroData()
	elseif self.wareType == Activity174Enum.WareType.Collection then
		wareDatas = self.wareHouseMo:getItemData()
	end

	self.curPageWareDatas = self:calculateCurPage(wareDatas)

	for i = 1, self.maxWareCnt do
		local wareData = self.curPageWareDatas[i]

		self.wareItemList[i]:setData(wareData, self.wareType)
	end

	local newIdDic = self.wareHouseMo:getNewIdDic(self.wareType)

	if newIdDic and next(newIdDic) then
		for i = self.maxWareCnt, 1, -1 do
			local wareData = self.curPageWareDatas[i]

			if wareData then
				local id = wareData.id
				local wareItem = self.wareItemList[i]

				if newIdDic[id] and newIdDic[id] ~= 0 then
					newIdDic[id] = newIdDic[id] - 1

					wareItem:setNew(true)

					if isNew then
						wareItem:playNew()
					end
				end
			end
		end
	end
end

function Act174GameWarehouseView:calculateCurPage(wareDatas)
	local curPageWareIds = {}
	local startNum = (self.curPage - 1) * self.maxWareCnt + 1
	local endNum = startNum + self.maxWareCnt - 1

	endNum = endNum > #wareDatas and #wareDatas or endNum

	for i = startNum, endNum do
		table.insert(curPageWareIds, wareDatas[i])
	end

	return curPageWareIds
end

function Act174GameWarehouseView:onChangeLocalTeam()
	self:refreshWareItem()
end

function Act174GameWarehouseView:setPage(page)
	self.curPage = page
	self._txtPage.text = self.curPage

	gohelper.setActive(self.goBtnLastL, self.curPage <= 1)
	gohelper.setActive(self.goBtnNextL, self.curPage >= self.maxPage)
end

return Act174GameWarehouseView
