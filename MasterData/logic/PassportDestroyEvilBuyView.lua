-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/destroyevil/PassportDestroyEvilBuyView.lua

module("logic.extensions.passport.view.destroyevil.PassportDestroyEvilBuyView", package.seeall)

local PassportDestroyEvilBuyView = class("PassportDestroyEvilBuyView", ViewComponent)

function PassportDestroyEvilBuyView:ctor()
	PassportDestroyEvilBuyView.super.ctor(self)
end

function PassportDestroyEvilBuyView:bindEvents()
	PassportDestroyEvilBuyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
	self._btnGet:AddClickListener(self._onClickBtnGet, self)
	GameUtil.addClickHandler(self._btnDiscount, self._onClickBtnBuy, self)
end

function PassportDestroyEvilBuyView:unbindEvents()
	PassportDestroyEvilBuyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnDiscount)
end

function PassportDestroyEvilBuyView:buildUI()
	PassportDestroyEvilBuyView.super.buildUI(self)

	self._btnClose = GameUtil.asBtn(self:getGo("BG/btnClose"))
	self._btnBuy = self:getBtn("BG/btnBuy")
	self._btnGet = self:getBtn("BG/btnGet")
	self._txtGoodCost = goutil.findChildTextComponent(self.mainGO, "BG/btnBuy/txt")
	self._goItem = self:getGo("BG/item")
	self._goBtnGet = self:getGo("BG/btnGet")
	self._goTableNow = self:getGo("BG/prizeNow/tableShow")
	self._tableviewNow = ScrollerList.create(self._goTableNow, self._goItem, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtPrice = self:getTxt("BG/originalPrice")
	self._txtDesc = self:getTxt("BG/txtDesc")
	self._discountTip = self:getGo("BG/discountTip")
	self._btnDiscount = goutil.findChild(self._discountTip, "btnBuy")
	self._txtDiscount = goutil.findChildTextComponent(self._btnDiscount, "txt")
	self._txtDiscount_1 = goutil.findChildTextComponent(self._btnDiscount, "txt_1")
	self._originalPrice = self:getGo("BG/price")
	self._txtOriginalPrice = self:getTxt("BG/price/originalPrice")
	self._txtNowPrice = self:getTxt("BG/price/txtNow")
	self._originalPriceIcon = self:getGo("BG/price/icon")
	self._imgPrivilege = self:getGo("BG/prizePrivilege/imgPrivilege")
end

function PassportDestroyEvilBuyView:onEnter()
	PassportDestroyEvilBuyView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil or #params < 2 then
		self:close()

		return
	end

	self._actCfg = params[1]
	self._funcCfg = params[2]

	local goodsId = self._actCfg.goodsId
	local isVipDiscount = VipModel.instance:getIsAbleToPassportDiscount()
	local isTimeDiscount = not string.nilorempty(self._actCfg.discountTime) and GameUtil.checkTimeStr(self._actCfg.discountTime)

	if isVipDiscount then
		goodsId = self._actCfg.vipGoodsId
	end

	local price = PayConfig.instance:getPayMoneyYuan((isTimeDiscount or nil) and self._actCfg.discountGoodsId)

	self._txtGoodCost.text = string.format("¥%s", price)
	self._txtDiscount.text = string.format("¥%s", price)
	self._txtDiscount_1.text = string.format("¥%s", PayConfig.instance:getPayMoneyYuan(self._actCfg.goodsId))
	self._txtOriginalPrice.text = string.format("¥%s", PayConfig.instance:getPayMoneyYuan(self._actCfg.goodsId))
	self._txtNowPrice.text = string.format("¥%s", price)

	GameUtil.SetActive(self._originalPriceIcon, false)
	GameUtil.SetActive(self._discountTip, false)
	GameUtil.SetActive(self._btnBuy, false)

	if isTimeDiscount then
		GameUtil.SetActive(self._originalPrice, true)
		GameUtil.SetActive(self._discountTip, true)
	else
		if isVipDiscount then
			GameUtil.SetActive(self._originalPrice, false)
		else
			GameUtil.SetActive(self._originalPrice, false)
		end

		GameUtil.SetActive(self._btnBuy, true)
	end

	GameUtil.SetActive(self._goImgMark, false)
	self:_refreshTable()

	if not string.nilorempty(self._actCfg.vipGoodsId) then
		local vipPrice = PayConfig.instance:getPayMoneyYuan(self._actCfg.vipGoodsId)
		local ogriginalPicee = PayConfig.instance:getPayMoneyYuan(self._actCfg.goodsId)

		if vipPrice ~= ogriginalPicee then
			self._txtDesc.text = langPara("VIP3及以上：<color=#20b376>%d元</color>", vipPrice)

			GameUtil.SetActive(self._txtDesc, true)
		else
			GameUtil.SetActive(self._txtDesc, false)
		end
	else
		GameUtil.SetActive(self._txtDesc, false)
	end

	local proxy = MaterialMgr.setCell(MatType.ACTIVITY_ITEM, 250999, self._imgPrivilege)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function PassportDestroyEvilBuyView:onExit()
	PassportDestroyEvilBuyView.super.onExit(self)
	MaterialMgr.resetAll(self._imgPrivilege)
	self._tableviewNow:dispose()
end

function PassportDestroyEvilBuyView:_refreshTable()
	local dataListNow
	local data1, data2, data3 = PassportModel.instance:getCurDataList(nil, self._funcCfg.id)

	self._tableviewNow:reloadData(data3)
end

function PassportDestroyEvilBuyView:_clearCell(cell)
	local point = goutil.findChild(cell, "point")

	MaterialMgr.resetAll(point)
end

function PassportDestroyEvilBuyView:_updateCell(view, cell, data)
	local point = goutil.findChild(cell, "point")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	if data then
		MaterialMgr.setCellByCfg(data, point)

		txtName.text = MaterialMgr.getMaterialsNameByCfg(data)
	else
		MaterialMgr.resetAll(point)
	end
end

function PassportDestroyEvilBuyView:_onClickBtnBuy()
	local periodData = PassportConfig.instance:getPeriodActivityCfgById(self._actCfg.actId)
	local paymentData = PassportConfig.instance:getPermanentPrizeCfgsByActId(self._actCfg.actId)

	if periodData then
		PassportController.instance:_buyPassportWithDifferentPayType(self._actCfg.actId, false)
	elseif paymentData then
		local para = {
			prizeType = 2,
			funcId = self._funcCfg.id
		}

		if VipModel.instance:getIsAbleToPassportDiscount() then
			PayController.instance:sendGenOrderNoReq(self._actCfg.vipGoodsId, 3, self._actCfg.actId, json.encode(para))
		else
			PayController.instance:sendGenOrderNoReq(self._actCfg.goodsId, 3, self._actCfg.actId, json.encode(para))
		end
	else
		printError("找不到类型", self._actCfg.actId)
	end

	self:close()
end

function PassportDestroyEvilBuyView:_onClickBtnGet()
	local function handler()
		GameUtil.SetActive(self._goBtnGet, false)
		GameUtil.SetActive(self._goImgMark, true)

		local isTimeDiscount = not string.nilorempty(self._actCfg.discountTime) and GameUtil.checkTimeStr(self._actCfg.discountTime)

		if isTimeDiscount then
			GameUtil.SetActive(self._discountTip, true)
		else
			GameUtil.SetActive(self._btnBuy.gameObject, true)
		end
	end

	PassportController.instance:sendOneKeyGainPrizeReq(self._actCfg.actId, self._funcCfg.id, handler, self)
	self:close()
end

return PassportDestroyEvilBuyView
