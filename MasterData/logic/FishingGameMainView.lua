-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/view/FishingGameMainView.lua

module("logic.extensions.fishinggame.view.FishingGameMainView", package.seeall)

local FishingGameMainView = class("FishingGameMainView", ViewComponent)

function FishingGameMainView:ctor()
	FishingGameMainView.super.ctor(self)
end

function FishingGameMainView:unbindEvents()
	FishingGameMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnImgTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function FishingGameMainView:bindEvents()
	FishingGameMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnImgTip, self._onClickBtnImgTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function FishingGameMainView:buildUI()
	FishingGameMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnImgTip = self:getGo("leftTop/btnImgTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._tipsRoot = self:getGo("tipsRoot")
	self._btnStart = self:getGo("progressCol/btnStart/btn")
	self._txtTimes = self:getTxt("progressCol/btnStart/desc/txt")
	self._txtNum = self:getTxt("progressCol/total/txtNum")
	self._scrView = self:getGo("progressCol/scrView")
	self._scrCell = self:getGo("progressCol/scrCell")
	self._progressBar = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._tableviewViewport = self:getGo("progressCol/scrView/Viewport")
	self._scrollList = ScrollerList.create(self._scrView, self._scrCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FishingGameMainView:onExit()
	FishingGameMainView.super.onExit(self)
	self._scrollList:dispose()
end

function FishingGameMainView:onEnter()
	FishingGameMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_FishingGameGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_FishingGameEndGameRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_FishingGameGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_FishingGameAnnuitySweepRes, self._handleSweepRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 607001
	end

	self._actCfg = FishingGameConfig.instance:getActivityCfg(self._activityId) or {}
	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)

	self:_onSetUI()
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
	FishingGameController.instance:sendPM_FishingGameGetInfoReq(self._activityId)
end

function FishingGameMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function FishingGameMainView:_onUpdate()
	self._info = FishingGameModel.instance:getInfo(self._activityId) or {}
	self._prizeCfgs = FishingGameConfig.instance:getPrizeCfgs(self._activityId) or {}
	self._curScore = checknumber(self._info.score)
	self._maxScore = checknumber(self._info.maxScore)
	self._gainPrizeIds = checktable(self._info.gainPrizeIds)

	local scoreList = {}
	local canGetIndex = -1

	for index, cfg in ipairs(self._prizeCfgs) do
		table.insert(scoreList, checknumber(cfg.needScore))

		local isCanGet = self._curScore >= checknumber(cfg.needScore)
		local isGainPrize = table.indexof(self._gainPrizeIds, cfg.prizeId) ~= false

		if isCanGet and not isGainPrize and canGetIndex == -1 then
			canGetIndex = index - 1
		end
	end

	self._txtNum.text = self._curScore

	self:_updateTimes()

	if self._scrollList then
		self._scrollList:updateUnderSlider(self._progressBar, self._curScore, scoreList)
		self._scrollList:reloadData(self._prizeCfgs)
		self._scrollList:MoveCellToCenter(canGetIndex == -1 and 0 or canGetIndex)
	end
end

function FishingGameMainView:_updateTimes()
	local todayTimes = checknumber(self._info.todayTimes)
	local dailyTimes = checknumber(self._actCfg.dailyTimes)

	self._txtTimes.text = string.format(lang("今日游戏次数：<color=#48B2F0FF>%s</color>/%s"), todayTimes, dailyTimes)
end

function FishingGameMainView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effectRoot = goutil.findChild(cell, "effectRoot")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")

	txtScore.text = data.needScore

	MaterialMgr.setCellByCfg(data.prize, item)

	local isCanGet = self._curScore >= checknumber(data.needScore)
	local isGainPrize = table.indexof(self._gainPrizeIds, data.prizeId) ~= false

	GameUtil.SetActive(received, isGainPrize)
	GameUtil.SetActive(btnGet, isCanGet and not isGainPrize)
	self:_clearCellEffect(effectRoot)

	if isCanGet and not isGainPrize then
		self:_playCellEffect(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function FishingGameMainView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effectRoot = goutil.findChild(cell, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:_clearCellEffect(effectRoot)
end

function FishingGameMainView:_playCellEffect(effectRoot)
	self:stopViewEffectUniGo(effectRoot)
	self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, self._tableviewViewport.transform, true, nil, nil)
end

function FishingGameMainView:_clearCellEffect(effectRoot)
	self:stopViewEffectUniGo(effectRoot)
end

function FishingGameMainView:_onClickGetPrize(data)
	local isCanGet = self._curScore >= checknumber(data.needScore)
	local isGainPrize = table.indexof(self._gainPrizeIds, data.prizeId) ~= false

	if isCanGet and not isGainPrize then
		FishingGameController.instance:sendPM_FishingGameGainPrizeReq(self._activityId, data.prizeId)
	elseif not isCanGet then
		TipsFacade.instance:openCommonTips(lang("还没有达到领取条件"))
	end
end

function FishingGameMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
end

function FishingGameMainView:_onClickBtnImgTip()
	local key = self._actCfg.ruleKeyImg

	TipsFacade.instance:openImageRuleViewByKey(key)
end

function FishingGameMainView:_onClickBtnStart()
	local isHasPassFirst = self._maxScore > 0

	if not self._isBelongSweep or not isHasPassFirst then
		self:_enterGame(self._activityId)

		return
	end

	local isInitInfo = YearCardModel.instance:isInitInfo()

	if not isInitInfo then
		FloatWordMgr.instance:show(lang("正在读取年费特权信息，请稍后再试"))

		return
	end

	local sweepResult = self:getTrySweepGameResultAndTips(false, self._activityId, 1)

	if sweepResult ~= GameEnum.ResultCode.Success then
		self:_enterGame(self._activityId)

		return
	end

	self:_showSweepChoiceDialog()
end

function FishingGameMainView:_showSweepChoiceDialog()
	local function sureCallBack(view)
		self:_sweepGame(self._activityId, view:getCurTimes())
	end

	local function cancelCallBack(view)
		self:_enterGame(self._activityId)
	end

	local maxCoinNum = checknumber(self._actCfg.dailyTimes)

	local function updateCoinTxtCallBack(view)
		view:getTxtCoin().text = string.format(lang("游戏次数：%s/%s"), view:getCurCoinNum(), maxCoinNum)
	end

	local passGetScore = self._maxScore

	local function updateDescTxtCallBack(view)
		local curTimes = view:getCurTimes()
		local score = passGetScore * curTimes

		view:getTxtDesc().text = string.format(lang("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>"), score)
	end

	local left = self:_getLeftTimes()

	TipsFacade.instance:openPopupCommonCostPopView(left, 1, lang("开始游戏"), lang("扫荡"), lang("直接开始"), nil, sureCallBack, cancelCallBack, nil, updateCoinTxtCallBack, updateDescTxtCallBack)
end

function FishingGameMainView:_enterGame(activityId)
	local leftTimes = self:_getLeftTimes()

	if leftTimes <= 0 then
		TipsFacade.instance:openCommonTips(lang("今日次数已经用完，下次再来吧"))

		return
	end

	UIStateManager.instance:push(ViewName.FishingGameView, activityId)
end

function FishingGameMainView:_sweepGame(activityId, times)
	local result = self:getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	FishingGameController.instance:sendPM_FishingGameAnnuitySweepReq(activityId, times)
end

function FishingGameMainView:getTrySweepGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
			tips = lang("不可扫荡")
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self:_getLeftTimes()

		if leftTimes <= 0 or leftTimes < times then
			result = GameEnum.ResultCode.Error
			tips = lang("次数不足")
		end
	end

	if isNeedTips and not string.nilorempty(tips) then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function FishingGameMainView:_getLeftTimes()
	local todayTimes = checknumber(self._info.todayTimes)
	local dailyTimes = checknumber(self._actCfg.dailyTimes)

	return dailyTimes - todayTimes
end

function FishingGameMainView:_handleSweepRes()
	FloatWordMgr.instance:show(lang("扫荡成功!"))
	self:_onUpdate()
end

return FishingGameMainView
