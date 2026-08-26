-- chunkname: @modules/logic/warmup/v3a9/V3a9_WarmUpLeftView.lua

module("modules.logic.warmup.v3a9.V3a9_WarmUpLeftView", package.seeall)

local V3a9_WarmUpLeftView = class("V3a9_WarmUpLeftView", BaseView)

function V3a9_WarmUpLeftView:onInitView()
	self._goDay0 = gohelper.findChild(self.viewGO, "Middle/#go_Day0")
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

function V3a9_WarmUpLeftView:addEvents()
	self._click:AddClickListener(self._onClick, self)
end

function V3a9_WarmUpLeftView:removeEvents()
	self._click:RemoveClickListener()
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local States = {
	SwipeDone = 1
}
local kCount = 5

function V3a9_WarmUpLeftView:ctor()
	self._draggedState = kFirstLocked
	self._dragEnabled = false
	self._needWaitCount = 0
	self._drag = UIDragListenerHelper.New()
end

function V3a9_WarmUpLeftView:_editableInitView()
	self._middleGo = gohelper.findChild(self.viewGO, "Middle")
	self._openGo = gohelper.findChild(self._middleGo, "Cabinet/Open")
	self._unopenGo = gohelper.findChild(self._middleGo, "Cabinet/unOpen")
	self._godrag = gohelper.findChild(self._middleGo, "Click")
	self._guideGo = gohelper.findChild(self._gotips, "hand")

	self._drag:create(self._godrag)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)

	self._bgClickAudio1 = gohelper.addUIClickAudio(self._godrag, AudioEnum.Talent.play_ui_resonate_close)
	self._dayItemList = self:getUserDataTb_()

	for i = 0, 5 do
		local go = self["_goDay" .. i]
		local item = {
			go = go,
			animPlayer = csAnimatorPlayer.Get(go)
		}

		item.animator = item.animPlayer.animator
		self._dayItemList[i] = item

		gohelper.setActive(go, true)
	end

	self._click = gohelper.getClick(self._godrag)
end

function V3a9_WarmUpLeftView:onOpen()
	return
end

function V3a9_WarmUpLeftView:_onClick()
	self:_playAnimAfterSwipe()
end

function V3a9_WarmUpLeftView:onDataUpdateFirst()
	if isDebugBuild then
		assert(self.viewContainer:getEpisodeCount() <= kCount, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	local isDone = self:_checkIsDone()

	if isDone then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end
end

function V3a9_WarmUpLeftView:onDataUpdate()
	self:_refresh()
end

function V3a9_WarmUpLeftView:onSwitchEpisode()
	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end

	self:_refresh()
end

function V3a9_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V3a9_WarmUpLeftView:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V3a9_WarmUpLeftView:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function V3a9_WarmUpLeftView:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function V3a9_WarmUpLeftView:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function V3a9_WarmUpLeftView:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function V3a9_WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
	gohelper.setActive(self._gotips, isActive)
end

function V3a9_WarmUpLeftView:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function V3a9_WarmUpLeftView:_refresh()
	local isDone = self:_checkIsDone()
	local index = self:_episode2Index()

	if isDone then
		self:_setActive_guide(false)
		self:_setActive_drag(false)
		self:_playAnimOpened(index - 1)
		self:_playAnimIdle(index)
		self:_setActive_dayGo(index)
	else
		local state = self:_getState()

		if state == 0 then
			self:_setActive_guide(self._draggedState <= kFirstLocked)
			self:_setActive_drag(true)
			self:_setActive_dayGo(index - 1)
			self:_playAnimIdle(index)
			self:_playAnimIdle(index - 1)
		elseif States.SwipeDone == state then
			self:_setActive_guide(false)
			self:_setActive_drag(false)
			self:_playAnimAfterSwiped()
		else
			logError("[V3a9_WarmUpLeftView] invalid state: " .. tostring(state))
			self:_setActive_dayGo(nil)
		end
	end
end

function V3a9_WarmUpLeftView:onClose()
	GameUtil.onDestroyViewMember(self, "_drag")
end

function V3a9_WarmUpLeftView:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
end

function V3a9_WarmUpLeftView:_setActive_dayGo(index)
	for i = 0, 5 do
		local item = self._dayItemList[i]

		gohelper.setActive(item.go, index and index <= i or false)
	end
end

function V3a9_WarmUpLeftView:_setActive_dayGoCur()
	self:_setActive_dayGo(self:_episode2Index())
end

function V3a9_WarmUpLeftView:_onDragBegin()
	self:_setActive_guide(false)
end

function V3a9_WarmUpLeftView:_onDragEnd()
	if self:_checkIsDone() then
		return
	end

	if self._drag:isSwipeRight() then
		self:_playAnimAfterSwipe()
	end
end

function V3a9_WarmUpLeftView:_playAnimIdle(index, cb, cbObj)
	self:_playAnim(index, "normal", cb, cbObj)
end

function V3a9_WarmUpLeftView:_playAnimOpened(index, cb, cbObj)
	self:_playAnim(index, "closed", cb, cbObj)
end

function V3a9_WarmUpLeftView:_playAnimOpen(index, cb, cbObj)
	self:_playAnim(index, "closing", cb, cbObj)
end

function V3a9_WarmUpLeftView:_playAnim(index, name, cb, cbObj)
	index = GameUtil.clamp(index, 0, 5)

	local item = self._dayItemList[index]

	if not item then
		logError("[V3a9_WarmUpLeftView] invalid index: " .. tostring(index))

		return
	end

	if item.go.activeSelf then
		item.animator.enabled = true

		item.animPlayer:Play(name, cb or function()
			return
		end, cbObj)
	elseif cb then
		cb(cbObj)
	end
end

function V3a9_WarmUpLeftView:_directPlayAnim(index, name, ...)
	index = GameUtil.clamp(index, 0, 5)

	local item = self._dayItemList[index]

	if not item then
		logError("[V3a9_WarmUpLeftView] invalid index: " .. tostring(index))

		return
	end

	item.animator.enabled = true

	item.animator:Play(name, ...)
end

function V3a9_WarmUpLeftView:_playAnimAfterSwipe()
	self:_setActive_drag(false)
	self:_saveState(States.SwipeDone)
	self:_playAnimAfterSwiped()
	self.viewContainer:setLocalIsPlayCurByUser()
end

local kBlock_Click = "V3a9_WarmUpLeftView:kBlock_Click"
local kTimeout = 9.99

function V3a9_WarmUpLeftView:_playAnimAfterSwiped()
	local index = self:_episode2Index()

	self:_setActive_dayGo(index - 1)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)
	self.viewContainer:addNeedWaitCount()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_chongran_yure_bazaar_papers)
	self:_playAnimOpen(index - 1, function()
		UIBlockHelper.instance:endBlock(kBlock_Click)
		UIBlockMgrExtend.setNeedCircleMv(true)
		self:_saveStateDone(true)
	end)
	self.viewContainer:openDesc()
end

function V3a9_WarmUpLeftView:_play_ui_shengyan_item_appeared()
	return
end

function V3a9_WarmUpLeftView:_play_ui_shengyan_unsheathe_dagger()
	return
end

function V3a9_WarmUpLeftView:_play_ui_fuleyuan_yure_whoosh()
	return
end

return V3a9_WarmUpLeftView
