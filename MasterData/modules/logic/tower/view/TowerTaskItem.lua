-- chunkname: @modules/logic/tower/view/TowerTaskItem.lua

module("modules.logic.tower.view.TowerTaskItem", package.seeall)

local TowerTaskItem = class("TowerTaskItem", ListScrollCellExtend)

function TowerTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._golight = gohelper.findChild(self.viewGO, "#go_normal/progress/#go_light")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._goStar = gohelper.findChild(self.viewGO, "#go_normal/#txt_taskdes/#go_star")
	self._goscrollRewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewardContent")
	self._btnnormal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_normal")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_normal/#go_hasget")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerTaskItem:addEvents()
	self._btnnormal:AddClickListener(self._btnnormalOnClick, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function TowerTaskItem:removeEvents()
	self._btnnormal:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

TowerTaskItem.BlockKey = "TowerTaskItemRewardGetAnim"
TowerTaskItem.TaskMaskTime = 0.65

function TowerTaskItem:_btnnormalOnClick()
	if not self.jumpId then
		return
	end

	GameFacade.jump(self.jumpId)
end

function TowerTaskItem:_btncangetOnClick()
	if not self.taskId and not self.mo.canGetAll then
		return
	end

	self._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(TowerTaskItem.BlockKey)
	TowerController.instance:dispatchEvent(TowerEvent.OnTaskRewardGetFinish, self._index)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, TowerTaskItem.TaskMaskTime)
end

function TowerTaskItem:_btngetallOnClick()
	self:_btncangetOnClick()
end

function TowerTaskItem:_onPlayActAniFinished()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.mo.canGetAll then
		local canGetIdList = TowerTaskModel.instance:getAllCanGetList()

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Tower, 0, canGetIdList, nil, nil, 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.taskId)
	end

	UIBlockMgr.instance:endBlock(TowerTaskItem.BlockKey)
end

function TowerTaskItem:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._scrollrewards = self._goscrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
end

function TowerTaskItem:onUpdateMO(mo)
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

function TowerTaskItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local delayTime = TowerTaskModel.instance:getDelayPlayTime(self.mo)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function TowerTaskItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function TowerTaskItem:refreshNormal()
	self.taskId = self.mo.id
	self.config = self.mo.config
	self.jumpId = self.config.jumpId

	local taskDesc = self.config.desc
	local hasStar = string.find(taskDesc, "%$")

	if hasStar then
		taskDesc = string.gsub(taskDesc, "%$", "")
	end

	gohelper.setActive(self._goStar, hasStar)

	self._txttaskdes.text = taskDesc

	self:refreshReward()
	self:refreshState()
end

function TowerTaskItem:refreshReward()
	local config = self.mo.config
	local rewardList = GameUtil.splitString2(config.bonus, true)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(self._gorewardContent)
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
end

function TowerTaskItem:refreshState()
	if TowerTaskModel.instance:isTaskFinished(self.mo) then
		gohelper.setActive(self._gohasget, true)
		gohelper.setActive(self._btnnormal.gameObject, false)
		gohelper.setActive(self._btncanget.gameObject, false)
		gohelper.setActive(self._golight, true)
	elseif self.mo.hasFinished then
		gohelper.setActive(self._gohasget, false)
		gohelper.setActive(self._btnnormal.gameObject, false)
		gohelper.setActive(self._btncanget.gameObject, true)
		gohelper.setActive(self._golight, true)
	else
		gohelper.setActive(self._gohasget, false)
		gohelper.setActive(self._btnnormal.gameObject, self.jumpId and self.jumpId > 0)
		gohelper.setActive(self._btncanget.gameObject, false)
		gohelper.setActive(self._golight, false)
	end
end

function TowerTaskItem:getAnimator()
	return self._animator
end

function TowerTaskItem:onDestroyView()
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

return TowerTaskItem
