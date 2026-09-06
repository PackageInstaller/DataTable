-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/view/MusicGameStageView.lua

module("logic.extensions.musicgame.view.MusicGameStageView", package.seeall)

local MusicGameStageView = class("MusicGameStageView", ViewComponent)

function MusicGameStageView:buildUI()
	MusicGameStageView.super.buildUI(self)

	self._diffScrView = self:getGo("diffCol/scrView")
	self._diffScrCell = self:getGo("diffCol/scrCell")
	self._diffScrollList = ScrollerList.create(self._diffScrView, self._diffScrCell, GameUtil.handler(self._updateDiffCell, self), GameUtil.handler(self._clearDiffCell, self))

	self._diffScrollList:setCenterMode(true)

	self._tipsRoot = self:getGo("tipsRoot")
	self._btnClose = self:getGo("btnClose")
end

function MusicGameStageView:bindEvents()
	MusicGameStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MusicGameStageView:unbindEvents()
	MusicGameStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MusicGameStageView:onEnter()
	MusicGameStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = MusicGameController.instance:getActivityType()

	local isInTime = MusicGameController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)
	self._musicGameMo = MusicGameController.instance:getMusicGameMo(self._activityId)
	self._actData = MusicGameConfig.instance:getActData(self._activityId)
	self._gamePlanId = self._actData.gamePlanId

	self.addGEvent(self, GlobalNotify.HandlePM_MusicGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MusicGameSweepRes, self._handlePM_MusicGameSweepRes, self)
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
	self:_onUpdate()
end

function MusicGameStageView:onExit()
	MusicGameStageView.super.onExit(self)
	self:_onClearDiffCol()
	AnnuityPrivilegeController.instance:closeAnnuityPrivilegeSweepTipsView()
end

function MusicGameStageView:destroyUI()
	MusicGameStageView.super.destroyUI(self)
end

function MusicGameStageView:_handlePM_MusicGameSweepRes(msg)
	local addScore = self._musicGameMo:getAddScore()

	FloatWordMgr.instance:show(string.format("扫荡成功！获得积分：%s", addScore))
	self:_onUpdate()
end

function MusicGameStageView:_onUpdate()
	self:_onUpdateDiffColUI()
end

function MusicGameStageView:_onUpdateDiffColUI()
	local cfg = MusicGameConfig.instance:getPlanCfg(self._gamePlanId)

	self._diffScrollList:reloadData(cfg)
end

function MusicGameStageView:_onClearDiffCol()
	self._diffScrollList:dispose()
end

function MusicGameStageView:_updateDiffCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtDiff = goutil.findChildTextComponent(mainGo, "txtDiff")
	local txtTips = goutil.findChildTextComponent(mainGo, "tips/txt")

	txtDiff.text = data.name

	local maxScore = 0

	for _, randomStageId in ipairs(data.randomStageIdList) do
		local stageData = MusicGameConfig.instance:getStageData(randomStageId)

		if not stageData.symbolScoreRate then
			local score = 0

			for dischargeType, field in ipairs(MusicGameEnum.DischargeTypeFields) do
				local count = stageData[field]

				score = score + count * dischargeType * stageData.symbolScoreRate
			end

			maxScore = Mathf.Max(maxScore, score)
		end
	end

	txtTips.text = string.format("该模式最高获得<color=#20b376>%s</color>积分", maxScore)

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickDiffBtnEnter, self, data.gameTypeId))
end

function MusicGameStageView:_clearDiffCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function MusicGameStageView:_onClickDiffBtnEnter(gameTypeId)
	local maxScore = self._musicGameMo:getMaxScore(gameTypeId)
	local isHasPassFirst = maxScore > 0

	if self._isBelongSweep and isHasPassFirst then
		local isInitInfo = YearCardModel.instance:isInitInfo()

		if not isInitInfo then
			FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

			return
		end

		local sweepResult = self:getTrySweepGameResultAndTips(false, self._activityId, gameTypeId, 1)

		if sweepResult == GameEnum.ResultCode.Success then
			local descTxt

			local function sureCallBack(view)
				self:_sweepGame(self._activityId, gameTypeId, view:getCurTimes())
			end

			local function cancelCallBack(view)
				self:_enterGame(self._activityId, gameTypeId)
			end

			local otherCallBack
			local maxCoinNum = self._musicGameMo:getMaxTimes()

			local function updateCoinTxtCallBack(view)
				view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxCoinNum)
			end

			local function updateDescTxtCallBack(view)
				view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>", maxScore * view:getCurTimes())
			end

			local left = self._musicGameMo:getLeftTimes()

			TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
		else
			self:_enterGame(self._activityId, gameTypeId)
		end
	else
		self:_enterGame(self._activityId, gameTypeId)
	end
end

function MusicGameStageView:_enterGame(activityId, gameTypeId)
	local result = self:getTryEnterGameResultAndTips(true, activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:close()

	local data = MusicGameConfig.instance:getPlanData(self._gamePlanId, gameTypeId)
	local randomIdx = Mathf.Random(1, #data.randomStageIdList)
	local stageId = data.randomStageIdList[randomIdx]

	MusicGameController.instance:startMusicGame(self._activityId, gameTypeId, stageId)
end

function MusicGameStageView:_sweepGame(activityId, gameTypeId, times)
	local result = self:getTrySweepGameResultAndTips(true, activityId, gameTypeId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	MusicGameController.instance:sendPM_MusicGameSweepReq(activityId, gameTypeId, times)
end

function MusicGameStageView:getTryEnterGameResultAndTips(isNeedTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and not MusicGameController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self._musicGameMo:getLeftTimes()

		if leftTimes <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "次数不足"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function MusicGameStageView:getTrySweepGameResultAndTips(isNeedTips, activityId, gameTypeId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and not MusicGameController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	end

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = self._musicGameMo:getLeftTimes()

		if leftTimes <= 0 or leftTimes < times then
			result = GameEnum.ResultCode.Error
			tips = "次数不足"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return MusicGameStageView
