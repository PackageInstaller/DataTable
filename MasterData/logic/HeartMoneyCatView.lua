-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartmoneycat/view/HeartMoneyCatView.lua

module("logic.extensions.heartmoneycat.view.HeartMoneyCatView", package.seeall)

local HeartMoneyCatView = class("HeartMoneyCatView", ViewComponent)

function HeartMoneyCatView:ctor()
	HeartMoneyCatView.super.ctor(self)
end

function HeartMoneyCatView:unbindEvents()
	HeartMoneyCatView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._moneyBtn:RemoveClickListener()
	self._getBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
end

function HeartMoneyCatView:bindEvents()
	HeartMoneyCatView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._moneyBtn:AddClickListener(self._onClickMoney, self)
	self._getBtn:AddClickListener(self._onClickGet, self)
	self._shopBtn:AddClickListener(self._onClickShop, self)
end

function HeartMoneyCatView:buildUI()
	HeartMoneyCatView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._tipBtn = self:getBtn("topleft/btnTip")
	self._num = {}

	for i = 1, 3 do
		self._num[i] = {
			transform = self:getGo("num/" .. i).transform,
			content = self:getGo("num/" .. i .. "/content")
		}
		self._num[i].contentRect = self._num[i].content:GetComponent(goutil.Type_RectTransform)
		self._num[i].currentVelocity = Vector2.New()
		self._num[i].cells = {}
	end

	self._numIcon = self:getGo("numIcon")
	self._numIconHeight = goutil.getHeight(self._numIcon:GetComponent(goutil.Type_RectTransform))
	self._moneyBtn = self:getBtn("moneyBtn")
	self._goldBar = self:getGo("goldBar")
	self._timeText = self:getTxt("time/txtTime")
	self._moneyConsume = self:getTxt("moneyBtn/consume")
	self._moneyConsumeIcon = self:getGo("moneyBtn/consume/icon")
	self._bubbleText = self:getTxt("bubble/Text")
	self._getBtn = self:getBtn("getBtn")
	self._shopBtn = self:getBtn("shopBtn")
	self._shopIcon = self:getGo("shopBtn/shopIconIma")
	self._shopName = self:getTxt("shopBtn/shopNameTxt")
	self._role = self:getGo("role")
	self._effPath = "fx_ui_2021930/ui_xinxinzhaocaimao/"
end

function HeartMoneyCatView:onExit()
	HeartMoneyCatView.super.onExit(self)

	self._sendMoney = false

	UpdateBeat:Remove(self._move, self)
	MaterialMgr:clearIcon(self._moneyConsumeIcon)
	self:_clearNum()
	removetimer(self._timer, self)
	removetimer(self._popPrize, self)
	GlobalDispatcher:removeListener(HeartMoneyCatController.PM_TreasureBasinGetInfoRes, self._handlePM_TreasureBasinGetInfoRes, self)
	GlobalDispatcher:removeListener(HeartMoneyCatController.PM_TreasureBasinMakeMoneyRes, self._handlePM_TreasureBasinMakeMoneyRes, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._updateGift, self)
	UIEffectManager.instance:stopEffect(self._viewEff)

	for i, num in ipairs(self._num) do
		UIEffectManager.instance:stopEffect(num.eff)
	end

	UIEffectManager.instance:stopEffect(self._bgEff)
	UIEffectManager.instance:stopEffect(self._numEff)

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)
end

function HeartMoneyCatView:onEnter()
	HeartMoneyCatView.super.onEnter(self)
	goutil.setActive(self._numIcon, false)
	self:_resetNum()

	local objList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		},
		{
			id = "10:73001",
			showAdd = true
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)

	self._activityInfo = HeartMoneyCatController.instance:getActivityInfo()
	self._timeText.text = GameUtil.FormatTimeSymbol(self._activityInfo.endTime - ServerTime.now())

	self:_timer()
	settimer(1, self._timer, self, true)
	GlobalDispatcher:addListener(HeartMoneyCatController.PM_TreasureBasinGetInfoRes, self._handlePM_TreasureBasinGetInfoRes, self)
	GlobalDispatcher:addListener(HeartMoneyCatController.PM_TreasureBasinMakeMoneyRes, self._handlePM_TreasureBasinMakeMoneyRes, self)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._updateGift, self)
	TreasureBasinAgent.instance:sendPM_TreasureBasinGetInfoReq(self._activityInfo.activityId)
	self:_updateGift()

	local skinId = self._activityInfo.faceId

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, skinId, self._role, 1, nil, false)
	self._viewEff = UIEffectManager.instance:playEffect(self, self._effPath .. "fx_xinxinzhaocaimao_fenwei_tx1.prefab", nil, nil, nil, true, nil, nil, function(_, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos()
	end)
end

function HeartMoneyCatView:_handlePM_TreasureBasinGetInfoRes()
	self:_updateMoneyBtn()
end

function HeartMoneyCatView:_handlePM_TreasureBasinMakeMoneyRes()
	self._count = 0

	self:_startAnimation(HeartMoneyCatModel.instance:getNum())
end

function HeartMoneyCatView:_updateMoneyBtn()
	local consumePlan = HeartMoneyCatConfig.instance:getConsumeByPlanId(self._activityInfo.consumeId)
	local times = math.min(HeartMoneyCatModel.instance:getTimes() + 1, #consumePlan)
	local itemConsume = consumePlan[times].itemConsume

	self._bubbleText.text = string.format(lang("heart_money_cat_1"), HeartMoneyCatController.instance:getPrizeRange(self._activityInfo.rewardId, times))

	local matType, id, matNum = MaterialMgr.getMatParams(itemConsume)

	self._moneyConsume.text = matNum

	MaterialMgr.setIcon(self._moneyConsumeIcon, matType, id)
end

function HeartMoneyCatView:_updateGift()
	local giftCfg = HeartMoneyCatConfig.instance:getGift()

	for i, v in ipairs(giftCfg) do
		if PayShopModel.instance:getPayShopGoodsCanBuyById(v.giftId) then
			local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.giftId)

			uGuiUtil.setSpriteToImage(self._shopIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))

			self._shopName.text = v.name
			self._giftId = v.giftId

			return
		end
	end

	goutil.setActive(self._shopBtn.gameObject, false)
end

function HeartMoneyCatView:_onClickMoney()
	if self._sendMoney then
		FloatWordMgr.instance:show(lang("heart_money_cat_2"))
	elseif HeartMoneyCatController.instance:isCanMoney(self._activityInfo.consumeId) and not self._sendMoney then
		self._sendMoney = true

		TreasureBasinAgent.instance:sendPM_TreasureBasinMakeMoneyReq(self._activityInfo.activityId)
	else
		self:_onClickGet()
	end
end

function HeartMoneyCatView:_onClickGet()
	local consumePlan = HeartMoneyCatConfig.instance:getConsumeByPlanId(self._activityInfo.consumeId)
	local times = math.min(HeartMoneyCatModel.instance:getTimes() + 1, #consumePlan)
	local itemConsume = consumePlan[times].itemConsume

	MaterialMgr.openGetSourceByStr(itemConsume)
end

function HeartMoneyCatView:_onClickShop()
	local data = {
		id = self._giftId,
		times = PayShopModel.instance:getMibaoBuyTimesById(self._giftId)
	}

	UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
end

function HeartMoneyCatView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "heartmoneycat")
end

function HeartMoneyCatView:_move()
	local curVec, newVec, completeNum = Vector2.New(), Vector2.New(), 0

	for i = 1, #self._num do
		local info = self._num[i]

		curVec.x, curVec.y = Framework.TransformUtil.GetAnchoredPos(info.contentRect, 0, 0)
		newVec.y = curVec.y + info.speed * UnityEngine.Time.deltaTime

		if newVec.y < info.targetPos.y then
			Framework.TransformUtil.SetAnchoredPos(info.contentRect, curVec.x, info.targetPos.y)

			completeNum = completeNum + 1
		else
			Framework.TransformUtil.SetAnchoredPos(info.contentRect, newVec.x, newVec.y)
			self:_sortCell(info.cells, newVec.y)
			UIEffectManager.instance:stopEffect(self._num[i].eff)

			self._num[i].eff = UIEffectManager.instance:playEffect(self, self._effPath .. "fx_xinxinzhaocaimao_shan_tx2.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
				eff:setParent(self._num[i].transform)
				eff:setScale(1)
				eff:setLocalPos()
			end)
		end
	end

	if completeNum >= #self._num then
		UpdateBeat:Remove(self._move, self)
		settimer(1, self._popPrize, self, false)
		UIEffectManager.instance:stopEffect(self._numEff)

		self._numEff = UIEffectManager.instance:playEffect(self, self._effPath .. "fx_xinxinzhaocaimao_zhongjiang_tx3.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
			eff:setParent(self.mainGO.transform)
			eff:setScale(1)
			eff:setLocalPos()
		end)
	end
end

function HeartMoneyCatView:_popPrize()
	MaterialController.instance:showChangeSetInTemp(HeartMoneyCatModel.instance:getChangeSetId())
	self:_resetNum()

	self._sendMoney = false

	self:_updateMoneyBtn()
end

function HeartMoneyCatView:_sortCell(cells, newVecY)
	local firstX, firstY = Framework.TransformUtil.GetAnchoredPos(cells[1].cellRect, 0, 0)
	local lastX, lastY = Framework.TransformUtil.GetAnchoredPos(cells[#cells].cellRect, 0, 0)

	if firstY + newVecY < -200 then
		local cellT = table.remove(cells, 1)

		Framework.TransformUtil.SetAnchoredPos(cellT.cellRect, lastX, lastY + self._numIconHeight)

		cellT.value = (cells[#cells].value + 1) % 10

		cellT.imageChange:SetState(cellT.value)
		table.insert(cells, cellT)
		self:_sortCell(cells, newVecY)
	end
end

function HeartMoneyCatView:_startAnimation(num)
	local temp = num

	for i = #self._num, 1, -1 do
		self._num[i].targetPos = self._num[i].targetPos or Vector2.New()
		self._num[i].targetPos.y = -self._numIconHeight * (89 + temp % 10)
		self._num[i].speed = self._num[i].targetPos.y / (5 - 0.5 * i)
		temp = math.floor(temp / 10)
	end

	self._bgEff = UIEffectManager.instance:playEffect(self, self._effPath .. "fx_xinxinzhaocaimao_choujiang_tx5.prefab", nil, nil, nil, false, nil, nil, function(_, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos()
	end)

	UpdateBeat:Add(self._move, self)
end

function HeartMoneyCatView:_resetNum()
	for i = 1, #self._num do
		self._num[i].smoothTime = 5 - i * 0.5

		Framework.TransformUtil.SetAnchoredPos(self._num[i].contentRect, 0, 0)

		for j = 1, 5 do
			local numIcon

			if self._num[i].cells[j] == nil then
				numIcon = goutil.cloneAndSetParent(self._numIcon, self._num[i].content.transform)

				goutil.setActive(numIcon, true)

				local t = {}

				t.cell = numIcon
				t.cellRect = numIcon:GetComponent(goutil.Type_RectTransform)

				Framework.TransformUtil.SetAnchoredPos(t.cellRect, 0, (j - 1) * self._numIconHeight)

				t.imageChange = numIcon:GetComponent(ComponentType.UIImageSpriteChange)

				t.imageChange:SetState(j - 1)

				t.value = j
				self._num[i].cells[j] = t
			else
				Framework.TransformUtil.SetAnchoredPos(self._num[i].cells[j].cellRect, 0, (j - 1) * self._numIconHeight)
				self._num[i].cells[j].imageChange:SetState(j - 1)

				self._num[i].cells[j].value = j
			end
		end
	end
end

function HeartMoneyCatView:_clearNum()
	for i, v in ipairs(self._num) do
		for j = v.contentRect.childCount - 1, 0, -1 do
			goutil.destroy(v.contentRect:GetChild(j).gameObject)

			v.cells[j + 1] = nil
		end
	end
end

function HeartMoneyCatView:_timer()
	self._timeText.text = self._activityInfo.endTime - ServerTime.now() > 0 and GameUtil.FormatTimeSymbol(self._activityInfo.endTime - ServerTime.now()) or lang("text_activity_end")
end

return HeartMoneyCatView
