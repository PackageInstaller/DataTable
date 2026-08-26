-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonTaskItem.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonTaskItem", package.seeall)

local AtomicDungeonTaskItem = class("AtomicDungeonTaskItem", ListScrollCellExtend)

function AtomicDungeonTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._goscrollRewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._gonojump = gohelper.findChild(self.viewGO, "#go_normal/#go_nojump")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnormalOnClick, self)
	self._btnfinishbg:AddClickListener(self._btncangetOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
	AtomicDungeonController.instance:registerCallback(AtomicDungeonEvent.AtomicDungeonTaskGetAll, self.playFinishAnim, self)
end

function AtomicDungeonTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
	AtomicDungeonController.instance:unregisterCallback(AtomicDungeonEvent.AtomicDungeonTaskGetAll, self.playFinishAnim, self)
end

AtomicDungeonTaskItem.BlockKey = "AtomicDungeonTaskItemRewardGetAnim"
AtomicDungeonTaskItem.TaskMaskTime = 0.65

function AtomicDungeonTaskItem:_btnnormalOnClick()
	if not self.jumpId or self.jumpId == 0 then
		return
	end

	GameFacade.jump(self.jumpId)
end

function AtomicDungeonTaskItem:_btncangetOnClick()
	if not self.taskId and not self.mo.canGetAll then
		return
	end

	if self.mo.canGetAll then
		local canGetIdList = AtomicDungeonTaskModel.instance:getAllCanGetList()

		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.AtomicDungeonTaskGetAll, canGetIdList)
	end

	self._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(AtomicDungeonTaskItem.BlockKey)
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnTaskRewardGetFinish, self._index)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, AtomicDungeonTaskItem.TaskMaskTime)
end

function AtomicDungeonTaskItem:_btngetallOnClick()
	self:_btncangetOnClick()
end

function AtomicDungeonTaskItem:playFinishAnim(taskIdList)
	for _, taskId in ipairs(taskIdList) do
		if taskId == self.taskId then
			self._animator:Play(UIAnimationName.Finish)
			self._animator:Update(0)
		end
	end
end

function AtomicDungeonTaskItem:_onPlayActAniFinished()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.mo.canGetAll then
		local canGetIdList = AtomicDungeonTaskModel.instance:getAllCanGetList()

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.AtomicDungeon, 0, canGetIdList, nil, nil, 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.taskId)
	end

	UIBlockMgr.instance:endBlock(AtomicDungeonTaskItem.BlockKey)
end

function AtomicDungeonTaskItem:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._scrollrewards = self._goscrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
end

function AtomicDungeonTaskItem:onUpdateMO(mo)
	if mo == nil then
		return
	end

	self.mo = mo
	self._scrollrewards.parentGameObject = self._view._csListScroll.gameObject

	if self.mo.canGetAll then
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._gogetall, true)
	else
		gohelper.setActive(self._gonormal, true)
		gohelper.setActive(self._gogetall, false)
		self:refreshNormal()
	end
end

function AtomicDungeonTaskItem:refreshNormal()
	self.taskId = self.mo.id
	self.config = self.mo.config
	self.jumpId = self.config.jumpId
	self._txttaskdes.text = self.config.desc
	self._txtnum.text = self.mo.progress
	self._txttotal.text = self.config.maxProgress

	self:refreshReward()
	self:refreshState()
end

function AtomicDungeonTaskItem:refreshReward()
	local config = self.mo.config

	if string.nilorempty(config.bonus) then
		return
	end

	local rewardList = GameUtil.splitString2(config.bonus, true)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(self._gorewards)
			}
			self.rewardItemTab[index] = rewardItem
		end

		rewardItem.itemIcon:setMOValue(rewardData[1], rewardData[2], rewardData[3], nil, true)
		rewardItem.itemIcon:isShowCount(true)
		rewardItem.itemIcon:setCountFontSize(40)
		rewardItem.itemIcon:showStackableNum2()
		rewardItem.itemIcon:setHideLvAndBreakFlag(true)
		rewardItem.itemIcon:hideEquipLvAndBreak(true)
		gohelper.setActive(rewardItem.itemIcon.go, true)
	end

	for index = #rewardList + 1, #self.rewardItemTab do
		local rewardItem = self.rewardItemTab[index]

		if rewardItem then
			gohelper.setActive(rewardItem.itemIcon.go, false)
		end
	end
end

function AtomicDungeonTaskItem:refreshState()
	if AtomicDungeonTaskModel.instance:isTaskFinished(self.mo) then
		gohelper.setActive(self._goallfinish, true)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._gonojump, false)
	elseif self.mo.hasFinished then
		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._btnfinishbg.gameObject, true)
		gohelper.setActive(self._gonojump, false)
	else
		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, self.jumpId > 0)
		gohelper.setActive(self._gonojump, self.jumpId == 0)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
	end
end

function AtomicDungeonTaskItem:getAnimator()
	return self._animator
end

function AtomicDungeonTaskItem:onDestroyView()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.rewardItemTab then
		for _, item in pairs(self.rewardItemTab) do
			if item.itemIcon then
				item.itemIcon:onDestroy()

				item.itemIcon = nil
			end
		end

		self.rewardItemTab = nil
	end

	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)
end

return AtomicDungeonTaskItem
