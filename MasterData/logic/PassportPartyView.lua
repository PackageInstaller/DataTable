-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportPartyView.lua

module("logic.extensions.passport.view.PassportPartyView", package.seeall)

local PassportPartyView = class("PassportPartyView", ViewComponent)

function PassportPartyView:buildUI()
	PassportPartyView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnHelp = self:getGo("btnHelp")
	self._btnOneKey = self:getGo("btnOneKey")
	self._rpOneKey = goutil.findChild(self._btnOneKey, "rp")
	self._timeTips = self:getGo("timeTips")
	self._txtTimeTips = self:getTxt("timeTips/txt")
	self._txtTips = self:getTxt("Tips")
	self._btnClose = self:getGo("btnClose")
	self._sldProgress = self:getSlider("tableview/Viewport/Content/sldProgress")
	self._retProress = self._sldProgress.gameObject:GetComponent("RectTransform")
	self._retProress.offsetMin = UnityEngine.Vector2.New(70, -50)
	self._retProress.offsetMax = UnityEngine.Vector2.New(-384, -40)
	self._txtProgress = self:getTxt("txtProgress")
	self._pos = goutil.findChild(self._sldProgress.gameObject, "handleRect/pos")
	self._playerPos = goutil.findChild(self._sldProgress.gameObject, "playerPos")
	self._handleGo = goutil.findChild(self._sldProgress.gameObject, "handleRect")
	self._scrollRect = self._goTable:GetComponent(ComponentType.ScrollRect)
	self._extraPart = self:getGo("extraPart")
	self._btnGetExtra = self:getBtn("extraPart/btnGet")
	self._btnRuleExtra = self:getBtn("extraPart/btnRule")
	self._txtProgressExtra = self:getTxt("extraPart/txtProgress")
	self._btnPay = self:getGo("pay/btn")
	self._goPay = self._btnPay
	self._showcell = self:getGo("showcell")
	self._txtProgress1 = goutil.findChildTextComponent(self._showcell, "progress/txtProgress")
	self._txtProgress2 = goutil.findChildTextComponent(self._showcell, "progress2/txtProgress")
	self._showItem_1 = goutil.findChild(self._showcell, "item_1")
	self._showItem_2 = goutil.findChild(self._showcell, "item_2")
end

function PassportPartyView:bindEvents()
	PassportPartyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnGetExtra, self._onClickGetExtra, self)
	GameUtil.addClickHandler(self._btnRuleExtra, self._onClickRuleExtra, self)
	GameUtil.addClickHandler(self._btnPay, self._onClickPay, self)
end

function PassportPartyView:unbindEvents()
	PassportPartyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnGetExtra)
	GameUtil.rmClickHandler(self._btnRuleExtra)
	GameUtil.rmClickHandler(self._btnPay)
end

function PassportPartyView:onEnter()
	PassportPartyView.super.onEnter(self)

	self._passPortFuncId = 9

	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PassportExtraPrizeUpdate, self._refreshExtraPart, self)
	PassportController.instance:sendGetInfoReq(self._passPortFuncId)
	self:_resetActTimePart()
	self._sldProgress:SetValue(0)

	self._txtProgress.text = ""

	goutil.setActive(self._extraPart, false)

	self._ableToClick = true

	local path = "20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"

	self._spine = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		eff:setParent(self._playerPos.transform)
		eff:setScale(0.2)
		eff:setLocalPos(0, -20, 0)
		RoleObjectPool.instance:playAnimation(eff.effGo, "idle", true)
	end)
end

function PassportPartyView:onExit()
	PassportPartyView.super.onExit(self)
	self._tableView:dispose()
	self:_resetActTimePart()
	removetimer(self._gainExtra, self)
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PassportExtraPrizeUpdate, self._refreshExtraPart, self)
	removetimer(self._resetPlayerPos, self)
	MaterialMgr.resetAll(self._showItem_1)
	MaterialMgr.resetAll(self._showItem_2)

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end

	if self._spine then
		UIEffectManager.instance:stopEffect(self._spine)

		self._spine = nil
	end

	self._showId = nil
end

function PassportPartyView:_refreshView()
	self._curData = PassportModel.instance:getInfo(self._passPortFuncId)

	local dataList = self:_getCurDataList()

	self._tableView:reloadData(dataList)
	self:_setActTimePart()
	self._sldProgress:SetValue(self._curData.sldValue)

	self._txtProgress.text = self._curData.progressTxt
	self._txtTips.text = self._curData.funcCfg.progressTips

	goutil.setActive(self._btnBuy, self._curData.progressAbletToBuy > 0)
	self:_refreshExtraPart()
	self:_refreshOneKey()
	self:_refreshPayBtn()
	self._tableView:MoveCellToCenter(self._curData.unlockIndex)
	self:_dealPlayerPos()
end

function PassportPartyView:_refreshPayBtn()
	goutil.setActive(self._goPay, not self._curData.hasPay)
end

function PassportPartyView:_refreshOneKey()
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
	end

	goutil.setActive(self._rpOneKey, self._ableToGetOneKey)
end

function PassportPartyView:_resetActTimePart()
	removetimer(self._onCountDonw, self)
	removetimer(self._movePlayer, self)
	goutil.setActive(self._timeTips, false)
end

function PassportPartyView:_setActTimePart()
	self:_resetActTimePart()
	self:_onCountDonw()
	settimer(1, self._onCountDonw, self)
	goutil.setActive(self._timeTips, true)
end

function PassportPartyView:_onCountDonw()
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

function PassportPartyView:_getCurDataList()
	local dataList = {}
	local data = {}

	data.id = index
	data.progressKey = 0
	data.freeState = true
	data.superState = true

	table.insert(dataList, data)

	self._prizeNums = 0

	for index, v in ipairs(self._curData.prizeCfgs) do
		local data = {}

		data.id = index
		data.progressKey = v.thresholdParam
		data.freePrize = v.freePrize
		data.payedPrize = v.payedPrize
		data.freeState = self._curData.normalPrizeState[index]
		data.superState = self._curData.superPrizeState[index]
		data.isLast = false

		table.insert(dataList, data)

		self._prizeNums = self._prizeNums + 1
	end

	dataList[#dataList].isLast = true

	table.insert(dataList, {})

	return dataList
end

function PassportPartyView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if not string.nilorempty(data.freePrize) then
		local proxy_1 = MaterialMgr.setCellByCfg(data.freePrize, cell.itemList[1].item)

		goutil.setActive(cell.itemList[1].mark, data.freeState)

		if not data.freeState and data.id < self._curData.unlockIndex then
			goutil.setActive(cell.itemList[1].rp, true)
			self:_playCellEff(cell.itemList[1].item)
			proxy_1:setAutoTips(false)
			proxy_1:setCallBack(function()
				PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false)
			end)
		end
	end

	if not string.nilorempty(data.payedPrize) then
		local proxy_2 = MaterialMgr.setCellByCfg(data.payedPrize, cell.itemList[2].item)

		goutil.setActive(cell.itemList[2].mark, data.superState)

		if not data.superState and data.id < self._curData.unlockIndex then
			goutil.setActive(cell.itemList[2].rp, true)
			proxy_2:setAutoTips(false)
			self:_playCellEff(cell.itemList[2].item)
			proxy_2:setCallBack(function()
				if self._curData.hasPay then
					PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, true)
				else
					self:_onClickPay()
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

		local pos = GameUtil.getLocalPos(self._extraPart)

		GameUtil.setLocalPos(self._extraPart, 20, pos.y, pos.z)
		goutil.setActive(self._extraPart, true)
	else
		local extraPart = goutil.findChild(cell.go, "extraPart")

		if extraPart then
			goutil.addChildToParent(self._extraPart, self.mainGO)
			goutil.setActive(self._extraPart, false)
		end
	end

	self:_refreshShowCell(self._tableView._tableview:GetCurrentIndex() + 1)
end

function PassportPartyView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.com = goutil.findChild(cell.go, "com")
	cell.txtProgrss = goutil.findChildTextComponent(cell.com, "txtProgress")
	cell.itemList = {}

	for i = 1, 2 do
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

function PassportPartyView:_refreshShowCell(dataId)
	if self._curData.prizeCfgs[dataId] then
		if self._showId ~= self._curData.prizeCfgs[dataId] then
			self._showId = self._curData.prizeCfgs[dataId]

			local data = self._curData.prizeCfgs[self._showId]

			if data then
				MaterialMgr.resetAll(self._showItem_1)
				MaterialMgr.resetAll(self._showItem_2)
				MaterialMgr.setCellByCfg(data.freePrize, self._showItem_1)
				MaterialMgr.setCellByCfg(data.payedPrize, self._showItem_2)

				self._txtProgress1.text = langPara("%s勋章奖励", data.thresholdParam)
				self._txtProgress2.text = langPara("%s勋章奖励", data.thresholdParam)

				goutil.setActive(self._showcell, true)
			else
				goutil.setActive(self._showcell, false)
			end
		end
	end
end

function PassportPartyView:_onClickHelp()
	ViewMgr.instance:open(ViewName.RulesView, self._curData.funcCfg.rule)
end

function PassportPartyView:_onClickOneKey()
	if self._ableToGetOneKey then
		PassportController.instance:sendOneKeyGainPrizeReq(self._curData.actId, self._curData.funcId)

		return
	end

	if not self._curData.hasPay then
		self:_onClickPay()

		return
	end

	FloatWordMgr.instance:show(lang("当前无可领取奖励"))
end

function PassportPartyView:_playCellEff(go)
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

function PassportPartyView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function PassportPartyView:_onClickPay()
	local data1, data2, data3, num = PassportModel.instance:getCurDataList(nil, self._curData.funcId)

	if GameUtil.isEmptyString(data1[1]) then
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 1, self._curData.sldValue)
	else
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 2, self._curData.sldValue)
	end
end

function PassportPartyView:_onClickGetExtra()
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

function PassportPartyView:_gainExtra()
	PassportController.instance:sendGainExtraPrize(self._curData.actId, self._curData.funcId)

	self._ableToClick = true
end

function PassportPartyView:_refreshExtraPart()
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

function PassportPartyView:_onClickRuleExtra()
	UIStateManager.instance:push(ViewName.RulesView, "passportwpextraprize")
end

function PassportPartyView:_resetPlayerPos()
	goutil.addChildToParent(self._playerPos, self._pos)
	GameUtil.setAnchoredPos(self._playerPos, 0, 0)
	PassportModel.instance:setLastSldValue(self._curData.sldValue)

	if self._spine then
		RoleObjectPool.instance:playAnimation(self._spine.effGo, "idle", true)
	end
end

function PassportPartyView:_dealPlayerPos()
	self._lastSldValue = PassportModel.instance:getLastSldValue()

	if self._lastSldValue and self._lastSldValue < self._curData.sldValue then
		self:_dealMove()
	else
		self:_resetPlayerPos()
	end
end

function PassportPartyView:_dealMove()
	self._sldProgress:SetValue(self._lastSldValue)
	goutil.addChildToParent(self._playerPos, self._pos)
	self._playerPos.transform:SetParent(self._sldProgress.gameObject.transform)
	self._sldProgress:SetValue(self._curData.sldValue)

	self._curMoveSteps = math.floor((self._curData.sldValue - self._lastSldValue) * self._prizeNums)

	PassportModel.instance:setLastSldValue(self._curData.sldValue)
	self:_movePlayer()
end

function PassportPartyView:_movePlayer()
	self._playerPos.transform:SetParent(self._handleGo.transform)

	local moveTimer = 2 * self._curMoveSteps
	local tween = self._playerPos.transform:DOLocalMove(self._pos.transform.localPosition, moveTimer):SetEase(DG.Tweening.Ease.Linear)

	self._tweenList = self._tweenList or {}

	table.insert(self._tweenList, tween)

	if self._spine then
		RoleObjectPool.instance:playAnimation(self._spine.effGo, "run", true)
	end

	settimer(moveTimer, self._resetPlayerPos, self, false)
end

return PassportPartyView
