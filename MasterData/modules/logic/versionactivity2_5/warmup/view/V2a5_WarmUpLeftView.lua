-- chunkname: @modules/logic/versionactivity2_5/warmup/view/V2a5_WarmUpLeftView.lua

module("modules.logic.versionactivity2_5.warmup.view.V2a5_WarmUpLeftView", package.seeall)

local V2a5_WarmUpLeftView = class("V2a5_WarmUpLeftView", BaseView)

function V2a5_WarmUpLeftView:onInitView()
	self._goopen = gohelper.findChild(self.viewGO, "Middle/#go_open")
	self._godrag = gohelper.findChild(self.viewGO, "Middle/#go_open/#go_drag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a5_WarmUpLeftView:addEvents()
	return
end

function V2a5_WarmUpLeftView:removeEvents()
	return
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local States = {
	SwipeDone = 1
}
local kCount = 5
local kAnimEvt = "onShowDay"

function V2a5_WarmUpLeftView:ctor(...)
	V2a5_WarmUpLeftView.super.ctor(self, ...)

	self._lastEpisodeId = nil
	self._needWaitCount = 0
	self._draggedState = kFirstLocked
	self._dayItemList = {}
	self._drag = UIDragListenerHelper.New()
end

function V2a5_WarmUpLeftView:_editableInitView()
	self._middleGo = gohelper.findChild(self.viewGO, "Middle")
	self._guideGo = gohelper.findChild(self._middleGo, "guide")
	self._animatorPlayer = csAnimatorPlayer.Get(self._middleGo)
	self._animtor = self._animatorPlayer.animator
	self._animEvent = gohelper.onceAddComponent(self._middleGo, gohelper.Type_AnimationEventWrap)

	self._drag:create(self._godrag)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
	self:_editableInitView_days()
	self:_setActive_drag(true)
	self._animEvent:AddEventListener(kAnimEvt, self._onShowDay, self)
end

function V2a5_WarmUpLeftView:_editableInitView_days()
	for i = 1, kCount do
		local go = gohelper.findChild(self._middleGo, "#go_day" .. i)
		local item = V2a5_WarmUpLeftView_Day.New({
			parent = self,
			baseViewContainer = self.viewContainer
		})

		item:setIndex(i)
		item:_internal_setEpisode(i)
		item:init(go)

		self._dayItemList[i] = item
	end
end

function V2a5_WarmUpLeftView:onOpen()
	return
end

function V2a5_WarmUpLeftView:onClose()
	self._animEvent:RemoveEventListener(kAnimEvt)
	GameUtil.onDestroyViewMember(self, "_drag")
	GameUtil.onDestroyViewMemberList(self, "_dayItemList")
end

function V2a5_WarmUpLeftView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
	GameUtil.onDestroyViewMemberList(self, "_dayItemList")
end

function V2a5_WarmUpLeftView:onDataUpdateFirst()
	if isDebugBuild then
		assert(self.viewContainer:getEpisodeCount() <= kCount, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	local isDone = self:_checkIsDone()

	if isDone then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end
end

function V2a5_WarmUpLeftView:onDataUpdate()
	self:_setActive_curEpisode(false)
	self:_refresh()
end

function V2a5_WarmUpLeftView:onSwitchEpisode()
	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end

	self:_setActive_curEpisode(false)
	self:_refresh()
end

function V2a5_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V2a5_WarmUpLeftView:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V2a5_WarmUpLeftView:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function V2a5_WarmUpLeftView:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function V2a5_WarmUpLeftView:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function V2a5_WarmUpLeftView:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function V2a5_WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
end

function V2a5_WarmUpLeftView:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function V2a5_WarmUpLeftView:_refresh()
	local isDone = self:_checkIsDone()

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
			logError("[V2a5_WarmUpLeftView] invalid state:" .. state)
		end
	end
end

function V2a5_WarmUpLeftView:_getItem(episodeId)
	local index = self:_episode2Index(episodeId)

	return self._dayItemList[index]
end

function V2a5_WarmUpLeftView:_setActive_curEpisode(isActive)
	self:_setActiveByEpisode(self:_episodeId(), isActive)
end

function V2a5_WarmUpLeftView:_setActiveByEpisode(episodeId, isActive)
	if self._lastEpisodeId then
		local item = self:_getItem(self._lastEpisodeId)

		item:setActive(false)
	end

	self._lastEpisodeId = episodeId

	self:_getItem(episodeId):setActive(isActive)
end

function V2a5_WarmUpLeftView:_onDragBegin()
	self:_setActive_guide(false)
end

function V2a5_WarmUpLeftView:_onDragEnd()
	if self:_checkIsDone() then
		return
	end

	if self._drag:isSwipeLT() or self._drag:isSwipeRB() then
		self:_saveState(States.SwipeDone)
		self:_playAnimAfterSwipe()
		self.viewContainer:setLocalIsPlayCurByUser()
	end
end

function V2a5_WarmUpLeftView:_playAnimAfterSwipe()
	self:_playAnimOpen(function()
		self:_saveStateDone(true)
		self.viewContainer:openDesc()
	end)
end

function V2a5_WarmUpLeftView:_playAnimIdle()
	self:_playAnim(UIAnimationName.Idle)
end

function V2a5_WarmUpLeftView:_playAnimOpen(cb, cbObj)
	self:_setActive_curEpisode(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tangren_scissors_cut_25251415)
	self:_playAnim(UIAnimationName.Open, cb, cbObj)
end

function V2a5_WarmUpLeftView:_playAnimOpend()
	self:_setActive_curEpisode(true)
	self:_playAnim("finishidle")
end

function V2a5_WarmUpLeftView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V2a5_WarmUpLeftView:_onShowDay()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_dog_page_25001215)
end

return V2a5_WarmUpLeftView
