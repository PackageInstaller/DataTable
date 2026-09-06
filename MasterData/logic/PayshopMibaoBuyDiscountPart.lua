-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopMibaoBuyDiscountPart.lua

module("logic.extensions.payshop.view.PayshopMibaoBuyDiscountPart", package.seeall)

local PayshopMibaoBuyDiscountPart = class("PayshopMibaoBuyDiscountPart", BaseLuaOnce)

function PayshopMibaoBuyDiscountPart:buildUI()
	self._btnJumpDisc = self:getBtn("btnJumpDisc")
	self._btnNoUseDisc = self:getBtn("btnNoUseDisc")
	self._txtItemName = self:getTxt("txtItemName")
end

function PayshopMibaoBuyDiscountPart:bindEvents()
	self._btnJumpDisc:AddClickListener(self._onClickbtnJumpDisc, self)
	self._btnNoUseDisc:AddClickListener(self._onClickbtnNoUseDisc, self)
end

function PayshopMibaoBuyDiscountPart:unbindEvents()
	self._btnJumpDisc:RemoveClickListener()
	self._btnNoUseDisc:RemoveClickListener()
end

function PayshopMibaoBuyDiscountPart:onEnter(goodsCfg)
	GlobalDispatcher:addListener(GlobalNotify.PayShopSelectDiscountId, self._PayShopSelectDiscountId, self)

	self._discId = 0
	self._isFree = false
	self._oldPrize = 0
	self._oldCostType = 0
	self._payType = 0
	self._selectNum = 1
	self._goodsCfg = goodsCfg
	self._bestDisPlanId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(self._goodsCfg.id)
	self._hasDisc = self._bestDisPlanId > 0
	self._discountCfgGroup = PayShopController.instance:getDiscountActiveGroup(self._goodsCfg.id)

	self:_initOldPrize()
	self:_updateView()
end

function PayshopMibaoBuyDiscountPart:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PayShopSelectDiscountId, self._PayShopSelectDiscountId, self)
end

function PayshopMibaoBuyDiscountPart:_onClickbtnJumpDisc()
	UIStateManager.instance:push(ViewName.PayshopselectdiscountView, self._goodsCfg.id, self._discId)
end

function PayshopMibaoBuyDiscountPart:_onClickbtnNoUseDisc()
	self:_onClickbtnJumpDisc()
end

function PayshopMibaoBuyDiscountPart:setDiscountId(id)
	self._discId = id

	self:_updateView()
end

function PayshopMibaoBuyDiscountPart:_initOldPrize()
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

function PayshopMibaoBuyDiscountPart:_setOldPrize(payType, payGoodsId)
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

function PayshopMibaoBuyDiscountPart:_updateView()
	self:_hideAll()

	if self._discId > 0 then
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._discId)
		local isOk = PayShopController.instance:checkDiscountPlanConditionPass(dcfg.id)

		if isOk then
			local discountTime = PayShopModel.instance:getUseDiscountTimes(self._goodsCfg.id)

			if discountTime < self._goodsCfg.discountLimitTimes or self._goodsCfg.discountLimitTimes <= 0 then
				self:_showDiscountItemName(self._discId)
			end
		end
	end

	if self._hasDisc then
		self:_showMainGo()
	end

	goutil.setActive(self._btnNoUseDisc.gameObject, self._hasDisc and self._discId <= 0)
	goutil.setActive(self._btnJumpDisc.gameObject, self._hasDisc and self._discId > 0)
end

function PayshopMibaoBuyDiscountPart:_showMainGo()
	if #self._discountCfgGroup > 1 then
		self._isShowPart = true
	else
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(self._bestDisPlanId)

		if not string.nilorempty(dcfg.discountCost) then
			self._isShowPart = true
		end
	end

	goutil.setActive(self.mainGO, self._isShowPart)
end

function PayshopMibaoBuyDiscountPart:_hideAll()
	self._isShowPart = false

	goutil.setActive(self.mainGO, false)
	goutil.setActive(self._txtItemName.gameObject, false)
end

function PayshopMibaoBuyDiscountPart:isShowPart()
	return self._isShowPart
end

function PayshopMibaoBuyDiscountPart:_PayShopSelectDiscountId(goodsDefineId, id)
	if self._goodsCfg.id == goodsDefineId then
		self._discId = id or 0

		self:_updateView()
	end
end

function PayshopMibaoBuyDiscountPart:setSelectNum(num)
	self._selectNum = num

	self:_updateView()
end

function PayshopMibaoBuyDiscountPart:_showDiscountItemName(disCountPlanId)
	local dcfg = PayShopConfig.instance:getDiscountPlanCfg(disCountPlanId)

	goutil.setActive(self._txtItemName.gameObject, true)

	self._txtItemName.text = MaterialMgr.getMaterialsNameByCfg(dcfg.discountCost)
end

return PayshopMibaoBuyDiscountPart
