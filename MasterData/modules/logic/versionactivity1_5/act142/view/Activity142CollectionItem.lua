-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142CollectionItem.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142CollectionItem", package.seeall)

local Activity142CollectionItem = class("Activity142CollectionItem", LuaCompBase)
local UNLOCK_ANIM_PLAY_AUDIO_DELAY_TIME = 0.25

function Activity142CollectionItem:init(go)
	self._go = go
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._go)
	self._goUnlock = gohelper.findChild(self._go, "go_unlocked")
	self._collectionIcon = gohelper.findChildImage(self._go, "go_unlocked/icon_bg/collection_icon")
	self._txtName = gohelper.findChildText(self._go, "go_unlocked/middle/#txt_name")
	self._txtNameEn = gohelper.findChildText(self._go, "go_unlocked/middle/#txt_en")
	self._scrollDesc = gohelper.findChild(self._go, "go_unlocked/#scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._txtDesc = gohelper.findChildText(self._go, "go_unlocked/#scroll_desc/Viewport/Content/#txt_desc")
	self._txtUnlockIndex = gohelper.findChildText(self._go, "go_unlocked/#txt_index")
	self._goLock = gohelper.findChild(self._go, "go_locked")
	self._txtLockIndex = gohelper.findChildText(self._go, "go_locked/#txt_index")
	self._goRightLine = gohelper.findChild(self._go, "line")
	self._index = nil
	self._collectionId = nil
	self._isLast = false
end

function Activity142CollectionItem:setData(index, collectionId, isLast, parentScrollGO)
	self._index = index
	self._collectionId = collectionId
	self._isLast = isLast
	self._parentScrollGO = parentScrollGO

	self:refresh()
	gohelper.setActive(self._go, self._collectionId)
end

function Activity142CollectionItem:onStart()
	if not self._collectionId then
		return
	end

	self:refresh()
end

function Activity142CollectionItem:refresh()
	if not self._collectionId or gohelper.isNil(self._go) then
		return
	end

	if self._parentScrollGO then
		self._scrollDesc.parentGameObject = self._parentScrollGO
	end

	self._scrollDesc.horizontalNormalizedPosition = 0

	local actId = Activity142Model.instance:getActivityId()
	local collectionCfg = Activity142Config.instance:getCollectionCfg(actId, self._collectionId, true)

	if not collectionCfg then
		return
	end

	local isHasCollection = Activity142Model.instance:isHasCollection(self._collectionId)

	if isHasCollection then
		self._txtDesc.text = collectionCfg.desc
		self._txtName.text = collectionCfg.name
		self._txtNameEn.text = collectionCfg.nameen

		self:loadIcon(collectionCfg.icon)
	end

	if self._animatorPlayer then
		local isAnimatorReady = self._animatorPlayer.isActiveAndEnabled

		if isAnimatorReady then
			self._animatorPlayer:Play(Activity142Enum.COLLECTION_IDLE_ANIM)
		end

		local cacheKey = string.format("%s_%s", Activity142Enum.COLLECTION_CACHE_KEY, self._collectionId)
		local isPlayUnlockAnim = not Activity142Controller.instance:havePlayedUnlockAni(cacheKey)

		if isPlayUnlockAnim and isAnimatorReady and isHasCollection then
			Activity142Helper.setAct142UIBlock(true, Activity142Enum.COLLECTION_UNLOCK)
			gohelper.setActive(self._goLock, true)
			gohelper.setActive(self._goUnlock, true)
			TaskDispatcher.runDelay(self.playUnlockAudio, self, UNLOCK_ANIM_PLAY_AUDIO_DELAY_TIME)
			self._animatorPlayer:Play(Activity142Enum.COLLECTION_UNLOCK_ANIM, self._finishUnlockAnim, self)
		else
			gohelper.setActive(self._goUnlock, isHasCollection)
			gohelper.setActive(self._goLock, not isHasCollection)
		end

		local strIndex = string.format("%02d", self._collectionId)

		self._txtUnlockIndex.text = strIndex
		self._txtLockIndex.text = strIndex

		gohelper.setActive(self._goRightLine, self._isLast)
	end
end

function Activity142CollectionItem:playUnlockAudio()
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockItem)
end

function Activity142CollectionItem:_finishUnlockAnim()
	local cacheKey = string.format("%s_%s", Activity142Enum.COLLECTION_CACHE_KEY, self._collectionId)

	Activity142Controller.instance:setPlayedUnlockAni(cacheKey)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.COLLECTION_UNLOCK)
end

function Activity142CollectionItem:loadIcon(icon)
	if not icon then
		return
	end

	UISpriteSetMgr.instance:setV1a5ChessSprite(self._collectionIcon, icon)
end

function Activity142CollectionItem:onDestroy()
	self._index = nil
	self._collectionId = nil
	self._isLast = false

	TaskDispatcher.cancelTask(self.playUnlockAudio, self)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.COLLECTION_UNLOCK)
end

return Activity142CollectionItem
