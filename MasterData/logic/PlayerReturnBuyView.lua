-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnBuyView.lua

module("logic.extensions.playerreturn.view.PlayerReturnBuyView", package.seeall)

local PlayerReturnBuyView = class("PlayerReturnBuyView", ViewComponent)
local json = require("cjson")

function PlayerReturnBuyView:ctor()
	PlayerReturnBuyView.super.ctor(self)

	self._goodsItemList = nil
end

function PlayerReturnBuyView:bindEvents()
	PlayerReturnBuyView.super.bindEvents(self)
	GameUtil.asBtn(self._closeClickGo):AddClickListener(self.close, self)
	self._buyClickBtn:AddClickListener(self._onClickBuyBtn, self)
end

function PlayerReturnBuyView:unbindEvents()
	PlayerReturnBuyView.super.unbindEvents(self)
	GameUtil.asBtn(self._closeClickGo):RemoveClickListener()
	self._buyClickBtn:RemoveClickListener()
end

function PlayerReturnBuyView:onExit()
	PlayerReturnBuyView.super.onExit(self)

	for _, item in pairs(self._goodsItemList or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	MaterialMgr.resetAll(self._buyIconIma.gameObject)
end

function PlayerReturnBuyView:destroyUI()
	PlayerReturnBuyView.super.destroyUI(self)

	self._goodsItemList = nil
end

function PlayerReturnBuyView:buildUI()
	PlayerReturnBuyView.super.buildUI(self)

	self._closeClickGo = self:getGo("closeClickGo")

	local viewBgGo = self:getGo("viewBgGo")

	self._goodsIconGo = goutil.findChild(viewBgGo, "goodsIconIma")
	self._goodsNameTxt = goutil.findChildTextComponent(viewBgGo, "goodsNameTxt")
	self._limitTxt = goutil.findChildTextComponent(viewBgGo, "limitTxt")
	self._buyClickBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "buyClickBtn")
	self._buyShowTxt = goutil.findChildTextComponent(viewBgGo, "buyClickBtn/buyShowTxt")
	self._buyIconIma = goutil.findChild(viewBgGo, "buyClickBtn/buyShowTxt/buyIconIma"):GetComponent("UIImageSpriteChange")
	self._goodsItemList = {
		goutil.findChild(viewBgGo, "goodsTranGo_1"),
		goutil.findChild(viewBgGo, "goodsTranGo_2"),
		goutil.findChild(viewBgGo, "goodsTranGo_3")
	}
end

function PlayerReturnBuyView:onEnter()
	PlayerReturnBuyView.super.onEnter(self)

	local planId = self:getFirstParam()

	if checknumber(planId) <= 0 then
		printError("sr--- 玩家回归 PlayerReturnBuyView:onEnter()       未传入方案id！ ")

		return
	end

	local openShopId = self._viewPresentor._openParam[2]

	if checknumber(openShopId) <= 0 then
		printError("sr--- 玩家回归 PlayerReturnBuyView:onEnter()       传入商品id为空！ ")

		return
	end

	for _, item in pairs(self._goodsItemList or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	self._shopCfg = PlayerReturnConfig.instance:getReturnShopCfgs(planId, openShopId)

	uGuiUtil.setSpriteToImage(self._goodsIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._shopCfg.itemIcon))

	self._goodsNameTxt.text = self._shopCfg.itemName

	local buyCount = PlayerReturnModel.instance:getSingleShopBuyCount(openShopId)

	self._limitTxt.text = string.format("永久限购%s/%s", self._shopCfg.countLimit - buyCount, self._shopCfg.countLimit)

	if not string.nilorempty(self._shopCfg.content) then
		local list = string.split(self._shopCfg.content, "#")

		for i = 1, #self._goodsItemList do
			if list[i] and not string.nilorempty(list[i]) then
				local goodsList = string.split(list[i], ":")
				local subLua = MaterialMgr.setCell(checknumber(goodsList[1]), checknumber(goodsList[2]), self._goodsItemList[i])

				subLua.binder:setNum(checknumber(goodsList[3]))
			end
		end
	end

	if not string.nilorempty(self._shopCfg.payGoodsId) then
		local payCfg = PayConfig.instance:getPayGoodsCfg(self._shopCfg.payGoodsId)

		if payCfg then
			if not payCfg.payMoney then
				local count = 600

				self._buyShowTxt.text = tostring(count * PayModel.RMB_UNIT)

				self._buyIconIma:SetState(1)
				self._buyIconIma:SetState(0)

				return
			end
		end
	end

	local priceList = string.split(self._shopCfg.price, ":")
	local priceType = checknumber(priceList[1])
	local priceId = checknumber(priceList[2])
	local priceCount = checknumber(priceList[3])

	if priceType == MatType.Diamond_Consume then
		priceCount = GoodsConfig.instance:getCfgPrice(priceId) * priceCount
	end

	self._buyShowTxt.text = tostring(priceCount)

	MaterialMgr.setIcon(self._buyIconIma.gameObject, priceType, priceId)
end

function PlayerReturnBuyView:_onClickBuyBtn()
	if self._shopCfg == nil then
		return
	end

	if PlayerReturnModel.instance._isActiEnd then
		FloatWordMgr.instance:show("活动已结束，无法购买礼包！")

		return
	end

	local buyCount = PlayerReturnModel.instance:getSingleShopBuyCount(self._shopCfg.id)

	if self._shopCfg.countLimit > 0 and buyCount >= self._shopCfg.countLimit then
		FloatWordMgr.instance:show("购买已达上限！")

		return
	end

	if not string.nilorempty(self._shopCfg.payGoodsId) then
		self:close()

		local actiInfo = PlayerReturnModel.instance:getOpenActivityInfo()
		local para = {
			actId = actiInfo.actId
		}

		PayController.instance:pay(self._shopCfg.payGoodsId, GameEnum.PaySubGoodsType.PAY_PLAYERRETURNSHOP, self._shopCfg.id, json.encode(para))

		return
	end

	local priceList = string.split(self._shopCfg.price, ":")

	if priceList == nil or #priceList < 2 then
		self:close()
		PlayerReturnController.instance:csRegressBuyShopItemReq(self._shopCfg.id)

		return
	end

	local priceType = checknumber(priceList[1])
	local priceId = checknumber(priceList[2])
	local priceCount = checknumber(priceList[3])
	local haveNum = MaterialModel.instance:getMaterialsNumber(priceType, priceId) or 0

	if priceType == MatType.Diamond_Consume then
		priceCount = GoodsConfig.instance:getCfgPrice(priceId) * priceCount
	end

	if haveNum < priceCount then
		FloatWordMgr.instance:show("购买礼包所需钻石不足！")
	else
		self:close()
		PlayerReturnController.instance:csRegressBuyShopItemReq(self._shopCfg.id)
	end
end

return PlayerReturnBuyView
