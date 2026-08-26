-- chunkname: @modules/logic/bossrush/view/v2a1/V2a1_BossRush_SpecialScheduleItem.lua

module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_SpecialScheduleItem", package.seeall)

local V2a1_BossRush_SpecialScheduleItem = class("V2a1_BossRush_SpecialScheduleItem", ListScrollCellExtend)

function V2a1_BossRush_SpecialScheduleItem:onInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_Normal/#txt_Descr")
	self._imgIcon = gohelper.findChildImage(self.viewGO, "#go_Normal/image_Icon")
	self._scrollRewards = gohelper.findChildScrollRect(self.viewGO, "#go_Normal/#scroll_Rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_Normal/#scroll_Rewards/Viewport/#go_rewards")
	self._btnNotFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Normal/#btn_NotFinish")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Normal/#btn_Finished")
	self._goAllFinished = gohelper.findChild(self.viewGO, "#go_Normal/#go_AllFinished")
	self._goGetAll = gohelper.findChild(self.viewGO, "#go_GetAll")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_GetAll/#btn_getall/click")
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._goNormal)
	self.animator = self._goNormal:GetComponent(typeof(UnityEngine.Animator))
	self.animatorGetAll = self._goGetAll:GetComponent(typeof(UnityEngine.Animator))
	self.animatorPlayerGetAll = ZProj.ProjAnimatorPlayer.Get(self._goGetAll)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a1_BossRush_SpecialScheduleItem:addEvents()
	self._btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnClickGetAllSpecialScheduleBouns, self._OnClickGetAllScheduleBouns, self)
end

function V2a1_BossRush_SpecialScheduleItem:removeEvents()
	self._btnNotFinish:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btngetall:RemoveClickListener()
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnClickGetAllSpecialScheduleBouns, self._OnClickGetAllScheduleBouns, self)
end

V2a1_BossRush_SpecialScheduleItem.UI_CLICK_BLOCK_KEY = "V2a1_BossRush_SpecialScheduleItemClick"

function V2a1_BossRush_SpecialScheduleItem:_btngetallOnClick()
	self:_btnFinishedOnClick()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnClickGetAllSpecialScheduleBouns)
end

function V2a1_BossRush_SpecialScheduleItem:_btnNotFinishOnClick()
	return
end

function V2a1_BossRush_SpecialScheduleItem:_btnFinishedOnClick()
	UIBlockMgr.instance:startBlock(V2a1_BossRush_SpecialScheduleItem.UI_CLICK_BLOCK_KEY)

	local _anim = self:getAnimatorPlayer()

	_anim:Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, self.firstAnimationDone, self)
end

function V2a1_BossRush_SpecialScheduleItem:_OnClickGetAllScheduleBouns()
	if self._mo and self._mo.isCanClaim then
		self:getAnimator():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, 0, 0)
	end
end

function V2a1_BossRush_SpecialScheduleItem:_editableInitView()
	return
end

function V2a1_BossRush_SpecialScheduleItem:_editableAddEvents()
	return
end

function V2a1_BossRush_SpecialScheduleItem:_editableRemoveEvents()
	return
end

function V2a1_BossRush_SpecialScheduleItem:onUpdateMO(mo)
	self._mo = mo

	local isGetAll = mo.getAll

	if not isGetAll then
		self:refreshNormalUI(mo)
	else
		self:refreshGetAllUI(mo)
	end
end

function V2a1_BossRush_SpecialScheduleItem:refreshNormalUI(mo)
	local config = mo.config
	local stage = config.stage
	local lastPointInfo = BossRushModel.instance:getLastPointInfo(stage)
	local isAllFinished = mo.finishCount >= config.maxFinishCount
	local isFinish = not isAllFinished and mo.hasFinished
	local isNotFinish = not isAllFinished and not isFinish
	local isAlready = lastPointInfo.cur >= config.maxProgress
	local itemDataList = ItemModel.instance:getItemDataListByConfigStr(config.bonus)

	self._imgIcon.color = isAlready and GameUtil.parseColor("#00AFAD") or GameUtil.parseColor("#919191")
	self._mo.isCanClaim = isFinish

	gohelper.setActive(self._btnNotFinish.gameObject, isNotFinish)
	gohelper.setActive(self._btnFinished.gameObject, isFinish)
	gohelper.setActive(self._goAllFinished, isAllFinished)
	gohelper.setActive(self._goGetAll, false)
	gohelper.setActive(self._goNormal, true)
	IconMgr.instance:getCommonPropItemIconList(self, self._onRewardItemShow, itemDataList, self._gorewards)

	self._txtDescr.text = string.format(luaLang("v2a1_bossrush_specialrewardview_desc"), config.maxProgress)
end

function V2a1_BossRush_SpecialScheduleItem:refreshGetAllUI(mo)
	gohelper.setActive(self._goGetAll, true)
	gohelper.setActive(self._goNormal, false)
end

function V2a1_BossRush_SpecialScheduleItem:_onRewardItemShow(obj, data, index)
	obj:onUpdateMO(data)
	obj:showStackableNum2()
	obj:setCountFontSize(48)
end

function V2a1_BossRush_SpecialScheduleItem:onSelect(isSelect)
	return
end

function V2a1_BossRush_SpecialScheduleItem:onDestroyView()
	return
end

function V2a1_BossRush_SpecialScheduleItem:firstAnimationDone()
	local _animRemoveItem = self._view.viewContainer:getScrollAnimRemoveItem(BossRushEnum.BonusViewTab.SpecialScheduleTab)

	if _animRemoveItem then
		_animRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
	else
		self:secondAnimationDone()
	end
end

function V2a1_BossRush_SpecialScheduleItem:secondAnimationDone()
	if self._mo.getAll then
		local stage = self._mo.stage
		local actId = BossRushConfig.instance:getActivityId()
		local taskIds = V2a1_BossRush_SpecialScheduleViewListModel.instance:getAllTask(stage)

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity128, nil, taskIds, nil, self, actId)
	else
		V2a1_BossRush_SpecialScheduleViewListModel.instance:claimRewardByIndex(self._index)
	end

	UIBlockMgr.instance:endBlock(V2a1_BossRush_SpecialScheduleItem.UI_CLICK_BLOCK_KEY)
end

function V2a1_BossRush_SpecialScheduleItem:getAnimator()
	return (self._mo.getAll or nil) and (self.animatorGetAll or self.animator)
end

function V2a1_BossRush_SpecialScheduleItem:getAnimatorPlayer()
	return (self._mo.getAll or nil) and (self.animatorPlayerGetAll or self.animatorPlayer)
end

return V2a1_BossRush_SpecialScheduleItem
