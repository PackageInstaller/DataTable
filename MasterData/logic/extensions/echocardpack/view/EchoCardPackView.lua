-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardPackView.lua

module("logic.extensions.echocardpack.view.EchoCardPackView", package.seeall)

local M = class("EchoCardPackView", ViewComponent)

function M:buildUI()
	self._txtTitle = self:getText("1&middle_tips_common_bg_1539984112")
	self._txtBuyDesc = self:getText("echocard_package_detail_tips_1489059191")
	self._txtOpenDesc = self:getText("echocard_package_detail_tips_2145936225")
	self._imgIcon = self:getImage("echocard_package_detail_tips_972542753")
	self._btnClose = self:getBtn("1&middle_tips_common_bg_-1205189576")
	self._goUse = self:getGo("echocard_package_detail_tips_435980816")
	self._goBuy = self:getGo("echocard_package_detail_tips_-118223468")
	self._goScroll = self:getGo("echocard_package_detail_tips_2019962952")
	self._goItemParent = self:getGo("echocard_package_detail_tips_296307968")
	self._scrollView = LoopListHelper.New(self._goScroll)

	self._scrollView:InitListView(0, self._updateCell, self)

	self._rewardItems = {}
end

function M:destroyUI()
	IconLoader.clearSprite(self._imgIcon)
	self._scrollView:ClearCells()
	self._scrollView:Dispose()

	self._scrollView = nil
	self._rewardItems = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.close, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:_setEvents(add)
	return
end

function M:onEnter()
	local param = self:getOpenParam()

	if not param then
		return
	end

	self._viewType = param[1]

	goutil.setActive(self._goUse, self._viewType == EchoCardPackController.ViewType.Use)
	goutil.setActive(self._goBuy, self._viewType == EchoCardPackController.ViewType.Buy)

	self._itemData = param[2]
	self._goodsMo = param[3]

	if not self._itemData then
		return
	end

	self._poolConfig = EchoCardPackController.instance:getEchoPoolConfig(self._itemData:getItemId())

	if not self._poolConfig then
		return
	end

	self:_updateMoneyView()
	self:_updateView()
end

function M:_updateView()
	if not self._itemData then
		return
	end

	if self._viewType == EchoCardPackController.ViewType.Use then
		local name = self._itemData:getName()

		self._txtTitle.text = langF("tip_backpack_title_use", name)
		self._txtOpenDesc.text = self._poolConfig.description
	else
		self._txtBuyDesc.text = self._itemData:getItemDesc()
		self._txtTitle.text = langF("tip_backpack_title_buy", self._goodsMo:getName())
	end

	self:_setIcon()
	self:_setReward()
end

function M:_setIcon()
	local url = StoreUtil.getEchoCarIconPath(self._itemData:getExtrInfo())

	if self._url ~= url then
		self._url = url

		IconLoader.setSprite(self._imgIcon, IconType.StoreIcon, url)
	end
end

function M:_setReward()
	local groupCodes = EchoCardPackConfig.instance:getEchoPoolGroupCodes(self._poolConfig.code)
	local infos = EchoCardPackConfig.instance:getEchoPoolItemInfos(groupCodes)

	self._curShowList = {}

	for i = 1, #infos do
		local data = ItemUtil.createItemData({
			1,
			itemId = infos[i].itemId
		})
		local info = {
			itemData = data,
			isUp = infos[i].isUp
		}

		table.insert(self._curShowList, info)
	end

	table.sort(self._curShowList, function(itemA, itemB)
		if itemA.isUp ~= itemB.isUp then
			return ItemUtil.sortByBool(itemA.isUp, itemB.isUp)
		end

		if itemA.itemData:getQuality() ~= itemB.itemData:getQuality() then
			return itemA.itemData:getQuality() > itemB.itemData:getQuality()
		end

		return itemA.itemData:getItemId() < itemA.itemData:getItemId()
	end)

	local count = self._curShowList and #self._curShowList or 0

	if self._viewType == EchoCardPackController.ViewType.Use then
		for i = 1, count do
			if not self._rewardItems[i] then
				local go = self:getResInstance(ResName.EchoCardPackViewItem)

				goutil.addChildToParent(go, self._goItemParent)

				local cell = Astral.LuaComponentContainer.Add(go, EchoCardPackViewItem)

				self._rewardItems[i] = cell
			end

			goutil.setActive(self._rewardItems[i]._go, true)
			self._rewardItems[i]:updateData(self._curShowList[i])
		end

		for i = count + 1, #self._rewardItems do
			goutil.setActive(self._rewardItems[i]._go, false)
		end
	else
		self._scrollView:SetListItemCount(count, true)
		self._scrollView:RefreshAllShownItem()
	end
end

function M:_updateCell(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollView:NewListViewItem("echocard_package_item")

	if self._curShowList then
		local info = self._curShowList[curIndex]
		local cell = Astral.LuaComponentContainer.Add(item.gameObject, EchoCardPackViewItem)

		cell:updateData(info)
	end

	return item
end

function M:onExit()
	return
end

function M:_updateMoneyView()
	if self._viewType == EchoCardPackController.ViewType.Use then
		self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, CommEnum.MoneyShowType.DefaultHideType, nil)
	end

	if not self._goodsMo then
		return
	end

	local storeCO = StoreConfig.instance:getStoreCO(self._goodsMo:getStoreId())

	if storeCO then
		self._viewPresentor:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, nil, storeCO.showCoin)
	end
end

return M
