-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/view/NewyeargoodsshopbuyView.lua

module("logic.extensions.newyeargoodsshop.view.NewyeargoodsshopbuyView", package.seeall)

local NewyeargoodsshopbuyView = class("NewyeargoodsshopbuyView", ViewComponent)

function NewyeargoodsshopbuyView:ctor()
	NewyeargoodsshopbuyView.super.ctor(self)
end

function NewyeargoodsshopbuyView:buildUI()
	NewyeargoodsshopbuyView.super.buildUI(self)

	self._closeBtn = GameUtil.asBtn(self:getGo("closeBtn"))
	self._buyBtn = self:getBtn("buyBtn")
	self._tipText = goutil.findChildTextComponent(self.mainGO, "tipText")
	self._limitText = goutil.findChildTextComponent(self.mainGO, "limitText")
	self._disCountText = goutil.findChildTextComponent(self.mainGO, "disCountImg/text")
	self._buyBtnText = goutil.findChildTextComponent(self.mainGO, "buyBtn/text")
	self._disCountGo = self:getGo("disCountImg")
	self._discountRoot = self:getGo("discountRoot")

	GameUtil.SetActive(self._disCountGo, false)

	self._payIconGo = self:getGo("buyBtn/text/payIcon")
	self._norTypePanelGo = self:getGo("norTypePanel")
	self._norTypePanelTr = self._norTypePanelGo.transform
	self._bg_5Tr = self:getGo("bggroup_lv2/bg1/bg_5").transform
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
	self._discountPart = GameUtil.AddLuaOnce(self._discountShowRootGo, NewYearGoodsShopBuyDiscountPart)
	self._batchBuyRootGo = self:getGo("batchBuyRoot")
	self._numberSelector = GameUtil.AddLuaOnce(self._batchBuyRootGo, NumberSelector)
end

function NewyeargoodsshopbuyView:bindEvents()
	NewyeargoodsshopbuyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._buyBtn:AddClickListener(self._onClickBuy, self)
end

function NewyeargoodsshopbuyView:unbindEvents()
	NewyeargoodsshopbuyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
end

function NewyeargoodsshopbuyView:destroyUI()
	NewyeargoodsshopbuyView.super.destroyUI(self)
end

function NewyeargoodsshopbuyView:onEnter()
	NewyeargoodsshopbuyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NewYearGoodsShopSelectDiscountId, self._payShopSelectDiscountId, self)

	self._isFirstEnter = true
	self._selectBuyNum = 1

	local params = self:getOpenParam()

	self._activityType = params[1]
	self._activityId = params[2]
	self._shopItemId = params[3]
	self._goodsCfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(self._activityType, self._activityId, self._shopItemId)
	self._discountPlanId = 0

	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, self._shopItemId)

	self._shopItemCfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(self._activityType, self._activityId, self._shopItemId)

	self._discountPart:onEnter(self._shopItemCfg)

	if self._shopItemCfg.sellLimitCount > 0 then
		if not (self._shopItemCfg.sellLimitCount - buyTime) then
			local maxNum = 9999

			self._numberSelector:AddListener(self._onBatchSelect, self)
			self._numberSelector:onEnter(1, maxNum)
			self:_setCostIcon()
			self:_autoGetBestDiscountId()
			self:_updateUI()
		end
	end
end

function NewyeargoodsshopbuyView:onEnterFinished()
	NewyeargoodsshopbuyView.super.onEnterFinished(self)
end

function NewyeargoodsshopbuyView:onExit()
	NewyeargoodsshopbuyView.super.onExit(self)
	MaterialMgr.resetAll(self._tableview)
	removetimer(self._updateTimer, self)
	MaterialMgr.resetAll(self._payIconGo)
	self._norItemGroup:dispose(function(item)
		self:_clearTableview(item)
	end)
	self._discountPart:onExit()
	self._numberSelector:onExit()
	self._numberSelector:RemoveListener()
end

function NewyeargoodsshopbuyView:onExitFinished()
	NewyeargoodsshopbuyView.super.onExitFinished(self)
end

function NewyeargoodsshopbuyView:_initView()
	local goodsCfg = self._goodsCfg

	if goodsCfg then
		self:setDisCount(goodsCfg)
		self:_checkMonthCardBuy(goodsCfg)
		self:_setBtnTextPos()
	end
end

function NewyeargoodsshopbuyView:isFirstBuy(cfg)
	if self.data and self.data.totalBuyTimes and self.data.totalBuyTimes <= 0 and string.trim(cfg.firstBuyExtraContent) ~= "" then
		return true
	end

	return false
end

function NewyeargoodsshopbuyView:_showLimitText()
	local limitType = self._shopItemCfg.sellPeriodLimit

	if limitType == "none" then
		self._limitText.text = ""
		self._tipText.text = ""

		return
	end

	local preStr = "限购："

	if limitType == "daily" then
		self._tipText.text = "每天5:00刷新"
		preStr = "每日限购："
	elseif limitType == "weekly" then
		self._tipText.text = "每周五5:00刷新"
		preStr = "每周限购："
	elseif limitType == "monthly" then
		self._tipText.text = "每月1日5:00刷新"
		preStr = "每月限购："
	elseif limitType == "allTime" then
		self._tipText.text = ""
		preStr = "永久限购："
	elseif limitType == "none" then
		self._limitText.text = ""
		self._tipText.text = ""

		return
	end

	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, self._shopItemCfg.shopItemId)

	self._limitText.text = langPara("%s%d/%d", preStr, self._shopItemCfg.sellLimitCount - buyTime, self._shopItemCfg.sellLimitCount)
end

function NewyeargoodsshopbuyView:_onClickBuy()
	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, self._shopItemId)

	if self._shopItemCfg.sellLimitCount > 0 and buyTime - self._shopItemCfg.sellLimitCount >= 0 then
		FloatWordMgr.instance:show("可购买次数不足")

		return
	end

	self:_openSureBuyTip()
end

function NewyeargoodsshopbuyView:_openSureBuyTip()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._shopItemCfg.sellPrice)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local totalCost = matNum * self._selectBuyNum
	local couponUseInfo

	if self._discountPlanId > 0 then
		local dcfg = ActivityshopConfig.instance:getCouponCfg(self._discountPlanId)
		local hasNum = MaterialMgr.getMatCount(dcfg.discountCost)
		local useCount = math.min(hasNum, self._selectBuyNum)

		couponUseInfo = {
			couponId = self._discountPlanId,
			useCount = useCount
		}
		totalCost = totalCost <= useCount * dcfg.deductCount and dcfg.minCost or totalCost - useCount * dcfg.deductCount
	end

	local content = string.format("确定要花费%s%s，购买%s个%s吗?", totalCost, matName, self._selectBuyNum, self._shopItemCfg.name)

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, totalCost, content, function()
		ActivityshopController.instance:buyShopItem(self._activityType, self._activityId, self._shopItemCfg.shopItemId, self._selectBuyNum, couponUseInfo)
		self:close()
	end)
end

function NewyeargoodsshopbuyView:setDisCount(goodsCfg)
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

function NewyeargoodsshopbuyView:_checkMonthCardBuy(goodsCfg)
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

function NewyeargoodsshopbuyView:_setBtnTextPos()
	if self._isNeedBuyVip or self._isNeedVipLv or self._isFree or self._isNeedBuyMonthCard then
		goutil.setActive(self._payIconGo, false)
		GameUtil.setAnchoredPos(self._buyBtnText.gameObject, 0, 3)
	else
		goutil.setActive(self._payIconGo, true)
		GameUtil.setAnchoredPos(self._buyBtnText.gameObject, 16.5, 3)
	end
end

function NewyeargoodsshopbuyView:_formatLeftTimeStr(leftTime)
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

function NewyeargoodsshopbuyView:_setPayBtnTextAndIcon(payType, payGoodsId, isDiscount)
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

		self._buyBtnText.text = math.max(0, costNum * (self._selectBuyNum - oriUseNum) + oriCostNum)
	elseif payType == GameEnum.PayShopPayType.GAMEGOODS then
		goutil.setActive(self._payIconGo, true)

		local list = string.split(payGoodsId, ":")
		local matType = checknumber(list[1])
		local matId = checknumber(list[2])
		local costNum = checknumber(list[#list])

		self._buyBtnText.text = math.max(0, costNum * (self._selectBuyNum - oriUseNum) + oriCostNum)

		MaterialMgr.setIcon(self._payIconGo, matType, matId)
	end
end

function NewyeargoodsshopbuyView:_calOldPrice(goodsCfg)
	self._oldCostNum = 0

	if goodsCfg.payType == GameEnum.PayShopPayType.RMB then
		self._oldCostNum = PayConfig.instance:getPayMoneyYuan(goodsCfg.originalGoodsId)
	else
		local arr = string.split(goodsCfg.originalGoodsId, ":")

		self._oldCostNum = checknumber(arr[#arr])
	end
end

function NewyeargoodsshopbuyView:_autoGetBestDiscountId()
	if self._discountPlanId <= 0 and self._isFirstEnter then
		self._isFirstEnter = false
		self._txtRebateTime.text = ""

		local planId = NewyeargoodsshopModel.instance:getBestDiscountPlanIdByGoodsDefineId(self._goodsCfg.activityType, self._goodsCfg.activityId, self._goodsCfg.shopItemId)

		if planId > 0 then
			self._discountPlanId = planId
		end
	end

	self._discountPart:setDiscountId(self._discountPlanId)
	self:_updateMaxNum()
end

function NewyeargoodsshopbuyView:_isGodGemBuy(originalGoodsId)
	return string.find(originalGoodsId, string.format("^%s:%s", MatType.GodGem, "%d+"))
end

function NewyeargoodsshopbuyView:_checkEnoughAndOpenSourceView(originalGoodsId)
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

function NewyeargoodsshopbuyView:_checkGoodsSellOut(goodsCfg)
	if goodsCfg.sellTargetLimit ~= "none" and goodsCfg.limitTimes > 0 then
		local times = PayShopModel.instance:getMibaoBuyTimesById(goodsCfg.id)

		if times >= goodsCfg.limitTimes then
			return true
		end
	end
end

function NewyeargoodsshopbuyView:_getNorItemSpace()
	return self._norTableViewComp.gridWidth + self._norTableViewComp.cellSpacing.x
end

function NewyeargoodsshopbuyView:_onBatchSelect(num)
	self._selectBuyNum = num

	self:_updateReward()
	self:_updateCost()
	self._discountPart:setSelectNum(num)
end

function NewyeargoodsshopbuyView:_adjustView()
	local y = 0

	y = self._discountPart:isShowPart() and 0 or -30

	Framework.TransformUtil.SetAnchoredPos(self._norTypePanelTr, 0, y)
	Framework.TransformUtil.SetAnchoredPos(self._bg_5Tr, 0, y + 20)
end

function NewyeargoodsshopbuyView:_payShopSelectDiscountId(activityType, activityId, shopItemId, discId)
	if self._goodsCfg.activityType == activityType or self._goodsCfg.activityId == activityId or self._goodsCfg.shopItemId == shopItemId then
		self._discountPlanId = discId or 0

		self:_onBatchSelect(self._selectBuyNum)
		self:_updateMaxNum()
	end
end

function NewyeargoodsshopbuyView:_updateCost()
	local matType, cfgId, matNum = MaterialMgr.getMatParams(self._shopItemCfg.sellPrice)
	local totalCost = matNum * self._selectBuyNum

	if self._discountPlanId > 0 then
		local dcfg = ActivityshopConfig.instance:getCouponCfg(self._discountPlanId)
		local hasNum = MaterialMgr.getMatCount(dcfg.discountCost)
		local useCount = math.min(hasNum, self._selectBuyNum)

		totalCost = matNum <= dcfg.deductCount and useCount * dcfg.minCost or totalCost - useCount * dcfg.deductCount
	end

	self._buyBtnText.text = math.max(0, totalCost)
end

function NewyeargoodsshopbuyView:_updateUI()
	self:_updateReward()
	self:_showLimitText()
	self:_updateCost()
end

function NewyeargoodsshopbuyView:_updateReward()
	local list = string.split(self._goodsCfg.sellContent, "#")
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

function NewyeargoodsshopbuyView:_updateNorCell(item, cfgStr, startPosX)
	local goCon = goutil.findChild(item.mainGO, "root/con")
	local txtName = goutil.findChildTextComponent(item.mainGO, "root/txtName")

	txtName.text = MaterialMgr.getMaterialsNameByCfg(cfgStr)

	local proxy = MaterialMgr.setCellByCfg(cfgStr, goCon)
	local list = string.split(cfgStr, ":")

	proxy.binder:setNum(checknumber(list[#list]) * self._selectBuyNum)
	Framework.TransformUtil.SetAnchoredPos(item.mainGO.transform, startPosX + (item.index - 1) * self:_getNorItemSpace(), 0)
end

function NewyeargoodsshopbuyView:_clearTableview(item)
	local goCon = goutil.findChild(item.mainGO, "root/con")

	MaterialMgr.resetAll(goCon)
end

function NewyeargoodsshopbuyView:_setCostIcon()
	local matType, cfgId = MaterialMgr.getMatParams(self._shopItemCfg.sellPrice)

	MaterialMgr.setIcon(self._payIconGo, matType, cfgId)
end

function NewyeargoodsshopbuyView:_updateMaxNum()
	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, self._shopItemId)

	if self._shopItemCfg.sellLimitCount > 0 then
		if not (self._shopItemCfg.sellLimitCount - buyTime) then
			local maxNum = 9999

			if self._discountPlanId > 0 then
				local dcfg = ActivityshopConfig.instance:getCouponCfg(self._discountPlanId)
				local hasNum = MaterialMgr.getMatCount(dcfg.discountCost)

				if hasNum < maxNum then
					maxNum = hasNum
				end
			end

			if maxNum < self._selectBuyNum then
				self._selectBuyNum = maxNum
			end

			self:_onBatchSelect(self._selectBuyNum)
			self._numberSelector:setMaxNum(maxNum)
		end
	end
end

return NewyeargoodsshopbuyView
