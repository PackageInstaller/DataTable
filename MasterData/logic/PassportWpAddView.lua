-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportWpAddView.lua

module("logic.extensions.passport.view.PassportWpAddView", package.seeall)

local PassportWpAddView = class("PassportWpAddView", ViewComponent)

function PassportWpAddView:buildUI()
	PassportWpAddView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnHelp = self:getGo("btnHelp")
	self._btnOneKey = self:getGo("btnOneKey")
	self._rpOneKey = goutil.findChild(self._btnOneKey, "rp")
	self._timeTips = self:getGo("timeTips")
	self._txtTimeTips = self:getTxt("timeTips/txt")
	self._txtTips = self:getTxt("Tips")
	self._btnGoTo = self:getGo("btnGoTo")
	self._btnBuy = self:getGo("btnBuy")
	self._sldProgress = self:getSlider("tableview/Viewport/Content/sldProgress")
	self._retProress = self._sldProgress.gameObject:GetComponent("RectTransform")
	self._retProress.offsetMin = UnityEngine.Vector2.New(120, -50)
	self._retProress.offsetMax = UnityEngine.Vector2.New(-360, -40)
	self._txtProgress = self:getTxt("txtProgress")
	self._scrollRect = self._goTable:GetComponent(ComponentType.ScrollRect)
	self._extraPart = self:getGo("extraPart")
	self._btnGetExtra = self:getBtn("extraPart/btnGet")
	self._btnRuleExtra = self:getBtn("extraPart/btnRule")
	self._txtProgressExtra = self:getTxt("extraPart/txtProgress")
	self._goPay = self:getGo("pay")
	self._goPayLock = self:getGo("pay/lock")
	self._btnPay = goutil.findChild(self._goPay, "btn")
	self._txtPay = goutil.findChildTextComponent(self._btnPay, "txt")
	self._tipPay = goutil.findChild(self._goPay, "tip")
	self._txtTipPay = goutil.findChildTextComponent(self._tipPay, "txt")
	self._goPayAdd = self:getGo("pay_Add")
	self._goPayAddLock = self:getGo("pay_Add/lock")
	self._btnPayAdd = goutil.findChild(self._goPayAdd, "btn")
	self._txtPayAdd = goutil.findChildTextComponent(self._btnPayAdd, "txt")
	self._tipPayAdd = goutil.findChild(self._goPayAdd, "tip")
	self._txtTipPayAdd = goutil.findChildTextComponent(self._tipPayAdd, "txt")
	self._goPayThird = self:getGo("pay_Third")
	self._goPayThirdLock = self:getGo("pay_Third/lock")
	self._btnPayThird = self:getGo("pay_Third/btn")
	self._txtPayThird = self:getTxt("pay_Third/btn/txt")
	self._tipPayThird = self:getGo("pay_Third/tip")
	self._txtTipPayThird = self:getTxt("pay_Third/tip/txt")
end

function PassportWpAddView:bindEvents()
	PassportWpAddView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnGoTo, self._onClickGoTo, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnGetExtra, self._onClickGetExtra, self)
	GameUtil.addClickHandler(self._btnRuleExtra, self._onClickRuleExtra, self)
	GameUtil.addClickHandler(self._btnPay, GameUtil.handler(self._onClickShowBuy, self, PassportModel.ORDINARY_PAYMENT_PRIZE_TYPE))
	GameUtil.addClickHandler(self._btnPayAdd, GameUtil.handler(self._onClickShowBuy, self, PassportModel.ADDITIONAL_PAYMENT_PRIZE_TYPE))
	GameUtil.addClickHandler(self._btnPayThird, GameUtil.handler(self._onClickShowBuy, self, PassportModel.THIRD_PAYMENT_PRIZE_TYPE))
end

function PassportWpAddView:unbindEvents()
	PassportWpAddView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnGoTo)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnGetExtra)
	GameUtil.rmClickHandler(self._btnRuleExtra)
	GameUtil.rmClickHandler(self._btnPay)
	GameUtil.rmClickHandler(self._btnPayAdd)
end

function PassportWpAddView:onEnter()
	PassportWpAddView.super.onEnter(self)

	self._passPortFuncId = 1

	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PassportExtraPrizeUpdate, self._refreshExtraPart, self)
	PassportController.instance:sendGetInfoReq(self._passPortFuncId)
	self:_resetActTimePart()
	self._sldProgress:SetValue(0)

	self._txtProgress.text = ""

	goutil.setActive(self._extraPart, false)

	self._ableToClick = true
end

function PassportWpAddView:onExit()
	PassportWpAddView.super.onExit(self)
	self._tableView:dispose()
	self:_resetActTimePart()
	removetimer(self._gainExtra, self)
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PassportExtraPrizeUpdate, self._refreshExtraPart, self)
end

function PassportWpAddView:_refreshView()
	self._curData = PassportModel.instance:getInfo(self._passPortFuncId)

	local dataList = self:_getCurDataList()

	self._tableView:reloadData(dataList)

	local idx = self:_getFirstCanGetCell(dataList)

	self._tableView:MoveCellToCenter(idx)
	self:_setActTimePart()
	self._sldProgress:SetValue(self._curData.sldValue)

	self._txtProgress.text = self._curData.progressTxt
	self._txtTips.text = self._curData.funcCfg.progressTips

	goutil.setActive(self._btnBuy, self._curData.progressAbletToBuy > 0)
	self:_refreshExtraPart()
	self:_refreshOneKey()
	self:_refreshPayBtn()
end

function PassportWpAddView:_refreshPayBtn()
	GameUtil.SetActive(self._goPayLock, false)
	GameUtil.SetActive(self._goPayAddLock, false)
	GameUtil.SetActive(self._goPayThirdLock, false)

	local timeNow = ServerTime.now()

	if self._curData.hasPay then
		GameUtil.SetGray(self._btnPay, false)

		self._txtPay.text = lang("已售罄")

		goutil.setActive(self._tipPay, false)
	else
		local goodId = self._curData.actCfg.goodsId

		self._payNum = PayConfig.instance:getPayMoneyYuan(goodId)
		self._txtPay.text = langPara("%s元解锁", self._payNum)

		goutil.setActive(self._tipPay, false)

		if not string.nilorempty(self._curData.actCfg.ordinaryBuyStartTime) then
			local timeStamp = GameUtil.string2time(self._curData.actCfg.ordinaryBuyStartTime)

			if timeNow < timeStamp then
				local date = GameUtil.time2date(timeStamp)

				self._txtTipPay.text = langPara("%s.%s开启售卖", date.month, date.day)

				goutil.setActive(self._tipPay, true)
			end
		end

		GameUtil.SetGray(self._btnPay, true)
		GameUtil.SetActive(self._goPayLock, true)
	end

	if self._curData.hasPayAdd then
		GameUtil.SetGray(self._btnPayAdd, false)

		self._txtPayAdd.text = lang("已售罄")

		goutil.setActive(self._tipPayAdd, false)
	else
		local goodId = self._curData.actCfg.additonalGoodsId

		self._payAddNum = PayConfig.instance:getPayMoneyYuan(goodId)
		self._txtPayAdd.text = langPara("%s元解锁", self._payAddNum)

		goutil.setActive(self._tipPayAdd, false)

		if not string.nilorempty(self._curData.actCfg.additionalBuyStartTime) then
			local timeStamp = GameUtil.string2time(self._curData.actCfg.additionalBuyStartTime)

			if timeNow < timeStamp then
				local date = GameUtil.time2date(timeStamp)

				self._txtTipPayAdd.text = langPara("%s.%s开启售卖", date.month, date.day)

				goutil.setActive(self._tipPayAdd, true)
			end
		end

		GameUtil.SetGray(self._btnPayAdd, true)
		GameUtil.SetActive(self._goPayAddLock, true)
	end

	if self._curData.hasPayThird then
		GameUtil.SetGray(self._btnPayThird, false)

		self._txtPayThird.text = lang("已售罄")

		goutil.setActive(self._tipPayThird, false)
	else
		local goodId = self._curData.actCfg.thirdGoodsId

		self._payThird = PayConfig.instance:getPayMoneyYuan(goodId)
		self._txtPayThird.text = langPara("%s元解锁", self._payThird)

		goutil.setActive(self._tipPayThird, false)

		if not string.nilorempty(self._curData.actCfg.thirdBuyStartTime) then
			local timeStamp = GameUtil.string2time(self._curData.actCfg.thirdBuyStartTime)

			if timeNow < timeStamp then
				local date = GameUtil.time2date(timeStamp)

				self._txtTipPayThird.text = langPara("%s.%s开启售卖", date.month, date.day)

				goutil.setActive(self._tipPayThird, true)
			end
		end

		GameUtil.SetGray(self._btnPayThird, true)
		GameUtil.SetActive(self._goPayThirdLock, true)
	end
end

function PassportWpAddView:_refreshOneKey()
	self._ableToGetOneKey = false

	for i = 1, self._curData.unlockIndex - 1 do
		if not self._curData.normalPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end

		if self._curData.hasPay and not self._curData.superPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end

		if self._curData.hasPayAdd and not self._curData.addPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end

		if self._curData.hasPayThird and not self._curData.thirdPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end
	end

	goutil.setActive(self._rpOneKey, self._ableToGetOneKey)
end

function PassportWpAddView:_resetActTimePart()
	removetimer(self._onCountDonw, self)
	goutil.setActive(self._timeTips, false)
end

function PassportWpAddView:_setActTimePart()
	self:_resetActTimePart()
	self:_onCountDonw()
	settimer(1, self._onCountDonw, self)
	goutil.setActive(self._timeTips, true)
end

function PassportWpAddView:_onCountDonw()
	local currTime = ServerTime.now()
	local countDownTime = self._curData.endTime / 1000 - currTime

	if countDownTime < 0 then
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.ActivityEnd)

		return
	else
		self._txtTimeTips.text = GameUtil.FormatTimeSymbol(countDownTime)
	end
end

function PassportWpAddView:_getCurDataList()
	local dataList = {}

	for index, v in ipairs(self._curData.prizeCfgs) do
		local data = {}

		data.id = index
		data.progressKey = v.thresholdParam
		data.freePrize = v.freePrize
		data.payedPrize = v.payedPrize
		data.additionalPaymentPrize = v.additionalPaymentPrize
		data.thirdPaymentPrize = v.thirdPaymentPrize
		data.freeState = self._curData.normalPrizeState[index]
		data.superState = self._curData.superPrizeState[index]
		data.addState = self._curData.addPrizeState[index]
		data.thirdState = self._curData.thirdPrizeState[index]
		data.isLast = false

		table.insert(dataList, data)
	end

	dataList[#dataList].isLast = true

	table.insert(dataList, {})

	return dataList
end

function PassportWpAddView:_getFirstCanGetCell(list)
	local unlockIndex = checknumber(self._curData.unlockIndex)

	for i, data in ipairs(list) do
		if checknumber(data.id) > 0 and unlockIndex > checknumber(data.id) then
			if not data.freeState then
				return i - 1
			end

			if not data.superState and self._curData.hasPay then
				return i - 1
			end

			if not data.addState and self._curData.hasPayAdd then
				return i - 1
			end

			if not data.thirdState and self._curData.hasPayThird then
				return i - 1
			end
		else
			return i - 1
		end
	end
end

function PassportWpAddView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if not string.nilorempty(data.freePrize) then
		local prizeArr = string.split(data.freePrize, "#")
		local proxy_1 = MaterialMgr.setCellByCfg(prizeArr[1], cell.itemList[1].item)
		local proxy_2 = MaterialMgr.setCellByCfg(prizeArr[2], cell.itemList[2].item)

		goutil.setActive(cell.itemList[1].mark, data.freeState)
		goutil.setActive(cell.itemList[2].mark, data.freeState)

		if not data.freeState and data.id < self._curData.unlockIndex then
			goutil.setActive(cell.itemList[1].rp, true)
			self:_playCellEff(cell.itemList[1].item)
			proxy_1:setAutoTips(false)
			proxy_1:setCallBack(function()
				PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false)
			end)
			goutil.setActive(cell.itemList[2].rp, true)
			self:_playCellEff(cell.itemList[2].item)
			proxy_2:setAutoTips(false)
			proxy_2:setCallBack(function()
				PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false)
			end)
		end
	end

	if not string.nilorempty(data.payedPrize) then
		local prizeArr = string.split(data.payedPrize, "#")
		local proxy_3 = MaterialMgr.setCellByCfg(prizeArr[1], cell.itemList[3].item)
		local proxy_4 = MaterialMgr.setCellByCfg(prizeArr[2], cell.itemList[4].item)

		goutil.setActive(cell.itemList[3].mark, data.superState)
		goutil.setActive(cell.itemList[4].mark, data.superState)

		if not data.superState and data.id < self._curData.unlockIndex then
			goutil.setActive(cell.itemList[3].rp, true)

			if self._curData.hasPay then
				proxy_3:setAutoTips(false)
			end

			self:_playCellEff(cell.itemList[3].item)
			proxy_3:setCallBack(function()
				if self._curData.hasPay then
					PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, true)
				end
			end)
			goutil.setActive(cell.itemList[4].rp, true)
			self:_playCellEff(cell.itemList[4].item)
			proxy_4:setCallBack(function()
				if self._curData.hasPay then
					PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, true)
				end
			end)
		end
	end

	if not string.nilorempty(data.additionalPaymentPrize) then
		local prizeArr = string.split(data.additionalPaymentPrize, "#")
		local proxy_5 = MaterialMgr.setCellByCfg(prizeArr[1], cell.itemList[5].item)
		local proxy_6 = MaterialMgr.setCellByCfg(prizeArr[2], cell.itemList[6].item)

		goutil.setActive(cell.itemList[5].mark, data.addState)
		goutil.setActive(cell.itemList[6].mark, data.addState)

		if not data.addState and data.id < self._curData.unlockIndex then
			goutil.setActive(cell.itemList[5].rp, true)

			if self._curData.hasPayAdd then
				proxy_5:setAutoTips(false)
			end

			self:_playCellEff(cell.itemList[5].item)
			proxy_5:setCallBack(function()
				if self._curData.hasPayAdd then
					PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false, true)
				end
			end)
			goutil.setActive(cell.itemList[6].rp, true)

			if self._curData.hasPayAdd then
				proxy_6:setAutoTips(false)
			end

			self:_playCellEff(cell.itemList[6].item)
			proxy_6:setCallBack(function()
				if self._curData.hasPayAdd then
					PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false, true)
				end
			end)
		end
	end

	if not string.nilorempty(data.thirdPaymentPrize) then
		local prizeArr = string.split(data.thirdPaymentPrize, "#")
		local proxy_7 = MaterialMgr.setCellByCfg(prizeArr[1], cell.itemList[7].item)
		local proxy_8 = MaterialMgr.setCellByCfg(prizeArr[2], cell.itemList[8].item)

		goutil.setActive(cell.itemList[7].mark, data.thirdState)
		goutil.setActive(cell.itemList[8].mark, data.thirdState)

		if not data.thirdState and data.id < self._curData.unlockIndex then
			goutil.setActive(cell.itemList[7].rp, true)

			if self._curData.hasPayThird then
				proxy_7:setAutoTips(false)
			end

			self:_playCellEff(cell.itemList[7].item)
			proxy_7:setCallBack(function()
				if self._curData.hasPayThird then
					PassportController.instance:sendGainPrizeReqByType(self._curData.actId, self._curData.funcId, data.id - 1, PassportModel.THIRD_PAYMENT_PRIZE_TYPE)
				end
			end)
			goutil.setActive(cell.itemList[8].rp, true)

			if self._curData.hasPayThird then
				proxy_8:setAutoTips(false)
			end

			self:_playCellEff(cell.itemList[8].item)
			proxy_8:setCallBack(function()
				if self._curData.hasPayThird then
					PassportController.instance:sendGainPrizeReqByType(self._curData.actId, self._curData.funcId, data.id - 1, PassportModel.THIRD_PAYMENT_PRIZE_TYPE)
				end
			end)
		end
	end

	cell.txtProgrss.text = data.progressKey

	if data.id then
		goutil.setActive(cell.com, true)
	else
		goutil.setActive(cell.com, false)
	end

	if data.isLast then
		goutil.addChildToParent(self._extraPart, cell.go)
		GameUtil.setAnchoredPos(self._extraPart, 0, 0)
		goutil.setActive(self._extraPart, true)
	else
		local extraPart = goutil.findChild(cell.go, "extraPart")

		if extraPart then
			goutil.addChildToParent(self._extraPart, self.mainGO)
			goutil.setActive(self._extraPart, false)
		end
	end
end

function PassportWpAddView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.com = goutil.findChild(cell.go, "com")
	cell.txtProgrss = goutil.findChildTextComponent(cell.com, "txtProgress")
	cell.itemList = {}

	for i = 1, 8 do
		local itemcell = {}

		itemcell.go = goutil.findChild(cell.com, "item_" .. i)
		itemcell.rp = goutil.findChild(itemcell.go, "rp")
		itemcell.mark = goutil.findChild(itemcell.go, "mark")
		itemcell.item = goutil.findChild(itemcell.go, "cell")

		MaterialMgr.resetAll(itemcell.item)
		goutil.setActive(itemcell.mark, false)
		goutil.setActive(itemcell.rp, false)
		self:_removeCellEff(itemcell.item)

		cell.itemList[i] = itemcell
	end

	return cell
end

function PassportWpAddView:_onClickHelp()
	ViewMgr.instance:open(ViewName.RulesView, self._curData.funcCfg.rule)
end

function PassportWpAddView:_onClickGoTo()
	UIStateManager.instance:push(ViewName.diamondtask, GameEnum.TaskViewTab.Daily)
end

function PassportWpAddView:_onClickBuy()
	if self._curData.progressAbletToBuy <= 0 then
		GameUtil.SetActive(self._goBuyProgress, false)

		return
	end

	UIStateManager.instance:push(ViewName.PassportbuyporgressView, self._curData.funcCfg, self._curData.actCfg, self._curData.progressAbletToBuy)
end

function PassportWpAddView:_onClickOneKey()
	if self._ableToGetOneKey then
		PassportController.instance:sendOneKeyGainPrizeReq(self._curData.actId, self._curData.funcId)

		return
	end

	if not self._curData.hasPay then
		FloatWordMgr.instance:show(langPara("解锁%s元奖励可以领取剩余物品", self._payNum))

		return
	end

	if not self._curData.hasPayAdd then
		FloatWordMgr.instance:show(langPara("解锁%s元奖励可以领取剩余物品", self._payAddNum))

		return
	end

	if not self._curData.hasPayThird then
		FloatWordMgr.instance:show(langPara("解锁%s元奖励可以领取剩余物品", self._payThird))

		return
	end

	FloatWordMgr.instance:show(lang("当前无可领取奖励"))
end

function PassportWpAddView:_playCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local resPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	local function loadCallBack()
		self._effs[go]:setScrollRectClipping(self._scrollRect)
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, true, nil, nil, loadCallBack)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScale(1)
	self._effs[go]:setLocalPos(0, 0, 0)

	self._effs[go].hideEffWhileNotOnTop = true
end

function PassportWpAddView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function PassportWpAddView:_onClickShowBuy(type)
	local isBlock = false

	if type == PassportModel.ORDINARY_PAYMENT_PRIZE_TYPE then
		if self._curData.hasPay then
			isBlock = true
		end
	elseif type == PassportModel.ADDITIONAL_PAYMENT_PRIZE_TYPE then
		if self._curData.hasPayAdd then
			isBlock = true
		end
	elseif type == PassportModel.THIRD_PAYMENT_PRIZE_TYPE and self._curData.hasPayThird then
		isBlock = true
	end

	if isBlock then
		TipsFacade.instance:openCommonTips("已购买该档位通行证")
	else
		UIStateManager.instance:push(ViewName.PassportwpextbuyView)
	end
end

function PassportWpAddView:_onClickPay()
	if self._curData.hasPay then
		GameUtil.SetGray(self._btnPay, true)

		self._txtPay.text = lang("已售罄")

		FloatWordMgr.instance:show(lang("已售罄"))

		return
	end

	if not string.nilorempty(self._curData.actCfg.ordinaryBuyStartTime) then
		local timeNow = ServerTime.now()

		if timeNow < GameUtil.string2time(self._curData.actCfg.ordinaryBuyStartTime) then
			FloatWordMgr.instance:show(langPara("%s后开启售卖", string.gsub(self._curData.actCfg.ordinaryBuyStartTime, "T", " ")))

			return
		end
	end

	local data1, data2, data3, num = PassportModel.instance:getCurDataList(nil, self._curData.funcId)

	if GameUtil.isEmptyString(data1[1]) then
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 1, self._curData.sldValue)
	else
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 2, self._curData.sldValue)
	end
end

function PassportWpAddView:_onClickPayAdd()
	if self._curData.hasPayAdd then
		GameUtil.SetGray(self._btnPayAdd, true)

		self._txtPayAdd.text = lang("已售罄")

		FloatWordMgr.instance:show(lang("已售罄"))

		return
	end

	if not string.nilorempty(self._curData.actCfg.additionalBuyStartTime) then
		local timeNow = ServerTime.now()

		if timeNow < GameUtil.string2time(self._curData.actCfg.additionalBuyStartTime) then
			FloatWordMgr.instance:show(langPara("%s后开启售卖", string.gsub(self._curData.actCfg.ordinaryBuyStartTime, "T", " ")))

			return
		end
	end

	local data1, data2, data3, num = PassportModel.instance:getCurDataList(true, self._curData.funcId)
	local goodId = self._curData.actCfg.additonalGoodsId

	if GameUtil.isEmptyString(data1[1]) then
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 1, self._curData.sldValue, nil, true, goodId)
	else
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 2, self._curData.sldValue, nil, true, goodId)
	end
end

function PassportWpAddView:_onClickGetExtra()
	if self._isAbleToGetExtra then
		if not self._ableToClick then
			return
		end

		if self._baoxiangEff then
			UIEffectManager.instance:stopEffect(self._baoxiangEff)

			self._baoxiangEff = nil
		end

		self._baoxiangEff = UIEffectManager.instance:playEffect(self, "fx_ui_tongxingzheng/fx_ui_tongxingzheng_baoxiangbaokai.prefab", self._btnGetExtra.gameObject.transform, 0, 0, false, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(self._btnGetExtra.gameObject.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
			eff:setScrollRectClipping(self._scrollRect)
		end)
		self._ableToClick = false

		removetimer(self._gainExtra, self)
		settimer(0.6, self._gainExtra, self, false)
	else
		CommonTipsMgr.instance:openTipsByConfStr(self._btnGetExtra.gameObject, self._extraPrize)
	end
end

function PassportWpAddView:_gainExtra()
	PassportController.instance:sendGainExtraPrize(self._curData.actId, self._curData.funcId)

	self._ableToClick = true
end

function PassportWpAddView:_refreshExtraPart()
	local extraCfg = PassportConfig.instance:getExtraPrizeCfgByActId(self._curData.actId)

	self._isAbleToGetExtra = self._curData.usefulProgress >= extraCfg.consumeProcess
	self._extraPrize = string.split(extraCfg.prize, "#")[1]
	self._txtProgressExtra.text = langPara("%s/%s", self._curData.usefulProgress, extraCfg.consumeProcess)

	if self._baoxiangEff then
		UIEffectManager.instance:stopEffect(self._baoxiangEff)

		self._baoxiangEff = nil
	end

	if self._isAbleToGetExtra then
		self._baoxiangEff = UIEffectManager.instance:playEffect(self, "fx_ui_tongxingzheng/fx_ui_tongxingzheng_baoxiang.prefab", self._btnGetExtra.gameObject.transform, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(self._btnGetExtra.gameObject.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
			eff:setScrollRectClipping(self._scrollRect)
		end)
	end
end

function PassportWpAddView:_onClickRuleExtra()
	UIStateManager.instance:push(ViewName.RulesView, "passportwpextraprize")
end

return PassportWpAddView
