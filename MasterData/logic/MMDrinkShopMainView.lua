-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/view/MMDrinkShopMainView.lua

module("logic.extensions.mmdrinkshop.view.MMDrinkShopMainView", package.seeall)

local MMDrinkShopMainView = class("MMDrinkShopMainView", ViewComponent)

function MMDrinkShopMainView:ctor()
	MMDrinkShopMainView.super.ctor(self)
end

function MMDrinkShopMainView:unbindEvents()
	MMDrinkShopMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnUnlock)

	for _, cell in ipairs(self._slotCells) do
		GameUtil.rmClickHandler(cell.btnGoto)
		GameUtil.rmClickHandler(cell.btnFinish)
	end
end

function MMDrinkShopMainView:bindEvents()
	MMDrinkShopMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnUnlock, self._onClickBtnUnlock, self)

	for i, cell in ipairs(self._slotCells) do
		GameUtil.addClickHandler(cell.btnGoto, function()
			self:_onClickBtnGoto(i)
		end, self)
		GameUtil.addClickHandler(cell.btnFinish, function()
			self:_onClickBtnFinish(i)
		end, self)
	end
end

function MMDrinkShopMainView:buildUI()
	MMDrinkShopMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnUnlock = self:getGo("btnUnlock")
	self._conSlotinfos = self:getGo("slotinfos")
	self._slotCells = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("slotinfos/slotcell_" .. i)
		cell.drink = goutil.findChild(cell.go, "drink")
		cell.drinkBase = goutil.findChild(cell.go, "drink/base")
		cell.drinkToppings1 = goutil.findChild(cell.go, "drink/toppings1")
		cell.drinkToppings2 = goutil.findChild(cell.go, "drink/toppings2")
		cell.drinkTop = goutil.findChild(cell.go, "drink/top")
		cell.conMaking = goutil.findChild(cell.go, "conMaking")
		cell.btnGoto = goutil.findChild(cell.go, "btnGoto")
		cell.btnFinish = goutil.findChild(cell.go, "conprize/btnFinish")
		cell.conPrize = goutil.findChild(cell.go, "conprize")
		cell.eff = nil
		cell.prizeicon = goutil.findChild(cell.go, "conprize/prizeicon")
		cell.finishTips = goutil.findChild(cell.go, "finishTips")
		cell.txtTimer = goutil.findChildTextComponent(cell.go, "conMaking/txtTimer")

		function cell.updateMakeTimer()
			local LeftTime = self:_getSlotLeftMakeSeconds(i)

			if LeftTime > 0 then
				local timeStr = GameUtil.FormatTimeSymbol(LeftTime)

				cell.txtTimer.text = langPara("剩余：%s", timeStr)
			else
				self:_resetSlotCells(cell)
				self:_updateSlotCellByInfo(i)
			end
		end

		table.insert(self._slotCells, cell)
	end

	self._redPoint = self:getGo("btnUnlock/redPoint")
end

function MMDrinkShopMainView:onExit()
	MMDrinkShopMainView.super.onExit(self)

	for _, cell in ipairs(self._slotCells) do
		self:_resetSlotCells(cell)
	end

	RedPointController.instance:unregRedPoint(self._redPoint)

	if self._uiEff then
		UIEffectManager.instance:stopEffect(self._uiEff)

		self._uiEff = nil
	end
end

function MMDrinkShopMainView:onEnter()
	MMDrinkShopMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MMDrinkShopGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_MMDrinkShopStartMakeRes, self._handleStartMake, self)
	self.addGEvent(self, GlobalNotify.PM_MMDrinkShopFinishMakeRes, self._handleFinishMake, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = MMDrinkShopController.instance:getDefaultActivityId()
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	MMDrinkShopController.instance:getInfo(self._activityId)
	RedPointController.instance:regRedPoint(self._redPoint, 776)

	local effPath = "20260529/mmyld/fx_ui_mmyld_fw.prefab"

	self._uiEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScaleXYZ(1, 1, 1)
	end)
end

function MMDrinkShopMainView:_updateUIByCfg()
	self._actCfg = MMDrinkShopConfig.instance:getActivityCfgByActivityId(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	if self._actCfg then
		self._curShowItemStr = self._actCfg.showItem or ""
	end

	if self._actCfg then
		self._slotCount = self._actCfg.slotCount or 0
	end

	for i, cell in ipairs(self._slotCells) do
		local showSlot = i <= self._slotCount

		cell.go:SetActive(showSlot)
	end
end

function MMDrinkShopMainView:_updateUIByInfo()
	for slotId = 1, self._slotCount do
		self:_updateSlotCellByInfo(slotId)
	end
end

function MMDrinkShopMainView:_handleStartMake()
	TipsFacade.instance:openCommonTips(lang("开始制作"))
	self:_updateUIByInfo()
end

function MMDrinkShopMainView:_handleFinishMake()
	TipsFacade.instance:openCommonTips(lang("完成制作"))
	self:_updateUIByInfo()
end

function MMDrinkShopMainView:_onClickBtnTip()
	if self._actCfg then
		if not self._actCfg.ruleKey then
			local ruleKey = ""

			TipsFacade.instance:openRulesView(ruleKey)
		end
	end
end

function MMDrinkShopMainView:_onClickBtnUnlock()
	UIStateManager.instance:push(ViewName.MMDrinkShopUnlockView, self._activityId)
end

function MMDrinkShopMainView:_onClickBtnGoto(slotId)
	local status = MMDrinkShopModel.instance:getSlotClientStatus(self._activityId, slotId)

	if status == MMDrinkShopModel.SLOT_CLIENT_STATUS.EMPTY then
		UIStateManager.instance:push(ViewName.MMDrinkShopMakeView, self._activityId, slotId)
	end
end

function MMDrinkShopMainView:_onClickBtnFinish(slotId)
	local status = MMDrinkShopModel.instance:getSlotClientStatus(self._activityId, slotId)

	if status == MMDrinkShopModel.SLOT_CLIENT_STATUS.FINISHED then
		MMDrinkShopController.instance:finishMake(self._activityId, slotId)
	end
end

function MMDrinkShopMainView:_resetSlotCells(cell)
	if cell then
		removetimer(cell.updateMakeTimer, self)
		MaterialMgr.resetAll(cell.prizeicon)
		goutil.setActive(cell.conMaking, false)
		goutil.setActive(cell.conPrize, false)
		goutil.setActive(cell.btnGoto, false)
		goutil.setActive(cell.btnFinish, false)
		goutil.setActive(cell.finishTips, false)

		if cell.effect then
			UIEffectManager.instance:stopEffect(cell.effect)
		end

		cell.effect = nil
	end
end

function MMDrinkShopMainView:_updateSlotCellByInfo(slotId)
	local cell = self._slotCells[slotId]
	local clientStatus = MMDrinkShopModel.instance:getSlotClientStatus(self._activityId, slotId)
	local drinkId = MMDrinkShopModel.instance:getSlotDrinkId(self._activityId, slotId)

	if not cell then
		return
	end

	self:_updateSlotCellDrinkShow(slotId, nil)
	self:_resetSlotCells(cell)

	local resPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	cell.effect = UIEffectManager.instance:playEffect(self, resPath, cell.btnFinish.transform, 0, 0, true, false, nil, function(_, eff)
		eff:setClipping(self.mainGO.transform:GetComponent(goutil.Type_RectTransform))
		eff.effGo.transform:SetParent(cell.btnFinish.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 0.7, 0.7, 0.7)
	end)

	local drinkCfg = MMDrinkShopConfig.instance:getDrinkCfgByDrinkId(self._activityId, drinkId)
	local gainScore = 0

	if drinkCfg then
		gainScore = drinkCfg.gainScore or 0
	end

	if gainScore > 0 and self._curShowItemStr ~= "" then
		local gainScoreStr = self._curShowItemStr .. ":" .. gainScore

		MaterialMgr.setCellByCfg(gainScoreStr, cell.prizeicon)
	end

	if clientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.EMPTY then
		goutil.setActive(cell.btnGoto, true)
	elseif clientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.CLAIMED then
		goutil.setActive(cell.finishTips, true)
	elseif clientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.MAKING then
		GameUtil.callBack(cell.updateMakeTimer, cell)
		settimer(1, cell.updateMakeTimer, self, true)
		goutil.setActive(cell.conMaking, true)
		self:_updateSlotCellDrinkShow(slotId, drinkCfg)
	elseif clientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.FINISHED then
		goutil.setActive(cell.btnFinish, true)
		goutil.setActive(cell.conPrize, true)
		self:_updateSlotCellDrinkShow(slotId, drinkCfg)
	elseif clientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.ERROR then
		-- block empty
	end
end

function MMDrinkShopMainView:_updateSlotCellDrinkShow(slotId, drinkCfg)
	local cell = self._slotCells[slotId]

	if cell and drinkCfg then
		if not drinkCfg.stepToppingsPlanIdArr then
			for stepId, toppingsPlanId in pairs(drinkCfg.stepToppingsPlanIdArr) do
				local toppingsPlanCfg = MMDrinkShopConfig.instance:getToppingsPlanCfgByPlanId(toppingsPlanId)

				if toppingsPlanCfg then
					if toppingsPlanCfg then
						if not toppingsPlanCfg.toppingsIdArr then
							local toppingsIdArr = {}

							if stepId == 2 then
								local baseToppingsId = toppingsIdArr[1]
								local baseToppingsCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, baseToppingsId)

								if baseToppingsCfg then
									local changer = GameUtil.getUIImageSpriteChange(cell.drinkBase)

									goutil.setActive(cell.drinkBase, true)
									changer:ChangeSprite(baseToppingsCfg.showPic)
								end
							elseif stepId == 1 then
								local toppingsId1 = toppingsIdArr[1]
								local toppingsCfg1 = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, toppingsId1)

								if toppingsCfg1 then
									local changer = GameUtil.getUIImageSpriteChange(cell.drinkToppings1)

									goutil.setActive(cell.drinkToppings1, true)
									changer:ChangeSprite(toppingsCfg1.showPic)
								end

								local toppingsId2 = toppingsIdArr[2]
								local toppingsCfg2 = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, toppingsId2)

								if toppingsCfg2 then
									local changer = GameUtil.getUIImageSpriteChange(cell.drinkToppings2)

									changer:ChangeSprite(toppingsCfg2.showPic)
									goutil.setActive(cell.drinkToppings2, true)
								end
							elseif stepId == 3 then
								local topToppingsId = toppingsIdArr[1]
								local topToppingsCfg = MMDrinkShopConfig.instance:getToppingsCfgByToppingsId(self._activityId, topToppingsId)

								if topToppingsCfg then
									local changer = GameUtil.getUIImageSpriteChange(cell.drinkTop)

									goutil.setActive(cell.drinkTop, true)
									changer:ChangeSprite(topToppingsCfg.showPic)
								end
							end
						end
					end
				end
			end
		end
	else
		goutil.setActive(cell.drinkBase, false)
		goutil.setActive(cell.drinkToppings1, false)
		goutil.setActive(cell.drinkToppings2, false)
		goutil.setActive(cell.drinkTop, false)
	end
end

function MMDrinkShopMainView:_getSlotLeftMakeSeconds(slotId)
	local status = MMDrinkShopModel.instance:getSlotClientStatus(self._activityId, slotId)

	if status == MMDrinkShopModel.SLOT_CLIENT_STATUS.MAKING then
		local slotInfo = MMDrinkShopModel.instance:getSlotInfo(self._activityId, slotId)

		if slotInfo then
			local drinkId = slotInfo.drinkId
			local drinkConfig = MMDrinkShopConfig.instance:getDrinkCfgByDrinkId(self._activityId, drinkId)

			if drinkConfig then
				local makeSeconds = checknumber(drinkConfig.makeSeconds)
				local startTime = Mathf.Floor(checknumber(slotInfo.startTime) / 1000)
				local currentTime = ServerTime.now()
				local leftSeconds = startTime + makeSeconds - currentTime

				return math.max(leftSeconds, 0)
			end
		end
	end

	return 0
end

return MMDrinkShopMainView
