-- chunkname: @modules/logic/task/view/TaskListNoviceNormalItem.lua

module("modules.logic.task.view.TaskListNoviceNormalItem", package.seeall)

local TaskListNoviceNormalItem = class("TaskListNoviceNormalItem", LuaCompBase)

function TaskListNoviceNormalItem:init(go, index, co, open, parentScrollGO)
	self.go = go
	self._index = index
	self._mo = co
	self._simagebg = gohelper.findChildSingleImage(self.go, "#simage_bg")
	self._txtprogress = gohelper.findChildText(self.go, "#txt_progress")
	self._txtmaxprogress = gohelper.findChildText(self.go, "#txt_maxprogress")
	self._txttaskdes = gohelper.findChildText(self.go, "#txt_taskdes")
	self._scrollreward = gohelper.findChild(self.go, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._gorewards = gohelper.findChild(self.go, "scroll_reward/Viewport/#go_rewards")
	self._gorewarditem = gohelper.findChild(self.go, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")
	self._gonotget = gohelper.findChild(self.go, "#go_notget")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.go, "#go_notget/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButton(self.go, "#go_notget/#btn_finishbg")
	self._goblackmask = gohelper.findChild(self.go, "#go_blackmask")
	self._golock = gohelper.findChild(self.go, "#go_lock")
	self._txttips = gohelper.findChildText(self.go, "#go_lock/#txt_tips")
	self._txtcondition = gohelper.findChildText(self.go, "#go_lock/#txt_condition")
	self._goget = gohelper.findChild(self.go, "#go_get")
	self._goclick = gohelper.findChild(self.go, "click")
	self._simageclickmask = gohelper.findChildSingleImage(self.go, "click/getmask")
	self._itemAni = self.go:GetComponent(typeof(UnityEngine.Animator))

	self._simagebg:LoadImage(ResUrl.getTaskBg("bg_youdi"))
	self._simageclickmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))

	self._rewardItems = {}

	self:addEvents()
	self:_refreshItem()

	if open then
		self._itemAni:Play(UIAnimationName.Open)
	else
		self._itemAni:Play(UIAnimationName.Idle)
	end

	self._scrollreward.parentGameObject = parentScrollGO
end

function TaskListNoviceNormalItem:reset(index, co)
	self._index = index
	self._mo = co

	self:_refreshItem()
	self._itemAni:Play(UIAnimationName.Idle)
end

function TaskListNoviceNormalItem:getTaskId()
	return self._mo.id
end

function TaskListNoviceNormalItem:hasFinished()
	return self._mo.finishCount >= self._mo.config.maxFinishCount
end

function TaskListNoviceNormalItem:getTaskMinType()
	return TaskEnum.TaskMinType.Novice
end

function TaskListNoviceNormalItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
end

function TaskListNoviceNormalItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
end

function TaskListNoviceNormalItem:_btnnotfinishbgOnClick()
	local jumpId = self._mo.config.jumpId

	if jumpId ~= 0 then
		TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem)
		GameFacade.jump(jumpId)
	end
end

function TaskListNoviceNormalItem:_btnfinishbgOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(self._goclick, true)
	self._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")

	local param = {}

	param.num = TaskConfig.instance:gettaskNoviceConfig(self._mo.id).activity
	param.taskType = TaskEnum.TaskType.Novice

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, param)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, 0.76)
end

function TaskListNoviceNormalItem:_onPlayActAniFinished()
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
	self:destroy()
end

function TaskListNoviceNormalItem:_refreshItem()
	self._txtprogress.text = tostring(self._mo.progress)
	self._txtprogress.fontSize = GameUtil.utf8len(tostring(self._mo.progress)) > 2 and 50 or 72
	self._txtmaxprogress.text = tostring(self._mo.config.maxProgress)
	self._txttaskdes.text = self._mo.config.desc

	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = {}

	local rewards = string.split(self._mo.config.bonus, "|")

	self._gorewards:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #rewards > 2

	for i = 1, #rewards do
		local item = {}

		item.parentGo = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(item.parentGo, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.parentGo)

		item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		item.itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(40)
		item.itemIcon:showStackableNum2()
		item.itemIcon:setHideLvAndBreakFlag(true)
		item.itemIcon:hideEquipLvAndBreak(true)
		table.insert(self._rewardItems, item)
	end

	if self._mo.finishCount >= self._mo.config.maxFinishCount then
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._goget, true)
		gohelper.setActive(self._gonotget, false)
		gohelper.setActive(self._goblackmask.gameObject, true)
	elseif self._mo.hasFinished then
		gohelper.setActive(self._btnfinishbg.gameObject, true)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._goget, false)
		gohelper.setActive(self._gonotget, true)
		gohelper.setActive(self._goblackmask.gameObject, false)
	else
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, self._mo.config.jumpId ~= 0)
		gohelper.setActive(self._goget, false)
		gohelper.setActive(self._gonotget, true)
		gohelper.setActive(self._goblackmask.gameObject, false)
	end

	gohelper.setActive(self._golock, self._mo.lock)

	if self._mo.lock then
		self._txttips.text = string.format(luaLang("activitynovicetaskview_tasktips"), self._mo.config.stage - 1)
		self._txtcondition.text = "PART" .. tostring(self._mo.config.stage - 1)

		gohelper.setActive(self._goblackmask.gameObject, true)
	end
end

function TaskListNoviceNormalItem:destroy()
	TaskDispatcher.cancelTask(self._onPlayClickFinished, self)
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.go then
		gohelper.destroy(self.go)

		self.go = nil
	end

	self:removeEvents()
	self._simagebg:UnLoadImage()
	self._simageclickmask:UnLoadImage()

	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()

		self._rewardItems = nil
	end
end

return TaskListNoviceNormalItem
