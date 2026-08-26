-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/revivaltask/VersionActivity1_5SubHeroTaskItem.lua

module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5SubHeroTaskItem", package.seeall)

local VersionActivity1_5SubHeroTaskItem = class("VersionActivity1_5SubHeroTaskItem", UserDataDispose)

function VersionActivity1_5SubHeroTaskItem.createItem(go)
	local item = VersionActivity1_5SubHeroTaskItem.New()

	item:init(go)

	return item
end

function VersionActivity1_5SubHeroTaskItem:init(go)
	self:__onInit()

	self.go = go
	self._gofinished = gohelper.findChild(self.go, "#go_finished")
	self._txttitle = gohelper.findChildText(self.go, "#go_finished/#txt_title")
	self._txtdes = gohelper.findChildText(self.go, "#go_finished/#txt_des")
	self._gofinishrewarditem = gohelper.findChild(self.go, "#go_finished/#go_finishrewarditem")
	self._goGainReward = gohelper.findChild(self.go, "#go_finished/#go_gainReward")
	self.tipClick = gohelper.findChildClickWithDefaultAudio(self.go, "#go_finished/bg")
	self._gohasget = gohelper.findChild(self.go, "#go_finished/go_hasget")
	self._finishAnimator = ZProj.ProjAnimatorPlayer.Get(self._gofinished)
	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._txtnormaltitle = gohelper.findChildText(self.go, "#go_normal/#txt_title")
	self._txtnormaldes = gohelper.findChildText(self.go, "#go_normal/#txt_des")
	self._gonormalrewarditem = gohelper.findChild(self.go, "#go_normal/#go_normalrewarditem")
	self._btngo = gohelper.findChildButtonWithAudio(self.go, "#go_normal/btn_go")
	self._normalAnimator = ZProj.ProjAnimatorPlayer.Get(self._gonormal)
	self._golocked = gohelper.findChild(self.go, "#go_locked")
	self._txtlocked = gohelper.findChildText(self.go, "#go_locked/#txt_locked")
	self._golockrewarditem = gohelper.findChild(self.go, "#go_locked/#go_lockrewarditem")
	self._lockAnimator = ZProj.ProjAnimatorPlayer.Get(self._golocked)
	self._gainRewardClick = gohelper.getClickWithDefaultAudio(self._goGainReward, AudioEnum.UI.UI_Common_Click)

	self.tipClick:AddClickListener(self.tipClickOnClick, self)
	self._btngo:AddClickListener(self._btngoOnClick, self)
	self._gainRewardClick:AddClickListener(self.onClickGainReward, self)

	self.openViewFinish = ViewMgr.instance:isOpenFinish(ViewName.VersionActivity1_5RevivalTaskView)

	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedSubHeroTaskReward, self.onGainedSubHeroTaskReward, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OpenAnimPlayingStatusChange, self.openAnimPlayingStatusChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
end

function VersionActivity1_5SubHeroTaskItem:tipClickOnClick()
	if self.status < VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished then
		return
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ShowSubTaskDetail, self.config)
end

function VersionActivity1_5SubHeroTaskItem:_btngoOnClick()
	if self.status ~= VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal then
		return
	end

	for _, elementId in ipairs(self.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(elementId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_5RevivalTaskView)
			VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.FocusElement, elementId)

			return
		end
	end
end

function VersionActivity1_5SubHeroTaskItem:onClickGainReward()
	VersionActivity1_5DungeonRpc.instance:sendAct139GainSubHeroTaskRewardRequest(self.id)
end

function VersionActivity1_5SubHeroTaskItem:show()
	gohelper.setActive(self.go, true)
end

function VersionActivity1_5SubHeroTaskItem:hide()
	gohelper.setActive(self.go, false)
end

function VersionActivity1_5SubHeroTaskItem:updateData(subHeroTaskCo)
	self.id = subHeroTaskCo.id
	self.config = subHeroTaskCo
	self.elementList = string.splitToNumber(self.config.elementIds, "#")

	local rewardList = string.splitToNumber(self.config.reward, "#")

	self.rewardType = rewardList[1]
	self.rewardId = rewardList[2]
	self.rewardQuantity = rewardList[3]

	self:refreshUI()
end

function VersionActivity1_5SubHeroTaskItem:refreshUI()
	self.status = VersionActivity1_5RevivalTaskModel.instance:getSubHeroTaskStatus(self.config)

	gohelper.setActive(self._gofinished, self.status >= VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished)
	gohelper.setActive(self._gonormal, self.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal)
	gohelper.setActive(self._golocked, self.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock)

	if self.status >= VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished then
		self:refreshFinishedUI()
	elseif self.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal then
		self:refreshNormalUI()
	elseif self.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock then
		self:refreshLockUI()
	end

	self.icon:setMOValue(self.rewardType, self.rewardId, self.rewardQuantity)
	self.icon:setScale(0.6, 0.6, 0.6)
end

function VersionActivity1_5SubHeroTaskItem:refreshFinishedUI()
	self._txttitle.text = self.config.title
	self._txtdes.text = GameUtil.getBriefName(self.config.desc .. self.config.descSuffix, VersionActivity1_5DungeonEnum.HeroTaskDescShowCount, VersionActivity1_5DungeonEnum.Suffix)
	self.finishRewardIcon = self.finishRewardIcon or IconMgr.instance:getCommonItemIcon(self._gofinishrewarditem)
	self.icon = self.finishRewardIcon

	self:refreshGainedReward()
	self:playUnlockAnimation(self.playFinishOpenAnim)
end

function VersionActivity1_5SubHeroTaskItem:refreshGainedReward()
	local gainedReward = VersionActivity1_5RevivalTaskModel.instance:checkSubHeroTaskGainedReward(self.config)

	gohelper.setActive(self._gohasget, gainedReward)
	gohelper.setActive(self._goGainReward, not gainedReward)
end

function VersionActivity1_5SubHeroTaskItem:onGainedSubHeroTaskReward(subTaskId)
	if self.id ~= subTaskId then
		return
	end

	self:refreshGainedReward()
end

function VersionActivity1_5SubHeroTaskItem:refreshNormalUI()
	self._txtnormaltitle.text = self.config.title
	self._txtnormaldes.text = GameUtil.getBriefName(self.config.desc, VersionActivity1_5DungeonEnum.HeroTaskDescShowCount, VersionActivity1_5DungeonEnum.Suffix)
	self.normalRewardIcon = self.normalRewardIcon or IconMgr.instance:getCommonItemIcon(self._gonormalrewarditem)
	self.icon = self.normalRewardIcon

	self:playUnlockAnimation(self.playNormalOpenAnim)
end

function VersionActivity1_5SubHeroTaskItem:refreshLockUI()
	self._txtlocked.text = self.config.lockDesc
	self.lockRewardIcon = self.lockRewardIcon or IconMgr.instance:getCommonItemIcon(self._golockrewarditem)
	self.icon = self.lockRewardIcon

	self._lockAnimator:Play("idle")
end

function VersionActivity1_5SubHeroTaskItem:playUnlockAnimation(finishCallback)
	local isPlayed = VersionActivity1_5RevivalTaskModel.instance:checkIsPlayedUnlockAnimation(self.config.id)

	if not isPlayed then
		gohelper.setActive(self._gofinished, false)
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._golocked, true)

		self._txtlocked.text = self.config.lockDesc
		self.lockRewardIcon = self.lockRewardIcon or IconMgr.instance:getCommonItemIcon(self._golockrewarditem)

		self.lockRewardIcon:setMOValue(self.rewardType, self.rewardId, self.rewardQuantity)
		self.lockRewardIcon:setScale(0.6, 0.6, 0.6)

		self.unlockCallback = finishCallback

		self:_playUnlockAnimation()
	end
end

function VersionActivity1_5SubHeroTaskItem:_playUnlockAnimation()
	if self.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock then
		return
	end

	local isPlayed = VersionActivity1_5RevivalTaskModel.instance:checkIsPlayedUnlockAnimation(self.config.id)

	if isPlayed then
		return
	end

	if not self.openViewFinish then
		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:getIsPlayingOpenAnim() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_quest_unlock)
	self._lockAnimator:Play("unlock", self.unLockAnimationDone, self)
end

function VersionActivity1_5SubHeroTaskItem:unLockAnimationDone()
	VersionActivity1_5RevivalTaskModel.instance:playedUnlockAnimation(self.config.id)
	gohelper.setActive(self._golocked, false)

	if self.unlockCallback then
		self:unlockCallback()

		self.unlockCallback = nil
	end
end

function VersionActivity1_5SubHeroTaskItem:playNormalOpenAnim()
	gohelper.setActive(self._gonormal, true)
	self._normalAnimator:Play("open")
end

function VersionActivity1_5SubHeroTaskItem:playFinishOpenAnim()
	gohelper.setActive(self._gofinished, true)
	self._finishAnimator:Play("open")
end

function VersionActivity1_5SubHeroTaskItem:onOpenViewFinish(viewName)
	if viewName == ViewName.VersionActivity1_5RevivalTaskView then
		self.openViewFinish = true

		self:_playUnlockAnimation()
	end
end

function VersionActivity1_5SubHeroTaskItem:openAnimPlayingStatusChange(isPlaying)
	if not isPlaying then
		self:_playUnlockAnimation()
	end
end

function VersionActivity1_5SubHeroTaskItem:destroy()
	self.tipClick:RemoveClickListener()
	self._btngo:RemoveClickListener()
	self._gainRewardClick:RemoveClickListener()
	self:__onDispose()
end

return VersionActivity1_5SubHeroTaskItem
