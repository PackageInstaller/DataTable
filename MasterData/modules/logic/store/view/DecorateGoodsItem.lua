-- chunkname: @modules/logic/store/view/DecorateGoodsItem.lua

module("modules.logic.store.view.DecorateGoodsItem", package.seeall)

local DecorateGoodsItem = class("DecorateGoodsItem", LuaCompBase)

function DecorateGoodsItem:init(go, mo)
	self.go = go
	self._mo = mo
	self._goroot = gohelper.findChild(self.go, "root")
	self._goselect = gohelper.findChild(self._goroot, "#go_select")
	self._goselectbuy = gohelper.findChild(self._goroot, "#go_selectbuy")
	self._goItem = gohelper.findChild(self._goroot, "#go_Item")
	self._simagebanner = gohelper.findChildSingleImage(self._goroot, "#go_Item/#simage_banner")
	self._simagerareicon = gohelper.findChildSingleImage(self._goroot, "#go_Item/#simage_icon")
	self._godeadline = gohelper.findChild(self._goroot, "#go_Item/#go_deadline")
	self._txttime = gohelper.findChildText(self._goroot, "#go_Item/#go_deadline/#txt_time")
	self._godeadlineEffect = gohelper.findChild(self._goroot, "#go_Item/#go_deadline/#effect")
	self._imagetimebg = gohelper.findChildImage(self._goroot, "#go_Item/#go_deadline/timebg")
	self._imagetimeicon = gohelper.findChildImage(self._goroot, "#go_Item/#go_deadline/#txt_time/timeicon")
	self._txtformat = gohelper.findChildText(self._goroot, "#go_Item/#go_deadline/#txt_time/#txt_format")
	self._gonewtag = gohelper.findChild(self._goroot, "#go_Item/#go_newtag")
	self._gotag = gohelper.findChild(self._goroot, "#go_Item/#go_tag")
	self._godiscount = gohelper.findChild(self._goroot, "#go_Item/#go_tag/#go_discount")
	self._txtdiscount = gohelper.findChildText(self._goroot, "#go_Item/#go_tag/#go_discount/#txt_discount")
	self._godiscount2 = gohelper.findChild(self._goroot, "#go_Item/#go_tag/#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self._goroot, "#go_Item/#go_tag/#go_discount2/#txt_discount")
	self._golimit = gohelper.findChild(self._goroot, "#go_Item/#go_tag/#go_limit")
	self._txtlimit = gohelper.findChildText(self._goroot, "#go_Item/#go_tag/#go_limit/txt_limit")
	self._txtname = gohelper.findChildText(self._goroot, "#go_Item/#txt_name")
	self._gosoldout = gohelper.findChild(self._goroot, "#go_soldout")
	self._goitemowned = gohelper.findChild(self._goroot, "#go_owned")
	self._btnbuy = gohelper.findChildButtonWithAudio(self._goroot, "#btn_buy")
	self._gosingle = gohelper.findChild(self._goroot, "#btn_buy/cost/#go_single")
	self._txtcurprice = gohelper.findChildText(self._goroot, "#btn_buy/cost/#go_single/txt_materialNum")
	self._simagesingleicon = gohelper.findChildSingleImage(self._goroot, "#btn_buy/cost/#go_single/icon/simage_material")
	self._txtoriginalprice = gohelper.findChildText(self._goroot, "#btn_buy/cost/#go_single/#txt_original_price")
	self._godouble = gohelper.findChild(self._goroot, "#btn_buy/cost/#go_doubleprice")
	self._txtcurprice1 = gohelper.findChildText(self._goroot, "#btn_buy/cost/#go_doubleprice/currency1/txt_materialNum")
	self._simagedoubleicon1 = gohelper.findChildSingleImage(self._goroot, "#btn_buy/cost/#go_doubleprice/currency1/simage_material")
	self._txtoriginalprice1 = gohelper.findChildText(self._goroot, "#btn_buy/cost/#go_doubleprice/currency1/#txt_original_price")
	self._txtcurprice2 = gohelper.findChildText(self._goroot, "#btn_buy/cost/#go_doubleprice/currency2/txt_materialNum")
	self._simagedoubleicon2 = gohelper.findChildSingleImage(self._goroot, "#btn_buy/cost/#go_doubleprice/currency2/simage_material")
	self._txtoriginalprice2 = gohelper.findChildText(self._goroot, "#btn_buy/cost/#go_doubleprice/currency2/#txt_original_price")
	self._gofree = gohelper.findChild(self._goroot, "#btn_buy/cost/#go_free")
	self._goclick = gohelper.findChild(self._goroot, "#go_click")
	self._btnClick = gohelper.getClick(self._goclick)
	self._goreddot = gohelper.findChild(self._goroot, "#go_Item/#go_reddot")
	self.goSp = gohelper.findChild(self._goroot, "#go_Item/#go_tag/#go_sp")
	self._goliandong = gohelper.findChild(self._goroot, "#go_Item/#go_tag/#go_liandong")

	self:_addEvents()
	gohelper.setActive(self.go, false)

	self._anim = self._goroot:GetComponent(typeof(UnityEngine.Animator))

	self:_refreshUI()
end

function DecorateGoodsItem:_addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function DecorateGoodsItem:_removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnClick:RemoveClickListener()
end

function DecorateGoodsItem:reset(mo)
	self._mo = mo

	gohelper.setActive(self.go, false)
	self:_refreshUI()
end

function DecorateGoodsItem:_btnbuyOnClick()
	local curGoodId = DecorateStoreModel.instance:getCurGood(self._mo.belongStoreId)

	if curGoodId ~= self._mo.goodsId then
		self:_btnClickOnClick()

		return
	end

	if self._mo.config.maxBuyCount > 0 and self._mo.buyCount >= self._mo.config.maxBuyCount then
		return
	end

	local isItemHas = DecorateStoreModel.instance:isDecorateGoodItemHas(self._mo.goodsId)

	if isItemHas then
		return
	end

	StoreController.instance:openDecorateStoreGoodsView(self._mo)
end

function DecorateGoodsItem:_btnClickOnClick()
	local curGoodId = DecorateStoreModel.instance:getCurGood(self._mo.belongStoreId)

	if curGoodId == self._mo.goodsId then
		return
	end

	DecorateStoreModel.instance:setGoodRead(self._mo.goodsId)
	DecorateStoreModel.instance:setCurGood(self._mo.goodsId)
	StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function DecorateGoodsItem:_refreshUI()
	self:_refreshDetail()
	self:_refreshCost()
	self:_refreshDeadline()
	self:_refreshReddot()
end

function DecorateGoodsItem:_refreshDetail()
	local curGoodId = DecorateStoreModel.instance:getCurGood(self._mo.belongStoreId)

	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._mo.goodsId)

	gohelper.setActive(self._goselect, self._mo.goodsId == curGoodId and self._isFold)
	gohelper.setActive(self._goselectbuy, self._mo.goodsId == curGoodId and not self._isFold)
	gohelper.setActive(self._goliandong, self._decorateConfig and self._decorateConfig.linkTag == DecorateStoreEnum.LinkTagType.Show)

	self._txtname.text = self._mo.config.name

	if self._decorateConfig.rare > 0 then
		gohelper.setActive(self._simagerareicon.gameObject, true)
		self._simagerareicon:LoadImage(ResUrl.getDecorateStoreImg(self._decorateConfig.smalllmg))
		self._simagebanner:LoadImage(ResUrl.getDecorateStoreImg(string.format("store_decorate_quality_%s", self._decorateConfig.rare)))
	else
		self._simagebanner:LoadImage(ResUrl.getDecorateStoreImg(self._decorateConfig.smalllmg))
	end

	local isItemHas = DecorateStoreModel.instance:isDecorateGoodItemHas(self._mo.goodsId)

	if isItemHas then
		gohelper.setActive(self._goitemowned, true)
		gohelper.setActive(self._gosoldout, false)
		gohelper.setActive(self._godiscount, false)
		gohelper.setActive(self._godiscount2, false)
		gohelper.setActive(self._gonewtag, false)
		gohelper.setActive(self._golimit, false)
		gohelper.setActive(self.goSp, false)
		self:_refreshNotClick()

		return
	end

	if self._decorateConfig.offTag > 0 then
		if not self._decorateConfig.offTag then
			local discount = 100
			local hasDiscount1 = discount > 0 and discount < 100

			if hasDiscount1 then
				self._txtdiscount.text = string.format("-%s%%", discount)
			end

			if self._decorateConfig.onlineTag == 0 then
				gohelper.setActive(self._gonewtag, false)
			else
				local isShowReddot = self:_isShowReddot()
				local isGoodRead = DecorateStoreModel.instance:isGoodRead(self._mo.goodsId)

				gohelper.setActive(self._gonewtag, not isGoodRead and not isShowReddot)
			end

			if self._mo.config.maxBuyCount > 0 and self._mo.buyCount >= self._mo.config.maxBuyCount then
				gohelper.setActive(self._gosoldout, self._decorateConfig.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.SoldOut)
				gohelper.setActive(self._goitemowned, self._decorateConfig.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.Owned)
			else
				gohelper.setActive(self._gosoldout, false)
			end

			local offsetSecond = DecorateStoreModel.instance:getGoodItemLimitTime(self._mo.goodsId)
			local discount2 = offsetSecond > 0 and DecorateStoreModel.instance:getGoodDiscount(self._mo.goodsId) or 100

			discount2 = discount2 == 0 and 100 or discount2

			local hasDiscount = discount2 > 0 and discount2 < 100

			if hasDiscount then
				self._txtdiscount2.text = string.format("-%s%%", discount2)
			end

			gohelper.setActive(self._godiscount, hasDiscount1)
			gohelper.setActive(self._godiscount2, hasDiscount)

			if string.nilorempty(self._decorateConfig.tag1) then
				gohelper.setActive(self._golimit, false)
			else
				gohelper.setActive(self._golimit, true)

				self._txtlimit.text = self._decorateConfig.tag1
			end

			gohelper.setActive(self.goSp, self._decorateConfig.tag2 == DecorateStoreEnum.TagType.SpecialSell)
			self:_refreshNotClick()
		end
	end
end

function DecorateGoodsItem:_refreshNotClick()
	if not self._gosoldout.gameObject.activeSelf then
		local isNotClick = self._goitemowned.gameObject.activeSelf
		local colorStr = isNotClick and "#808080" or "#FFFFFF"
		local color = GameUtil.parseColor(colorStr)

		self._imagebanner = self._imagebanner or gohelper.findChildImage(self._goroot, "#go_Item/#simage_banner")
		self._imagerareicon = self._imagerareicon or gohelper.findChildImage(self._goroot, "#go_Item/#simage_icon")
		self._imagebanner.color = color
		self._imagerareicon.color = color
	end
end

function DecorateGoodsItem:_refreshCost()
	gohelper.setActive(self._btnbuy.gameObject, not self._isFold)

	local costs = string.splitToNumber(self._mo.config.cost, "#")

	if string.nilorempty(self._mo.config.cost) then
		gohelper.setActive(self._gosingle, false)
		gohelper.setActive(self._godouble, false)
		gohelper.setActive(self._gofree, true)

		return
	end

	local offsetSecond = DecorateStoreModel.instance:getGoodItemLimitTime(self._mo.goodsId)
	local discount2 = offsetSecond > 0 and DecorateStoreModel.instance:getGoodDiscount(self._mo.goodsId) or 100

	discount2 = discount2 == 0 and 100 or discount2

	gohelper.setActive(self._gofree, false)

	if self._mo.config.cost2 ~= "" then
		gohelper.setActive(self._gosingle, false)
		gohelper.setActive(self._godouble, true)

		self._txtcurprice1.text = 0.01 * discount2 * costs[3]

		if self._decorateConfig.originalCost1 > 0 then
			gohelper.setActive(self._txtoriginalprice1.gameObject, true)

			self._txtoriginalprice1.text = self._decorateConfig.originalCost1
		else
			gohelper.setActive(self._txtoriginalprice1.gameObject, false)
		end

		local _, icon = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

		self._simagedoubleicon1:LoadImage(icon)

		local cost2s = string.splitToNumber(self._mo.config.cost2, "#")

		self._txtcurprice2.text = 0.01 * discount2 * cost2s[3]

		if self._decorateConfig.originalCost2 > 0 then
			gohelper.setActive(self._txtoriginalprice2.gameObject, true)

			self._txtoriginalprice2.text = self._decorateConfig.originalCost2
		else
			gohelper.setActive(self._txtoriginalprice2.gameObject, false)
		end

		local _, icon2 = ItemModel.instance:getItemConfigAndIcon(cost2s[1], cost2s[2])

		self._simagedoubleicon2:LoadImage(icon2)
	else
		gohelper.setActive(self._gosingle, true)
		gohelper.setActive(self._godouble, false)

		self._txtcurprice.text = 0.01 * discount2 * costs[3]

		if self._decorateConfig.originalCost1 > 0 then
			gohelper.setActive(self._txtoriginalprice.gameObject, true)

			self._txtoriginalprice.text = self._decorateConfig.originalCost1
		else
			gohelper.setActive(self._txtoriginalprice.gameObject, false)
		end

		local _, icon = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

		self._simagesingleicon:LoadImage(icon)
	end
end

function DecorateGoodsItem:_isShowReddot()
	local showReddot = StoreModel.instance:isTabSecondRedDotShow(self._mo.belongStoreId)
	local isFree = string.nilorempty(self._mo.config.cost)
	local has = self._mo.config.maxBuyCount > 0 and self._mo.buyCount >= self._mo.config.maxBuyCount

	return showReddot and isFree and not has
end

function DecorateGoodsItem:_refreshDeadline()
	local isShowReddot = self:_isShowReddot()
	local isGoodRead = DecorateStoreModel.instance:isGoodRead(self._mo.goodsId)

	if isShowReddot or not isGoodRead then
		gohelper.setActive(self._godeadline, false)

		return
	end

	local deadlineTimeSec = 0
	local deadlineHasDay = false

	if not string.nilorempty(self._mo.config.offlineTime) and type(self._mo.config.offlineTime) == "string" then
		local curGoodDeadlineTimeSec = TimeUtil.stringToTimestamp(self._mo.config.offlineTime) - ServerTime.now()

		deadlineTimeSec = curGoodDeadlineTimeSec > 0 and curGoodDeadlineTimeSec or 0
	end

	local needShowDeadline = deadlineTimeSec > 0 and deadlineTimeSec < TimeUtil.OneWeekSecond

	if needShowDeadline then
		self._txttime.text, self._txtformat.text, deadlineHasDay = TimeUtil.secondToRoughTime(math.floor(deadlineTimeSec), true)

		SLFramework.UGUI.GuiHelper.SetColor(self._txttime, deadlineHasDay and "#98D687" or "#E99B56")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtformat, deadlineHasDay and "#98D687" or "#E99B56")
		gohelper.setActive(self._godeadlineEffect, not deadlineHasDay)
		UISpriteSetMgr.instance:setCommonSprite(self._imagetimebg, deadlineHasDay and "daojishi_01" or "daojishi_02")
		UISpriteSetMgr.instance:setCommonSprite(self._imagetimeicon, deadlineHasDay and "daojishiicon_01" or "daojishiicon_02")
	end

	gohelper.setActive(self._godeadline, needShowDeadline)
end

function DecorateGoodsItem:playIn(index, isUnfold)
	if isUnfold or not index then
		self:_startPlayIn(true)

		return
	end

	self._index = index

	if self._isFold then
		self:_startPlayIn()

		return
	end

	TaskDispatcher.runDelay(self._startPlayIn, self, 0.03 * math.ceil(self._index / 4))
end

function DecorateGoodsItem:playOut()
	self._anim:Play("out", 0, 0)
end

function DecorateGoodsItem:_startPlayIn(noAnim)
	gohelper.setActive(self.go, true)

	if not noAnim then
		self._anim:Play("in", 0, 0)
	end
end

function DecorateGoodsItem:setFold(fold)
	self._isFold = fold

	self:_refreshUI()
end

function DecorateGoodsItem:_refreshReddot()
	local showReddot = self:_isShowReddot()

	gohelper.setActive(self._goreddot, showReddot)
end

function DecorateGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function DecorateGoodsItem:destroy()
	TaskDispatcher.cancelTask(self._startPlayIn, self)
	self:_removeEvents()
end

return DecorateGoodsItem
