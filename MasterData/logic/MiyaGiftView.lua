-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaGiftView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaGiftView", package.seeall)

local MiyaGiftView = class("MiyaGiftView", ViewComponent)

function MiyaGiftView:unbindEvents()
	MiyaGiftView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function MiyaGiftView:bindEvents()
	MiyaGiftView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function MiyaGiftView:onExit()
	MiyaGiftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MiyaBuyGoodSuccess, self._updateUI, self)
end

function MiyaGiftView:buildUI()
	MiyaGiftView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._gridItems = self:getGo("ScrollView/Viewport/Content")
	self._slider = self:getSlider("ScrollView/Viewport/Content/progress")
	self._scrollView = self:getGo("ScrollView")
	self._gift = self:getGo("gift")
	self._singleGift = goutil.findChild(self._gift, "item")
end

function MiyaGiftView:onEnter()
	MiyaGiftView.super.onEnter(self)
	self:_updateUI()
	GlobalDispatcher:addListener(GlobalNotify.MiyaBuyGoodSuccess, self._updateUI, self)
end

function MiyaGiftView:_updateUI()
	self._buyProcess = MiyaGameModel.instance:getBuyProcess()

	local cfgs = MiyaGameConfig.instance:getGoodCfgs()
	local isSingle = #cfgs == 1

	self._scrollView:SetActive(not isSingle)
	self._gift:SetActive(isSingle)
	print("isSingle = " .. tostring(isSingle))

	if isSingle then
		self:_updateOneGift(self._singleGift, cfgs[1])
	else
		GameUtil.updateCellsWithCreate(self._gridItems, cfgs, self._updateOneGift, self, 1)
	end

	local value = (83 + 220 * self._buyProcess) / (220 * #cfgs - 52)

	self._slider:SetValue(value)
end

function MiyaGiftView:_onClickBuy(cfg)
	PayController.instance:pay(cfg.payGoodsId, 15, cfg.id)
end

function MiyaGiftView:_updateOneGift(cell, cfg)
	local imgIcon = goutil.findChild(cell, "imgIcon")
	local txtDiscount = goutil.findChildTextComponent(cell, "discount/txtDiscount")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtPrice = goutil.findChildTextComponent(cell, "txtPrice")
	local txtTip = goutil.findChildTextComponent(cell, "txtTip")
	local btnBuy = Framework.ButtonAdapter.GetFrom(cell, "btnBuy")
	local purchased = goutil.findChild(cell, "purchased")
	local matType, matId, matNum = unpack(string.splitToNumber(cfg.goods, ":"))

	MaterialMgr.setIcon(imgIcon, matType, matId)

	txtDiscount.text = cfg.discount .. "折"

	local goodType, goodNum = unpack(string.splitToNumber(cfg.payGoodsId, "_"))

	txtPrice.text = "¥ " .. goodNum

	local matCfg = MaterialMgr.getMatCfg(matType, matId)

	txtName.text = matCfg.name .. "x" .. matNum

	if not goutil.isNil(txtTip) then
		txtTip.gameObject:SetActive(false)
	end

	btnBuy.gameObject:SetActive(false)
	purchased.gameObject:SetActive(false)

	if cfg.id == self._buyProcess + 1 then
		btnBuy.gameObject:SetActive(true)
		btnBuy:AddClickListener(function()
			self:_onClickBuy(cfg)
		end)
	elseif cfg.id < self._buyProcess + 1 then
		purchased.gameObject:SetActive(true)
	else
		txtTip.gameObject:SetActive(true)
	end
end

return MiyaGiftView
