-- chunkname: @modules/logic/versionactivity2_1/warmup/view/Act2_1WarmUpLeftView.lua

module("modules.logic.versionactivity2_1.warmup.view.Act2_1WarmUpLeftView", package.seeall)

local Act2_1WarmUpLeftView = class("Act2_1WarmUpLeftView", BaseView)

function Act2_1WarmUpLeftView:onInitView()
	local go = gohelper.findChild(self.viewGO, "Middle")

	self._middleGo = go
	self._godrag = gohelper.findChild(go, "#go_drag")
	self._imageicon = gohelper.findChildImage(go, "#image_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act2_1WarmUpLeftView:addEvents()
	return
end

function Act2_1WarmUpLeftView:removeEvents()
	return
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local kHasDragged = 1
local csAnimatorPlayer = SLFramework.AnimatorPlayer

function Act2_1WarmUpLeftView:_editableInitView()
	self._drag = UIDragListenerHelper.New()
	self._animatorPlayer = csAnimatorPlayer.Get(self._middleGo)
	self._animSelf = self._animatorPlayer.animator
	self._guideGo = gohelper.findChild(self.viewGO, "Middle/guide")
	self._animatorPlayer_guide = csAnimatorPlayer.Get(self._guideGo)
	self._audioClick = gohelper.getClickWithDefaultAudio(self._godrag)
	self._draggedState = kFirstLocked
end

function Act2_1WarmUpLeftView:onDataUpdateFirst()
	if self:_checkIsOpen() then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end

	self._drag:create(self._godrag)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
end

function Act2_1WarmUpLeftView:onDataUpdate()
	self:_refresh()
end

function Act2_1WarmUpLeftView:onSwitchEpisode()
	local isOpened = self:_checkIsOpen()

	if self._draggedState == kFirstUnlocked and not isOpened then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isOpened then
		self._draggedState = kFirstUnlocked
	end

	self:_refresh()
end

function Act2_1WarmUpLeftView:onOpen()
	return
end

function Act2_1WarmUpLeftView:onClose()
	return
end

function Act2_1WarmUpLeftView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
end

function Act2_1WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
end

function Act2_1WarmUpLeftView:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function Act2_1WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function Act2_1WarmUpLeftView:_checkIsOpen(episodeId)
	return self.viewContainer:checkIsOpen(episodeId or self:_episodeId())
end

function Act2_1WarmUpLeftView:_refresh()
	local episodeId = self:_episodeId()
	local isOpened = self:_checkIsOpen(episodeId)
	local spriteName = self.viewContainer:getImgSpriteName(self.viewContainer:episode2Index(episodeId))

	UISpriteSetMgr.instance:setV2a1WarmupSprite(self._imageicon, spriteName, true)
	self:_setActive_guide(not isOpened and self._draggedState <= kFirstLocked)
	self:_setActive_drag(not isOpened)
	self:_setBoxState(isOpened)
end

function Act2_1WarmUpLeftView:openGuide(cb, cbObj)
	self._animatorPlayer_guide:Play("guide_warmup1_loop", cb, cbObj)
end

function Act2_1WarmUpLeftView:_onDragBegin()
	self:_setActive_guide(false)

	self._draggedState = kHasDragged
end

function Act2_1WarmUpLeftView:_onDragEnd()
	if self:_checkIsOpen() then
		return
	end

	if self._drag:isMoveVerticalMajor() and self._drag:isSwipeUp() then
		self:_playAnim_Box(true)
	end
end

function Act2_1WarmUpLeftView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb, cbObj)
end

function Act2_1WarmUpLeftView:_playAnimRaw(name, ...)
	self._animSelf.enabled = true

	self._animSelf:Play(name, ...)
end

local kBlock_Box = "Act2_1WarmUpLeftView:_playAnim_Box"
local kTimeout = 9.99

function Act2_1WarmUpLeftView:_playAnim_Box(isOpen)
	local episodeId = self:_episodeId()

	if isOpen == self:_checkIsOpen(episodeId) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wangshi_carton_open_20211603)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Box, kTimeout, self.viewName)

	self._animSelf.speed = isOpen and 1 or -1

	self:_playAnim("open", function()
		self.viewContainer:saveBoxState(episodeId, isOpen)
		self.viewContainer:openDesc()
		UIBlockHelper.instance:endBlock(kBlock_Box)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end)
end

function Act2_1WarmUpLeftView:_setBoxState(isOpened)
	self:_playAnimRaw(isOpened and "unlock" or "lock", 0, 1)
end

return Act2_1WarmUpLeftView
