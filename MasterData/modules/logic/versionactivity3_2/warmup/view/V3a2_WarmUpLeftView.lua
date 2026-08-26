-- chunkname: @modules/logic/versionactivity3_2/warmup/view/V3a2_WarmUpLeftView.lua

module("modules.logic.versionactivity3_2.warmup.view.V3a2_WarmUpLeftView", package.seeall)

local V3a2_WarmUpLeftView = class("V3a2_WarmUpLeftView", BaseView)

function V3a2_WarmUpLeftView:onInitView()
	self._goDay1 = gohelper.findChild(self.viewGO, "Middle/#go_Day1")
	self._goDay2 = gohelper.findChild(self.viewGO, "Middle/#go_Day2")
	self._goDay3 = gohelper.findChild(self.viewGO, "Middle/#go_Day3")
	self._goDay4 = gohelper.findChild(self.viewGO, "Middle/#go_Day4")
	self._goDay5 = gohelper.findChild(self.viewGO, "Middle/#go_Day5")
	self._gotips = gohelper.findChild(self.viewGO, "Middle/#go_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_WarmUpLeftView:addEvents()
	return
end

function V3a2_WarmUpLeftView:removeEvents()
	return
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local States = {
	SwipeDone = 1
}
local kCount = 5

function V3a2_WarmUpLeftView:ctor()
	self._draggedState = kFirstLocked
	self._dragEnabled = false
	self._needWaitCount = 0
	self._drag = UIDragListenerHelper.New()
end

function V3a2_WarmUpLeftView:_editableInitView()
	self._middleGo = gohelper.findChild(self.viewGO, "Middle")
	self._godrag = gohelper.findChild(self._middleGo, "Click")
	self._guideGo = self._gotips
	self._animatorPlayer = csAnimatorPlayer.Get(self._middleGo)
	self._animtor = self._animatorPlayer.animator
	self._animEvent = gohelper.onceAddComponent(self._middleGo, gohelper.Type_AnimationEventWrap)

	self._drag:create(self._godrag)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)

	self._dayItemList = self:getUserDataTb_()

	for i = 1, 5 do
		local go = self["_goDay" .. i]

		gohelper.setActive(go, false)

		self._dayItemList[i] = go
	end
end

function V3a2_WarmUpLeftView:onOpen()
	self._animEvent:AddEventListener("play_ui_shengyan_item_appeared", self._play_ui_shengyan_item_appeared, self)
end

function V3a2_WarmUpLeftView:onDataUpdateFirst()
	if isDebugBuild then
		assert(self.viewContainer:getEpisodeCount() <= kCount, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	local isDone = self:_checkIsDone()

	if isDone then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end
end

function V3a2_WarmUpLeftView:onDataUpdate()
	self:_refresh()
end

function V3a2_WarmUpLeftView:onSwitchEpisode()
	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end

	self:_refresh()
end

function V3a2_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V3a2_WarmUpLeftView:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V3a2_WarmUpLeftView:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function V3a2_WarmUpLeftView:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function V3a2_WarmUpLeftView:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function V3a2_WarmUpLeftView:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function V3a2_WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
end

function V3a2_WarmUpLeftView:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function V3a2_WarmUpLeftView:_refresh()
	local isDone = self:_checkIsDone()
	local index = self:_episode2Index()

	if isDone then
		self:_setActive_guide(false)
		self:_setActive_drag(false)
		self:_playAnimOpened()
		self:_setActive_dayGo(index)
	else
		local state = self:_getState()

		if state == 0 then
			self:_setActive_guide(self._draggedState <= kFirstLocked)
			self:_setActive_drag(true)
			self:_playAnimIdle()
			self:_setActive_dayGo(nil)
		elseif States.SwipeDone == state then
			self:_setActive_guide(false)
			self:_setActive_drag(false)
			self:_playAnimAfterSwiped()
		else
			logError("[V3a2_WarmUpLeftView] invalid state: " .. tostring(state))
			self:_setActive_dayGo(nil)
		end
	end
end

function V3a2_WarmUpLeftView:onClose()
	GameUtil.onDestroyViewMember(self, "_drag")
	self._animEvent:RemoveAllEventListener()
end

function V3a2_WarmUpLeftView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
end

function V3a2_WarmUpLeftView:_setActive_dayGo(index)
	for i, go in ipairs(self._dayItemList) do
		gohelper.setActive(go, index == i)
	end
end

function V3a2_WarmUpLeftView:_setActive_dayGoCur()
	self:_setActive_dayGo(self:_episode2Index())
end

function V3a2_WarmUpLeftView:_onDragBegin()
	self:_setActive_guide(false)
end

function V3a2_WarmUpLeftView:_onDragEnd()
	if self:_checkIsDone() then
		return
	end

	if self._drag:isSwipeDown() then
		self:_playAnimAfterSwipe()
	end
end

function V3a2_WarmUpLeftView:_playAnimIdle(cb, cbObj)
	self:_playAnim("idle_close", cb, cbObj)
end

function V3a2_WarmUpLeftView:_playAnimOpened(cb, cbObj)
	self:_playAnim("idle_open", cb, cbObj)
end

function V3a2_WarmUpLeftView:_playAnimOpen(cb, cbObj)
	self:_playAnim(UIAnimationName.Open, cb, cbObj)
end

function V3a2_WarmUpLeftView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a2_WarmUpLeftView:_playAnimAfterSwipe()
	self:_setActive_drag(false)
	self:_saveState(States.SwipeDone)
	self:_playAnimAfterSwiped()
	self.viewContainer:setLocalIsPlayCurByUser()
end

local kBlock_Click = "V3a2_WarmUpLeftView:kBlock_Click"
local kTimeout = 9.99

function V3a2_WarmUpLeftView:_playAnimAfterSwiped()
	self:_setActive_dayGoCur()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)
	self.viewContainer:addNeedWaitCount()
	AudioMgr.instance:trigger(AudioEnum3_2.WarmUp.play_ui_shengyan_pull_drawer)
	self:_playAnimOpen(function()
		UIBlockHelper.instance:endBlock(kBlock_Click)
		UIBlockMgrExtend.setNeedCircleMv(true)
		self:_saveStateDone(true)
	end)
	self.viewContainer:openDesc()
end

function V3a2_WarmUpLeftView:_play_ui_shengyan_item_appeared()
	if self:_episode2Index() == 1 then
		AudioMgr.instance:trigger(AudioEnum3_2.WarmUp.play_ui_shengyan_unsheathe_dagger)
	else
		AudioMgr.instance:trigger(AudioEnum3_2.WarmUp.play_ui_shengyan_item_appeared)
	end
end

function V3a2_WarmUpLeftView:_play_ui_shengyan_unsheathe_dagger()
	return
end

function V3a2_WarmUpLeftView:_play_ui_fuleyuan_yure_whoosh()
	return
end

return V3a2_WarmUpLeftView
