-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpTaskItem.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpTaskItem", package.seeall)

local ActivityWarmUpTaskItem = class("ActivityWarmUpTaskItem", LuaCompBase)

function ActivityWarmUpTaskItem:onInitView()
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#txt_taskdes")
	self._txtprogress = gohelper.findChildText(self.viewGO, "#txt_progress")
	self._txtmaxprogress = gohelper.findChildText(self.viewGO, "#txt_maxprogress")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gorewarditem = gohelper.findChild(self.viewGO, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")
	self._goget = gohelper.findChild(self.viewGO, "#go_get")
	self._gonotget = gohelper.findChild(self.viewGO, "#go_notget")
	self._goblackmask = gohelper.findChild(self.viewGO, "#go_blackmask")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_notget/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_notget/#btn_finishbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWarmUpTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
end

function ActivityWarmUpTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
end

function ActivityWarmUpTaskItem:initData(index, go)
	self._index = index
	self.viewGO = go

	self:onInitView()
	self:addEvents()
	gohelper.setActive(self.viewGO, false)
	self._animSelf:Play(UIAnimationName.Open, 0, 0)
end

function ActivityWarmUpTaskItem:onDestroy()
	UIBlockMgr.instance:endBlock(ActivityWarmUpTaskItem.BLOCK_KEY)
	TaskDispatcher.cancelTask(self.onFinishAnimCompleted, self)
	self:removeEvents()
	self:onDestroyView()
end

function ActivityWarmUpTaskItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simagebg:LoadImage(ResUrl.getActivityWarmUpBg("bg_rwdi"))

	self._animSelf = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animSelf.enabled = true
	self._iconList = {}
end

function ActivityWarmUpTaskItem:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, v in pairs(self._iconList) do
		gohelper.setActive(v.go, true)
		gohelper.destroy(v.go)
	end

	self._iconList = nil
end

function ActivityWarmUpTaskItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshInfo()
	self:refreshAllRewardIcons()
end

function ActivityWarmUpTaskItem:refreshInfo()
	local cfg = self._mo.config

	self._txttaskdes.text = cfg.desc
	self._txtprogress.text = tostring(self._mo:getProgress())
	self._txtmaxprogress.text = tostring(cfg.maxProgress)

	if self._mo:isLock() then
		gohelper.setActive(self._goblackmask, true)
		gohelper.setActive(self._goget, false)
		gohelper.setActive(self._gonotget, true)
		gohelper.setActive(self._btnnotfinishbg.gameObject, true)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
	else
		self:refreshButtonRunning()
	end
end

function ActivityWarmUpTaskItem:refreshButtonRunning()
	if self._mo:alreadyGotReward() then
		self:refreshWhenFinished()
	else
		gohelper.setActive(self._goblackmask, false)

		if self._mo:isFinished() then
			gohelper.setActive(self._goget, false)
			gohelper.setActive(self._gonotget, true)
			gohelper.setActive(self._btnnotfinishbg.gameObject, false)
			gohelper.setActive(self._btnfinishbg.gameObject, true)
		else
			gohelper.setActive(self._goget, false)
			gohelper.setActive(self._gonotget, true)
			gohelper.setActive(self._btnnotfinishbg.gameObject, true)
			gohelper.setActive(self._btnfinishbg.gameObject, false)
		end
	end
end

function ActivityWarmUpTaskItem:refreshWhenFinished()
	gohelper.setActive(self._goblackmask, true)
	gohelper.setActive(self._goget, true)
	gohelper.setActive(self._gonotget, false)
end

function ActivityWarmUpTaskItem:refreshAllRewardIcons()
	self:hideAllRewardIcon()

	local bonusList = string.split(self._mo.config.bonus, "|")

	for i = 1, #bonusList do
		local item = self:getOrCreateIcon(i)

		gohelper.setActive(item.go, true)

		local bonusArr = string.splitToNumber(bonusList[i], "#")

		item.itemIcon:setMOValue(bonusArr[1], bonusArr[2], bonusArr[3], nil, true)
		item.itemIcon:isShowCount(bonusArr[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(40)
		item.itemIcon:showStackableNum2()
		item.itemIcon:setHideLvAndBreakFlag(true)
		item.itemIcon:hideEquipLvAndBreak(true)
	end
end

function ActivityWarmUpTaskItem:getOrCreateIcon(index)
	local item = self._iconList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(item.go, true)

		item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.go)
		self._iconList[index] = item
	end

	return item
end

function ActivityWarmUpTaskItem:hideAllRewardIcon()
	for _, iconItem in pairs(self._iconList) do
		gohelper.setActive(iconItem.go, false)
	end
end

function ActivityWarmUpTaskItem:_btnnotfinishbgOnClick()
	local day = self._mo.config.openDay

	ActivityWarmUpController.instance:switchTab(day)
	ActivityWarmUpTaskController.instance:dispatchEvent(ActivityWarmUpEvent.TaskListNeedClose)
end

ActivityWarmUpTaskItem.BLOCK_KEY = "ActivityWarmUpTaskItemBlock"

function ActivityWarmUpTaskItem:_btnfinishbgOnClick()
	self:refreshWhenFinished()
	self._animSelf:Play("finish", 0, 0)
	UIBlockMgr.instance:startBlock(ActivityWarmUpTaskItem.BLOCK_KEY)
	TaskDispatcher.runDelay(self.onFinishAnimCompleted, self, 0.4)
end

function ActivityWarmUpTaskItem:onFinishAnimCompleted()
	UIBlockMgr.instance:endBlock(ActivityWarmUpTaskItem.BLOCK_KEY)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(self._goclick, true)
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

return ActivityWarmUpTaskItem
