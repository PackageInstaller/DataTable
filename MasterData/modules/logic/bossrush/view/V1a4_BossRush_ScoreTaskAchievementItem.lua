-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ScoreTaskAchievementItem.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ScoreTaskAchievementItem", package.seeall)

local V1a4_BossRush_ScoreTaskAchievementItem = class("V1a4_BossRush_ScoreTaskAchievementItem", ListScrollCellExtend)

function V1a4_BossRush_ScoreTaskAchievementItem:onInitView()
	self._imageAssessIcon = gohelper.findChildSingleImage(self.viewGO, "Root/#image_AssessIcon")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/#txt_Descr")
	self._scrollRewards = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_Rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "Root/#scroll_Rewards/Viewport/#go_rewards")
	self._btnNotFinish = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_NotFinish")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Finished", AudioEnum.ui_task.play_ui_task_slide)
	self._goAllFinished = gohelper.findChild(self.viewGO, "Root/#go_AllFinished")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRush_ScoreTaskAchievementItem:addEvents()
	self._btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
end

function V1a4_BossRush_ScoreTaskAchievementItem:removeEvents()
	self._btnNotFinish:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
end

local eAnimEvt = BossRushEnum.AnimEvtAchievementItem

function V1a4_BossRush_ScoreTaskAchievementItem:_btnNotFinishOnClick()
	return
end

function V1a4_BossRush_ScoreTaskAchievementItem:_btnFinishedOnClick()
	self:_playFinish()
end

function V1a4_BossRush_ScoreTaskAchievementItem:_editableInitView()
	self._goRootGo = gohelper.findChild(self.viewGO, "Root")
	self._anim = self._goRootGo:GetComponent(gohelper.Type_Animator)
	self._animEvent = self._goRootGo:GetComponent(gohelper.Type_AnimationEventWrap)
	self._imageAssessIconGo = self._imageAssessIcon.gameObject
	self._btnNotFinishGo = self._btnNotFinish.gameObject
	self._btnFinishedGo = self._btnFinished.gameObject
	self._scrollrewardLimitScollRect = self._scrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
	self._txtDescr.text = ""
end

function V1a4_BossRush_ScoreTaskAchievementItem:_editableAddEvents()
	self._animEvent:AddEventListener(eAnimEvt.onEndBlock, self._onEndBlock, self)
	self._animEvent:AddEventListener(eAnimEvt.onFinishEnd, self._onFinishEnd, self)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_editableRemoveEvents()
	self._animEvent:RemoveEventListener(eAnimEvt.onEndBlock)
	self._animEvent:RemoveEventListener(eAnimEvt.onFinishEnd)
	TaskDispatcher.cancelTask(self._playOpenInner, self)
end

function V1a4_BossRush_ScoreTaskAchievementItem:onUpdateMO(mo)
	self:_initScollParentGameObject()

	self._mo = mo

	self:_setActiveBlock(true, true)
	self:_playOpen()
	self:_refresh()
end

function V1a4_BossRush_ScoreTaskAchievementItem:onDestroyView()
	TaskDispatcher.cancelTask(self._playOpenInner, self)
	self._imageAssessIcon:UnLoadImage()
end

function V1a4_BossRush_ScoreTaskAchievementItem:_refresh()
	local mo = self._mo
	local config = mo.config
	local bonus = config.bonus
	local achievementRes = config.achievementRes
	local maxProgress = config.maxProgress
	local isAllFinished = mo.finishCount >= config.maxFinishCount
	local isFinish = not isAllFinished and mo.hasFinished
	local isNotFinish = not isAllFinished and not isFinish
	local isEmptySprite = achievementRes == ""
	local itemDataList = ItemModel.instance:getItemDataListByConfigStr(bonus)

	if not isEmptySprite then
		self._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(achievementRes))
	end

	gohelper.setActive(self._imageAssessIconGo, not isEmptySprite)
	gohelper.setActive(self._btnNotFinishGo, isNotFinish)
	gohelper.setActive(self._btnFinishedGo, isFinish)
	gohelper.setActive(self._goAllFinished, isAllFinished)
	IconMgr.instance:getCommonPropItemIconList(self, self._onRewardItemShow, itemDataList, self._gorewards)

	self._txtDescr.text = BossRushConfig.instance:getScoreStr(maxProgress)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_onRewardItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setCountFontSize(48)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_playOpenInner()
	self:_setActive(true)
	self:_playAnim(UIAnimationName.Open)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_playOpen()
	local openAnim = V1a4_BossRush_ScoreTaskAchievementListModel.instance:getStaticData()

	if openAnim then
		self:_playIdle()

		return
	end

	self:_setActive(false)
	TaskDispatcher.runDelay(self._playOpenInner, self, self._index * 0.06)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_playFinish()
	self:_setActiveBlock(true)
	self:_playAnim(UIAnimationName.Finish)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_playIdle()
	self:_playAnim(UIAnimationName.Idle, 0, 1)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_playAnim(eUIAnimationName, ...)
	self._anim:Play(eUIAnimationName, ...)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_setActive(bool)
	gohelper.setActive(self.viewGO, bool)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_onEndBlock()
	self:_setActiveBlock(false, true)
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setStaticData(true)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_setActiveBlock(isActive, isOnce)
	local viewContainer = ViewMgr.instance:getContainer(ViewName.V1a4_BossRush_ScoreTaskAchievement)

	if not viewContainer then
		return
	end

	viewContainer:setActiveBlock(isActive, isOnce)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_onFinishEnd()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self._onFinishTweenEnd, self)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_onFinishTweenEnd()
	self:_playIdle()
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:claimRewardByIndex(self._index)
	self:_setActiveBlock(false)
end

function V1a4_BossRush_ScoreTaskAchievementItem:_initScollParentGameObject()
	if not self._isSetParent then
		self._scrollrewardLimitScollRect.parentGameObject = self._view:getCsListScroll().gameObject
		self._isSetParent = true
	end
end

return V1a4_BossRush_ScoreTaskAchievementItem
