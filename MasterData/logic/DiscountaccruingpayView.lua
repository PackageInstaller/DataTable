-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/discountaccruingpay/view/DiscountaccruingpayView.lua

module("logic.extensions.discountaccruingpay.view.DiscountaccruingpayView", package.seeall)

local DiscountaccruingpayView = class("DiscountaccruingpayView", ViewComponent)
local space = 261
local Index2Pos = {
	{
		pos = Vector2.New(-space, 0),
		scale = Vector3.New(1, 1, 1)
	},
	{
		pos = Vector2.New(0, 0),
		scale = Vector3.New(1, 1, 1)
	},
	{
		pos = Vector2.New(space, 0),
		scale = Vector3.New(1, 1, 1)
	}
}

function DiscountaccruingpayView:ctor()
	DiscountaccruingpayView.super.ctor(self)
end

function DiscountaccruingpayView:buildUI()
	DiscountaccruingpayView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnRight = self:getBtn("btnRight")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnBuy1 = self:getBtn("btnBuy1")
	self._btnClose = self:getBtn("btnClose")
	self._txtCost1 = goutil.findChildTextComponent(self.mainGO, "btnBuy1/text")
	self._txtCost2 = goutil.findChildTextComponent(self.mainGO, "btnBuy2/text")
	self._txtCost3 = goutil.findChildTextComponent(self.mainGO, "btnBuy3/text")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._itemconGo = self:getGo("extra/itemcon")
	self._cellGo = self:getGo("extra/itemcon/cell")
	self._extraItemGroup = ItemGroup.New(self._itemconGo, self._cellGo, nil, nil, true)
	self._txtUnlockProgress = goutil.findChildTextComponent(self.mainGO, "extra/txtUnlockProgress")
	self._roleConGo = self:getGo("roleCon")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "LeftTime/txtLeftTime")
	self._btnMask3Go = self:getGo("btnMask3")
	self._btnMask2Go = self:getGo("btnMask2")
	self._btnMask1Go = self:getGo("btnMask1")
	self._btnBuy2 = self:getBtn("btnBuy2")
	self._btnBuy3 = self:getBtn("btnBuy3")

	self:_buildItems()
end

function DiscountaccruingpayView:_buildItems()
	self._itemList = {}

	for i = 1, 3 do
		local go = self:getGo("itemcon/item" .. i)
		local root = goutil.findChild(go, "root")
		local imgGo = goutil.findChild(root, "img")
		local cellcon = goutil.findChild(root, "cellcon")
		local cell = goutil.findChild(cellcon, "cell")
		local itemGroup = ItemGroup.New(cellcon, cell, nil, nil, true)
		local btn = GameUtil.asBtn(go)
		local selectGo = goutil.findChild(go, "select")
		local hasBuyGo = goutil.findChild(go, "hasBuyGo")
		local bgChange = imgGo:GetComponent(ComponentType.UIImageSpriteChange)
		local item = {
			tweenPos = go:GetComponent(UnityTweensType.TweenPosition),
			tweenScale = imgGo:GetComponent(UnityTweensType.TweenScale),
			transform = go.transform,
			imgTr = imgGo.transform,
			itemGroup = itemGroup,
			root = root,
			selectGo = selectGo,
			txtName = goutil.findChildTextComponent(root, "txtName"),
			bigItem = goutil.findChild(root, "bigItem"),
			bgChange = bgChange,
			hasBuyGo = hasBuyGo
		}

		btn:AddClickListener(function()
			self:_moveItem(i, true, true)
		end)

		self._itemList[i] = item
	end
end

function DiscountaccruingpayView:bindEvents()
	DiscountaccruingpayView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnBuy1:AddClickListener(self._onClickbtnBuy1, self)
	self._btnBuy2:AddClickListener(self._onClickbtnBuy2, self)
	self._btnBuy3:AddClickListener(self._onClickbtnBuy3, self)
end

function DiscountaccruingpayView:unbindEvents()
	DiscountaccruingpayView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnBuy1:RemoveClickListener()
	self._btnBuy2:RemoveClickListener()
	self._btnBuy3:RemoveClickListener()
end

function DiscountaccruingpayView:destroyUI()
	DiscountaccruingpayView.super.destroyUI(self)
end

function DiscountaccruingpayView:onEnter()
	DiscountaccruingpayView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._currIndex = nil
	self._maxIndex = 3
	self._isItemMoving = false
	self._effectHandlers = {}
	self._leftTime = 0

	GlobalDispatcher:addListener(DiscountaccruingpayController.GetPayInfoRes, self._GetPayInfoRes, self)
	GlobalDispatcher:addListener(DiscountaccruingpayController.PM_NotifyBuyGiftRes, self._PM_NotifyBuyGiftRes, self)
	GlobalDispatcher:addListener(DiscountaccruingpayController.GainExGiftRes, self._GainExGiftRes, self)
	DiscountAccruingPayAgent.instance:sendGetPayInfoReq(self._activityId)
	self:_updateView()
	self:_setRole()
	self:_setActLeftTime()
end

function DiscountaccruingpayView:onEnterFinished()
	DiscountaccruingpayView.super.onEnterFinished(self)
end

function DiscountaccruingpayView:onExit()
	DiscountaccruingpayView.super.onExit(self)
	GlobalDispatcher:removeListener(DiscountaccruingpayController.GetPayInfoRes, self._GetPayInfoRes, self)
	GlobalDispatcher:removeListener(DiscountaccruingpayController.PM_NotifyBuyGiftRes, self._PM_NotifyBuyGiftRes, self)
	GlobalDispatcher:removeListener(DiscountaccruingpayController.GainExGiftRes, self._GainExGiftRes, self)

	for i, v in ipairs(self._itemList) do
		uGuiUtil.clearImage(v.bigItem)
		v.itemGroup:dispose(function(item)
			MaterialMgr.resetAll(item.mainGO)
		end)
	end

	self._extraItemGroup:dispose(function(item)
		local conGo = goutil.findChild(item.mainGO, "con")

		MaterialMgr.resetAll(conGo)
	end)

	for k, v in pairs(self._effectHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effectHandlers = {}

	RoleObjectPool.instance:removeRole(self._roleObj)
	removetimer(self._updateTimer, self)
end

function DiscountaccruingpayView:onExitFinished()
	DiscountaccruingpayView.super.onExitFinished(self)
end

function DiscountaccruingpayView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("discountaccruingpay")
end

function DiscountaccruingpayView:_onClickbtnRight()
	self:_onClikcMove(false)
end

function DiscountaccruingpayView:_onClickbtnLeft()
	self:_onClikcMove(true)
end

function DiscountaccruingpayView:_onClikcMove(isLeft)
	if self._isItemMoving then
		return
	end

	self._currIndex = self._currIndex + (isLeft and -1 or 1)

	if self._currIndex < 1 then
		self._currIndex = self._currIndex + self._maxIndex
	end

	if self._currIndex > self._maxIndex then
		self._currIndex = self._currIndex - self._maxIndex
	end

	self:_moveItem(self._currIndex, false, isLeft)
end

function DiscountaccruingpayView:_onClickbtnBuy1()
	self:_buyGift(1)
end

function DiscountaccruingpayView:_onClickbtnBuy2()
	self:_buyGift(2)
end

function DiscountaccruingpayView:_onClickbtnBuy3()
	self:_buyGift(3)
end

function DiscountaccruingpayView:_onClickbtnClose()
	self:close()
end

function DiscountaccruingpayView:_buyGift(index)
	if self._leftTime <= 0 then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	if not self._nextPayCfg then
		FloatWordMgr.instance:show("全部礼包已购买")

		return
	end

	local buySumTimes = 0

	for k, v in pairs(self._dataList) do
		buySumTimes = checknumber(v.buyTimes) + buySumTimes
	end

	if index <= buySumTimes then
		FloatWordMgr.instance:show("您所点击的价格暂时不可使用")

		return
	end

	if self._hasBuyTimes < index - 1 then
		FloatWordMgr.instance:show("您所点击的价格暂时不可使用")

		return
	end

	local cfg = self._planCfgs[self._currIndex]
	local data = self._dataList[self._currIndex]

	if cfg then
		if data and data.buyTimes >= cfg.times then
			FloatWordMgr.instance:show("您所点击的价格暂时不可使用")

			return
		end

		if self._nextPayCfg then
			local jsonStr = "{\"actId\":" .. self._activityId .. "}"

			PayController.instance:pay(self._nextPayCfg.payGoodsId, GameEnum.PaySubGoodsType.DISCOUNT_ACCRUYING_PAY, cfg.giftId, jsonStr)
		end
	end
end

function DiscountaccruingpayView:_moveItem(midIndex, notMove, isLeft)
	self._currIndex = midIndex
	self._isItemMoving = true

	local firstIndex = midIndex - 1
	local midIndex = midIndex
	local lastIndex = midIndex + 1

	if firstIndex < 1 then
		firstIndex = firstIndex + self._maxIndex
	end

	if lastIndex > self._maxIndex then
		lastIndex = lastIndex - self._maxIndex
	end

	local fitem = self._itemList[1]
	local mitem = self._itemList[2]
	local litem = self._itemList[3]
	local currItem = self._itemList[midIndex]
	local fpos = Index2Pos[1].pos
	local mpos = Index2Pos[2].pos
	local lpos = Index2Pos[3].pos
	local fscal = Index2Pos[1].scale
	local mscal = Index2Pos[2].scale
	local lscal = Index2Pos[3].scale

	goutil.setActive(mitem.selectGo, false)
	goutil.setActive(fitem.selectGo, false)
	goutil.setActive(litem.selectGo, false)
	goutil.setActive(currItem.selectGo, true)

	if notMove then
		Framework.TransformUtil.SetLocalPos(fitem.transform, fpos.x, fpos.y, 0)
		Framework.TransformUtil.SetLocalPos(mitem.transform, mpos.x, mpos.y, 0)
		Framework.TransformUtil.SetLocalPos(litem.transform, lpos.x, lpos.y, 0)
		Framework.TransformUtil.SetLocalScale(fitem.imgTr, fscal.x, fscal.y, 1)
		Framework.TransformUtil.SetLocalScale(mitem.imgTr, mscal.x, mscal.y, 1)
		Framework.TransformUtil.SetLocalScale(litem.imgTr, lscal.x, lscal.y, 1)

		self._isItemMoving = false
	else
		if isLeft then
			fitem.transform:SetAsFirstSibling()
		else
			litem.transform:SetAsFirstSibling()
		end

		fitem.tweenPos:AddListener(self._tweenFinish, self)
		self:_setItemMoveParam(fitem, fpos, fscal)
		self:_setItemMoveParam(mitem, mpos, mscal)
		self:_setItemMoveParam(litem, lpos, lscal)
	end

	mitem.bgChange:SetState(0)
	fitem.bgChange:SetState(0)
	litem.bgChange:SetState(0)
	currItem.bgChange:SetState(1)
end

function DiscountaccruingpayView:_updateView()
	local cfg = DiscountaccruingpayConfig.instance:getActCfg(self._activityId)
	local payPlanCfgs = DiscountaccruingpayConfig.instance:getPayPlanCfgs(cfg.payPlanId)

	self._planCfgs = DiscountaccruingpayConfig.instance:getPlanCfgs(cfg.giftPlanId)
	self._maxPlanCfgLen = #self._planCfgs
	self._maxIndex = self._maxPlanCfgLen
	self._dataList = DiscountaccruingpayModel.instance:getPayInfos()

	table.sort(self._dataList, function(a, b)
		return a.giftId < b.giftId
	end)

	self._hasBuyTimes = 0

	for i, v in ipairs(self._dataList) do
		self._hasBuyTimes = self._hasBuyTimes + v.buyTimes
	end

	self:_setBtnMaskActive()

	self._nextPayCfg = payPlanCfgs[self._hasBuyTimes + 1]

	local descStr = ""

	for i, v in ipairs(payPlanCfgs) do
		local yuan = PayConfig.instance:getPayMoneyYuan(v.payGoodsId)

		self["_txtCost" .. i].text = string.format("¥ %s", yuan)
		descStr = i == 1 and descStr .. string.format("首次购买选中礼包<color=#FFC572FF>%s元</color>", PayConfig.instance:getPayMoneyYuan(v.payGoodsId)) or descStr .. string.format("第%s次购买<color=#FFC572FF>%s元</color>", GameUtil.getChineseNumber(i), PayConfig.instance:getPayMoneyYuan(v.payGoodsId))

		if i < #payPlanCfgs then
			descStr = descStr .. ","
		end
	end

	self._txtDesc.text = descStr

	local index = -1

	for i, v in ipairs(self._planCfgs) do
		if not self._dataList[v.giftId] or self._dataList[v.giftId].buyTimes <= 0 then
			index = i

			break
		end
	end

	self._currIndex = index > 0 and index or self._currIndex or 1
	self._txtUnlockProgress.text = string.format("解锁进度：%s/%s", self._hasBuyTimes, self._maxPlanCfgLen)

	self:_setItemContent()
	self:_moveItem(self._currIndex, true)
	self:_setExtraItemContent(cfg.exgift)
end

function DiscountaccruingpayView:_setBtnMaskActive()
	local show1 = self._hasBuyTimes ~= 0
	local show2 = self._hasBuyTimes ~= 1
	local show3 = self._hasBuyTimes ~= 2

	goutil.setActive(self._btnMask1Go, false)
	goutil.setActive(self._btnMask2Go, false)
	goutil.setActive(self._btnMask3Go, false)
	GameUtil.SetGray(self._btnBuy1.gameObject, show1)
	GameUtil.SetGray(self._btnBuy2.gameObject, show2)
	GameUtil.SetGray(self._btnBuy3.gameObject, show3)
end

function DiscountaccruingpayView:_setItemContent()
	for i, v in ipairs(self._planCfgs) do
		local itemTab = self._itemList[v.giftId]
		local data = self._dataList[v.giftId]
		local list = string.split(v.prize, "#")

		itemTab.txtName.text = v.name

		uGuiUtil.setSpriteToImage(itemTab.bigItem, nil, GameUrl.getItemIconUrl(v.icon))
		itemTab.itemGroup:updateWithMoArray(list, function(item, cfgStr)
			MaterialMgr.setCellByCfg(cfgStr, item.mainGO)
		end)
		goutil.setActive(itemTab.hasBuyGo, data and data.buyTimes > 0)
	end
end

function DiscountaccruingpayView:_tweenFinish()
	self._isItemMoving = false
end

function DiscountaccruingpayView:_setItemMoveParam(item, posV2, scaleV3)
	local time = 0.2

	item.tweenPos.from = item.transform.localPosition
	item.tweenPos.to = posV2
	item.tweenPos.time = time
	item.tweenScale.from = item.imgTr.localScale
	item.tweenScale.to = scaleV3
	item.tweenScale.time = time

	item.tweenPos:Begin()
	item.tweenScale:Begin()
end

function DiscountaccruingpayView:_GetPayInfoRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function DiscountaccruingpayView:_PM_NotifyBuyGiftRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function DiscountaccruingpayView:_GainExGiftRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function DiscountaccruingpayView:_setExtraItemContent(cfgStr)
	local list = string.split(cfgStr, "#")

	self._extraItemGroup:updateWithMoArray(list, function(item, data)
		local lockGo = goutil.findChild(item.mainGO, "lock")
		local effectGo = goutil.findChild(item.mainGO, "effect")
		local conGo = goutil.findChild(item.mainGO, "con")
		local hasBuyGo = goutil.findChild(item.mainGO, "hasBuyGo")

		MaterialMgr.resetAll(conGo)

		local proxy = MaterialMgr.setCellByCfg(data, conGo)
		local hasget = DiscountaccruingpayModel.instance:hasGetExtraPrize()
		local unlock = self._hasBuyTimes >= self._maxPlanCfgLen
		local showEffect = unlock and not hasget

		goutil.setActive(lockGo, not unlock)
		goutil.setActive(effectGo, showEffect)

		if showEffect then
			local handler = self._effectHandlers[effectGo]

			if not handler then
				handler = UIEffectManager.instance:playEffect(self, "fx_ui_tequan/fx_ui_tequan_kuang.prefab", nil, nil, nil, true)
				self._effectHandlers[effectGo] = handler
			end

			handler:setParent(effectGo.transform)
			handler:setScale(1.4)
			handler:setLocalPos(0, 0, 0)
		end

		proxy.binder:setAutoTips(not showEffect)
		goutil.setActive(hasBuyGo, hasget)

		if showEffect then
			proxy.binder:setCallBack(function()
				DiscountAccruingPayAgent.instance:sendGainExGiftReq(self._activityId)
			end)
		else
			proxy.binder:setCallBack(nil)
		end
	end)
end

function DiscountaccruingpayView:_setRole()
	local cfg = DiscountaccruingpayConfig.instance:getActCfg(self._activityId)
	local raceId, modelConfig = cfg.raceId, cfg.modelConfig
	local x = modelConfig[1]
	local y = modelConfig[2]
	local scale = modelConfig[3]

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, raceId, self._roleConGo, scale, callBack, true, x, y)
end

function DiscountaccruingpayView:_setActLeftTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DiscountaccruingPay, self._activityId)

	self._leftTime = etime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function DiscountaccruingpayView:_updateTimer()
	self._leftTime = self._leftTime - 1

	if self._leftTime > 0 then
		self._txtLeftTime.text = self:_formatLeftTimeStr(self._leftTime)
	else
		self:_actEndOp()
	end
end

function DiscountaccruingpayView:_formatLeftTimeStr(leftTime)
	local d, h, m, s = GameUtil.getTimeDDHHMMSS(leftTime)

	return d > 0 and string.format("时间剩余：%s天%s时%s分", d, h, m) or h > 0 and string.format("时间剩余：%s时%s分%s秒", h, m, s) or string.format("时间剩余：%s分%s秒", m, s)
end

function DiscountaccruingpayView:_actEndOp()
	self._txtLeftTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

return DiscountaccruingpayView
