-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreShoppingTipsView.lua

module("logic.extensions.store.view.StoreShoppingTipsView", package.seeall)

local M = class("StoreShoppingTipsView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("3&small_tips_common_bg_1276053964")
	self._btnBuy = self:getBtn("store_shopping_tips_-1708084061")
	self._labBuy = self:getText("store_shopping_tips_-1154228927")
	self._btnCancle = self:getBtn("store_shopping_tips_-1396390192")
	self._discountSign = self:getGo("store_shopping_tips_1184389917")
	self._txtDiscount = self:getText("store_shopping_tips_2017990079")
	self._imgQuality = self:getImage("0&rewards_detail_item_868117965")
	self._imgIcon = self:getImage("0&rewards_detail_item_-2041880288")
	self._imgHeroIcon = self:getImage("0&backpack_item_-723704209", UIComponentType.Image)
	self._txtName = self:getText("store_shopping_tips_-1642614107")
	self._txtDesc = self:getText("store_shopping_tips_-88665914")
	self._itemScrollView = LoopListHelper.New(self:getGo("store_shopping_tips_-1896320368"))

	self._itemScrollView:InitListView(0, self._updateCell, self)

	self._itemGo = self:getGo("0&rewards_detail_item_2141037416")
	self._itemCell = Astral.LuaComponentContainer.Add(self._itemGo, ShopItemCell)

	self._itemCell:setShowSelectedEffect(false)

	self._txtNum = self:getText("0&backpack_item_977509436")
	self._limitHitGo = self:getGo("store_shopping_tips_-460295320")
	self._txtLimitHint = self:getText("store_shopping_tips_-1735227220")
	self._autoInputGo = self:getGo("store_shopping_tips_967126693")
	self._iptNum = self:getInput("store_shopping_tips_-218316319")
	self._longPressTriggerIncrease = Astral.UILongPressTrigger.Get(self:getGo("store_shopping_tips_1005045188"))
	self._longPressTriggerReduce = Astral.UILongPressTrigger.Get(self:getGo("store_shopping_tips_1168728181"))

	local longPressTriggerCfg = {
		0.6,
		0.2,
		0.01
	}

	self._longPressTriggerIncrease:SetTriggerTime(longPressTriggerCfg)
	self._longPressTriggerReduce:SetTriggerTime(longPressTriggerCfg)

	self._btnMax = self:getBtn("store_shopping_tips_-1497884752")
	self._txtPrice = self:getText("store_shopping_tips_-449731970")
	self._imgPriceIcon = self:getImage("store_shopping_tips_-133198434")
	self._btnFull = self:getBtn("store_shopping_tips_1099187071")
end

function M:destroyUI()
	self._autoInputGo = nil
	self._limitHitGo = nil
	self._txtNum = nil
	self._btnClose = nil
	self._btnCancle = nil
	self._btnBuy = nil
	self._discountSign = nil
	self._txtDiscount = nil
	self._imgIcon = nil
	self._txtName = nil
	self._txtDesc = nil

	self._itemScrollView:Dispose()

	self._itemScrollView = nil
	self._txtLimitHint = nil
	self._btnMinus = nil
	self._btnAdd = nil
	self._iptNum = nil
	self._txtPrice = nil
	self._imgPriceIcon = nil
	self._btnFull = nil
	self._longPressTriggerIncrease = nil
	self._longPressTriggerReduce = nil
end

function M:bindEvents()
	self._iptNum:AddOnValueChanged(self._onInputValueChange, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancle:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._longPressTriggerIncrease:AddLongPressListener(self._onLongClickBtnIncrease, self, nil)
	self._longPressTriggerReduce:AddLongPressListener(self._onLongClickBtnReduce, self, nil)
	self._btnMax:AddClickListener(self._onClickMax, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updataGoodsData, self)
end

function M:unbindEvents()
	self._iptNum:RemoveOnValueChanged()
	self._btnClose:RemoveClickListener()
	self._btnCancle:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._longPressTriggerIncrease:RemoveLongPressListener()
	self._longPressTriggerReduce:RemoveLongPressListener()
	self._btnMax:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._updataGoodsData, self)
end

function M:onEnter()
	self._handleCount = false

	local goodsData = self:getFirstParam()

	self._goodsMo = goodsData
	self._curCount = 1
	self._costItem = false
	self._discountPrice = false
	self._myNum = false
	self._canBuyMax = 999

	self:showData(goodsData)
	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, StoreMainViewViewPresentor.MONEY_SHOW_TYPE[goodsData:getStoreId()])
end

function M:showData(goodsMo)
	self._itemScrollView:ClearCells()

	local storeType = StoreUtil.getStoreType(goodsMo:getStoreId())

	self._storeType = storeType

	local useItemName = string.nilorempty(goodsMo:getName())

	self._txtName.text = goodsMo:getName()
	self._isDayBuyLimit = false
	self._isBuyLimit = false
	self._isSingleLimit = false

	goutil.setActive(self._discountSign, false)
	goutil.setActive(self._limitHitGo, false)
	goutil.setActive(self._autoInputGo, false)

	self._txtDesc.text = ""
	self._txtLimitHint.text = ""

	local buyLimit = goodsMo:getBuyLimit()
	local hisBuyLimit = goodsMo:getHisBuyLimit()
	local dailyBuyLimit = goodsMo:getDailyBuyMaxNum()
	local limit = self:getMinLimit(limit or 0, buyLimit or 0)

	limit = self:getMinLimit(limit, hisBuyLimit or 0)
	limit = self:getMinLimit(limit, dailyBuyLimit or 0)

	goutil.setActive(self._imgHeroIcon.gameObject, true)
	goutil.setActive(self._imgIcon.gameObject, false)

	if storeType == StoreEnum.MallType.SecondExchange then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, goodsMo:getIcon())

		local baseExchangeNum = goodsMo:getExchangeNum()

		if goodsMo:getIsFirst() then
			if goodsMo:getFrstExtraExchangeNum() > 0 then
				baseExchangeNum = baseExchangeNum + goodsMo:getFrstExtraExchangeNum()
			end
		elseif goodsMo:getNormalExtraExchangeNum() > 0 then
			baseExchangeNum = baseExchangeNum + goodsMo:getNormalExtraExchangeNum()
		end

		self._txtNum.text = baseExchangeNum
		self._txtDesc.text = TextUtils.GetPunctuationFixedText(goodsMo:getDesc(), self._txtDesc)

		local tmpprice = goodsMo:getCostFirstMoneyNum()
		local firstMoneyId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.FirstMoneyId)
		local itemCo = BackpackConfig.instance:getItemInfoByItemId(firstMoneyId)

		if itemCo then
			IconLoader.setSprite(self._imgPriceIcon, IconType.ItemIcon, itemCo.icon)
		end

		local myCount = ItemModel.instance:getItemCountByItemId(firstMoneyId)
		local txtColorStr = self:_getPriceColorStr(myCount, tmpprice)

		self._txtPrice.text = string.format("<color=%s>%s</color>", txtColorStr, tmpprice)
	elseif storeType == StoreEnum.MallType.GiftBag then
		local firstReward = goodsMo:getFirstReward()

		if string.nilorempty(goodsMo:getIcon()) then
			local itemCo = BackpackConfig.instance:getItemInfoByItemId(firstReward.itemId)

			if itemCo then
				if useItemName then
					self._txtName.text = itemCo.name
				end

				IconLoader.setSpriteByItemType(self._imgIcon, itemCo.type, itemCo.icon)
			end
		else
			IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, goodsMo:getIcon())
		end

		IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[goodsMo:getQuality()])

		self._txtDesc.text = ""

		local reward = goodsMo:getReward()

		self._rewardList = StoreUtil.formatText(reward)

		local len = #self._rewardList

		self._itemScrollView:SetListItemCount(len, true)

		self._curCount = 1
		self._txtNum.text = self._curCount

		goutil.setActive(self._autoInputGo, false)
		self:getCurCost(goodsMo:getCost())
		self._iptNum:SetText(self._curCount)

		local curCount = goodsMo:getRemainedNum()

		if limit > 0 and curCount >= 0 then
			self._canBuyMax = curCount

			goutil.setActive(self._limitHitGo, true)

			local colorStr = curCount == 0 and "ff3e48" or "ffffff"

			self._txtLimitHint.text = langF("tip_store_total_limmit", colorStr, curCount, limit)
		end

		if goodsMo:getIsDiscount() then
			self._discountPrice = goodsMo:getDiscountPrice()

			if goodsMo:getDiscount() > 0 then
				self:getCurCost(goodsMo:getCost())
				goutil.setActive(self._discountSign, true)

				self._txtDiscount.text = "-" .. 100 - goodsMo:getDiscount() * 10 .. "%"
			end
		end

		local tempPrice = 0

		if self._discountPrice then
			tempPrice = self._discountPrice * self._curCount
		else
			tempPrice = self._costItem.num * self._curCount
		end

		local txtColorStr = self:_getPriceColorStr(self._myNum, tempPrice)

		self._txtPrice.text = string.format("<color=%s>%s</color>", txtColorStr, tempPrice)
	elseif storeType == StoreEnum.MallType.CurrencyExchange or storeType == StoreEnum.MallType.RandomOutput or storeType == StoreEnum.MallType.Fixed then
		local firstReward = goodsMo:getFirstReward()
		local itemData = ItemUtil.createItemData({
			count = 0,
			itemId = firstReward.itemId
		})

		if string.nilorempty(goodsMo:getIcon()) then
			if itemData then
				if useItemName then
					self._txtName.text = itemData:getName()
				end

				goutil.setActive(self._imgHeroIcon.gameObject, itemData:getType() == GameEnum.ItemTypeEnum.HeroType)
				goutil.setActive(self._imgIcon.gameObject, itemData:getType() ~= GameEnum.ItemTypeEnum.HeroType)

				local imgIcon = itemData:getType() == GameEnum.ItemTypeEnum.HeroType and self._imgHeroIcon or self._imgIcon

				IconLoader.setSpriteByItemType(imgIcon, itemData:getType(), itemData:getIcon())
			end
		else
			IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, goodsMo:getIcon())
		end

		if itemData then
			IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[itemData:getQuality()])
			self._itemCell:updateData(itemData)
		end

		local reward = goodsMo:getReward()

		self._rewardList = StoreUtil.formatText(reward)

		local len = #self._rewardList

		self._itemCell:setCanClick(len <= 1)

		if len > 1 then
			self._itemScrollView:SetListItemCount(len, true)
		elseif len == 1 then
			self._itemScrollView:ClearCells()

			if itemData then
				if GameEnum.ItemTypeEnum.HeroType == itemData:getType() then
					local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(itemData:getItemId())

					if heroInfoCO then
						self._txtDesc.text = TextUtils.GetPunctuationFixedText(heroInfoCO.baseInfo, self._txtDesc)
					end
				else
					self._txtDesc.text = TextUtils.GetPunctuationFixedText(itemData:getItemUseDesc(), self._txtDesc)
				end
			end
		end

		self._curCount = 1
		self._txtNum.text = self._curCount

		goutil.setActive(self._autoInputGo, true)
		self:getCurCost(goodsMo:getCost())
		self._iptNum:SetText(self._curCount)

		local remainedNum = goodsMo:getRemainedNum()
		local onceMaxNum = goodsMo:getOnceMaxNum()
		local dailyBuyNum = goodsMo:getDailyBuyNum()
		local dailyBuyMaxNum = goodsMo:getDailyBuyMaxNum()

		if dailyBuyMaxNum > 0 and dailyBuyMaxNum < onceMaxNum or limit > 0 and dailyBuyMaxNum < limit and dailyBuyMaxNum > 0 then
			printError("提示:每日购买上限请不要小于其他限购数量")
		end

		if limit > 0 then
			self._canBuyMax = remainedNum ~= -1 and remainedNum or limit
			self._isBuyLimit = self._canBuyMax > 0

			if onceMaxNum > 0 and dailyBuyMaxNum > 0 then
				local dailyRemainedNum = dailyBuyMaxNum - dailyBuyNum > 0 and dailyBuyMaxNum - dailyBuyNum or 0
				local onceRemainedNum = onceMaxNum

				if self._isBuyLimit then
					if dailyRemainedNum <= onceRemainedNum and dailyRemainedNum <= remainedNum then
						self._canBuyMax = dailyRemainedNum
						self._isBuyLimit = false
						self._isSingleLimit = false
						self._isDayBuyLimit = true
					elseif onceRemainedNum <= dailyRemainedNum and onceRemainedNum <= remainedNum then
						self._canBuyMax = onceRemainedNum
						self._isBuyLimit = false
						self._isSingleLimit = true
						self._isDayBuyLimit = false
					elseif remainedNum > 0 and remainedNum <= dailyRemainedNum and remainedNum <= onceRemainedNum then
						self._canBuyMax = remainedNum
						self._isSingleLimit = false
						self._isDayBuyLimit = false
					end
				else
					self._isBuyLimit = true
					self._isSingleLimit = false
					self._isDayBuyLimit = false
				end
			elseif onceMaxNum > 0 then
				if onceMaxNum < self._canBuyMax then
					self._canBuyMax = onceMaxNum
					self._isBuyLimit = false
					self._isSingleLimit = true
				end
			elseif dailyBuyMaxNum > 0 then
				self._canBuyMax = dailyBuyMaxNum - dailyBuyNum > 0 and dailyBuyMaxNum - dailyBuyNum or 0
				self._isDayBuyLimit = self._canBuyMax > 0

				if self._isDayBuyLimit then
					self._isBuyLimit = false
				end
			end
		elseif dailyBuyMaxNum > 0 then
			self._canBuyMax = dailyBuyMaxNum - dailyBuyNum > 0 and dailyBuyMaxNum - dailyBuyNum or 0
			self._isDayBuyLimit = self._canBuyMax > 0

			if onceMaxNum > 0 and onceMaxNum < self._canBuyMax then
				self._canBuyMax = onceMaxNum
				self._isDayBuyLimit = false
				self._isSingleLimit = true
			end
		elseif onceMaxNum > 0 then
			self._canBuyMax = onceMaxNum
			self._isSingleLimit = true
		else
			self._canBuyMax = 999
		end

		if remainedNum >= 0 then
			goutil.setActive(self._limitHitGo, true)

			local colorStr = remainedNum == 0 and "ff3e48" or "ffffff"

			self._txtLimitHint.text = langF("tip_store_total_limmit", colorStr, remainedNum, limit)
		elseif dailyBuyMaxNum > 0 then
			goutil.setActive(self._limitHitGo, true)

			local colorStr = dailyBuyNum == 0 and "ff3e48" or "ffffff"

			self._txtLimitHint.text = langF("tip_store_day_limmit", colorStr, dailyBuyNum, dailyBuyMaxNum)
		end

		if goodsMo:getIsDiscount() then
			self._discountPrice = goodsMo:getDiscountPrice()

			if goodsMo:getDiscount() > 0 then
				self:getCurCost(goodsMo:getCost())
				goutil.setActive(self._discountSign, true)

				self._txtDiscount.text = "-" .. 100 - goodsMo:getDiscount() * 10 .. "%"
			end
		end

		local tempPrice = 0

		if self._discountPrice then
			tempPrice = self._discountPrice * self._curCount
		else
			tempPrice = self._costItem.num * self._curCount
		end

		local txtColorStr = self:_getPriceColorStr(self._myNum, tempPrice)

		self._txtPrice.text = string.format("<color=%s>%s</color>", txtColorStr, tempPrice)
	end

	goutil.setActive(self._btnMax.gameObject, self._canBuyMax ~= 999)
	self:_adjustBuyTips()
end

function M:getMinLimit(curent, target)
	if curent == 0 then
		return target
	end

	if target == 0 then
		return curent
	end

	return Mathf.Min(curent, target)
end

function M:_adjustBuyTips()
	local hasHero = false

	if self._rewardList then
		for index, rewardData in pairs(self._rewardList) do
			local itemData = ItemUtil.createItemData({
				count = rewardData.num,
				itemId = rewardData.itemId
			})

			hasHero = GameEnum.ItemTypeEnum.HeroType == itemData:getType()

			break
		end
	end

	self._labBuy.text = hasHero and lang("tip_store_buy_hero") or lang("tip_store_buy_normal")
end

function M:getCurCost(costStr)
	local costItems = StoreUtil.formatText(costStr)
	local len = #costItems

	if len == 1 then
		local itemId = costItems[1].itemId
		local num = costItems[1].num

		self._costItem = {
			itemId = itemId,
			num = num
		}
		self._myNum = ItemModel.instance:getItemCountByItemId(itemId)

		local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

		if itemCo then
			IconLoader.setSprite(self._imgPriceIcon, IconType.ItemIcon, itemCo.icon)
		end
	elseif enableErrorLog then
		printError("There are multiple consumable items,ID,", self._storeCo.mallId)
	end
end

function M:_getPriceColorStr(myCount, costCount)
	return costCount <= myCount and "#FFFFFF" or "#ff3e48"
end

function M:onExit()
	return
end

function M:onExitFinished()
	self._itemScrollView:ClearCells()
	IconLoader.clearSprite(self._imgIcon)
	IconLoader.clearSprite(self._imgHeroIcon)
	IconLoader.clearSprite(self._imgPriceIcon)

	self._rewardList = {}
end

function M:_onClickClose()
	self:close()
end

function M:_onClickBuy()
	local goodsMo = self._goodsMo
	local storeType = self._storeType
	local myCount = self._myNum
	local costCount = 0
	local buyLimit = goodsMo:getBuyLimit()
	local hisBuyLimit = goodsMo:getHisBuyLimit()
	local dailyBuyLimit = goodsMo:getDailyBuyMaxNum()
	local limit = self:getMinLimit(limit or 0, buyLimit or 0)

	limit = self:getMinLimit(limit, hisBuyLimit or 0)
	limit = self:getMinLimit(limit, dailyBuyLimit or 0)

	if storeType == StoreEnum.MallType.SecondExchange then
		local firstMoneyId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.FirstMoneyId)

		myCount = ItemModel.instance:getItemCountByItemId(firstMoneyId)
		costCount = goodsMo:getCostFirstMoneyNum()

		if costCount <= myCount then
			local costItems = StoreUtil.createCostItems(firstMoneyId, costCount)

			StoreAgent.instance:sendBuyGoodsRequest(goodsMo:getGoodsId(), 1, goodsMo:getTabId(), costItems)
		else
			local firstMoneyId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.FirstMoneyId)
			local itemCo = BackpackConfig.instance:getItemInfoByItemId(firstMoneyId)

			if itemCo then
				FloatWordMgr.instance:show(langF("tip_store_item_not_enough", itemCo.name))
			end
		end
	elseif storeType == StoreEnum.MallType.GiftBag then
		local curCount = goodsMo:getRemainedNum()

		if limit > 0 and curCount == 0 then
			FloatWordMgr.instance:show(lang("tip_store_goods_limmit_buy"))

			return
		end

		self._curCount = tonumber(self._iptNum:GetText())

		if self._curCount == 0 then
			FloatWordMgr.instance:show(lang("tip_store_no_buy_times"))

			return
		end

		if self._canBuyMax > 0 and self._curCount > self._canBuyMax then
			local formatTxt = ""

			formatTxt = self._isSingleLimit and lang("tip_store_single_buy_max") or formatTxt
			formatTxt = self._isDayBuyLimit and lang("tip_store_day_buy_max") or formatTxt
			formatTxt = self._isBuyLimit and lang("tip_store_can_buy_max") or formatTxt

			FloatWordMgr.instance:show(string.format(formatTxt, self._curCount))

			return
		end

		local cost = self._costItem.num * self._curCount
		local discountPrice = false

		if goodsMo:getIsDiscount() then
			discountPrice = goodsMo:getDiscountPrice()
		end

		if discountPrice then
			cost = discountPrice * self._curCount
		else
			cost = self._costItem.num * self._curCount
		end

		local costId = self._costItem.itemId

		if cost <= myCount then
			local costItems = StoreUtil.createCostItems(costId, cost)

			StoreAgent.instance:sendBuyGoodsRequest(goodsMo:getGoodsId(), self._curCount, costItems)
		else
			local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._costItem.itemId)

			if itemCo then
				FloatWordMgr.instance:show(langF("tip_store_item_not_enough", itemCo.name))
			end
		end
	elseif storeType == StoreEnum.MallType.CurrencyExchange or storeType == StoreEnum.MallType.RandomOutput or storeType == StoreEnum.MallType.Fixed then
		local remainedNum = goodsMo:getRemainedNum()

		if self._canBuyMax > 0 and self._curCount > self._canBuyMax then
			FloatWordMgr.instance:show(lang("tip_store_item_day_limmit_buy"))

			return
		end

		if remainedNum >= 0 and limit > 0 and remainedNum <= 0 then
			FloatWordMgr.instance:show(lang("tip_store_goods_limmit_buy"))

			return
		end

		local discountPrice = false

		if goodsMo:getIsDiscount() then
			discountPrice = goodsMo:getDiscountPrice()
		end

		self._curCount = tonumber(self._iptNum:GetText())

		if self._curCount == 0 then
			FloatWordMgr.instance:show(lang("tip_store_no_buy_times"))

			return
		end

		local cost = 0

		if discountPrice then
			cost = discountPrice * self._curCount
		else
			cost = self._costItem.num * self._curCount
		end

		local costId = self._costItem.itemId

		if cost <= myCount then
			local costItems = StoreUtil.createCostItems(costId, cost)

			StoreAgent.instance:sendBuyGoodsRequest(goodsMo:getGoodsId(), self._curCount, costItems)
		else
			local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._costItem.itemId)

			if itemCo then
				FloatWordMgr.instance:show(langF("tip_store_item_not_enough", itemCo.name))
			end
		end
	end

	self:close()
end

function M:_onLongClickBtnReduce(triggerIndex)
	if self._curCount > 1 then
		self._curCount = self._curCount - 1
	end

	self._handleCount = self._curCount

	self._iptNum:SetText(self._curCount)
end

function M:_onLongClickBtnIncrease(triggerIndex)
	if self._canBuyMax <= 0 then
		self._iptNum:SetText(0)

		return
	end

	if self._curCount >= self._canBuyMax and self._canBuyMax > 0 then
		local formatTxt = ""

		formatTxt = self._isSingleLimit and lang("tip_store_single_buy_max") or formatTxt
		formatTxt = self._isDayBuyLimit and lang("tip_store_day_buy_max") or formatTxt
		formatTxt = self._isBuyLimit and lang("tip_store_can_buy_max") or formatTxt

		FloatWordMgr.instance:show(string.format(formatTxt, self._canBuyMax))

		return
	end

	self._curCount = self._curCount + 1
	self._handleCount = self._curCount

	self._iptNum:SetText(self._curCount)
end

function M:_onClickMax()
	if self._curCount >= self._canBuyMax and self._canBuyMax > 0 then
		local formatTxt = ""

		formatTxt = self._isSingleLimit and lang("tip_store_single_buy_max") or formatTxt
		formatTxt = self._isDayBuyLimit and lang("tip_store_day_buy_max") or formatTxt
		formatTxt = self._isBuyLimit and lang("tip_store_can_buy_max") or formatTxt

		FloatWordMgr.instance:show(string.format(formatTxt, self._canBuyMax))

		return
	end

	if self._canBuyMax > 0 then
		local buyMaxWithEngouhMoney = self:_checkRealMaxCount()

		if not self._handleCount or self._handleCount and self._handleCount < self._canBuyMax and buyMaxWithEngouhMoney > self._handleCount then
			self._curCount = buyMaxWithEngouhMoney
		else
			self._curCount = self._handleCount
		end

		self._iptNum:SetText(self._curCount)
	else
		self._curCount = 0

		self._iptNum:SetText(self._curCount)
	end
end

function M:_checkRealMaxCount()
	local costPirce = 0

	if self._discountPrice then
		costPirce = self._discountPrice
	else
		costPirce = self._costItem.num
	end

	local integer, decimal = math.modf(self._myNum / costPirce)

	if integer >= self._canBuyMax then
		return self._canBuyMax
	else
		return integer
	end
end

function M:_onInputValueChange()
	if string.nilorempty(self._iptNum:GetText()) then
		return
	end

	local count = tonumber(self._iptNum:GetText())

	self._curCount = count

	if count <= 0 then
		return
	end

	if self._rewardList then
		for index, rewardItem in pairs(self._rewardList) do
			rewardItem.num = rewardItem.base * count
		end

		local len = #self._rewardList

		if self._storeType == StoreEnum.MallType.CurrencyExchange or self._storeType == StoreEnum.MallType.RandomOutput or self._storeType == StoreEnum.MallType.Fixed then
			if len > 1 then
				self._itemScrollView:SetListItemCount(len, false)
			elseif len == 1 then
				-- block empty
			end
		else
			self._itemScrollView:SetListItemCount(len, false)
			self._itemScrollView:RefreshAllShownItem()
		end
	end

	self._txtNum.text = self._curCount

	local costPirce = 0

	if self._discountPrice then
		costPirce = self._discountPrice * self._curCount
	else
		costPirce = self._costItem.num * self._curCount
	end

	self._txtPrice.text = costPirce

	if self._myNum then
		TextUtils.SetColor(self._txtPrice, self:_getPriceColorStr(self._myNum, costPirce))
	end
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._itemScrollView:NewListViewItem("backpack_item")

	if self._rewardList then
		local data = self._rewardList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreShoppingItem)

		shower:setCellData(data, curIndex, self._goodsMo)
	end

	return item
end

function M:_updataGoodsData()
	local goodsData = StoreModel.instance:getGoodMoByGoodsId(self._goodsMo:getGoodsId())

	if goodsData then
		self._goodsMo = goodsData
		self._discountPrice = false

		self:showData(goodsData)
	end
end

return M
