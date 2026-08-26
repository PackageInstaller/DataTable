-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/task/VersionActivity1_8TaskItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.task.VersionActivity1_8TaskItem", package.seeall)

local VersionActivity1_8TaskItem = class("VersionActivity1_8TaskItem", ListScrollCellExtend)

function VersionActivity1_8TaskItem:onInitView()
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self.scrollReward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.goRewardContent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self.sizeFitterRewardContent = self.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	self.goFinished = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self.btnNotFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self.btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	self.btnFinishAll = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8TaskItem:addEvents()
	self.btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self.btnFinish:AddClickListener(self._btnFinishOnClick, self)
	self.btnFinishAll:AddClickListener(self._btnFinishOnClick, self)
end

function VersionActivity1_8TaskItem:removeEvents()
	self.btnNotFinish:RemoveClickListener()
	self.btnFinish:RemoveClickListener()
	self.btnFinishAll:RemoveClickListener()
end

function VersionActivity1_8TaskItem:_btnNotFinishOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_8TaskView)
		end
	end
end

function VersionActivity1_8TaskItem:_btnFinishOnClick()
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.TaskGetReward)

	self._animator.speed = 1

	self._animatorPlayer:Play(UIAnimationName.Finish, self.firstAnimationDone, self)
end

function VersionActivity1_8TaskItem:firstAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
end

function VersionActivity1_8TaskItem:secondAnimationDone()
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.TaskGetReward)
	self._animatorPlayer:Play(UIAnimationName.Idle)

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, nil, nil, nil, VersionActivity1_8Enum.ActivityId.Dungeon)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.co.id)
	end
end

function VersionActivity1_8TaskItem:_editableInitView()
	self.rewardItemList = {}
end

function VersionActivity1_8TaskItem:onUpdateMO(mo)
	self.taskMo = mo
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject

	gohelper.setActive(self._gonormal, not self.taskMo.getAll)
	gohelper.setActive(self._gogetall, self.taskMo.getAll)

	if self.taskMo.getAll then
		self:refreshGetAllUI()
	else
		self:refreshNormalUI()
	end
end

function VersionActivity1_8TaskItem:refreshGetAllUI()
	return
end

function VersionActivity1_8TaskItem:refreshNormalUI()
	self.co = self.taskMo.config
	self._txttaskdes.text = self.co.desc
	self._txtnum.text = self.taskMo.progress
	self._txttotal.text = self.co.maxProgress

	if self.taskMo.finishCount >= self.co.maxFinishCount then
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.goFinished, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self.btnFinish.gameObject, true)
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.goFinished, false)
	else
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.btnNotFinish.gameObject, true)
		gohelper.setActive(self.goFinished, false)
	end

	self:refreshRewardItems()
end

local REWARD_FONT_SIZE = 26

function VersionActivity1_8TaskItem:refreshRewardItems()
	local bonus = self.co.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = GameUtil.splitString2(bonus, true, "|", "#")

	self.sizeFitterRewardContent.enabled = #rewardList > 2

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self.rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self.goRewardContent)

			rewardItem:setMOValue(type, id, quantity, nil, true)
			rewardItem:setCountFontSize(REWARD_FONT_SIZE)
			rewardItem:showStackableNum2()
			rewardItem:isShowEffect(true)

			local countBg = rewardItem:getItemIcon():getCountBg()
			local count = rewardItem:getItemIcon():getCount()

			transformhelper.setLocalScale(countBg.transform, 1, 1.5, 1)
			transformhelper.setLocalScale(count.transform, 1.5, 1.5, 1)
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

function VersionActivity1_8TaskItem:getAnimator()
	return self._animator
end

function VersionActivity1_8TaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()

	self.rewardItemList = {}

	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.TaskGetReward)
end

return VersionActivity1_8TaskItem
