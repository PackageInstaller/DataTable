-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/integral_drop/ActivityIntegralDropView.lua

module("logic.extensions.welfare.view.integral_drop.ActivityIntegralDropView", package.seeall)

local M = class("ActivityIntegralDropView", DynamicFragmentView)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._timeText = self._registry:getText("activity_integral_drop_panel_2123162423")
	self._curIntegralText = self._registry:getText("activity_integral_drop_panel_543442697")
	self._stepIntegralComps = {}

	ActivityAgent.instance:sendGetScoreActivityInfoRequest()

	self._stepIntegralMax = 1
	self._loopRoot = self._registry:getGo("activity_integral_drop_panel_-1627210708")
	self._loopList = LoopListHelper.New(self._loopRoot)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._curIntegralText = nil
	self._stepIntegralComps = nil
	self._stepIntegralMax = nil
	self._allRewardLst = nil
	self._maxStepOrder = nil
	self._loopRoot = nil

	self._loopList:ClearCells()
	self._loopList:Dispose()

	self._loopList = nil
	self._rewardCellList = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._curIntegralText.text = ActivityIntegralDropController.instance:getCurStepIntegral()

	local actId = ActivityIntegralDropController.instance:getActivityId()
	local actMo = ActivityModel.instance:getActivityById(actId)

	if actMo then
		local seconds = actMo:getLeftSeconds()

		if seconds <= 0 then
			seconds = 0
		end

		self._timeText.text = TextFormatter.formatFullExpireTime(seconds)
	end

	settimer(60, self.setTimeText, self, true)
	self:setEvent(true)
end

function M:onExit()
	self:setEvent(false)
	removetimer(self.setTimeText, self)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ACTIVITY_INTEGRAL_DROP_REWARD, self.handleRewardClick, self)
		GlobalDispatcher:addEventListener(EventType.ACTIVITY_INTEGRAL_DROP_REFRESH, self.handleRefreshRewardList, self)
		GlobalDispatcher:addEventListener(EventType.ACTIVITY_INTEGRAL_DROP_REWARDREFRESH, self.refreshRewardStatus, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ACTIVITY_INTEGRAL_DROP_REWARD, self.handleRewardClick, self)
		GlobalDispatcher:removeEventListener(EventType.ACTIVITY_INTEGRAL_DROP_REFRESH, self.handleRefreshRewardList, self)
		GlobalDispatcher:removeEventListener(EventType.ACTIVITY_INTEGRAL_DROP_REWARDREFRESH, self.refreshRewardStatus, self)
	end
end

function M:handleRewardClick(e, cell)
	local data = cell:getData()
	local orderId = cell:getStepOrder()
	local rewardStatus = ActivityIntegralDropController.instance:getReceivingRewardStatus(orderId)

	if rewardStatus == CommEnum.RewardEnum.CanNotGot then
		GlobalDispatcher:dispatchEvent(data:getItemMarkType(), data, cell:getGo(), 0, true)
	elseif rewardStatus == CommEnum.RewardEnum.HasGot then
		GlobalDispatcher:dispatchEvent(data:getItemMarkType(), data, cell:getGo(), 0, true)
	elseif rewardStatus == CommEnum.RewardEnum.CanGot then
		local msg = {}

		msg.activity = ActivityIntegralDropController.instance:getActivityId()
		msg.index = orderId - 1

		ActivityAgent.instance:sendGainScoreActivityRewardRequest(msg)
	end
end

function M:setTimeText()
	local actId = ActivityIntegralDropController.instance:getActivityId()
	local actMo = ActivityModel.instance:getActivityById(actId)

	if actMo then
		local seconds = actMo:getLeftSeconds()

		if seconds <= 0 then
			seconds = 0
		end

		self._timeText.text = TextFormatter.formatFullExpireTime(seconds)
	end
end

function M:handleRefreshRewardList()
	self._rewardCellList = {}

	self._loopList:ClearCells(true)

	self._allRewardLst = ActivityIntegralDropController.instance:getAllRewardList()
	self._maxStepOrder = #self._allRewardLst

	self:refreshRewardLst(false)
end

function M:refreshRewardLst(resetPos)
	if self._maxStepOrder == 0 then
		return
	end

	self._loopList:SetListItemCount(self._maxStepOrder, resetPos)
	self._loopList:RefreshAllShownItem()

	if resetPos then
		self._loopList:MoveToItemIndex(0)
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item, shower

	if curIndex == 1 then
		local class = ActivityIntegralDropFirstItemCell

		item = self._loopList:NewListViewItem("item1")

		local integralDropMo = self._allRewardLst[curIndex]

		shower = Astral.LuaComponentContainer.Get(item.gameObject, class)
		shower = shower or Astral.LuaComponentContainer.Add(item.gameObject, class)

		shower:setRewardData(integralDropMo)
	else
		local class = ActivityIntegralDropItemCell

		item = self._loopList:NewListViewItem("item2")

		local integralDropMo = self._allRewardLst[curIndex]

		shower = Astral.LuaComponentContainer.Get(item.gameObject, class)
		shower = shower or Astral.LuaComponentContainer.Add(item.gameObject, class)

		shower:setRewardData(integralDropMo)
	end

	table.insert(self._rewardCellList, shower)

	return item
end

function M:refreshRewardStatus()
	self._loopList:RefreshAllShownItem()
end

return M
