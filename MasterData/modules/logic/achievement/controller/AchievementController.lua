-- chunkname: @modules/logic/achievement/controller/AchievementController.lua

module("modules.logic.achievement.controller.AchievementController", package.seeall)

local AchievementController = class("AchievementController", BaseController)

function AchievementController:onInit()
	return
end

function AchievementController:onInitFinish()
	return
end

function AchievementController:addConstEvents()
	self.registerCallback(self, AchievementEvent.UpdateAchievements, self._onUpdateAchievementsHandle, self)
end

function AchievementController:reInit()
	return
end

function AchievementController:onUpdateAchievements()
	return
end

function AchievementController:getMaxLevelFinishTask(achievementId)
	local level = AchievementModel.instance:getAchievementLevel(achievementId)
	local taskCO

	return level > 0 and AchievementConfig.instance:getTaskByAchievementLevel(achievementId, level) or AchievementConfig.instance:getAchievementFirstTask(achievementId)
end

function AchievementController:openAchievementMainView(categoryType, viewType, sortType, filterType, isImmediate)
	local params = {
		categoryType = categoryType,
		viewType = viewType,
		sortType = sortType,
		filterType = filterType
	}

	ViewMgr.instance:openView(ViewName.AchievementMainView, params, isImmediate)
end

function AchievementController:openAchievementMainViewAndFocus(achievmentType, focusDataId, isOpenLevelView, isImmediate)
	local categoryType

	if achievmentType == AchievementEnum.AchievementType.Single then
		local achievementCfg = AchievementConfig.instance:getAchievement(focusDataId)

		categoryType = achievementCfg and achievementCfg.category
	elseif achievmentType == AchievementEnum.AchievementType.Group then
		local groupCfg = AchievementConfig.instance:getGroup(focusDataId)

		categoryType = groupCfg and groupCfg.category
	end

	local params = {
		categoryType = categoryType,
		achievementType = achievmentType,
		focusDataId = focusDataId,
		filterType = AchievementEnum.SearchFilterType.All,
		isOpenLevelView = isOpenLevelView
	}

	ViewMgr.instance:openView(ViewName.AchievementMainView, params, isImmediate)
end

function AchievementController:openAchievementLevelView(achievementId)
	local achievementCfg = AchievementConfig.instance:getAchievement(achievementId)

	if not achievementCfg then
		return
	end

	local isNamePlate = AchievementMainCommonModel.instance:checkIsNamePlate()

	if isNamePlate then
		local viewParam = {}

		viewParam.achievementId = achievementId
		viewParam.achievementIds = AchievementMainListModel.instance:getCurrentAchievementIds()

		ViewMgr.instance:openView(ViewName.AchievementNamePlateLevelView, viewParam)
	else
		local achievementIds = AchievementMainTileModel.instance:getCurrentAchievementIds()
		local params = {
			achievementId = achievementId,
			achievementIds = achievementIds
		}

		ViewMgr.instance:openView(ViewName.AchievementLevelView, params)
	end
end

function AchievementController:openAchievementGroupPreView(groupId, groupPreViewUrl)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))

		return
	end

	local viewSetting = ViewMgr.instance:getSetting(ViewName.AchievementGroupPreView)

	if not viewSetting then
		logError("cannot find AchievementGroupPreView Setting, please check module_views.AchievementGroupPreView")

		return
	end

	local groupCfg = AchievementConfig.instance:getGroup(groupId)

	if not groupCfg or string.nilorempty(groupPreViewUrl) then
		logError(string.format("AchievementConfig Error, groupId = %s, groupPreViewUrl = %s", groupId, groupPreViewUrl))

		return
	end

	viewSetting.mainRes = string.format("%s/%s.prefab", AchievementEnum.AchievementPreViewPrefabPath, groupPreViewUrl)

	ViewMgr.instance:openView(ViewName.AchievementGroupPreView, {
		groupId = groupId
	})
end

function AchievementController:_onUpdateAchievementsHandle()
	AchievementLevelController.instance:cleanNotShowTaskIsNew()
end

AchievementController.instance = AchievementController.New()

return AchievementController
