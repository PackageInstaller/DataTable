-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/view/IceQiBuGameMainView.lua

module("logic.extensions.iceqibugame.view.IceQiBuGameMainView", package.seeall)

local IceQiBuGameMainView = class("IceQiBuGameMainView", ViewComponent)

function IceQiBuGameMainView:ctor()
	IceQiBuGameMainView.super.ctor(self)
end

function IceQiBuGameMainView:buildUI()
	IceQiBuGameMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._tipsRoot = self:getGo("tipsRoot")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._con = self:getGo("con")
	self._btnStart = self:getGo("btnStart/btn")
	self._redBtnStart = self:getGo("btnStart/btn/red")
	self._txtDescBtnStart = self:getTxt("btnStart/desc/txt")

	local prizeScrView = self:getGo("prizeCol/scrView")
	local prizeScrCell = self:getGo("prizeCol/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function IceQiBuGameMainView:bindEvents()
	IceQiBuGameMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function IceQiBuGameMainView:unbindEvents()
	IceQiBuGameMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function IceQiBuGameMainView:onEnter()
	IceQiBuGameMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = IceQibuGameController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = IceQibuGameController.instance:getSubMo(self._activityId)
	self._actData = IceQibuGameConfig.instance:getActivityData(self._activityId)
	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_onUpdatePrizeColUI()
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)

	local skinId = 11033
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, modelCfg[1], y)

				self.addGEvent(self, GlobalNotify.HandlePM_IceQibuGameInfoRes, self._onUpdate, self)
				self.addGEvent(self, GlobalNotify.HandlePM_IceQibuGameEndGameRes, self._onUpdate, self)
				self.addGEvent(self, GlobalNotify.HandlePM_IceQibuGameSweepRes, self._onUpdate, self)
				IceQibuGameController.instance:sendPM_IceQibuGameInfoReq(self._activityId)
				self:_onUpdate()
			end
		end
	end
end

function IceQiBuGameMainView:onExit()
	IceQiBuGameMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	self:_onClearPrizeCol()
end

function IceQiBuGameMainView:_onUpdate()
	local left = self._subMo:getLeftGameTimes()
	local max = self._subMo:getMaxGameTimes()

	self._txtDescBtnStart.text = left > 0 and string.format("今日奖励次数：<color=#20b376>%s</color>/%s", left, max) or string.format("今日奖励次数：%s/%s", left, max)

	GameUtil.SetGray(self._btnStart, left <= 0)
end

function IceQiBuGameMainView:_onUpdatePrizeColUI()
	local cfg = IceQibuGameConfig.instance:getPrizeData(self._activityId) or {}

	self._prizeScrollerList:reloadData(cfg)
end

function IceQiBuGameMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function IceQiBuGameMainView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	txtScore.text = string.format("%s~%s", data.timeRange[1], data.timeRange[2])

	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)

	txtNum.text = matNum

	MaterialMgr.setIcon(icon, matType, matId, nil, nil)
end

function IceQiBuGameMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
end

function IceQiBuGameMainView:_onClickClose()
	self:close()
end

function IceQiBuGameMainView:_onClickTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function IceQiBuGameMainView:_onClickStart()
	local maxScore = self._subMo:getMinCostTime()
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

function IceQiBuGameMainView:_showSweepChoiceDialog(maxScore)
	local function sureCallBack(view)
		self:_sweepGame(self._activityId, view:getCurTimes())
	end

	local function cancelCallBack(view)
		self:_enterGame(self._activityId)
	end

	local maxGameTimes = self._subMo:getMaxGameTimes()

	local function updateCoinTxtCallBack(view)
		view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxGameTimes)
	end

	local function updateDescTxtCallBack(view)
		local data = IceQibuGameConfig.instance:getPrizeDataByTime(self._activityId, maxScore)
		local prize = data and data.prize
		local matType, matId, matNum = MaterialMgr.getMatParams(prize)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得奖励数量：%s x <color=#0068b7>%s</color>", matName, matNum * view:getCurTimes())
	end

	local left = self._subMo:getLeftGameTimes()

	TipsFacade.instance:openPopupCommonCostPopView(left, 1, "开始游戏", "扫荡", "直接开始", nil, sureCallBack, cancelCallBack, nil, updateCoinTxtCallBack, updateDescTxtCallBack)
end

function IceQiBuGameMainView:_enterGame(activityId)
	local result = self:_getTryEnterGameResultAndTips(true, activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	IceQibuGameController.instance:startGame(self._activityId)
end

function IceQiBuGameMainView:_sweepGame(activityId, times)
	local result = self:_getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	IceQibuGameController.instance:sendPM_IceQibuGameSweepReq(activityId, times)
end

function IceQiBuGameMainView:_getTryEnterGameResultAndTips(isNeedTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local left = self._subMo:getLeftGameTimes()

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

function IceQiBuGameMainView:_getTrySweepGameResultAndTips(isNeedTips, activityId, times)
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

return IceQiBuGameMainView
