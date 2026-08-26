-- chunkname: @modules/logic/warmup/view/WarmUp.lua

module("modules.logic.warmup.view.WarmUp", package.seeall)

local WarmUp = class("WarmUp", BaseView)

function WarmUp:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#Simage_Title/LimitTime/#txt_LimitTime")
	self._scrollTaskTabList = gohelper.findChildScrollRect(self.viewGO, "opened/open/image_panelbg_right/Right/TaskTab/#scroll_TaskTabList")
	self._goradiotaskitem = gohelper.findChild(self.viewGO, "opened/open/image_panelbg_right/Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	self._goTitle = gohelper.findChild(self.viewGO, "opened/open/image_panelbg_right/Right/TaskPanel/#go_Title")
	self._txtTaskTitle = gohelper.findChildText(self.viewGO, "opened/open/image_panelbg_right/Right/TaskPanel/#go_Title/#txt_TaskTitle")
	self._goWrongChannel = gohelper.findChild(self.viewGO, "opened/open/image_panelbg_right/Right/TaskPanel/#go_WrongChannel")
	self._scrollTaskDesc = gohelper.findChildScrollRect(self.viewGO, "opened/open/image_panelbg_right/Right/TaskPanel/#scroll_TaskDesc")
	self._txtTaskContent = gohelper.findChildText(self.viewGO, "opened/open/image_panelbg_right/Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "opened/open/image_panelbg_left/RawardPanel/#scroll_Reward")
	self._gorewarditem = gohelper.findChild(self.viewGO, "opened/open/image_panelbg_left/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._btngetreward = gohelper.findChildButtonWithAudio(self.viewGO, "opened/open/image_panelbg_left/RawardPanel/#btn_getreward")
	self._gotips = gohelper.findChild(self.viewGO, "unopen/Cabinet/unOpen/node_panel/node_book/#go_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WarmUp:addEvents()
	self._btngetreward:AddClickListener(self._btngetrewardOnClick, self)
	self._click:AddClickListener(self._onClick, self)
	self._clickLeft:AddClickListener(self._onClickLeft, self)
	self._clickRight:AddClickListener(self._onClickRight, self)
end

function WarmUp:removeEvents()
	self._btngetreward:RemoveClickListener()
	self._click:RemoveClickListener()
	self._clickLeft:RemoveClickListener()
	self._clickRight:RemoveClickListener()
end

local Vector4 = _G.Vector4
local splitToNumber = string.splitToNumber
local split = string.split
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local kAnimEvt = "onSwitchTaskPanel"
local kTimeout = 9.99
local kFirstLocked = -1
local kFirstUnlocked = 0
local States = {
	SwipeDone = 1
}

function WarmUp:_btngetrewardOnClick()
	local _, _, _, canGetReward = self.viewContainer:getRLOCCur()

	if not canGetReward then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(true)
	self.viewContainer:sendFinishAct125EpisodeRequest()
end

function WarmUp:_onClickLeft()
	local curEpisodeId = self:_episodeId()
	local maxEpisodeCount = self.viewContainer:getEpisodeCount()
	local toEpisodeId = GameUtil.clamp(curEpisodeId - 1, 0, maxEpisodeCount)

	if toEpisodeId >= 1 then
		self:onClickTab(toEpisodeId)
		self:_taskScrollToIndex(toEpisodeId - 2)
	else
		self:_day1ToCover()
	end
end

local kBlock_day1ToCover = "WarmUp:_day1ToCover"

function WarmUp:_day1ToCover()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_day1ToCover, kTimeout, self.viewName)
	self:_setActive_openAndUnopen(false)
	self:_setActive_drag(true)
	self._playAnim(self, "open_to_close", self._onDay1ToCover, self)
end

function WarmUp:_onDay1ToCover()
	local episodeId = self.viewContainer:getFirstRewardEpisode()
	local isRecevied = self.viewContainer:getRLOC(episodeId)

	self.viewContainer:setCurSelectEpisodeIdSlient(episodeId)

	self._lastSelectedIndex = nil

	self:_doSwitchByEpisodeId(episodeId, true)
	self:_setSelectIndex(self:episode2Index(episodeId), true)
	self:_setActive_reddot(not isRecevied)
	self:_setActive_guide(true, true)
	UIBlockHelper.instance:endBlock(kBlock_day1ToCover)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function WarmUp:_onClickRight()
	local curEpisodeId = self:_episodeId()
	local maxEpisodeCount = self.viewContainer:getEpisodeCount()
	local toEpisodeId = GameUtil.clamp(curEpisodeId + 1, 1, maxEpisodeCount)

	self:onClickTab(toEpisodeId)
	self:_taskScrollToIndex(toEpisodeId - 2)
end

function WarmUp:ctor()
	self._draggedState = kFirstLocked
	self._drag = UIDragListenerHelper.New()
end

function WarmUp:_editableInitView()
	local scroll_TaskDescGo = self._scrollTaskDesc.gameObject
	local scroll_TaskDesc_ViewPort = gohelper.findChild(scroll_TaskDescGo, "Viewport")
	local scroll_TaskTabList = self._scrollTaskTabList.gameObject
	local scroll_TaskTabList_Content = gohelper.findChild(scroll_TaskTabList, "Viewport/Content")

	self._openGo = gohelper.findChild(self.viewGO, "opened")
	self._unopenGo = gohelper.findChild(self.viewGO, "unopen")
	self._unopen_go_reddot = gohelper.findChild(self._unopenGo, "Cabinet/unOpen/#go_reddot")
	self._image_jiantou1Go = gohelper.findChild(self._openGo, "image_jiantou1")
	self._image_jiantou2Go = gohelper.findChild(self._openGo, "image_jiantou2")
	self._btngetrewardGo = self._btngetreward.gameObject
	self._txtTaskContentTran = self._txtTaskContent.transform
	self._scroll_TaskDescGo = scroll_TaskDescGo
	self._descScrollRect = scroll_TaskDescGo:GetComponent(gohelper.Type_ScrollRect)
	self._scrollCanvasGroup = gohelper.onceAddComponent(scroll_TaskDescGo, typeof(UnityEngine.CanvasGroup))
	self._taskDescViewportHeight = math.max(0, recthelper.getHeight(scroll_TaskDescGo.transform))
	self._taskDescMask = scroll_TaskDesc_ViewPort:GetComponent(gohelper.Type_RectMask2D)
	self._goTaskContentTran = scroll_TaskTabList_Content.transform
	self._taskScrollViewportWidth = recthelper.getWidth(scroll_TaskTabList.transform)
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animSelf = self._animatorPlayer.animator
	self._animEvent = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)
	self._guideGo = gohelper.findChild(self.viewGO, "img_hand")
	self._animator_guide = self._guideGo:GetComponent(gohelper.Type_Animator)
	self._taskPanelGo = gohelper.findChild(self.viewGO, "opened/open/image_panelbg_right/Right/TaskPanel")
	self._animatorPlayerTaskPanel = csAnimatorPlayer.Get(self._taskPanelGo)
	self._animEventTaskPanel = gohelper.onceAddComponent(self._taskPanelGo, gohelper.Type_AnimationEventWrap)

	self._animEventTaskPanel:AddEventListener(kAnimEvt, self._onSwitchTaskPanel, self)

	self._godrag = gohelper.findChild(self._unopenGo, "Click")

	self._drag:create(self._godrag)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
	self:_resetTaskContentPos()
	self:_setActive_goWrongChannel(false)
	gohelper.setActive(self._gorewarditem, false)
	gohelper.setActive(self._goradiotaskitem, false)
	gohelper.setActive(self._image_jiantou1Go, true)

	self._click = gohelper.getClick(self._godrag)
	self._clickLeft = gohelper.getClick(self._image_jiantou1Go)
	self._clickRight = gohelper.getClick(self._image_jiantou2Go)
	self._txtLimitTime.text = ""
	self._descHeight = 0
	self._rewardCount = 0
	self._itemTabList = {}
	self._rewardItemList = {}
	self._unlockedIndex = 0
end

function WarmUp:onDataUpdateFirst()
	self:_refreshOnce()

	local isDone = self:_checkIsDone()

	if isDone then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end
end

function WarmUp:onDataUpdate()
	self:_refresh()
end

function WarmUp:onSwitchEpisode()
	self._drag:clear()
	self._descScrollRect:StopMovement()
	self:_resetTweenDescPos()
	self:_refresh()
	self.viewContainer:tryTweenDesc()
	self:_refreshAnimState()

	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end
end

function WarmUp:onUpdateActivity()
	self._descScrollRect:StopMovement()
	self:_setTaskContentToEnd()
	self:_refresh()
	self:_refreshAnimState()
end

function WarmUp:onUpdateParam()
	self:_refreshOnce()
	self:_refresh()
end

local kBlock_onOpen = "WarmUp:onOpen"

function WarmUp:onOpen()
	self._lastSelectedIndex = nil

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_onOpen, kTimeout, self.viewName)

	self._bInPlaying = true
	self._afterInAnimCbCbObj = {}

	TaskDispatcher.cancelTask(self._inDone, self)
	TaskDispatcher.runDelay(self._inDone, self, 0.16)
end

function WarmUp:_inDone()
	self._bInPlaying = false

	for _, info in ipairs(self._afterInAnimCbCbObj or {}) do
		local cb, cbObj = info[1], info[2]

		if cb then
			cb(cbObj)
		end
	end

	self._afterInAnimCbCbObj = {}

	UIBlockHelper.instance:endBlock(kBlock_onOpen)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function WarmUp:onClose()
	TaskDispatcher.cancelTask(self._inDone, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function WarmUp:onDestroyView()
	TaskDispatcher.cancelTask(self._inDone, self)
	GameUtil.onDestroyViewMember(self, "_drag")
	self._animEvent:RemoveAllEventListener()
	self._animEventTaskPanel:RemoveAllEventListener()
	GameUtil.onDestroyViewMemberList(self, "_itemTabList")
end

function WarmUp:_refreshOnce()
	local maxEpisodeCount = self.viewContainer:getEpisodeCount()

	for i = 1, maxEpisodeCount do
		local episodeId = i

		if self.viewContainer:isEpisodeReallyOpen(episodeId) then
			self._unlockedIndex = i
		else
			break
		end
	end

	self:_showDeadline()
	self:_refreshTabList()
	self:_autoSelectTab()
	self:_refreshAnimState()
end

function WarmUp:_setActive_reddot(isActive)
	gohelper.setActive(self._unopen_go_reddot, isActive)
end

function WarmUp:_refresh()
	self:_refreshData()
	self:_refreshTabList()
	self:_refreshRewards()
	self:_refreshRightView()
end

function WarmUp:_refreshAnimState(bAutoSwipeDone)
	local isDone = self:_checkIsDone()
	local index = self:_episode2Index()

	self:_refreshArrow(index)

	local _, localIsPlay = self.viewContainer:getRLOCCur()

	if isDone then
		self:_setActive_guide(false)
		self:_setActive_drag(false)
		self:_setActive_openAndUnopen(true)
		self:_playAnimOpened()
	elseif localIsPlay then
		-- block empty
	else
		local state = self:_getState()

		if bAutoSwipeDone or States.SwipeDone == state then
			if not bAutoSwipeDone then
				self:_setActive_guide(false)
			end

			self:_setActive_drag(false)
			self:_setActive_openAndUnopen(true)
			self:_playAnimAfterSwiped(bAutoSwipeDone)
		elseif state == 0 then
			local targetEpisodeId = self.viewContainer:getFirstRewardEpisode()
			local isShowingReceived = index ~= self:_episode2Index(targetEpisodeId)

			self:_setActive_guide(self._draggedState <= kFirstLocked and (isShowingReceived or index == 1))
			self:_setActive_drag(true)
			self:_playAnimIdle()
			self:_setActive_openAndUnopen(isShowingReceived)
		else
			logError("[WarmUp] invalid state: " .. tostring(state))
		end
	end
end

function WarmUp:_setActive_openAndUnopen(isOpen)
	self:_setActive_openGo(isOpen)
	self:_setActive_unopenGo(not isOpen)
end

function WarmUp:_refreshArrow(optIndex)
	optIndex = optIndex or self:_episode2Index() or 0

	local maxEpisodeCount = self.viewContainer:getEpisodeCount()

	gohelper.setActive(self._image_jiantou2Go, optIndex < maxEpisodeCount)
end

function WarmUp:_refreshRightView()
	local isRecevied, localIsPlay, _, canGetReward = self.viewContainer:getRLOCCur()

	gohelper.setActive(self._btngetrewardGo, canGetReward)

	if isRecevied or localIsPlay then
		self:_setActive_goWrongChannel(false)
	elseif not self.viewContainer:checkIsDone() then
		self:_setActive_goWrongChannel(true)
	end

	for _, item in ipairs(self._rewardItemList) do
		item:refresh()
	end
end

function WarmUp:_setActive_goWrongChannel(isBlockDesc)
	gohelper.setActive(self._goWrongChannel, isBlockDesc)
	gohelper.setActive(self._scroll_TaskDescGo, not isBlockDesc)

	if isBlockDesc then
		self:_setMaskPaddingBottom(self._taskDescViewportHeight)
		self:_resetTaskContentPos()
	else
		self:_setMaskPaddingBottom(0)
	end
end

function WarmUp:_refreshData()
	local co = self.viewContainer:getEpisodeConfigCur()

	self.viewContainer:dispatchRedEvent()

	self._txtTaskTitle.text = co.name
	self._txtTaskContent.text = co.text
	self._descHeight = self._txtTaskContent.preferredHeight
end

function WarmUp:_showDeadline()
	self:_showLeftTime()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
end

function WarmUp:_showLeftTime()
	self._txtLimitTime.text = self.viewContainer:getActivityRemainTimeStr()
end

function WarmUp:_refreshTabList()
	local curEpisodeId = self:_episodeId()
	local maxEpisodeCount = self.viewContainer:getEpisodeCount()

	for i = 1, maxEpisodeCount do
		local episodeId = i
		local isSelected = episodeId == curEpisodeId
		local item

		if i > #self._itemTabList then
			item = self:_create_WarmUp_radiotaskitem(i)

			table.insert(self._itemTabList, item)
		else
			item = self._itemTabList[i]
		end

		item:onUpdateMO(episodeId)
		item:setActive(true)
		item:setSelected(isSelected)
	end

	for i = maxEpisodeCount + 1, #self._itemTabList do
		local item = self._itemTabList[i]

		item:setActive(false)
	end

	ZProj.UGUIHelper.RebuildLayout(self._goTaskContentTran)
end

function WarmUp:_setSelectIndex(index, isFocus)
	if index == self._lastSelectedIndex then
		return
	end

	local curEpisodeId = self:_episodeId()

	if isFocus then
		self:_taskScrollToIndex(index)

		self._lastSelectedIndex = nil
	else
		self:onClickTab(self:index2EpisodeId(curEpisodeId) or 1)
	end
end

local kItemWidth_go_radiotaskitem = 166

function WarmUp:_taskScrollToIndex(index)
	local maxScrollPosX = math.max(recthelper.getWidth(self._goTaskContentTran) - self._taskScrollViewportWidth, 0)
	local posX = math.min((index - 1) * kItemWidth_go_radiotaskitem, maxScrollPosX)

	recthelper.setAnchorX(self._goTaskContentTran, -math.max(0, posX))
end

function WarmUp:onClickTab(mo)
	local curEpisodeId = mo
	local lastEpisodeId = self:_episodeId()

	if lastEpisodeId == curEpisodeId then
		return
	end

	local isOpen, remainDay = self.viewContainer:isEpisodeDayOpen(curEpisodeId)

	if not isOpen then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeNotOpen, remainDay)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

		return
	end

	if not self.viewContainer:isEpisodeReallyOpen(curEpisodeId) then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeLock)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

		return
	end

	gohelper.setActive(self._guideGo, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)

	self._lastSelectedIndex = self:_doSelectTabByEpisodeId(curEpisodeId)

	self.viewContainer:switchTabWithAnim(lastEpisodeId, curEpisodeId)
end

function WarmUp:_doSelectTabByEpisodeId(toSelectEpisodeId)
	local lastItem = self._itemTabList[self._lastSelectedIndex]

	if lastItem then
		lastItem:playAnimIdle()
	end

	local newSelectedIndex = self:episode2Index(toSelectEpisodeId)
	local curItem = self._itemTabList[newSelectedIndex]

	if curItem then
		curItem:playAnimSelect()
	end

	return newSelectedIndex
end

function WarmUp:_refreshRewards(optEpisodeId)
	local co = self.viewContainer:getEpisodeConfig(optEpisodeId or self:_episodeId())
	local rewardBonus = co.bonus
	local rewards = split(rewardBonus, "|")
	local itemCount = #rewards

	self._rewardCount = itemCount

	for i = 1, itemCount do
		local item
		local itemCo = splitToNumber(rewards[i], "#")

		if i > #self._rewardItemList then
			item = self:_create_WarmUp_rewarditem(i)

			table.insert(self._rewardItemList, item)
		else
			item = self._rewardItemList[i]
		end

		item:onUpdateMO(itemCo)
		item:setActive(true)
	end

	for i = itemCount + 1, #self._rewardItemList do
		local item = self._rewardItemList[i]

		item:setActive(false)
	end
end

function WarmUp:openDesc(cb, cbObj)
	local isRecevied, localIsPlay = self.viewContainer:getRLOCCur()

	if isRecevied or localIsPlay then
		if cb then
			cb(cbObj)
		end

		return
	end

	self:_resetTweenDescPos()

	local co = self.viewContainer:getEpisodeConfigCur()
	local duration = math.max(co.time or 0, 1)

	gohelper.setActive(self._goWrongChannel, false)
	gohelper.setActive(self._scroll_TaskDescGo, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)

	local function _tweenDescDoneCallBack()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)

		if cb then
			cb(cbObj)
		end
	end

	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, duration, self._tweenDescUpdateCb, function()
		self:_tweenDescEndCb(duration, _tweenDescDoneCallBack)
	end, self)
end

local lerp = Mathf.Lerp

function WarmUp:_tweenDescUpdateCb(value)
	local bottom = lerp(0, self._taskDescViewportHeight, value)

	self:_setMaskPaddingBottom(bottom)
end

function WarmUp:_tweenDescEndCb(maskDurationTime, cb, cbObj)
	local toPosY = self._descHeight - self._taskDescViewportHeight

	if toPosY <= 0 then
		if cb then
			cb(cbObj)
		end

		return
	end

	local duration = toPosY * (maskDurationTime / self._taskDescViewportHeight)

	GameUtil.onDestroyViewMember_TweenId(self, "_movetweenId")

	self._movetweenId = ZProj.TweenHelper.DOLocalMoveY(self._txtTaskContentTran, toPosY, duration, cb, cbObj)
end

function WarmUp:_resetTaskContentPos()
	recthelper.setAnchorY(self._txtTaskContentTran, 0)
end

function WarmUp:episode2Index(episodeId)
	return episodeId
end

function WarmUp:index2EpisodeId(index)
	local item = self._itemTabList[index]

	if not item then
		return
	end

	return item._mo
end

function WarmUp:_setMaskPaddingBottom(bottom)
	self._taskDescMask.padding = Vector4(0, bottom, 0, 0)
end

function WarmUp:_autoSelectTab()
	local episodeId = self.viewContainer:getLatestEpisode() or self:_episodeId()

	self.viewContainer:setCurSelectEpisodeIdSlient(episodeId)
	self:_setSelectIndex(self:episode2Index(episodeId), true)
end

function WarmUp:_create_WarmUp_radiotaskitem(index)
	local go = gohelper.cloneInPlace(self._goradiotaskitem)
	local item = WarmUp_radiotaskitem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function WarmUp:_create_WarmUp_rewarditem(index)
	local go = gohelper.cloneInPlace(self._gorewarditem)
	local item = WarmUp_rewarditem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function WarmUp:_resetTweenDescPos()
	GameUtil.onDestroyViewMember_TweenId(self, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
	self:_resetTaskContentPos()
end

function WarmUp:_playAnim(name, cb, cbObj)
	if self._bInPlaying then
		table.insert(self._afterInAnimCbCbObj, {
			cb,
			cbObj
		})

		return
	end

	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function WarmUp:tweenSwitch(lastEpisodeId, curEpisodeId, cb, cbObj)
	if not curEpisodeId or not lastEpisodeId then
		if cb then
			cb(cbObj)
		end

		return
	end

	local lastIsRecevied, lastLocalIsPlay = self.viewContainer:getRLOC(lastEpisodeId)
	local curIsRecevied, curLocalIsPlay = self.viewContainer:getRLOC(curEpisodeId)

	if curIsRecevied or curLocalIsPlay then
		self:_tweenSwitchToOld(lastEpisodeId, curEpisodeId, cb, cbObj)
	elseif cb then
		cb(cbObj)
	end

	do return end

	local lastIsDone = self:_checkIsDone(lastEpisodeId) or lastLocalIsPlay or lastIsRecevied
	local curIsDone = self:_checkIsDone(curEpisodeId) or curIsRecevied or curLocalIsPlay

	if lastIsDone and curIsDone then
		if cb then
			cb(cbObj)
		end

		return
	end

	local animName
	local lastState = self:_getState(0, lastEpisodeId)
	local curState = self:_getState(0, curEpisodeId)

	if lastState == States.SwipeDone then
		if cb then
			cb(cbObj)
		end

		return
	end

	if curState == 0 and lastState == 0 then
		if cb then
			cb(cbObj)
		end

		return
	end

	if not lastIsDone and curIsDone then
		animName = "close_to_open"
	elseif lastIsDone and not curIsDone then
		animName = "open_to_close"
	else
		assert(false, string.format("invalid state lastEpisodeId: %s(%s), curEpisodeId: %s(%s)", tostring(lastEpisodeId), tostring(lastState), tostring(curEpisodeId), tostring(curState)))
	end

	self:_playAnim(animName, cb, cbObj)
end

local kBlock_tweenSwitchToOld = "WarmUp:_tweenSwitchToOld"

function WarmUp:_tweenSwitchToOld(lastEpisodeId, curEpisodeId, cb, cbObj)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_tweenSwitchToOld, kTimeout, self.viewName)
	self._drag:clear()
	self._descScrollRect:StopMovement()
	self:_resetTweenDescPos()
	self:_doSelectTabByEpisodeId(curEpisodeId)

	local ctx = self.viewContainer._tweenSwitchContext

	ctx.cbTweenSwitch = cb
	ctx.cbObjTweenSwitch = cbObj

	self:_playTaskPanelSwitch()
end

function WarmUp:_onSwitchTaskPanel()
	local ctx = self.viewContainer._tweenSwitchContext

	if ctx.cbTweenSwitch then
		ctx.cbTweenSwitch(ctx.cbObjTweenSwitch)

		ctx.cbTweenSwitch = nil
		ctx.cbObjTweenSwitch = nil
	end

	UIBlockHelper.instance:endBlock(kBlock_tweenSwitchToOld)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function WarmUp:_doSwitchByEpisodeId(toSelectEpisodeId, bSlient)
	self.viewContainer:switchTabNoAnim(toSelectEpisodeId or self:_episodeId(), bSlient)
end

function WarmUp:onSwitch(curEpisodeId, lastEpisodeId)
	lastEpisodeId = lastEpisodeId or self:_episodeId()

	self:_doSwitchByEpisodeId(curEpisodeId)
	self:_refreshAnimState(curEpisodeId > 1)
end

function WarmUp:playRewardItemsHasGetAnim()
	for i = 1, self._rewardCount do
		local item = self._rewardItemList[i]

		item:playAnim_hasget()
	end
end

function WarmUp:playTabItemsUnlockAnim()
	local maxEpisodeCount = self.viewContainer:getEpisodeCount()

	if not self._unlockedIndex then
		local newUnlockIndex = 1
		local bFirst = true

		for i = self._unlockedIndex + 1, maxEpisodeCount do
			local episodeId = i

			if self.viewContainer:isEpisodeReallyOpen(episodeId) then
				if bFirst then
					bFirst = false

					self:_taskScrollToIndex(newUnlockIndex)
				end

				local item = self._itemTabList[i]

				newUnlockIndex = i

				item:playAnimUnlock()
			end
		end

		local isDiff = newUnlockIndex ~= self._unlockedIndex

		self._unlockedIndex = newUnlockIndex

		if isDiff then
			self:_setActive_guide(true)
		end
	end
end

function WarmUp:setBlock_scroll(isBlock)
	self._scrollCanvasGroup.blocksRaycasts = not isBlock
end

function WarmUp:_btngotoOnClick()
	SDKDataTrackMgr.instance:trackClickActivityJumpButton()
	self.viewContainer:openWebView(self._onWebViewCb, self)
end

function WarmUp:_onWebViewCb(errorType, msg)
	if errorType == WebViewEnum.WebViewCBType.Cb then
		local msgParamList = string.split(msg, "#")
		local eventName = msgParamList[1]

		if eventName == "webClose" then
			ViewMgr.instance:closeView(ViewName.WebView)
		end
	end
end

function WarmUp:_setTaskContentToEnd()
	recthelper.setAnchorY(self._txtTaskContentTran, self:_getTaskContentEndPosY())
end

function WarmUp:_getTaskContentEndPosY()
	return math.max(0, self._descHeight - self._taskDescViewportHeight)
end

function WarmUp:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function WarmUp:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function WarmUp:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function WarmUp:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function WarmUp:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function WarmUp:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function WarmUp:_setActive_drag(isActive)
	gohelper.setActive(self._godrag, isActive)
	gohelper.setActive(self._gotips, isActive)
end

function WarmUp:_setActive_guide(isActive, bForceSlide)
	gohelper.setActive(self._guideGo, isActive)

	if isActive then
		if not self._unlockedIndex then
			if self._unlockedIndex <= 1 or bForceSlide then
				self:_playGuideSlideAnim()
			else
				self:_playGuideClickAnim()
			end
		end
	end
end

function WarmUp:_setActive_openGo(isActive)
	gohelper.setActive(self._openGo, isActive)

	if isActive and self:_episode2Index() == 1 then
		self:_refreshTabList()
	end
end

function WarmUp:_setActive_unopenGo(isActive)
	gohelper.setActive(self._unopenGo, isActive)
end

function WarmUp:_onClick()
	self:_playAnimAfterSwipe()
end

function WarmUp:_onDragBegin()
	self:_setActive_guide(false)
end

function WarmUp:_onDragEnd()
	if self._drag:isSwipeLeft() then
		self:_playAnimAfterSwipe()
	end
end

function WarmUp:_playAnimIdle(cb, cbObj)
	self:_playAnim("idle_close", cb, cbObj)
end

function WarmUp:_playAnimOpened(cb, cbObj)
	self:_playAnim("idle_open", cb, cbObj)
end

function WarmUp:_playAnimOpen(cb, cbObj)
	self:_playAnim("close_to_open", cb, cbObj)
	self:_setActive_openGo(true)
	self:_setActive_unopenGo(true)
end

function WarmUp:_playAnimAfterSwipe()
	self:_setActive_guide(false)
	self:_setActive_drag(false)
	self:_saveState(States.SwipeDone)
	self:_playAnimAfterSwiped()
	self.viewContainer:setLocalIsPlayCurByUser()
end

local kBlock_Click = "WarmUp:kBlock_Click"

function WarmUp:_playAnimAfterSwiped(bAutoSwipeDone)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)
	self.viewContainer:addNeedWaitCount()

	if bAutoSwipeDone then
		self._playAnimOpened(self, self._onPlayEndAnimOpen, self)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)
		self._playAnimOpen(self, self._onPlayEndAnimOpen, self)
	end

	self.viewContainer:openDesc()
end

function WarmUp:_onPlayEndAnimOpen()
	UIBlockHelper.instance:endBlock(kBlock_Click)
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:_saveStateDone(true)
end

function WarmUp:_playGuideSlideAnim()
	self:_playGuideAnim("slide", 0, 0)
end

function WarmUp:_playGuideClickAnim()
	self:_playGuideAnim("click", 0, 0)
end

function WarmUp:_playGuideAnim(name, ...)
	self._animator_guide:Play(name, ...)
end

function WarmUp:_playTaskPanelSwitch(...)
	self:_playTaskPanelAnim(UIAnimationName.Switch, ...)
end

function WarmUp:_playTaskPanelIdle(...)
	self:_playTaskPanelAnim(UIAnimationName.Idle, ...)
end

function WarmUp:_playTaskPanelAnim(name, a1, a2)
	self._animatorPlayerTaskPanel:Play(name, a1 or function()
		return
	end, a2)
end

function WarmUp:_play_ui_shengyan_item_appeared()
	return
end

function WarmUp:_play_ui_shengyan_unsheathe_dagger()
	return
end

function WarmUp:_play_ui_fuleyuan_yure_whoosh()
	return
end

return WarmUp
