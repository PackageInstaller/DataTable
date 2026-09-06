-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerGiftView.lua

module("logic.extensions.jisummoner.view.JiSummonerGiftView", package.seeall)

local JiSummonerGiftView = class("JiSummonerGiftView", ViewComponent)

function JiSummonerGiftView:ctor()
	JiSummonerGiftView.super.ctor(self)
end

function JiSummonerGiftView:bindEvents()
	JiSummonerGiftView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._moneyBtn:AddClickListener(function()
		local shopId = checknumber(self._paramCfg.shopId)
		local shopCfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopId)

		PayController.instance:pay(shopCfg.originalGoodsId, shopCfg.payType, shopId)
		self:close()
	end, self)
end

function JiSummonerGiftView:unbindEvents()
	JiSummonerGiftView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._moneyBtn:RemoveClickListener()
end

function JiSummonerGiftView:onExit()
	JiSummonerGiftView.super.onExit(self)
	self:clearItems()
	removetimer(self._calculationSurplusTime, self)
end

function JiSummonerGiftView:destroyUI()
	JiSummonerGiftView.super.destroyUI(self)
end

function JiSummonerGiftView:buildUI()
	JiSummonerGiftView.super.buildUI(self)

	self._goodsTran = self:getGo("goodsTran").transform
	self._itemCell = self:getGo("itemCell")
	self._closeBtn = self:getBtn("closeBtn")
	self._moneyBtn = self:getBtn("moneyBtn")
	self._moneyTxt = self:getGo("moneyBtn/moneyTxt"):GetComponent("Text")
	self._timeTxt = self:getGo("middleGo/timeTxt"):GetComponent("Text")
	self._timeTxt.text = ""

	GameUtil.SetActive(self._itemCell, false)
end

function JiSummonerGiftView:onEnter()
	JiSummonerGiftView.super.onEnter(self)

	self._paramCfg = self:getFirstParam()

	if self._paramCfg == nil then
		printError("sr----  JiSummonerGiftView:onEnter() y运营-极召唤师礼包    未传入参数！！")

		return
	end

	self._shopTime = checknumber(self._viewPresentor._openParam[2])

	local shopId = checknumber(self._paramCfg.shopId)
	local shopCfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopId)

	self:showItems((shopCfg and not string.nilorempty(shopCfg.content) or nil) and string.split(shopCfg.content, "#"))

	local payCfg = PayConfig.instance:getPayGoodsCfg(shopCfg.goodsId)

	self._moneyTxt.text = payCfg and "￥" .. payCfg.payMoney / 100 or "￥6"

	self:_showActivityTimer()
end

function JiSummonerGiftView:showItems(list)
	self:clearItems()

	if list == nil or #list == 0 then
		return
	end

	for i = 1, #list do
		if list[i] and not string.nilorempty(list[i]) then
			local cell = goutil.clone(self._itemCell, "itemCell_" .. i)

			GameUtil.SetActive(cell, true)
			MaterialMgr.setCellByCfg(list[i], cell)
			goutil.addChildToParent(cell, self._goodsTran)
			Framework.TransformUtil.SetLocalPos(cell.transform, 0, 3, 0)
		end
	end
end

function JiSummonerGiftView:clearItems()
	if self._goodsTran == nil or self._goodsTran.childCount == 0 then
		return
	end

	for i = self._goodsTran.childCount, 1, -1 do
		local childGo = self._goodsTran:GetChild(i - 1)

		MaterialMgr.resetAll(childGo.gameObject)
		UnityEngine.GameObject.Destroy(childGo.gameObject)
	end

	self._goodsTran:DetachChildren()
end

function JiSummonerGiftView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	if self._shopTime <= 0 then
		FloatWordMgr.instance:show("活动已结束")
		self:close()

		return
	end

	self:_calculationSurplusTime()
	settimer(1, self._calculationSurplusTime, self, true)
end

function JiSummonerGiftView:_calculationSurplusTime()
	self._shopTime = self._shopTime - 1

	if self._shopTime <= 0 then
		removetimer(self._calculationSurplusTime, self)
		FloatWordMgr.instance:show("活动已结束")
		self:close()

		return
	end

	self._timeTxt.text = GameUtil.FormatTimeSymbol(self._shopTime)
end

return JiSummonerGiftView
