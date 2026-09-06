-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionConditionSortView.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionConditionSortView", package.seeall)

local HolyStripeQuickActionConditionSortView = class("HolyStripeQuickActionConditionSortView", HolyStripeConditionSortView)

function HolyStripeQuickActionConditionSortView:_onClickItem(conditionId)
	if self._selectSort == conditionId then
		self._selectSort = -1

		GlobalDispatcher:dispatch(HolyStripeQuickActionFilterEvent.ConditionSort, self._selectSort)
	else
		GlobalDispatcher:dispatch(HolyStripeQuickActionFilterEvent.ConditionSort, conditionId)
	end

	self:close()
end

return HolyStripeQuickActionConditionSortView
