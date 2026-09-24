-- chunkname: @modules/logic/college/view/task/CollegeTaskListItem.lua

module("modules.logic.college.view.task.CollegeTaskListItem", package.seeall)

local CollegeTaskListItem = class("CollegeTaskListItem", MixScrollCell)

function CollegeTaskListItem:init(go)
	self.go = go
	self._goTag = gohelper.findChild(self.go, "#go_Tag")
	self._goLockTag = gohelper.findChild(self.go, "#go_Tag/#go_LockTag")
	self._txtTag1 = gohelper.findChildText(self.go, "#go_Tag/#go_LockTag/title/#txt_Tag1")
	self._goNormalTag = gohelper.findChild(self.go, "#go_Tag/#go_NormalTag")
	self._txtTag2 = gohelper.findChildText(self.go, "#go_Tag/#go_NormalTag/title/#txt_Tag2")
	self._goFinishTag = gohelper.findChild(self.go, "#go_Tag/#go_FinishTag")
	self._txtTag3 = gohelper.findChildText(self.go, "#go_Tag/#go_FinishTag/title/#txt_Tag3")
	self._txtNum = gohelper.findChildText(self.go, "#go_normal/progress/#txt_num")
	self._txtTotal = gohelper.findChildText(self.go, "#go_normal/progress/#txt_num/#txt_total")
	self._txtTaskDesc = gohelper.findChildText(self.go, "#go_normal/#txt_taskdes")
	self._goRewards = gohelper.findChild(self.go, "#go_normal/#scroll_rewards/Viewport/#go_Rewards")
	self._goRewardItem = gohelper.findChild(self.go, "#go_normal/#scroll_rewards/Viewport/#go_Rewards/#go_RewardItem")
	self._btnJump = gohelper.findChildButtonWithAudio(self.go, "#go_normal/#btn_Jump")
	self._goDoing = gohelper.findChild(self.go, "#go_normal/#go_Doing")
	self._goFinish = gohelper.findChild(self.go, "#go_normal/#go_Finish")
	self._goLock = gohelper.findChild(self.go, "#go_normal/#go_Lock")
	self._animator = gohelper.findComponentAnim(self.go)
	self._animator.keepAnimatorStateOnDisable = true
	self._animator.speed = 0

	self._animator:Play(0, 0, 0)
	self._animator:Update(0)
end

function CollegeTaskListItem:addEventListeners()
	self._btnJump:AddClickListener(self._btnJumpOnClick, self)
end

function CollegeTaskListItem:removeEventListeners()
	self._btnJump:RemoveClickListener()
end

function CollegeTaskListItem:_btnJumpOnClick()
	if not CollegeJumpHelper.instance:jumpTo(self._config.jumpId) then
		ViewMgr.instance:closeView(ViewName.CollegeTaskView)
	end
end

function CollegeTaskListItem:onUpdateMO(mo, mixType, param)
	self._mo = mo
	self._mixType = mixType
	self._config = self._mo and self._mo.co

	self:refreshState()
	self:refreshUI()
	self:checkPlayAnim()
end

function CollegeTaskListItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	if self._isPlay then
		return
	end

	local delayTime = CollegeTaskListModel.instance:getDelayPlayTime(self._index)

	if delayTime <= 0 then
		self._animator:Play(0, 0, 1)
	else
		self._animator:Play(0, 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end

	self._isPlay = true
end

function CollegeTaskListItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	self._animator.speed = 1
end

function CollegeTaskListItem:refreshState()
	if self._config then
		local sceneMo = CollegeModel.instance:getSceneMo()
		local prop = sceneMo and sceneMo.prop

		if prop then
			if not prop.stage then
				local curStage = 0
				local curStageIndex = CollegeConfig.instance:getStageSortIndex(curStage)

				self._taskStageIndex = CollegeConfig.instance:getStageSortIndex(self._config)
				self._state = self._mo and self._mo.state
				self._isFinish = self._state == CollegeEnum.TaskState.Reward
				self._isDoing = self._state == CollegeEnum.TaskState.Doing and curStageIndex == self._taskStageIndex
				self._isLock = curStageIndex < self._taskStageIndex
			end
		end
	end
end

function CollegeTaskListItem:refreshUI()
	self:refreshTag()
	self:refreshTask()
end

function CollegeTaskListItem:refreshTag()
	local showTag = self._mixType == CollegeEnum.TaskMixType.First

	gohelper.setActive(self._goTag, showTag)

	if not showTag then
		return
	end

	gohelper.setActive(self._goLockTag, self._isLock)
	gohelper.setActive(self._goNormalTag, self._isDoing)
	gohelper.setActive(self._goFinishTag, self._isFinish)

	local curStageIndexCn = GameUtil.getNum2Chinese(self._taskStageIndex)
	local tagStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_task_stage"), curStageIndexCn)

	if self._isLock then
		local lastStageIndexCn = GameUtil.getNum2Chinese(self._taskStageIndex - 1)

		tagStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("college_task_stagelocktips"), curStageIndexCn, lastStageIndexCn)
	end

	self._txtTag1.text = tagStr
	self._txtTag2.text = tagStr
	self._txtTag3.text = tagStr
end

function CollegeTaskListItem:refreshTask()
	if self._config then
		if self._config then
			if not self._config.maxProgress then
				local maxProgress = 0

				if self._mo then
					if not self._mo.progress then
						local progress = 0

						self._txtTaskDesc.text = CollegeHelper.instance:replaceColor(self._config)
						self._txtTotal.text = maxProgress
						self._txtNum.text = progress

						gohelper.setActive(self._goLock, self._isLock)
						gohelper.setActive(self._goFinish, self._isFinish)

						local canJump = not string.nilorempty(self._config.jumpId)

						gohelper.setActive(self._btnJump.gameObject, self._isDoing and canJump)
						gohelper.setActive(self._goDoing, self._isDoing and not canJump)

						if self._mo then
							gohelper.CreateObjList(self, self._refreshRewardItem, self._mo or {}, self._goRewards, self._goRewardItem)
						end
					end
				end
			end
		end
	end
end

function CollegeTaskListItem:_refreshRewardItem(goReward, rewardInfo, index)
	local imageIcon = gohelper.findChildImage(goReward, "image_RewardIcon")
	local txtNum = gohelper.findChildText(goReward, "txt_RewardNum")

	txtNum.text = rewardInfo[2] or 0

	CollegeIconHelper.setItemIcon(rewardInfo[1], imageIcon)
end

function CollegeTaskListItem:onDestroy()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
end

return CollegeTaskListItem
