-- chunkname: @modules/logic/commandstation/view/CommandStationTaskItem.lua

module("modules.logic.commandstation.view.CommandStationTaskItem", package.seeall)

local CommandStationTaskItem = class("CommandStationTaskItem", ListScrollCellExtend)

function CommandStationTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._simagenormalbg2 = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg2")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._gonojump = gohelper.findChild(self.viewGO, "#go_normal/#go_nojump")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gounopen = gohelper.findChild(self.viewGO, "#go_normal/#go_unopen")
	self._txtUnOpen = gohelper.findChildText(self.viewGO, "#go_normal/#go_unopen/image_Tag/#txt_UnOpen")
	self._goexpire = gohelper.findChild(self.viewGO, "#go_normal/#go_expire")
	self._goopen = gohelper.findChild(self.viewGO, "#go_normal/#go_open")
	self._goxunyou = gohelper.findChild(self.viewGO, "#go_normal/#go_xunyou")
	self._gocatch = gohelper.findChild(self.viewGO, "#go_normal/#go_catch")
	self._gospring = gohelper.findChild(self.viewGO, "#go_normal/#go_spring")
	self._txtOpen = gohelper.findChildText(self.viewGO, "#go_normal/#go_open/image_Tag/#txt_Open")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function CommandStationTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function CommandStationTaskItem:_btnnotfinishbgOnClick()
	if self._taskMO.config.jumpId and self._taskMO.config.jumpId > 0 and GameFacade.jump(self._taskMO.config.jumpId) then
		ViewMgr.instance:closeView(ViewName.CommandStationTaskView)
	end
end

function CommandStationTaskItem:_btnfinishbgOnClick()
	self:_onOneClickClaimReward()
	UIBlockHelper.instance:startBlock("CommandStationTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinish, self, 0.5)
end

function CommandStationTaskItem:_btngetallOnClick()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.OneClickClaimReward)
	UIBlockHelper.instance:startBlock("CommandStationTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinishAll, self, 0.5)
end

function CommandStationTaskItem:_delayFinish()
	TaskRpc.instance:sendFinishTaskRequest(self._taskMO.config.id)
end

function CommandStationTaskItem:_delayFinishAll()
	TaskRpc.instance:sendFinishAllTaskRequest((CommandStationTaskListModel.instance.curSelectType ~= 1 or nil) and TaskEnum.TaskType.CommandStationCatch)
end

function CommandStationTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewTrs = self.viewGO.transform
	self._scrollRewards = gohelper.findChildComponent(self.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function CommandStationTaskItem:_editableAddEvents()
	CommandStationController.instance:registerCallback(CommandStationEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function CommandStationTaskItem:_editableRemoveEvents()
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function CommandStationTaskItem:_onOneClickClaimReward()
	if self._taskMO and self._taskMO:alreadyGotReward() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function CommandStationTaskItem:getAnimator()
	return self._animator
end

function CommandStationTaskItem:onUpdateMO(mo)
	self._taskMO = mo

	local rankDiff = CommandStationTaskListModel.instance:getRankDiff(mo)

	self._scrollRewards.parentGameObject = self._view._csListScroll.gameObject

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function CommandStationTaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx, posy, posz = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, 0.15)
	end
end

function CommandStationTaskItem:onSelect(isSelect)
	return
end

function CommandStationTaskItem:_refreshUI()
	local atMO = self._taskMO

	if not atMO then
		return
	end

	local isNormal = atMO.id ~= -99999

	gohelper.setActive(self._gogetall, not isNormal)
	gohelper.setActive(self._gonormal, isNormal)

	if isNormal then
		if self._playFinishAnin then
			self._playFinishAnin = false

			self._animator:Play("idle", 0, 0)
		end

		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg, false)
		gohelper.setActive(self._btnfinishbg, false)
		gohelper.setActive(self._gonojump, false)
		gohelper.setActive(self._goopen, false)
		gohelper.setActive(self._goexpire, false)
		gohelper.setActive(self._gounopen, false)

		local actStatus = self:_getActStatus(atMO)

		if actStatus and atMO:isFinished() then
			gohelper.setActive(self._goallfinish, true)
		elseif atMO:alreadyGotReward() then
			gohelper.setActive(self._btnfinishbg, true)
			gohelper.setActive(self._goexpire, false)
		elseif actStatus and atMO.config.jumpId and atMO.config.jumpId > 0 then
			gohelper.setActive(self._btnnotfinishbg, true)
		else
			gohelper.setActive(self._gonojump, actStatus)
		end

		if atMO.config then
			if not atMO.config.offestProgress then
				local offestPro = 0

				self._txtnum.text = math.max(atMO:getFinishProgress() + offestPro, 0)
				self._txttotal.text = math.max(atMO:getMaxProgress() + offestPro, 0)

				if atMO.config then
					self._txttaskdes.text = atMO.config.desc or ""
				end

				local item_list = ItemModel.instance:getItemDataListByConfigStr(atMO.config.bonus)

				self.item_list = item_list

				IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._gorewards)

				self._scrollRewards.horizontalNormalizedPosition = 0

				if CommandStationTaskListModel.instance:isCatchTaskType() then
					self._txttaskdes.text = string.format((atMO.config or nil) and (atMO.config.desc or ""), atMO:getMaxProgress())
				end

				local isNormalShowType = atMO.config.taskType == CommandStationEnum.TaskShowType.Normal

				gohelper.setActive(self._simagenormalbg, isNormalShowType)
				gohelper.setActive(self._simagenormalbg2, not isNormalShowType)
				gohelper.setActive(self._goxunyou, not isNormalShowType and atMO.config.taskType == CommandStationEnum.TaskShowType.Parade)
				gohelper.setActive(self._gocatch, not isNormalShowType and atMO.config.taskType == CommandStationEnum.TaskShowType.Overseas)
				gohelper.setActive(self._gospring, not isNormalShowType and atMO.config.taskType == CommandStationEnum.TaskShowType.Spring)
			end
		end
	end
end

function CommandStationTaskItem:_getActStatus(atMO)
	if CommandStationTaskListModel.instance:isCatchTaskType() then
		return true
	end

	TaskDispatcher.cancelTask(self._delayRefreshActivityStatus, self)

	if atMO.config then
		local activityId = atMO.config.activityid

		if not activityId or activityId <= 0 then
			return true
		end

		local status = ActivityHelper.getActivityStatus(activityId)

		if status == ActivityEnum.ActivityStatus.NotOpen then
			gohelper.setActive(self._gounopen, true)

			local second = ActivityModel.instance:getActStartTime(activityId) / 1000 - ServerTime.now()
			local timeStr = string.format("%s%s", TimeUtil.secondToRoughTime2(second))

			self._txtUnOpen.text = string.format(luaLang("seasonmainview_timeopencondition"), timeStr)

			TaskDispatcher.runDelay(self._delayRefreshActivityStatus, self, second)

			return false
		end

		if status == ActivityEnum.ActivityStatus.Expired then
			gohelper.setActive(self._goexpire, true)

			local disableImg = gohelper.findChild(self._goexpire, "image_Disable")
			local finishImg = gohelper.findChild(self._goexpire, "image_ClaimedTick")
			local isFinished = atMO:isFinished()

			gohelper.setActive(disableImg, not isFinished)
			gohelper.setActive(finishImg, isFinished)

			return false
		end

		gohelper.setActive(self._goopen, true)

		local second = ActivityModel.instance:getActEndTime(activityId) / 1000 - ServerTime.now()

		self._txtOpen.text = TimeUtil.SecondToActivityTimeFormat(second)

		TaskDispatcher.runDelay(self._delayRefreshActivityStatus, self, second)

		return true
	end
end

function CommandStationTaskItem:_delayRefreshActivityStatus()
	self:_refreshUI()
end

function CommandStationTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function CommandStationTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end

	TaskDispatcher.cancelTask(self._delayRefreshActivityStatus, self)
end

CommandStationTaskItem.prefabPath = "ui/viewres/commandstation/commandstation_taskitem.prefab"

return CommandStationTaskItem
