-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopGiftItem.lua

module("logic.extensions.shop.view.ShopGiftItem", package.seeall)

local ShopGiftItem = class("ShopGiftItem")
local LuaComponentContainer = Framework.LuaComponentContainer
local limitTypes = {
	none = "",
	person = lang("限售:"),
	global = lang("全服限售:"),
	vip = lang("VIP限售:")
}
local limitPeriod = {
	[""] = "",
	weekly = lang("每周"),
	daily = lang("每日"),
	monthly = lang("每月"),
	allTime = lang("永久"),
	none = lang("不限购")
}

function ShopGiftItem.AddOnce(go)
	local component = ShopGiftItem.Get(go)

	component = component or LuaComponentContainer.Add(go, ShopGiftItem)

	return component
end

function ShopGiftItem.Remove(go)
	LuaComponentContainer.Remove(go, ShopGiftItem)
end

function ShopGiftItem.Get(go)
	return (LuaComponentContainer.Get(go, ShopGiftItem))
end

function ShopGiftItem:ctor(target)
	local container = target.gameObject

	self._target = target
	self._icon = goutil.findChild(container, "Icon")
	self._hotObj = goutil.findChild(container, "hot")
	self._soldObj = goutil.findChild(container, "ImgSold")
	self._nameTxt = goutil.findChildTextComponent(container, "TxtName")
	self._limitTxt = goutil.findChildTextComponent(container, "limit/txtLimit")
	self._limitGo = goutil.findChild(container, "limit")
	self._priceTxt = goutil.findChildTextComponent(container, "ImgCnt")
	self.imgCnt = goutil.findChild(container, "ImgCnt/diamond")
	self.imgCntDis = goutil.findChild(container, "ImgCntDis")
	self.txtPriceDis = goutil.findChildTextComponent(container, "ImgCntDis/text")
	self._spr = goutil.findChild(container, "ImgCnt/diamond"):GetComponent("UIImageSpriteChange")
	self._btn = GameUtil.asBtn(goutil.findChild(container, "okBtn"))

	self._btn:AddClickListener(self._onClickBtn, self)
end

function ShopGiftItem:OnDestroy()
	self._btn:RemoveClickListener()

	self._info = nil

	MaterialMgr.resetAll(self._icon)
	MaterialMgr.resetAll(self._spr)
end

function ShopGiftItem:init(goodsInfo, viewParent)
	self._info = goodsInfo

	self._hotObj:SetActive(goodsInfo.hotSale)

	local times = ShopModel.instance:getGoodsCount(goodsInfo.id)
	local isLimitBuy = self._info.sellTargetLimit ~= "none"

	self._soldObj:SetActive(isLimitBuy and times >= goodsInfo.limitTimes)

	if isLimitBuy then
		local count = goodsInfo.limitTimes - times

		self._limitTxt.text = limitPeriod[goodsInfo.limitType] .. limitTypes[goodsInfo.sellTargetLimit] .. count .. "/" .. goodsInfo.limitTimes
	end

	self._limitGo:SetActive(isLimitBuy)

	self._nameTxt.text = goodsInfo.name

	self:_setGoodsPrice(goodsInfo)

	local iconBtn = Framework.ButtonAdapter.Get(self._icon)

	iconBtn:RemoveClickListener()
	iconBtn:AddClickListener(self._onClickItem, self)

	self._viewParent = viewParent
end

function ShopGiftItem:_setGoodsPrice(goodsInfo)
	local isDiscount = PayShopModel.instance:checkCanDisCount(goodsInfo.id)
	local payGoodsId = goodsInfo.originalGoodsId

	if isDiscount then
		payGoodsId = PayShopModel.instance:getBuyItemMinCostPayGoodsId(goodsInfo.id)
	end

	GameUtil.SetActive(self.imgCntDis, isDiscount)

	if goodsInfo.payType == GameEnum.PayShopPayType.RMB then
		local payCfg = PayConfig.instance:getPayGoodsCfg(payGoodsId)

		self._priceTxt.text = "¥ " .. payCfg.payMoney * PayModel.RMB_UNIT
	else
		local currList = string.split(payGoodsId, ":")
		local orilist = string.split(goodsInfo.originalGoodsId, ":")
		local matType, matId, matNum = checknumber(currList[1]), checknumber(currList[2]), checknumber(currList[3])
		local currprice = MaterialFacade:getGoodCost(matType, matId, matNum)

		if isDiscount then
			local matType2, matId2, matNum2 = checknumber(orilist[1]), checknumber(orilist[2]), checknumber(orilist[3])

			self.txtPriceDis.text = currprice
			self._priceTxt.text = MaterialFacade:getGoodCost(matType2, matId2, matNum2)
		else
			self._priceTxt.text = currprice
		end
	end

	if isDiscount then
		self._priceTxt.fontSize = 20
		self._priceTxt.alignment = UnityEngine.TextAnchor.MiddleLeft
	else
		self._priceTxt.fontSize = 24
		self._priceTxt.alignment = UnityEngine.TextAnchor.MiddleCenter
	end

	self:_setItemShow(goodsInfo, payGoodsId)
end

function ShopGiftItem:_setItemShow(goodsInfo, payGoodsId)
	local goodsList = string.split(goodsInfo.content, "#")

	MaterialMgr.updateItemByStr(self._icon, goodsList[1])
	goutil.setActive(self._spr.gameObject, goodsInfo.payType ~= GameEnum.PayShopPayType.RMB)

	if goodsInfo.payType == GameEnum.PayShopPayType.RMB then
		-- block empty
	else
		MaterialMgr.updateItemByStr(self._spr.gameObject, payGoodsId)
	end
end

function ShopGiftItem:_onClickBtn()
	if not FuncOpenController.instance:getConditionReached(self._info.openCondition) then
		FloatWordMgr.instance:show(self._info.lockedTips)
	else
		ShopController.instance:checkBuyGood(self._info, 1)
	end

	ShopController.instance:reportBehavior(self._info)
end

function ShopGiftItem:_onClickItem()
	local arr = string.split(self._info.content, ":")
	local matType = checknumber(arr[1])
	local defineId = checknumber(arr[2])

	matType, defineId = MaterialMgr.changeIfDropByTypeAndId(matType, defineId)

	if matType == MatType.Pet then
		local lvl = 1
		local raceId = defineId
		local co = MaterialMgr.getMatCfg(MatType.Pet, raceId)

		if co then
			local awakenLv = co.initAwakenLv
			local creepCo = {
				talentLv = 0,
				raceId = raceId,
				lv = lvl,
				awakenLv = awakenLv
			}
			local mo = FightingPowerPetMo.New()

			mo:fromChallengeCreepCo(creepCo)

			local petMo = {
				raceId = raceId,
				level = lvl,
				name = co.name,
				awakenLv = mo.awakenLv
			}

			petMo._curZdl = mo._zdl

			CommonTipsMgr.instance:showPetTips(petMo)
		end
	else
		CommonTipsMgr.instance:openMaterialTips(self._icon, matType, defineId, lv, awakenLv)
	end

	ShopController.instance:reportBehavior(self._info)
end

return ShopGiftItem
