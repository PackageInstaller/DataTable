-- chunkname: @modules/logic/reactivity/view/ReactivityTaskItem.lua

module("modules.logic.reactivity.view.ReactivityTaskItem", package.seeall)

local ReactivityTaskItem = class("ReactivityTaskItem", ListScrollCell)

function ReactivityTaskItem:init(go)
	self.viewGO = go
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self.txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self.txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self.txttaskdesc = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self.scrollReward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.goRewardContent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self.goFinished = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self.btnNotFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self.btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	self.btnFinishAll = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ReactivityTaskItem:addEventListeners()
	self.btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self.btnFinish:AddClickListener(self._btnFinishOnClick, self)
	self.btnFinishAll:AddClickListener(self._btnFinishAllOnClick, self)
end

function ReactivityTaskItem:removeEventListeners()
	self.btnNotFinish:RemoveClickListener()
	self.btnFinish:RemoveClickListener()
	self.btnFinishAll:RemoveClickListener()
end

function ReactivityTaskItem:_btnNotFinishOnClick()
	local jumpId = self.co.jumpId

	if jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(jumpId) then
			ViewMgr.instance:closeView(ViewName.ReactivityTaskView)
		end
	end
end

function ReactivityTaskItem:_btnFinishAllOnClick()
	self:_btnFinishOnClick()
end

ReactivityTaskItem.FinishKey = "FinishKey"

function ReactivityTaskItem:_btnFinishOnClick()
	UIBlockMgr.instance:startBlock(ReactivityTaskItem.FinishKey)

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self.firstAnimationDone, self)
end

function ReactivityTaskItem:firstAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
end

function ReactivityTaskItem:secondAnimationDone()
	self.animatorPlayer:Play(UIAnimationName.Idle)

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, nil, nil, nil, self.activityId)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.co.id)
	end

	UIBlockMgr.instance:endBlock(ReactivityTaskItem.FinishKey)
end

function ReactivityTaskItem:_editableInitView()
	self.rewardItemList = {}
end

function ReactivityTaskItem:onUpdateMO(taskMo)
	self.taskMo = taskMo
	self.activityId = taskMo.activityId
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject

	gohelper.setActive(self._gonormal, not self.taskMo.getAll)
	gohelper.setActive(self._gogetall, self.taskMo.getAll)

	if self.taskMo.getAll then
		self:refreshGetAllUI()
	else
		self:refreshNormalUI()
	end
end

function ReactivityTaskItem:refreshNormalUI()
	self.co = self.taskMo.config

	self:refreshDesc()

	self.txtnum.text = self.taskMo.progress
	self.txttotal.text = self.co.maxProgress

	if self.taskMo.finishCount >= self.co.maxFinishCount then
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.goFinished, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self.btnFinish.gameObject, true)
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.goFinished, false)
	else
		gohelper.setActive(self.btnNotFinish.gameObject, true)
		gohelper.setActive(self.goFinished, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
	end

	self:refreshRewardItems()
end

function ReactivityTaskItem:refreshDesc()
	self.txttaskdesc.text = self.co.desc
end

function ReactivityTaskItem:refreshRewardItems()
	local bonus = self.co.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = GameUtil.splitString2(bonus, true, "|", "#")

	self.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #rewardList > 2

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self.rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self.goRewardContent)

			rewardItem:setMOValue(type, id, quantity, nil, true)
			rewardItem:setCountFontSize(40)
			rewardItem:showStackableNum2()
			rewardItem:isShowEffect(true)
			table.insert(self.rewardItemList, rewardItem)
		else
			rewardItem:setMOValue(type, id, quantity, nil, true)
		end

		gohelper.setActive(rewardItem.go, true)
	end

	for i = #rewardList + 1, #self.rewardItemList do
		gohelper.setActive(self.rewardItemList[i].go, false)
	end

	self.scrollReward.horizontalNormalizedPosition = 0
end

function ReactivityTaskItem:refreshGetAllUI()
	return
end

function ReactivityTaskItem:canGetReward()
	return self.taskMo.finishCount < self.co.maxFinishCount and self.taskMo.hasFinished
end

function ReactivityTaskItem:getAnimator()
	return self.animator
end

function ReactivityTaskItem:onDestroyView()
	return
end

return ReactivityTaskItem
