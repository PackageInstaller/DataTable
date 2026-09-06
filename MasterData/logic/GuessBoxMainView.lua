-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/view/GuessBoxMainView.lua

module("logic.extensions.guessbox.view.GuessBoxMainView", package.seeall)

local GuessBoxMainView = class("GuessBoxMainView", ViewComponent)

function GuessBoxMainView:ctor()
	GuessBoxMainView.super.ctor(self)
end

function GuessBoxMainView:buildUI()
	GuessBoxMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtTipsCon = goutil.findChildTextComponent(self.mainGO, "tipsCon/txt")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._txtDateTimes = goutil.findChildTextComponent(self.mainGO, "txtDateTimes/txt")
	self._txtWeekTimesGo = goutil.findChild(self.mainGO, "txtWeekTimes")
	self._txtWeekTimes = goutil.findChildTextComponent(self.mainGO, "txtWeekTimes/txt")
	self._btnRule = goutil.findChild(self.mainGO, "btnRule")
	self._btnStart = goutil.findChild(self.mainGO, "btnStart")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollercell")
	self._prizeScrollList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function GuessBoxMainView:bindEvents()
	GuessBoxMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function GuessBoxMainView:unbindEvents()
	GuessBoxMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnStart)
end

function GuessBoxMainView:destroyUI()
	GuessBoxMainView.super.destroyUI(self)
end

function GuessBoxMainView:onEnter()
	GuessBoxMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.GuessBoxGame)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._gbCfg = GuessBoxConfig.instance:getGbCfg(self._activityId)
	self._gbBoxCfg = GuessBoxConfig.instance:getGbBoxCfg(self._activityId)
	self._gbFlowerCfg = GuessBoxConfig.instance:getGbFlowerCfg(self._activityId)

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.GuessBoxGameGetInfo, self._onUpdate, self)
	GuessBoxController.instance:onSendGuessBoxGameGetInfoReq(self._activityId)

	local key = "GuessBoxMainViewFirstStartThenOpenRuleView" .. self._activityId

	local function handler(value)
		if value ~= true then
			self:_onClickRule()
			GameUtil.saveUserData(key, true)
		end
	end

	GameUtil.getUserData(key, handler)

	local storyId = self._gbCfg.firstStoryId

	if storyId > 0 then
		local key = string.format("GuessBox_First_Story_%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end
end

function GuessBoxMainView:onExit()
	GuessBoxMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessBoxGameGetInfo, self._onUpdate, self)
	self._prizeScrollList:dispose()
end

function GuessBoxMainView:_onSetUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.GuessBoxGame, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end
end

function GuessBoxMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GuessBoxMainView:_onUpdateData()
	self:_onUpdateDataMo()
end

function GuessBoxMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePrizeScrollerList()
end

function GuessBoxMainView:_onUpdateDataMo()
	return
end

function GuessBoxMainView:_onUpdatePlaneUI()
	local dailyHasPlayeTimes = GuessBoxModel.instance:getDailyHasPlayeTimes()
	local dailyPlayTimes = self._gbCfg.dailyPlayTimes
	local leftDateTimes = dailyPlayTimes - dailyHasPlayeTimes

	if self._txtDateTimes then
		self._txtDateTimes.text = string.format("今日剩余次数：%d次", leftDateTimes)
	end

	local weeklyHasPlayeTimes = GuessBoxModel.instance:getWeeklyHasPlayeTimes()
	local weekPlayTimes = self._gbCfg.weekPlayTimes
	local leftWeekTimes = weekPlayTimes - weeklyHasPlayeTimes
	local isNeedActive = weekPlayTimes <= 999

	if self._txtWeekTimes and isNeedActive then
		self._txtWeekTimes.text = string.format("本周剩余次数：%d次", leftWeekTimes)
	end

	GameUtil.SetActive(self._txtWeekTimesGo, isNeedActive)
end

function GuessBoxMainView:_onUpdatePrizeScrollerList()
	local list = {}
	local strArr = MaterialMgr.filterClothsArr(self._gbCfg.prizeShowList)

	for _, prizeStr in ipairs(strArr) do
		local data = {}

		data.prizeStr = prizeStr

		table.insert(list, data)
	end

	self._prizeScrollList:reloadData(list)

	local idx = math.max(0, 1)
	local isMotion = true

	self._prizeScrollList:MoveCellInView(idx, isMotion)
end

function GuessBoxMainView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prizeStr)

	MaterialMgr.setIcon(itemGo, matType, matId, nil, nil)
	GameUtil.addClickHandler(itemGo, function()
		CommonTipsMgr.instance:openMaterialTips(itemGo, matType, matId, 0)
	end)

	local matName = MaterialMgr.getMaterialsNameByCfg(data.prizeStr)

	if not string.nilorempty(matName) and txtName then
		txtName.text = matName
	end
end

function GuessBoxMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.clearIcon(itemGo)
	GameUtil.rmClickHandler(itemGo)
end

function GuessBoxMainView:_onClickStart()
	local isHaveTimes = GuessBoxController.instance:isHaveTimes()

	if isHaveTimes then
		UIStateManager.instance:push(ViewName.GuessBoxSceneView)
	else
		FloatWordMgr.instance:show("没有足够游戏次数")
	end
end

function GuessBoxMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.GuessBoxRuleView, self._activityId)
end

return GuessBoxMainView
