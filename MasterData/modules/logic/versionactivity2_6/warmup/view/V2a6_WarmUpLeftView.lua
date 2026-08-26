-- chunkname: @modules/logic/versionactivity2_6/warmup/view/V2a6_WarmUpLeftView.lua

local sf = string.format

module("modules.logic.versionactivity2_6.warmup.view.V2a6_WarmUpLeftView", package.seeall)

local V2a6_WarmUpLeftView = class("V2a6_WarmUpLeftView", BaseView)

function V2a6_WarmUpLeftView:onInitView()
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "Middle/open/#simage_pic")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a6_WarmUpLeftView:addEvents()
	return
end

function V2a6_WarmUpLeftView:removeEvents()
	return
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local States = {
	SwipeDone = 1
}
local kCount = 5

function V2a6_WarmUpLeftView:ctor(...)
	V2a6_WarmUpLeftView.super.ctor(self, ...)

	self._lastEpisodeId = nil
	self._needWaitCount = 0
	self._draggedState = kFirstLocked
	self._dayItemList = {}
	self._drag = UIDragListenerHelper.New()
end

function V2a6_WarmUpLeftView:_editableInitView()
	self._middleGo = gohelper.findChild(self.viewGO, "Middle")
	self._openGo = gohelper.findChild(self._middleGo, "open")
	self._unopenGo = gohelper.findChild(self._middleGo, "unopen")
	self._godrag = gohelper.findChild(self._unopenGo, "drag")
	self._guideGo = gohelper.findChild(self._unopenGo, "guide")
	self._animatorPlayer = csAnimatorPlayer.Get(self._middleGo)
	self._animtor = self._animatorPlayer.animator

	self._drag:create(self._godrag)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
	self:_setActive_drag(true)
end

function V2a6_WarmUpLeftView:onOpen()
	return
end

function V2a6_WarmUpLeftView:onClose()
	GameUtil.onDestroyViewMember(self, "_drag")
end

function V2a6_WarmUpLeftView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
end

function V2a6_WarmUpLeftView:onDataUpdateFirst()
	if isDebugBuild then
		assert(self.viewContainer:getEpisodeCount() <= kCount, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	local isDone = self:_checkIsDone()

	if isDone then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end
end

function V2a6_WarmUpLeftView:onDataUpdate()
	self:_refresh()
end

function V2a6_WarmUpLeftView:onSwitchEpisode()
	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end

	self:_refresh()
end

function V2a6_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V2a6_WarmUpLeftView:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V2a6_WarmUpLeftView:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function V2a6_WarmUpLeftView:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function V2a6_WarmUpLeftView:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function V2a6_WarmUpLeftView:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function V2a6_WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
end

function V2a6_WarmUpLeftView:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function V2a6_WarmUpLeftView:_refresh()
	local isDone = self:_checkIsDone()

	self:_refreshImg()

	if isDone then
		self:_playAnimOpend()
		self:_setActive_drag(false)
		self:_setActive_guide(false)
	else
		local state = self:_getState()

		if state == 0 then
			self:_setActive_guide(not isDone and self._draggedState <= kFirstLocked)
			self:_setActive_drag(true)
			self:_playAnimIdle()
		elseif States.SwipeDone == state then
			self:_setActive_guide(false)
			self:_setActive_drag(false)
			self:_playAnimAfterSwipe()
		else
			logError("[V2a6_WarmUpLeftView] invalid state:" .. state)
		end
	end
end

function V2a6_WarmUpLeftView:_refreshImg()
	GameUtil.loadSImage(self._simagepic, sf("singlebg/v2a6_warmup_singlebg/v2a6_warmup_pic_%s.png", self:_episodeId()))
end

function V2a6_WarmUpLeftView:_onDragBegin()
	self:_setActive_guide(false)
end

function V2a6_WarmUpLeftView:_onDragEnd()
	if self:_checkIsDone() then
		return
	end

	if self._drag:isSwipeLT() or self._drag:isSwipeRB() or self._drag:isSwipeLeft() then
		self:_saveState(States.SwipeDone)
		self:_playAnimAfterSwipe()
	end
end

function V2a6_WarmUpLeftView:_playAnimAfterSwipe()
	self:_playAnimOpen(function()
		self:_saveStateDone(true)
		self.viewContainer:openDesc()
	end)
end

function V2a6_WarmUpLeftView:_playAnimIdle()
	self:_playAnim(UIAnimationName.Close)
end

function V2a6_WarmUpLeftView:_playAnimOpen(cb, cbObj)
	AudioMgr.instance:trigger(AudioEnum2_6.WarmUp.play_ui_wenming_page_20260904)
	self:_playAnim(UIAnimationName.Open, cb, cbObj)
end

function V2a6_WarmUpLeftView:_playAnimOpend()
	self:_playAnim(UIAnimationName.Finish)
end

function V2a6_WarmUpLeftView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

return V2a6_WarmUpLeftView
