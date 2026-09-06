-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/TreasureBuyView.lua

module("logic.extensions.sevendays.view.TreasureBuyView", package.seeall)

local TreasureBuyView = class("TreasureBuyView", ViewComponent)
local json = require("cjson")

function TreasureBuyView:ctor()
	TreasureBuyView.super.ctor(self)

	self.goodsTranGoList = nil
end

function TreasureBuyView:onExitFinished()
	return
end

function TreasureBuyView:onEnterFinished()
	return
end

function TreasureBuyView:buildUI()
	TreasureBuyView.super.buildUI(self)

	self.closeClickGo = self:getGo("closeClickGo")

	local viewBgGo = self:getGo("viewBgGo")

	self.titleNameTxt = goutil.findChildTextComponent(viewBgGo, "titleNameTxt")
	self.goodsIconGo = goutil.findChild(viewBgGo, "goodsIconIma")
	self.goodsNameTxt = goutil.findChildTextComponent(viewBgGo, "goodsNameTxt")
	self.updataTxt = goutil.findChildTextComponent(viewBgGo, "updataTxt")
	self.lbnrTxt = goutil.findChildTextComponent(viewBgGo, "lbnrTxt")
	self.limitTxt = goutil.findChildTextComponent(viewBgGo, "limitTxt")
	self.buyClickBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "buyClickBtn")
	self.buyShowTxt = goutil.findChildTextComponent(viewBgGo, "buyClickBtn/buyShowTxt")
	self.buyIconGo = goutil.findChild(viewBgGo, "buyClickBtn/buyIconGo")
	self.goodsTranGoList = {
		goutil.findChild(viewBgGo, "goodsTranGo_1"),
		goutil.findChild(viewBgGo, "goodsTranGo_2"),
		goutil.findChild(viewBgGo, "goodsTranGo_3")
	}
end

function TreasureBuyView:bindEvents()
	TreasureBuyView.super.bindEvents(self)
	GameUtil.asBtn(self.closeClickGo):AddClickListener(self.close, self)
	self.buyClickBtn:AddClickListener(self.OnClickBuyBtn, self)
end

function TreasureBuyView:unbindEvents()
	TreasureBuyView.super.unbindEvents(self)
	GameUtil.asBtn(self.closeClickGo):RemoveClickListener()
	self.buyClickBtn:RemoveClickListener()
end

function TreasureBuyView:onExit()
	TreasureBuyView.super.onExit(self)

	if self.goodsTranGoList and #self.goodsTranGoList > 0 then
		for i = 1, #self.goodsTranGoList do
			if self.goodsTranGoList[i] then
				MaterialMgr.resetAll(self.goodsTranGoList[i])
			end
		end
	end
end

function TreasureBuyView:destroyUI()
	TreasureBuyView.super.destroyUI(self)

	self.goodsTranGoList = nil
end

function TreasureBuyView:onEnter()
	TreasureBuyView.super.onEnter(self)

	self.openIndex = 1
	self.openItemId = 0

	if self._viewPresentor._openParam == nil then
		error("sr---活动购买参数  TreasureBuyView:onEnter()    传入的类型为空！ ")

		return
	end

	if checknumber(self._viewPresentor._openParam[1]) > 0 then
		self.openIndex = checknumber(self._viewPresentor._openParam[1])
	end

	if checknumber(self._viewPresentor._openParam[2]) > 0 then
		self.openItemId = checknumber(self._viewPresentor._openParam[2])
	end

	if self.openItemId <= 0 then
		error("sr---活动购买参数  TreasureBuyView:onEnter()    传入的礼包为空！ ")

		return
	end

	self:StartInitShow()
end

function TreasureBuyView:StartInitShow()
	self.itemCfg = nil

	if self.openIndex == 1 then
		local planId = SevenDaysModel.instance:GetNowOpenPlanId()
		local cfg = TreasureBoxConfig.instance:GetShopBuyCfg(planId, self.openItemId)

		if cfg == nil then
			error("sr---活动购买  TreasureBuyView:StartInitShow()    未得到配置 planId、itemId = " .. planId .. "， " .. self.openItemId)

			return
		end

		self.itemCfg = cfg

		uGuiUtil.setSpriteToImage(self.goodsIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.itemIcon))

		self.goodsNameTxt.text = cfg.itemName
		self.updataTxt.text = "每日5点刷新"
		self.lbnrTxt.text = "礼包内容："

		local buyCount = SevenDaysModel.instance:GetShopBuyCount(self.openItemId)

		self.limitTxt.text = checknumber(cfg.dailyLimitTimes) < 1 and "" or string.format("每日限购%s/%s", cfg.dailyLimitTimes - buyCount, cfg.dailyLimitTimes)

		if not string.nilorempty(cfg.sellContent) then
			local list = string.split(cfg.sellContent, "#")

			for i = 1, #self.goodsTranGoList do
				if list[i] and not string.nilorempty(list[i]) then
					local goodsList = string.split(list[i], ":")
					local subLua = MaterialMgr.setCell(checknumber(goodsList[1]), checknumber(goodsList[2]), self.goodsTranGoList[i])

					subLua.binder:setNum(checknumber(goodsList[3]))
				end
			end
		end

		self.buyIconGo:SetActive(false)

		if not string.nilorempty(cfg.goodsId) then
			local payCfg = PayConfig.instance:getPayGoodsCfg(cfg.goodsId)

			if payCfg then
				if not payCfg.payMoney then
					local count = 600

					self.buyShowTxt.text = "¥ " .. count * PayModel.RMB_UNIT

					return
				end
			end
		end

		if string.nilorempty(cfg.sellPrice) then
			self.buyShowTxt.text = "免费"

			return
		end

		local priceList = string.split(cfg.sellPrice, ":")
		local priceType = checknumber(priceList[1])
		local priceId = checknumber(priceList[2])
		local priceCount = checknumber(priceList[3])

		if priceType == MatType.Diamond_Consume then
			priceCount = GoodsConfig.instance:getCfgPrice(priceId) * priceCount
		end

		self.buyShowTxt.text = tostring(priceCount)

		self.buyIconGo:SetActive(true)
		MaterialMgr.setIcon(self.buyIconGo, priceType, priceId)

		local len = StringUtil.GetUtf8Length(tostring(priceCount))

		Framework.TransformUtil.SetLocalPos(self.buyIconGo.transform, -25 - (len - 1) * 7, 5, 0)
	end
end

function TreasureBuyView:OnClickBuyBtn()
	if self.itemCfg == nil then
		return
	end

	if self.openIndex == 1 then
		local activityId = SevenDaysModel.instance:CalculationWishingWellOpen()

		if activityId <= 0 then
			FloatWordMgr.instance:show("活动已结束，无法购买礼包！")

			return
		end

		local buyCount = SevenDaysModel.instance:GetShopBuyCount(self.itemCfg.itemId)

		if checknumber(self.itemCfg.dailyLimitTimes) > 0 and buyCount >= self.itemCfg.dailyLimitTimes then
			FloatWordMgr.instance:show("今日购买已达上限！")

			return
		end

		if not string.nilorempty(self.itemCfg.goodsId) then
			self:close()

			local para = {
				itemId = self.itemCfg.itemId
			}

			PayController.instance:pay(self.itemCfg.goodsId, GameEnum.PaySubGoodsType.PAY_WISHINGWELLSHOP, activityId, json.encode(para))

			return
		end

		if string.nilorempty(self.itemCfg.sellPrice) then
			self:close()
			SevenDaysController.instance:CSRequestWishingWellShopBuy(self.itemCfg.itemId)

			return
		end

		local priceList = string.split(self.itemCfg.sellPrice, ":")

		if priceList == nil or #priceList < 2 then
			self:close()
			SevenDaysController.instance:CSRequestWishingWellShopBuy(self.itemCfg.itemId)

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
			SevenDaysController.instance:CSRequestWishingWellShopBuy(self.itemCfg.itemId)
		end
	end
end

return TreasureBuyView
