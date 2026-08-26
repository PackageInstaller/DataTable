-- chunkname: @modules/logic/task/view/TaskNoviceView.lua

module("modules.logic.task.view.TaskNoviceView", package.seeall)

local TaskNoviceView = class("TaskNoviceView", BaseView)

function TaskNoviceView:onInitView()
	self._goright = gohelper.findChild(self.viewGO, "#go_right")
	self._gotaskitemcontent = gohelper.findChild(self.viewGO, "#go_right/viewport/#go_taskitemcontent")
	self._gogrowitemcontent = gohelper.findChild(self.viewGO, "#go_right/viewport/#go_taskitemcontent/#go_growitemcontent")
	self._gogrowtip = gohelper.findChild(self.viewGO, "#go_right/viewport/#go_taskitemcontent/#go_growitemcontent/#go_growtip")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#go_left/#simage_leftbg")
	self._simageren = gohelper.findChildSingleImage(self.viewGO, "#go_left/#simage_ren")
	self._btnshowdetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/title/#btn_showdetail")
	self._goactlist = gohelper.findChild(self.viewGO, "#go_left/act/actlistscroll/Viewport/#go_actlist")
	self._goactitem = gohelper.findChild(self.viewGO, "#go_left/act/actlistscroll/Viewport/#go_actlist/#go_actitem")
	self._txtstagename = gohelper.findChildText(self.viewGO, "#go_left/#txt_stagename")
	self._goflag = gohelper.findChild(self.viewGO, "#go_left/curprogresslist/#go_flag")
	self._txtcurprogress = gohelper.findChildText(self.viewGO, "#go_left/#txt_stagename/#txt_curprogress")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_left/rewardscroll/Viewport/#go_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_left/rewardscroll/Viewport/#go_rewards/#go_rewarditem")
	self._golingqumax = gohelper.findChild(self.viewGO, "#go_left/#lingqumax")
	self._gohasreceive = gohelper.findChild(self.viewGO, "#go_left/#go_hasreceive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TaskNoviceView:addEvents()
	self._btnshowdetail:AddClickListener(self._btnshowDetailOnClick, self)
end

function TaskNoviceView:removeEvents()
	self._btnshowdetail:RemoveClickListener()
end

function TaskNoviceView:_btnshowDetailOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, 302303, false, nil, false)
end

function TaskNoviceView:_onUpdateTaskList()
	local list = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice)
	local growCount = 0

	for i = 1, #list do
		if list[i].config.minTypeId == TaskEnum.TaskMinType.GrowBack then
			growCount = growCount + 1
		end
	end

	local maxUnlockStage = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	TaskModel.instance:setNoviceTaskCurStage(maxUnlockStage)
	TaskDispatcher.runDelay(self._onCheckRefreshNovice, self, 0.2)
end

function TaskNoviceView:_onCheckRefreshNovice()
	if TaskModel.instance:couldGetTaskNoviceStageReward() then
		return
	end

	self:_refreshNovice()
end

function TaskNoviceView:_onPlayActState(param)
	if param.taskType ~= TaskEnum.TaskType.Novice then
		return
	end

	if param.force then
		self:_refreshNovice()

		return
	end

	if param.growCount then
		gohelper.setActive(self._gogrowitemcontent, param.growCount > 1)
		gohelper.setActive(self._gogrowtip, param.growCount > 1)
	end

	TaskDispatcher.cancelTask(self._flagPlayUpdate, self)

	if param.num < 1 then
		return
	end

	local curStage = TaskModel.instance:getNoviceTaskCurStage()
	local curSelectStage = TaskModel.instance:getNoviceTaskCurSelectStage()
	local maxUnlockStage = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	if curStage < maxUnlockStage then
		return
	end

	if maxUnlockStage < curSelectStage then
		TaskModel.instance:setNoviceTaskCurStage(maxUnlockStage)
		TaskModel.instance:setNoviceTaskCurSelectStage(maxUnlockStage)
		self:_refreshStageInfo()
		self:_refreshActItem()
		self:_refreshProgressItem()
	end

	local curProgress = TaskModel.instance:getCurStageActDotGetNum()
	local total = TaskModel.instance:getCurStageMaxActDot()
	local addNum = 0

	addNum = total < curProgress + param.num and curProgress + param.num - total or param.num
	self._totalAct = curProgress + addNum

	if addNum > 0 then
		self._flagPlayCount = 0

		TaskDispatcher.runRepeat(self._flagPlayUpdate, self, 0.06, addNum)
	end
end

function TaskNoviceView:_flagPlayUpdate()
	local curProgress = TaskModel.instance:getCurStageActDotGetNum()
	local total = TaskModel.instance:getCurStageMaxActDot()

	self._flagPlayCount = self._flagPlayCount + 1

	gohelper.setActive(self._noviceFlags[self._flagPlayCount + curProgress].go, true)
	self._noviceFlags[self._flagPlayCount + curProgress].ani:Play("play")

	if self._flagPlayCount + curProgress >= self._totalAct then
		TaskDispatcher.cancelTask(self._flagPlayUpdate, self)

		for i = curProgress, self._totalAct - 1 do
			UISpriteSetMgr.instance:setCommonSprite(self._noviceFlags[i + 1].img, "logo_huoyuedu")
		end
	end
end

function TaskNoviceView:_editableInitView()
	self._noviceTaskAni = self._goleft:GetComponent(typeof(UnityEngine.Animator))
	self._noviceReceiveAni = self._gohasreceive:GetComponent(typeof(UnityEngine.Animator))

	self._simageleftbg:LoadImage(ResUrl.getTaskBg("bg_yusijia"))
	self._simageren:LoadImage(ResUrl.getTaskBg("bg_yusijiaren"))

	self._taskItems = {}
	self._actItems = {}
	self._pointItems = {}
	self._extraRewardItems = {}
	self._initActPos = transformhelper.getLocalPos(self._goactlist.transform)

	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.RefreshActState, self._onPlayActState, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._onGetBonus, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnShowTaskFinished, self._onShowTaskFinished, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnRefreshActItem, self._onRefreshRewardActItem, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function TaskNoviceView:_onRefreshRewardActItem(param)
	local curSelectStage = TaskModel.instance:getNoviceTaskCurSelectStage()
	local curStage = TaskModel.instance:getNoviceTaskCurStage()
	local maxStage = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	if maxStage < curSelectStage then
		self:_refreshStageInfo()
		self:_refreshActItem()
		self:_refreshProgressItem()
		TaskModel.instance:setNoviceTaskCurStage(maxStage)

		if param and not param.isFinishClick then
			TaskDispatcher.runDelay(self._setNoviceTaskItem, self, 0.5)

			return
		end
	end

	if not param or not param.isActClick then
		local couldGet = TaskModel.instance:couldGetTaskNoviceStageReward()

		if not couldGet then
			TaskModel.instance:setNoviceTaskCurSelectStage(maxStage)
			TaskModel.instance:setNoviceTaskCurStage(maxStage)
		end

		self:_refreshStageInfo()
		self:_refreshActItem()
		self:_refreshProgressItem()
		TaskModel.instance:setNoviceTaskCurSelectStage(maxStage)
		TaskModel.instance:setNoviceTaskCurStage(maxStage)

		if TaskModel.instance:couldGetTaskNoviceStageReward() then
			return
		end

		TaskDispatcher.runDelay(self._setNoviceTaskItem, self, 0.5)

		return
	end

	self:_refreshStageInfo()
	self:_refreshActItem()
	self:_refreshProgressItem()
end

function TaskNoviceView:onUpdateParam()
	self:_refreshNovice()
end

function TaskNoviceView:onOpen()
	TaskModel.instance:setHasTaskNoviceStageReward(false)

	local count = TaskModel.instance:getRefreshCount()
	local initType = TaskView.getInitTaskType()

	if count == 0 and initType ~= TaskEnum.TaskType.Novice then
		return
	end

	local curStage = TaskModel.instance:getNoviceTaskCurStage()

	TaskModel.instance:setNoviceTaskCurSelectStage(curStage)

	if #self._taskItems < 1 then
		self:_refreshNovice()
	end
end

function TaskNoviceView:_onShowTaskFinished(taskType)
	if taskType == TaskEnum.TaskType.Novice then
		return
	end

	self:_refreshNovice()
end

function TaskNoviceView:_onFinishTask(taskId)
	local taskCo = TaskConfig.instance:gettaskNoviceConfig(taskId)

	if not taskCo then
		return
	end

	local data = {}

	data.isFinishClick = true

	TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem, data)
end

function TaskNoviceView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView or viewName == ViewName.CharacterSkinGainView then
		local size = PopupController.instance:getPopupCount()

		if TaskModel.instance:couldGetTaskNoviceStageReward() and size == 0 then
			TaskDispatcher.runDelay(self._onWaitShowGetStageReward, self, 0.1)
		end
	end
end

function TaskNoviceView:_onWaitShowGetStageReward()
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return
	end

	gohelper.setActive(self._golingqumax, true)
	UIBlockMgr.instance:startBlock("taskstageani")
	TaskDispatcher.runDelay(self._showStageReward, self, 1.3)
end

function TaskNoviceView:_showStageReward()
	UIBlockMgr.instance:endBlock("taskstageani")
	gohelper.setActive(self._golingqumax, false)

	local stage = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	TaskModel.instance:setNoviceTaskCurSelectStage(stage)

	local co = {}
	local allStageFinished = stage == TaskModel.instance:getMaxStage(TaskEnum.TaskType.Novice)

	allStageFinished = allStageFinished and TaskModel.instance:getStageActDotGetNum(stage) >= TaskModel.instance:getStageMaxActDot(stage)

	local bonusStage = allStageFinished and stage or stage - 1
	local bonusCo = TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, bonusStage)
	local rewards = string.split(bonusCo.bonus, "|")
	local uid

	for _, v in ipairs(rewards) do
		local itemCo = string.splitToNumber(v, "#")

		if itemCo[1] == MaterialEnum.MaterialType.PowerPotion then
			local latestPowerCo = ItemPowerModel.instance:getLatestPowerChange()

			for _, power in pairs(latestPowerCo) do
				if tonumber(power.itemid) == tonumber(v.materilId) then
					uid = power.uid
				end
			end
		end

		local o = MaterialDataMO.New()

		o:initValue(itemCo[1], itemCo[2], itemCo[3])

		if itemCo[1] ~= MaterialEnum.MaterialType.Faith then
			table.insert(co, o)
		end
	end

	TaskModel.instance:setHasTaskNoviceStageReward(false)
	TaskDispatcher.runDelay(self._onCheckRefreshNovice, self, 0.2)

	local heroParam = TaskModel.instance:getTaskNoviceStageParam()

	if heroParam then
		TaskController.instance:getRewardByLine(MaterialEnum.GetApproach.NoviceStageReward, ViewName.CharacterSkinGainView, heroParam)
		TaskModel.instance:setTaskNoviceStageHeroParam()
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
end

function TaskNoviceView:_onGetBonus()
	TaskDispatcher.runDelay(self._onCheckRefreshNovice, self, 0.1)
end

function TaskNoviceView:_refreshNovice()
	local open = TaskModel.instance:getRefreshCount() < 2

	self._noviceTaskAni.enabled = open

	self:_refreshStageInfo(open)
	self:_refreshActItem(open)
	self:_refreshProgressItem(open)
	self:_setNoviceTaskItem(open)
end

function TaskNoviceView:_refreshStageInfo(open)
	local stage = TaskModel.instance:getNoviceTaskCurSelectStage()
	local total = TaskModel.instance:getStageMaxActDot(stage)
	local maxUnlockStage = TaskModel.instance:getNoviceTaskMaxUnlockStage()
	local curProgress = TaskModel.instance:getStageActDotGetNum(stage)
	local bonusCo = TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, stage)
	local couldGet = TaskModel.instance:couldGetTaskNoviceStageReward()
	local hasGetReward = stage < maxUnlockStage and true or total <= curProgress

	hasGetReward = not couldGet and hasGetReward

	if hasGetReward then
		gohelper.setActive(self._gohasreceive, true)

		if open then
			self._noviceReceiveAni:Play(UIAnimationName.Open)
		else
			self._noviceReceiveAni:Play(UIAnimationName.Idle)
		end
	else
		gohelper.setActive(self._gohasreceive, false)
	end

	self._txtstagename.text = bonusCo.desc
	self._extraRewardItems = self._extraRewardItems or {}

	local rewards = string.split(bonusCo.bonus, "|")

	for i = 1, #rewards do
		local item = self._extraRewardItems[i]

		if not item then
			item = {
				parentGo = gohelper.cloneInPlace(self._gorewarditem)
			}
			item.itemGo = gohelper.findChild(item.parentGo, "rewarditem")
			item.canvasGroup = item.itemGo:GetComponent(typeof(UnityEngine.CanvasGroup))
			item.itemIcon = IconMgr.instance:getCommonItemIcon(item.itemGo)

			table.insert(self._extraRewardItems, item)
		end

		gohelper.setActive(item.parentGo, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		item.itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(45)
		item.itemIcon:showStackableNum2()
		item.itemIcon:hideEquipLvAndCount()

		item.canvasGroup.alpha = hasGetReward and 0.7 or 1

		item.itemIcon:setItemColor(hasGetReward and "#3F3F3F" or nil)
	end

	for i = #rewards + 1, #self._extraRewardItems do
		local item = self._extraRewardItems[i]

		gohelper.setActive(item.parentGo, false)
	end
end

function TaskNoviceView:_refreshActItem(open)
	for _, v in pairs(self._actItems) do
		v:destroy()
	end

	self._actItems = {}

	local stageTotal = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Novice)
	local item

	for i = 1, stageTotal do
		local child = gohelper.cloneInPlace(self._goactitem)

		item = TaskNoviceActItem.New()

		item:init(child, i)
		table.insert(self._actItems, item)
	end

	if self._actTweenId then
		ZProj.TweenHelper.KillById(self._actTweenId)
	end

	TaskDispatcher.runDelay(self._showActItems, self, 0.1)
end

function TaskNoviceView:_showActItems()
	local curStage = TaskModel.instance:getNoviceTaskCurSelectStage()
	local maxStage = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Novice)
	local deltaPos = 0

	if curStage >= maxStage - 1 then
		local subItemWidth = recthelper.getWidth(self._actItems[1].go.transform)
		local layoutGroup = self._goactlist:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
		local scrollGo = gohelper.findChild(self.viewGO, "#go_left/act/actlistscroll")
		local contentWidth = recthelper.getWidth(scrollGo.transform)

		deltaPos = transformhelper.getLocalPos(self._actItems[maxStage - 3].go.transform) - transformhelper.getLocalPos(self._actItems[1].go.transform) + (4 * subItemWidth + 3 * layoutGroup.spacing + layoutGroup.padding.left - contentWidth)
	elseif curStage > 1 then
		deltaPos = transformhelper.getLocalPos(self._actItems[curStage - 1].go.transform) - transformhelper.getLocalPos(self._actItems[1].go.transform)
	end

	if self._hasEnterNovice then
		self._actTweenId = ZProj.TweenHelper.DOLocalMoveX(self._goactlist.transform, self._initActPos - deltaPos, 0.5)
	else
		self._hasEnterNovice = true

		transformhelper.setLocalPosXY(self._goactlist.transform, self._initActPos - deltaPos, 0)
	end
end

function TaskNoviceView:_refreshProgressItem(open)
	if self._noviceFlags then
		for _, v in pairs(self._noviceFlags) do
			gohelper.destroy(v.go)
		end
	end

	self._noviceFlags = self:getUserDataTb_()

	local curStage = TaskModel.instance:getNoviceTaskCurStage()
	local curSelectStage = TaskModel.instance:getNoviceTaskCurSelectStage()
	local maxUnlockStage = TaskModel.instance:getNoviceTaskMaxUnlockStage()
	local total = TaskModel.instance:getStageMaxActDot(curSelectStage)
	local curProgress = TaskModel.instance:getStageActDotGetNum(curSelectStage)
	local value = curSelectStage < maxUnlockStage and total or curProgress

	if maxUnlockStage < curSelectStage then
		curProgress = TaskModel.instance:getStageActDotGetNum(curSelectStage)
		total = TaskModel.instance:getStageMaxActDot(curSelectStage)
		value = 0
	end

	for i = 1, total do
		local child = gohelper.cloneInPlace(self._goflag)

		gohelper.setActive(child, not open)

		local flag = {}

		flag.go = child
		flag.idle = gohelper.findChild(flag.go, "idle")

		gohelper.setActive(flag.idle, true)

		flag.img = gohelper.findChildImage(flag.go, "idle")

		local spr = (maxUnlockStage < curSelectStage or nil) and false and "logo_huoyuedu" or "logo_huoyuedu_dis"

		UISpriteSetMgr.instance:setCommonSprite(flag.img, spr)

		flag.play = gohelper.findChild(flag.go, "play")

		gohelper.setActive(flag.play, false)

		flag.ani = flag.go:GetComponent(typeof(UnityEngine.Animator))

		flag.ani:Play(UIAnimationName.Idle)
		table.insert(self._noviceFlags, flag)
	end

	self._txtcurprogress.text = string.format("%s/%s", value, total)

	if open then
		self._flagopenCount = 0

		TaskDispatcher.cancelTask(self._flagOpenUpdate, self)
		TaskDispatcher.runRepeat(self._flagOpenUpdate, self, 0.03, total)
	end
end

function TaskNoviceView:_flagOpenUpdate()
	self._flagopenCount = self._flagopenCount + 1

	gohelper.setActive(self._noviceFlags[self._flagopenCount].go, true)
	self._noviceFlags[self._flagopenCount].ani:Play(UIAnimationName.Open)
end

function TaskNoviceView:_setNoviceTaskItem(open)
	if self._taskItems then
		for _, v in pairs(self._taskItems) do
			if v.go then
				v:destroy()
			end
		end

		self._taskItems = {}
	end

	gohelper.setActive(self._gogrowitemcontent, false)

	local list = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice)

	if open then
		UIBlockMgr.instance:startBlock("taskani")

		self._repeatCount = 0

		TaskDispatcher.runRepeat(self.showByLine, self, 0.04, #list)
	else
		for i = 1, #list do
			local item = self:getItem(list[i], i, false)

			table.insert(self._taskItems, item)
		end
	end
end

function TaskNoviceView:showByLine()
	self._repeatCount = self._repeatCount + 1

	local list = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice)
	local item = self:getItem(list[self._repeatCount], self._repeatCount, true)

	table.insert(self._taskItems, item)

	if self._repeatCount >= #list then
		UIBlockMgr.instance:endBlock("taskani")
		TaskDispatcher.cancelTask(self.showByLine, self)
		TaskDispatcher.runDelay(self._onStartTaskFinished, self, 0.5)
	end
end

function TaskNoviceView:_onStartTaskFinished()
	local count = TaskModel.instance:getRefreshCount()

	TaskModel.instance:setRefreshCount(count + 1)
	TaskController.instance:dispatchEvent(TaskEvent.OnShowTaskFinished, TaskEnum.TaskType.Novice)
end

function TaskNoviceView:getItem(co, index, open)
	local taskItem = {}

	if co.type == TaskEnum.TaskType.Novice and co.config.chapter ~= 0 then
		local res = self.viewContainer:getSetting().otherRes[4]
		local go = self:getResInst(res, self._gotaskitemcontent, "item" .. index)

		taskItem = TaskListNoviceSpItem.New()

		gohelper.setSiblingBefore(go, self._gogrowitemcontent)
		taskItem:init(go, index, co, open, self._goright)
	elseif co.config.minTypeId == TaskEnum.TaskMinType.GrowBack then
		gohelper.setActive(self._gogrowitemcontent, true)
		gohelper.setActive(self._gogrowtip, true)

		local res = self.viewContainer:getSetting().otherRes[3]
		local go = self:getResInst(res, self._gogrowitemcontent, "item" .. index)

		taskItem = TaskListNoviceGrowItem.New()

		taskItem:init(go, index, co, open, self._goright)
	else
		local res = self.viewContainer:getSetting().otherRes[2]
		local go = self:getResInst(res, self._gotaskitemcontent, "item" .. index)

		taskItem = TaskListNoviceNormalItem.New()

		taskItem:init(go, index, co, open, self._goright)
	end

	return taskItem
end

function TaskNoviceView:onClose()
	return
end

function TaskNoviceView:onDestroyView()
	UIBlockMgr.instance:endBlock("taskstageani")
	TaskModel.instance:setNoviceTaskCurStage(0)

	if self._extraRewardItems then
		for _, v in pairs(self._extraRewardItems) do
			gohelper.destroy(v.itemIcon.go)
			gohelper.destroy(v.parentGo)
			v.itemIcon:onDestroy()
		end

		self._extraRewardItems = nil
	end

	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.RefreshActState, self._onPlayActState, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._onGetBonus, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnShowTaskFinished, self._onShowTaskFinished, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnRefreshActItem, self._onRefreshRewardActItem, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	TaskDispatcher.cancelTask(self._flagOpenUpdate, self)
	TaskDispatcher.cancelTask(self._flagPlayUpdate, self)
	TaskDispatcher.cancelTask(self._onCheckRefreshNovice, self)
	TaskDispatcher.cancelTask(self._showStageReward, self)
	TaskDispatcher.cancelTask(self._showActItems, self)
	TaskDispatcher.cancelTask(self._setNoviceTaskItem, self)
	TaskDispatcher.cancelTask(self._onWaitShowGetStageReward, self)
	self._simageleftbg:UnLoadImage()
	self._simageren:UnLoadImage()

	if self._actTweenId then
		ZProj.TweenHelper.KillById(self._actTweenId)

		self._actTweenId = nil
	end

	if self._taskItems then
		for _, taskItem in ipairs(self._taskItems) do
			if taskItem.go then
				taskItem:destroy()
			end
		end

		self._taskItems = nil
	end

	if self._actItems then
		for _, v in pairs(self._actItems) do
			v:destroy()
		end

		self._actItems = nil
	end

	if self._pointItems then
		for _, v in pairs(self._pointItems) do
			v:destroy()
		end

		self._pointItems = nil
	end
end

return TaskNoviceView
