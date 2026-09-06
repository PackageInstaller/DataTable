-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PowerLandMainView.lua

module("logic.extensions.powerland.view.PowerLandMainView", package.seeall)

local PowerLandMainView = class("PowerLandMainView", ViewComponent)

function PowerLandMainView:buildUI()
	PowerLandMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._btnTask = goutil.findChild(self.mainGO, "btnTask")
	self._btnPrize = goutil.findChild(self.mainGO, "btnPrize")
	self._btnWay = goutil.findChild(self.mainGO, "btnWay")
	self._btnEntry = goutil.findChild(self.mainGO, "btnEntry")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._btnTaskRed = goutil.findChild(self.mainGO, "btnTask/redPoint")
	self._btnPrizeRed = goutil.findChild(self.mainGO, "btnPrize/redPoint")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtCount")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "tip/txtDesc")
	self._txtBubbleDesc = goutil.findChildTextComponent(self.mainGO, "bubble/txtDesc")

	GameUtil.SetActive(self._btnTaskRed, false)
	GameUtil.SetActive(self._btnPrizeRed, false)
end

function PowerLandMainView:bindEvents()
	PowerLandMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnWay, self._onClickBtnWay, self)
	GameUtil.addClickHandler(self._btnEntry, self._onClickBtnEntry, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
end

function PowerLandMainView:unbindEvents()
	PowerLandMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnWay)
	GameUtil.rmClickHandler(self._btnEntry)
	GameUtil.rmClickHandler(self._btnShop)
end

function PowerLandMainView:onEnter()
	PowerLandMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.PowerLand)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	PowerLandController.instance:onSendPowerLandGetInfoReq(self._activityId)
	self:_onUpdate()
end

function PowerLandMainView:onExit()
	PowerLandMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	RedPointController.instance:unregRedPoint(self._btnTaskRed)
end

function PowerLandMainView:_onSetUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.PowerLand, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	local eTaskCfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	if eTaskCfg then
		RedPointController.instance:regRedPoint(self._btnTaskRed, eTaskCfg.redPointId)
	end

	self._txtDesc.text = PowerLandConfig.instance:getPlHomeViewBottomTips()
	self._txtBubbleDesc.text = PowerLandConfig.instance:getBubbleDesc()
end

function PowerLandMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PowerLandMainView:_onUpdateData()
	return
end

function PowerLandMainView:_onUpdateUI()
	local leaveTimes = PowerLandModel.instance:getLeaveGameTimes()

	self._txtCount.text = string.format("剩余次数：%d", leaveTimes)
end

function PowerLandMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(PowerLandConfig.instance:getRuleTipsKey())
end

function PowerLandMainView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.PowerLandTaskView, self._activityId)
end

function PowerLandMainView:_onClickBtnPrize()
	local prizeCfg = PowerLandConfig.instance:getPlPrizeCfg(self._activityId)
	local prizeDataList = {}

	local function getPrizeData(data)
		t = {
			txtTitle = string.format("%d胜", data.winCount),
			prizeStrList = data.prize
		}

		return t
	end

	if prizeCfg[0] then
		table.insert(prizeDataList, getPrizeData(prizeCfg[0]))
	end

	for _, data in ipairs(prizeCfg) do
		table.insert(prizeDataList, getPrizeData(data))
	end

	UIStateManager.instance:push(ViewName.PowerLandPrizeView, prizeDataList)
end

function PowerLandMainView:_onClickBtnWay()
	UIStateManager.instance:push(ViewName.PowerLandRuleView)
end

function PowerLandMainView:_onClickBtnEntry()
	if PowerLandModel.instance:isStartChallenge() then
		UIStateManager.instance:push(ViewName.PowerLandScenceView)

		return
	end

	if PowerLandController.instance:isGameTimesEnough() then
		local key = "PowerLandMainViewFirstStartThenOpenRuleView" .. self._activityId

		local function handler(value)
			if value ~= true then
				local function finishCallBack()
					UIStateManager.instance:push(ViewName.InitialPetSelectionView)
				end

				UIStateManager.instance:push(ViewName.PowerLandRuleView, finishCallBack)
				GameUtil.saveUserData(key, true)
			else
				UIStateManager.instance:push(ViewName.InitialPetSelectionView)
			end
		end

		GameUtil.getUserData(key, handler)
	else
		FloatWordMgr.instance:show("没有剩余次数，无法挑战")
	end
end

function PowerLandMainView:_onClickBtnShop()
	local str = PowerLandConfig.instance:getPlCommonValue("SHOP_JUMP")

	GotoMgr.gotoByString(str)
end

return PowerLandMainView
