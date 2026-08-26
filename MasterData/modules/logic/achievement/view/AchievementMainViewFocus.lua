-- chunkname: @modules/logic/achievement/view/AchievementMainViewFocus.lua

module("modules.logic.achievement.view.AchievementMainViewFocus", package.seeall)

local AchievementMainViewFocus = class("AchievementMainViewFocus", BaseView)

function AchievementMainViewFocus:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementMainViewFocus:addEvents()
	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.OnSwitchCategory, self.onSwitchCategory, self)
	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.OnSwitchViewType, self.onSwitchViewType, self)
end

function AchievementMainViewFocus:removeEvents()
	self.removeEventCb(self, AchievementMainController.instance, AchievementEvent.OnSwitchCategory, self.onSwitchCategory, self)
	self.removeEventCb(self, AchievementMainController.instance, AchievementEvent.OnSwitchViewType, self.onSwitchViewType, self)
end

function AchievementMainViewFocus:_editableInitView()
	return
end

function AchievementMainViewFocus:onDestroyView()
	TaskDispatcher.cancelTask(self.focus2OriginAchievement, self)
	TaskDispatcher.cancelTask(self.triggerAchievementUnLockAduio, self)
	TaskDispatcher.cancelTask(self.setHasPlayOpenAnim, self)
	TaskDispatcher.cancelTask(self.onFocusNewestUpgradeGroupSucc, self)
	TaskDispatcher.cancelTask(self._blockSwtichCategory, self)

	if self._scrollFocusTweenId then
		ZProj.TweenHelper.KillById(self._scrollFocusTweenId)

		self._scrollFocusTweenId = nil
	end
end

function AchievementMainViewFocus:onOpen()
	self:checkIsNeedFocusAchievement()
end

function AchievementMainViewFocus:onClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_Focus")
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_FocusOrigin")
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_SwitchCategory")
end

local playGroupUpgradeEffectTime = 2

function AchievementMainViewFocus:checkIsNeedFocusAchievement()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_FocusOrigin")

	local isSucc = self:checkIsNeedFocusNewest()

	if isSucc then
		if not playGroupUpgradeEffectTime then
			local delayFocusOrignAchievementTime = 0

			TaskDispatcher.cancelTask(self.focus2OriginAchievement, self)
			TaskDispatcher.runDelay(self.focus2OriginAchievement, self, delayFocusOrignAchievementTime)
		end
	end
end

function AchievementMainViewFocus:checkIsNeedFocusNewest()
	local isSucc = self:try2FocusNewestUpgradeGroup()

	isSucc = isSucc or self:try2FocusNewestUnlockAchievement()

	return isSucc
end

function AchievementMainViewFocus:focus2OriginAchievement()
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_FocusOrigin")

	if self.viewParam then
		if self.viewParam then
			local focusDataId = self.viewParam.focusDataId
			local isSucc = false

			if self.viewParam and focusDataId and focusDataId ~= 0 then
				isSucc = self:try2FocusAchievement(self.viewParam, focusDataId)
			else
				self:setHasPlayOpenAnim()
			end

			return isSucc
		end
	end
end

function AchievementMainViewFocus:onSwitchCategory()
	local isSucc = self:checkIsNeedFocusNewest()

	if not isSucc then
		self:resetViewScrollPixel()
	end

	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_SwitchCategory")
	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.runDelay(self._blockSwtichCategory, self, 0.5)
end

function AchievementMainViewFocus:_blockSwtichCategory()
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_SwitchCategory")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function AchievementMainViewFocus:onSwitchViewType()
	local isSucc = self:checkIsNeedFocusNewest()

	if not isSucc then
		self:resetViewScrollPixel()
	end
end

function AchievementMainViewFocus:try2FocusAchievement(achievementType, dataId)
	local viewType = AchievementMainCommonModel.instance:getCurrentViewType()
	local isSucc, achievementIndex, scrollPixel = AchievementMainCommonModel.instance:getViewAchievementIndex(viewType, achievementType, dataId)
	local duration = 0

	if isSucc then
		duration = self:scrollView2TargetPixel(viewType, scrollPixel, achievementIndex)
	else
		logError(string.format("focus achievement failed, achievementType = %s, dataId = %s", achievementType, dataId))
	end

	return isSucc, duration
end

local scrollPerPixleDuration = 0.0001
local minScrollFocsuDuration = 0
local maxScrollFocusDuration = 1

function AchievementMainViewFocus:scrollView2TargetPixel(viewType, scrollPixel, achievementIndex)
	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_Focus")
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)

	if self._scrollFocusTweenId then
		ZProj.TweenHelper.KillById(self._scrollFocusTweenId)
	end

	local luaScrollView = self.viewContainer:getScrollView(viewType)
	local csScroll = luaScrollView and luaScrollView:getCsScroll()

	self._curFocusAchievementIndex = achievementIndex

	local duration = 0

	if luaScrollView and csScroll then
		self._curFocusCsScroll = csScroll

		local originVScrollPixel = csScroll.VerticalScrollPixel
		local targetVScrollPixel = scrollPixel or 0
		local scrollDistance = math.abs(targetVScrollPixel - originVScrollPixel)

		duration = scrollDistance * scrollPerPixleDuration
		duration = Mathf.Clamp(scrollDistance * scrollPerPixleDuration, minScrollFocsuDuration, maxScrollFocusDuration)

		if scrollDistance <= 0 then
			self:_onFocusTweenFrameCallback(targetVScrollPixel)
			self:_onFocusTweenFinishCallback()
		else
			self._scrollFocusTweenId = ZProj.TweenHelper.DOTweenFloat(originVScrollPixel, targetVScrollPixel, duration, self._onFocusTweenFrameCallback, self._onFocusTweenFinishCallback, self)
		end
	end

	return duration
end

function AchievementMainViewFocus:_onFocusTweenFrameCallback(scrollPixel)
	if self._curFocusCsScroll then
		self._curFocusCsScroll.VerticalScrollPixel = scrollPixel
	end
end

local delayDispatchFocusFinishedEventTime = 0.05

function AchievementMainViewFocus:_onFocusTweenFinishCallback()
	local scrollViewTopIndex = Mathf.Clamp(self._curFocusAchievementIndex - 1, 1, self._curFocusAchievementIndex)

	AchievementMainTileModel.instance:markScrollFocusIndex(scrollViewTopIndex)
	TaskDispatcher.cancelTask(self.setHasPlayOpenAnim, self)
	TaskDispatcher.runDelay(self.setHasPlayOpenAnim, self, delayDispatchFocusFinishedEventTime)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_Focus")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function AchievementMainViewFocus:setHasPlayOpenAnim()
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(false)

	local curViewType = AchievementMainCommonModel.instance:getCurrentViewType()

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnFocusAchievementFinished, curViewType)
	AchievementMainTileModel.instance:setHasPlayOpenAnim(true)
end

function AchievementMainViewFocus:try2FocusNewestUpgradeGroup()
	local matchGroupId = self:getNewestUpgradeGroup()
	local isSucc = false
	local duration = 0

	if matchGroupId and matchGroupId ~= 0 then
		isSucc, duration = self:try2FocusAchievement(AchievementEnum.AchievementType.Group, matchGroupId)

		if isSucc then
			self._focusUpgradeGroupId = matchGroupId

			AchievementMainCommonModel.instance:markGroupPlayUpgradeEffect(matchGroupId)

			local delayExcuteTime = duration + delayDispatchFocusFinishedEventTime + 0.1

			TaskDispatcher.cancelTask(self.onFocusNewestUpgradeGroupSucc, self)
			TaskDispatcher.runDelay(self.onFocusNewestUpgradeGroupSucc, self, delayExcuteTime)
		end
	end

	return isSucc
end

function AchievementMainViewFocus:onFocusNewestUpgradeGroupSucc()
	AchievementController.instance:dispatchEvent(AchievementEvent.OnGroupUpGrade, self._focusUpgradeGroupId)
	self:triggerAchievementUnLockAduio()
end

function AchievementMainViewFocus:getNewestUpgradeGroup()
	local curSelectCategory = AchievementMainCommonModel.instance:getCurrentCategory()
	local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()

	return (AchievementMainCommonModel.instance:getNewestUpgradeGroupId(curSelectCategory, curFilterType))
end

function AchievementMainViewFocus:try2FocusNewestUnlockAchievement()
	local matchAchievementId = self:getNewestUnlockAchievement()
	local isSucc = false
	local duration = 0

	if matchAchievementId and matchAchievementId ~= 0 then
		local achievementCfg = AchievementConfig.instance:getAchievement(matchAchievementId)
		local curViewType = AchievementMainCommonModel.instance:getCurrentViewType()
		local achievementType = AchievementEnum.AchievementType.Single
		local matchData = matchAchievementId

		if curViewType == AchievementEnum.ViewType.Tile and AchievementUtils.isActivityGroup(matchAchievementId) then
			achievementType = AchievementEnum.AchievementType.Group
			matchData = achievementCfg.groupId
		end

		isSucc, duration = self:try2FocusAchievement(achievementType, matchData)

		if isSucc then
			local dealyTriggerAuidoTime = duration + delayDispatchFocusFinishedEventTime

			TaskDispatcher.cancelTask(self.triggerAchievementUnLockAduio, self)
			TaskDispatcher.runDelay(self.triggerAchievementUnLockAduio, self, dealyTriggerAuidoTime)
		end
	end

	return isSucc
end

function AchievementMainViewFocus:triggerAchievementUnLockAduio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_medal)
end

function AchievementMainViewFocus:getNewestUnlockAchievement()
	local curSelectCategory = AchievementMainCommonModel.instance:getCurrentCategory()
	local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()

	return (AchievementMainCommonModel.instance:getNewestUnlockAchievementId(curSelectCategory, curFilterType))
end

function AchievementMainViewFocus:resetViewScrollPixel()
	for _, viewType in pairs(AchievementEnum.ViewType) do
		local luaScrollView = self.viewContainer:getScrollView(viewType)
		local csScroll = luaScrollView and luaScrollView:getCsScroll()

		csScroll.VerticalScrollPixel = 0

		self:scrollView2TargetPixel(viewType, 0, 1)
	end
end

return AchievementMainViewFocus
