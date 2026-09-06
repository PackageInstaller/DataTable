-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/controller/PayShopController.lua

module("logic.extensions.payshop.controller.PayShopController", package.seeall)

local PayShopController = class("PayShopController", BaseController)
local json = require("cjson")

PayShopController.GetAllPayShopBuyTimesRes = "PayShopController.GetAllPayShopBuyTimesRes"
PayShopController.GetConsumeGiftInfoRes = "PayShopController.GetConsumeGiftInfoRes"
PayShopController.GainConsumeGiftRes = "PayShopController.GainConsumeGiftRes"
PayShopController.GetAccConsumeGiftInfoRes = "PayShopController.GetAccConsumeGiftInfoRes"
PayShopController.GainAccConsumeGiftRes = "PayShopController.GainAccConsumeGiftRes"
PayShopController.GetLevelTimeMachineInfoRes = "PayShopController.GetLevelTimeMachineInfoRes"
PayShopController.FreeUseLevelTimeMachineRes = "PayShopController.FreeUseLevelTimeMachineRes"
PayShopController.BuyItemRes = "PayShopController.BuyItemRes"
PayShopController.NotifyPayShopItemBuySucRes = "PayShopController.NotifyPayShopItemBuySucRes"
PayShopController.NotifyLevelTimeMachineUseSucRes = "PayShopController.NotifyLevelTimeMachineUseSucRes"
PayShopController.GetDiscountGiftInfoRes = "PayShopController.GetDiscountGiftInfoRes"
PayShopController.GainDiscountGiftRes = "PayShopController.GainDiscountGiftRes"
PayShopController.OneKeyGainDiscountGiftRes = "PayShopController.OneKeyGainDiscountGiftRes"

function PayShopController:ctor()
	return
end

function PayShopController:onInit()
	GlobalDispatcher:addListener(PayShopAgent.GetAllPayShopBuyTimesRes, self._GetAllPayShopBuyTimesRes, self)
	GlobalDispatcher:addListener(PayShopAgent.GetConsumeGiftInfoRes, self._GetConsumeGiftInfoRes, self)
	GlobalDispatcher:addListener(PayShopAgent.GainConsumeGiftRes, self._GainConsumeGiftRes, self)
	GlobalDispatcher:addListener(PayShopAgent.GetAccConsumeGiftInfoRes, self._GetAccConsumeGiftInfoRes, self)
	GlobalDispatcher:addListener(PayShopAgent.GainAccConsumeGiftRes, self._GainAccConsumeGiftRes, self)
	GlobalDispatcher:addListener(PayShopAgent.GetLevelTimeMachineInfoRes, self._GetLevelTimeMachineInfoRes, self)
	GlobalDispatcher:addListener(PayShopAgent.BuyItemRes, self._BuyItemRes, self)
	GlobalDispatcher:addListener(PayShopAgent.NotifyPayShopItemBuySucRes, self._NotifyPayShopItemBuySucRes, self)
	GlobalDispatcher:addListener(PayShopAgent.NotifyLevelTimeMachineUseSucRes, self._NotifyLevelTimeMachineUseSucRes, self)
	GlobalDispatcher:addListener(PayShopAgent.UseLevelTimeMachineRes, self.onUseLevelTimeMachineRes, self)
	GlobalDispatcher:addListener(PayShopAgent.GetDiscountGiftInfoRes, self._GetDiscountGiftInfoRes, self)
	GlobalDispatcher:addListener(PayShopAgent.GainDiscountGiftRes, self._GainDiscountGiftRes, self)
	GlobalDispatcher:addListener(PayShopAgent.OneKeyGainDiscountGiftRes, self._OneKeyGainDiscountGiftRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ForceClosePayShopMainView, self._forceCloseMainView, self)
	self:onReset()
end

function PayShopController:onReset()
	self.machindPool = {}
	self._isInitGiftTimes = false
end

function PayShopController:openView(jumpInTag, extParams, jumpGoodsId)
	if SceneMgr.instance.isGogingToEnterBattleScene then
		FloatWordMgr.instance:show("正在战斗中，暂时无法打开商城")

		return
	end

	if FuncOpenModel.instance:getFuncIsOpen(95) then
		UIStateManager.instance:push(ViewName.PayShopMainView, jumpInTag, extParams, jumpGoodsId)
	end
end

function PayShopController:openExchangeView(id)
	id = checknumber(id)

	printError("还有人在用这个接口，发现请改用470")

	if id == GameEnum.ExchangeTab.Family then
		if FamilyController.instance:getFamilyLv() <= 0 then
			FloatWordMgr.instance:show("请加入一个家族")

			return
		end

		self:openView(GameEnum.PayShopEasyJump.ExchangeFamily)
	elseif id == GameEnum.ExchangeTab.Arena then
		self:openView(GameEnum.PayShopEasyJump.ExchangeArena)
	elseif id == GameEnum.ExchangeTab.Expedition then
		self:openView(GameEnum.PayShopEasyJump.ExchangeExpedition)
	elseif id == GameEnum.ExchangeTab._3v3 then
		self:openView(GameEnum.PayShopEasyJump.Exchange3v3)
	elseif id == GameEnum.ExchangeTab.WorldBoss then
		self:openView(GameEnum.PayShopEasyJump.ExchangeWorldBoss)
	elseif id == GameEnum.ExchangeTab.TutorSystem then
		self:openView(GameEnum.PayShopEasyJump.ExchangeTutorSystem)
	elseif id == GameEnum.ExchangeTab.Thankscoin then
		self:openView(GameEnum.PayShopEasyJump.Thankscoin)
	elseif id == GameEnum.ExchangeTab.CutePet then
		self:openView(GameEnum.PayShopEasyJump.ExchangeCutePet)
	elseif id == GameEnum.ExchangeTab.KingArena then
		self:openView(GameEnum.PayShopEasyJump.ExchangeKingArena)
	else
		self:openView(GameEnum.PayShopEasyJump.Exchange)
	end
end

function PayShopController:sendGetAllPayShopBuyTimesReq()
	PayShopAgent.instance:sendGetAllPayShopBuyTimesReq()
end

function PayShopController:buyShopItemWithTips(goodsId)
	goodsId = checknumber(goodsId)

	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(goodsId)

	if isCanBuy then
		local data = PayShopModel.instance:getBuyData(goodsId)

		if data then
			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data, true)
		else
			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, {
				totalBuyTimes = 0,
				times = 0,
				id = goodsId
			})
		end
	else
		FloatWordMgr.instance:show(lang("text_recall_desc_6"))
	end
end

function PayShopController:buyShopItem(id, buyTimes, discountPlanId, deduceItemCount)
	buyTimes = buyTimes or 1
	discountPlanId = discountPlanId or -1

	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(id)

	if not goodsCfg then
		printError("payshop Id:", id, "没有配置")

		return
	end

	local currPayGoodsId = goodsCfg.originalGoodsId
	local isFreeGoods = string.nilorempty(currPayGoodsId)

	if goodsCfg.sellTargetLimit ~= "none" and goodsCfg.limitTimes > 0 then
		local times = PayShopModel.instance:getMibaoBuyTimesById(id)

		if times >= goodsCfg.limitTimes then
			FloatWordMgr.instance:show("已售罄")

			return
		end

		if times + buyTimes > goodsCfg.limitTimes then
			FloatWordMgr.instance:show(string.format("物品最多能购买%s个", goodsCfg.limitTimes - times))

			return
		end
	end

	if not self:checkTimeStr(goodsCfg.sellTime) then
		FloatWordMgr.instance:show("不在可购买时间内")

		return
	end

	if not FuncOpenController.instance:getConditionReached(goodsCfg.openCondition) then
		FloatWordMgr.instance:show("未满足开放条件")

		return
	end

	if not isFreeGoods and goodsCfg.payType == GameEnum.PayShopPayType.RMB then
		self:_rmbBuy(goodsCfg.id, discountPlanId)
	else
		self:_gameGoodsBuy(isFreeGoods, goodsCfg, buyTimes, discountPlanId, deduceItemCount)
	end
end

function PayShopController:_rmbBuy(goodsId, discountPlanId)
	PayShopModel.instance:recordDiscountId(nil)

	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)
	local cfg = PayConfig.instance:getPayGoodsCfg(goodsCfg.originalGoodsId)
	local currPayGoodsId = goodsCfg.originalGoodsId

	if cfg then
		local params = {
			disId = discountPlanId
		}
		local extParams = json.encode(params)

		currPayGoodsId = self:_getDiscountPayGoodsId(goodsId, discountPlanId)

		if discountPlanId > 0 then
			PayShopModel.instance:recordDiscountId(goodsId)
		end

		PayController.instance:pay(currPayGoodsId, GameEnum.PaySubGoodsType.PAY_SHOP, goodsId, extParams)
	else
		printError("t_pay_goods 无 id: ", currPayGoodsId)
	end
end

function PayShopController:_gameGoodsBuy(isFreeGoods, goodsCfg, buyTimes, discountPlanId, deduceItemCount)
	if isFreeGoods then
		if goodsCfg.limitType == "daily" then
			SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_MIBAO_RILIBAO)
		elseif goodsCfg.limitType == "weekly" then
			SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_MIBAO_ZHOULIBAO)
		elseif goodsCfg.limitType == "monthly" then
			SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_MIBAO_YUELIBAO)
		end
	end

	PayShopModel.instance:recordDiscountId(nil)

	local currPayGoodsId = self:_getDiscountPayGoodsId(goodsCfg.id, discountPlanId)

	if discountPlanId and discountPlanId > 0 then
		PayShopModel.instance:recordDiscountId(goodsCfg.id)
	end

	self:_sureBuyGameGoods(goodsCfg.id, buyTimes, discountPlanId, deduceItemCount)
end

function PayShopController:_getDiscountPayGoodsId(goodsId, discountPlanId)
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)
	local payGoodsId = goodsCfg.originalGoodsId

	if discountPlanId and discountPlanId > 0 then
		local disCfg = PayShopConfig.instance:getDiscountPlanCfg(discountPlanId)

		if disCfg then
			payGoodsId = disCfg.discountPrice
		end
	end

	return payGoodsId
end

function PayShopController:_sureBuyGameGoods(shopItemId, buyTimes, discountPlanId, deduceItemCount)
	PayShopAgent.instance:sendBuyItemReq(shopItemId, buyTimes, discountPlanId, deduceItemCount)
end

function PayShopController:sendGainConsumeGiftReq(id, handler)
	PayShopAgent.instance:sendGainConsumeGiftReq(id, handler)
end

function PayShopController:sendGetAccConsumeGiftInfoReq(handler)
	PayShopAgent.instance:sendGetAccConsumeGiftInfoReq(handler)
end

function PayShopController:sendGetEmoticonGroupInfoReq()
	ChatAgent.instance:sendPM_GetEmoticonGroupInfoReq()
end

function PayShopController:sendPigraiseStateReq()
	AnimalsAgent.instance:sendPM_AnimalsGetStateReq(function(msg)
		PigraiseModel.instance:updateAfterGetState(msg)
	end)
end

function PayShopController:sendGainAccConsumeGiftReq(id, handler)
	PayShopAgent.instance:sendGainAccConsumeGiftReq(id, function(msg)
		GameUtil.callBack(handler)
		GlobalDispatcher:dispatch(GlobalNotify.UpdatePayShopRedDot)
	end)
end

function PayShopController:gainWeeklyPrize(annuityId, handler)
	YearCardController.instance:gainWeeklyPrize(annuityId, handler)
end

function PayShopController:gainFixedPrize(annuityId, handler)
	YearCardController.instance:gainFixedPrize(annuityId, handler)
end

function PayShopController:getUserAnnuityInfo(callback)
	YearCardController.instance:getUserAnnuityInfo(callback)
end

function PayShopController:getIfBuyAnnuity(callback)
	YearCardController.instance:getIfBuyAnnuity(callback)
end

function PayShopController:activateAnnuity(activityId, callback)
	YearCardController.instance:activateAnnuity(activityId, callback)
end

function PayShopController:freeLvlup(activityId, id, petId, callback)
	PayShopAgent.instance:sendFreeUseLevelTimeMachineReq(activityId, id, petId, function(msg)
		local obj = self.machindPool[id]

		if obj then
			obj.usedTimes = msg.usedTimes
			self.machindPool[id] = obj
		else
			self.machindPool[id] = {
				id = id,
				usedTimes = msg.usedTimes
			}
		end

		GlobalDispatcher:dispatch(PayShopController.NotifyLevelTimeMachineUseSucRes, petId)
	end)
end

function PayShopController:sendUseLevelTimeMachineReq(id, petId, subIndex, callBack)
	self.timeMachineLvlCallBack = callBack

	PayShopAgent.instance:sendUseLevelTimeMachineReq(id, petId, subIndex, function(msg)
		local obj = self.machindPool[id]

		if obj then
			obj.usedTimes = msg.usedTimes
			self.machindPool[id] = obj
		else
			self.machindPool[id] = {
				id = id,
				usedTimes = msg.usedTimes
			}
		end

		local ci = msg.changeSetId

		ItemGetController.instance:setTitleType(ci, ItemGetController.TITLE_RETURNMAT)

		local tem = self.timeMachineLvlCallBack

		self.timeMachineLvlCallBack = nil

		GameUtil.callBack(tem, msg)
		GlobalDispatcher:dispatch(PayShopController.NotifyLevelTimeMachineUseSucRes, petId)
	end)
end

function PayShopController:rmTimeMachineLvlCallBack()
	self.timeMachineLvlCallBack = nil
end

function PayShopController:onUseLevelTimeMachineRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function PayShopController:getLevelTimeMachineInfo(callback)
	self.timeMachineInfoFunc = callback

	PayShopAgent.instance:sendGetLevelTimeMachineInfoReq()
end

function PayShopController:clearTimeMachineInfoFunc()
	self.timeMachineInfoFunc = nil
end

function PayShopController:getBuyTimeById(id)
	if self.machindPool[id] then
		return self.machindPool[id].usedTimes
	end

	return 0
end

function PayShopController:onGetLvlTimeMachineInfo(msg)
	return
end

function PayShopController:onNotifyLevelTimeMachineUseSucRes(msg)
	return
end

function PayShopController:_GetAllPayShopBuyTimesRes(status, msg)
	if status == 0 then
		PayShopModel.instance:setMibaoBuyTimes(msg.buyTimes)
		ShopModel.instance:initAllGoods(msg.buyTimes)
		GlobalDispatcher:dispatch(PayShopModel.GetAllPayShopBuyTimesRes)
		GlobalDispatcher:dispatch(PayShopController.GetAllPayShopBuyTimesRes, msg)
		GlobalDispatcher:dispatch(GlobalNotify.UpdatePayShopRedDot)

		self._isInitGiftTimes = true
	end
end

function PayShopController:_GetConsumeGiftInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PayShopController.GetConsumeGiftInfoRes)
	end
end

function PayShopController:_GainConsumeGiftRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PayShopController.GainConsumeGiftRes)
	end
end

function PayShopController:_GetAccConsumeGiftInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PayShopController.GetAccConsumeGiftInfoRes)
	end
end

function PayShopController:_GainAccConsumeGiftRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PayShopController.GainAccConsumeGiftRes)
	end
end

function PayShopController:_GetLevelTimeMachineInfoRes(status, msg)
	if status == 0 then
		local list = msg.machineTimes

		for i, obj in ipairs(list) do
			self.machindPool[obj.id] = {
				id = obj.id,
				usedTimes = obj.usedTimes
			}
		end

		GameUtil.callBack(self.timeMachineInfoFunc)
		GlobalDispatcher:dispatch(PayShopController.GetLevelTimeMachineInfoRes)
	end
end

function PayShopController:_handlePM_GetEmoticonGroupInfoRes()
	return
end

function PayShopController:_FreeUseLevelTimeMachineRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PayShopController.FreeUseLevelTimeMachineRes)
	end
end

function PayShopController:_BuyItemRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PayShopController.BuyItemRes)
	end
end

function PayShopController:_NotifyPayShopItemBuySucRes(status, msg)
	if status == 0 then
		local changesetid = msg.changeSetId
		local titleType = ItemGetController.TITLE_BUY_SUC

		for i, v in ipairs(msg.buyTimes) do
			if v.id == 96003 then
				titleType = ItemGetController.TITLE_PRIZE

				break
			end
		end

		ItemGetController.instance:setTitleType(changesetid, titleType)
		PayShopModel.instance:changeBuyTimes(msg.buyTimes)
		ActivityPopupController.instance:onBuyCheckLuoshiqi()
		GlobalDispatcher:dispatch(PayShopController.NotifyPayShopItemBuySucRes, msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.NotifyPayShopItemBuySucRes, status, msg)
end

function PayShopController:_NotifyLevelTimeMachineUseSucRes(status, msg)
	if status == 0 then
		local obj = self.machindPool[msg.id]

		if obj then
			obj.usedTimes = msg.usedTimes
			self.machindPool[msg.id] = obj
		else
			self.machindPool[msg.id] = {
				id = msg.id,
				usedTimes = msg.usedTimes
			}
		end

		print(">>>>>>>>>>>>>>>>>>> onNotifyLevelTimeMachineUseSucRes", msg.id, msg.usedTimes, msg.petId)
		GlobalDispatcher:dispatch(PayShopController.NotifyLevelTimeMachineUseSucRes, msg.petId)
	end
end

function PayShopController:getIsInitGiftTimes()
	return self._isInitGiftTimes
end

function PayShopController:checkTimeStr(str)
	return GameUtil.checkTimeStr(str)
end

function PayShopController:_GetDiscountGiftInfoRes(status, msg)
	if status == 0 then
		PayShopModel.instance:setDiscountGiftInfo(msg.giftGainState)
	end

	GlobalDispatcher:dispatch(PayShopController.GetDiscountGiftInfoRes, status, msg)
end

function PayShopController:_GainDiscountGiftRes(status, msg)
	if status == 0 then
		PayShopModel.instance:gainDiscountGiftRes(msg.giftId)
	end

	GlobalDispatcher:dispatch(PayShopController.GainDiscountGiftRes, status, msg)
end

function PayShopController:_OneKeyGainDiscountGiftRes(status, msg)
	if status == 0 then
		PayShopModel.instance:gainAllDiscountGiftRes()
	end

	GlobalDispatcher:dispatch(PayShopController.OneKeyGainDiscountGiftRes, status, msg)
end

function PayShopController:openShopByJumpPageConfig(cfgId)
	local cfg = PayShopConfig.instance:getJumpPageCfg(cfgId)

	if cfg and not string.nilorempty(cfg.jumpTo) then
		local jumpTo = cfg.jumpTo

		if string.find(jumpTo, "mibao") and cfg.tabTypes then
			jumpTo = jumpTo .. "#" .. json.encode(cfg.tabTypes)
		end

		GotoMgr.gotoByString(jumpTo)
	else
		FloatWordMgr.instance:show("暂无跳转界面")
	end
end

function PayShopController:_forceCloseMainView()
	PayShopModel.instance:setRecordTag(false)
	PayShopModel.instance:recordJumpPageParam(false)
	UIStateManager.instance:popByName(ViewName.PayShopMainView)
end

function PayShopController:getBestFreeDiscountPlanIdByGoodsDefineId(defineId)
	local discountBaseCheck = self:_discountPlanBaseCheck(defineId)

	if not discountBaseCheck then
		return 0
	end

	local bestId = 0
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(defineId)
	local dcfgs = {}

	for i, v in ipairs(goodsCfg.discountPlans) do
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(v)

		if string.nilorempty(dcfg.discountCost) and self:checkDiscountPlanConditionPass(v) then
			table.insert(dcfgs, dcfg)
		end
	end

	if #dcfgs > 0 then
		local dcfg = dcfgs[1]
		local payType = dcfg.payType
		local payGoodsId = ""
		local minCostNum = -1
		local costNum = 0

		for i, v in ipairs(dcfgs) do
			if payType == GameEnum.PayShopPayType.RMB then
				costNum = PayConfig.instance:getPayMoneyYuan(v.discountPrice)
			elseif payType == GameEnum.PayShopPayType.GAMEGOODS then
				local list = string.split(payGoodsId, ":")

				costNum = checknumber(list[#list])
			end

			if minCostNum <= 0 then
				minCostNum = costNum
				bestId = v.id
			elseif costNum < minCostNum then
				minCostNum = costNum
				bestId = v.id
			end
		end
	end

	return bestId
end

function PayShopController:getBestDiscountPlanId(defineId, planCfgs)
	local discountBaseCheck = self:_discountPlanBaseCheck(defineId)

	if not discountBaseCheck then
		return 0
	end

	local bestId = 0
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(defineId)
	local dcfgs = planCfgs

	if #dcfgs > 0 then
		local dcfg = dcfgs[1]
		local payType = dcfg.payType
		local payGoodsId = ""
		local minCostNum = -1
		local costNum = 0

		for i, v in ipairs(dcfgs) do
			if payType == GameEnum.PayShopPayType.RMB then
				costNum = PayConfig.instance:getPayMoneyYuan(v.discountPrice)
			elseif payType == GameEnum.PayShopPayType.GAMEGOODS then
				local list = string.split(payGoodsId, ":")

				costNum = checknumber(list[#list])
			end

			if minCostNum <= 0 then
				minCostNum = costNum
				bestId = v.id
			elseif costNum < minCostNum then
				minCostNum = costNum
				bestId = v.id
			end
		end
	end

	return bestId
end

function PayShopController:getUseDiscountTimes(shopItemId)
	return PayShopModel.instance:getUseDiscountTimes(shopItemId)
end

function PayShopController:checkDiscountPlanConditionPass(planId)
	local pcfg = PayShopConfig.instance:getDiscountPlanCfg(planId)

	if not pcfg then
		return false
	end

	local isInTime = string.nilorempty(pcfg.discountTime) or GameUtil.checkTimeStr(pcfg.discountTime)

	if isInTime then
		if string.nilorempty(pcfg.discountCost) then
			return true
		else
			local arr = string.split(pcfg.discountCost, "#")

			for i, str in ipairs(arr) do
				local isEnough = MaterialFacade.instance:isMatsEnough(str)

				if not isEnough then
					return false
				end
			end

			return true
		end
	end

	return false
end

function PayShopController:getDiscountActiveGroup(shopItemId)
	local plans = {}
	local scfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopItemId)

	if scfg and scfg.discountPlans then
		for i, planId in ipairs(scfg.discountPlans) do
			if self:checkDiscountPlanConditionPass(planId) then
				local pcfg = PayShopConfig.instance:getDiscountPlanCfg(planId)

				if not string.nilorempty(pcfg.discountCost) then
					table.insert(plans, pcfg)
				end
			end
		end
	end

	return plans
end

function PayShopController:_discountPlanBaseCheck(defineId)
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(defineId)

	if not goodsCfg then
		return false
	end

	if not goodsCfg.discountPlans then
		return false
	end

	local useTime = self:getUseDiscountTimes(goodsCfg.id)

	if goodsCfg.discountLimitTimes > 0 and useTime >= goodsCfg.discountLimitTimes then
		return false
	end

	return true
end

PayShopController.instance = PayShopController.New()

return PayShopController
