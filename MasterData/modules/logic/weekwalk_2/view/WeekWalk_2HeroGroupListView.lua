-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeroGroupListView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupListView", package.seeall)

local WeekWalk_2HeroGroupListView = class("WeekWalk_2HeroGroupListView", HeroGroupListView)

function WeekWalk_2HeroGroupListView:addEvents()
	WeekWalk_2HeroGroupListView.super.addEvents(self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroupFinish, self._checkRestrictHero, self)
end

function WeekWalk_2HeroGroupListView:_getHeroItemCls()
	return WeekWalk_2HeroGroupHeroItem
end

function WeekWalk_2HeroGroupListView:_checkRestrictHero()
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

function WeekWalk_2HeroGroupListView:_removeWeekWalkInCdHero()
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

function WeekWalk_2HeroGroupListView:onDestroyView()
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")
	TaskDispatcher.cancelTask(self._removeWeekWalkInCdHero, self)
	WeekWalk_2HeroGroupListView.super.onDestroyView(self)
end

return WeekWalk_2HeroGroupListView
