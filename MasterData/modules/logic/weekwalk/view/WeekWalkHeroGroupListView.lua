-- chunkname: @modules/logic/weekwalk/view/WeekWalkHeroGroupListView.lua

module("modules.logic.weekwalk.view.WeekWalkHeroGroupListView", package.seeall)

local WeekWalkHeroGroupListView = class("WeekWalkHeroGroupListView", HeroGroupListView)

function WeekWalkHeroGroupListView:addEvents()
	WeekWalkHeroGroupListView.super.addEvents(self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroupFinish, self._checkRestrictHero, self)
end

function WeekWalkHeroGroupListView:_getHeroItemCls()
	return WeekWalkHeroGroupHeroItem
end

function WeekWalkHeroGroupListView:_checkRestrictHero()
	local list = {}

	for i, heroItem in ipairs(self._heroItemList) do
		local id = heroItem:checkWeekWalkCd()

		if id then
			table.insert(list, id)
		end
	end

	if #list == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeWeekWalkInCdHero")

	self._heroInCdList = list

	TaskDispatcher.runDelay(self._removeWeekWalkInCdHero, self, 1.5)
end

function WeekWalkHeroGroupListView:_removeWeekWalkInCdHero()
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

	if not self._heroInCdList then
		return
	end

	local list = self._heroInCdList

	self._heroInCdList = nil

	for i, id in ipairs(list) do
		HeroSingleGroupModel.instance:remove(id)
	end

	for _, heroItem in ipairs(self._heroItemList) do
		heroItem:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function WeekWalkHeroGroupListView:onDestroyView()
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")
	TaskDispatcher.cancelTask(self._removeWeekWalkInCdHero, self)
	WeekWalkHeroGroupListView.super.onDestroyView(self)
end

return WeekWalkHeroGroupListView
