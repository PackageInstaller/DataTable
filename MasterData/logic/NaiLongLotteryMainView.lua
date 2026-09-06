-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/view/NaiLongLotteryMainView.lua

module("logic.extensions.nailonglottery.view.NaiLongLotteryMainView", package.seeall)

local NaiLongLotteryMainView = class("NaiLongLotteryMainView", ViewComponent)
local TriggerTime = 3

function NaiLongLotteryMainView:buildUI()
	NaiLongLotteryMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._petView = self:getGo("petCol/view")
	self._petCell = self:getGo("petCol/cell")
	self._btnEnter = self:getGo("btnEnter")
	self._redBtnEnter = self:getGo("btnEnter/redPoint")
	self._txtLotteryTimes = self:getTxt("txtLotteryTimes")
	self._strTxtLotteryTimes = self._txtLotteryTimes.text
	self._txtDailyCanGet = self:getTxt("txtDailyCanGet")
	self._strTxtDailyCanGet = self._txtDailyCanGet.text
	self._btnGood = self:getGo("btnGood")
	self._btnLongPressHelper = BtnLongPressHelper.create(self._btnGood)
	self._goodCellList = {}

	for idx = 1, self._btnGood.transform.childCount do
		local mainGo = self._btnGood.transform:GetChild(idx - 1).gameObject
		local cell = {}

		cell._mainGo = mainGo
		cell._imgProgress = goutil.findChild(mainGo, "imgProgress")
		cell._imgComp = cell._imgProgress:GetComponent(ComponentType.Image)

		GameUtil.SetActive(cell._imgProgress, false)

		self._goodCellList[idx] = cell
	end

	self._prizeScrView = self:getGo("progressCol/scrView")
	self._prizeScrCell = self:getGo("progressCol/scrCell")
	self._sliderComp = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._txtNumPrize = self:getTxt("progressCol/total/txtNum")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrView, self._prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function NaiLongLotteryMainView:bindEvents()
	NaiLongLotteryMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)

	if self._btnLongPressHelper then
		self._btnLongPressHelper:addClickHandler(GameUtil.handler(self._onBtnPressClick, self))
		self._btnLongPressHelper:addPressStartHandler(GameUtil.handler(self._onBtnPressStart, self))
		self._btnLongPressHelper:addPressEndHandler(GameUtil.handler(self._onBtnPressEnd, self))
		self._btnLongPressHelper:addPressUpdateHandler(GameUtil.handler(self._onBtnPressUpdate, self))
		self._btnLongPressHelper:onPressTimeHandler(TriggerTime + 0.3, GameUtil.handler(self._onBtnPressUpdateTimeOverOnce, self))
	end
end

function NaiLongLotteryMainView:unbindEvents()
	NaiLongLotteryMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)

	if self._btnLongPressHelper then
		self._btnLongPressHelper:clearAllHandlers()
	end
end

function NaiLongLotteryMainView:onEnter()
	NaiLongLotteryMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = NaiLongLotteryController.instance:getActivityId()
	end

	self._activityType = NaiLongLotteryController.instance:getActivityType()

	local isInTime = NaiLongLotteryController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = NaiLongLotteryConfig.instance:getActData(self._activityId)
	self._naiLongLotteryMo = NaiLongLotteryController.instance:getNaiLongLotteryMo(self._activityId)

	local value = GameUtil.getUserData(string.format("NaiLongLottery_PressGood_%d", self._activityId))

	self._isNeedLongPressGood = checknumber(value) ~= 1

	self.addGEvent(self, GlobalNotify.HandlePM_ShareLotteryGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShareLotteryGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShareLotteryShareRes, self._onUpdate, self)
	NaiLongLotteryController.instance:sendPM_ShareLotteryGetInfoReq(self._activityId)
	self:_onSetUI()
	self:_onUpdate()
end

function NaiLongLotteryMainView:onExit()
	NaiLongLotteryMainView.super.onExit(self)
	self:_onClearPrizeCol()
	self:_onClearPetCol()
end

function NaiLongLotteryMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	self:_updateBtnGoodStateUI()
end

function NaiLongLotteryMainView:_onUpdate()
	self:_onUpdatePrizeCol()
	self:_onUpdatePetColUI()

	self._txtLotteryTimes.text = string.format(self._strTxtLotteryTimes, self._naiLongLotteryMo:getLotteryTimes())
	self._txtDailyCanGet.text = string.format(self._strTxtDailyCanGet, self._naiLongLotteryMo:getDailyShareCanLotteryTimes())

	local isHavePrize = self._naiLongLotteryMo:isHavePrizeCanGain()
	local isHaveTimes = self._naiLongLotteryMo:getLotteryTimes() > 0

	GameUtil.SetActive(self._redBtnEnter, isHavePrize and isHaveTimes)
end

function NaiLongLotteryMainView:_onUpdatePetColUI()
	local cfg = NaiLongLotteryConfig.instance:getProgressUnlockCfg(self._activityId) or {}

	GameUtil.updateCellsList(self._petView, self._petCell, cfg, self._updatePetCell, self)
end

function NaiLongLotteryMainView:_onClearPetCol()
	GameUtil.clearCells(self._petView, self._clearPetCell, self)
end

function NaiLongLotteryMainView:_updatePetCell(mainGo, data, index)
	local isLock = data.needProgress > self._naiLongLotteryMo:getGlobalShareTimes()
	local content = goutil.findChild(mainGo, "content")
	local con = goutil.findChild(mainGo, "content/con")
	local btnBg = goutil.findChild(mainGo, "content/btnBg")
	local txtTips = goutil.findChildTextComponent(mainGo, "content/txtTips")
	local lock = goutil.findChild(mainGo, "lock")
	local txtLock = goutil.findChildTextComponent(mainGo, "lock/txt")

	if data.pos then
		local pos = data.pos
		local x, y, scale, rz = checknumber(pos[1]), checknumber(pos[2]), pos[3] or 1, checknumber(pos[4])

		GameUtil.setLocalPos(mainGo, x, y, 0)
		GameUtil.setLocalScale(mainGo, scale, scale, scale)

		local rx, ry = GameUtil.getLocalRotation(mainGo)

		GameUtil.setLocalRotation(mainGo, rx, ry, rz)
	end

	GameUtil.SetActive(lock, isLock)
	GameUtil.SetActive(content, not isLock)

	if isLock then
		uGuiUtil.clearImage(con)
	else
		local spriteUrl = GameUrl.getBigbgPngUrl(data.bgName)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, spriteUrl)
	end

	GameUtil.addClickHandler(btnBg, function()
		UIStateManager.instance:push(ViewName.NaiLongLotteryBgView, data.boardName)
	end)

	txtLock.text = data.lockTips
	txtTips.text = data.desc
end

function NaiLongLotteryMainView:_clearPetCell(mainGo)
	local con = goutil.findChild(mainGo, "content/con")
	local btnBg = goutil.findChild(mainGo, "content/con")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(btnBg)
end

function NaiLongLotteryMainView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isCanGetPrize(data) then
			index = idx

			break
		elseif self:_isHasGainPrize(data) then
			index = idx
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._txtNumPrize.text = curProgress
end

function NaiLongLotteryMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function NaiLongLotteryMainView:_getProgressDataList()
	return NaiLongLotteryConfig.instance:getProgressPrizeCfg(self._activityId) or {}
end

function NaiLongLotteryMainView:_getSliderComp()
	return self._sliderComp
end

function NaiLongLotteryMainView:_getScrollRect()
	return self._prizeScrView:GetComponent(ComponentType.ScrollRect)
end

function NaiLongLotteryMainView:_getCurProgress()
	return self._naiLongLotteryMo:getGlobalShareTimes()
end

function NaiLongLotteryMainView:_getProgressByData(data)
	return checknumber(data.needShareCount)
end

function NaiLongLotteryMainView:_getPrizeIdByData(data)
	return data.prizeId
end

function NaiLongLotteryMainView:_getPrizeStrByData(data)
	return data.prize
end

function NaiLongLotteryMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._naiLongLotteryMo:isHasGainProgressPrize(prizeId)
end

function NaiLongLotteryMainView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._naiLongLotteryMo:isEnoughGetProgressPrize(prizeId)
end

function NaiLongLotteryMainView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._naiLongLotteryMo:isCanGetProgressPrize(prizeId)
end

function NaiLongLotteryMainView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(scrollRect)
			eff:setParent(effectRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._prizeEffPool[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectRoot, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function NaiLongLotteryMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function NaiLongLotteryMainView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	self:_onClickPrizeGetAll()
end

function NaiLongLotteryMainView:_onClickPrizeGetAll()
	local prizeIds = {}
	local dataList = self:_getProgressDataList()

	if dataList then
		for _, data in ipairs(dataList) do
			if self:_isCanGetPrize(data) then
				table.insert(prizeIds, self:_getPrizeIdByData(data))
			end
		end
	end

	if #prizeIds <= 0 then
		FloatWordMgr.instance:show("没有可领取的奖励")

		return
	end

	NaiLongLotteryController.instance:sendPM_ShareLotteryGainPrizeReq(self._activityId, prizeIds)
end

function NaiLongLotteryMainView:_onBtnPressClick()
	if not self._isNeedLongPressGood then
		UIStateManager.instance:push(ViewName.NaiLongLotteryShareView, self._activityId)
	end
end

function NaiLongLotteryMainView:_onBtnPressStart()
	for _, cell in ipairs(self._goodCellList) do
		if self._isNeedLongPressGood then
			GameUtil.SetActive(cell._imgProgress, true)

			cell._imgComp.fillAmount = 0
		else
			GameUtil.SetActive(cell._imgProgress, false)
		end
	end
end

function NaiLongLotteryMainView:_onBtnPressEnd(pressTime)
	for _, cell in ipairs(self._goodCellList) do
		GameUtil.SetActive(cell._imgProgress, false)
	end
end

function NaiLongLotteryMainView:_onBtnPressUpdateTimeOverOnce(pressTime)
	GameUtil.saveUserData(string.format("NaiLongLottery_PressGood_%s", self._activityId), 1)

	self._isNeedLongPressGood = false

	self:_updateBtnGoodStateUI()
	self:_onBtnPressClick()
end

function NaiLongLotteryMainView:_onBtnPressUpdate(deltaTime, pressTime)
	if not self._isNeedLongPressGood then
		return
	end

	local progress = Mathf.Min(pressTime / TriggerTime, 1)

	for _, cell in ipairs(self._goodCellList) do
		cell._imgComp.fillAmount = progress
	end
end

function NaiLongLotteryMainView:_updateBtnGoodStateUI()
	for _, cell in ipairs(self._goodCellList) do
		GameUtil.setUIGroupIdx(cell._mainGo, self._isNeedLongPressGood and 0 or 1)
		GameUtil.SetActive(cell._imgProgress, false)
	end
end

function NaiLongLotteryMainView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function NaiLongLotteryMainView:_onClickBtnEnter()
	UIStateManager.instance:push(ViewName.NaiLongLotteryPlayView, self._activityId)
end

return NaiLongLotteryMainView
