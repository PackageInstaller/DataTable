-- chunkname: @modules/logic/activity/view/Activity101SignViewItemBase.lua

module("modules.logic.activity.view.Activity101SignViewItemBase", package.seeall)

local Activity101SignViewItemBase = class("Activity101SignViewItemBase", ListScrollCellExtend)
local kDelaySecond = 0.03
local kMaxOpenAnimDuration = 0.25
local sIsFirstCreated = false

function Activity101SignViewItemBase:_optimizePlayOpenAnim()
	local scoreModel = self:getScrollModel()
	local startPinIndex = scoreModel:getStartPinIndex()

	if startPinIndex >= self._index then
		sIsFirstCreated = true
	end

	if sIsFirstCreated then
		self:playOpenAnim()
	end
end

function Activity101SignViewItemBase:onUpdateMO(mo)
	self._mo = mo

	if self:isLimitedScrollViewItem() then
		self:_optimizePlayOpenAnim()
	end

	self:onRefresh()
	self:_refresh_TomorrowTagGo()
end

function Activity101SignViewItemBase:_animCmp()
	if not self._anim then
		self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)

		assert(self._anim, "can not found anim component!!")
	end

	return self._anim
end

function Activity101SignViewItemBase:onDestroyView()
	TaskDispatcher.cancelTask(self._playOpenInner, self)

	sIsFirstCreated = false
end

function Activity101SignViewItemBase:_onItemClick()
	local actId = self:actId()
	local index = self._index

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if not ActivityModel.instance:isActOnLine(actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(actId)

	if couldGet then
		Activity101Rpc.instance:sendGet101BonusRequest(actId, index)
	end

	if totalday < index then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function Activity101SignViewItemBase:_playOpenInner()
	self:setActive(true)

	local anim = self:_animCmp()

	anim:Play(UIAnimationName.Open, 0, 0)
end

function Activity101SignViewItemBase:playOpenAnim()
	local mo = self._mo

	if mo.__isPlayedOpenAnim then
		self:_playIdle()

		return
	end

	mo.__isPlayedOpenAnim = true

	local index = self._index
	local delaySecond

	if self:isLimitedScrollViewItem() then
		local scoreModel = self:getScrollModel()
		local startPinIndex = scoreModel:getStartPinIndex()

		if index < startPinIndex then
			self:_playIdle()

			return
		end

		delaySecond = math.max(0, index - startPinIndex + 1) * kDelaySecond

		if delaySecond > kMaxOpenAnimDuration then
			delaySecond = kMaxOpenAnimDuration

			self:_playIdle()

			return
		end
	else
		delaySecond = index * kDelaySecond
	end

	self:setActive(false)
	TaskDispatcher.runDelay(self._playOpenInner, self, delaySecond)
end

function Activity101SignViewItemBase:_playIdle()
	local anim = self:_animCmp()

	anim:Play(UIAnimationName.Idle, 0, 1)
end

function Activity101SignViewItemBase:setActive(bool)
	gohelper.setActive(self.viewGO, bool)
end

function Activity101SignViewItemBase:isLimitedScrollViewItem()
	local view = self._view

	return type(view.getScrollModel) ~= "function"
end

function Activity101SignViewItemBase:getScrollModel()
	local view = self._view

	if self:isLimitedScrollViewItem() then
		return view._model
	end

	if isDebugBuild then
		assert(type(view.getScrollModel == "function", "please override this function"))
	end

	return view:getScrollModel()
end

function Activity101SignViewItemBase:getCsListScroll()
	local view = self._view

	if self:isLimitedScrollViewItem() then
		return view:getCsListScroll()
	end

	if isDebugBuild then
		assert(type(view.getCsListScroll == "function", "please override this function"))
	end

	return view:getCsListScroll()
end

function Activity101SignViewItemBase:_refreshRewardItem(item, itemCo)
	item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item:setCountFontSize(46)
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:customOnClickCallback(function()
		local actId = self:actId()
		local index = self._index

		if not ActivityModel.instance:isActOnLine(actId) then
			GameFacade.showToast(ToastEnum.BattlePass)

			return
		end

		local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

		if couldGet then
			Activity101Rpc.instance:sendGet101BonusRequest(actId, index)

			return
		end

		MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
	end)
end

function Activity101SignViewItemBase:_setActive_TomorrowTagGo(isActive)
	gohelper.setActive(self:_tomorrowTagGo(), isActive)
end

function Activity101SignViewItemBase:_setActive_kelingquGo(isActive)
	gohelper.setActive(self:_kelingquGo(), isActive)
end

local k24HSec = 86400

function Activity101SignViewItemBase:_refresh_TomorrowTagGo()
	local actId = self:actId()
	local index = self._index
	local totalday = ActivityType101Model.instance:getType101LoginCount(actId)
	local isActive = index == totalday + 1 and self:getRemainTimeSec() >= k24HSec or false

	self:_setActive_TomorrowTagGo(isActive)
end

function Activity101SignViewItemBase:actId()
	return self._mo.data[1]
end

function Activity101SignViewItemBase:view()
	return self._view
end

function Activity101SignViewItemBase:viewContainer()
	return self:view().viewContainer
end

function Activity101SignViewItemBase:getRemainTimeSec()
	local actId = self:actId()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(actId)

	return remainTimeSec or 0
end

function Activity101SignViewItemBase:onRefresh()
	assert(false, "please override thid function")
end

function Activity101SignViewItemBase:_kelingquGo()
	self._kelinquGo = self._kelinquGo or self._goSelectedBG and gohelper.findChild(self._goSelectedBG, "kelinqu") or gohelper.findChild(self.viewGO, "Root/#go_SelectedBG/kelinqu")

	return self._kelinquGo
end

function Activity101SignViewItemBase:_tomorrowTagGo()
	self._goTomorrowTag = self._goTomorrowTag or gohelper.findChild(self.viewGO, "Root/#go_TomorrowTag")

	return self._goTomorrowTag
end

function Activity101SignViewItemBase:setScrollparentGameObject(limitedScrollRectGo)
	if gohelper.isNil(limitedScrollRectGo) then
		return
	end

	local limitedScrollRectCmp = limitedScrollRectGo:GetComponent(gohelper.Type_LimitedScrollRect)

	assert(limitedScrollRectCmp, "must add csharp LimitedScrollRect component!!")

	local scrollParent = self:getCsListScroll()

	assert(scrollParent, "parent scroll must add csharp ListScrollView component!!")

	limitedScrollRectCmp.parentGameObject = scrollParent.gameObject
end

return Activity101SignViewItemBase
