-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopMessItem.lua

module("logic.extensions.shop.view.ShopMessItem", package.seeall)

local ShopMessItem = class("ShopMessItem")
local LuaComponentContainer = Framework.LuaComponentContainer
local limitTypes = {
	none = "",
	person = lang("限购:"),
	global = lang("全服购售:")
}
local limitPeriod = {
	[""] = "",
	weekly = lang("每周"),
	daily = lang("每日"),
	monthly = lang("每月"),
	allTime = lang("永久"),
	none = lang("不限购")
}

function ShopMessItem.AddOnce(go)
	local component = ShopMessItem.Get(go)

	component = component or LuaComponentContainer.Add(go, ShopMessItem)

	return component
end

function ShopMessItem.Remove(go)
	LuaComponentContainer.Remove(go, ShopMessItem)
end

function ShopMessItem.Get(go)
	return (LuaComponentContainer.Get(go, ShopMessItem))
end

function ShopMessItem:ctor(target)
	local container = target.gameObject

	self._target = target
	self._icon = goutil.findChild(container, "Icon")
	self._selectObj = goutil.findChild(container, "ImgSelect")
	self._nameTxt = goutil.findChildTextComponent(container, "TxtName")
	self._limitTxt = goutil.findChildTextComponent(container, "limit/txtLimit")
	self._limitObj = goutil.findChild(container, "limit")
	self._priceTxt = goutil.findChildTextComponent(container, "ImgCnt")
	self._spr = goutil.findChild(container, "ImgCnt/diamond"):GetComponent("UIImageSpriteChange")
	self._btn = GameUtil.asBtn(goutil.findChild(container, "okBtn"))
	self._timeObj = goutil.findChild(container, "ImgLimit")
	self._hotObj = goutil.findChild(container, "imghot")
	self._hotTxt = goutil.findChildTextComponent(container, "imghot/Text")
	self._soldObj = goutil.findChild(container, "imgover")
	self._openObj = goutil.findChild(container, "openTip")
	self._openTxt = goutil.findChildTextComponent(container, "openTip/Text")

	self._btn:AddClickListener(self._onClickBtn, self)
end

function ShopMessItem:OnDestroy()
	self._btn:RemoveClickListener()

	self._info = nil
end

function ShopMessItem:init(goodsInfo)
	self._info = goodsInfo

	local isOpen = FuncOpenController.instance:getConditionReached(self._info.openCondition)
	local isLock = not isOpen

	self._openObj:SetActive(isLock)
	self._hotObj:SetActive(isOpen and goodsInfo.tag ~= "")

	self._openTxt.text = self._info.lockedTips

	self._timeObj:SetActive(goodsInfo.sellTime ~= "全天")

	local isLimitBuy = goodsInfo.sellTargetLimit ~= "none"
	local times = ShopModel.instance:getGoodsCount(goodsInfo.id)

	self._soldObj:SetActive(isLimitBuy and times >= goodsInfo.limitTimes)

	self._nameTxt.text = goodsInfo.name

	local isSelect = goodsInfo.id == ShopModel.instance:getSelect()

	self._limitObj:SetActive(isLimitBuy)

	if isLimitBuy then
		local count = goodsInfo.limitTimes - times

		self._limitTxt.gameObject:SetActive(goodsInfo.sellTargetLimit ~= "none")

		self._limitTxt.text = limitPeriod[goodsInfo.limitType] .. limitTypes[goodsInfo.sellTargetLimit] .. count .. "/" .. goodsInfo.limitTimes
	end

	self:_setGoodsPrice(goodsInfo)

	local contentList = string.split(goodsInfo.content, "#")
	local proxy = MaterialMgr.setCellByCfg(contentList[1], self._icon)

	if proxy then
		proxy:setAutoTips(true)
		proxy:setCallBack(function()
			ShopController.instance:reportBehavior(goodsInfo)
		end)
	end
end

function ShopMessItem:_setGoodsPrice(goodsInfo)
	local isDiscount = PayShopModel.instance:checkCanDisCount(goodsInfo.id)
	local payGoodsId = goodsInfo.originalGoodsId

	if isDiscount then
		payGoodsId = PayShopModel.instance:getBuyItemMinCostPayGoodsId(goodsInfo.id)
	end

	if goodsInfo.payType == GameEnum.PayShopPayType.RMB then
		local payCfg = PayConfig.instance:getPayGoodsCfg(payGoodsId)

		self._priceTxt.text = "¥ " .. payCfg.payMoney * PayModel.RMB_UNIT
	else
		local currList = string.split(payGoodsId, ":")
		local matType, matId, matNum = checknumber(currList[1]), checknumber(currList[2]), checknumber(currList[3])

		self._priceTxt.text = MaterialFacade:getGoodCost(matType, matId, matNum)
	end

	self:_setItemShow(goodsInfo, payGoodsId)
end

function ShopMessItem:_setItemShow(goodsInfo, payGoodsId)
	goutil.setActive(self._spr.gameObject, goodsInfo.payType ~= GameEnum.PayShopPayType.RMB)

	if goodsInfo.payType == GameEnum.PayShopPayType.RMB then
		-- block empty
	else
		MaterialMgr.updateItemByStr(self._spr.gameObject, payGoodsId)
	end
end

function ShopMessItem:reset()
	MaterialMgr.resetAll(self._icon)
end

function ShopMessItem:_onClickBtn()
	local disCountPlanId = -1
	local isDiscount = PayShopModel.instance:checkCanDisCount(self._info.id)

	if isDiscount then
		_, disCountPlanId = PayShopModel.instance:getBuyItemMinCostPayGoodsId(self._info.id)
	end

	ShopController.instance:reportBehavior(self._info)

	if not FuncOpenController.instance:getConditionReached(self._info.openCondition) then
		FloatWordMgr.instance:show(self._info.feedbackTips)
	else
		ShopModel.instance:select(self._info.id)

		if self._info.payType == GameEnum.PayShopPayType.RMB then
			PayShopController.instance:buyShopItem(self._info.id, 1, disCountPlanId)
		else
			local times = ShopModel.instance:getGoodsCount(self._info.id)
			local count = -1

			if self._info.sellTargetLimit ~= "none" then
				if times >= self._info.limitTimes then
					TipsFacade.instance:openCommonTips(lang("物品已售罄"))

					return
				else
					count = self._info.limitTimes - times
				end
			end

			ShopController.instance:localNotify(ShopController.MESSSELECTCHANGE)
			UIStateManager.instance:push(ViewName.SellcellView, self._info, count)
		end
	end
end

return ShopMessItem
