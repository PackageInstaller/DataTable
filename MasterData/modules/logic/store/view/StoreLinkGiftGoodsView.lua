-- chunkname: @modules/logic/store/view/StoreLinkGiftGoodsView.lua

module("modules.logic.store.view.StoreLinkGiftGoodsView", package.seeall)

local StoreLinkGiftGoodsView = class("StoreLinkGiftGoodsView", BaseView)

function StoreLinkGiftGoodsView:onInitView()
	self._txtgoodsNameCn = gohelper.findChildText(self.viewGO, "view/common/title/#txt_goodsNameCn")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/#btn_buy")
	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "view/common/#btn_buy/cost/#txt_materialNum")
	self._txtprice = gohelper.findChildText(self.viewGO, "view/common/#btn_buy/cost/#txt_price")
	self._gohasget = gohelper.findChild(self.viewGO, "view/common/#go_hasget")
	self._goleftbg = gohelper.findChild(self.viewGO, "view/normal/remain/#go_leftbg")
	self._txtremain = gohelper.findChildText(self.viewGO, "view/normal/remain/#go_leftbg/#txt_remain")
	self._gorightbg = gohelper.findChild(self.viewGO, "view/normal/remain/#go_rightbg")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "view/normal/remain/#go_rightbg/#txt_remaintime")
	self._txtgoodsUseDesc = gohelper.findChildText(self.viewGO, "view/normal/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	self._txtgoodsDesc = gohelper.findChildText(self.viewGO, "view/normal/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	self._simagerewardIcon = gohelper.findChildSingleImage(self.viewGO, "view/normal/reward/right/hasget/#simage_rewardIcon")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_close")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreLinkGiftGoodsView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function StoreLinkGiftGoodsView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function StoreLinkGiftGoodsView:_btnbuyOnClick()
	local isCurGoodHasNext = StoreConfig.instance:hasNextGood(self._mo.id)

	if isCurGoodHasNext then
		StoreModel.instance:setCurBuyPackageId(self._mo.id)
	end

	if self._mo.isChargeGoods then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
		PayController.instance:startPay(self._mo.goodsId)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

		if self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			if CurrencyController.instance:checkFreeDiamondEnough(self._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._buyGoods, self, self.closeThis, self) then
				self:_buyGoods()
			end
		elseif self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.Diamond then
			if CurrencyController.instance:checkDiamondEnough(self._costQuantity, self.closeThis, self) then
				self:_buyGoods()
			end
		else
			self:_buyGoods()
		end
	end
end

function StoreLinkGiftGoodsView:_btncloseOnClick()
	self:closeThis()
end

function StoreLinkGiftGoodsView:_editableInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "view/normal")
	self._goremain = gohelper.findChild(self._gonormal, "info/remain")
	self._gotxtgoodsDesc = gohelper.findChild(self.viewGO, "view/normal/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	self._imagematerial = gohelper.findChildImage(self.viewGO, "view/common/#btn_buy/cost/simage_material")
	self._txtnum = gohelper.findChildText(self.viewGO, "view/left/num1/txt_num")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "view/left/num2/txt_num")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "view/left/num3/txt_num")
	self._txttipnum = gohelper.findChildText(self.viewGO, "view/left/Tips/#txt_num")
	self._simagecurrency = gohelper.findChildSingleImage(self.viewGO, "view/left/num1/icon")
	self._simagecurrency2 = gohelper.findChildSingleImage(self.viewGO, "view/left/num2/icon")
	self._simagecurrency3 = gohelper.findChildSingleImage(self.viewGO, "view/left/num3/icon")
	self._gonum = gohelper.findChild(self.viewGO, "view/left/num1")
	self._gonum2 = gohelper.findChild(self.viewGO, "view/left/num2")
	self._gonum3 = gohelper.findChild(self.viewGO, "view/left/num3")
	self._goimagedec = gohelper.findChild(self.viewGO, "view/left/image_dec")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "view/left/simage_icon")
	self._imageicon = gohelper.findChildImage(self.viewGO, "view/left/simage_icon")
	self._goleftIcon = gohelper.findChild(self.viewGO, "view/normal/reward/left/normal/#simage_leftIcon")
	self._gotxtnormal = gohelper.findChild(self.viewGO, "view/normal/reward/left/normal/txt_normal")
	self._gorightIcon = gohelper.findChild(self.viewGO, "view/normal/reward/right/lock/#simage_rightIcon")
	self._golefthasget = gohelper.findChild(self.viewGO, "view/normal/reward/left/hasget")
	self._gofigithasget = gohelper.findChild(self.viewGO, "view/normal/reward/right/hasget")
	self._txtlock = gohelper.findChildText(self.viewGO, "view/normal/reward/right/lock/txt_lock")
	self._golockicon = gohelper.findChild(self.viewGO, "view/normal/reward/right/lock/lockicon")
	self._golockBg = gohelper.findChild(self.viewGO, "view/normal/reward/right/lock/bg")
	self._gounlockBg = gohelper.findChild(self.viewGO, "view/normal/reward/right/lock/unlockbg")

	gohelper.setActive(self._txtgoodsDesc, false)
	gohelper.setActive(self._txtgoodsUseDesc, false)

	self._canvasGroup = gohelper.onceAddComponent(self._gorightIcon, typeof(UnityEngine.CanvasGroup))
end

function StoreLinkGiftGoodsView:onUpdateParam()
	return
end

function StoreLinkGiftGoodsView:onOpen()
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)

	self._mo = self.viewParam

	self:_refreshPriceArea()
	self:_updateNormal()
	StoreController.instance:statOpenChargeGoods(self._mo.belongStoreId, self._mo.config)
end

function StoreLinkGiftGoodsView:onClose()
	return
end

function StoreLinkGiftGoodsView:onDestroyView()
	self._simageicon:UnLoadImage()
	self._simagecurrency:UnLoadImage()
	self._simagecurrency2:UnLoadImage()
	self._simagecurrency3:UnLoadImage()
end

function StoreLinkGiftGoodsView:_updateNormal()
	local isLevelOpen = self._mo:isLevelOpen()
	local isCanBuy = self._mo.maxBuyCount > self._mo.buyCount
	local isAlreadyBuy = self._mo.buyCount > 0
	local isUnlock = StoreCharageConditionalHelper.isCharageCondition(self._mo.id)
	local isTaskNotFinish = StoreCharageConditionalHelper.isCharageTaskNotFinish(self._mo.id)
	local condCfg = StoreConfig.instance:getChargeConditionalConfig(self._mo.config.taskid)

	if not isAlreadyBuy and isUnlock then
		StoreGoodsTaskController.instance:setAutoFininishTaskId(self._mo.config.taskid)
	end

	local iconName = condCfg.bigImg2
	local showCondIcon = true

	if isCanBuy and isUnlock then
		showCondIcon = false
		iconName = self._mo.config.bigImg
	end

	gohelper.setActive(self._btnbuy, isLevelOpen and isCanBuy)
	gohelper.setActive(self._gohasget, not isCanBuy)
	gohelper.setActive(self._gotxtnormal, isCanBuy)
	gohelper.setActive(self._golefthasget, isAlreadyBuy)
	gohelper.setActive(self._goleftTxt, not isAlreadyBuy)
	gohelper.setActive(self._golockicon, not isUnlock)
	gohelper.setActive(self._golockBg, not isUnlock)
	gohelper.setActive(self._gounlockBg, isUnlock)
	gohelper.setActive(self._gofigithasget, not isTaskNotFinish)
	gohelper.setActive(self._txtlock, isTaskNotFinish)

	self._txtgoodsNameCn.text = self._mo.config.name
	self._txtlock.text = isUnlock and luaLang("store_linkfigt_getitnow_txt") or condCfg and condCfg.conDesc

	self._simageicon:LoadImage(ResUrl.getStorePackageIcon(iconName), self._onIconLoadFinish, self)

	if self._mo.offlineTime > 0 then
		local limitSec = math.floor(self._mo.offlineTime - ServerTime.now())

		self._txtremaintime.text = string.format("%s%s", TimeUtil.secondToRoughTime(limitSec))
	end

	self:_updateNormalPackCommon(self._goleftbg, self._txtremain, self._goremain)

	local detailDesc = self._mo.config.detailDesc
	local detailDescStrList = string.split(detailDesc, "\n")

	gohelper.CreateObjList(self, self._onDescItemShow, detailDescStrList, nil, self._gotxtgoodsDesc)

	if self._mo.config.product then
		local bonusList = GameUtil.splitString2(self._mo.config.product, true)
		local condBonusList = condCfg and GameUtil.splitString2(condCfg.bonus, true)

		gohelper.setActive(self._gonum, showCondIcon)
		gohelper.setActive(self._gonum2, showCondIcon)
		gohelper.setActive(self._goimagedec, showCondIcon)
		gohelper.setActive(self._gonum3, not showCondIcon)

		local bounsCount, summonCount = self:_getRewardCount(bonusList)
		local condBonusCount, condSummonCount = self:_getRewardCount(condBonusList)

		if showCondIcon then
			self._txtnum.text = self:_getNumStr(bounsCount)
			self._txtnum2.text = self:_getNumStr(condBonusCount)

			StoreLinkGiftGoodsView.setCurrencyIconByBouns(self._simagecurrency, bonusList)
			StoreLinkGiftGoodsView.setCurrencyIconByBouns(self._simagecurrency2, condBonusList)
		else
			self._txtnum3.text = self:_getNumStr(bounsCount + condBonusCount)

			StoreLinkGiftGoodsView.setCurrencyIconByBouns(self._simagecurrency3, bonusList)
		end

		self._iconItemList = self._iconItemList or self:getUserDataTb_()
		self._iconItem2List = self._iconItem2List or self:getUserDataTb_()

		self:_setIconBouns(self._iconItemList, bonusList, self._goleftIcon)
		self:_setIconBouns(self._iconItem2List, condBonusList, self._gorightIcon)

		self._txttipnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_store_linkgift_totalcount2_txt"), summonCount + condSummonCount)
	end
end

function StoreLinkGiftGoodsView:_getNumStr(num)
	return string.format("×<size=32>%s", num)
end

function StoreLinkGiftGoodsView:_onIconLoadFinish()
	self._imageicon:SetNativeSize()
end

function StoreLinkGiftGoodsView:_onDescItemShow(itemViewGo, str, index)
	local txtDesc = gohelper.findChildText(itemViewGo, "")

	txtDesc.text = str
end

function StoreLinkGiftGoodsView:_refreshPriceArea()
	local cost = self._mo.cost

	gohelper.setActive(self._txtprice.gameObject, self._mo.config.originalCost > 0)

	if string.nilorempty(cost) or cost == 0 then
		self._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(self._imagematerial, false)
	elseif self._mo.isChargeGoods then
		self._txtmaterialNum.text = string.format("%s %s", StoreModel.instance:getCostSymbolAndPrice(self._mo.id))
		self._txtprice.text = StoreModel.instance:getOriginCostPriceFull(self._mo.id)

		gohelper.setActive(self._imagematerial, false)
	else
		local costs = GameUtil.splitString2(cost, true)

		if not costs[self._mo.buyCount + 1] then
			self._costType = costs[self._mo.buyCount + 1][1]
			self._costId = costs[self._mo.buyCount + 1][2]
			self._costQuantity = costs[self._mo.buyCount + 1][3]

			local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)
			local id = costConfig.icon
			local str = string.format("%s_1", id)

			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerial, str)

			self._txtmaterialNum.text = self._costQuantity
			self._txtprice.text = self._mo.config.originalCost

			gohelper.setActive(self._imagematerial, true)

			local hadQuantity = ItemModel.instance:getItemQuantity(self._costType, self._costId)

			if hadQuantity >= self._costQuantity then
				SLFramework.UGUI.GuiHelper.SetColor(self._txtmaterialNum, "#393939")
			else
				SLFramework.UGUI.GuiHelper.SetColor(self._txtmaterialNum, "#bf2e11")
			end
		end
	end
end

function StoreLinkGiftGoodsView:_getRewardCount(bonusList)
	local count = 0
	local summonCount = 0

	if bonusList and #bonusList > 0 then
		for i, bonus in ipairs(bonusList) do
			if bonus and #bonus >= 3 then
				count = count + bonus[3]
				summonCount = summonCount + SummonConfig.instance:getSummonCountByItemId(bonus[2]) * bonus[3]
			end
		end
	end

	return count, summonCount
end

function StoreLinkGiftGoodsView:_updateNormalPackCommon(leftbg, txtremain, goremain)
	local maxBuyCount = self._mo.maxBuyCount
	local remain = maxBuyCount - self._mo.buyCount
	local content

	if self._mo.isChargeGoods then
		content = StoreConfig.instance:getChargeRemainText(maxBuyCount, self._mo.refreshTime, remain, self._mo.offlineTime)
	else
		local showRefreshTime = StoreHelper.getShowRefreshTimeByGoodsMO(self._mo)

		content = StoreConfig.instance:getRemainText(maxBuyCount, showRefreshTime, remain, self._mo.offlineTime)
	end

	if string.nilorempty(content) then
		gohelper.setActive(leftbg, false)
		gohelper.setActive(txtremain.gameObject, false)
		gohelper.setActive(goremain, self._mo.offlineTime > 0)
	else
		gohelper.setActive(leftbg, true)
		gohelper.setActive(txtremain.gameObject, true)

		txtremain.text = content
	end
end

function StoreLinkGiftGoodsView:_get2GOList(go1, go2)
	local list = self:getUserDataTb_()

	table.insert(list, go1)
	table.insert(list, go2)

	return list
end

function StoreLinkGiftGoodsView:_setIconBouns(iconList, bonusList, parentGO)
	if not bonusList then
		return
	end

	local countIdx = 0

	for i, bonus in ipairs(bonusList) do
		if bonus and #bonus >= 2 then
			countIdx = countIdx + 1

			local itemIcon = iconList[countIdx]

			if not itemIcon then
				itemIcon = IconMgr.instance:getCommonItemIcon(parentGO)

				table.insert(iconList, itemIcon)
			end

			local itemType = bonus[1]
			local itemId = bonus[2]

			if not bonus[3] then
				self:_setIcon(itemIcon, itemType, itemId, bonus[3])
			end
		end
	end
end

function StoreLinkGiftGoodsView:_setIcon(icon, type, id, quantity)
	icon:setMOValue(type, id, quantity, nil, true)
	icon:setCantJump(true)
	icon:setCountFontSize(36)
	icon:setScale(0.7)
	icon:SetCountLocalY(43.6)
	icon:SetCountBgHeight(25)
end

function StoreLinkGiftGoodsView:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
	end
end

function StoreLinkGiftGoodsView:_payFinished()
	self:closeThis()
end

function StoreLinkGiftGoodsView.setCurrencyIconByBouns(simageIcon, bonusList)
	if not bonusList or not simageIcon then
		return
	end

	for i, bonus in ipairs(bonusList) do
		if bonus and #bonus >= 2 then
			local itemType = bonus[1]
			local itemId = bonus[2]

			simageIcon:LoadImage(SummonMainModel.getSummonItemIcon(itemType, itemId))
		end
	end
end

return StoreLinkGiftGoodsView
