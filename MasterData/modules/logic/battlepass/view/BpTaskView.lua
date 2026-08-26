-- chunkname: @modules/logic/battlepass/view/BpTaskView.lua

module("modules.logic.battlepass.view.BpTaskView", package.seeall)

local BpTaskView = class("BpTaskView", BaseView)

function BpTaskView:ctor()
	self._taskLoopType = 1
end

function BpTaskView:onInitView()
	self._goline = gohelper.findChild(self.viewGO, "#go_line")
	self._goallcomplete = gohelper.findChild(self.viewGO, "#go_allcomplete")
	self._gonew = gohelper.findChild(self.viewGO, "toggleGroup/toggle3/#go_new")
	self._gooperactshow = gohelper.findChild(self.viewGO, "#go_operactshow")
	self._btnopershow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_operactshow/#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpTaskView:addEvents()
	self._btnopershow:AddClickListener(self._btnopershowOnClick, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnGetInfo, self._onTaskUpdate, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnTaskUpdate, self._onTaskUpdate, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnRedDotUpdate, self._onRedDotUpdate, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self.updateLineEnable, self)
	self.addEventCb(self, self.viewContainer, BpEvent.OnTaskFinishAnim, self.playFinishAnim, self)
end

function BpTaskView:removeEvents()
	self._btnopershow:RemoveClickListener()
	self.removeEventCb(self, BpController.instance, BpEvent.OnGetInfo, self._onTaskUpdate, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnTaskUpdate, self._onTaskUpdate, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnRedDotUpdate, self._onRedDotUpdate, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self.updateLineEnable, self)
	self.removeEventCb(self, self.viewContainer, BpEvent.OnTaskFinishAnim, self.playFinishAnim, self)
end

function BpTaskView:_btnopershowOnClick()
	local bpId = BpModel.instance.id
	local actId = BpConfig.instance:getBpCO(bpId).activityId

	if actId and actId > 0 then
		local jumpParam = string.format("%s#%s", JumpEnum.JumpView.ActivityView, actId)

		JumpController.instance:jumpByParam(jumpParam)
	end
end

function BpTaskView:_editableInitView()
	self._operactAnim = self._gooperactshow:GetComponent(typeof(UnityEngine.Animator))

	local taskItemHeight = 132
	local taskItemSpaceV = 15
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll/item"
	scrollParam.cellClass = BpTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1330
	scrollParam.cellHeight = taskItemHeight
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = taskItemSpaceV
	scrollParam.startSpace = -2.5
	scrollParam.frameUpdateMs = 100
	self._scrollView = LuaListScrollView.New(BpTaskModel.instance, scrollParam)

	self:addChildView(self._scrollView)

	self._toggleGroupGO = gohelper.findChild(self.viewGO, "toggleGroup")
	self._toggleGroup = self._toggleGroupGO:GetComponent(typeof(UnityEngine.UI.ToggleGroup))
	self._redDotGO = gohelper.findChild(self.viewGO, "redDot")
	self._toggleWraps = self:getUserDataTb_()
	self._toggleRedDots = self:getUserDataTb_()
	self._expupGos = self:getUserDataTb_()

	local toggleGroupTransform = self._toggleGroupGO.transform
	local count = toggleGroupTransform.childCount

	for i = 1, count do
		local childTrs = toggleGroupTransform:GetChild(i - 1)
		local childGO = childTrs.gameObject
		local toggle = childGO:GetComponent(typeof(UnityEngine.UI.Toggle))

		self._toggleRedDots[i] = gohelper.findChild(self._redDotGO, "#go_reddot" .. i)

		if toggle then
			local toggleWrap = gohelper.onceAddComponent(childGO, typeof(SLFramework.UGUI.ToggleWrap))

			toggleWrap:AddOnValueChanged(self._onToggleValueChanged, self, i)

			self._toggleWraps[i] = toggleWrap
		end

		local go_expup = gohelper.findChild(childGO, "Label/#go_expup")

		table.insert(self._expupGos, go_expup)
	end

	self._taskHeight = taskItemHeight + taskItemSpaceV
	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(BpEnum.TaskMaskTime - BpEnum.TaskGetAnimTime)
	self:_onRedDotUpdate()
	TaskDispatcher.runDelay(self._delayPlayTaskAnim, self, 0)
end

function BpTaskView:_delayPlayTaskAnim()
	self.viewContainer:dispatchEvent(BpEvent.TapViewOpenAnimBegin, 2)
end

function BpTaskView:_onClickbtnGetAll()
	local list = BpTaskModel.instance:getList()
	local haveFinish = false

	self._tweenIndexes = {}

	local isWeekScoreFull = BpModel.instance:isWeeklyScoreFull()

	if not isWeekScoreFull or isWeekScoreFull and self._taskLoopType == 3 then
		for key, mo in ipairs(list) do
			if mo.progress >= mo.config.maxProgress and mo.finishCount == 0 then
				haveFinish = true

				table.insert(self._tweenIndexes, key)

				break
			end
		end
	end

	if haveFinish then
		self.viewContainer:dispatchEvent(BpEvent.OnTaskFinishAnim)
		UIBlockMgr.instance:startBlock("BpTaskItemFinish")
		TaskDispatcher.runDelay(self.finishAllTask, self, BpEnum.TaskMaskTime)
	else
		self:finishAllTask()
	end
end

function BpTaskView:playFinishAnim(index)
	if index then
		self._tweenIndexes = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, BpEnum.TaskGetAnimTime)
end

function BpTaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self._tweenIndexes)
end

function BpTaskView:finishAllTask()
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskDispatcher.cancelTask(self.finishAllTask, self)
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)

	self._preBpScore = BpModel.instance.score
	BpModel.instance.lockLevelUpShow = true

	local isWeekScoreFull = BpModel.instance:isWeeklyScoreFull()
	local finishIds

	if isWeekScoreFull then
		finishIds = {}

		for k, mo in pairs(BpTaskModel.instance.serverTaskModel:getList()) do
			local configLoopType = mo.config.loopType

			if configLoopType ~= 1 and configLoopType ~= 2 and mo.progress >= mo.config.maxProgress and mo.finishCount == 0 and mo.config.bpId == BpModel.instance.id then
				table.insert(finishIds, mo.config.id)
			end
		end
	end

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.BattlePass, nil, finishIds, self._onTaskSendFinish, self)
end

function BpTaskView:_onTaskSendFinish(cmd, resultCode, msg)
	if resultCode == 0 and BpModel.instance.lockLevelUpShow then
		local levelChange = BpModel.instance:checkLevelUp(BpModel.instance.score, self._preBpScore)

		if levelChange then
			BpModel.instance.preStatus = {
				score = self._preBpScore,
				payStatus = BpModel.instance.payStatus
			}

			BpController.instance:onBpLevelUp()
		end
	end

	BpModel.instance.lockLevelUpShow = false
end

function BpTaskView:_onRedDotUpdate()
	for i = 1, #self._toggleRedDots do
		gohelper.setActive(self._toggleRedDots[i], BpTaskModel.instance:getHaveRedDot(i))
	end
end

function BpTaskView:_onToggleValueChanged(toggleId, isOn)
	if isOn then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_second_tabs_click)

		self._taskLoopType = toggleId

		self:_onTaskUpdate()
	end

	self:_setToggleLabelColor()
end

function BpTaskView:_setToggleLabelColor()
	for i = 1, #self._toggleWraps do
		local label = gohelper.findChildText(self._toggleWraps[i].gameObject, "Label")

		SLFramework.UGUI.GuiHelper.SetColor(label, self._taskLoopType == i and "#c66030" or "#888888")
	end
end

function BpTaskView:onClose()
	TaskDispatcher.cancelTask(self._delayPlayTaskAnim, self)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskDispatcher.cancelTask(self.finishAllTask, self)
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)

	BpModel.instance.lockLevelUpShow = false
end

function BpTaskView:onDestroyView()
	for i = 1, #self._toggleWraps do
		self._toggleWraps[i]:RemoveOnValueChanged()
	end

	self._toggleWraps = nil
end

function BpTaskView:onOpen()
	BpController.instance:dispatchEvent(BpEvent.SetGetAllCallBack, self._onClickbtnGetAll, self)

	local selectIndex = 1

	for i = 1, 3 do
		if BpTaskModel.instance:getHaveRedDot(i) then
			selectIndex = i

			break
		end
	end

	self._taskLoopType = selectIndex

	for i = 1, #self._toggleWraps do
		self._toggleWraps[i].isOn = i == selectIndex
	end

	BpTaskModel.instance:sortList()
	self:_onTaskUpdate()
	self:_refreshExpUp()
end

function BpTaskView:_onTaskUpdate()
	self.viewContainer:dispatchEvent(BpEvent.TaskTabChange, self._taskLoopType)
	BpTaskModel.instance:refreshListView(self._taskLoopType)
	self:updateLineEnable()
	BpController.instance:dispatchEvent(BpEvent.SetGetAllEnable, BpTaskModel.instance.showQuickFinishTask)

	if not BpModel.instance.id then
		local bpId = 0
		local isShowNew = false

		if BpTaskModel.instance.haveTurnBackTask then
			local isMark = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.BpTurnBackNewMark .. bpId, "0")

			if isMark == "0" then
				isShowNew = true
			end
		end

		if self._taskLoopType == 3 and isShowNew then
			GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.BpTurnBackNewMark .. bpId, "1")

			isShowNew = false
		end

		gohelper.setActive(self._gonew, isShowNew)

		local isTabFinished = BpTaskModel.instance:isLoopTypeTaskAllFinished(self._taskLoopType)
		local isBpOperTaskAllFinished = V3a1_BpOperActModel.instance:isAllTaskFinihshed()
		local isMaxLv = BpModel.instance:isMaxLevel()
		local operActInfoMo = ActivityModel.instance:getActivityInfo()[BpModel.instance:getCurVersionOperActId()]
		local isOperActOnline = operActInfoMo:isOpen() and operActInfoMo:isOnline() and not operActInfoMo:isExpired()
		local showOper = isTabFinished and not isMaxLv and not isBpOperTaskAllFinished and isOperActOnline

		gohelper.setActive(self._gooperactshow, showOper)

		if showOper then
			self._operactAnim:Play("open", 0, 0)
		end

		local showAllComplete = not showOper and self._taskLoopType <= 2 and BpModel.instance:isWeeklyScoreFull()

		gohelper.setActive(self._goallcomplete, showAllComplete)
	end
end

function BpTaskView:updateLineEnable()
	gohelper.setActive(self._goline, (BpModel.instance.payStatus ~= BpEnum.PayStatus.Pay2 or nil) and false)
end

function BpTaskView:_refreshExpUp()
	local isShowExePup = BpModel.instance:isShowExpUp()

	if not isShowExePup then
		for _, go in ipairs(self._expupGos) do
			gohelper.setActive(go, false)
		end

		return
	end

	local set = {}

	for _, mo in pairs(BpTaskModel.instance.serverTaskModel:getList()) do
		local config = mo.config
		local loopType = config.loopType
		local bonusScoreTimes = 1000 + (config.bonusScoreTimes or 0)
		local isShow = bonusScoreTimes > 1000

		set[loopType] = set[loopType] or isShow
	end

	for i, go in ipairs(self._expupGos) do
		gohelper.setActive(go, set[i] or false)
	end
end

return BpTaskView
