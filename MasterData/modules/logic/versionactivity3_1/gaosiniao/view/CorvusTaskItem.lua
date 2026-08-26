-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/CorvusTaskItem.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.CorvusTaskItem", package.seeall)

local CorvusTaskItem = class("CorvusTaskItem", ListScrollCellExtend)

function CorvusTaskItem:onInitView()
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
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CorvusTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)

	if self._btngetall then
		self._btngetall:AddClickListener(self._btngetallOnClick, self)
	end
end

function CorvusTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()

	if self._btngetall then
		self._btngetall:RemoveClickListener()
	end
end

local kOneClickClaimRewardEvent = 11235

function CorvusTaskItem:initInternal(...)
	CorvusTaskItem.super.initInternal(self, ...)

	self.scrollReward = self._scrollrewardsGo:GetComponent(typeof(ZProj.LimitedScrollRect))
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject
end

function CorvusTaskItem:_btnnotfinishbgOnClick()
	local mo = self._mo
	local config = mo.config

	if not config.jumpId then
		if config.jumpId ~= 0 then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

			if GameFacade.jump(config.jumpId) then
				local c = self:_viewContainer()

				c:closeThis()
			end
		end
	end
end

local kBlock = "CorvusTaskItem:_btnfinishbgOnClick()"

function CorvusTaskItem:_btnfinishbgOnClick()
	self:_startBlock()

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self._firstAnimationDone, self)
end

function CorvusTaskItem:_btngetallOnClick()
	self:_startBlock()

	local c = self:_viewContainer()

	c:dispatchEvent(kOneClickClaimRewardEvent, self:_actId())

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self._firstAnimationDone, self)
end

function CorvusTaskItem:_editableInitView()
	self._rewardItemList = {}
	self._btnnotfinishbgGo = self._btnnotfinishbg.gameObject
	self._btnfinishbgGo = self._btnfinishbg.gameObject
	self._goallfinishGo = self._goallfinish.gameObject
	self._scrollrewardsGo = self._scrollrewards.gameObject
	self._gorewardsContentFilter = gohelper.onceAddComponent(self._gorewards, gohelper.Type_ContentSizeFitter)
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function CorvusTaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
end

function CorvusTaskItem:_viewContainer()
	return self._view.viewContainer
end

function CorvusTaskItem:getAnimator()
	return self.animator
end

function CorvusTaskItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._gonormal, not mo.getAll)
	gohelper.setActive(self._gogetall, mo.getAll)

	if mo.getAll then
		self:_refreshGetAllUI()
	else
		self:_refreshNormalUI()
	end
end

function CorvusTaskItem:_refreshGetAllUI()
	return
end

function CorvusTaskItem:_isReadTask()
	local mo = self._mo
	local CO = mo.config

	return CO.listenerType == "ReadTask"
end

function CorvusTaskItem:_refreshNormalUI()
	local mo = self._mo
	local CO = mo.config
	local progress = mo.progress
	local maxProgress = CO.maxProgress

	if self:_isReadTask() then
		progress = self:_getProgressReadTask()
		maxProgress = self:_getMaxProgressReadTask()
	end

	self._txtnum.text = math.min(progress, maxProgress)
	self._txttaskdes.text = CO.desc or CO.taskDesc
	self._txttotal.text = maxProgress

	gohelper.setActive(self._btnnotfinishbgGo, mo:isUnfinished())
	gohelper.setActive(self._goallfinishGo, mo:isClaimed())
	gohelper.setActive(self._btnfinishbgGo, mo:isClaimable())
	self:_refreshRewardItems()
end

function CorvusTaskItem:_refreshRewardItems()
	local mo = self._mo
	local CO = mo.config
	local bonus = CO.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = self:_getRewardList()

	self._gorewardsContentFilter.enabled = #rewardList > 2

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self._rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self._gorewards)

			table.insert(self._rewardItemList, rewardItem)
		end

		rewardItem:setMOValue(type, id, quantity, nil, true)
		rewardItem:setCountFontSize(48)
		rewardItem:showStackableNum2()
		rewardItem:isShowEffect(true)
		gohelper.setActive(rewardItem.go, true)
	end

	for i = #rewardList + 1, #self._rewardItemList do
		gohelper.setActive(self._rewardItemList[i].go, false)
	end

	self.scrollReward.horizontalNormalizedPosition = 0
end

function CorvusTaskItem:_firstAnimationDone()
	local c = self:_viewContainer()

	c:removeByIndex(self._index, self._secondAnimationDone, self)
end

function CorvusTaskItem:_secondAnimationDone()
	local c = self:_viewContainer()
	local mo = self._mo

	self.animatorPlayer:Play(UIAnimationName.Idle)
	self._endBlock()

	if mo.getAll then
		c:sendFinishAllTaskRequest()
	else
		local CO = mo.config
		local taskId = CO.id

		c:sendFinishTaskRequest(taskId)
	end
end

function CorvusTaskItem:_startBlock()
	UIBlockMgr.instance:startBlock(kBlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function CorvusTaskItem:_endBlock()
	UIBlockMgr.instance:endBlock(kBlock)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function CorvusTaskItem:showAsGotState()
	gohelper.setActive(self._btnnotfinishbgGo, false)
	gohelper.setActive(self._goallfinishGo, true)
	gohelper.setActive(self._btnfinishbgGo, false)
end

function CorvusTaskItem:_getRewardList()
	local mo = self._mo
	local CO = mo.config
	local bonus = CO.bonus

	if string.nilorempty(bonus) then
		return {}
	end

	return GameUtil.splitString2(bonus, true, "|", "#")
end

function CorvusTaskItem:_editableAddEvents()
	local c = self:_viewContainer()

	c:registerCallback(kOneClickClaimRewardEvent, self._onOneClickClaimReward, self)
end

function CorvusTaskItem:_editableRemoveEvents()
	local c = self:_viewContainer()

	c:unregisterCallback(kOneClickClaimRewardEvent, self._onOneClickClaimReward, self)
end

function CorvusTaskItem:_actId()
	local c = self:_viewContainer()

	return c:actId()
end

function CorvusTaskItem:_onOneClickClaimReward(actId)
	if self:_actId() ~= actId then
		return
	end

	if self._mo.getAll then
		return
	end

	local mo = self._mo

	if mo:isUnfinished() or mo:isClaimed() then
		return
	end

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self._onOneClickClaimRewardAnimFirstDone, self)
end

function CorvusTaskItem:_onOneClickClaimRewardAnimFirstDone()
	local c = self:_viewContainer()

	c:removeByIndex(self._index, self._getAllPlayAnimDone, self)
end

function CorvusTaskItem:_getAllPlayAnimDone()
	self.animatorPlayer:Play(UIAnimationName.Idle)
	self:showAsGotState()
end

function CorvusTaskItem:_getProgressReadTask()
	return 0
end

function CorvusTaskItem:_getMaxProgressReadTask()
	return 1
end

return CorvusTaskItem
