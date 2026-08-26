-- chunkname: @modules/logic/task/view/TaskListNoviceGrowItem.lua

module("modules.logic.task.view.TaskListNoviceGrowItem", package.seeall)

local TaskListNoviceGrowItem = class("TaskListNoviceGrowItem", LuaCompBase)

function TaskListNoviceGrowItem:init(go, index, co, open, parentScrollGO)
	self.go = go
	self._index = index
	self._mo = co
	self._txttaskdes = gohelper.findChildText(self.go, "#txt_taskdes")
	self._txttasktitle = gohelper.findChildText(self.go, "#txt_taskdes/#txt_title")
	self._scrollreward = gohelper.findChild(self.go, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._gorewards = gohelper.findChild(self.go, "scroll_reward/Viewport/#go_rewards")
	self._gorewarditem = gohelper.findChild(self.go, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")
	self._goblackmask = gohelper.findChild(self.go, "#go_blackmask")
	self._goget = gohelper.findChild(self.go, "#go_get")
	self._gonotget = gohelper.findChild(self.go, "#go_notget")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.go, "#go_notget/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButton(self.go, "#go_notget/#btn_finishbg")
	self._simageroleicon = gohelper.findChildSingleImage(self.go, "#simage_roleicon")
	self._simagebg = gohelper.findChildSingleImage(self.go, "#simage_bg")
	self._goclick = gohelper.findChild(self.go, "click")
	self._simageclickmask = gohelper.findChildSingleImage(self.go, "click/getmask")
	self._itemAni = self.go:GetComponent(typeof(UnityEngine.Animator))

	self._simagebg:LoadImage(ResUrl.getTaskBg("bg_youdi2"))
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

function TaskListNoviceGrowItem:reset(index, co)
	self._index = index
	self._mo = co

	self:_refreshItem()
	self._itemAni:Play(UIAnimationName.Idle)
end

function TaskListNoviceGrowItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
end

function TaskListNoviceGrowItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
end

function TaskListNoviceGrowItem:_btnnotfinishbgOnClick()
	local jumpId = self._mo.config.jumpId

	if jumpId ~= 0 then
		TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem)
		GameFacade.jump(jumpId)
	end
end

function TaskListNoviceGrowItem:_btnfinishbgOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(self._goclick, true)
	self._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")

	local num = TaskConfig.instance:gettaskNoviceConfig(self._mo.id).activity
	local list = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice)
	local growCount = 0

	for i = 1, #list do
		if list[i].config.minTypeId == TaskEnum.TaskMinType.GrowBack and list[i].finishCount < list[i].config.maxFinishCount then
			growCount = growCount + 1
		end
	end

	local param = {}

	param.num = num
	param.taskType = TaskEnum.TaskType.Novice
	param.force = false
	param.growCount = growCount

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, param)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, 0.76)
end

function TaskListNoviceGrowItem:_onPlayActAniFinished()
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
	self:destroy()
end

function TaskListNoviceGrowItem:getTaskId()
	return self._mo.id
end

function TaskListNoviceGrowItem:hasFinished()
	return self._mo.finishCount >= self._mo.config.maxFinishCount
end

function TaskListNoviceGrowItem:getTaskMinType()
	return TaskEnum.TaskMinType.GrowBack
end

function TaskListNoviceGrowItem:_refreshItem()
	local roleCo = HeroConfig.instance:getHeroCO(tonumber(self._mo.config.listenerParam))

	self._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(roleCo.skinId))

	self._txttaskdes.text = self._mo.config.desc
	self._txttasktitle.text = self._mo.config.listenerType == "HeroRank" and luaLang("taskitem_growtask2") or luaLang("taskitem_growtask1")

	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = {}

	local rewards = string.split(self._mo.config.bonus, "|")

	self._gorewards:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #rewards > 3

	for i = 1, #rewards do
		local item = {}

		item.parentGo = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(item.parentGo, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.parentGo)

		item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		item.itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(47)
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
end

function TaskListNoviceGrowItem:destroy()
	TaskDispatcher.cancelTask(self._onPlayClickFinished, self)
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.go then
		gohelper.destroy(self.go)

		self.go = nil
	end

	self:removeEvents()
	self._simagebg:UnLoadImage()
	self._simageroleicon:UnLoadImage()
	self._simageclickmask:UnLoadImage()

	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = nil
end

return TaskListNoviceGrowItem
