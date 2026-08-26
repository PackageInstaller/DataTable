-- chunkname: @modules/logic/task/view/TaskListCommonLevelItem.lua

module("modules.logic.task.view.TaskListCommonLevelItem", package.seeall)

local TaskListCommonLevelItem = class("TaskListCommonLevelItem", LuaCompBase)

function TaskListCommonLevelItem:init(go, parentScrollGO)
	self.go = go
	self._tag = gohelper.findChildText(go, "tag")
	self._goflagcontent = gohelper.findChild(go, "flagitem")
	self._goflag = gohelper.findChild(go, "flagitem/#go_flag")
	self._scrollreward = gohelper.findChild(go, "rewarditem"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._gorewardcontent = gohelper.findChild(go, "rewarditem/viewport/content")
	self._gomaskbg = gohelper.findChild(go, "go_maskbg")
	self._gomask = gohelper.findChild(go, "go_maskbg/maskcontainer")
	self._itemAni = go:GetComponent(typeof(UnityEngine.Animator))
	self._itemAni.enabled = false
	self._maskAni = self._gomaskbg:GetComponent(typeof(UnityEngine.Animator))
	self._maskAni.enabled = false
	self._maskCanvasGroup = self._gomaskbg:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._getAct = 0
	self._gocanvasgroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._scrollreward.parentGameObject = parentScrollGO

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCheckPlayRewardGet, self)
end

function TaskListCommonLevelItem:_onPlayActState(param)
	if param.taskType == TaskEnum.TaskType.Novice or param.num < 1 then
		return
	end

	if self._taskType ~= param.taskType then
		return
	end

	TaskDispatcher.cancelTask(self._flagPlayUpdate, self)

	local addNum = self:_getAddNum(param.num)

	if addNum < 1 then
		return
	end

	self._totalAct = self._getAct + addNum

	if addNum > 0 then
		self._flagupdateCount = 0

		TaskDispatcher.runRepeat(self._flagPlayUpdate, self, 0.06, addNum)
	end
end

function TaskListCommonLevelItem:_getAddNum(num)
	local actMo = TaskModel.instance:getTaskActivityMO(self._taskType)

	if self._index <= actMo.defineId then
		return 0
	end

	local totalNum = 0

	for i = actMo.defineId + 1, self._index do
		totalNum = totalNum + TaskConfig.instance:gettaskactivitybonusCO(self._taskType, i).needActivity
	end

	local curTotal = TaskConfig.instance:gettaskactivitybonusCO(self._taskType, self._index).needActivity
	local beyondNum = actMo.value - actMo.gainValue + num - totalNum

	return beyondNum >= 0 and (self._index == actMo.defineId + 1 and curTotal - (actMo.value - actMo.gainValue) or curTotal) or self._index == actMo.defineId + 1 and num or num + (actMo.value - actMo.gainValue) - (totalNum - curTotal)
end

function TaskListCommonLevelItem:_flagPlayUpdate()
	self._flagupdateCount = self._flagupdateCount + 1

	if self._flagupdateCount + self._getAct > #self._flags then
		TaskDispatcher.cancelTask(self._flagPlayUpdate, self)

		return
	end

	gohelper.setActive(self._flags[self._flagupdateCount + self._getAct].go, true)
	self._flags[self._flagupdateCount + self._getAct].ani:Play("play")

	if self._flagupdateCount + self._getAct >= self._totalAct then
		for i = self._getAct, self._totalAct - 1 do
			UISpriteSetMgr.instance:setCommonSprite(self._flags[i + 1].img, "logo_huoyuedu")
		end

		self._getAct = self._totalAct

		local totalNum = TaskConfig.instance:gettaskactivitybonusCO(self._taskType, self._index).needActivity

		if totalNum <= self._getAct then
			self._needOpen = true
		end

		TaskDispatcher.cancelTask(self._flagPlayUpdate, self)
	end
end

function TaskListCommonLevelItem:_onCheckPlayRewardGet(viewName)
	if viewName == ViewName.CommonPropView and self._needOpen and self._maskCanvasGroup then
		self._maskCanvasGroup.alpha = 1
		self._maskAni.enabled = true

		self._maskAni:Play(UIAnimationName.Open)

		self._needOpen = false
	end
end

function TaskListCommonLevelItem:setItem(index, co, type, open)
	self._index = index
	self._mo = co
	self._taskType = type

	TaskController.instance:registerCallback(TaskEvent.RefreshActState, self._onPlayActState, self)

	local actMo = TaskModel.instance:getTaskActivityMO(self._taskType)
	local totalAct = 0
	local boCo = TaskConfig.instance:getTaskActivityBonusConfig(self._taskType)

	for i = 1, #boCo do
		totalAct = totalAct + boCo[i].needActivity
	end

	if self._index <= actMo.defineId and totalAct > actMo.value then
		self._maskCanvasGroup.alpha = 1
		self._maskAni.enabled = true

		if open then
			self._maskAni:Play(UIAnimationName.Open)
		else
			self._maskAni:Play(UIAnimationName.Idle)
		end
	else
		self._maskCanvasGroup.alpha = 0
		self._itemAni.enabled = true
		self._gocanvasgroup.alpha = 1
	end

	self._tag.text = string.format("%02d", self._index)

	if open then
		self._gocanvasgroup.alpha = 0
		self._itemAni.enabled = false

		local totalStage = TaskModel.instance:getMaxStage(self._taskType)
		local curStage = TaskModel.instance:getTaskActivityMO(self._taskType).defineId + 1

		if totalStage - curStage >= 5 then
			if not (curStage - 1) then
				local hideNum = totalStage - 5

				TaskDispatcher.runDelay(self._playStartAni, self, 0.04 * (self._index - hideNum + 1))
			end
		end
	else
		self._gocanvasgroup.alpha = 1
		self._itemAni.enabled = true

		self._itemAni:Play(UIAnimationName.Idle)
		self:_setFlagItem()
		self:_setRewardItem()
	end
end

function TaskListCommonLevelItem:showAllComplete()
	self._maskCanvasGroup.alpha = 1

	self._maskAni:Play(UIAnimationName.Idle)
	gohelper.setActive(self._gomask, false)
end

function TaskListCommonLevelItem:_playStartAni()
	self._gocanvasgroup.alpha = 1
	self._itemAni.enabled = true

	self._itemAni:Play(UIAnimationName.Open)
	self:_setFlagItem(true)
	self:_setRewardItem()
end

function TaskListCommonLevelItem:_setFlagItem(open)
	if self._flags then
		for _, v in pairs(self._flags) do
			gohelper.destroy(v.go)
		end
	end

	self._getAct = 0
	self._flags = self:getUserDataTb_()

	local totalNum = TaskConfig.instance:gettaskactivitybonusCO(self._taskType, self._index).needActivity
	local actMo = TaskModel.instance:getTaskActivityMO(self._taskType)

	if self._index <= actMo.defineId then
		self._getAct = totalNum
	elseif self._index == actMo.defineId + 1 then
		self._getAct = actMo.value - actMo.gainValue
	end

	for i = 1, totalNum do
		local child = gohelper.cloneInPlace(self._goflag.gameObject)

		gohelper.setActive(child, not open)

		local flag = {}

		flag.go = child
		flag.idle = gohelper.findChild(flag.go, "idle")

		gohelper.setActive(flag.idle, true)

		flag.img = gohelper.findChildImage(flag.go, "idle")

		local spr = i <= self._getAct and "logo_huoyuedu" or "logo_huoyuedu_dis"

		UISpriteSetMgr.instance:setCommonSprite(flag.img, spr)

		flag.play = gohelper.findChild(flag.go, "play")

		gohelper.setActive(flag.play, false)

		flag.ani = flag.go:GetComponent(typeof(UnityEngine.Animator))

		flag.ani:Play(UIAnimationName.Idle)
		table.insert(self._flags, flag)
	end

	self._flagopenCount = 0

	if open then
		TaskDispatcher.cancelTask(self._flagOpenUpdate, self)
		TaskDispatcher.runRepeat(self._flagOpenUpdate, self, 0.03, totalNum)
	end
end

function TaskListCommonLevelItem:_flagOpenUpdate()
	self._flagopenCount = self._flagopenCount + 1

	gohelper.setActive(self._flags[self._flagopenCount].go, true)
	self._flags[self._flagopenCount].ani:Play(UIAnimationName.Open)
end

function TaskListCommonLevelItem:_setRewardItem()
	if self._rewardItems then
		for _, v in pairs(self._rewardItems) do
			gohelper.destroy(v.go)
			v:onDestroy()
		end
	end

	self._rewardItems = self:getUserDataTb_()

	local rewards = string.split(TaskConfig.instance:gettaskactivitybonusCO(self._taskType, self._index).bonus, "|")

	for i = 1, #rewards do
		self._rewardItems[i] = IconMgr.instance:getCommonPropItemIcon(self._gorewardcontent)

		local infos = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i]:setMOValue(infos[1], infos[2], infos[3], nil, true)
		transformhelper.setLocalScale(self._rewardItems[i].go.transform, 0.6, 0.6, 1)
		self._rewardItems[i]:setCountFontSize(50)
		self._rewardItems[i]:showStackableNum2()
		self._rewardItems[i]:isShowEffect(true)
		self._rewardItems[i]:setHideLvAndBreakFlag(true)
		self._rewardItems[i]:hideEquipLvAndBreak(true)
		gohelper.setActive(self._rewardItems[i].go, true)
	end
end

function TaskListCommonLevelItem:destroy()
	TaskDispatcher.cancelTask(self._playStartAni, self)
	TaskDispatcher.cancelTask(self._flagOpenUpdate, self)
	TaskDispatcher.cancelTask(self._flagPlayUpdate, self)
	TaskController.instance:unregisterCallback(TaskEvent.RefreshActState, self._onPlayActState, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCheckPlayRewardGet, self)

	if self._rewardItems then
		for _, v in pairs(self._rewardItems) do
			gohelper.destroy(v.go)
			v:onDestroy()
		end

		self._rewardItems = nil
	end

	if self._flags then
		for _, v in pairs(self._flags) do
			gohelper.destroy(v.go)
		end

		self._flags = nil
	end
end

return TaskListCommonLevelItem
