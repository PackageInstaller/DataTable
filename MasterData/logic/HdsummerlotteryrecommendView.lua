-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/view/HdsummerlotteryrecommendView.lua

module("logic.extensions.hdsummerlotteryrecommend.view.HdsummerlotteryrecommendView", package.seeall)

local HdsummerlotteryrecommendView = class("HdsummerlotteryrecommendView", ViewComponent)

function HdsummerlotteryrecommendView:buildUI()
	HdsummerlotteryrecommendView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._btnClose = self:getBtn("btnClose")
	self._txtLeftName = goutil.findChildTextComponent(self.mainGO, "left/txtName")
	self._txtLeftBuy = goutil.findChildTextComponent(self.mainGO, "left/btnBuy/txtBuy")
	self._txtRightName = goutil.findChildTextComponent(self.mainGO, "right/txtName")
	self._txtRightBuy = goutil.findChildTextComponent(self.mainGO, "right/btnBuy/txtBuy")
	self._leftGo = self:getGo("left")
	self._rightGo = self:getGo("right")
	self._btnLeftBuy = self:getBtn("left/btnBuy")
	self._btnRightBuy = self:getBtn("right/btnBuy")
	self._leftItemCon = self:getGo("left/itemcon")
	self._rightItemCon = self:getGo("right/itemcon")
	self._leftSoldoutGo = self:getGo("left/soldout")
	self._rightSoldoutGo = self:getGo("right/soldout")
	self.oldPriceLeftGo = self:getGo("left/oldPrice")
	self.txtOldPriceLeft = self:getTxt("left/oldPrice/txtOldPrice")
	self.discountLeftGo = self:getGo("left/discount")
	self.txtDiscountLeft = self:getTxt("left/discount/txtDiscount")
	self.oldPriceRightGo = self:getGo("right/oldPrice")
	self.txtOldPriceRight = self:getTxt("right/oldPrice/txtOldPrice")
	self.discountRightGo = self:getGo("right/discount")
	self.txtDiscountRight = self:getTxt("right/discount/txtDiscount")
	self._leftItemList = {}
	self._rightItemList = {}

	self:_buildGoodsItem(self._leftItemList, self._leftItemCon.transform)
	self:_buildGoodsItem(self._rightItemList, self._rightItemCon.transform)

	self._btnOtherBuy = self:getBtn("right/btnGift")
	self._otherBuyEffectGo = self:getGo("right/btnGift/effect")
	self._soldoutGo = self:getGo("right/btnGift/soldout")
	self._bg = self:getGo("bg")
	self._leftPayIconChange = self:getGo("left/btnBuy/item"):GetComponent(ComponentType.UIChangeGroup)
	self._leftDiscPayIconChange = self:getGo("left/oldPrice/txtOldPrice/item"):GetComponent(ComponentType.UIChangeGroup)
	self._rightPayIconChange = self:getGo("right/btnBuy/item"):GetComponent(ComponentType.UIChangeGroup)
	self._rightDiscPayIconChange = self:getGo("right/oldPrice/txtOldPrice/item"):GetComponent(ComponentType.UIChangeGroup)
end

function HdsummerlotteryrecommendView:_buildGoodsItem(list, con)
	for i = 1, con.childCount do
		local mainGO = goutil.findChild(con, "item" .. i)
		local item = {
			txtNum = goutil.findChildTextComponent(mainGO, "txtNum"),
			icon = goutil.findChild(mainGO, "icon"),
			btn = GameUtil.asBtn(goutil.findChild(mainGO, "icon")),
			mainGO = mainGO
		}

		if i == 1 then
			local petExtCon = goutil.findChild(mainGO, "petExtCon")

			item.petExtCon = petExtCon
			item.petLvText = goutil.findChildTextComponent(petExtCon, "TxtC_Level")
			item.petAttrChange = goutil.findChild(petExtCon, "Img_attr"):GetComponent(ComponentType.UIImageSpriteChange)

			goutil.setActive(petExtCon, false)
		end

		list[i] = item
	end
end

function HdsummerlotteryrecommendView:bindEvents()
	HdsummerlotteryrecommendView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnLeftBuy:AddClickListener(self._onClickLeftbtnBuy, self)
	self._btnRightBuy:AddClickListener(self._onClickRightbtnBuy, self)
	self._btnOtherBuy:AddClickListener(self._onClickbtnOtherBuy, self)
end

function HdsummerlotteryrecommendView:unbindEvents()
	HdsummerlotteryrecommendView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnLeftBuy:RemoveClickListener()
	self._btnRightBuy:RemoveClickListener()
	self._btnOtherBuy:RemoveClickListener()
end

function HdsummerlotteryrecommendView:destroyUI()
	HdsummerlotteryrecommendView.super.destroyUI(self)
end

function HdsummerlotteryrecommendView:onEnter()
	HdsummerlotteryrecommendView.super.onEnter(self)

	self._funcId = checknumber(self:getFirstParam())

	if self._funcId <= 0 then
		printError("看看功能开启表 jumpTo 是不是配了 ui#hdsummerlotteryrecommendview#功能id")
	end

	self._leftDiscPlanId = false
	self._rightDiscPlanId = false
	self._leftGoodsId = self:_getShopIdByKey("FirstGiftId")
	self._rightGoodsId = self:_getShopIdByKey("SecGiftId")
	self._otherGoodsId = self:_getShopIdByKey("HdsOtherGiftId")

	local resName = DirectPurchaseConfig.instance:getSellShopConstValue(string.format("Func_%s_BG", self._funcId))

	self._bgResPath = GameUrl.getBigbgFolderUrl("hdsummerlottery", resName)

	uGuiUtil.setSpriteToImage(self._bg, nil, self._bgResPath)
	GlobalDispatcher:addListener(PayShopController.GetAllPayShopBuyTimesRes, self._updateView, self)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._updateView, self)
	HdsummerlotteryrecommendModel.instance:clearClickDot()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BEJ_DOT1, false, true)
	self:_updateView()
	self:_setActLeftTime()
	self:_showOtherBuyEffect()
end

function HdsummerlotteryrecommendView:onEnterFinished()
	HdsummerlotteryrecommendView.super.onEnterFinished(self)
end

function HdsummerlotteryrecommendView:onExit()
	HdsummerlotteryrecommendView.super.onExit(self)
	GlobalDispatcher:removeListener(PayShopController.GetAllPayShopBuyTimesRes, self._updateView, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._updateView, self)

	for k, v in pairs(self._leftItemList) do
		MaterialMgr.resetAll(v.icon)
	end

	for k, v in pairs(self._rightItemList) do
		MaterialMgr.resetAll(v.icon)
	end

	removetimer(self._updateTimer, self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
	uGuiUtil.clearImage(self._bg)
	MaterialMgr.resetAll(self._leftPayIconChange.gameObject)
	MaterialMgr.resetAll(self._leftDiscPayIconChange.gameObject)
	MaterialMgr.resetAll(self._rightPayIconChange.gameObject)
	MaterialMgr.resetAll(self._rightDiscPayIconChange.gameObject)
end

function HdsummerlotteryrecommendView:onExitFinished()
	HdsummerlotteryrecommendView.super.onExitFinished(self)
end

function HdsummerlotteryrecommendView:_onClickbtnClose()
	self:close()
end

function HdsummerlotteryrecommendView:_onClickLeftbtnBuy()
	if self._isLeftCanBuy then
		if self._leftTime <= 0 then
			FloatWordMgr.instance:show("活动已结束，无法购买")

			return
		end

		local data = PayShopModel.instance:getBuyData(self._leftGoodsId)

		if data then
			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data, false)
		end
	else
		FloatWordMgr.instance:show("商品已售罄")

		return
	end
end

function HdsummerlotteryrecommendView:_onClickRightbtnBuy()
	if self._isRightCanBuy then
		if self._leftTime <= 0 then
			FloatWordMgr.instance:show("活动已结束，无法购买")

			return
		end

		local data = PayShopModel.instance:getBuyData(self._rightGoodsId)

		if data then
			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data, false)
		end
	else
		FloatWordMgr.instance:show("商品已售罄")

		return
	end
end

function HdsummerlotteryrecommendView:_onClickbtnOtherBuy()
	local goodsId = self._otherGoodsId
	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(goodsId)

	if isCanBuy then
		local data = PayShopModel.instance:getBuyData(goodsId)

		if data then
			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data, self._showLeftTime)
		end
	else
		FloatWordMgr.instance:show(lang("text_recall_desc_6"))
	end
end

function HdsummerlotteryrecommendView:_updateView()
	self:_updateLeft()
	self:_updateRight()
	self:_chechkOtherGiftCanBuy()
end

function HdsummerlotteryrecommendView:_updateLeft()
	local goodsId = self._leftGoodsId
	local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)

	self._isLeftCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(goodsId)

	goutil.setActive(self._btnLeftBuy.gameObject, cfg)
	goutil.setActive(self._btnLeftBuy.gameObject, self._isLeftCanBuy)
	goutil.setActive(self._leftSoldoutGo, not self._isLeftCanBuy)

	if cfg then
		self._txtLeftName.text = cfg.name

		self:_setPayBtnTextAndIcon(cfg, self._txtLeftBuy, self._leftPayIconChange, self.oldPriceLeftGo, self.discountLeftGo)

		self._leftDiscPlanId = self:_setDiscountPayBtnTextAndIcon(cfg, self.txtOldPriceLeft, self._txtLeftBuy, self._leftDiscPayIconChange, self.oldPriceLeftGo, self.discountLeftGo, self.txtDiscountLeft)

		self:_setReward(self._leftItemList, cfg.content)
	end
end

function HdsummerlotteryrecommendView:_updateRight()
	local goodsId = self._rightGoodsId
	local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)

	self._isRightCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(goodsId)

	goutil.setActive(self._btnRightBuy.gameObject, cfg)
	goutil.setActive(self._btnRightBuy.gameObject, self._isRightCanBuy)
	goutil.setActive(self._rightSoldoutGo, not self._isRightCanBuy)

	if cfg then
		self._txtRightName.text = cfg.name

		self:_setPayBtnTextAndIcon(cfg, self._txtRightBuy, self._rightPayIconChange, self.oldPriceRightGo, self.discountRightGo)

		self._rightDiscPlanId = self:_setDiscountPayBtnTextAndIcon(cfg, self.txtOldPriceRight, self._txtRightBuy, self._rightDiscPayIconChange, self.oldPriceRightGo, self.discountRightGo, self.txtDiscountRight)

		self:_setReward(self._rightItemList, cfg.content)
	end
end

function HdsummerlotteryrecommendView:_setReward(itemList, content)
	local arr = string.split(content, "#")

	for i, v in ipairs(arr) do
		local temp = string.split(v, ":")

		goutil.setActive(itemList[i].mainGO, true)

		local matType = checknumber(temp[1])
		local matId = checknumber(temp[2])
		local matNum = checknumber(temp[#temp])

		goutil.setActive(itemList[i].petExtCon, matType == MatType.Pet)

		if matType == MatType.Pet and itemList[i].petExtCon then
			local petCo = CharacterConfig.instance:getPetCo(matId)

			if petCo then
				local race = PetSkinConfig.instance:getFisrtEleAttrIdx(matId)

				race = math.fmod(race, 10)

				local targetValue = race - 1

				itemList[i].petAttrChange:SetState(targetValue)
			end

			itemList[i].petLvText.text = checknumber(temp[3]) .. "级"
		end

		MaterialMgr.setIcon(itemList[i].icon, matType, matId)

		itemList[i].txtNum.text = matNum

		itemList[i].btn:AddClickListener(function()
			if matType == MatType.Pet then
				CommonTipsMgr.instance:openMaterialTips(itemList[i].icon, matType, matId, checknumber(temp[3]))
			else
				CommonTipsMgr.instance:openMaterialTips(itemList[i].icon, matType, matId, 0)
			end
		end)
	end

	for i = #arr + 1, #itemList do
		goutil.setActive(itemList[i].mainGO, false)
	end
end

function HdsummerlotteryrecommendView:_setActLeftTime()
	local value = self._funcId
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(value)
	local arr = string.split(cfg.openTime, "#")
	local time = GameUtil.string2time(arr[2])

	self._leftTime = time - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function HdsummerlotteryrecommendView:_updateTimer()
	self._leftTime = self._leftTime - 1

	if self._leftTime > 0 then
		self._txtLeftTime.text = self:_formatLeftTimeStr(self._leftTime)
	else
		self:_actEndOp()
	end
end

function HdsummerlotteryrecommendView:_formatLeftTimeStr(leftTime)
	local d, h, m, s = GameUtil.getTimeDDHHMMSS(leftTime)
	local hstr = h
	local mstr = m
	local sstr = s

	if h < 10 then
		hstr = "0" .. h
	end

	if m < 10 then
		mstr = "0" .. m
	end

	if s < 10 then
		sstr = "0" .. s
	end

	return d > 0 and string.format("时间剩余：%s天%s时%s分", d, hstr, mstr) or h > 0 and string.format("时间剩余：%s时%s分%s秒", hstr, mstr, sstr) or string.format("时间剩余：%s分%s秒", mstr, sstr)
end

function HdsummerlotteryrecommendView:_actEndOp()
	self._txtLeftTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function HdsummerlotteryrecommendView:_showOtherBuyEffect()
	local goodsId = self._otherGoodsId

	if goodsId <= 0 then
		return
	end

	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(goodsId)

	if isCanBuy then
		local effName = "fx_ui_fuli/fx_ui_fuli_lingqu.prefab"

		self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

		self._effectHandler:setParent(self._otherBuyEffectGo.transform)
		self._effectHandler:setLocalPos(0, 0, 0)
		self._effectHandler:setScale(1)
	end
end

function HdsummerlotteryrecommendView:_chechkOtherGiftCanBuy()
	local goodsId = self._otherGoodsId

	goutil.setActive(self._btnOtherBuy.gameObject, goodsId > 0)

	if goodsId <= 0 then
		return
	end

	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(goodsId)

	goutil.setActive(self._soldoutGo, not isCanBuy)

	if not isCanBuy and self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)
	end
end

function HdsummerlotteryrecommendView:_getShopIdByKey(key)
	local content = DirectPurchaseConfig.instance:getSellShopConstValue(key)
	local s, e = string.find(content, self._funcId .. ":%d+")
	local goodsId = 0

	if s then
		local str = string.sub(content, s, e)
		local value = string.gsub(str, self._funcId .. ":", "")
		local id = checknumber(value)
		local cfgItem = DirectPurchaseConfig.instance:getSellShopMultiCfg(id)

		goodsId = cfgItem.shopItemId
	end

	return checknumber(goodsId)
end

function HdsummerlotteryrecommendView:_setPayBtnTextAndIcon(goodsCfg, txtPrice, payIconChange, oldPriceRootGo, disCountRootGo)
	goutil.setActive(oldPriceRootGo, false)
	goutil.setActive(disCountRootGo, false)

	local payGoodsId = goodsCfg.originalGoodsId

	if goodsCfg.payType == GameEnum.PayShopPayType.RMB then
		payIconChange:SetState(0)

		txtPrice.text = PayConfig.instance:getPayMoneyYuan(payGoodsId)
	elseif goodsCfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
		payIconChange:SetState(1)

		local list = string.split(payGoodsId, ":")
		local matType = checknumber(list[1])
		local matId = checknumber(list[2])

		txtPrice.text = list[#list]

		MaterialMgr.setIcon(payIconChange.gameObject, matType, matId)
	end
end

function HdsummerlotteryrecommendView:_setDiscountPayBtnTextAndIcon(goodsCfg, txtPriceOld, txtPriceNew, payIconChange, oldPriceRootGo, disCountRootGo, txtDiscount)
	local discountPlanId

	if goodsCfg.discountPlans and goodsCfg.discountLimitTimes <= 0 then
		printError("discountLimitTimes 不可为0，id", goodsCfg.id)
	end

	goutil.setActive(oldPriceRootGo, false)
	goutil.setActive(disCountRootGo, false)

	local useTime = PayShopController.instance:getUseDiscountTimes(goodsCfg.id)

	if useTime >= goodsCfg.discountLimitTimes then
		return
	end

	if goodsCfg.discountPlans then
		local dcfgs = {}

		for i, v in ipairs(goodsCfg.discountPlans) do
			local dcfg = PayShopConfig.instance:getDiscountPlanCfg(v)

			if PayShopController.instance:checkDiscountPlanConditionPass(v) then
				table.insert(dcfgs, dcfg)
			end
		end

		if #dcfgs > 0 then
			txtPriceOld.text = txtPriceNew.text

			table.sort(dcfgs, function(a, b)
				return a.id < b.id
			end)

			local dcfg = dcfgs[1]
			local payGoodsId = dcfg.discountPrice

			discountPlanId = dcfg.id

			goutil.setActive(oldPriceRootGo, true)

			if goodsCfg.payType == GameEnum.PayShopPayType.RMB then
				payIconChange:SetState(0)

				txtPriceNew.text = PayConfig.instance:getPayMoneyYuan(payGoodsId)
			elseif goodsCfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
				payIconChange:SetState(1)

				local list = string.split(payGoodsId, ":")
				local matType = checknumber(list[1])
				local matId = checknumber(list[2])

				txtPriceNew.text = list[#list]

				MaterialMgr.setIcon(payIconChange.gameObject, matType, matId)
			end
		end

		goutil.setActive(self.discountLeftGo, self._isLeftCanBuy)
		goutil.setActive(self.discountRightGo, self._isRightCanBuy)

		txtDiscount.text = string.format("限时特惠")
	end

	return discountPlanId
end

return HdsummerlotteryrecommendView
