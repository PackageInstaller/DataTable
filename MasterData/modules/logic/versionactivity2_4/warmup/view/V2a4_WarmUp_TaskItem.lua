-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_TaskItem.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_TaskItem", package.seeall)

local V2a4_WarmUp_TaskItem = class("V2a4_WarmUp_TaskItem", ListScrollCellExtend)

function V2a4_WarmUp_TaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_WarmUp_TaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
end

function V2a4_WarmUp_TaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
end

local kBlock = "V2a4_WarmUp_TaskItem:_btnfinishbgOnClick()"

function V2a4_WarmUp_TaskItem:_btnnotfinishbgOnClick()
	local mo = self._mo
	local config = mo.config

	if config.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.V2a4_WarmUp_TaskView)
		end
	end
end

function V2a4_WarmUp_TaskItem:_btnfinishbgOnClick()
	UIBlockMgr.instance:startBlock(kBlock)

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self._firstAnimationDone, self)
end

function V2a4_WarmUp_TaskItem:_editableInitView()
	self._rewardItemList = {}
	self._btnnotfinishbgGo = self._btnnotfinishbg.gameObject
	self._btnfinishbgGo = self._btnfinishbg.gameObject
	self._goallfinishGo = self._goallfinish.gameObject
	self._scrollrewardsGo = self._scrollrewards.gameObject
	self._gorewardsContentFilter = gohelper.onceAddComponent(self._gorewards, gohelper.Type_ContentSizeFitter)
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function V2a4_WarmUp_TaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
end

function V2a4_WarmUp_TaskItem:initInternal(...)
	V2a4_WarmUp_TaskItem.super.initInternal(self, ...)

	self.scrollReward = self._scrollrewardsGo:GetComponent(typeof(ZProj.LimitedScrollRect))
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject
end

function V2a4_WarmUp_TaskItem:_viewContainer()
	return self._view.viewContainer
end

function V2a4_WarmUp_TaskItem:onUpdateMO(mo)
	self._mo = mo

	if mo.getAll then
		self:_refreshGetAllUI()
	else
		self:_refreshNormalUI()
	end
end

function V2a4_WarmUp_TaskItem:_refreshGetAllUI()
	return
end

function V2a4_WarmUp_TaskItem:_isReadTask()
	local mo = self._mo
	local CO = mo.config

	return CO.listenerType == "ReadTask"
end

function V2a4_WarmUp_TaskItem:_getProgressReadTask()
	local E = ActivityWarmUpEnum.Activity125TaskTag
	local mo = self._mo
	local CO = mo.config
	local taskId = CO.id
	local activityId = CO.activityId
	local sum_help_npcDict = Activity125Config.instance:getTaskCO_ReadTask_Tag(activityId, E.sum_help_npc)

	if sum_help_npcDict[taskId] then
		return self:_progress_sum_help_npc()
	end

	local help_npcDict = Activity125Config.instance:getTaskCO_ReadTask_Tag(activityId, E.help_npc)

	if help_npcDict[taskId] then
		return mo.progress
	end

	local perfect_winDict = Activity125Config.instance:getTaskCO_ReadTask_Tag(activityId, E.perfect_win)

	if perfect_winDict[taskId] then
		return mo.progress
	end
end

function V2a4_WarmUp_TaskItem:_getMaxProgressReadTask()
	local mo = self._mo
	local CO = mo.config
	local E = ActivityWarmUpEnum.Activity125TaskTag
	local taskId = CO.id
	local activityId = CO.activityId
	local sum_help_npcDict = Activity125Config.instance:getTaskCO_ReadTask_Tag(activityId, E.sum_help_npc)

	if sum_help_npcDict[taskId] then
		return tonumber(CO.clientlistenerParam) or 0
	else
		return 1
	end
end

function V2a4_WarmUp_TaskItem:_progress_sum_help_npc()
	return Activity125Controller.instance:get_V2a4_WarmUp_sum_help_npc(0)
end

function V2a4_WarmUp_TaskItem:_refreshNormalUI()
	local mo = self._mo
	local CO = mo.config
	local progress = mo.progress
	local maxProgress = CO.maxProgress

	if self:_isReadTask() then
		progress = self:_getProgressReadTask()
		maxProgress = self:_getMaxProgressReadTask()
	end

	self._txtnum.text = math.min(progress, maxProgress)
	self._txttaskdes.text = CO.desc
	self._txttotal.text = maxProgress

	gohelper.setActive(self._btnnotfinishbgGo, mo:isUnfinished())
	gohelper.setActive(self._goallfinishGo, mo:isClaimed())
	gohelper.setActive(self._btnfinishbgGo, mo:isClaimable())
	self:_refreshRewardItems()
end

function V2a4_WarmUp_TaskItem:_refreshRewardItems()
	local mo = self._mo
	local CO = mo.config
	local bonus = CO.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = GameUtil.splitString2(bonus, true, "|", "#")

	self._gorewardsContentFilter.enabled = #rewardList > 2

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self._rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self._gorewards)

			rewardItem:setMOValue(type, id, quantity, nil, true)
			rewardItem:setCountFontSize(26)
			rewardItem:showStackableNum2()
			rewardItem:isShowEffect(true)
			table.insert(self._rewardItemList, rewardItem)

			local itemIcon = rewardItem:getItemIcon()

			if itemIcon.getCountBg then
				local countBg = itemIcon:getCountBg()

				transformhelper.setLocalScale(countBg.transform, 1, 1.5, 1)
			end

			if itemIcon.getCount then
				local count = itemIcon:getCount()

				transformhelper.setLocalScale(count.transform, 1.5, 1.5, 1)
			end
		else
			rewardItem:setMOValue(type, id, quantity, nil, true)
		end

		gohelper.setActive(rewardItem.go, true)
	end

	for i = #rewardList + 1, #self._rewardItemList do
		gohelper.setActive(self._rewardItemList[i].go, false)
	end

	self.scrollReward.horizontalNormalizedPosition = 0
end

function V2a4_WarmUp_TaskItem:_firstAnimationDone()
	local c = self:_viewContainer()

	c:removeByIndex(self._index, self._secondAnimationDone, self)
end

function V2a4_WarmUp_TaskItem:_secondAnimationDone()
	local c = self:_viewContainer()
	local mo = self._mo
	local CO = mo.config
	local taskId = CO.id

	UIBlockMgr.instance:endBlock(kBlock)
	self.animatorPlayer:Play(UIAnimationName.Idle)

	if mo.getAll then
		c:sendFinishAllTaskRequest()
	else
		c:sendFinishTaskRequest(taskId)
	end
end

function V2a4_WarmUp_TaskItem:getAnimator()
	return self.animator
end

return V2a4_WarmUp_TaskItem
