-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/view/MiniPartyTaskItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.view.MiniPartyTaskItem", package.seeall)

local MiniPartyTaskItem = class("MiniPartyTaskItem", LuaCompBase)

function MiniPartyTaskItem:init(go, taskType)
	self.go = go
	self._taskType = taskType
	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.go, "#go_normal/simage_normalbg")
	self._gohas = gohelper.findChild(self.go, "#go_normal/has")
	self._txtnum = gohelper.findChildText(self.go, "#go_normal/has/progress/txt_num")
	self._txttotal = gohelper.findChildText(self.go, "#go_normal/has/progress/txt_num/txt_total")
	self._txttaskdes = gohelper.findChildText(self.go, "#go_normal/has/txt_taskdes")
	self._goScroll = gohelper.findChild(self.go, "#go_normal/has/scroll_rewards")
	self._gorewards = gohelper.findChild(self.go, "#go_normal/has/scroll_rewards/Viewport/go_rewards")
	self._gorewarditem = gohelper.findChild(self.go, "#go_normal/has/scroll_rewards/Viewport/go_rewards/go_item")
	self._goempty = gohelper.findChild(self.go, "#go_normal/empty")
	self._gonojump = gohelper.findChild(self.go, "#go_normal/go_nojump")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.go, "#go_normal/btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.go, "#go_normal/btn_finishbg")
	self._gotimelimittag = gohelper.findChild(self.go, "#go_normal/go_timeLimitTag")
	self._txttime = gohelper.findChildText(self.go, "#go_normal/go_timeLimitTag/image_Tag/txt_time")
	self._goweektag = gohelper.findChild(self.go, "#go_normal/go_weekTag")
	self._godailytag = gohelper.findChild(self.go, "#go_normal/go_dailyTag")
	self._goallfinish = gohelper.findChild(self.go, "#go_normal/go_allfinish")
	self._gonormalclick = gohelper.findChild(self.go, "#go_normal/click")
	self._gogetall = gohelper.findChild(self.go, "go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.go, "go_getall/simage_getallbg")
	self._gotips2 = gohelper.findChild(self.go, "go_getall/layout/text_Tips2")
	self._btngetall = gohelper.findChildButtonWithAudio(self.go, "go_getall/btn_getall/btn_getall")
	self._rewardItems = {}

	gohelper.setActive(self._gorewards, true)

	self._itemAnim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._limitScroll = self._goScroll:GetComponent(gohelper.Type_LimitedScrollRect)

	self:_addEvents()
end

function MiniPartyTaskItem:setScrollParentGo(go)
	self._limitScroll.parentGameObject = go
end

function MiniPartyTaskItem:showItem(show, itemType)
	gohelper.setActive(self.go, show)

	if show then
		gohelper.setAsFirstSibling(self.go)

		if itemType == MiniPartyEnum.TaskItemType.GetAll then
			gohelper.setActive(self._gonormal, false)
			gohelper.setActive(self._gogetall, true)

			local hasGrouped = MiniPartyModel.instance:hasGrouped()

			gohelper.setActive(self._gotips2, self._taskType and self._taskType == MiniPartyEnum.TaskType.GroupTask and not hasGrouped)
		elseif itemType == MiniPartyEnum.TaskItemType.Waiting then
			gohelper.setActive(self._gonormal, true)
			gohelper.setActive(self._gogetall, false)
			gohelper.setActive(self._gohas, false)
			gohelper.setActive(self._goempty, true)
			gohelper.setActive(self._gonojump, false)
			gohelper.setActive(self._goallfinish, false)
			gohelper.setActive(self._btnnotfinishbg.gameObject, false)
			gohelper.setActive(self._btnfinishbg.gameObject, false)
			gohelper.setActive(self._godailytag, false)
			gohelper.setActive(self._goweektag, false)
			gohelper.setActive(self._gotimelimittag, false)
			gohelper.setActive(self._gonormalclick, false)
		end
	else
		gohelper.setAsLastSibling(self.go)
	end
end

function MiniPartyTaskItem:_addEvents()
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	MiniPartyController.instance:registerCallback(MiniPartyEvent.GetAllTaskReward, self._onGetAllReward, self)
end

function MiniPartyTaskItem:_removeEvents()
	self._btngetall:RemoveClickListener()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	MiniPartyController.instance:unregisterCallback(MiniPartyEvent.GetAllTaskReward, self._onGetAllReward, self)
end

function MiniPartyTaskItem:_btngetallOnClick()
	self._itemAnim:Play("finish", 0, 0)
	MiniPartyController.instance:dispatchEvent(MiniPartyEvent.GetAllTaskReward)
	TaskDispatcher.runDelay(self._realSendFinishAll, self, 0.5)
end

function MiniPartyTaskItem:_realSendFinishAll()
	self._itemAnim:Play("open", 0, 1)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.MiniParty, self._taskType)
end

function MiniPartyTaskItem:_btnnotfinishbgOnClick()
	if self._mo then
		local jumpId = self._mo.config.jumpId

		if jumpId and jumpId > 0 then
			GameFacade.jump(jumpId)
		end
	end
end

function MiniPartyTaskItem:_btnfinishbgOnClick()
	self._itemAnim:Play("finish", 0, 0)
	MiniPartyController.instance:dispatchEvent(MiniPartyEvent.ShowTaskAnim)
	TaskDispatcher.runDelay(self._realSendFinish, self, 0.5)
end

function MiniPartyTaskItem:_realSendFinish()
	self._itemAnim:Play("idle", 0, 0)
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

function MiniPartyTaskItem:_onGetAllReward()
	if not self._mo then
		return
	end

	if self._mo.finishCount > 0 then
		return
	end

	if self._mo.progress < self._mo.config.maxProgress then
		return
	end

	self._itemAnim:Play("finish", 0, 0)
	TaskDispatcher.runDelay(self._getAllFinish, self, 0.5)
end

function MiniPartyTaskItem:_getAllFinish()
	self._itemAnim:Play("idle", 0, 0)
end

function MiniPartyTaskItem:refresh(mo)
	gohelper.setActive(self.go, true)

	self._mo = mo

	gohelper.setActive(self._gogetall, false)
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._gohas, true)
	gohelper.setActive(self._goempty, false)
	gohelper.setActive(self._goallfinish, false)
	gohelper.setActive(self._btnnotfinishbg.gameObject, false)
	gohelper.setActive(self._btnfinishbg.gameObject, false)
	gohelper.setActive(self._gonojump, false)
	gohelper.setActive(self._godailytag, self._mo.config.loopType == TaskEnum.TaskLoopType.Daily)
	gohelper.setActive(self._goweektag, self._mo.config.loopType == TaskEnum.TaskLoopType.Weekly)
	gohelper.setActive(self._gotimelimittag, false)

	if self._mo.config.loopType == TaskEnum.TaskLoopType.Permanent and not LuaUtil.isEmptyStr(self._mo.config.showOfflineTime) and self._mo.progress < self._mo.config.maxProgress then
		local endTime = TimeUtil.stringToTimestamp(self._mo.config.showOfflineTime) - ServerTime.clientToServerOffset()
		local limitTime = endTime - ServerTime.now()

		if limitTime > 0 then
			gohelper.setActive(self._gotimelimittag, true)

			self._txttime.text = TimeUtil.secondToRoughTime3(limitTime)
		else
			gohelper.setActive(self._gotimelimittag, false)
		end
	end

	if self._mo.finishCount > 0 then
		gohelper.setActive(self._goallfinish, true)
	elseif self._mo.progress >= self._mo.config.maxProgress then
		gohelper.setActive(self._btnfinishbg.gameObject, true)
	else
		gohelper.setActive(self._btnnotfinishbg.gameObject, self._mo.config.jumpId ~= 0)
		gohelper.setActive(self._gonojump, self._mo.config.jumpId == 0)
	end

	self._txtnum.text = self._mo.progress
	self._txttaskdes.text = string.format(self._mo.config.desc, self._mo.config.maxProgress)
	self._txttotal.text = GameUtil.numberDisplay(self._mo.config.maxProgress)

	local rewards = string.split(self._mo.config.bonus, "|")

	for i = 1, #rewards do
		if not self._rewardItems[i] then
			self._rewardItems[i] = {}

			local go = gohelper.cloneInPlace(self._gorewarditem)

			gohelper.setActive(go, true)

			self._rewardItems[i].root = go
			self._rewardItems[i].goreward = gohelper.findChild(go, "go_reward")
			self._rewardItems[i].goeffect = gohelper.findChild(go, "go_effected")
			self._rewardItems[i].gouneffect = gohelper.findChild(go, "go_uneffect")
			self._rewardItems[i].itemIcon = IconMgr.instance:getCommonPropItemIcon(self._rewardItems[i].goreward)

			gohelper.setAsFirstSibling(self._rewardItems[i].itemIcon.go)
		end

		gohelper.setActive(self._rewardItems[i].goeffect, false)
		gohelper.setActive(self._rewardItems[i].gouneffect, false)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i].itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		self._rewardItems[i].itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		self._rewardItems[i].itemIcon:setCountFontSize(40)
		self._rewardItems[i].itemIcon:showStackableNum2()
		self._rewardItems[i].itemIcon:setHideLvAndBreakFlag(true)
		self._rewardItems[i].itemIcon:hideEquipLvAndBreak(true)
	end

	if LuaUtil.isEmptyStr(self._mo.config.teamBonus) then
		return
	end

	local groupRewards = string.split(self._mo.config.teamBonus, "|")

	for i = #rewards + 1, #rewards + #groupRewards do
		if not self._rewardItems[i] then
			self._rewardItems[i] = {}

			local go = gohelper.cloneInPlace(self._gorewarditem)

			gohelper.setActive(go, true)

			self._rewardItems[i].root = go
			self._rewardItems[i].goreward = gohelper.findChild(go, "go_reward")
			self._rewardItems[i].goeffect = gohelper.findChild(go, "go_effected")
			self._rewardItems[i].gouneffect = gohelper.findChild(go, "go_uneffect")
			self._rewardItems[i].itemIcon = IconMgr.instance:getCommonPropItemIcon(self._rewardItems[i].goreward)

			gohelper.setAsFirstSibling(self._rewardItems[i].itemIcon.go)
		end

		local hasGrouped = MiniPartyModel.instance:hasGrouped()

		gohelper.setActive(self._rewardItems[i].goeffect, hasGrouped)
		gohelper.setActive(self._rewardItems[i].gouneffect, not hasGrouped)

		local itemCo = string.splitToNumber(groupRewards[i - #rewards], "#")

		self._rewardItems[i].itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		self._rewardItems[i].itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		self._rewardItems[i].itemIcon:setCountFontSize(40)
		self._rewardItems[i].itemIcon:showStackableNum2()
		self._rewardItems[i].itemIcon:setHideLvAndBreakFlag(true)
		self._rewardItems[i].itemIcon:hideEquipLvAndBreak(true)
	end
end

function MiniPartyTaskItem:destroy()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._realSendFinishAll, self)
	TaskDispatcher.cancelTask(self._realSendFinish, self)

	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()

		self._rewardItems = nil
	end
end

return MiniPartyTaskItem
