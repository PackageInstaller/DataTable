-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/SellcellView.lua

module("logic.extensions.shop.view.SellcellView", package.seeall)

local SellcellView = class("SellcellView", ViewComponent)
local limitTypes = {
	none = "",
	person = lang("限购:"),
	global = lang("全服限购:")
}
local limitPeriod = {
	[""] = "",
	weekly = lang("每周"),
	daily = lang("每日"),
	monthly = lang("每月"),
	allTime = lang("永久"),
	none = lang("不限购")
}

function SellcellView:ctor()
	SellcellView.super.ctor(self)
end

function SellcellView:buildUI()
	SellcellView.super.buildUI(self)

	self._icon = self:getGo("content/Icon")
	self._timeObj = self:getGo("content/ImgTimeBg")
	self._timeTxt = self:getGo("content/ImgTimeBg/TxtTime"):GetComponent("Text")
	self._nameTxt = self:getGo("content/TxtName"):GetComponent("Text")
	self._limitTxt = self:getGo("content/TxtLimit"):GetComponent("Text")
	self._priceTxt = self:getGo("content/BgPrice/ImgCnt/TxtPrice"):GetComponent("Text")
	self._haveTxt = self:getGo("content/TxtHave"):GetComponent("Text")
	self._descTxt = self:getGo("content/TxtDesc"):GetComponent("Text")
	self._spr = self:getGo("content/BgPrice/ImgCnt"):GetComponent("UIImageSpriteChange")
	self._addBtn = self:getBtn("content/BgNum/BtnAdd")
	self._minusBtn = self:getBtn("content/BgNum/BtnMinus")
	self._addBtnTen = self:getBtn("content/BgNum/BtnAddTen")
	self._minusBtnTen = self:getBtn("content/BgNum/BtnMinusTen")
	self._buyBtn = self:getBtn("content/BtnBuy")
	self._returnBtn = self:getBtn("btnRtn")
	self._input = self:getInput("content/BgNum")
	self._nameTxt = self:getGo("content/TxtName"):GetComponent("Text")
	self.group = self:getGo("content/TxtName"):GetComponent("UIChangeGroup")
end

function SellcellView:bindEvents()
	SellcellView.super.bindEvents(self)
	self._addBtn:AddClickListener(self._onClickAdd, self)
	self._minusBtn:AddClickListener(self._onClickMinus, self)
	self._addBtnTen:AddClickListener(self._onClickAddTen, self)
	self._minusBtnTen:AddClickListener(self._onClickMinusTen, self)
	self._buyBtn:AddClickListener(self._onClickBuy, self)
	self._returnBtn:AddClickListener(self._onClickReturn, self)
	self._input:AddOnValueChanged(self._buyCountChanged, self)
end

function SellcellView:unbindEvents()
	SellcellView.super.unbindEvents(self)
	self._addBtn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtnTen:RemoveClickListener()
	self._minusBtnTen:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
	self._returnBtn:RemoveClickListener()
	self._input:RemoveOnValueChanged()
end

function SellcellView:destroyUI()
	SellcellView.super.destroyUI(self)
end

function SellcellView:onEnter()
	SellcellView.super.onEnter(self)
	GlobalDispatcher:addListener(PayShopModel.ChangeMibaoShopBuyTimes, self._onBuyItemRes, self)

	local param = self:getOpenParam()

	self:_refreshSelect(param[1], param[2])
end

function SellcellView:onEnterFinished()
	SellcellView.super.onEnterFinished(self)
end

function SellcellView:onExit()
	SellcellView.super.onExit(self)
	MaterialMgr.resetAll(self._icon)
	GlobalDispatcher:removeListener(PayShopModel.ChangeMibaoShopBuyTimes, self._onBuyItemRes, self)
end

function SellcellView:onExitFinished()
	SellcellView.super.onExitFinished(self)
end

function SellcellView:_refreshSelect(data, count)
	self._info = data

	if self._info then
		local goodsInfo = self._info

		self._count = count

		local strs = string.split(goodsInfo.content, ":")
		local matType = checknumber(strs[1])
		local matId = checknumber(strs[2])

		matType, matId = MaterialMgr.changeIfDropByTypeAndId(matType, matId)

		local isLimitBuy = goodsInfo.sellTargetLimit ~= "none"

		self._buyCount = 1

		self._timeObj:SetActive(goodsInfo.sellTime ~= "全天")
		self._limitTxt.gameObject:SetActive(isLimitBuy)

		if isLimitBuy then
			self._limitTxt.text = limitPeriod[goodsInfo.limitType] .. limitTypes[goodsInfo.sellTargetLimit] .. count .. "/" .. goodsInfo.limitTimes
		end

		self._haveTxt.text = "拥有：" .. MaterialFacade.instance:getMatNumber(matType, matId)

		self.group:SetState(0)

		if matType == MatType.Pet then
			local cfg = CharacterConfig.instance:getPetInfoCo(matId)

			self._descTxt.text = cfg.introduce
			self._nameTxt.text = cfg.name

			self.group:SetState(cfg.rare or 0)
		else
			local cfg = MaterialFacade.instance:getMatCfg(matType, matId)

			self._descTxt.text = cfg.desc
			self._nameTxt.text = cfg.name

			self.group:SetState(cfg.quality or 0)
		end

		local proxy = MaterialMgr.setCellByCfg(goodsInfo.content, self._icon)

		proxy:setAutoTips(false)
		self:_refreshBuyCount()
		ShopController.instance:setMoneyType(self._spr, goodsInfo.payType)
	end
end

function SellcellView:_buyCountChanged()
	self._buyCount = checknumber(self._input:GetText())

	self:_refreshBuyCount()
end

function SellcellView:_refreshBuyCount()
	local payGoodsId = ""

	payGoodsId = PayShopController.instance:checkTimeStr(self._info.discountTime) and self._info.discountGoodsId or self._info.originalGoodsId

	local matType, matId, matNum = unpack(string.splitToNumber(payGoodsId, ":"))
	local limitCount = math.floor(MaterialModel.instance:getMaterialsNumber(matType, matId) / matNum)

	self._buyCount = math.max(self._buyCount, 1)
	self._buyCount = math.min(self._buyCount, limitCount)
	self._buyCount = self._info.limitTimes > 0 and math.min(self._buyCount, self._count) or math.min(self._buyCount, 99)

	if not string.nilorempty(payGoodsId) then
		if self._info.payType == GameEnum.PayShopPayType.RMB then
			self._priceTxt.text = "没做"
		else
			local currList = string.split(payGoodsId, ":")
			local currprice = 0

			if checknumber(currList[1]) == MatType.Diamond_Consume then
				local gcfg = GoodsConfig.instance:getCfg(checknumber(currList[2]))

				currprice = gcfg.price * checknumber(currList[3])
			else
				currprice = currList[3]
			end

			self._priceTxt.text = currprice * self._buyCount
		end
	else
		self._priceTxt.text = "免费"
	end

	local str = tostring(self._buyCount)

	self._input:SetText(str)
	self:_setItemShow(payGoodsId)
end

function SellcellView:_setItemShow(payGoodsId)
	if self._info.payType == GameEnum.PayShopPayType.RMB then
		-- block empty
	else
		MaterialMgr.updateItemByStr(self._spr, payGoodsId)
	end
end

function SellcellView:_onClickAdd()
	self._buyCount = self._buyCount + 1

	self:_refreshBuyCount()
end

function SellcellView:_onClickMinus()
	self._buyCount = self._buyCount - 1

	self:_refreshBuyCount()
end

function SellcellView:_onClickAddTen()
	self._buyCount = self._buyCount + 10

	self:_refreshBuyCount()
end

function SellcellView:_onClickMinusTen()
	self._buyCount = self._buyCount - 10

	self:_refreshBuyCount()
end

function SellcellView:_onClickBuy()
	if not FuncOpenController.instance:getConditionReached(self._info.openCondition) then
		FloatWordMgr.instance:show(self._info.feedbackTips)
	elseif self._buyCount > 0 then
		ShopController.instance:checkBuyGood(self._info, self._buyCount)
	else
		FloatWordMgr.instance:show(lang("购买数量不能为0"))
	end
end

function SellcellView:_onBuyItemRes(id)
	self:_onClickReturn()
end

function SellcellView:_onClickReturn()
	self:close()
end

return SellcellView
