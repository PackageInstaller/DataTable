-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewJudgePanel.lua

module("logic.extensions.season.view.SeasonNewJudgePanel", package.seeall)

local M = class("SeasonNewJudgePanel", SeasonNewPanelBase)

M.PageType = {
	Day = 1,
	Fixed = 3,
	Weekly = 2
}

local PageType = M.PageType
local ScrollHeight = {
	[PageType.Day] = 359,
	[PageType.Weekly] = 379,
	[PageType.Fixed] = 530
}
local kLvAnimDuration = 0.5

function M:buildUI()
	M.super.buildUI(self)

	self._init = true

	local registry = self._registry
	local rootGO = registry:getMainGO()

	self._canvasGroupRoot = rootGO:GetComponent(ComponentType.CanvasGroup)
	self._txtLevel = goutil.findChildTextComponent(rootGO, "txtScore")
	self._imgScore = goutil.findChildImageComponent(rootGO, "imgProgress")
	self._txtScore = goutil.findChildTextComponent(rootGO, "txtProgress")
	self._btnPromoteLevel = UIComponentType.ButtonAdapter(goutil.findChild(rootGO, "btnPromoteLevel"))
	self._toggleDailyTask = goutil.findChildComponent(rootGO, "horizontal_tab_content/tab_1", UIComponentType.SpaceXToggle)
	self._goRedPointDay = goutil.findChild(self._toggleDailyTask.gameObject, "red_point")
	self._toggleWeeklyTask = goutil.findChildComponent(rootGO, "horizontal_tab_content/tab_2", UIComponentType.SpaceXToggle)
	self._goRedPointWeekly = goutil.findChild(self._toggleWeeklyTask.gameObject, "red_point")
	self._toggleFixedTask = goutil.findChildComponent(rootGO, "horizontal_tab_content/tab_3", UIComponentType.SpaceXToggle)
	self._goRedPointFixed = goutil.findChild(self._toggleFixedTask.gameObject, "red_point")
	self._txtFixedTime = goutil.findChildTextComponent(rootGO, "horizontal_tab_content/tab_3/objDay/txtDay")
	self._scrollRectTask = goutil.findChild(rootGO, "layout/scrollView"):GetComponent(UIComponentType.ScrollRect)
	self._loopList = LoopGridViewHelper.New(self._scrollRectTask.gameObject)

	self._loopList:InitGridView(0, self._onCellUpdate, self)

	self._goTaskContent = goutil.findChild(rootGO, "layout/scrollView/viewPort/content")
	self._goTaskItem = goutil.findChild(self._goTaskContent, "secret_time_judge_item")
	self._goTaskProgress = registry:getGo("secret_time_judge_panel_1242899054")
	self._viewPresentor = self:getViewPage():getViewPresentor()
	self._goDayRefreshTips = goutil.findChild(rootGO, "layout/txtFreshTime")

	local goCurrency = registry:getGo("13&top_currency_1050779625")

	self:addSubView(MoneyView.New(CommEnum.MoneyShowType.OnlyEnergyShowType, goCurrency))

	self._textProgressNum = registry:getText("secret_time_judge_panel_-2074516505")

	local lineList = {}

	table.insert(lineList, registry:getGo("secret_time_judge_panel_1936530088"))
	table.insert(lineList, registry:getGo("secret_time_judge_panel_-1074178468"))
	table.insert(lineList, registry:getGo("secret_time_judge_panel_-1844408506"))
	table.insert(lineList, registry:getGo("secret_time_judge_panel_-733131412"))
	table.insert(lineList, registry:getGo("secret_time_judge_panel_-684546133"))

	local transfLine = registry:getGo("secret_time_judge_panel_-1123159000").transform
	local lineBgList = {}

	for i = 0, transfLine.childCount - 1 do
		table.insert(lineBgList, transfLine:GetChild(i).gameObject)
	end

	self._progressItems = {}
	self._transfProgressGroup = registry:getRectTransform("secret_time_judge_panel_758086730")

	for i = 0, self._transfProgressGroup.childCount - 1 do
		local goChild = self._transfProgressGroup:GetChild(i).gameObject
		local goCell = self._viewPresentor:getResInstance(ResName.Secret_secret_time_judge_cell)

		goutil.addChildToParent(goCell, goChild)

		local cell = Astral.SimpleLuaComponentContainer.Add(goCell, SeasonJudgeProgressCell)

		cell:setLineGo(lineList[i + 1], lineBgList[i + 1])
		cell:setClickReceiveCallBack(self._clickReceiveProgress, self)
		table.insert(self._progressItems, cell)
	end
end

function M:destroyUI()
	M.super.destroyUI(self)
	self._loopList:Dispose()

	self._loopList = nil

	if self._uiParticle then
		goutil.destroy(self._uiParticle)
	end

	self._uiParticle = nil
end

function M:bindEvents()
	self._btnPromoteLevel:AddClickListener(self._onClickBtnPromoteLevel, self)
	self._toggleDailyTask:AddListener(self._onToggleUnlimitedTask, self)
	self._toggleWeeklyTask:AddListener(self._onToggleWeeklyTask, self)
	self._toggleFixedTask:AddListener(self._onToggleFixedTask, self)
end

function M:unbindEvents()
	self._btnPromoteLevel:RemoveClickListener()
	self._toggleDailyTask:RemoveListener()
	self._toggleWeeklyTask:RemoveListener()
	self._toggleFixedTask:RemoveListener()
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.SEASON_TASK_UPDATE, self._onSeasonTaskUpdate, self)
		GlobalDispatcher:addEventListener(EventType.SEASON_RECEIVE_TASK, self._onSeasonTaskAnimation, self)
		GlobalDispatcher:addEventListener(EventType.SEASON_TASK_PROGRESS_UPDATE, self._onSeasonTaskProgressUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.SEASON_TASK_UPDATE, self._onSeasonTaskUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.SEASON_RECEIVE_TASK, self._onSeasonTaskAnimation, self)
		GlobalDispatcher:removeEventListener(EventType.SEASON_TASK_PROGRESS_UPDATE, self._onSeasonTaskProgressUpdate, self)
	end
end

function M:onEnter()
	M.super.onEnter(self)

	self._canvasGroupRoot.alpha = 0
	self._arrayTaskItem = {}

	self._loopList:ClearCells(true)

	if self._activeTaskType == nil then
		self:_setActiveTaskType(PageType.Day)
	end

	self:_activeToggleByTaskType(self._activeTaskType)
	self:refreshView()
	self:_showTaskAnim()
	self:_setEvents(true)
	self:_showUIPaticle(false)
end

function M:onExit()
	self:_showUIPaticle(false)
	self:_setEvents(false)
	self:_clearTaskItem()
	self:_setActiveTaskType(PageType.Day)
	DG.Tweening.DOTween.Kill(self.mainGO)

	self._scrollRectTask.enabled = true
	self._doingAnim = false
end

function M:setParam(subIndex)
	local pageType = subIndex or PageType.Day

	self:_setActiveTaskType(pageType)

	if self._init then
		self:_activeToggleByTaskType(self._activeTaskType)
	end
end

function M:_showUIPaticle(isShow)
	if not isShow then
		if not goutil.isNil(self._uiParticle) then
			goutil.setActive(self._uiParticle, false)
		end
	else
		if goutil.isNil(self._uiParticle) then
			self._uiParticle = self._viewPresentor:getResInstance(ResName.Secret_secret_time_common_effect)

			goutil.addChildToParent(self._uiParticle, self._imgScore.gameObject)
		end

		goutil.setActive(self._uiParticle, true)
	end
end

function M:_activeToggleByTaskType(taskType)
	if taskType == PageType.Day then
		self._toggleDailyTask.IsOn = true
	elseif taskType == PageType.Weekly then
		self._toggleWeeklyTask.IsOn = true
	elseif taskType == PageType.Fixed then
		self._toggleFixedTask.IsOn = true
	end
end

function M:refreshView()
	self:_refreshLv()
	self:_refreshTask()
	self:_refreshProgress()
end

function M:_refreshLv()
	local lv = SeasonModel.instance:getCurrLv()
	local curScore = SeasonModel.instance:getCurrScore()

	self._maxLv = SeasonConfig.instance:getMaxLv()
	self._upgradeScore = SeasonConfig.instance:getScorePerLv()
	self._txtLevel.text = lv

	if lv < self._maxLv then
		self._txtScore.text = string.format("%s/%s", curScore, self._upgradeScore)
	else
		self._txtScore.text = "MAX"
	end

	local progress = Mathf.Clamp(curScore / self._upgradeScore, 0, 1)

	self._imgScore.fillAmount = 0

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:AppendInterval(0.5)
	sequence:Append(self._imgScore:DOFillAmount(progress, 0.3):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)):SetTarget(self._imgScore.gameObject)

	self._snapshotData = {
		level = lv,
		score = curScore
	}
end

function M:_refreshLvByInfoUpdate()
	local lv = SeasonModel.instance:getCurrLv()
	local curScore = SeasonModel.instance:getCurrScore()

	self:_playUpgradeFill(lv, curScore)
end

function M:_refreshTask(resetPos)
	local timeStr, needShowTime = SeasonModel.instance:getRemainTimeStr()

	self._taskMOList = SeasonModel.instance:getWeeklyTasks(true)

	if self._activeTaskType == PageType.Day then
		self._taskMOList = SeasonModel.instance:getDayTasks(true)
	elseif self._activeTaskType == PageType.Fixed then
		self._taskMOList = SeasonModel.instance:getFixedTasks(true)
	end

	self._arrayTaskItem = {}
	self._txtFixedTime.text = timeStr

	RectTransformUtils.SetHeight(self._scrollRectTask.transform, ScrollHeight[self._activeTaskType])
	goutil.setActive(self._goDayRefreshTips, self._activeTaskType == PageType.Day)
	self._loopList:SetListItemCount(#self._taskMOList, resetPos)
	self._loopList:RefreshAllShownItem()
	self:_refreshRedPoint()
end

function M:_refreshRedPoint()
	goutil.setActive(self._goRedPointDay, SeasonModel.instance:hasDayTaskActive() or SeasonModel.instance:hasDailyTaskProgressActive())
	goutil.setActive(self._goRedPointWeekly, SeasonModel.instance:hasWeeklyTaskActive() or SeasonModel.instance:hasWeeklyTaskProgressActive())
	goutil.setActive(self._goRedPointFixed, SeasonModel.instance:hasFixedTaskActive())
end

function M:_refreshProgress()
	local hasProgress = true

	goutil.setActive(self._goTaskProgress, true)

	local finishedCount = 0
	local rewardData = {}

	if self._activeTaskType == PageType.Day then
		finishedCount = SeasonModel.instance:getDailyTaskFinishedNum()
		rewardData = SeasonConfig.instance:getDailyProgressReward(SeasonModel.instance:getSeasonId())
	elseif self._activeTaskType == PageType.Weekly then
		finishedCount = SeasonModel.instance:getWeeklyTaskFinishedNum()
		rewardData = SeasonConfig.instance:getWeeklyProgressReward(SeasonModel.instance:getSeasonId())
	elseif self._activeTaskType == PageType.Fixed then
		hasProgress = false
	end

	local scheduleRewards = SeasonModel.instance:getScheduleRewards()

	for index, cell in ipairs(self._progressItems) do
		local preProgressCO = rewardData[index - 1]
		local progressCO = rewardData[index]
		local isReceived = progressCO and table.indexof(scheduleRewards or {}, progressCO.id) or false

		cell:setData(progressCO, preProgressCO, isReceived, finishedCount)
	end

	self._textProgressNum.text = finishedCount

	goutil.setActive(self._goTaskProgress, hasProgress)
end

function M:_setActiveTaskType(pageType)
	self._activeTaskType = pageType
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local mo = self._taskMOList[curIndex]
	local item = self._loopList:NewListViewItem("task_cell")
	local rootGO = goutil.findChild(item.gameObject, "secret_time_judge_item")
	local cg = rootGO:GetComponent(ComponentType.CanvasGroup)

	cg.alpha = 1

	TransformUtils.SetLocalPosition(rootGO.transform, 0, 0, 0)

	local shower = Astral.LuaComponentContainer.Get(rootGO, SeasonNewTaskCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(rootGO, SeasonNewTaskCell)

		shower:setGetRewardCallback(self._onTaskGetReward, self)
		shower:setJumpCallback(self._onTaskJump, self)
	end

	shower:setIndex(curIndex)
	shower:setTaskData(mo)

	self._arrayTaskItem[curIndex] = rootGO

	return item
end

function M:_showTaskAnim()
	DG.Tweening.DOTween.Kill(self.mainGO)
	RectTransformUtils.SetAnchoredPosition(self._goTaskContent.transform, 0, 0)

	self._scrollRectTask.enabled = false
	self._doingAnim = true

	local firstPos = -66
	local interval = -138
	local time = 0.2
	local delay = 0.1
	local totalDelay = 0.3
	local sequence = DG.Tweening.DOTween.Sequence()
	local maxCount = math.min(4, #self._taskMOList)

	for idx, item in ipairs(self._arrayTaskItem) do
		local cg = item:GetComponent(ComponentType.CanvasGroup)

		if idx <= maxCount then
			cg.alpha = 0

			cg:DOFade(1, time):SetEase(DG.Tweening.Ease.Linear):SetDelay(delay * (idx - 1) + totalDelay):SetAutoKill(true)
			TransformUtils.SetLocalPosition(item.transform, 0, interval, 0)
			sequence:Insert(delay * (idx - 1) + totalDelay, item.transform:DOLocalMoveY(0, time, false):SetEase(DG.Tweening.Ease.OutCubic, 1))
		end
	end

	sequence:AppendInterval(time + delay * (maxCount - 1) + totalDelay)
	sequence:AppendCallback(self._onTaskAnimEnd, self)
	sequence:SetTarget(self.mainGO)
end

function M:_onTaskAnimEnd()
	self._scrollRectTask.enabled = true
	self._doingAnim = false
end

function M:_clearTaskItem()
	for _, item in pairs(self._arrayTaskItem) do
		local cg = item:GetComponent(ComponentType.CanvasGroup)

		cg:DOKill()
	end
end

function M:_onClickBtnPromoteLevel()
	local curSeasonId = SeasonModel.instance:getSeasonId()
	local curLv = SeasonModel.instance:getCurrLv()
	local normalMaxLv = SeasonConfig.instance:getLimitLv(curSeasonId)

	if normalMaxLv <= curLv then
		FloatWordMgr.instance:show(lang("season_buy_lv_limit"))

		return
	end

	local costCode = SeasonConfig.instance:getUpgradeLvMoneyCode()
	local costPerNum = SeasonConfig.instance:getUpgradeLvMoneyNum()
	local ownNum = ItemModel.instance:getItemCountByItemId(costCode)

	if costPerNum <= ownNum then
		ViewMgr.instance:open(ViewName.SeasonNewPromote)
	else
		FloatWordMgr.instance:show(lang("tip_season_5"))
	end
end

function M:_onClickBtnReport()
	ViewMgr.instance:open(ViewName.SeasonNewReport)
end

function M:_onToggleUnlimitedTask(toggle, isOn)
	if isOn and self._activeTaskType ~= PageType.Day then
		self:_setActiveTaskType(PageType.Day)
		self:_refreshTask(true)
		self:_refreshProgress()
	end
end

function M:_onToggleWeeklyTask(toggle, isOn)
	if isOn and self._activeTaskType ~= PageType.Weekly then
		self:_setActiveTaskType(PageType.Weekly)
		self:_refreshTask(true)
		self:_refreshProgress()
	end
end

function M:_onToggleFixedTask(toggle, isOn)
	if isOn and self._activeTaskType ~= PageType.Fixed then
		self:_setActiveTaskType(PageType.Fixed)
		self:_refreshTask(true)
		self:_refreshProgress()
	end
end

function M:_onTaskGetReward()
	self:_takeAllTask()
end

function M:_takeAllTask()
	local tasks = {}

	for _, taskMO in ipairs(self._taskMOList) do
		if taskMO:isActive() and not taskMO:isFinished() then
			table.insert(tasks, taskMO:getId())
		end
	end

	SeasonAgent.instance:sendTakeTaskPointRequest(tasks)
end

function M:_onTaskJump(idx)
	local taskMO = self._taskMOList[idx]
	local jumpId = taskMO:getJumpId()

	if jumpId > 0 and SystemJumpController.instance:canJump(jumpId, true) then
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
	end
end

function M:_clickReceiveProgress()
	local progressIds = {}

	for _, progressCell in ipairs(self._progressItems) do
		if progressCell:canReceive() then
			table.insert(progressIds, progressCell:getId())
		end
	end

	SeasonAgent.instance:sendReceiveScheduleRewardRequest(progressIds)
end

function M:_onSeasonInfoUpdate()
	self:_refreshLvByInfoUpdate()
end

function M:_onSeasonTaskUpdate()
	self:_refreshTask()
	self:_refreshProgress()
end

function M:_onSeasonTaskAnimation()
	self:_refreshTask()
end

function M:_onSeasonTaskProgressUpdate()
	self:_refreshProgress()
	self:_refreshRedPoint()
end

function M:_playUpgradeFill(lv, score)
	self:_releaseScoreTweener()

	self._fillAniData = {
		oldLv = self._snapshotData.level,
		oldScore = self._snapshotData.score,
		curLv = self._snapshotData.level,
		curScore = self._snapshotData.score,
		targetLv = lv,
		targetScore = score,
		offsetLv = lv - self._snapshotData.level
	}

	local data = self._fillAniData
	local stepTime = kLvAnimDuration

	if data.offsetLv > 0 then
		stepTime = data.targetScore > 0 and stepTime / (data.offsetLv + 1) or stepTime / data.offsetLv
	end

	self._fillAniData.stepTime = stepTime

	self:_checkFill()
end

function M:_playUpgradeFillFinish()
	if self._fillAniData.targetLv >= self._maxLv then
		self._txtScore.text = "max"
	else
		self._txtScore.text = string.format("%s/%s", SeasonModel.instance:getCurrScore(), self._upgradeScore)
	end

	self._snapshotData = {
		level = SeasonModel.instance:getCurrLv(),
		score = SeasonModel.instance:getCurrScore()
	}
end

function M:_checkFill()
	local data = self._fillAniData
	local duration = data.stepTime

	if data.curLv == data.targetLv then
		if data.curScore ~= data.targetScore then
			local endVal = data.targetScore / self._upgradeScore

			self:_fillScoreTween(true, endVal, duration, self._playUpgradeFillFinish, self)
		else
			self:_playUpgradeFillFinish()
		end
	else
		local endVal = 1

		self:_fillScoreTween(true, endVal, duration, self._onScoreFillUpFinish, self)
	end
end

function M:_onScoreFillUpFinish()
	self:_showUIPaticle(false)
	self:_showUIPaticle(true)

	self._fillAniData.curLv = self._fillAniData.curLv + 1
	self._fillAniData.curScore = 0
	self._txtLevel.text = self._fillAniData.curLv
	self._imgScore.fillAmount = 0
	self._txtScore.text = string.format("%s/%s", 0, self._upgradeScore)

	self:_checkFill()
end

function M:_fillScoreTween(play, fillAmount, duration, finishCB, finishCBHandler)
	self:_releaseScoreTweener()

	if play then
		self._scoreTweener = TweenNumberUtils.FloatToWithGetter(fillAmount, duration, self._getScoreFillAmount, self._setScoreFillAmount, self)

		self._scoreTweener:SetEase(DG.Tweening.Ease.Linear)
		self._scoreTweener:SetAutoKill(true)
		self._scoreTweener:OnComplete(function()
			if finishCB then
				if finishCBHandler then
					finishCB(finishCBHandler)
				else
					finishCB()
				end
			end
		end, self)
	end
end

function M:_releaseScoreTweener()
	if self._scoreTweener then
		self._scoreTweener:Kill(false)
	end

	self._scoreTweener = nil
end

function M:_getScoreFillAmount()
	return self._imgScore.fillAmount
end

function M:_setScoreFillAmount(val)
	self._imgScore.fillAmount = val

	local curScore = math.floor(self._upgradeScore * val)

	self._fillAniData.curScore = curScore
	self._txtScore.text = string.format("%s/%s", curScore, self._upgradeScore)
end

return M
