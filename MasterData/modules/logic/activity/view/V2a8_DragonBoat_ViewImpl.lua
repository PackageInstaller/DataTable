-- chunkname: @modules/logic/activity/view/V2a8_DragonBoat_ViewImpl.lua

module("modules.logic.activity.view.V2a8_DragonBoat_ViewImpl", package.seeall)

local csAnimatorPlayer = SLFramework.AnimatorPlayer
local csUIDragListener = SLFramework.UGUI.UIDragListener
local csUIClickListener = SLFramework.UGUI.UIClickListener
local V2a8_DragonBoat_ViewImpl = class("V2a8_DragonBoat_ViewImpl", Activity101SignViewBase)

function V2a8_DragonBoat_ViewImpl:_createList()
	if self.__itemList then
		return
	end

	recthelper.setWidth(self.viewContainer:getScrollContentTranform(), self:calcContentWidth())

	self.__itemList = {}

	self:_createListDirectly()
end

function V2a8_DragonBoat_ViewImpl:_updateScrollViewPos()
	if self._isFirstUpdateScrollPos then
		return
	end

	self._isFirstUpdateScrollPos = true

	self:updateRewardCouldGetHorizontalScrollPixel(function(index)
		return index - 1
	end)
end

function V2a8_DragonBoat_ViewImpl:addEvents()
	V2a8_DragonBoat_ViewImpl.super.addEvents(self)
end

function V2a8_DragonBoat_ViewImpl:removeEvents()
	V2a8_DragonBoat_ViewImpl.super.removeEvents(self)
end

function V2a8_DragonBoat_ViewImpl:_editableInitView()
	self._txtLimitTime.text = ""
	self._txt_dec.text = ""
	self._leftAnimPlayer = csAnimatorPlayer.Get(self._leftGo)
	self._leftAnimator = self._leftAnimPlayer.animator
	self._leftAnimEvent = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)
	self._animEvent = gohelper.onceAddComponent(self._leftGo, gohelper.Type_AnimationEventWrap)

	self._animEvent:AddEventListener("play_ui_mln_no_effect", self._onplay_ui_mln_no_effect, self)

	self._drag = csUIDragListener.Get(self._scrollItemListGo)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._scrollItemListGo, DungeonMapEpisodeAudio, self._scrollItemList)
	self._touch = csUIClickListener.Get(self._scrollItemListGo)

	self._touch:AddClickDownListener(self._onClickDownHandler, self)
	self:_setActive_normalGo(false)
	self:_setActive_cangetGo(false)
	self:_setActive_hasgetGo(false)
end

function V2a8_DragonBoat_ViewImpl:onOpen()
	self:internal_set_actId(self.viewParam.actId)
	self:internal_onOpen()
	self:_clearTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_playAnim_None()
end

function V2a8_DragonBoat_ViewImpl:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a8_DragonBoat_ViewImpl:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function V2a8_DragonBoat_ViewImpl:onClose()
	self:_clearTimeTick()
	V2a8_DragonBoat_ViewImpl.super.onClose(self)
end

function V2a8_DragonBoat_ViewImpl:onDestroyView()
	self._animEvent:RemoveAllEventListener()
	self:_clearTimeTick()
	self:_setIntOnAnime(nil)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end

	self._drag = nil

	if self._touch then
		self._touch:RemoveClickDownListener()
	end

	self._touch = nil

	if self._audioScroll then
		self._audioScroll:onDestroy()
	end

	self._audioScroll = nil

	Activity101SignViewBase._internal_onDestroy(self)
	V2a8_DragonBoat_ViewImpl.super.onDestroyView(self)
end

function V2a8_DragonBoat_ViewImpl:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
	self:_refreshRightTop()
	self:_refreshLeft()
	self:_updateScrollViewPos()
end

function V2a8_DragonBoat_ViewImpl:_refreshLeft()
	local maxDay = self.viewContainer:getMoonFestivalSignMaxDay()
	local isShowBtn = false

	for i = 1, maxDay do
		local couldGet = self.viewContainer:isType101RewardCouldGet(i)

		if couldGet and not self.viewContainer:isStateDone(i) then
			isShowBtn = true

			break
		end
	end

	self:_setActive_btnstartGO(isShowBtn)
end

function V2a8_DragonBoat_ViewImpl:_refreshRightTop()
	local CO = self.viewContainer:getCurrentTaskCO()

	if not CO then
		self._txt_dec.text = ""

		return
	end

	local bonusItems = GameUtil.splitString2(CO.bonus, true)
	local bonusItem = bonusItems[1]
	local isFinishedTask = self.viewContainer:isFinishedTask(CO.id)
	local isRewardable = self.viewContainer:isRewardable(CO.id)

	self:_setActive_cangetGo(isRewardable)
	self:_setActive_hasgetGo(isFinishedTask)
	self:_setActive_normalGo(not isRewardable and not isFinishedTask)

	self._txt_dec.text = CO.taskDesc
	self._bonusItem = bonusItem
end

function V2a8_DragonBoat_ViewImpl:_onItemClick()
	local ok = self.viewContainer:sendGet101SpBonusRequest(self._onReceiveGet101SpBonusReplySucc, self)

	if not ok and self._bonusItem then
		MaterialTipController.instance:showMaterialInfo(self._bonusItem[1], self._bonusItem[2])
	end
end

function V2a8_DragonBoat_ViewImpl:_setActive_normalGo(isActive)
	gohelper.setActive(self._normalGo, isActive)
end

function V2a8_DragonBoat_ViewImpl:_setActive_cangetGo(isActive)
	gohelper.setActive(self._cangetGo, isActive)
end

function V2a8_DragonBoat_ViewImpl:_setActive_hasgetGo(isActive)
	gohelper.setActive(self._hasgetGo, isActive)
end

function V2a8_DragonBoat_ViewImpl:_setActive_btnstartGO(isActive)
	gohelper.setActive(self._btnstartGO, isActive)
end

function V2a8_DragonBoat_ViewImpl:_onReceiveGet101SpBonusReplySucc()
	self:_refreshRightTop()

	if not ActivityType101Model.instance:isType101SpRewardCouldGetAnyOne(self:actId()) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.ActivityNoviceTab
		})
	end
end

function V2a8_DragonBoat_ViewImpl:_playAnim(name, cb, cbObj)
	self._leftAnimator.enabled = true

	self._leftAnimPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V2a8_DragonBoat_ViewImpl:_playAnim_None(cb, cbObj)
	self:_playAnim(UIAnimationName.None, cb, cbObj)
end

function V2a8_DragonBoat_ViewImpl:_playAnim_Open(cb, cbObj)
	self:_playAnim(UIAnimationName.Open, cb, cbObj)
end

function V2a8_DragonBoat_ViewImpl:_getTargetDay()
	local firstAvailableIndex = self.viewContainer:getFirstAvailableIndex()
	local maxDay = self.viewContainer:getMoonFestivalSignMaxDay()

	if maxDay < firstAvailableIndex then
		return
	end

	local targetDay = firstAvailableIndex == 0 and 1 or firstAvailableIndex

	for i = targetDay, maxDay do
		if self.viewContainer:isPlayAnimAvaliable(i) then
			return i
		end
	end

	return nil
end

function V2a8_DragonBoat_ViewImpl:_onClickMedicinalBath()
	local targetDay = self:_getTargetDay()

	if not targetDay then
		return
	end

	if self:_isOnAnime() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_yaoyu_make)
	self:focusByIndex(targetDay - 1)
	self:_setIntOnAnime(targetDay)
	self._playAnim_Open(self, self._onOpenAnimDone, self)
end

function V2a8_DragonBoat_ViewImpl:_getPrefsKeyPrefix_OnAnime()
	local key = self.viewContainer:getPrefsKeyPrefix()

	return key .. "OnAnime"
end

function V2a8_DragonBoat_ViewImpl:_setIntOnAnime(day)
	local key = self:_getPrefsKeyPrefix_OnAnime()

	self.viewContainer:saveInt(key, day or 0)
end

function V2a8_DragonBoat_ViewImpl:_getIntOnAnime()
	local key = self:_getPrefsKeyPrefix_OnAnime()

	return self.viewContainer:getInt(key, 0)
end

function V2a8_DragonBoat_ViewImpl:_isOnAnime(day)
	local animatingDay = self:_getIntOnAnime()

	if day then
		return animatingDay == day
	end

	return animatingDay > 0
end

function V2a8_DragonBoat_ViewImpl:_onOpenAnimDone()
	local targetDay = self:_getIntOnAnime()
	local item = self:getItemByIndex(targetDay)

	if not item then
		if self:_isOnAnime() then
			self:_setIntOnAnime(nil)
			self:_playAnim_None()
		end

		return
	end

	item:playAnim_unlock(self._saveStateDone, self)
end

function V2a8_DragonBoat_ViewImpl:_saveStateDone()
	local targetDay = self:_getIntOnAnime()

	self:_setIntOnAnime(nil)

	if not targetDay or targetDay == 0 then
		return
	end

	self.viewContainer:saveStateDone(targetDay, true)
	self:_refreshLeft()
	self:_playAnim_None()
end

function V2a8_DragonBoat_ViewImpl:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function V2a8_DragonBoat_ViewImpl:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function V2a8_DragonBoat_ViewImpl:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

function V2a8_DragonBoat_ViewImpl:_onplay_ui_mln_no_effect()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_no_effect)
end

return V2a8_DragonBoat_ViewImpl
