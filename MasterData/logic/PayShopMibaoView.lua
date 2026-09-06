-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayShopMibaoView.lua

module("logic.extensions.payshop.view.PayShopMibaoView", package.seeall)

local PayShopMibaoView = class("PayShopMibaoView", ViewComponent)
local CellPrefabTag = {
	SellPet = 2,
	Normal = 1
}

function PayShopMibaoView:ctor()
	PayShopMibaoView.super.ctor(self)

	self.currTabIndex = 1
	self._currTabData = nil
	self.Vector2Temp = Vector2.New(0, 0)
	self._lineBgList = {}
end

function PayShopMibaoView:buildUI()
	PayShopMibaoView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollRect = self._tableviewGo:GetComponent(ComponentType.ScrollRect)
	self.scrollViewTr = self._tableviewGo.transform
	self._timeText = goutil.findChildTextComponent(self.mainGO, "timeText")
	self._conVip = self:getGo("conVip")
	self._emptyGo = self:getGo("emptyGo")
	self._txtEmpty = self:getTxt("emptyGo/txtEmpty")
	self._btnClear = self:getBtn("searchpart/btnClear")
	self._inputComp = self:getInput("searchpart/search")
	self._searchpartGo = self:getGo("searchpart")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(function()
		self:_onReloadFinish()
	end)
	self._scrollerList:setTagCell(self:getGo("tablecell"), CellPrefabTag.Normal)
	self._scrollerList:setTagCell(self:getGo("sellPetcell"), CellPrefabTag.SellPet)
	self._scrollerList:regGetTagByIdx(function(data, idx)
		return self:_getCellTag(data)
	end)
end

function PayShopMibaoView:bindEvents()
	PayShopMibaoView.super.bindEvents(self)
	self._btnClear:AddClickListener(self._onClickbtnClear, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
end

function PayShopMibaoView:unbindEvents()
	PayShopMibaoView.super.unbindEvents(self)
	self._btnClear:RemoveClickListener()
	self._inputComp:RemoveOnValueChanged()
end

function PayShopMibaoView:destroyUI()
	PayShopMibaoView.super.destroyUI(self)

	self._lineBgList = {}
end

function PayShopMibaoView:onEnter()
	PayShopMibaoView.super.onEnter(self)

	self._isLimitTimeTab = false
	self._isFirstLoadData = true
	self._skinSortId = false
	self._sellKey = nil

	self.addGEvent(self, PayShopModel.ChangeMibaoShopBuyTimes, self._updateGoodsView, self)
	self.addGEvent(self, PayShopModel.GetAllPayShopBuyTimesRes, self._initTabData, self)
	self.addGEvent(self, PayAgent.NotifyPayResultRes, self._payResultRes, self)
	self.addGEvent(self, GlobalNotify.PayShopSkinSortId, self._sortSkinDatasView, self)
	self._inputComp:SetText(PayShopModel.instance:getPetSearchStr())
	self:_initTabData(true)
	LocalUserDataController.instance:doCallbackWhenWeekFirst("PayShopMibaoView", function()
		return
	end)
end

function PayShopMibaoView:onExit()
	PayShopMibaoView.super.onExit(self)
	self._scrollerList:dispose()

	self._isFirstLoadData = false
	self._sellKey = nil

	self:_stopHuodongTimer()
	self.mainGO.transform:SetParent(nil)
	UIStateManager.instance:popByName(ViewName.PayshopsortpetskinpartView)
end

function PayShopMibaoView:_updateGoodsView(needLocationGoods)
	if self._currTabData then
		self._curViewDatas = self:_onGetRealViewData()
	else
		self._curViewDatas = {}

		local tabDatas = PayShopModel.instance:getMibaoTabData()

		for i, v in ipairs(tabDatas) do
			local temp = PayShopModel.instance:getMiBaoGoodDatasByTabId(checknumber(v.param))

			for _, v1 in ipairs(temp) do
				table.insert(self._curViewDatas, {
					goodsData = v1
				})
			end
		end
	end

	self._oriCurViewDatas = self._curViewDatas

	self:_sortViewDatasAndReload(needLocationGoods)
end

function PayShopMibaoView:_sortViewDatasAndReload(needLocationGoods)
	if needLocationGoods and self._locationGoodsId > 0 then
		self._locationGoodsIdOnce = self._locationGoodsId
	end

	self:_trySortViewDatas()
	self:_setCellOffset()
	self:_checkViewDatasEmpty()

	self._prefilterCurViewDatas = self._curViewDatas

	self:_filterBySearchText()
	self._scrollerList:reloadData(self._curViewDatas)
end

function PayShopMibaoView:_getCellTag(data)
	if self:_isSellPetView() then
		return CellPrefabTag.SellPet
	else
		return CellPrefabTag.Normal
	end
end

function PayShopMibaoView:_updateCell(view, cell, data)
	local tag = self:_getCellTag(data)

	if tag == CellPrefabTag.SellPet then
		self:_updateSellPetCell(view, cell, data)
	else
		self:_updateNorCell(view, cell, data)
	end
end

function PayShopMibaoView:_updateNorCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopMibaoGoodsItem)

	component:onEnter(self, self._scrollRect, data, self._isLimitTimeTab)
	self:_autoDoClickBuy(data, component)
end

function PayShopMibaoView:_updateSellPetCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopSellPetGoodsItem)

	component:onEnter(self, self._scrollRect, data, self._isLimitTimeTab)
	self:_autoDoClickBuy(data, component)
end

function PayShopMibaoView:_autoDoClickBuy(data, component)
	if self._autoClickBuyTimeMs and self._autoClickBuyGoodsId then
		if ServerTime.nowMs() - self._autoClickBuyTimeMs <= 500 then
			if self._autoClickBuyGoodsId == data.goodsData.id then
				component:_onClickBuy(false)

				self._autoClickBuyGoodsId = nil
				self._autoClickBuyTime = nil
			end
		else
			self._autoClickBuyGoodsId = nil
			self._autoClickBuyTime = nil
		end
	end
end

function PayShopMibaoView:_clearCell(cell)
	local component = GameUtil.GetLua(cell.gameObject, PayShopMibaoGoodsItem)

	if component then
		component:onExit()
	else
		component = GameUtil.GetLua(cell.gameObject, PayShopSellPetGoodsItem)

		if component then
			component:onExit()
		end
	end
end

function PayShopMibaoView:_initTabData(needLocationGoods)
	local openParams = self:getOpenParam() or {}

	self._showType = checknumber(openParams[1])
	self._currTabData = self._showType ~= 0 and openParams[2]
	self._locationGoodsId = checknumber(openParams[3])

	self:_updateView(needLocationGoods)
end

function PayShopMibaoView:_updateView(needLocationGoods)
	self._isLimitTimeTab = self._currTabData and not string.nilorempty(self._currTabData.startTime) and not string.nilorempty(self._currTabData.endTime)
	self._sellKey = self._currTabData and self._currTabData.sellKey

	self:_tryOpenSkinSortPanel()
	self:_updateGoodsView(needLocationGoods)
	self:_updateTitleStatus()
	self:_updateTopSearchView()
end

function PayShopMibaoView:_updateTopSearchView()
	local isOpenVip = not not (self._currTabData and (self._currTabData.jumpInTag == "GodDiamond" or self._currTabData.jumpInTag == "Recharge" or self._currTabData.jumpInTag == "Fuzhuang"))

	if isOpenVip then
		self:showTabAt(self._conVip, ViewName.ViplvView)
	end

	goutil.setActive(self._searchpartGo, not isOpenVip)

	local width = isOpenVip and 375 or 422
	local posY = isOpenVip and -295 or -248

	GameUtil.setHeight(self._tableviewGo, width)
	Framework.TransformUtil.SetAnchoredPos(self.scrollViewTr, 243, posY)
end

function PayShopMibaoView:_updateTitleStatus()
	self._timeText.text = ""

	self:_stopHuodongTimer()

	if self._currTabData and not string.nilorempty(self._currTabData.startTime) and not string.nilorempty(self._currTabData.endTime) then
		local hasDifferent = false

		if self._curViewDatas and #self._curViewDatas > 0 then
			local endTimeList = {}

			for i, v in ipairs(self._curViewDatas) do
				local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.goodsData.id)
				local etime = GameUtil.string2time(goodsCfg.offlineTime)

				if not endTimeList[etime] and table.nums(endTimeList) > 0 then
					hasDifferent = true

					break
				else
					endTimeList[etime] = true
				end
			end
		end

		if hasDifferent then
			self._timeText.text = "剩余时间:具体见礼包详情"
		else
			self:_checkHuodongTimer()
		end
	else
		self:_setCustomTip()
	end
end

function PayShopMibaoView:_checkHuodongTimer()
	self:_stopHuodongTimer()

	if self._currTabData then
		local inTime = GameUtil.checkIsInTimePeriod(self._currTabData.startTime, self._currTabData.endTime)

		if inTime then
			local endTimeSec = GameUtil.string2time(self._currTabData.endTime)

			self._leftTime = endTimeSec - ServerTime.now() + 2

			if self._leftTime > 0 then
				settimer(1, self._startHuodongTimer, self, true)
				self:_startHuodongTimer()
			end
		else
			self._timeText.text = "活动已结束"
		end
	end
end

function PayShopMibaoView:_startHuodongTimer()
	if self._leftTime and self._leftTime > 0 then
		self._leftTime = self._leftTime - 1
		self._timeText.text = self._currTabData.name .. "剩余时间：" .. GameUtil.FormatTimeWords(self._leftTime)
	else
		self.currTabIndex = 1
		self._timeText.text = "活动已结束"

		self:_stopHuodongTimer()
		self:_initTabData()
		GlobalDispatcher:dispatch(PayShopModel.ForceUpdateView)
	end
end

function PayShopMibaoView:_stopHuodongTimer()
	removetimer(self._startHuodongTimer, self)
end

function PayShopMibaoView:_payResultRes(status)
	if status == 0 then
		self:_updateGoodsView()
	end
end

function PayShopMibaoView:_onGetRealViewData()
	local goodsDatas = PayShopModel.instance:getMiBaoGoodDatasByTabId(checknumber(self._currTabData.param), self._sellKey, self._currTabData.jobIds)

	if goodsDatas == nil or #goodsDatas <= 0 then
		return nil
	end

	if self:_isSellPetView() then
		return self:_onParseViewDataBySellKey(goodsDatas, self._sellKey)
	end

	local newViewDatas = {}

	for i, v in ipairs(goodsDatas) do
		table.insert(newViewDatas, {
			goodsData = v
		})
	end

	return newViewDatas
end

function PayShopMibaoView:_onParseViewDataBySellKey(viewDatas, sellKey)
	local kvList = {}
	local newViewDatas = {}

	for i, v in ipairs(viewDatas) do
		kvList[v.id] = v
	end

	local sellType = 1
	local mathSkinStr = "^" .. MatType.PET_SKIN .. ":"

	for _, vData in ipairs(viewDatas) do
		local dataList = {}

		table.insert(dataList, {
			goodsData = vData
		})

		local isSellOut = true

		for i, v0 in ipairs(dataList) do
			if PayShopModel.instance:getPayShopGoodsCanBuyById(v0.goodsData.id) then
				local hasBuy = false

				if self:_isSellMount() then
					local shopItemCfg = PayShopConfig.instance:getPayShopGoodsCfgById(v0.goodsData.id)
					local sellList = string.split(shopItemCfg.content, "#")

					for _, sellStr in pairs(sellList) do
						local type, id, num = MaterialMgr.getMatParams(sellStr)
						local mountId = MountConfig.instance:getMountInMap(type, id)

						if mountId ~= nil and (MaterialModel.instance:getMaterialsNumber(type, id) > 0 or MountModel.instance:getLockmountsById(mountId) ~= false) then
							hasBuy = true

							break
						end
					end
				elseif self:_isSellPetSkin() then
					local shopItemCfg = PayShopConfig.instance:getPayShopGoodsCfgById(v0.goodsData.id)
					local sellList = string.split(shopItemCfg.content, "#")

					for _, sellStr in pairs(sellList) do
						if string.find(sellStr, mathSkinStr) then
							local arr = string.split(sellStr, ":")
							local skinInfo = PetskinModel.instance:getSkinInfoById(checknumber(arr[2]))

							if skinInfo then
								hasBuy = true

								break
							end
						end
					end
				end

				if not hasBuy then
					table.insert(newViewDatas, {
						isSellOut = 0,
						goodsData = v0.goodsData,
						sellKey = sellKey,
						sellType = sellType
					})

					isSellOut = false

					break
				end
			end
		end

		if isSellOut then
			local data = dataList[#dataList]

			if data then
				table.insert(newViewDatas, {
					goodsData = data.goodsData,
					isSellOut = (PayShopModel.GoodsIdNeedSetNotSell[data.goodsData.id] or nil) and 0,
					sellKey = sellKey,
					sellType = sellType
				})
			end
		end
	end

	local cfgList = PayShopConfig.instance:getPayShopMibaoGoodsCfgsByTabId(checknumber(self._currTabData.param))
	local cfgKVList = {}

	for i, v in pairs(cfgList) do
		cfgKVList[v.id] = v
	end

	table.sort(newViewDatas, function(a, b)
		if a.isSellOut == b.isSellOut then
			return cfgKVList[a.goodsData.id].rank < cfgKVList[b.goodsData.id].rank
		else
			return a.isSellOut < b.isSellOut
		end
	end)

	return newViewDatas
end

function PayShopMibaoView:_setCellOffset()
	if self:_isSellPetView() then
		self._scrollerList._tableview.gridWidth = 186
		self._scrollerList._tableview.gridHeight = 286
		self._scrollerList._tableview.numRowsOrCols = 5
	else
		self._scrollerList._tableview.gridWidth = 234
		self._scrollerList._tableview.gridHeight = 296
		self._scrollerList._tableview.numRowsOrCols = 4
	end
end

function PayShopMibaoView:_checkViewDatasEmpty()
	if self._curViewDatas then
		local isHadData = #self._curViewDatas > 0

		goutil.setActive(self._emptyGo, not isHadData)

		if not isHadData then
			self._txtEmpty.text = self:_getEmptyDesc()
		end
	end
end

function PayShopMibaoView:_getEmptyDesc()
	return (self._currTabData and string.find(string.lower(self._currTabData.jumpInTag), "youhui") or nil) and "暂无优惠券"
end

function PayShopMibaoView:_isSellPetView()
	return self._sellKey and not string.nilorempty(self._sellKey)
end

function PayShopMibaoView:_isSellPet()
	return self._sellKey == GameEnum.PayShopTabSellType.SellPet
end

function PayShopMibaoView:_isSellPetSkin()
	return self._sellKey == GameEnum.PayShopTabSellType.SellSkin
end

function PayShopMibaoView:_isSellMount()
	return self._sellKey == GameEnum.PayShopTabSellType.SellMount
end

function PayShopMibaoView:_setCustomTip()
	self._timeText.text = self._currTabData and self._currTabData.jumpInTag == "GodDiamond" and "神钻极其珍贵，只能通过购买获得" or ""
end

function PayShopMibaoView:_tryOpenSkinSortPanel()
	if self:_isSellPetSkin() then
		UIStateManager.instance:push(ViewName.PayshopsortpetskinpartView, self._currTabData.jumpInTag)
	else
		UIStateManager.instance:popByName(ViewName.PayshopsortpetskinpartView)
	end
end

function PayShopMibaoView:_sortSkinDatasView(id)
	self._skinSortId = id

	self:_sortViewDatasAndReload()
end

function PayShopMibaoView:_trySortViewDatas()
	if self:_isSellPetSkin() then
		self._curViewDatas = self._skinSortId == GameEnum.PayshopSkinSortType.NotGet and self:_filterNotGetPetskin() or PayShopModel.instance:sortGoodsBySkinSortId(self._skinSortId, self._oriCurViewDatas)
	elseif self._currTabData and string.find(string.lower(self._currTabData.jumpInTag), "youhui") then
		local newList = {}

		for i, v in ipairs(self._curViewDatas) do
			if PayShopModel.instance:getPayShopGoodsCanBuyById(v.goodsData.id) then
				table.insert(newList, v)
			end
		end

		self._curViewDatas = newList
	end
end

function PayShopMibaoView:_filterNotGetPetskin()
	local content = ""
	local cfg
	local isHad = false
	local notSortList = {}

	for i, v in ipairs(self._curViewDatas or {}) do
		isHad = false
		cfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.goodsData.id)
		content = cfg.content

		if cfg.payType == GameEnum.PayShopPayType.JUMPGOODS then
			table.insert(notSortList, v)
		elseif string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":") then
			local arr1 = string.split(content, "#")

			for i, str in ipairs(arr1) do
				if string.find(str, "^" .. MatType.PET_SKIN .. ":") then
					local arr2 = string.split(str, ":")
					local matId = checkint(arr2[2])
					local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(matId)
					local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

					isHad = skinStatus == PetskinController.SKIN_STATUS_HAD

					break
				end
			end

			if not isHad then
				table.insert(notSortList, v)
			end
		else
			table.insert(notSortList, v)
		end
	end

	return notSortList
end

function PayShopMibaoView:_onClickbtnClear()
	self._inputComp:SetText("")
end

function PayShopMibaoView:_inputValueChanged(text)
	if text == PayShopModel.instance:getPetSearchStr() then
		return
	end

	PayShopModel.instance:setPetSearchStr(text)
	self:_filterBySearchText()
	self._scrollerList:reloadData(self._curViewDatas)
end

function PayShopMibaoView:_filterBySearchText()
	if string.nilorempty(PayShopModel.instance:getPetSearchStr()) then
		self._curViewDatas = self._prefilterCurViewDatas

		return
	end

	self._curViewDatas = {}

	local cfg

	for i, data in ipairs(self._prefilterCurViewDatas) do
		if string.find(PayShopConfig.instance:getPayShopGoodsCfgById(data.goodsData.id).name, PayShopModel.instance:getPetSearchStr()) then
			table.insert(self._curViewDatas, data)
		end
	end
end

function PayShopMibaoView:_onReloadFinish()
	if self._isFirstLoadData then
		self._isFirstLoadData = false

		self._scrollerList._tableview:SetOffsetWithoutRefresh(0)
		self._scrollerList:reloadData(self._curViewDatas)

		return
	end

	if self._locationGoodsIdOnce and self._locationGoodsIdOnce > 0 then
		local locationGoodsId = self._locationGoodsIdOnce

		self._locationGoodsIdOnce = 0

		for i, v in ipairs(self._curViewDatas) do
			if v.goodsData.id == locationGoodsId then
				self._autoClickBuyTimeMs = ServerTime.nowMs()
				self._autoClickBuyGoodsId = locationGoodsId

				self._scrollerList:MoveCellToBegin(i - 1)
				self._scrollerList:refresh()

				break
			end
		end
	end
end

return PayShopMibaoView
