-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTaskItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyTaskItem", package.seeall)

local OdysseyTaskItem = class("OdysseyTaskItem", ListScrollCellExtend)

function OdysseyTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._goscrollRewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnormal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyTaskItem:addEvents()
	self._btnnormal:AddClickListener(self._btnnormalOnClick, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function OdysseyTaskItem:removeEvents()
	self._btnnormal:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

OdysseyTaskItem.BlockKey = "OdysseyTaskItemRewardGetAnim"
OdysseyTaskItem.TaskMaskTime = 0.65

function OdysseyTaskItem:_btnnormalOnClick()
	if not self.jumpId then
		return
	end

	local jumpResult = GameFacade.jump(self.jumpId)

	if jumpResult then
		ViewMgr.instance:closeView(ViewName.OdysseyTaskView)
	end
end

function OdysseyTaskItem:_btncangetOnClick()
	if not self.taskId and not self.mo.canGetAll then
		return
	end

	self._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(OdysseyTaskItem.BlockKey)
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnTaskRewardGetFinish, self._index)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, OdysseyTaskItem.TaskMaskTime)
end

function OdysseyTaskItem:_btngetallOnClick()
	self:_btncangetOnClick()
end

function OdysseyTaskItem:_onPlayActAniFinished()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.mo.canGetAll then
		local canGetIdList = OdysseyTaskModel.instance:getAllCanGetIdList()

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Odyssey, 0, canGetIdList, nil, nil, 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.taskId)
	end

	UIBlockMgr.instance:endBlock(OdysseyTaskItem.BlockKey)
end

function OdysseyTaskItem:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._scrollrewards = self._goscrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
end

function OdysseyTaskItem:onUpdateMO(mo)
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

function OdysseyTaskItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local delayTime = OdysseyTaskModel.instance:getDelayPlayTime(self.mo)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function OdysseyTaskItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function OdysseyTaskItem:refreshNormal()
	self.taskId = self.mo.id
	self.config = self.mo.config
	self.jumpId = self.config.jumpId
	self._txttaskdes.text = self.config.desc

	self:refreshReward()
	self:refreshState()
end

function OdysseyTaskItem:refreshReward()
	local config = self.mo.config
	local rewardList = GameUtil.splitString2(config.bonus, true)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(self._gorewards)
			}
			self.rewardItemTab[index] = rewardItem
		end

		rewardItem.itemIcon:setMOValue(rewardData[1], rewardData[2], rewardData[3])
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

	gohelper.setActive(self._gorewards, false)
	TaskDispatcher.runDelay(self.setRewardsShow, self, 0.01)
end

function OdysseyTaskItem:setRewardsShow()
	gohelper.setActive(self._gorewards, true)
end

function OdysseyTaskItem:refreshState()
	if OdysseyTaskModel.instance:isTaskHasGet(self.mo) then
		gohelper.setActive(self._gohasget, true)
		gohelper.setActive(self._btnnormal.gameObject, false)
		gohelper.setActive(self._btncanget.gameObject, false)
	elseif self.mo.hasFinished then
		gohelper.setActive(self._gohasget, false)
		gohelper.setActive(self._btnnormal.gameObject, false)
		gohelper.setActive(self._btncanget.gameObject, true)
	else
		gohelper.setActive(self._gohasget, false)
		gohelper.setActive(self._btnnormal.gameObject, self.jumpId and self.jumpId > 0)
		gohelper.setActive(self._btncanget.gameObject, false)
	end
end

function OdysseyTaskItem:getAnimator()
	return self._animator
end

function OdysseyTaskItem:onDestroyView()
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

	TaskDispatcher.cancelTask(self.setRewardsShow, self)
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)
end

return OdysseyTaskItem
