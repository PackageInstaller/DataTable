-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallMainView.lua

module("logic.extensions.pinball.view.PinBallMainView", package.seeall)

local PinBallMainView = class("PinBallMainView", ViewComponent)

function PinBallMainView:ctor()
	PinBallMainView.super.ctor(self)
end

function PinBallMainView:unbindEvents()
	PinBallMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGame)
	GameUtil.rmClickHandler(self._btnWeed)
end

function PinBallMainView:bindEvents()
	PinBallMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnGame, self._onClickBtnGame, self)
	GameUtil.addClickHandler(self._btnWeed, self._onClickBtnWeed, self)
end

function PinBallMainView:buildUI()
	PinBallMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("time/txt")
	self._tipsRoot = self:getGo("tipsRoot")
	self._btnGame = self:getGo("btnGame")
	self._btnWeed = self:getGo("btnWeed")
	self._txtGameTime = self:getTxt("txtGameTime")
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
	self._tableview = self:getGo("scorollReward/tableview")
	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableviewViewport = self:getGo("scorollReward/tableview/viewport")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PinBallMainView:onExit()
	PinBallMainView.super.onExit(self)
	self._scrollList:dispose()
end

function PinBallMainView:onEnter()
	PinBallMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PinBallGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_PinBallGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PinBallSweepRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 554001
	end

	self._actCfg = PinBallConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = PinBallConfig.instance:getStageCfgs(self._activityId)
	self._stageId = 1
	self._prizeCfg = PinBallConfig.instance:getPrizeCfgs(self._activityId)
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	PinBallController.instance:sendPM_PinBallGetInfoReq(self._activityId)
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
end

function PinBallMainView:_onUpdate()
	self._info = PinBallModel.instance:getInfo(self._activityId)
	self._stageId = self._info.lastStageId + 1
	self._stageId = (self._stageId - 1) % #self._stageCfgs + 1
	self._txtProgress.text = self._info.totalScore
	self._txtGameTime.text = string.format("今日剩余游戏次数：%d/%d", self._actCfg.dailyGameLimit - self._info.todayGameTimes, self._actCfg.dailyGameLimit)

	local scoreList = {}

	for i, v in ipairs(self._prizeCfg) do
		table.insert(scoreList, v.progress)
	end

	self._scrollList:updateUnderSlider(self._progressSlider, self._info.totalScore, scoreList)
	self._scrollList:reloadData(self._prizeCfg)
end

function PinBallMainView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local hasGet = false

	txtScore.text = data.progress

	MaterialMgr.setCellByCfg(data.prize, item)

	if self._info then
		local finishIds = self._info.totalScore
		local isCanGet = finishIds >= data.progress

		if not self._info.gainPrizeIds then
			local gainPrizeIds = {}

			hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

			GameUtil.SetActive(geted, hasGet)
			GameUtil.SetActive(btnGet, isCanGet and not hasGet)
			self:_clearCellEffect(effect)

			if isCanGet and not hasGet then
				self:_playCellEffect(effect)
			end

			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
		end
	end
end

function PinBallMainView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

function PinBallMainView:_playCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)

	local eff = self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effGo, self._tableviewViewport.transform, true, nil, nil)
end

function PinBallMainView:_clearCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

function PinBallMainView:_onClickGetPrize(data)
	if not self._info.gainNormalPrizeIds then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

		if not hasGet then
			local finishIds = checknumber(self._info.totalScore)
			local isCanGet = finishIds >= data.progress

			if isCanGet then
				PinBallController.instance:sendPM_PinBallGainPrizeReq(self._activityId, {
					data.prizeId
				})
			else
				TipsFacade.instance:openCommonTips("还没达到条件哦~")
			end
		end
	end
end

function PinBallMainView:_onClickBtnGame()
	local hasPlayTime = self._info.todayGameTimes < self._actCfg.dailyGameLimit

	if not hasPlayTime then
		FloatWordMgr.instance:show("今日游戏次数已达上限")

		return
	end

	if not YearCardModel.instance:isInitInfo() then
		FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

		return
	end

	local sweepResult = self:_getTrySweepGameResultAndTips(false, self._activityId)

	if sweepResult == GameEnum.ResultCode.Success then
		self:_showSweepChoiceDialog()

		return
	end

	self:_enterGame()
end

function PinBallMainView:_enterGame()
	UIStateManager.instance:push(ViewName.PinBallGameView, self._activityId, self._stageId)
end

function PinBallMainView:_onClickBtnWeed()
	local jumpStr = self._actCfg.jumpTo[1]

	GotoMgr.gotoByString(jumpStr)
end

function PinBallMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function PinBallMainView:_getTrySweepGameResultAndTips(isNeedTips, activityId)
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

	if result == GameEnum.ResultCode.Success then
		result = self._info.totalScore > 0 and GameEnum.ResultCode.Success or GameEnum.ResultCode.Error
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function PinBallMainView:_showSweepChoiceDialog()
	local function sureCallBack(view)
		self:_sweepGame(self._activityId, view:getCurTimes())
	end

	local function cancelCallBack(view)
		self:_enterGame()
	end

	local maxGameTimes = self._actCfg.dailyGameLimit

	local function updateCoinTxtCallBack(view)
		view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxGameTimes)
	end

	local function updateDescTxtCallBack(view)
		view:getTxtDesc().text = "您已首通完毕，是否扫荡获得进度？"
	end

	local left = self._actCfg.dailyGameLimit - self._info.todayGameTimes

	TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", nil, sureCallBack, cancelCallBack, nil, updateCoinTxtCallBack, updateDescTxtCallBack, true)
end

function PinBallMainView:_sweepGame(activityId, times)
	local result = self:_getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	PinBallAgent.instance:sendPM_PinBallSweepReq(activityId, times)
end

function PinBallMainView:_getTryEnterGameResultAndTips(isNeedTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local left = self._actCfg.dailyGameLimit - self._info.todayGameTimes

		if left <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "剩余游戏次数不足"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return PinBallMainView
