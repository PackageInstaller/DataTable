-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/view/HexLineupMainView.lua

module("logic.extensions.hexlineup.view.HexLineupMainView", package.seeall)

local HexLineupMainView = class("HexLineupMainView", ViewComponent)

function HexLineupMainView:buildUI()
	HexLineupMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._tipsRoot = self:getGo("tipsRoot")
	self._progressScrView = self:getGo("progressCol/scrView")
	self._progressScrCell = self:getGo("progressCol/scrCell")
	self._progressBar = self:getGo("progressCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._txtTotalScore = self:getTxt("progressCol/total/txtNum")
	self._iconTotal = self:getGo("progressCol/total/icon")
	self._progressScrollerList = ScrollerList.create(self._progressScrView, self._progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._btnStart = self:getGo("progressCol/btnStart/btn")
	self._txtStartDesc = self:getTxt("progressCol/btnStart/desc/txt")
	self._redPointStart = self:getGo("progressCol/btnStart/btn/redPoint")
	self._btnRank = self:getGo("btnRank")
	self._btnExt = self:getGo("btnExt")
end

function HexLineupMainView:bindEvents()
	HexLineupMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnExt, self._onClickBtnExt, self)
end

function HexLineupMainView:unbindEvents()
	HexLineupMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnExt)
end

function HexLineupMainView:onEnter()
	HexLineupMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = HexLineupController.instance:getActivityId()
	end

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._subMo = HexLineupController.instance:getSubMo(self._activityId)
	self._actData = HexLineupConfig.instance:getActivityData(self._activityId)
	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_HexLineupGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HexLineupGainPrizeRes, self._onUpdateProgressCol, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HexLineupEndGameRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HexLineupSweepRes, self._onUpdate, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
	HexLineupController.instance:sendPM_HexLineupGetInfoReq(self._activityId)
	self:_onUpdate()
end

function HexLineupMainView:onExit()
	HexLineupMainView.super.onExit(self)
	self:_onClearProgressCol()
end

function HexLineupMainView:_onUpdate()
	self:_onUpdateProgressCol()
	self:_onUpdateStartBtn()
end

function HexLineupMainView:_getProgressDataList()
	return HexLineupConfig.instance:getProgressPrizeDatas(self._activityId) or {}
end

function HexLineupMainView:_onUpdateProgressCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self._subMo:getTotalScore()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, checknumber(data.progress))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if not self._subMo:isHasGainPrize(data.prizeId) then
			index = idx - 1

			break
		end
	end

	self._progressScrollerList:reloadData(dataList)
	self._progressScrollerList:updateUnderSlider(self._sliderComp, curProgress, scoreList)
	self._progressScrollerList:MoveCellToCenter(index)

	self._txtTotalScore.text = curProgress
end

function HexLineupMainView:_onClearProgressCol()
	self._progressScrollerList:dispose()
end

function HexLineupMainView:_updateProgressCell(view, cell, data, tag)
	local prizeId = data.prizeId
	local isHasGain = self._subMo:isHasGainPrize(prizeId)
	local isCanGet = self._subMo:isCanGetPrize(prizeId)
	local progress = checknumber(data.progress)
	local prizeStr = data.prize
	local scrollRect = self._progressScrView:GetComponent(ComponentType.ScrollRect)
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

	if isCanGet then
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function HexLineupMainView:_clearProgressCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function HexLineupMainView:_onClickPrizeGet(data)
	local prizeId = data.prizeId

	if self._subMo:isHasGainPrize(prizeId) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self._subMo:isEnoughGetPrize(prizeId) then
		FloatWordMgr.instance:show("积分不足")

		return
	end

	HexLineupController.instance:sendPM_HexLineupGainPrizeReq(self._activityId, {
		prizeId
	})
end

function HexLineupMainView:_onUpdateStartBtn()
	local leftTimes = self._subMo:getLeftDailyTimes()
	local dailyLimit = self._subMo:getDailyGameLimit()

	self._txtStartDesc.text = string.format("今日剩余次数: %s/%s", leftTimes, dailyLimit)
end

function HexLineupMainView:_onClickBtnTip()
	local key = self._actData.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function HexLineupMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.HexLineupRankView, self._activityId)
end

function HexLineupMainView:_onClickBtnStart()
	local maxScore = self._subMo:getLimitModeMaxScore()
	local isHasPassFirst = maxScore > 0

	if not self._isBelongSweep or not isHasPassFirst then
		self:_enterGame(self._activityId)

		return
	end

	if not YearCardModel.instance:isInitInfo() then
		FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

		return
	end

	local sweepResult = self:_getTrySweepGameResultAndTips(false, self._activityId, 1)

	if sweepResult ~= GameEnum.ResultCode.Success then
		self:_enterGame(self._activityId)

		return
	end

	self:_showSweepChoiceDialog(maxScore)
end

function HexLineupMainView:_onClickBtnExt()
	HexLineupController.instance:startGame(self._activityId, HexLineupEnum.ModeId_Endless)
end

function HexLineupMainView:_showSweepChoiceDialog(maxScore)
	local function sureCallBack(view)
		self:_sweepGame(self._activityId, view:getCurTimes())
	end

	local function cancelCallBack(view)
		self:_enterGame(self._activityId)
	end

	local dailyLimit = self._subMo:getDailyGameLimit()

	local function updateCoinTxtCallBack(view)
		view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), dailyLimit)
	end

	local function updateDescTxtCallBack(view)
		view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n每次扫荡可获得积分：%s x <color=#0068b7>%s</color>", maxScore, view:getCurTimes())
	end

	local left = self._subMo:getLeftDailyTimes()

	TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", nil, sureCallBack, cancelCallBack, nil, updateCoinTxtCallBack, updateDescTxtCallBack, true)
end

function HexLineupMainView:_enterGame(activityId)
	local result = self:_getTryEnterGameResultAndTips(true, activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	HexLineupController.instance:startGame(activityId, HexLineupEnum.ModeId_Limit)
end

function HexLineupMainView:_sweepGame(activityId, times)
	local result = self:_getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	HexLineupController.instance:sendPM_HexLineupSweepReq(activityId, times)
end

function HexLineupMainView:_getTryEnterGameResultAndTips(isNeedTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local left = self._subMo:getLeftDailyTimes()

		if left <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "今日次数已用完"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function HexLineupMainView:_getTrySweepGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			tips = "不可扫荡"
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		result = self:_getTryEnterGameResultAndTips(isNeedTips, activityId)
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return HexLineupMainView
