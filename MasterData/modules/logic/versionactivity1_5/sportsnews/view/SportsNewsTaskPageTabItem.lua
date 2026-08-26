-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsTaskPageTabItem.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskPageTabItem", package.seeall)

local SportsNewsTaskPageTabItem = class("SportsNewsTaskPageTabItem", SportsNewsPageTabItem)

function SportsNewsTaskPageTabItem:initData(index, go)
	SportsNewsTaskPageTabItem.super.initData(self, index, go)
end

function SportsNewsTaskPageTabItem:getTabStatus()
	local isSelect = ActivityWarmUpTaskListModel.instance:getSelectedDay() == self._index
	local isLock = self._index > ActivityWarmUpModel.instance:getCurrentDay()

	if isLock then
		return SportsNewsEnum.PageTabStatus.Lock
	elseif isSelect then
		return SportsNewsEnum.PageTabStatus.Select
	else
		return SportsNewsEnum.PageTabStatus.UnSelect
	end
end

function SportsNewsTaskPageTabItem:_btnclickOnClick()
	local status = self:getTabStatus()

	if status == SportsNewsEnum.PageTabStatus.UnSelect then
		ActivityWarmUpTaskController.instance:changeSelectedDay(self._index)
		SportsNewsController.instance:dispatchEvent(SportsNewsEvent.OnCutTab, 2)
	end
end

function SportsNewsTaskPageTabItem:onRefresh()
	SportsNewsTaskPageTabItem.super.onRefresh(self)
	self:redDot()
end

function SportsNewsTaskPageTabItem:redDot()
	local _isShowRedDot = self:isShowRedDot()

	self:enableRedDot(_isShowRedDot, RedDotEnum.DotNode.v1a5NewsTaskBonus)
end

function SportsNewsTaskPageTabItem:isShowRedDot()
	if self._index > ActivityWarmUpModel.instance:getCurrentDay() then
		return false
	end

	local taskMo = SportsNewsModel.instance:getSelectedDayTask(self._index)

	if taskMo then
		for _, mo in ipairs(taskMo) do
			local finish = mo:isFinished()
			local gotbonus = mo:alreadyGotReward()

			if finish and not gotbonus then
				return true
			end
		end
	end

	return false
end

function SportsNewsTaskPageTabItem:playTabAnim()
	return
end

return SportsNewsTaskPageTabItem
