-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayShopMibaoBuyView.lua

module("logic.extensions.payshop.view.PayShopMibaoBuyView", package.seeall)

local PayShopMibaoBuyView = class("PayShopMibaoBuyView", ViewComponent)

function PayShopMibaoBuyView:ctor()
	PayShopMibaoBuyView.super.ctor(self)
end

function PayShopMibaoBuyView:buildUI()
	PayShopMibaoBuyView.super.buildUI(self)

	self._closeBtn = GameUtil.asBtn(self:getGo("closeBtn"))
	self._buyBtn = self:getBtn("buyBtn")
	self._tipText = goutil.findChildTextComponent(self.mainGO, "tipText")
	self._limitText = goutil.findChildTextComponent(self.mainGO, "limitText")
	self._disCountText = goutil.findChildTextComponent(self.mainGO, "disCountImg/text")
	self._buyBtnText = goutil.findChildTextComponent(self.mainGO, "buyBtn/text")
	self._disCountGo = self:getGo("disCountImg")
	self._discountRoot = self:getGo("discountRoot")

	GameUtil.SetActive(self._disCountGo, false)

	self._payIconChange = self:getGo("buyBtn/text"):GetComponent(ComponentType.UIChangeGroup)
	self._payIconGo = self:getGo("buyBtn/text/payIcon")
	self._giftTypePanelGo = self:getGo("giftTypePanel")
	self._norTypePanelGo = self:getGo("norTypePanel")
	self._norTypePanelTr = self._norTypePanelGo.transform
	self._bg_5Tr = self:getGo("bggroup_lv2/bg1/bg_5").transform
	self._daygetContentGo = self:getGo("giftTypePanel/daygettableview/Nego_Viewport/Nego_Content")
	self._immgetContentGo = self:getGo("giftTypePanel/immgettableview/Nego_Viewport/Nego_Content")

	local cell = self:getGo("giftTypePanel/tablecell")

	self._dayGetItemGroup = ItemGroup.New(self._daygetContentGo, cell, nil, nil, true)
	self._immGetItemGroup = ItemGroup.New(self._immgetContentGo, cell, nil, nil, true)
	self._daygetText = goutil.findChildTextComponent(self.mainGO, "giftTypePanel/dayget/text")
	self._redPackageRootGo = self:getGo("redPackageRoot")
	self._toggleCashCoupon = self:getToggle("redPackageRoot/toggleCashCoupon")
	self._txtCostCashCoupon = goutil.findChildTextComponent(self.mainGO, "redPackageRoot/txtCostCashCoupon")
	self._btnRedPackage = self:getBtn("redPackageRoot/btnRedPackage")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._txtRebateTime = goutil.findChildTextComponent(self.mainGO, "txtRebateTime")
	self._txtDiscountTime = goutil.findChildTextComponent(self.mainGO, "discountRoot/txtDiscountTime")
	self._scrollList = {}
	self._nor_Nego_ViewportTrSize = self:getGo("norTypePanel/tableview/Nego_Viewport").transform.sizeDelta
	self._norCellGo = self:getGo("norTypePanel/tablecell")
	self._norTableViewComp = self:getGo("norTypePanel/tableview"):GetComponent(ComponentType.UITableview)
	self._norTableViewComp.enabled = false
	self._norAutoSizeNum = math.floor(self._nor_Nego_ViewportTrSize.x / self:_getNorItemSpace())
	self._norAutoSizeNum = self._norAutoSizeNum - self._norAutoSizeNum % 2
	self._norItemContentGo = self:getGo("norTypePanel/tableview/Nego_Viewport/Nego_Content")
	self._norItemContentTr = self._norItemContentGo.transform
	self._norItemGroup = ItemGroup.New(self._norItemContentGo, self._norCellGo, nil, nil, true)
	self._discountShowRootGo = self:getGo("discountShowRoot")
	self._discountPart = GameUtil.AddLuaOnce(self._discountShowRootGo, PayshopMibaoBuyDiscountPart)
	self._batchBuyRootGo = self:getGo("batchBuyRoot")
	self._batchBuyPart = GameUtil.AddLuaOnce(self._batchBuyRootGo, PayshopMibaoBuyBatchPart)
end

function PayShopMibaoBuyView:bindEvents()
	PayShopMibaoBuyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._buyBtn:AddClickListener(self._onClickBuy, self)
	self._btnRedPackage:AddClickListener(self._onClickbtnRedPackage, self)
end

function PayShopMibaoBuyView:unbindEvents()
	PayShopMibaoBuyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
	self._btnRedPackage:RemoveClickListener()
end

function PayShopMibaoBuyView:destroyUI()
	PayShopMibaoBuyView.super.destroyUI(self)
end

function PayShopMibaoBuyView:onEnter()
	PayShopMibaoBuyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PayShopSelectDiscountId, self._payShopSelectDiscountId, self)

	self._isFirstEnter = true
	self._selectBuyNum = 1

	local params = self:getOpenParam()

	self.data = params[1]
	self._goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self.data.id)
	self._showLeftTime = params[2]
	self._discountPlanId = params[3] or 0

	self:_calOldPrice(self._goodsCfg)
	self:_initView()
	self._discountPart:onEnter(self._goodsCfg)
	self._batchBuyPart:AddListener(self._onBatchSelect, self)
	self._batchBuyPart:onEnter(self._goodsCfg.id, self._selectBuyNum)
	self:_autoGetBestDiscountId()
	self:_adjustView()
end

function PayShopMibaoBuyView:onEnterFinished()
	PayShopMibaoBuyView.super.onEnterFinished(self)
end

function PayShopMibaoBuyView:onExit()
	PayShopMibaoBuyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PayShopSelectDiscountId, self._payShopSelectDiscountId, self)
	MaterialMgr.resetAll(self._tableview)
	self._dayGetItemGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
	self._immGetItemGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
	removetimer(self._updateTimer, self)
	MaterialMgr.resetAll(self._payIconGo)
	self._norItemGroup:dispose(function(item)
		self:_clearTableview(item)
	end)
	self._discountPart:onExit()
	self._batchBuyPart:onExit()
	self._batchBuyPart:RemoveListener()
end

function PayShopMibaoBuyView:onExitFinished()
	PayShopMibaoBuyView.super.onExitFinished(self)
end

function PayShopMibaoBuyView:_initView()
	local goodsCfg = self._goodsCfg

	if goodsCfg then
		self:showReward(goodsCfg)
		self:showLimitText(goodsCfg)
		self:setDisCount(goodsCfg)
		self:_checkMonthCardBuy(goodsCfg)
		self:_checkVipBuy(goodsCfg)
		self:_setBtnTextPos()
		self:_setCashCouponUse()
		self:_setLeftTime(goodsCfg)
	end
end

function PayShopMibaoBuyView:isFirstBuy(cfg)
	if self.data and self.data.totalBuyTimes and self.data.totalBuyTimes <= 0 and string.trim(cfg.firstBuyExtraContent) ~= "" then
		return true
	end

	return false
end

function PayShopMibaoBuyView:showLimitText(goodsCfg)
	if goodsCfg.sellTargetLimit == "none" then
		self._limitText.text = ""
		self._tipText.text = ""

		return
	end

	local preStr = "限购："

	if goodsCfg.limitType == "daily" then
		self._tipText.text = "每天5:00刷新"
		preStr = "每日限购："
	elseif goodsCfg.limitType == "weekly" then
		self._tipText.text = "每周五5:00刷新"
		preStr = "每周限购："
	elseif goodsCfg.limitType == "monthly" then
		self._tipText.text = "每月1日5:00刷新"
		preStr = "每月限购："
	elseif goodsCfg.limitType == "allTime" then
		self._tipText.text = ""
		preStr = "永久限购："
	elseif goodsCfg.limitType == "none" then
		self._limitText.text = ""
		self._tipText.text = ""

		return
	end

	self._limitText.text = preStr .. math.max(goodsCfg.limitTimes - self.data.times, 0) .. "/" .. goodsCfg.limitTimes
end

function PayShopMibaoBuyView:showReward(cfg)
	local isgift = cfg.groupId > 0

	goutil.setActive(self._norTypePanelGo, not isgift)
	goutil.setActive(self._giftTypePanelGo, isgift)

	if isgift then
		self:_showGiftReward(cfg)
	else
		self:_showNorReward(cfg)
	end
end

function PayShopMibaoBuyView:_showGiftReward(cfg)
	local list = {}

	if self:isFirstBuy(cfg) then
		table.insert(list, cfg.firstBuyExtraContent)
	end

	local arr = string.split(cfg.content, "#")

	for i, v in ipairs(arr) do
		table.insert(list, v)
	end

	self._immGetItemGroup:updateWithMoArray(list, function(item, data)
		MaterialMgr.setCellByCfg(data, item.mainGO)
	end)

	local list2 = {}
	local gcfg = PayShopConfig.instance:getGroupCfg(cfg.groupId)
	local arr = string.split(gcfg.presentGain, "#")

	for i, v in ipairs(arr) do
		table.insert(list2, v)
	end

	self._dayGetItemGroup:updateWithMoArray(list2, function(item, data)
		MaterialMgr.setCellByCfg(data, item.mainGO)
	end)

	self._daygetText.text = string.format("连续%s天，每天5:00邮件发送", gcfg.totalDays)
end

function PayShopMibaoBuyView:_showNorReward(cfg)
	local list = {}

	if self:isFirstBuy(cfg) then
		table.insert(list, cfg.firstBuyExtraContent)
	end

	local arr = string.split(cfg.content, "#")

	for i, v in ipairs(arr) do
		table.insert(list, v)
	end

	local len = #list
	local startPosX = 0

	if len <= self._norAutoSizeNum then
		self._norItemContentTr.sizeDelta = Vector2.New(self._nor_Nego_ViewportTrSize.x, self._nor_Nego_ViewportTrSize.y)

		local halfSizeX = math.floor(self._nor_Nego_ViewportTrSize.x / 2)

		if self._norAutoSizeNum % 2 == 0 then
			local num = len / 2

			startPosX = halfSizeX - self:_getNorItemSpace() * num
		else
			local num = (len - 1) / 2

			startPosX = halfSizeX - self:_getNorItemSpace() / 2 - self:_getNorItemSpace() * num
		end
	else
		self._norItemContentTr.sizeDelta = Vector2.New(self:_getNorItemSpace() * len, self._nor_Nego_ViewportTrSize.y)
	end

	self._norItemGroup:updateWithMoArray(list, function(item, cfgStr)
		self:_updateNorCell(item, cfgStr, startPosX)
	end)
end

function PayShopMibaoBuyView:_updateNorCell(item, cfgStr, startPosX)
	local goCon = goutil.findChild(item.mainGO, "root/con")
	local txtName = goutil.findChildTextComponent(item.mainGO, "root/txtName")

	txtName.text = MaterialMgr.getMaterialsNameByCfg(cfgStr)

	local proxy = MaterialMgr.setCellByCfg(cfgStr, goCon)
	local list = string.split(cfgStr, ":")

	proxy.binder:setNum(checknumber(list[#list]) * self._selectBuyNum)
	Framework.TransformUtil.SetAnchoredPos(item.mainGO.transform, startPosX + (item.index - 1) * self:_getNorItemSpace(), 0)
end

function PayShopMibaoBuyView:_clearTableview(item)
	local goCon = goutil.findChild(item.mainGO, "root/con")

	MaterialMgr.resetAll(goCon)
end

function PayShopMibaoBuyView:_onClickBuy()
	if self._isNeedBuyMonthCard then
		UIStateManager.instance:popByName(ViewName.PayShopMainView)
		PayShopController.instance:openView(GameEnum.PayShopEasyJump.MonthCard)
		self:close()

		return
	end

	if self._isNeedBuyVip then
		UIStateManager.instance:push(ViewName.VipView)
		self:close()

		return
	end

	if self._isNeedVipLv then
		FloatWordMgr.instance:show(string.format("达到VIP%s后解锁", self._isNeedVipLv))

		return
	end

	local content = ""
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self.data.id)

	if goodsCfg then
		if self:_checkGoodsSellOut(goodsCfg) then
			FloatWordMgr.instance:show("已售罄")

			return
		end

		if self:_isGodGemBuy(goodsCfg.originalGoodsId) and self:_checkEnoughAndOpenSourceView(goodsCfg.originalGoodsId) then
			return
		end

		content = goodsCfg.content
	end

	local boo = ItemBagController.instance:checkItemChangeWhenGet(content, GameUtil.handler(self._openSureBuyTip, self))

	if boo then
		return
	end

	self:_openSureBuyTip()
end

function PayShopMibaoBuyView:_openSureBuyTip()
	local goodsCfg = self._goodsCfg
	local isFree = string.nilorempty(goodsCfg.originalGoodsId)

	if not isFree and goodsCfg.payType ~= GameEnum.PayShopPayType.RMB then
		local currPayGoodsId = goodsCfg.originalGoodsId

		if self._discountPlanId > 0 then
			local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._discountPlanId)

			currPayGoodsId = dcfg.discountPrice
		end

		local oriCostNum = 0
		local oriUseNum = 0

		if self._discountPlanId > 0 then
			local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._discountPlanId)

			if not string.nilorempty(dcfg.discountCost) then
				local hasNum = MaterialMgr.getMatCount(dcfg.discountCost)

				if self._goodsCfg.discountLimitTimes > 0 then
					local useTime = PayShopModel.instance:getUseDiscountTimes(self._goodsCfg.id)

					oriUseNum = self._selectBuyNum - math.min(self._goodsCfg.discountLimitTimes - useTime, hasNum)
				else
					oriUseNum = self._selectBuyNum - hasNum
				end
			end

			oriUseNum = math.max(oriUseNum, 0)

			if oriUseNum > 0 then
				if self._goodsCfg.payType == GameEnum.PayShopPayType.RMB then
					oriCostNum = PayConfig.instance:getPayMoneyYuan(self._goodsCfg.originalGoodsId) * oriUseNum
				elseif self._goodsCfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
					local list = string.split(self._goodsCfg.originalGoodsId, ":")

					oriCostNum = checknumber(list[#list]) * oriUseNum
				end
			end
		end

		local arr = string.split(currPayGoodsId, ":")
		local matType = checkint(arr[1])
		local matId = checkint(arr[2])
		local matNum = checkint(arr[#arr])
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local totalCost = 0

		totalCost = oriUseNum > 0 and (self._selectBuyNum - oriUseNum) * matNum + oriCostNum or matNum * self._selectBuyNum

		local content = string.format("确定要花费%s%s，购买%s个%s吗?", totalCost, matName, self._selectBuyNum, goodsCfg.name)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, totalCost, content, function()
			PayShopController.instance:buyShopItem(self.data.id, self._selectBuyNum, self._discountPlanId)
			self:close()
		end)
	else
		PayShopController.instance:buyShopItem(self.data.id, self._selectBuyNum, self._discountPlanId)
		self:close()
	end
end

function PayShopMibaoBuyView:setDisCount(goodsCfg)
	local payGoodsId = goodsCfg.originalGoodsId

	self._currPayGoodsId = payGoodsId
	self._discountPayGoodsId = payGoodsId
	self._isFree = string.nilorempty(payGoodsId)

	if self._isFree then
		self:_setPayBtnTextAndIcon()
	elseif self._goodsCfg.payType == GameEnum.PayShopPayType.RMB then
		goutil.setActive(self._payIconGo, true)
		self:_setPayBtnTextAndIcon(GameEnum.PayShopPayType.RMB, payGoodsId)
	else
		self:_setPayBtnTextAndIcon(GameEnum.PayShopPayType.GAMEGOODS, payGoodsId)
	end

	local disCountNum = goodsCfg.disCount / 100

	if disCountNum > 0 then
		self._disCountText.text = string.format("%s%s", math.floor(disCountNum * 100) / 100, "折")
	end

	goutil.setActive(self._disCountGo, disCountNum > 0)
end

function PayShopMibaoBuyView:_checkMonthCardBuy(goodsCfg)
	self._isNeedBuyMonthCard = false

	if goodsCfg.sellTargetLimit == "monthCard" then
		local isActiveMonthcard = RoleModel.instance:isMonthCardActive(1)

		if not isActiveMonthcard then
			FloatWordMgr.instance:show("请激活月卡")

			self._buyBtnText.text = "需购买月卡"
			self._isNeedBuyMonthCard = true
		end
	end
end

function PayShopMibaoBuyView:_checkVipBuy(goodsCfg)
	self._isNeedBuyVip = false
	self._isNeedVipLv = false

	goutil.setActive(self._redPackageRootGo, false)

	if goodsCfg.sellTargetLimit == "vip" then
		local isVip = VipModel.instance:isVip()
		local vipLv = VipModel.instance:getCurVipLv()

		self._isNeedBuyVip = not isVip
		self._isNeedVipLv = vipLv < goodsCfg.vipLevel and goodsCfg.vipLevel

		if not isVip or vipLv < goodsCfg.vipLevel then
			local str = string.format("达到VIP%s后解锁", goodsCfg.vipLevel)

			FloatWordMgr.instance:show(str)

			self._buyBtnText.alignment = UnityEngine.TextAnchor.MiddleCenter
			self._buyBtnText.text = string.format("VIP%s解锁", goodsCfg.vipLevel)

			goutil.setActive(self._redPackageRootGo, false)
		end
	end
end

function PayShopMibaoBuyView:_setBtnTextPos()
	if self._isNeedBuyVip or self._isNeedVipLv or self._isFree or self._isNeedBuyMonthCard then
		goutil.setActive(self._payIconGo, false)
		GameUtil.setAnchoredPos(self._buyBtnText.gameObject, 0, 3)
	else
		goutil.setActive(self._payIconGo, true)
		GameUtil.setAnchoredPos(self._buyBtnText.gameObject, 16.5, 3)
	end
end

function PayShopMibaoBuyView:_onClickbtnRedPackage()
	UIStateManager.instance:push(ViewName.PayshopcashcouponuseView)
end

function PayShopMibaoBuyView:_setCashCouponUse()
	self._txtCostCashCoupon.text = "使用啥"
end

function PayShopMibaoBuyView:_setLeftTime(goodsCfg)
	removetimer(self._updateTimer, self)

	if self._showLeftTime then
		self._endTime = GameUtil.string2time(goodsCfg.offlineTime)

		if self._endTime > ServerTime.nowServerLook() then
			settimer(1, self._updateTimer, self, true)
			self:_updateTimer()
		else
			self:_actEndOp()
		end
	else
		self._txtLeftTime.text = ""
	end
end

function PayShopMibaoBuyView:_updateTimer()
	self._leftTime = self._endTime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		self._txtLeftTime.text = self:_formatLeftTimeStr(self._leftTime)
	else
		self:_actEndOp()
	end
end

function PayShopMibaoBuyView:_formatLeftTimeStr(leftTime)
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

function PayShopMibaoBuyView:_actEndOp()
	self._txtLeftTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function PayShopMibaoBuyView:_setPayBtnTextAndIcon(payType, payGoodsId, isDiscount)
	local oriCostNum = 0
	local oriUseNum = 0

	if isDiscount and self._discountPlanId > 0 then
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._discountPlanId)

		if not string.nilorempty(dcfg.discountCost) then
			local hasNum = MaterialMgr.getMatCount(dcfg.discountCost)

			if self._goodsCfg.discountLimitTimes > 0 then
				local useTime = PayShopModel.instance:getUseDiscountTimes(self._goodsCfg.id)

				oriUseNum = self._selectBuyNum - math.min(self._goodsCfg.discountLimitTimes - useTime, hasNum)
			else
				oriUseNum = self._selectBuyNum - hasNum
			end
		end

		oriUseNum = math.max(oriUseNum, 0)

		if oriUseNum > 0 then
			if payType == GameEnum.PayShopPayType.RMB then
				oriCostNum = PayConfig.instance:getPayMoneyYuan(self._goodsCfg.originalGoodsId) * oriUseNum
			elseif payType == GameEnum.PayShopPayType.GAMEGOODS then
				local list = string.split(self._goodsCfg.originalGoodsId, ":")

				oriCostNum = checknumber(list[#list]) * oriUseNum
			end
		end
	end

	if string.nilorempty(payGoodsId) then
		goutil.setActive(self._payIconGo, false)

		self._buyBtnText.text = "领取"
	elseif payType == GameEnum.PayShopPayType.RMB then
		goutil.setActive(self._payIconGo, true)
		self._payIconChange:SetState(0)
		self._payIconChange:SetState(2)

		local costNum = PayConfig.instance:getPayMoneyYuan(payGoodsId)

		self._buyBtnText.text = costNum * (self._selectBuyNum - oriUseNum) + oriCostNum
	elseif payType == GameEnum.PayShopPayType.GAMEGOODS then
		goutil.setActive(self._payIconGo, true)

		local list = string.split(payGoodsId, ":")
		local matType = checknumber(list[1])
		local matId = checknumber(list[2])
		local costNum = checknumber(list[#list])

		self._buyBtnText.text = costNum * (self._selectBuyNum - oriUseNum) + oriCostNum

		MaterialMgr.setIcon(self._payIconGo, matType, matId)
	end
end

function PayShopMibaoBuyView:_calOldPrice(goodsCfg)
	self._oldCostNum = 0

	if goodsCfg.payType == GameEnum.PayShopPayType.RMB then
		self._oldCostNum = PayConfig.instance:getPayMoneyYuan(goodsCfg.originalGoodsId)
	else
		local arr = string.split(goodsCfg.originalGoodsId, ":")

		self._oldCostNum = checknumber(arr[#arr])
	end
end

function PayShopMibaoBuyView:_autoGetBestDiscountId()
	local useTime = PayShopModel.instance:getUseDiscountTimes(self._goodsCfg.id)

	if self._goodsCfg.discountLimitTimes > 0 and useTime >= self._goodsCfg.discountLimitTimes then
		self._discountPart:setDiscountId(0)

		return
	end

	if self._discountPlanId <= 0 and self._isFirstEnter then
		self._isFirstEnter = false
		self._txtRebateTime.text = ""

		local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(self._goodsCfg.id)

		if planId > 0 then
			self._discountPlanId = planId
		end
	end

	if self._discountPlanId > 0 then
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._discountPlanId)

		self:_setPayBtnTextAndIcon(dcfg.payType, dcfg.discountPrice, true)

		if dcfg.discountTime == "全天" then
			self._txtRebateTime.text = langPara("折扣时间：全天")
		else
			local discountTime = string.split(dcfg.discountTime, "|")
			local discountDescArr = string.split(discountTime[2], ",")
			local startTimeDesc, endTimeDesc = GameUtil.string2date(discountDescArr[1]), GameUtil.string2date(discountDescArr[2])

			self._txtRebateTime.text = langPara("折扣时间：%02d.%02d.%02d 5点 - %02d.%02d.%02d 5点", startTimeDesc.year, startTimeDesc.month, startTimeDesc.day, endTimeDesc.year, endTimeDesc.month, endTimeDesc.day)
		end
	end

	self._discountPart:setDiscountId(self._discountPlanId)
end

function PayShopMibaoBuyView:_isGodGemBuy(originalGoodsId)
	return string.find(originalGoodsId, string.format("^%s:%s", MatType.GodGem, "%d+"))
end

function PayShopMibaoBuyView:_checkEnoughAndOpenSourceView(originalGoodsId)
	local curPayGoodsId = originalGoodsId

	if self._discountPlanId > 0 then
		local cfg = PayShopConfig.instance:getDiscountPlanCfg(self._discountPlanId)

		curPayGoodsId = cfg.discountPrice
	end

	if not MaterialMgr.getMatEnough(curPayGoodsId) then
		FloatWordMgr.instance:show(string.format("%s数量不足", MaterialMgr.getMaterialsNameByCfg(curPayGoodsId)))

		return true
	end

	return false
end

function PayShopMibaoBuyView:_checkGoodsSellOut(goodsCfg)
	if goodsCfg.sellTargetLimit ~= "none" and goodsCfg.limitTimes > 0 then
		local times = PayShopModel.instance:getMibaoBuyTimesById(goodsCfg.id)

		if times >= goodsCfg.limitTimes then
			return true
		end
	end
end

function PayShopMibaoBuyView:_getNorItemSpace()
	return self._norTableViewComp.gridWidth + self._norTableViewComp.cellSpacing.x
end

function PayShopMibaoBuyView:_onBatchSelect(num)
	self._selectBuyNum = num

	if self._discountPlanId > 0 then
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._discountPlanId)

		if not string.nilorempty(dcfg.discountCost) then
			local hasNum = MaterialMgr.getMatCount(dcfg.discountCost)

			if self._goodsCfg.discountLimitTimes > 0 then
				local useTime = PayShopModel.instance:getUseDiscountTimes(self._goodsCfg.id)
				local canUse = math.min(self._goodsCfg.discountLimitTimes - useTime, hasNum)

				if canUse < self._selectBuyNum then
					self._selectBuyNum = canUse
				end
			elseif hasNum < self._selectBuyNum then
				self._selectBuyNum = hasNum
			end
		end
	end

	if self._selectBuyNum ~= num then
		self._batchBuyPart:setNum(self._selectBuyNum)
	end

	self._discountPart:setSelectNum(self._selectBuyNum)
	self:showReward(self._goodsCfg)
	self:_updateCost()
end

function PayShopMibaoBuyView:_adjustView()
	local y = 0

	y = (self._discountPart:isShowPart() or self._batchBuyPart:isShowPart()) and 0 or -30

	Framework.TransformUtil.SetAnchoredPos(self._norTypePanelTr, 0, y)
	Framework.TransformUtil.SetAnchoredPos(self._bg_5Tr, 0, y + 20)
end

function PayShopMibaoBuyView:_payShopSelectDiscountId(goodsDefineId, id)
	if self._goodsCfg.id == goodsDefineId then
		self._discountPlanId = id or 0

		self:_onBatchSelect(self._selectBuyNum)
	end
end

function PayShopMibaoBuyView:_updateCost()
	if self._discountPlanId > 0 then
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._discountPlanId)

		self:_setPayBtnTextAndIcon(dcfg.payType, dcfg.discountPrice, true)
	else
		self:_setPayBtnTextAndIcon(self._goodsCfg.payType, self._goodsCfg.originalGoodsId)
	end
end

return PayShopMibaoBuyView
