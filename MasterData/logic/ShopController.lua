-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/controller/ShopController.lua

module("logic.extensions.shop.controller.ShopController", package.seeall)

local ShopController = class("ShopController", BaseController)

ShopController.SHOPREFRESHED = "ShopRefreshed"
ShopController.MESSSELECTCHANGE = "MessSelectChange"

function ShopController:onInit()
	ShopController.super.onInit(self)
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
	GlobalDispatcher:addListener(PayShopModel.ChangeMibaoShopBuyTimes, self._buyItemSucRes, self)
end

function ShopController:_reloadData()
	self:resetInited()
end

function ShopController:onReset()
	self:_reloadData()
	ActivityShopAgent.instance:addHandler(ActivityShopAgent.PM_GetAllShopItemInfoRes, self.ReceivedAllShopItemInfo, self)
	ActivityShopAgent.instance:addHandler(ActivityShopAgent.PM_BuyShopItemRes, self.ReceivedBuyShopItem, self)
end

function ShopController:reportBehavior(cfg)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_SHOP_ITEM, cfg.name)
end

function ShopController:buyGoodByCfgId(cfgId, count, contentEnd)
	local info = PayShopConfig.instance:getPayShopGoodsCfgById(cfgId)

	self:checkBuyGood(info, count, contentEnd)
end

function ShopController:checkBuyGood(info, count, contentEnd)
	contentEnd = contentEnd or ""

	if info.sellTargetLimit ~= "none" then
		local times = PayShopModel.instance:getMibaoBuyTimesById(info.id)

		if times >= info.limitTimes then
			FloatWordMgr.instance:show("已售罄")

			return
		end

		if times + count > info.limitTimes then
			FloatWordMgr.instance:show(string.format("物品最多能购买%s个", info.limitTimes - times))

			return
		end
	end

	local isDiscountTime = PayShopModel.instance:checkCanDisCount(info.id)
	local currPayGoodsId = info.originalGoodsId
	local disCountPlanId = -1

	if isDiscountTime then
		currPayGoodsId, disCountPlanId = PayShopModel.instance:getBuyItemMinCostPayGoodsId(info.id)
	end

	local function onSureBuyFunc()
		PayShopController.instance:buyShopItem(info.id, count, disCountPlanId)
	end

	if not ((string.nilorempty(currPayGoodsId) or nil) and true) and info.payType == GameEnum.PayShopPayType.RMB then
		onSureBuyFunc()
	else
		local currList = string.split(currPayGoodsId, ":")
		local matType = checknumber(currList[1])

		if not matType or matType <= 0 then
			return
		end

		local matType, matId, matNum = checknumber(currList[1]), checknumber(currList[2]), checknumber(currList[3])
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local cost = MaterialFacade:getGoodCost(matType, matId, matNum)
		local content = langPara("确定要花费%s%s,购买%s个%s吗？%s", cost * count, matName, count, info.name, contentEnd)

		if matType == MatType.Diamond then
			TipsFacade.instance:openPopupCostDiamondView(cost * count, content, onSureBuyFunc)
		elseif matType == MatType.Coin then
			TipsFacade.instance:openPopupCostCoinView(cost * count, content, onSureBuyFunc)
		else
			TipsFacade.instance:openPopupWindow("提示", content, onSureBuyFunc)
		end
	end
end

function ShopController:resetInited()
	ShopModel.instance.isCountInited = false
end

function ShopController:getGoodLeftCount()
	PayShopController.instance:sendGetAllPayShopBuyTimesReq()
end

function ShopController:setMoneyType(spr, type, payGoodsId)
	return
end

function ShopController:_buyItemSucRes(id, times)
	ShopModel.instance:onBuyGood(id, times)
end

ShopController.instance = ShopController.New()

return ShopController
