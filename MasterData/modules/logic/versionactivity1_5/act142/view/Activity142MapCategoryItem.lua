-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142MapCategoryItem.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142MapCategoryItem", package.seeall)

local Activity142MapCategoryItem = class("Activity142MapCategoryItem", LuaCompBase)
local UNLOCK_ANIM_PLAY_AUDIO_DELAY_TIME = 1

function Activity142MapCategoryItem:ctor(param)
	self._index = param.index
	self._clickCb = param.clickCb
	self._clickCbObj = param.clickCbObj
end

function Activity142MapCategoryItem:init(go)
	self._go = go
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._go)
	self._golock = gohelper.findChild(self._go, "#go_lock")
	self._simagelock = gohelper.findChildImage(self._go, "#go_lock")
	self._txtlock = gohelper.findChildText(self._go, "#go_lock/#txt_lock")
	self._gounlock = gohelper.findChild(self._go, "#go_unlock")
	self._gonormal = gohelper.findChild(self._go, "#go_unlock/#go_normal")
	self._simagenormal = gohelper.findChildImage(self._go, "#go_unlock/#go_normal")
	self._txtnormal = gohelper.findChildText(self._go, "#go_unlock/#go_normal/#txt_normal")
	self._goselect = gohelper.findChild(self._go, "#go_unlock/#go_select")
	self._simageselect = gohelper.findChildImage(self._go, "#go_unlock/#go_select")
	self._txtselect = gohelper.findChildText(self._go, "#go_unlock/#go_select/#txt_select")
	self._btncategory = gohelper.findChildButtonWithAudio(self._go, "#btn_click")

	self:setChapterId()
	self:setIsSelected(false)
end

function Activity142MapCategoryItem:addEventListeners()
	self._btncategory:AddClickListener(self.onClick, self)
end

function Activity142MapCategoryItem:removeEventListeners()
	self._btncategory:RemoveClickListener()
end

function Activity142MapCategoryItem:onClick(notPlaySwitchAnim)
	if self._isSelected or not self._chapterId or not self._index then
		return
	end

	if not self:isChapterOpen() then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	if self._clickCb then
		self._clickCb(self._clickCbObj, self._index, notPlaySwitchAnim)
	end
end

function Activity142MapCategoryItem:setChapterId(chapterId)
	self:cancelAllTaskDispatcher()

	self._chapterId = chapterId

	if self._chapterId then
		local actId = Activity142Model.instance:getActivityId()
		local name = Activity142Config.instance:getChapterName(actId, self._chapterId)

		self._txtnormal.text = name
		self._txtselect.text = name

		local colorStr = Activity142Config.instance:getChapterCategoryTxtColor(actId, self._chapterId)

		if colorStr then
			local txtColor = GameUtil.parseColor(colorStr)

			self._txtnormal.color = txtColor
			self._txtselect.color = txtColor
		end

		local normalSpriteName = Activity142Config.instance:getChapterCategoryNormalSP(actId, self._chapterId)

		if normalSpriteName then
			UISpriteSetMgr.instance:setV1a5ChessSprite(self._simagenormal, normalSpriteName)
		end

		local selectSpriteName = Activity142Config.instance:getChapterCategorySelectSP(actId, self._chapterId)

		if selectSpriteName then
			UISpriteSetMgr.instance:setV1a5ChessSprite(self._simageselect, selectSpriteName)
		end

		local lockSpriteName = Activity142Config.instance:getChapterCategoryLockSP(actId, self._chapterId)

		if lockSpriteName then
			UISpriteSetMgr.instance:setV1a5ChessSprite(self._simagelock, lockSpriteName)
		end

		self:refresh()
		self:setIsSelected(false)
	end

	gohelper.setActive(self._go, self._chapterId)
end

function Activity142MapCategoryItem:getChapterId()
	return self._chapterId
end

function Activity142MapCategoryItem:refresh(unlockAnimDelayTime)
	if self._animatorPlayer then
		if self._animatorPlayer then
			self._animatorPlayer:Play(Activity142Enum.CATEGORY_IDLE_ANIM)
		end

		local isChapterOpen = self:isChapterOpen()
		local cacheKey = string.format("%s_%s", Activity142Enum.CATEGORY_CACHE_KEY, self._chapterId)
		local isPlayUnlockAnim = self._chapterId ~= Activity142Enum.NOT_PLAY_UNLOCK_ANIM_CHAPTER and not Activity142Controller.instance:havePlayedUnlockAni(cacheKey)

		if isPlayUnlockAnim and self._animatorPlayer and isChapterOpen then
			self:playUnlockAnim(unlockAnimDelayTime)
		else
			gohelper.setActive(self._gounlock, isChapterOpen)
			gohelper.setActive(self._golock, not isChapterOpen)
		end
	end
end

function Activity142MapCategoryItem:setIsSelected(_isSelected)
	self._isSelected = _isSelected

	gohelper.setActive(self._goselect, self._isSelected)
	gohelper.setActive(self._gonormal, not self._isSelected)
end

function Activity142MapCategoryItem:isChapterOpen()
	return (Activity142Model.instance:isChapterOpen(self._chapterId))
end

function Activity142MapCategoryItem:playUnlockAnim(delayTime)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.MAP_CATEGORY_UNLOCK)
	gohelper.setActive(self._golock, true)
	gohelper.setActive(self._gounlock, false)

	if delayTime and delayTime > 0 then
		TaskDispatcher.runDelay(self._delayPlayUnlockAnim, self, delayTime)
	else
		self:_delayPlayUnlockAnim()
	end
end

function Activity142MapCategoryItem:_delayPlayUnlockAnim()
	UIBlockMgrExtend.setNeedCircleMv(false)
	gohelper.setActive(self._gounlock, true)
	TaskDispatcher.runDelay(self.playUnlockAudio, self, UNLOCK_ANIM_PLAY_AUDIO_DELAY_TIME)
	self._animatorPlayer:Play(Activity142Enum.MAP_ITEM_UNLOCK_ANIM, self._finishUnlockAnim, self)
end

function Activity142MapCategoryItem:playUnlockAudio()
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockChapter)
end

function Activity142MapCategoryItem:_finishUnlockAnim()
	local cacheKey = string.format("%s_%s", Activity142Enum.CATEGORY_CACHE_KEY, self._chapterId)

	Activity142Controller.instance:setPlayedUnlockAni(cacheKey)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.MAP_CATEGORY_UNLOCK)
end

function Activity142MapCategoryItem:onDestroy()
	self._index = nil
	self._chapterId = nil
	self._clickCb = nil
	self._clickCbObj = nil
	self._isSelected = false

	self:cancelAllTaskDispatcher()
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.MAP_CATEGORY_UNLOCK)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function Activity142MapCategoryItem:cancelAllTaskDispatcher()
	TaskDispatcher.cancelTask(self._delayPlayUnlockAnim, self)
	TaskDispatcher.cancelTask(self.playUnlockAudio, self)
end

return Activity142MapCategoryItem
