-- chunkname: @modules/logic/versionactivity3_1/warmup/view/V3a1_WarmUpLeftView.lua

module("modules.logic.versionactivity3_1.warmup.view.V3a1_WarmUpLeftView", package.seeall)

local V3a1_WarmUpLeftView = class("V3a1_WarmUpLeftView", BaseView)

function V3a1_WarmUpLeftView:onInitView()
	self._simagePaper = gohelper.findChildSingleImage(self.viewGO, "Middle/Map/#simage_Paper")
	self._simageMapMask = gohelper.findChildSingleImage(self.viewGO, "Middle/Map/#simage_MapMask")
	self._simageMap1 = gohelper.findChildSingleImage(self.viewGO, "Middle/Map/#simage_MapMask/Map/#simage_Map1")
	self._simageMap2 = gohelper.findChildSingleImage(self.viewGO, "Middle/Map/#simage_MapMask/Map/#simage_Map2")
	self._goPath1 = gohelper.findChild(self.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path1")
	self._goPath2 = gohelper.findChild(self.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path2")
	self._goPath3 = gohelper.findChild(self.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path3")
	self._goPath4 = gohelper.findChild(self.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path4")
	self._goPath5 = gohelper.findChild(self.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path5")
	self._simageShadow = gohelper.findChildSingleImage(self.viewGO, "Middle/Map/#simage_Shadow")
	self._simagepicsmall = gohelper.findChildSingleImage(self.viewGO, "Middle/Map/#simage_pic_small")
	self._gopoints = gohelper.findChild(self.viewGO, "Middle/Map/#go_points")
	self._simagebgclick = gohelper.findChildSingleImage(self.viewGO, "Middle/#simage_bg_click")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "Middle/#simage_pic")
	self._gotips = gohelper.findChildSingleImage(self.viewGO, "Middle/#go_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_WarmUpLeftView:addEvents()
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function V3a1_WarmUpLeftView:removeEvents()
	self._itemClick:RemoveClickListener()
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local States = {
	Clicked = 1
}
local kCount = 5

function V3a1_WarmUpLeftView:ctor()
	self._draggedState = kFirstLocked
end

function V3a1_WarmUpLeftView:_editableInitView()
	self._middleGo = gohelper.findChild(self.viewGO, "Middle")
	self._godrag = self._simagepicsmall.gameObject
	self._guideGo = gohelper.findChild(self._godrag, "image_Drag")
	self._animatorPlayer = csAnimatorPlayer.Get(self._middleGo)
	self._animtor = self._animatorPlayer.animator
	self._animEvent = gohelper.onceAddComponent(self._middleGo, gohelper.Type_AnimationEventWrap)
	self._itemClick = gohelper.getClickWithAudio(self._godrag, AudioEnum.UI.Play_UI_Universal_Click)

	self:_setActive_drag(true)

	self._gopointsTrans = self._gopoints.gameObject.transform

	local n = self._gopointsTrans.childCount

	self._posTranList = self:getUserDataTb_()

	for i = 0, n - 1 do
		table.insert(self._posTranList, self._gopointsTrans:GetChild(i))
	end

	self._godragTrans = self._godrag.transform
end

function V3a1_WarmUpLeftView:onOpen()
	return
end

function V3a1_WarmUpLeftView:onDataUpdateFirst()
	if isDebugBuild then
		assert(self.viewContainer:getEpisodeCount() <= kCount, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	local isDone = self:_checkIsDone()

	if isDone then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end
end

function V3a1_WarmUpLeftView:onDataUpdate()
	self:_refresh()
end

function V3a1_WarmUpLeftView:onSwitchEpisode()
	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end

	self:_refresh()
end

function V3a1_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V3a1_WarmUpLeftView:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V3a1_WarmUpLeftView:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function V3a1_WarmUpLeftView:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function V3a1_WarmUpLeftView:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function V3a1_WarmUpLeftView:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function V3a1_WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
	gohelper.setActive(self._gotips, isActive)
end

function V3a1_WarmUpLeftView:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function V3a1_WarmUpLeftView:_refresh()
	local isDone = self:_checkIsDone()
	local index = self:_episode2Index()
	local resUrl = self.viewContainer:getImgResUrl(index)

	self._simagepicsmall:LoadImage(resUrl)
	self._simagepic:LoadImage(resUrl)
	self:_dock(index)

	if isDone then
		self:_setActive_guide(false)
		self:_setActive_drag(false)
		self:_playAnimOpened()
	else
		local state = self:_getState()

		if state == 0 then
			self:_setActive_guide(self._draggedState <= kFirstLocked)
			self:_setActive_drag(true)
			self:_playAnimIdle()
		elseif States.Clicked == state then
			self:_setActive_guide(false)
			self:_setActive_drag(false)
			self:_playAnimOpened()
			self:_playAnimAfterClicked()
		else
			logError("[V3a1_WarmUpLeftView] invalid state: " .. tostring(state))
		end
	end
end

function V3a1_WarmUpLeftView:onClose()
	self._animEvent:RemoveAllEventListener()
end

function V3a1_WarmUpLeftView:onDestroyView()
	return
end

function V3a1_WarmUpLeftView:_playAnimIdle(cb, cbObj)
	self:_playAnim("map", cb, cbObj)
end

function V3a1_WarmUpLeftView:_playAnimOpened(cb, cbObj)
	self:_playAnim("pic", cb, cbObj)
end

function V3a1_WarmUpLeftView:_playAnimClick(cb, cbObj)
	self:_playAnim(UIAnimationName.Click, cb, cbObj)
end

function V3a1_WarmUpLeftView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a1_WarmUpLeftView:_onItemClick()
	self:_setActive_drag(false)
	self:_saveState(States.Clicked)
	self:_playAnimAfterClicked()
	self.viewContainer:setLocalIsPlayCurByUser()
end

local kBlock_Click = "V3a1_WarmUpLeftView:kBlock_Click"
local kTimeout = 9.99

function V3a1_WarmUpLeftView:_playAnimAfterClicked()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)
	self.viewContainer:addNeedWaitCount()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
	self:_playAnimClick(function()
		UIBlockHelper.instance:endBlock(kBlock_Click)
		UIBlockMgrExtend.setNeedCircleMv(true)
		self:_saveStateDone(true)
	end)
	self.viewContainer:openDesc()
end

function V3a1_WarmUpLeftView:_play_ui_fuleyuan_yure_open()
	return
end

function V3a1_WarmUpLeftView:_play_ui_fuleyuan_yure_paper()
	return
end

function V3a1_WarmUpLeftView:_play_ui_fuleyuan_yure_whoosh()
	return
end

function V3a1_WarmUpLeftView:_dock(index)
	local p = self._posTranList[index]

	self._godragTrans:SetParent(p)
	transformhelper.setLocalPos(self._godragTrans, 0, 0, 0)
end

return V3a1_WarmUpLeftView
