-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionConditionFilterView.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionConditionFilterView", package.seeall)

local HolyStripeQuickActionConditionFilterView = class("HolyStripeQuickActionConditionFilterView", HolyStripeConditionFilterView)

function HolyStripeQuickActionConditionFilterView:_onClickItem(conditionId)
	local maxSelectCount = self:_getMaxSelectCount()

	if self._selectMap[conditionId] == true then
		self._selectMap[conditionId] = false
		self._selectCount = self._selectCount - 1
	elseif maxSelectCount <= self._selectCount then
		FloatWordMgr.instance:show(langPara("最多同时筛选%s条属性哦！", maxSelectCount))

		return
	else
		self._selectMap[conditionId] = true
		self._selectCount = self._selectCount + 1
	end

	table.clear(self._selectSort)

	for i, v in pairs(self._selectMap) do
		if v == true then
			table.insert(self._selectSort, i)
		end
	end

	GlobalDispatcher:dispatch(HolyStripeQuickActionFilterEvent.ConditionFilter, self._selectSort)
	self:_refreshView()
end

return HolyStripeQuickActionConditionFilterView
