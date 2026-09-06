-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/view/NewYearGoodsShopBuyDiscountPart.lua

module("logic.extensions.newyeargoodsshop.view.NewYearGoodsShopBuyDiscountPart", package.seeall)

local NewYearGoodsShopBuyDiscountPart = class("NewYearGoodsShopBuyDiscountPart", BaseLuaOnce)

function NewYearGoodsShopBuyDiscountPart:buildUI()
	self._btnJumpDisc = self:getBtn("btnJumpDisc")
	self._btnNoUseDisc = self:getBtn("btnNoUseDisc")
	self._txtItemName = self:getTxt("txtItemName")
end

function NewYearGoodsShopBuyDiscountPart:bindEvents()
	self._btnJumpDisc:AddClickListener(self._onClickbtnJumpDisc, self)
	self._btnNoUseDisc:AddClickListener(self._onClickbtnNoUseDisc, self)
end

function NewYearGoodsShopBuyDiscountPart:unbindEvents()
	self._btnJumpDisc:RemoveClickListener()
	self._btnNoUseDisc:RemoveClickListener()
end

function NewYearGoodsShopBuyDiscountPart:onEnter(goodsCfg)
	self.addGEvent(self, GlobalNotify.NewYearGoodsShopSelectDiscountId, self._PayShopSelectDiscountId, self)

	self._discId = 0
	self._isFree = false
	self._oldPrize = 0
	self._oldCostType = 0
	self._payType = 0
	self._selectNum = 0
	self._maxSelectNum = 0
	self._goodsCfg = goodsCfg
	self._bestDisPlanId = NewyeargoodsshopModel.instance:getBestDiscountPlanIdByGoodsDefineId(goodsCfg.activityType, goodsCfg.activityId, goodsCfg.shopItemId)
	self._hasDisc = self._bestDisPlanId > 0
	self._discountCfgGroup = ActivityshopConfig.instance:getCouponCfgsByShopItemId(goodsCfg.activityType, goodsCfg.activityId, goodsCfg.shopItemId)

	self:_updateView()
end

function NewYearGoodsShopBuyDiscountPart:onExit()
	NewYearGoodsShopBuyDiscountPart.super.onExit(self)
end

function NewYearGoodsShopBuyDiscountPart:_onClickbtnJumpDisc()
	UIStateManager.instance:push(ViewName.NewyeargoodsshopselectdiscountView, self._goodsCfg, self._discId)
end

function NewYearGoodsShopBuyDiscountPart:_onClickbtnNoUseDisc()
	self:_onClickbtnJumpDisc()
end

function NewYearGoodsShopBuyDiscountPart:setDiscountId(id)
	self._discId = id

	self:_calUseCount()
	self:_updateView()
end

function NewYearGoodsShopBuyDiscountPart:_initOldPrize()
	local payGoodsId = self._goodsCfg.originalGoodsId

	self._isFree = string.nilorempty(payGoodsId)

	if self._isFree then
		return
	elseif self._goodsCfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
		self:_setOldPrize(GameEnum.PayShopPayType.GAMEGOODS, payGoodsId)
	else
		local payCfg = PayConfig.instance:getPayGoodsCfg(payGoodsId)

		self:_setOldPrize(GameEnum.PayShopPayType.RMB, payGoodsId)
	end
end

function NewYearGoodsShopBuyDiscountPart:_setOldPrize(payType, payGoodsId)
	self._oldPrize = 0
	self._oldCostType = 0
	self._payType = payType

	if payType == GameEnum.PayShopPayType.RMB then
		self._oldPrize = PayConfig.instance:getPayMoneyYuan(payGoodsId)
	elseif payType == GameEnum.PayShopPayType.GAMEGOODS then
		local list = string.split(payGoodsId, ":")

		self._oldPrize = checkint(list[#list])
		self._oldCostType = checkint(list[1])
	end
end

function NewYearGoodsShopBuyDiscountPart:_updateView()
	self:_hideAll()

	if self._discId > 0 then
		local dcfg = ActivityshopConfig.instance:getCouponCfg(self._discId)
		local discountTime = PayShopModel.instance:getUseDiscountTimes(self._goodsCfg.id)

		self:_showDiscountItemName(self._discId)
	end

	if self._hasDisc then
		self:_showMainGo()
	end

	goutil.setActive(self._btnNoUseDisc.gameObject, self._hasDisc and self._discId <= 0)
	goutil.setActive(self._btnJumpDisc.gameObject, self._hasDisc and self._discId > 0)
end

function NewYearGoodsShopBuyDiscountPart:_showMainGo()
	if #self._discountCfgGroup > 1 then
		self._isShowPart = true
	else
		local dcfg = ActivityshopConfig.instance:getCouponCfg(self._bestDisPlanId)

		if not string.nilorempty(dcfg.discountCost) then
			self._isShowPart = true
		end
	end

	goutil.setActive(self.mainGO, self._isShowPart)
end

function NewYearGoodsShopBuyDiscountPart:_hideAll()
	self._isShowPart = false

	goutil.setActive(self.mainGO, false)
	goutil.setActive(self._txtItemName.gameObject, false)
end

function NewYearGoodsShopBuyDiscountPart:isShowPart()
	return self._isShowPart
end

function NewYearGoodsShopBuyDiscountPart:_PayShopSelectDiscountId(activityType, activityId, shopItemId, discId)
	if self._goodsCfg.activityType == activityType or self._goodsCfg.activityId == activityId or self._goodsCfg.shopItemId == shopItemId then
		self._discId = discId or 0

		self:_calUseCount()
		self:_updateView()
	end
end

function NewYearGoodsShopBuyDiscountPart:setSelectNum(num)
	self._selectNum = math.min(num, self._maxSelectNum)

	self:_updateView()
end

function NewYearGoodsShopBuyDiscountPart:_showDiscountItemName(disCountPlanId)
	local dcfg = ActivityshopConfig.instance:getCouponCfg(self._discId)
	local hasNum = MaterialMgr.getMatCount(dcfg.discountCost)

	goutil.setActive(self._txtItemName.gameObject, true)

	self._txtItemName.text = string.format("%s*%s", dcfg.couponName, self._selectNum)
end

function NewYearGoodsShopBuyDiscountPart:_calUseCount()
	if self._discId <= 0 then
		self._maxSelectNum = 0
	else
		local dcfg = ActivityshopConfig.instance:getCouponCfg(self._discId)

		self._maxSelectNum = MaterialMgr.getMatCount(dcfg.discountCost)
	end

	if self._maxSelectNum <= 0 then
		self._selectNum = 0
	elseif self._selectNum <= 0 then
		self._selectNum = 1
	end
end

return NewYearGoodsShopBuyDiscountPart
