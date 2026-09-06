-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshoppetailviewDiscountPart.lua

module("logic.extensions.payshop.view.PayshoppetailviewDiscountPart", package.seeall)

local PayshoppetailviewDiscountPart = class("PayshoppetailviewDiscountPart", BaseLuaOnce)

function PayshoppetailviewDiscountPart:ctor(go)
	PayshoppetailviewDiscountPart.super.ctor(self, go)
end

function PayshoppetailviewDiscountPart:buildUI()
	PayshoppetailviewDiscountPart.super.buildUI(self)

	self._btnBuy2 = self:getBtn("btns/btnBuy2")
	self._btnBuy1 = self:getBtn("btns/btnBuy1")
	self._btnPayIconChange2 = self:getGo("btns/btnBuy2/payIcon")
	self._btnPayIconChange1 = self:getGo("btns/btnBuy1/payIcon")
	self._txtBtnBuy1 = goutil.findChildTextComponent(self.mainGO, "btns/btnBuy1/txtBtnBuy")
	self._txtBtnBuy2 = goutil.findChildTextComponent(self.mainGO, "btns/btnBuy2/txtBtnBuy")
	self._nowPrizeGo1 = self:getGo("nowPrice/prizecon/price1")
	self._nowPrizeGo2 = self:getGo("nowPrice/prizecon/price2")
	self._txtNotDiscoutGo = self:getGo("discount/txtNotDiscout")
	self._nowPayIconChange2 = self:getGo("nowPrice/prizecon/price2/payIcon")
	self._nowPayIconChange1 = self:getGo("nowPrice/prizecon/price1/payIcon")
	self._disPayIconChange1 = self:getGo("discount/prizecon/price1/payIcon")
	self._disPayIconChange2 = self:getGo("discount/prizecon/price2/payIcon")
	self._txtNowPrizeNum2 = self:getTxt("nowPrice/prizecon/price2/txtNum")
	self._txtNowPrizeNum1 = self:getTxt("nowPrice/prizecon/price1/txtNum")
	self._txtDiscPrizeNum2 = self:getTxt("discount/prizecon/price2/txtNum")
	self._txtDiscPrizeNum1 = self:getTxt("discount/prizecon/price1/txtNum")
	self._btnGetDiscount = self:getBtn("discount/btnGetDiscount")
	self._discountPriceGo2 = self:getGo("discount/prizecon/price2")
	self._discountPriceGo1 = self:getGo("discount/prizecon/price1")
	self._disPrizeconGo = self:getGo("discount/prizecon")
	self._addconGo = self:getGo("btns/btnBuy1/addcon")
	self._txtAddDesc = self:getTxt("btns/btnBuy1/addcon/txtAdd")
	self._addIconGo = self:getGo("btns/btnBuy1/addcon/payIcon")
	self._btnOpenDiscount = self:getBtn("discount/prizecon/price1/btnOpenDiscount")
	self._groups = {}

	for i = 1, 2 do
		self._groups[i] = {
			iconChanges = {
				self["_btnPayIconChange" .. i],
				self["_nowPayIconChange" .. i],
				self["_disPayIconChange" .. i]
			},
			btnBuy = self["_btnBuy" .. i],
			txtBtnBuy = self["_txtBtnBuy" .. i],
			prizeCons = {
				self["_nowPrizeGo" .. i],
				self["_discountPriceGo" .. i]
			},
			discountPriceGo = self["_discountPriceGo" .. i],
			txtNowPrize = self["_txtNowPrizeNum" .. i],
			txtDiscPrize = self["_txtDiscPrizeNum" .. i]
		}
	end

	self._btnNotUseDisc = self:getBtn("discount/btnNotUseDisc")
end

function PayshoppetailviewDiscountPart:bindEvents()
	PayshoppetailviewDiscountPart.super.bindEvents(self)
	self._btnBuy2:AddClickListener(self._onClickbtnBuy2, self)
	self._btnBuy1:AddClickListener(self._onClickbtnBuy1, self)
	self._btnGetDiscount:AddClickListener(self._onClickbtnGetDiscount, self)
	self._btnOpenDiscount:AddClickListener(self._onClickbtnOpenDiscount, self)
	self._btnNotUseDisc:AddClickListener(self._onClickbtnNotUseDisc, self)
end

function PayshoppetailviewDiscountPart:unbindEvents()
	PayshoppetailviewDiscountPart.super.unbindEvents(self)
	self._btnBuy2:RemoveClickListener()
	self._btnBuy1:RemoveClickListener()
	self._btnGetDiscount:RemoveClickListener()
	self._btnOpenDiscount:RemoveClickListener()
	self._btnNotUseDisc:RemoveClickListener()
end

function PayshoppetailviewDiscountPart:onEnter(goodsDefineId, discountPlanId)
	PayshoppetailviewDiscountPart.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PayShopSelectDiscountId, self._payShopSelectDiscountId, self)

	self._goodsDefineId = goodsDefineId
	self._discountPlanId = discountPlanId or 0
	self._curPayOriNum = 0
	self._goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._goodsDefineId)
	self._discGroups = PayShopController.instance:getDiscountActiveGroup(self._goodsDefineId)
	self._hasDiscPlan = self._discGroups and #self._discGroups > 0

	self:setRootActive(self._goodsCfg.payType ~= GameEnum.PayShopPayType.JUMPGOODS)
	self:_updateView()
end

function PayshoppetailviewDiscountPart:onExit()
	PayshoppetailviewDiscountPart.super.onExit(self)

	for i, v in ipairs(self._groups) do
		for _, iconChange in ipairs(v.iconChanges) do
			MaterialMgr.resetAll(iconChange)
		end
	end

	MaterialMgr.resetAll(self._addIconGo)
	GlobalDispatcher:removeListener(GlobalNotify.PayShopSelectDiscountId, self._payShopSelectDiscountId, self)
end

function PayshoppetailviewDiscountPart:_onClickbtnOpenDiscount()
	UIStateManager.instance:push(ViewName.PayshopselectdiscountView, self._goodsCfg.id, self._discountPlanId)
end

function PayshoppetailviewDiscountPart:_onClickbtnBuy2()
	if not PayShopModel.instance:getPayShopGoodsCanBuyById(self._goodsCfg.id) then
		FloatWordMgr.instance:show("已售罄")

		return
	end

	if self._goodsCfg.deducePlanId > 0 then
		local dcfg = PayShopConfig.instance:getDeduceCfg(self._goodsCfg.deducePlanId)
		local arr = string.split(dcfg.deduction, ":")
		local matType = checkint(arr[1])
		local matId = checkint(arr[2])
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local content = string.format("确定要花费%s%s，购买%s个%s吗?", self._needAllDeduceNum, matName, 1, self._goodsCfg.name)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, self._needAllDeduceNum, content, function()
			PayShopController.instance:buyShopItem(self._goodsCfg.id, 1, self._discountPlanId, self._needAllDeduceNum)
		end, nil, nil, nil, nil, false)
	else
		printError("没有替代方案 此按钮不应该出现！！")
	end
end

function PayshoppetailviewDiscountPart:_onClickbtnBuy1()
	if not PayShopModel.instance:getPayShopGoodsCanBuyById(self._goodsCfg.id) then
		FloatWordMgr.instance:show("已售罄")

		return
	end

	local isFree = string.nilorempty(self._goodsCfg.originalGoodsId)

	if not isFree and self._goodsCfg.payType ~= GameEnum.PayShopPayType.RMB then
		local currPayGoodsId = self._goodsCfg.originalGoodsId
		local arr = string.split(currPayGoodsId, ":")
		local matType = checkint(arr[1])
		local matId = checkint(arr[2])
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local addStr = ""

		if self._needDeduceNum > 0 then
			local dcfg = PayShopConfig.instance:getDeduceCfg(self._goodsCfg.deducePlanId)
			local arr2 = string.split(dcfg.deduction, ":")
			local matType2 = checkint(arr2[1])
			local matId2 = checkint(arr2[2])
			local matName2 = MaterialMgr.getMaterialsName(matType2, matId2)

			addStr = string.format("和%s%s", self._needDeduceNum, matName2)
		end

		local content = string.format("确定要花费%s%s%s，购买%s个%s吗?", self._curPayOriNum, matName, addStr, 1, self._goodsCfg.name)

		if self._needDeduceNum > 0 then
			local function okFunc()
				PayShopController.instance:buyShopItem(self._goodsCfg.id, 1, self._discountPlanId, self._needDeduceNum)
			end

			TipsFacade.instance:openPopupWindow("提示", content, okFunc)
		else
			TipsFacade.instance:openPopupCostMatViewNew(matType, matId, self._curPayOriNum, content, function()
				PayShopController.instance:buyShopItem(self._goodsCfg.id, 1, self._discountPlanId, self._needDeduceNum)
			end, nil, nil, nil, nil, false)
		end
	else
		PayShopController.instance:buyShopItem(self._goodsCfg.id, 1, self._discountPlanId, self._needDeduceNum)
	end
end

function PayshoppetailviewDiscountPart:_onClickbtnGetDiscount()
	GotoMgr.gotoByString(self._goodsCfg.jumpTo)
end

function PayshoppetailviewDiscountPart:_onClickbtnNotUseDisc()
	self:_onClickbtnOpenDiscount()
end

function PayshoppetailviewDiscountPart:_updateView()
	if self._goodsCfg.payType == GameEnum.PayShopPayType.JUMPGOODS then
		return
	end

	self._needDeduceNum = 0
	self._needAllDeduceNum = 0

	self:_setDiscountActive()
	self:_checkHasMulPrize()
	self:_setPrizeConPos()
	self:_setCurrPrize()
end

function PayshoppetailviewDiscountPart:_setDiscountActive()
	local hasDiscFrom = not string.nilorempty(self._goodsCfg.jumpTo)

	goutil.setActive(self._disPrizeconGo, self._discountPlanId > 0)
	goutil.setActive(self._txtNotDiscoutGo, not hasDiscFrom and self._discountPlanId <= 0 and not self._hasDiscPlan)
	goutil.setActive(self._btnGetDiscount.gameObject, hasDiscFrom and self._discountPlanId <= 0 and not self._hasDiscPlan)
	goutil.setActive(self._addconGo, false)
	goutil.setActive(self._btnNotUseDisc.gameObject, self._discountPlanId <= 0 and self._hasDiscPlan)
end

function PayshoppetailviewDiscountPart:_checkHasMulPrize()
	local has = self._goodsCfg.deducePlanId > 0

	for i, v in ipairs(self._groups[2].prizeCons) do
		goutil.setActive(v, has)
	end

	goutil.setActive(self._groups[2].btnBuy.gameObject, has)
end

function PayshoppetailviewDiscountPart:_setPrizeConPos()
	return
end

function PayshoppetailviewDiscountPart:_setCurrPrize()
	local payGoodsId = self._goodsCfg.originalGoodsId
	local originalGoodsId = self._goodsCfg.originalGoodsId

	if self._discountPlanId > 0 then
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._discountPlanId)

		payGoodsId = dcfg.discountPrice
		originalGoodsId = self._goodsCfg.originalGoodsId
	end

	local list1 = string.split(payGoodsId, ":")
	local list2 = string.split(originalGoodsId, ":")
	local oriCostNum = checknumber(list2[3])
	local matType = checkint(list1[1])
	local matId = checkint(list1[2])

	for i, iconChange in ipairs(self._groups[1].iconChanges) do
		MaterialMgr.setIcon(iconChange, matType, matId)
	end

	local nowCostNum, nowCostNumOri = self:_onCalDeduceCost(payGoodsId)

	self:_setBaseCostNum(nowCostNum, oriCostNum, nowCostNumOri)
end

function PayshoppetailviewDiscountPart:_setBaseCostNum(nowCostNum, oriCostNum, nowCostNumOri)
	self._curPayOriNum = nowCostNum
	self._groups[1].txtBtnBuy.text = nowCostNum
	self._groups[1].txtNowPrize.text = oriCostNum

	local num = math.max(0, oriCostNum - nowCostNumOri)

	goutil.setActive(self._groups[1].discountPriceGo, num > 0)

	self._groups[1].txtDiscPrize.text = num
end

function PayshoppetailviewDiscountPart:_setDeduceCostNum(nowCostNum, oriCostNum)
	self._groups[2].txtBtnBuy.text = nowCostNum
	self._groups[2].txtNowPrize.text = oriCostNum

	local num = oriCostNum - nowCostNum

	goutil.setActive(self._groups[2].discountPriceGo, num > 0)

	self._groups[2].txtDiscPrize.text = num
end

function PayshoppetailviewDiscountPart:_onCalDeduceCost(payGoodsId)
	local list = string.split(payGoodsId, ":")
	local matType = checkint(list[1])
	local matId = checkint(list[2])
	local oriCostNum = checkint(list[3])
	local needCostNum = oriCostNum
	local hasDeduce = self._goodsCfg.deducePlanId > 0

	if hasDeduce then
		self:_onDeduceCost()

		local hasNum = MaterialFacade.instance:getMatNumber(matType, matId)

		if hasNum < needCostNum then
			local cfg = PayShopConfig.instance:getDeduceCfg(self._goodsCfg.deducePlanId)
			local needRelpaceCostNum = needCostNum - hasNum - hasNum % cfg.deduceFactor
			local modNum = needRelpaceCostNum % cfg.deduceFactor

			if modNum > 0 then
				if not (needRelpaceCostNum - modNum + cfg.deduceFactor) then
					local needAddNum = needRelpaceCostNum

					needCostNum = oriCostNum - needAddNum

					self:_setNeedAddDeduceNum(needAddNum)
				end
			end
		end
	end

	return math.max(0, needCostNum), oriCostNum
end

function PayshoppetailviewDiscountPart:_onDeduceCost()
	local oriCostNum = 0
	local payGoodsId = self._goodsCfg.originalGoodsId
	local originalGoodsId = self._goodsCfg.originalGoodsId
	local hasDeduce = self._goodsCfg.deducePlanId > 0

	if hasDeduce then
		local cfg = PayShopConfig.instance:getDeduceCfg(self._goodsCfg.deducePlanId)

		if self._discountPlanId > 0 then
			local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._discountPlanId)

			payGoodsId = dcfg.discountPrice
			originalGoodsId = self._goodsCfg.originalGoodsId
		end

		local nowList = string.split(payGoodsId, ":")
		local oriList = string.split(originalGoodsId, ":")
		local replaceList = string.split(cfg.deduction, ":")
		local nowMatType = checkint(nowList[1])
		local nowMatId = checkint(nowList[2])
		local replaceMatType = checkint(replaceList[1])
		local replaceMatId = checkint(replaceList[2])

		oriCostNum = checknumber(oriList[#oriList])

		local nowNeedNum = checknumber(nowList[#nowList]) / cfg.deduceFactor
		local oriNeedNum = oriCostNum / cfg.deduceFactor

		nowNeedNum = math.ceil(nowNeedNum)
		oriNeedNum = math.ceil(oriNeedNum)

		for i, iconChange in ipairs(self._groups[2].iconChanges) do
			MaterialMgr.setIcon(iconChange, replaceMatType, replaceMatId)
		end

		MaterialMgr.setIcon(self._addIconGo, replaceMatType, replaceMatId)

		self._needAllDeduceNum = nowNeedNum

		self:_setDeduceCostNum(nowNeedNum, oriNeedNum)
	end
end

function PayshoppetailviewDiscountPart:_setNeedAddDeduceNum(needAddNum)
	goutil.setActive(self._addconGo, true)

	local cfg = PayShopConfig.instance:getDeduceCfg(self._goodsCfg.deducePlanId)
	local needNum = math.ceil(needAddNum / cfg.deduceFactor)

	self._needDeduceNum = needNum
	self._txtAddDesc.text = string.format("%s可补足", needNum)
end

function PayshoppetailviewDiscountPart:_payShopSelectDiscountId(goodsDefineId, id)
	if goodsDefineId == self._goodsCfg.id then
		self._discountPlanId = id

		self:_updateView()
	end
end

function PayshoppetailviewDiscountPart:setRootActive(flag)
	goutil.setActive(self.mainGO, flag)
end

return PayshoppetailviewDiscountPart
