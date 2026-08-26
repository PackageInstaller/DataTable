-- chunkname: @modules/logic/bossrush/view/v1a6/taskachievement/V1a6_BossRush_AchievementItem.lua

module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_AchievementItem", package.seeall)

local V1a6_BossRush_AchievementItem = class("V1a6_BossRush_AchievementItem", ListScrollCellExtend)

function V1a6_BossRush_AchievementItem:onInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._imageAssessIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Normal/#image_AssessIcon")
	self._txtScore = gohelper.findChildText(self.viewGO, "#go_Normal/txt_Score")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_Normal/#txt_Descr")
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

function V1a6_BossRush_AchievementItem:addEvents()
	self._btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnClickGetAllAchievementBouns, self._OnClickGetAllAchievementBouns, self)
end

function V1a6_BossRush_AchievementItem:removeEvents()
	self._btnNotFinish:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btngetall:RemoveClickListener()
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnClickGetAllAchievementBouns, self._OnClickGetAllAchievementBouns, self)
end

V1a6_BossRush_AchievementItem.UI_CLICK_BLOCK_KEY = "V1a6_BossRush_AchievementItemClick"

function V1a6_BossRush_AchievementItem:_btnNotFinishOnClick()
	return
end

function V1a6_BossRush_AchievementItem:_btnFinishedOnClick()
	UIBlockMgr.instance:startBlock(V1a6_BossRush_AchievementItem.UI_CLICK_BLOCK_KEY)

	local _anim = self:getAnimatorPlayer()

	_anim:Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, self.firstAnimationDone, self)
end

function V1a6_BossRush_AchievementItem:_btngetallOnClick()
	self:_btnFinishedOnClick()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnClickGetAllAchievementBouns)
end

function V1a6_BossRush_AchievementItem:_OnClickGetAllAchievementBouns()
	if self._mo and self._mo.isCanClaim then
		self:getAnimator():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, 0, 0)
	end
end

function V1a6_BossRush_AchievementItem:_editableInitView()
	self.rewardItemList = {}
end

function V1a6_BossRush_AchievementItem:_editableAddEvents()
	return
end

function V1a6_BossRush_AchievementItem:_editableRemoveEvents()
	return
end

function V1a6_BossRush_AchievementItem:onUpdateMO(mo)
	self._mo = mo

	local isGetAll = mo.getAll

	if not isGetAll then
		self:refreshNormalUI(mo)
	else
		self:refreshGetAllUI(mo)
	end
end

function V1a6_BossRush_AchievementItem:refreshNormalUI(mo)
	local config = mo.config
	local bonus = config.bonus
	local achievementRes = config.achievementRes
	local maxProgress = config.maxProgress
	local isAllFinished = mo.finishCount >= config.maxFinishCount
	local isFinish = not isAllFinished and mo.hasFinished
	local isNotFinish = not isAllFinished and not isFinish
	local isEmptySprite = achievementRes == ""
	local itemDataList = ItemModel.instance:getItemDataListByConfigStr(bonus)

	self._mo.isCanClaim = isFinish

	if not isEmptySprite then
		self._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(achievementRes))
	end

	gohelper.setActive(self._imageAssessIconGo, not isEmptySprite)
	gohelper.setActive(self._btnNotFinish.gameObject, isNotFinish)
	gohelper.setActive(self._btnFinished.gameObject, isFinish)
	gohelper.setActive(self._goAllFinished, isAllFinished)
	gohelper.setActive(self._goGetAll, false)
	gohelper.setActive(self._goNormal, true)
	IconMgr.instance:getCommonPropItemIconList(self, self._onRewardItemShow, itemDataList, self._gorewards)

	self._txtDescr.text = BossRushConfig.instance:getScoreStr(maxProgress)

	if not mo.ScoreDesc then
		self._txtScore.text = luaLang(mo.ScoreDesc)
	end
end

function V1a6_BossRush_AchievementItem:refreshGetAllUI(mo)
	gohelper.setActive(self._goGetAll, true)
	gohelper.setActive(self._goNormal, false)
end

function V1a6_BossRush_AchievementItem:onSelect(isSelect)
	return
end

function V1a6_BossRush_AchievementItem:onDestroyView()
	self._imageAssessIcon:UnLoadImage()
end

function V1a6_BossRush_AchievementItem:_onRewardItemShow(obj, data, index)
	obj:onUpdateMO(data)
	obj:showStackableNum2()
	obj:setCountFontSize(48)
end

function V1a6_BossRush_AchievementItem:firstAnimationDone()
	local tab = V1a6_BossRush_BonusModel.instance:getTab()
	local _animRemoveItem = self._view.viewContainer:getScrollAnimRemoveItem(tab)

	if _animRemoveItem then
		_animRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
	else
		self:secondAnimationDone()
	end
end

function V1a6_BossRush_AchievementItem:secondAnimationDone()
	if self._mo.getAll then
		local stage = self._mo.stage
		local actId = BossRushConfig.instance:getActivityId()
		local taskIds = V1a4_BossRush_ScoreTaskAchievementListModel.instance:getAllAchievementTask(stage)

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity128, nil, taskIds, nil, self, actId)
	else
		V1a4_BossRush_ScoreTaskAchievementListModel.instance:claimRewardByIndex(self._index)
	end

	UIBlockMgr.instance:endBlock(V1a6_BossRush_AchievementItem.UI_CLICK_BLOCK_KEY)
end

function V1a6_BossRush_AchievementItem:getAnimator()
	return (self._mo.getAll or nil) and (self.animatorGetAll or self.animator)
end

function V1a6_BossRush_AchievementItem:getAnimatorPlayer()
	return (self._mo.getAll or nil) and (self.animatorPlayerGetAll or self.animatorPlayer)
end

return V1a6_BossRush_AchievementItem
