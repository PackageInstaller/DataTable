-- chunkname: @modules/logic/sp01/warmup/view/V2a9_WarmUpLeftView.lua

module("modules.logic.sp01.warmup.view.V2a9_WarmUpLeftView", package.seeall)

local V2a9_WarmUpLeftView = class("V2a9_WarmUpLeftView", BaseView)

function V2a9_WarmUpLeftView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_WarmUpLeftView:addEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function V2a9_WarmUpLeftView:removeEvents()
	self._itemClick:RemoveClickListener()
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local States = {
	Clicked = 1
}
local kCount = 5

function V2a9_WarmUpLeftView:ctor()
	self._draggedState = kFirstLocked
end

function V2a9_WarmUpLeftView:_editableInitView()
	self._middleGo = gohelper.findChild(self.viewGO, "Middle")
	self._openGo = gohelper.findChild(self._middleGo, "opened_effect")
	self._unopenGo = gohelper.findChild(self._middleGo, "turnon_effect")
	self._godrag = gohelper.findChild(self._unopenGo, "drag")
	self._guideGo = gohelper.findChild(self._unopenGo, "guide")
	self._simagepic = gohelper.findChildSingleImage(self._middleGo, "#simage_pic")
	self._animatorPlayer = csAnimatorPlayer.Get(self._middleGo)
	self._animtor = self._animatorPlayer.animator
	self._animEvent = gohelper.onceAddComponent(self._middleGo, gohelper.Type_AnimationEventWrap)
	self._itemClick = gohelper.getClickWithAudio(self._godrag, AudioEnum.UI.Play_UI_Universal_Click)

	self:_setActive_drag(true)
end

function V2a9_WarmUpLeftView:onOpen()
	return
end

function V2a9_WarmUpLeftView:onDataUpdateFirst()
	if isDebugBuild then
		assert(self.viewContainer:getEpisodeCount() <= kCount, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	local isDone = self:_checkIsDone()

	if isDone then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end
end

function V2a9_WarmUpLeftView:onDataUpdate()
	self:_refresh()
end

function V2a9_WarmUpLeftView:onSwitchEpisode()
	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end

	self:_refresh()
end

function V2a9_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V2a9_WarmUpLeftView:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V2a9_WarmUpLeftView:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function V2a9_WarmUpLeftView:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function V2a9_WarmUpLeftView:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function V2a9_WarmUpLeftView:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function V2a9_WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
end

function V2a9_WarmUpLeftView:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function V2a9_WarmUpLeftView:_refresh()
	local isDone = self:_checkIsDone()
	local resUrl = self.viewContainer:getImgResUrl(self:_episode2Index())

	self._simagepic:LoadImage(resUrl)

	if isDone then
		self:_setActive_guide(false)
		self:_setActive_drag(false)
		self:_playAnimOpend()
	else
		local state = self:_getState()

		if state == 0 then
			self:_setActive_guide(self._draggedState <= kFirstLocked)
			self:_setActive_drag(true)
			self:_playAnimIdle()
		elseif States.Clicked == state then
			self:_setActive_guide(false)
			self:_setActive_drag(false)
			self:_playAnimOpend()
			self:_playAnimAfterClicked()
		else
			logError("[V2a9_WarmUpLeftView] invalid state: " .. tostring(state))
		end
	end
end

function V2a9_WarmUpLeftView:onClose()
	self._animEvent:RemoveAllEventListener()
end

function V2a9_WarmUpLeftView:onDestroyView()
	return
end

function V2a9_WarmUpLeftView:_playAnimIdle(cb, cbObj)
	self:_playAnim(UIAnimationName.Unopen, cb, cbObj)
end

function V2a9_WarmUpLeftView:_playAnimOpend(cb, cbObj)
	self:_playAnim(UIAnimationName.Open, cb, cbObj)
end

function V2a9_WarmUpLeftView:_playAnimClick(cb, cbObj)
	self:_playAnim(UIAnimationName.Click, cb, cbObj)
end

function V2a9_WarmUpLeftView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V2a9_WarmUpLeftView:_onItemClick()
	self:_setActive_drag(false)
	self:_saveState(States.Clicked)
	self:_playAnimAfterClicked()
	self.viewContainer:setLocalIsPlayCurByUser()
end

local kBlock_Click = "V2a9_WarmUpLeftView:kBlock_Click"
local kTimeout = 9.99

function V2a9_WarmUpLeftView:_playAnimAfterClicked()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)
	self.viewContainer:addNeedWaitCount()
	AudioMgr.instance:trigger(AudioEnum2_9.WarmUp.play_ui_cikexia_screen_shine)
	self:_playAnimClick(function()
		UIBlockHelper.instance:endBlock(kBlock_Click)
		UIBlockMgrExtend.setNeedCircleMv(true)
		self:_saveStateDone(true)
	end)
	self.viewContainer:openDesc()
end

function V2a9_WarmUpLeftView:_play_ui_fuleyuan_yure_open()
	return
end

function V2a9_WarmUpLeftView:_play_ui_fuleyuan_yure_paper()
	return
end

function V2a9_WarmUpLeftView:_play_ui_fuleyuan_yure_whoosh()
	return
end

return V2a9_WarmUpLeftView
