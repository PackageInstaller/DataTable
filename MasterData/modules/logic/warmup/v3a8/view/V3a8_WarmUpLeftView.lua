-- chunkname: @modules/logic/warmup/v3a8/view/V3a8_WarmUpLeftView.lua

module("modules.logic.warmup.v3a8.view.V3a8_WarmUpLeftView", package.seeall)

local V3a8_WarmUpLeftView = class("V3a8_WarmUpLeftView", BaseView)

function V3a8_WarmUpLeftView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_WarmUpLeftView:addEvents()
	return
end

function V3a8_WarmUpLeftView:removeEvents()
	return
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local States = {
	SwipeDone = 1
}
local kCount = 5

function V3a8_WarmUpLeftView:ctor()
	self._draggedState = kFirstLocked
	self._dragEnabled = false
	self._needWaitCount = 0
	self._opItemList = {}
end

function V3a8_WarmUpLeftView:_editableInitView()
	self._leftGo = gohelper.findChild(self.viewGO, "Left")
	self._ansGo = gohelper.findChild(self._leftGo, "Answer")
	self._simgBack = gohelper.findChildSingleImage(self._leftGo, "Display_back")
	self._txttitle = gohelper.findChildText(self._ansGo, "txtbg/#txt_title")
	self._golist = gohelper.findChild(self._ansGo, "Scroll_list/#go_list")
	self._golist1 = gohelper.findChild(self._ansGo, "Scroll_list/#go_list_1")
	self._golist2 = gohelper.findChild(self._ansGo, "Scroll_list/#go_list_2")
	self._animatorPlayer = csAnimatorPlayer.Get(self._leftGo)
	self._animtor = self._animatorPlayer.animator
	self._ansAnimator = self._ansGo:GetComponent(gohelper.Type_Animator)
	self._dayItemList = self:getUserDataTb_()

	for i = 1, 5 do
		local go = gohelper.findChild(self._leftGo, "Display_front/#go_day0" .. i)

		gohelper.setActive(go, false)

		self._dayItemList[i] = go
	end

	self._opItemList = {
		self:_create_V3a8_WarmUpOpItem(self._golist, 1),
		self:_create_V3a8_WarmUpOpItem(self._golist1, 2),
		self:_create_V3a8_WarmUpOpItem(self._golist2, 3)
	}
	self._txttitle.text = ""
end

function V3a8_WarmUpLeftView:onOpen()
	return
end

function V3a8_WarmUpLeftView:onClose()
	return
end

function V3a8_WarmUpLeftView:onDestroyView()
	GameUtil.onDestroyViewMember_SImage(self, "_simgBack")
	GameUtil.onDestroyViewMemberList(self, "_opItemList")
end

function V3a8_WarmUpLeftView:onDataUpdateFirst()
	if isDebugBuild then
		assert(self.viewContainer:getEpisodeCount() <= kCount, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	local isDone = self:_checkIsDone()

	if isDone then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end

	self:_playAnsAnimOpen()
end

function V3a8_WarmUpLeftView:onDataUpdate()
	self:_refresh()
end

function V3a8_WarmUpLeftView:onSwitchEpisode()
	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end

	self:_refresh()
end

function V3a8_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V3a8_WarmUpLeftView:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V3a8_WarmUpLeftView:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function V3a8_WarmUpLeftView:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function V3a8_WarmUpLeftView:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function V3a8_WarmUpLeftView:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function V3a8_WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
	gohelper.setActive(self._gotips, isActive)
end

function V3a8_WarmUpLeftView:_setActive_guide(isActive)
	gohelper.setActive(self._guideGo, isActive)
end

function V3a8_WarmUpLeftView:_refresh()
	local isDone = self:_checkIsDone()
	local index = self:_episode2Index()
	local resUrl = self.viewContainer:getImgResUrl(index)

	self._simgBack:LoadImage(resUrl)
	self:_refreshIssue()

	if isDone then
		self:_playAnimOpened()
		self:_setActive_dayGo(index)
	else
		local state = self:_getState()

		if state == 0 then
			self:_playAnimIdle()
			self:_setActive_dayGo(nil)
		elseif States.SwipeDone == state then
			self:_playAnimAfterSwiped()
		else
			logError("[V3a8_WarmUpLeftView] invalid state: " .. tostring(state))
			self:_setActive_dayGo(nil)
		end
	end
end

function V3a8_WarmUpLeftView:_setActive_dayGo(index)
	for i, go in ipairs(self._dayItemList) do
		gohelper.setActive(go, index == i)
	end
end

function V3a8_WarmUpLeftView:_setActive_dayGoCur()
	self:_setActive_dayGo(self:_episode2Index())
end

function V3a8_WarmUpLeftView:_onDragBegin()
	self:_setActive_guide(false)
end

function V3a8_WarmUpLeftView:_onDragEnd()
	if self:_checkIsDone() then
		return
	end

	if self._drag:isSwipeLeft() then
		self:_playAnimAfterSwipe()
	end
end

function V3a8_WarmUpLeftView:_playAnimIdle(cb, cbObj)
	self:_playAnim("none", cb, cbObj)
end

function V3a8_WarmUpLeftView:_playAnimOpened(cb, cbObj)
	self:_playAnim("idle", cb, cbObj)
end

function V3a8_WarmUpLeftView:_playAnimOpen(cb, cbObj)
	self:_playAnim("flip", cb, cbObj)
end

function V3a8_WarmUpLeftView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a8_WarmUpLeftView:_playAnimAfterSwipe()
	self:_saveState(States.SwipeDone)
	self:_playAnimAfterSwiped()
end

local kBlock_Click = "V3a8_WarmUpLeftView:kBlock_Click"
local kTimeout = 9.99

function V3a8_WarmUpLeftView:_playAnimAfterSwiped()
	if self.viewContainer:openDesc() then
		return
	end

	self:_setActive_dayGoCur()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)
	self.viewContainer:addNeedWaitCount()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
	self:_playAnimOpen(function()
		UIBlockHelper.instance:endBlock(kBlock_Click)
		UIBlockMgrExtend.setNeedCircleMv(true)
		self:_saveStateDone(true)
	end)
end

function V3a8_WarmUpLeftView:_play_ui_shengyan_item_appeared()
	return
end

function V3a8_WarmUpLeftView:_play_ui_shengyan_unsheathe_dagger()
	return
end

function V3a8_WarmUpLeftView:_play_ui_fuleyuan_yure_whoosh()
	return
end

function V3a8_WarmUpLeftView:_playAnsAnim(name, ...)
	self._ansAnimator:Play(name, ...)
end

function V3a8_WarmUpLeftView:_playAnsAnimOpen()
	self:_playAnsAnim(UIAnimationName.Open, 0, 0)
end

function V3a8_WarmUpLeftView:_playAnsAnimIdleHide()
	self:_playAnsAnim("idle1", 0, 1)
end

function V3a8_WarmUpLeftView:_playAnsAnimIdleOpened()
	self:_playAnsAnim("idle2", 0, 1)
end

function V3a8_WarmUpLeftView:_create_V3a8_WarmUpOpItem(srcGo, index)
	local item = V3a8_WarmUpOpItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:init(srcGo)
	item:setIndex(index)

	return item
end

function V3a8_WarmUpLeftView:_getPlayCO()
	local res = self.viewContainer:getPlayCO(self:_episodeId())

	if isDebugBuild then
		assert(res, "invalid config json_v3a8_warmup_play actId: " .. self.viewContainer:actId())
	end

	return res
end

function V3a8_WarmUpLeftView:_getOpList(playCO)
	local list = {}
	local CO = playCO or self:_getPlayCO()

	for i = 1, 1999 do
		local mem = "op" .. tostring(i)
		local opStr = CO[mem]

		if not opStr then
			break
		end

		table.insert(list, opStr or "")
	end

	return list
end

function V3a8_WarmUpLeftView:_refreshIssue()
	local playCO = self:_getPlayCO()
	local optionList = self:_getOpList(playCO)

	if isDebugBuild then
		assert(#self._opItemList == #optionList)
	end

	for i, opStr in ipairs(optionList) do
		local item = self._opItemList[i]

		item:onUpdateMO(opStr)
		item:setActive(true)
	end

	self._txttitle.text = playCO.issue
end

return V3a8_WarmUpLeftView
