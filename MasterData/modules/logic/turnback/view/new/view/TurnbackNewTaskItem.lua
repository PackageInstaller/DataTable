-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewTaskItem.lua

module("modules.logic.turnback.view.new.view.TurnbackNewTaskItem", package.seeall)

local TurnbackNewTaskItem = class("TurnbackNewTaskItem", ListScrollCellExtend)

function TurnbackNewTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._scrollrewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._goRewardContent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._godaily = gohelper.findChild(self.viewGO, "#go_normal/#go_daily")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self.rewardItemList = {}
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackNewTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
end

function TurnbackNewTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
end

function TurnbackNewTaskItem:_btnnotfinishbgOnClick()
	local jumpId = self.taskMo.config.jumpId

	if jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function TurnbackNewTaskItem:_btnfinishbgOnClick()
	UIBlockMgr.instance:startBlock("TurnbackTaskItemFinish")
	TaskDispatcher.runDelay(self.finishTask, self, TurnbackEnum.TaskMaskTime)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.OnTaskRewardGetFinish, self._index)
	self.animator:Play(UIAnimationName.Finish, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
end

function TurnbackNewTaskItem:finishTask()
	TaskDispatcher.cancelTask(self.finishTask, self)
	UIBlockMgr.instance:endBlock("TurnbackTaskItemFinish")
	TaskRpc.instance:sendFinishTaskRequest(self.taskMo.id)
end

function TurnbackNewTaskItem:_editableInitView()
	return
end

function TurnbackNewTaskItem:_editableAddEvents()
	return
end

function TurnbackNewTaskItem:_editableRemoveEvents()
	return
end

function TurnbackNewTaskItem:onUpdateMO(taskMo)
	self.taskMo = taskMo
	self._scrollrewards.parentGameObject = self._view._csListScroll.gameObject

	gohelper.setActive(self._gonormal, not self.taskMo.getAll)

	self.co = self.taskMo.config
	self._txttaskdes.text = self.co.desc
	self._txtnum.text = self.taskMo.progress
	self._txttotal.text = self.co.maxProgress

	local isDaily = self.taskMo.config.loopType == 1

	gohelper.setActive(self._godaily, isDaily)

	if self.taskMo.finishCount > 0 then
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._goallfinish, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self._btnfinishbg.gameObject, true)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._goallfinish, false)
	else
		gohelper.setActive(self._btnnotfinishbg.gameObject, true)
		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
	end

	self:refreshRewardItems()
end

function TurnbackNewTaskItem:refreshRewardItems()
	local bonus = self.co.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self._scrollrewards.gameObject, false)

		return
	end

	gohelper.setActive(self._scrollrewards.gameObject, true)

	local rewardList = GameUtil.splitString2(bonus, true, "|", "#")

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self.rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self._goRewardContent)

			rewardItem:setMOValue(type, id, quantity, nil, true)
			table.insert(self.rewardItemList, rewardItem)
		else
			rewardItem:setMOValue(type, id, quantity, nil, true)
		end

		rewardItem:setCountFontSize(40)
		rewardItem:showStackableNum2()
		rewardItem:isShowEffect(true)
		gohelper.setActive(rewardItem.go, true)
	end

	for i = #rewardList + 1, #self.rewardItemList do
		gohelper.setActive(self.rewardItemList[i].go, false)
	end

	self._scrollrewards.horizontalNormalizedPosition = 0

	self.animator:Play(UIAnimationName.Idle, 0, 0)
end

function TurnbackNewTaskItem:onSelect(isSelect)
	return
end

function TurnbackNewTaskItem:onDestroyView()
	TaskDispatcher.cancelTask(self.finishTask, self)
end

return TurnbackNewTaskItem
