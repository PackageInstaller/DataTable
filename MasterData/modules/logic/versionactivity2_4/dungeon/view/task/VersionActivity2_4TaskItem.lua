-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/task/VersionActivity2_4TaskItem.lua

module("modules.logic.versionactivity2_4.dungeon.view.task.VersionActivity2_4TaskItem", package.seeall)

local VersionActivity2_4TaskItem = class("VersionActivity2_4TaskItem", ListScrollCell)

function VersionActivity2_4TaskItem:init(go)
	self.viewGO = go
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self.txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self.txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self.txttaskdesc = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self.scrollReward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.goRewardContent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self.goFinished = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self.goDoing = gohelper.findChild(self.viewGO, "#go_normal/txt_finishing")
	self.btnNotFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self.goRunning = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_running")
	self.btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self.btnFinishAll = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall")
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4TaskItem:addEventListeners()
	self.btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self.btnFinish:AddClickListener(self._btnFinishOnClick, self)
	self.btnFinishAll:AddClickListener(self._btnFinishAllOnClick, self)
	TaskController.instance:registerCallback(TaskEvent.OnClickFinishAllTask, self._onClickFinishAllTaskItem, self)
end

function VersionActivity2_4TaskItem:removeEventListeners()
	self.btnNotFinish:RemoveClickListener()
	self.btnFinish:RemoveClickListener()
	self.btnFinishAll:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.OnClickFinishAllTask, self._onClickFinishAllTaskItem, self)
end

function VersionActivity2_4TaskItem:_btnNotFinishOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity2_4TaskView)
		end
	end
end

function VersionActivity2_4TaskItem:_onClickFinishAllTaskItem(actId)
	if self.taskMo.getAll then
		return
	end

	if actId ~= VersionActivity2_4Enum.ActivityId.Dungeon or not self.taskMo.hasFinished then
		return
	end

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish)
end

function VersionActivity2_4TaskItem:_btnFinishAllOnClick()
	self:_btnFinishOnClick()
end

VersionActivity2_4TaskItem.FinishKey = "VersionActivity2_4TaskItem FinishKey"

function VersionActivity2_4TaskItem:_btnFinishOnClick()
	UIBlockMgr.instance:startBlock(VersionActivity2_4TaskItem.FinishKey)

	if self.taskMo.getAll then
		TaskController.instance:dispatchEvent(TaskEvent.OnClickFinishAllTask, VersionActivity2_4Enum.ActivityId.Dungeon)
	end

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self.firstAnimationDone, self)
end

function VersionActivity2_4TaskItem:firstAnimationDone()
	local finishedTaskIdxList = VersionActivity2_4TaskListModel.instance:getFinishedTaskIdxList()

	finishedTaskIdxList[#finishedTaskIdxList + 1] = self._index

	self._view.viewContainer.taskAnimRemoveItem:removeByIndexs(finishedTaskIdxList, self.secondAnimationDone, self)
end

function VersionActivity2_4TaskItem:secondAnimationDone()
	UIBlockMgr.instance:endBlock(VersionActivity2_4TaskItem.FinishKey)
	self.animatorPlayer:Play(UIAnimationName.Idle)

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, nil, nil, nil, VersionActivity2_4Enum.ActivityId.Dungeon)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.co.id)
	end
end

function VersionActivity2_4TaskItem:_editableInitView()
	self.rewardItemList = {}
end

function VersionActivity2_4TaskItem:onUpdateMO(taskMo)
	self.taskMo = taskMo
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject

	gohelper.setActive(self._gonormal, not self.taskMo.getAll)
	gohelper.setActive(self._gogetall, self.taskMo.getAll)

	if self.taskMo.getAll then
		self:refreshGetAllUI()
	else
		self:refreshNormalUI()
	end
end

function VersionActivity2_4TaskItem:refreshNormalUI()
	self.co = self.taskMo.config
	self.txttaskdesc.text = self.co.desc
	self.txtnum.text = self.taskMo.progress
	self.txttotal.text = self.co.maxProgress

	if self.taskMo.finishCount >= self.co.maxFinishCount then
		gohelper.setActive(self.goDoing, false)
		gohelper.setActive(self.btnNotFinish, false)
		gohelper.setActive(self.goRunning, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.goFinished, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self.btnFinish, true)
		gohelper.setActive(self.btnNotFinish, false)
		gohelper.setActive(self.goDoing, false)
		gohelper.setActive(self.goRunning, false)
		gohelper.setActive(self.goFinished, false)
	else
		if self.co.jumpId ~= 0 then
			gohelper.setActive(self.btnNotFinish, true)
			gohelper.setActive(self.goDoing, false)
			gohelper.setActive(self.goRunning, false)
		else
			gohelper.setActive(self.btnNotFinish, false)
			gohelper.setActive(self.goDoing, true)
			gohelper.setActive(self.goRunning, true)
		end

		gohelper.setActive(self.goFinished, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
	end

	self:refreshRewardItems()
end

function VersionActivity2_4TaskItem:refreshRewardItems()
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

			transformhelper.setLocalScale(rewardItem.go.transform, 1, 1, 1)
			rewardItem:setMOValue(type, id, quantity, nil, true)
			rewardItem:setCountFontSize(26)
			rewardItem:showStackableNum2()
			rewardItem:isShowEffect(true)
			table.insert(self.rewardItemList, rewardItem)

			local countBg = rewardItem:getItemIcon():getCountBg()
			local count = rewardItem:getItemIcon():getCount()

			transformhelper.setLocalScale(countBg.transform, 1, 1.5, 1)
			transformhelper.setLocalScale(count.transform, 1.5, 1.5, 1)
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

function VersionActivity2_4TaskItem:refreshGetAllUI()
	return
end

function VersionActivity2_4TaskItem:canGetReward()
	return self.taskMo.finishCount < self.co.maxFinishCount and self.taskMo.hasFinished
end

function VersionActivity2_4TaskItem:getAnimator()
	return self.animator
end

function VersionActivity2_4TaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()
end

return VersionActivity2_4TaskItem
