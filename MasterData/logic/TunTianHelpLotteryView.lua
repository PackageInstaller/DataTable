-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/view/TunTianHelpLotteryView.lua

module("logic.extensions.tuntianhelp.view.TunTianHelpLotteryView", package.seeall)

local TunTianHelpLotteryView = class("TunTianHelpLotteryView", ViewComponent)

function TunTianHelpLotteryView:buildUI()
	TunTianHelpLotteryView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeView = goutil.findChild(self.mainGO, "prizeCol/prizeView")
	self._prizeCell = goutil.findChild(self.mainGO, "prizeCol/prizeCell")
	self._prizeCellList = {}
	self._btnLottery = goutil.findChild(self.mainGO, "btnLottery")
	self._txtLeftTimes = goutil.findChildTextComponent(self.mainGO, "txtLeftTimes")
end

function TunTianHelpLotteryView:bindEvents()
	TunTianHelpLotteryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
end

function TunTianHelpLotteryView:unbindEvents()
	TunTianHelpLotteryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLottery)
end

function TunTianHelpLotteryView:onEnter()
	TunTianHelpLotteryView.super.onEnter(self)

	self._activityId = TunTianHelpController.instance:getActivityId()
	self._activityType = TunTianHelpController.instance:getActivityType()

	local isInTime = TunTianHelpController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)

		return
	end

	self._prizeDataList = TunTianHelpConfig.instance:getTthPrizeDataList(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.TunTianHelpGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TunTianHelpLotteryRes, self._handleTunTianHelpLotteryRes, self)
	TunTianHelpController.instance:sendPM_TunTianHelpGetInfoReq(self._activityId)
end

function TunTianHelpLotteryView:onExit()
	TunTianHelpLotteryView.super.onExit(self)
	self:_onClearLottery()
end

function TunTianHelpLotteryView:_handleTunTianHelpLotteryRes()
	self:_startLottery()
end

function TunTianHelpLotteryView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end
end

function TunTianHelpLotteryView:_onUpdate()
	self:_onUpdatePrizeColData()
	self:_onUpdatePrizeColUI()

	local leftTimes = TunTianHelpController.instance:getLeftDailyLotteryTimes(self._activityId)

	self._txtLeftTimes.text = string.format("今日剩余次数：%s", leftTimes)
end

function TunTianHelpLotteryView:_onUpdatePrizeColData()
	local parentTran = self._prizeView.transform
	local children = GameUtil.getChildren(parentTran)

	for idx, data in ipairs(self._prizeDataList) do
		if not self._prizeCellList[data.prizeId] then
			self._prizeCellList[data.prizeId] = self._prizeCellList[data.prizeId]

			if not self._prizeCellList[data.prizeId]._mainGo then
				self._prizeCellList[data.prizeId]._mainGo = self._prizeCellList[data.prizeId]._mainGo
				self._prizeCellList[data.prizeId]._item = goutil.findChild(self._prizeCellList[data.prizeId]._mainGo, "item")
				self._prizeCellList[data.prizeId]._imgLight = goutil.findChild(self._prizeCellList[data.prizeId]._mainGo, "imgLight")
			end
		end
	end
end

function TunTianHelpLotteryView:_onUpdatePrizeColUI()
	for idx, data in ipairs(self._prizeDataList) do
		local cell = self._prizeCellList[data.prizeId]

		if not string.nilorempty(data.prize) then
			MaterialMgr.setCellByCfg(data.prize, cell._item)
		else
			MaterialMgr.resetAll(cell._item)
		end

		GameUtil.SetActive(cell._imgLight, false)
	end
end

function TunTianHelpLotteryView:_onClearPrizeCol()
	for _, cell in ipairs(self._prizeCellList) do
		MaterialMgr.resetAll(cell._item)
	end
end

function TunTianHelpLotteryView:_onClickBtnLottery()
	local result, tips = TunTianHelpController.instance:getTryLotteryResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	TunTianHelpController.instance:sendPM_TunTianHelpLotteryReq(self._activityId)
end

function TunTianHelpLotteryView:_startLottery()
	local prizeId = TunTianHelpModel.instance:getPrizeIdOfLottery()

	if prizeId <= 0 then
		printError("prizeId缺失,无法进行抽奖")

		return
	end

	ViewBlockMgr.instance:blockClick(true, self)

	self._targetIdx = prizeId
	self._interval = 0.01
	self._sumInr = 0
	self._startInr = 0.05
	self._endInr = 0.35
	self._limitInr = 0
	self._cellCount = #self._prizeCellList
	self._curStepCount = -1
	self._totalStepCount = 25 - 25 % self._cellCount + self._targetIdx - 1

	removetimer(self._updateTime, self)
	settimer(self._interval, self._updateTime, self, true)
end

function TunTianHelpLotteryView:_updateTime()
	self._sumInr = self._sumInr + self._interval

	if self._sumInr < self._limitInr then
		return
	end

	self._sumInr = 0
	self._curStepCount = self._curStepCount + 1

	local stepIdx = self._curStepCount % self._cellCount + 1
	local t = self._curStepCount / self._totalStepCount - 0.5

	self._limitInr = Mathf.SmoothStep(self._startInr, self._endInr, t)

	for idx, cell in ipairs(self._prizeCellList) do
		GameUtil.SetActive(cell._imgLight, stepIdx == idx)
	end

	if self._curStepCount >= self._totalStepCount then
		removetimer(self._updateTime, self)
		self:_readyEndLottery()

		return
	end
end

function TunTianHelpLotteryView:_readyEndLottery()
	self._lightTimes = 0
	self._totalLightTimes = 3
	self._isLight = false

	removetimer(self._lightCell, self)
	settimer(0.3, self._lightCell, self, true)
end

function TunTianHelpLotteryView:_lightCell()
	local cell = self._prizeCellList[self._targetIdx]

	GameUtil.SetActive(cell._imgLight, self._isLight)

	self._isLight = not self._isLight
	self._lightTimes = self._lightTimes + 1

	if self._lightTimes > self._totalLightTimes then
		removetimer(self._lightCell, self)
		settimer(0.3, self._endLottery, self, false)
	end
end

function TunTianHelpLotteryView:_endLottery()
	ViewBlockMgr.instance:blockClick(false, self)

	local changeSetId = TunTianHelpModel.instance:getChangeSetIdOfLottery()

	MaterialController.instance:showChangeSetInTemp(changeSetId)
	self:_onUpdate()
end

function TunTianHelpLotteryView:_onClearLottery()
	removetimer(self._updateTime, self)
	removetimer(self._lightCell, self)
	removetimer(self._endLottery, self)
end

return TunTianHelpLotteryView
