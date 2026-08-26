-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142StoryItem.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142StoryItem", package.seeall)

local Activity142StoryItem = class("Activity142StoryItem", ListScrollCellExtend)
local UNLOCK_ANIM_PLAY_AUDIO_DELAY_TIME = 0.25

function Activity142StoryItem:onInitView()
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._goNormal = gohelper.findChild(self.viewGO, "normal")
	self._txtUnlockNum = gohelper.findChildText(self.viewGO, "normal/txt_titlenum")
	self._imageUnlockStoryIcon = gohelper.findChildImage(self.viewGO, "normal/icon_bg/icon_story")
	self._txtName = gohelper.findChildText(self.viewGO, "normal/middle/txt_name")
	self._txtNameEn = gohelper.findChildText(self.viewGO, "normal/middle/txt_name_en")
	self._btnReplay = gohelper.findChildButtonWithAudio(self.viewGO, "normal/bottom/btn_replay")
	self._goUnlockEff = gohelper.findChild(self.viewGO, "unlock")
	self._goLock = gohelper.findChild(self.viewGO, "locked")
	self._txtLockNum = gohelper.findChildText(self.viewGO, "locked/txt_titlenum")
	self._imageLockStoryIcon = gohelper.findChildSingleImage(self.viewGO, "locked/icon_bg/icon_story")
	self._btnLockReplay = gohelper.findChildButtonWithAudio(self.viewGO, "locked/bottom/btn_replay")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity142StoryItem:addEvents()
	self._btnReplay:AddClickListener(self._btnReviewOnClick, self)
	self._btnLockReplay:AddClickListener(self._btnReviewOnClick, self)
end

function Activity142StoryItem:removeEvents()
	self._btnReplay:RemoveClickListener()
	self._btnLockReplay:RemoveClickListener()
end

function Activity142StoryItem:_btnReviewOnClick()
	if not self._storyMO then
		return
	end

	local storyId = self._storyMO.storyId
	local isLocked = not StoryModel.instance:isStoryHasPlayed(storyId)

	if isLocked then
		GameFacade.showToast(ToastEnum.Va3Act122StoryIsLock)

		return
	end

	local param = {}

	param.hideStartAndEndDark = true

	StoryController.instance:playStory(storyId, param)
end

function Activity142StoryItem:_editableInitView()
	gohelper.setActive(self._goNormal, false)
	gohelper.setActive(self._goLock, false)
end

function Activity142StoryItem:onUpdateMO(mo)
	self._storyMO = mo

	self:_refreshUI()
end

function Activity142StoryItem:_refreshUI()
	if not self._storyMO then
		return
	end

	gohelper.setActive(self._goUnlockEff, false)

	local storyId = self._storyMO.storyId
	local actId = Activity142Model.instance:getActivityId()
	local storyCfg = Activity142Config.instance:getAct142StoryCfg(actId, storyId)

	if not storyCfg then
		return
	end

	local isUnlock = StoryModel.instance:isStoryHasPlayed(storyId)

	if isUnlock and not string.nilorempty(storyCfg.icon) then
		UISpriteSetMgr.instance:setV1a5ChessSprite(self._imageUnlockStoryIcon, storyCfg.icon)
	end

	local strNum = string.format("%02d", self._storyMO.index)

	self._txtUnlockNum.text = strNum
	self._txtName.text = storyCfg.name

	if isUnlock then
		self._txtNameEn.text = storyCfg.nameen or "UNKNOWN"
	end

	self._txtLockNum.text = strNum

	if self._animatorPlayer then
		local isAnimatorReady = self._animatorPlayer.isActiveAndEnabled

		if isAnimatorReady then
			self._animatorPlayer:Play(Activity142Enum.STORY_REVIEW_IDLE_ANIM)
		end

		local cacheKey = string.format("%s_%s", Activity142Enum.STORY_REVIEW__CACHE_KEY, storyId)
		local isPlayUnlockAnim = not Activity142Controller.instance:havePlayedUnlockAni(cacheKey)

		if isPlayUnlockAnim and isAnimatorReady and isUnlock then
			Activity142Helper.setAct142UIBlock(true, Activity142Enum.STORY_REVIEW_UNLOCK)
			gohelper.setActive(self._goNormal, true)
			gohelper.setActive(self._goLock, true)
			TaskDispatcher.runDelay(self.playUnlockAudio, self, UNLOCK_ANIM_PLAY_AUDIO_DELAY_TIME)
			self._animatorPlayer:Play(Activity142Enum.STORY_REVIEW_UNLOCK_ANIM, self._finishUnlockAnim, self)
		else
			gohelper.setActive(self._goNormal, isUnlock)
			gohelper.setActive(self._goLock, not isUnlock)
		end
	end
end

function Activity142StoryItem:playUnlockAudio()
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockItem)
end

function Activity142StoryItem:_finishUnlockAnim()
	local storyId = self._storyMO.storyId
	local cacheKey = string.format("%s_%s", Activity142Enum.STORY_REVIEW__CACHE_KEY, storyId)

	Activity142Controller.instance:setPlayedUnlockAni(cacheKey)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.STORY_REVIEW_UNLOCK)
end

function Activity142StoryItem:onDestroyView()
	TaskDispatcher.cancelTask(self.playUnlockAudio, self)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.STORY_REVIEW_UNLOCK)
end

return Activity142StoryItem
