-- chunkname: @modules/logic/bossrush/view/v1a6/taskachievement/V1a6_BossRush_ScheduleItem.lua

module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_ScheduleItem", package.seeall)

local V1a6_BossRush_ScheduleItem = class("V1a6_BossRush_ScheduleItem", ListScrollCellExtend)

function V1a6_BossRush_ScheduleItem:onInitView()
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

function V1a6_BossRush_ScheduleItem:addEvents()
	self._btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnClickGetAllScheduleBouns, self._OnClickGetAllScheduleBouns, self)
end

function V1a6_BossRush_ScheduleItem:removeEvents()
	self._btnNotFinish:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btngetall:RemoveClickListener()
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnClickGetAllScheduleBouns, self._OnClickGetAllScheduleBouns, self)
end

V1a6_BossRush_ScheduleItem.UI_CLICK_BLOCK_KEY = "V1a6_BossRush_ScheduleItemClick"

function V1a6_BossRush_ScheduleItem:_btngetallOnClick()
	self:_btnFinishedOnClick()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnClickGetAllScheduleBouns)
end

function V1a6_BossRush_ScheduleItem:_btnNotFinishOnClick()
	return
end

function V1a6_BossRush_ScheduleItem:_btnFinishedOnClick()
	UIBlockMgr.instance:startBlock(V1a6_BossRush_ScheduleItem.UI_CLICK_BLOCK_KEY)

	local _anim = self:getAnimatorPlayer()

	_anim:Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, self.firstAnimationDone, self)
end

function V1a6_BossRush_ScheduleItem:_OnClickGetAllScheduleBouns()
	if self._mo and self._mo.isCanClaim then
		self:getAnimator():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, 0, 0)
	end
end

function V1a6_BossRush_ScheduleItem:_editableInitView()
	return
end

function V1a6_BossRush_ScheduleItem:_editableAddEvents()
	return
end

function V1a6_BossRush_ScheduleItem:_editableRemoveEvents()
	return
end

function V1a6_BossRush_ScheduleItem:onUpdateMO(mo)
	self._mo = mo

	local isGetAll = mo.getAll

	if not isGetAll then
		self:refreshNormalUI(mo)
	else
		self:refreshGetAllUI(mo)
	end
end

function V1a6_BossRush_ScheduleItem:refreshNormalUI(mo)
	local isGot = mo.isGot
	local config = mo.stageRewardCO
	local stage = config.stage
	local actId = config.activityId

	self._stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)

	if self._stageMo then
		local score = self._stageMo:getTotalPoint()
		local isAlready = score >= config.rewardPointNum
		local itemDataList = ItemModel.instance:getItemDataListByConfigStr(config.reward)

		self._imgIcon.color = isAlready and GameUtil.parseColor("#c48152") or GameUtil.parseColor("#919191")
		self._mo.isCanClaim = not isGot and isAlready

		gohelper.setActive(self._goAllFinished, isGot)
		gohelper.setActive(self._btnFinished.gameObject, self._mo.isCanClaim)
		gohelper.setActive(self._btnNotFinish.gameObject, not isGot and not isAlready)
		gohelper.setActive(self._goGetAll, false)
		gohelper.setActive(self._goNormal, true)
		IconMgr.instance:getCommonPropItemIconList(self, self._onRewardItemShow, itemDataList, self._gorewards)

		self._txtDescr.text = string.format(luaLang("v1a6_bossrush_scheduleview_desc"), config.rewardPointNum)
	end
end

function V1a6_BossRush_ScheduleItem:refreshGetAllUI(mo)
	gohelper.setActive(self._goGetAll, true)
	gohelper.setActive(self._goNormal, false)
end

function V1a6_BossRush_ScheduleItem:_onRewardItemShow(obj, data, index)
	obj:onUpdateMO(data)
	obj:showStackableNum2()
	obj:setCountFontSize(48)
end

function V1a6_BossRush_ScheduleItem:onSelect(isSelect)
	return
end

function V1a6_BossRush_ScheduleItem:onDestroyView()
	return
end

function V1a6_BossRush_ScheduleItem:firstAnimationDone()
	local tab = V1a6_BossRush_BonusModel.instance:getTab()
	local _animRemoveItem = self._view.viewContainer:getScrollAnimRemoveItem(tab)

	if _animRemoveItem then
		_animRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
	else
		self:secondAnimationDone()
	end
end

function V1a6_BossRush_ScheduleItem:secondAnimationDone()
	if self._mo then
		if self._mo.getAll then
			BossRushRpc.instance:sendAct128GetTotalRewardsRequest(self._mo.stage)
		elseif self._mo.stageRewardCO then
			BossRushRpc.instance:sendAct128GetTotalSingleRewardRequest(self._mo.stage, self._mo.stageRewardCO.id)
		end

		UIBlockMgr.instance:endBlock(V1a6_BossRush_ScheduleItem.UI_CLICK_BLOCK_KEY)
	end
end

function V1a6_BossRush_ScheduleItem:getAnimator()
	return (self._mo.getAll or nil) and (self.animatorGetAll or self.animator)
end

function V1a6_BossRush_ScheduleItem:getAnimatorPlayer()
	return (self._mo.getAll or nil) and (self.animatorPlayerGetAll or self.animatorPlayer)
end

return V1a6_BossRush_ScheduleItem
