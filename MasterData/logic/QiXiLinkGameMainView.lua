-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qixilinkgame/view/QiXiLinkGameMainView.lua

module("logic.extensions.qixilinkgame.view.QiXiLinkGameMainView", package.seeall)

local QiXiLinkGameMainView = class("QiXiLinkGameMainView", ViewComponent)

function QiXiLinkGameMainView:ctor()
	QiXiLinkGameMainView.super.ctor(self)
end

function QiXiLinkGameMainView:unbindEvents()
	QiXiLinkGameMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function QiXiLinkGameMainView:bindEvents()
	QiXiLinkGameMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickDiffBtnEnter, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function QiXiLinkGameMainView:buildUI()
	QiXiLinkGameMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._tipsRoot = self:getGo("tipsRoot")
	self._txtPlayTimes = self:getTxt("playTimes/txt")
	self._tableViewport = self:getGo("scorollReward/tableview/viewport")
	self._tableview = self:getGo("scorollReward/tableview")
	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
	self._btnStart = self:getGo("btnStart")
end

function QiXiLinkGameMainView:onExit()
	QiXiLinkGameMainView.super.onExit(self)
	self._scrollList:dispose()
end

function QiXiLinkGameMainView:onEnter()
	QiXiLinkGameMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_LinkendlessGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_LinkendlessGameSweepRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_LinkendlessGameGainProgressPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_LinkendlessGameStartGameRes, self._onStartGameRes, self)
	self.addGEvent(self, GlobalNotify.AnnuityInfoChange, self._onAnnuityInfoChangeRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 394002
	end

	self._actCfg = QiXiLinkGameConfig.instance:getGameActCfg(self._activityId)
	self._ruleId = checknumber(self._actCfg.ruleId or 1)
	self._rewardCfg = QiXiLinkGameConfig.instance:getPrizeCfgs(self._activityId)
	self._curAnnuityId = 8005
	self._hasGetAnnuityInfo = false
	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)

	self:_onSetUI()
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
	QiXiLinkGameController.instance:sendPM_LinkendlessGameInfoReq(self._activityId)
	YearCardController.instance:getUserAnnuityInfo()
end

function QiXiLinkGameMainView:_onUpdate()
	self._info = QiXiLinkGameModel.instance:getInfo(self._activityId)

	if not self._info.gainPrizeIds then
		if not self._info.totalScore then
			local totalScore = 0
			local dailyGameTimes = self._actCfg.dailyTimes
			local todayGameTimes = self._info.dailyTimes
			local leftGameTime = dailyGameTimes - todayGameTimes
			local list = QiXiLinkGameConfig.instance:getPrizeCfgs(self._activityId)

			self._scrollList:reloadData(list)

			self._txtProgress.text = totalScore
			self._txtPlayTimes.text = "剩余游戏次数:" .. leftGameTime .. "/" .. dailyGameTimes

			GameUtil.SetActive(self._redpoint, todayGameTimes < dailyGameTimes)

			local scoreList = {}

			for i, v in ipairs(list) do
				table.insert(scoreList, v.score)
			end

			self._scrollList:updateUnderSlider(self._progressSlider, self._info.totalScore, scoreList)
		end
	end
end

function QiXiLinkGameMainView:_onSetUI()
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function QiXiLinkGameMainView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local hasGet = false

	if not self._info.totalScore then
		local finishIds = {}
		local isCanGet = finishIds >= data.score

		if not self._info.gainPrizeIds then
			local gainPrizeIds = {}

			hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false
			txtScore.text = data.score

			MaterialMgr.setCellByCfg(data.prize, item)
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

function QiXiLinkGameMainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

function QiXiLinkGameMainView:_playCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effGo, self._tableViewport.transform, true, nil, nil)
end

function QiXiLinkGameMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		self:stopViewEffectUniGo(effGo)

		self._cellEffects[effGo] = nil
	end
end

function QiXiLinkGameMainView:_onClickDiffBtnEnter()
	local hasPlayTime = QiXiLinkGameModel.instance:getTodayGameTimes(self._activityId)
	local maxCanPlayTime = self._actCfg.dailyTimes

	if maxCanPlayTime <= hasPlayTime then
		FloatWordMgr.instance:show("您已达最大游戏次数，明天再来吧")

		return
	end

	local isInitInfo = YearCardModel.instance:isInitInfo()

	if not isInitInfo and not self._hasGetAnnuityInfo then
		FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

		return
	end

	if self._isYearPLayer then
		local isHasPassFirst = self._info.maxScore > 0

		if self._isBelongSweep and isHasPassFirst then
			local sweepResult = self:_getTrySweepGameResultAndTips(true, self._activityId, 1)

			if sweepResult == GameEnum.ResultCode.Success then
				local descTxt = "您已首通完毕，是否扫荡直接通关？"

				local function sureCallBack(view)
					self:_sweepGame(self._activityId, view:getCurTimes())
				end

				local function cancelCallBack(view)
					self:_onBtnStart()
				end

				local otherCallBack
				local maxCoinNum = self._actCfg.dailyTimes

				local function updateCoinTxtCallBack(view)
					view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxCoinNum)
				end

				local historyMaxScore = QiXiLinkGameModel.instance:getHistoryMaxScore(self._activityId)

				local function updateDescTxtCallBack(view)
					view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>", historyMaxScore * view:getCurTimes())
				end

				local left = self:_getLeftTimes()

				TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
			end
		else
			self:_onBtnStart()
		end
	else
		self:_onBtnStart()
	end
end

function QiXiLinkGameMainView:_getTrySweepGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isInActTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

		if not isInActTime then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间内"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self:_getLeftTimes()

		if leftTimes <= 0 or leftTimes < times then
			result = GameEnum.ResultCode.Error
			tips = "已达每日游戏最大次数"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function QiXiLinkGameMainView:_getLeftTimes()
	local maxTime = self._actCfg.dailyTimes
	local curTime = QiXiLinkGameModel.instance:getTodayGameTimes(self._activityId)

	return maxTime - curTime
end

function QiXiLinkGameMainView:_sweepGame(activityId, times)
	local result = self:_getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	QiXiLinkGameController.instance:sendPM_LinkendlessGameSweepReq(activityId, times)
end

function QiXiLinkGameMainView:_onBtnStart()
	QiXiLinkGameController.instance:sendPM_LinkendlessGameStartGameReq(self._activityId)
end

function QiXiLinkGameMainView:_onClickGetPrize(data)
	if not self._info.gainPrizeIds then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

		if not hasGet then
			if not self._info.totalScore then
				local finishIds = {}
				local isCanGet = finishIds >= data.score

				if isCanGet then
					QiXiLinkGameController.instance:sendPM_LinkendlessGameGainProgressPrizeReq(self._activityId, data.prizeId)
				else
					TipsFacade.instance:openCommonTips("还没达到条件哦~")
				end
			end
		end
	end
end

function QiXiLinkGameMainView:_onStartGameRes()
	UIStateManager.instance:push(ViewName.QiXiLinkGameView, self._activityId, 394002)
end

function QiXiLinkGameMainView:_onClickRule()
	local ruleCfg = QiXiLinkGameConfig.instance:getGameRuleCfgs(self._ruleId or 1)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade:openImageRuleView(ruleList, "游戏规则")
end

function QiXiLinkGameMainView:_onAnnuityInfoChangeRes()
	self._hasGetAnnuityInfo = true

	local annuityInfo = YearCardModel.instance:getAnnuityInfo(self._curAnnuityId)

	self._isYearPLayer = annuityInfo.active
end

return QiXiLinkGameMainView
