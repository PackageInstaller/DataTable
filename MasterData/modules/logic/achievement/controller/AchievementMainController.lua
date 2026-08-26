-- chunkname: @modules/logic/achievement/controller/AchievementMainController.lua

module("modules.logic.achievement.controller.AchievementMainController", package.seeall)

local AchievementMainController = class("AchievementMainController", BaseController)

function AchievementMainController:onOpenView(category, viewType, sortType, filterType)
	category = category or AchievementEnum.Type.Story

	AchievementMainCommonModel.instance:initDatas(category, viewType, sortType, filterType)
	self:cleanTabNew(category)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, self.notifyUpdateView, self)
end

function AchievementMainController:updateAchievementState()
	local curCategory = AchievementMainCommonModel.instance:getCurrentCategory()
	local curViewType = AchievementMainCommonModel.instance:getCurrentViewType()
	local curSortType = AchievementMainCommonModel.instance:getCurrentSortType()
	local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()

	AchievementMainCommonModel.instance:initDatas(curCategory, curViewType, curSortType, curFilterType)
end

function AchievementMainController:onCloseView()
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievements, self.notifyUpdateView, self)

	local category = AchievementMainCommonModel.instance:getCurrentCategory()

	self:cleanCategoryNewFlag(category)
end

function AchievementMainController:setCategory(category)
	AchievementMainTileModel.instance:resetScrollFocusIndex()
	AchievementMainTileModel.instance:setHasPlayOpenAnim(false)
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)

	local lastCategory = AchievementMainCommonModel.instance:getCurrentCategory()

	AchievementMainCommonModel.instance:switchCategory(category)
	self:cleanCategoryNewFlag(lastCategory)
	self:cleanTabNew(category)
	self:dispatchEvent(AchievementEvent.OnSwitchCategory)
	self:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function AchievementMainController:switchViewType(viewType)
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)
	AchievementMainCommonModel.instance:switchViewType(viewType)
	self:dispatchEvent(AchievementEvent.OnSwitchViewType)
	self:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function AchievementMainController:switchSortType(sortType)
	AchievementMainCommonModel.instance:switchSortType(sortType)
	self:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function AchievementMainController:switchSearchFilterType(searchFilerType)
	AchievementMainCommonModel.instance:switchSearchFilterType(searchFilerType)
	self:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function AchievementMainController:cleanTabNew(category)
	AchievementMainCommonModel.instance.categoryNewDict[category] = false
end

function AchievementMainController:cleanCategoryNewFlag(category)
	local coList = AchievementMainCommonModel.instance:getCategoryAchievementConfigList(category)
	local taskIds = {}

	for i, achievementCo in ipairs(coList) do
		local taskCoList = AchievementModel.instance:getAchievementTaskCoList(achievementCo.id)

		if taskCoList then
			for _, taskCo in ipairs(taskCoList) do
				local taskMo = AchievementModel.instance:getById(taskCo.id)

				if taskMo and taskMo.isNew then
					table.insert(taskIds, taskCo.id)
				end
			end
		end
	end

	if #taskIds > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(taskIds)
	end
end

function AchievementMainController:notifyUpdateView()
	AchievementMainTileModel.instance:onModelUpdate()
end

AchievementMainController.instance = AchievementMainController.New()

LuaEventSystem.addEventMechanism(AchievementMainController.instance)

return AchievementMainController
