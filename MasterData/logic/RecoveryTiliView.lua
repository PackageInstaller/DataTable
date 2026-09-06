-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/RecoveryTiliView.lua

module("logic.extensions.lottery.view.RecoveryTiliView", package.seeall)

local RecoveryTiliView = class("RecoveryTiliView", ViewComponent)

function RecoveryTiliView:ctor()
	RecoveryTiliView.super.ctor(self)

	self.itemList = nil
end

function RecoveryTiliView:bindEvents()
	RecoveryTiliView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)

	for i = 1, 4 do
		if self.itemList[i] and self.itemList[i].useClickBtnObj then
			local num = i

			if num == 1 then
				GameUtil.asBtn(self.itemList[i].useClickBtnObj):AddClickListener(function()
					self:OnClickBuyTiliBtn()
				end, self)
			else
				GameUtil.asBtn(self.itemList[i].useClickBtnObj):AddClickListener(function()
					self:OnClickReceiveBtn(num)
				end, self)
			end
		end
	end

	GlobalDispatcher:addListener(GlobalNotify.OnMaterialItemChange, self.OnGoodsCountChange, self)
end

function RecoveryTiliView:unbindEvents()
	RecoveryTiliView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()

	for _, item in pairs(self.itemList or {}) do
		if item and item.useClickBtnObj then
			GameUtil.asBtn(item.useClickBtnObj):RemoveClickListener()
		end
	end

	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialItemChange, self.OnGoodsCountChange, self)
end

function RecoveryTiliView:destroyUI()
	RecoveryTiliView.super.destroyUI(self)
end

function RecoveryTiliView:onExit()
	RecoveryTiliView.super.onExit(self)
	removetimer(self._countdownTiliTimer, self)

	for _, item in pairs(self.itemList or {}) do
		if item and item.goodsIconIma then
			MaterialMgr.clearIcon(item.goodsIconIma)
		end
	end
end

function RecoveryTiliView:buildUI()
	RecoveryTiliView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("viewBgIma/closeBtn")

	local rightItemsGo = self:getGo("rightItemsGo")

	self.itemList = {}

	for i = 1, 4 do
		self.itemList[i] = {}

		local parentObj = goutil.findChild(rightItemsGo, "cellItem_" .. i)

		self.itemList[i].goodsNameTxt = goutil.findChild(parentObj, "goodsNameTxt"):GetComponent("Text")
		self.itemList[i].goodsDesTxt = goutil.findChild(parentObj, "goodsDesTxt"):GetComponent("Text")
		self.itemList[i].goodsExplainTxt = goutil.findChild(parentObj, "goodexplainBg/goodsExplainTxt"):GetComponent("Text")
		self.itemList[i].useClickBtnObj = goutil.findChild(parentObj, "useClickBtn")

		if i == 1 then
			self.itemList[i].useIconIma = goutil.findChild(parentObj, "useClickBtn/useIconIma"):GetComponent("UIImageSpriteChange")
			self.itemList[i].doubleGo = goutil.findChild(parentObj, "doubleGo")

			self.itemList[i].doubleGo:SetActive(false)
		else
			self.itemList[i].goodsIconIma = goutil.findChild(parentObj, "goodsBgIma/goodsIconIma"):GetComponent("Image")
		end

		self.itemList[i].useDesTxt = goutil.findChild(parentObj, "useClickBtn/useDesTxt"):GetComponent("Text")
	end

	local viewLeftGo = self:getGo("viewLeftGo")

	self.timeTxt = goutil.findChildTextComponent(viewLeftGo, "timeTxt")
	self.countTxt = goutil.findChildTextComponent(viewLeftGo, "countTxt")
	self.descTxt = goutil.findChildTextComponent(viewLeftGo, "descTxt")
	self.timeTxt.text = ""
	self.countTxt.text = ""
	self.descTxt.text = ""
	self._birthdayGo = self:getGo("birthday")
	self.txtExtTime = self:getTxt("birthday/txtTime")
end

function RecoveryTiliView:onEnter()
	RecoveryTiliView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.UpdataTiliCount, self._onUpdate, self)

	local pId = SupplyConfig.instance:getCommonValue("FREE_STRENGTH_BUY_TIME_PLAN_ID")

	GameUtil.SetActive(self._birthdayGo, false)

	local timeCfg = SupplyConfig.instance:getTimePlanCfg(checknumber(pId))

	if timeCfg and GameUtil.checkIsInTimePeriod(timeCfg.startTime, timeCfg.endTime) then
		GameUtil.SetActive(self._birthdayGo, true)

		local pre = GameUtil.string2date(timeCfg.startTime)
		local next = GameUtil.string2date(timeCfg.endTime)

		self.txtExtTime.text = langPara("%s月%s日%s点-%s月%s日%s点", pre.month, pre.day, pre.hour, next.month, next.day, next.hour)
	end

	local tiliInfo = SupplyModel.instance:getTiliCommonInfo()

	self.descTxt.text = langPara("text_tili_desc_9", tiliInfo.recoveryTime / 60, tiliInfo.freeMaxHF)

	self:UpdateShowFirstItem()

	for i = 2, 4 do
		if self.itemList[i] then
			self:UpdateShowOtherItem(i)
		end
	end

	SupplyController.instance:getSupplyInfo()
end

function RecoveryTiliView:_onUpdate()
	self:UpdateShowFirstItem()

	for i = 2, 4 do
		if self.itemList[i] then
			self:UpdateShowOtherItem(i)
		end
	end
end

function RecoveryTiliView:getSupplyBuyCfgs()
	local cfgList = SupplyConfig.instance:getSupplyBuyCfgs()
	local list = {}

	for i, cfg in ipairs(cfgList) do
		if cfg.buyTimePlanId == 0 then
			table.insert(list, cfg)
		else
			local timeCfg = SupplyConfig.instance:getTimePlanCfg(cfg.buyTimePlanId)

			if timeCfg and GameUtil.checkIsInTimePeriod(timeCfg.startTime, timeCfg.endTime) then
				table.insert(list, cfg)
			end
		end
	end

	return list
end

function RecoveryTiliView:UpdateShowFirstItem()
	removetimer(self._countdownTiliTimer, self)

	local item = self.itemList[1]
	local tiliInfo = SupplyModel.instance:getTiliCommonInfo()

	if item == nil or tiliInfo == nil then
		return
	end

	item.goodsNameTxt.text = lang("text_tili_name")

	local isMul = false
	local allBuyCfg = self:getSupplyBuyCfgs()
	local supCount = #allBuyCfg - tiliInfo.buyCount < 0 and 0 or #allBuyCfg - tiliInfo.buyCount

	item.goodsExplainTxt.text = langPara("text_tili_desc_1", supCount, #allBuyCfg)

	if supCount <= 0 then
		GameUtil.setUIImageSpriteIdx(item.useClickBtnObj, 1)
		uGuiUtil.setGoGrayState(item.useClickBtnObj, true)
		GoUtil.SetImageAlpha(item.useClickBtnObj:GetComponent(goutil.Type_UIImage), 0.5)

		item.useDesTxt.text = lang("text_tili_over")
		item.useDesTxt.gameObject.transform.localPosition = Vector3.New(0, 6, 0)

		item.useIconIma.gameObject:SetActive(false)
		item.doubleGo:SetActive(false)
	else
		uGuiUtil.setGoGrayState(item.useClickBtnObj, false)
		GoUtil.SetImageAlpha(item.useClickBtnObj:GetComponent(goutil.Type_UIImage), 1)

		local price = self:GetConsumeFromBuyCount(tiliInfo.useFreeCount, tiliInfo.buyCount)

		if type(price) == "number" and price == 0 then
			GameUtil.setUIImageSpriteIdx(item.useClickBtnObj, 0)

			item.useDesTxt.gameObject.transform.localPosition = Vector3.New(0, 6, 0)
			item.useDesTxt.text = lang("text_tili_free")

			item.useIconIma.gameObject:SetActive(false)
			item.doubleGo:SetActive(false)
		else
			GameUtil.setUIImageSpriteIdx(item.useClickBtnObj, 0)

			item.useDesTxt.gameObject.transform.localPosition = Vector3.New(0, 6, 0)
			item.useDesTxt.text = "购买"

			local prFree = PlayerReturnModel.instance:getSinglePlgeCount(3)

			if checknumber(prFree) <= 0 then
				item.doubleGo:SetActive(false)
			else
				isMul = true

				item.doubleGo:SetActive(tiliInfo.useFreeCount + prFree > tiliInfo.buyCount)
			end
		end
	end

	item.goodsDesTxt.text = isMul and langPara("text_tili_desc_2", tiliInfo.oneBuyCount * 2) or langPara("text_tili_desc_2", tiliInfo.oneBuyCount)

	local hasTili = checknumber(tiliInfo.tiliNowCount)
	local allTili = checknumber(tiliInfo.freeMaxHF)

	self.countTxt.text = langPara("text_tili_desc_10", hasTili, allTili)

	if allTili <= hasTili then
		self.timeTxt.text = lang("text_tili_desc_8")

		return
	end

	self.supTime = checknumber(tiliInfo.endTime) > ServerTime.now() and math.ceil(checknumber(tiliInfo.endTime) - ServerTime.now()) + (allTili - hasTili - 1) * tiliInfo.recoveryTime or math.ceil(checknumber(tiliInfo.endTime) - ServerTime.now()) + (allTili - hasTili) * tiliInfo.recoveryTime
	self.timeTxt.text = TimeUtil:timeConvert2(self.supTime, "HH:MM:SS", true)

	settimer(1, self._countdownTiliTimer, self, true)
end

function RecoveryTiliView:_countdownTiliTimer()
	self.supTime = self.supTime - 1

	if self.supTime <= 0 then
		self.timeTxt.text = lang("text_tili_desc_8")

		removetimer(self._countdownTiliTimer, self)

		return
	end

	self.timeTxt.text = TimeUtil:timeConvert2(self.supTime, "HH:MM:SS", true)
end

function RecoveryTiliView:GetConsumeFromBuyCount(freeCount, useCount)
	local num = VipModel.instance:getFreeGetTimesOfEnergy(isTequan)

	if checknumber(freeCount) < checknumber(num) then
		return 0
	end

	local buyCfg = self:getSupplyBuyCfgs()
	local consume = buyCfg[useCount + 1].consume

	return string.split(consume, ":")
end

function RecoveryTiliView:OnGoodsCountChange(data)
	if data == nil or data:GetMatType() ~= MatType.Item then
		return
	end

	if data:getId() == 32 then
		self:UpdateShowOtherItem(2)
	elseif data:getId() == 33 then
		self:UpdateShowOtherItem(3)
	elseif data:getId() == 34 then
		self:UpdateShowOtherItem(4)
	end
end

function RecoveryTiliView:UpdateShowOtherItem(index)
	if index < 2 then
		return
	end

	local item = self.itemList[index]
	local goodsId = 30 + index
	local itemCfg = MaterialMgr.getMatCfg(MatType.Item, goodsId)

	if item == nil or itemCfg == nil or item.goodsIconIma == nil then
		return
	end

	MaterialMgr.setIcon(item.goodsIconIma, MatType.Item, goodsId)

	item.goodsNameTxt.text = itemCfg.name
	item.goodsDesTxt.text = itemCfg.desc

	local count = MaterialModel.instance:getMaterialsNumber(MatType.Item, goodsId)

	item.goodsExplainTxt.text = langPara("text_tili_desc_3", count)
	item.useDesTxt.text = checknumber(count) <= 0 and "获取" or lang("text_tili_use")
end

function RecoveryTiliView:OnClickBuyTiliBtn()
	local tiliInfo = SupplyModel.instance:getTiliCommonInfo()

	if tiliInfo == nil then
		return
	end

	local allBuyCfg = self:getSupplyBuyCfgs()

	if tiliInfo.buyCount >= #allBuyCfg then
		FloatWordMgr.instance:show(lang("text_tili_desc_4"))

		return
	end

	local price = self:GetConsumeFromBuyCount(tiliInfo.useFreeCount, tiliInfo.buyCount)

	if type(price) == "number" and price == 0 then
		SupplyController.instance:CSRequestBuyTili(1)

		return
	end

	if tonumber(price[1]) == MatType.Coin then
		local haveCount = RoleModel.instance:getCoin()
		local id = checknumber(price[2])
		local allBuyCfg = self:getSupplyBuyCfgs()
		local maxBuyCount = #allBuyCfg
		local supCount = #allBuyCfg - tiliInfo.buyCount < 0 and 0 or #allBuyCfg - tiliInfo.buyCount

		if haveCount < tonumber(price[3]) then
			MaterialMgr.openGetSource(MatType.Coin, MatType.Coin_Gold, GameUtil.handler(self.close, self))
			FloatWordMgr.instance:show(lang("text_tili_desc_5"))

			return
		end

		SupplyController.instance:CSRequestBuyTili(1)
		TipsFacade.instance:openPopupCostAdjustBySingleNumView(MatType.Coin, checknumber(price[2]), checknumber(price[3]), 1, langPara("确定花费%d钻石购买%d次体力吗？\n每天最多可购买%d次，还能购买%d次", checknumber(price[3]), 1, maxBuyCount, supCount), function(num)
			SupplyController.instance:CSRequestBuyTili(num)
		end, supCount, nil, function(state, num)
			if state == TipsFacade.STATE_NUM_CHANGE then
				return langPara("确定花费%d钻石购买%d次体力吗？\n每天最多可购买%d次，还能购买%d次", checknumber(price[3]) * num, num, maxBuyCount, supCount)
			end
		end)
	else
		local haveCount = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()

		if haveCount < tonumber(price[3]) then
			MaterialMgr.openGetSource(MatType.Diamond, MatType.Diamond_Normal, GameUtil.handler(self.close, self))
			FloatWordMgr.instance:show(lang("text_tili_desc_6"))

			return
		end

		local id = checknumber(price[2])
		local allBuyCfg = self:getSupplyBuyCfgs()
		local maxBuyCount = #allBuyCfg
		local supCount = #allBuyCfg - tiliInfo.buyCount < 0 and 0 or #allBuyCfg - tiliInfo.buyCount

		TipsFacade.instance:openPopupCostAdjustBySingleNumView(MatType.Diamond, id, checknumber(price[3]), 1, langPara("确定花费%d钻石购买%d次体力吗？\n每天最多可购买%d次，还能购买%d次", checknumber(price[3]), 1, maxBuyCount, supCount), function(num)
			SupplyController.instance:CSRequestBuyTili(num)
		end, supCount, nil, function(state, num)
			if state == TipsFacade.STATE_NUM_CHANGE then
				return langPara("确定花费%d钻石购买%d次体力吗？\n每天最多可购买%d次，还能购买%d次", checknumber(price[3]) * num, num, maxBuyCount, supCount)
			end
		end)
	end
end

function RecoveryTiliView:OnClickReceiveBtn(index)
	local goodsId = 30 + index
	local itemCfg = MaterialMgr.getMatCfg(MatType.Item, goodsId)

	if itemCfg == nil then
		return
	end

	local count = MaterialModel.instance:getMaterialsNumber(MatType.Item, goodsId)

	if checknumber(count) <= 0 then
		MaterialMgr.openGetSource(MatType.Item, goodsId)
	elseif checknumber(count) > 1 then
		UIStateManager.instance:push(ViewName.RecoveryTiliCostTipView, MatType.Item, goodsId, index)
	else
		MaterialFacade.instance:useItem(MatType.Item, goodsId, 1)
	end
end

return RecoveryTiliView
