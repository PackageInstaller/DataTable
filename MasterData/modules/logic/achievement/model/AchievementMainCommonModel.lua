-- chunkname: @modules/logic/achievement/model/AchievementMainCommonModel.lua

module("modules.logic.achievement.model.AchievementMainCommonModel", package.seeall)

local AchievementMainCommonModel = class("AchievementMainCommonModel", BaseModel)

function AchievementMainCommonModel:initDatas(selectCategory, selectViewType, selectSortType, filterType)
	self._curCategory = selectCategory or AchievementEnum.Type.Story
	self._curViewType = selectViewType or AchievementEnum.ViewType.Tile
	self._curSortType = selectSortType or AchievementEnum.SortType.RareDown
	self._curFilterType = filterType or AchievementEnum.SearchFilterType.All
	self._infoDict = AchievementConfig.instance:getCategoryAchievementMap()
	self._categoryAchievementCountMap = {}
	self._categoryUnlockAchievementCountMap = {}
	self._achievementEffectMap = {}
	self._taskEffectMap = {}
	self._groupUpgradeEffectMap = {}
	self._isCurrentScrollFocusing = false

	self:initScrollData()
	self:initCategoryNewFlag()
	self:refreshScroll()
end

function AchievementMainCommonModel:switchCategory(category)
	if self._curCategory ~= category then
		self._curCategory = category

		self:refreshScroll()
	end
end

function AchievementMainCommonModel:switchViewType(selectViewType)
	if self._curViewType ~= selectViewType then
		self._curViewType = selectViewType

		self:refreshScroll()
	end
end

function AchievementMainCommonModel:switchSearchFilterType(searchFilterType)
	if self._curFilterType ~= searchFilterType then
		self._curFilterType = searchFilterType

		self:refreshScroll()
	end
end

function AchievementMainCommonModel:initScrollData()
	AchievementMainTileModel.instance:initDatas()
	AchievementMainListModel.instance:initDatas()
end

function AchievementMainCommonModel:refreshScroll()
	local curExcuteModelInstance = self:getViewExcuteModelInstance(self._curViewType)
	local categoryAchievementCfgs = self._infoDict[self._curCategory]

	curExcuteModelInstance:refreshTabData(self._curCategory, self._curSortType, self._curFilterType, categoryAchievementCfgs)
end

function AchievementMainCommonModel:initCategoryNewFlag()
	self.categoryNewDict = {}

	for _, category in pairs(AchievementEnum.Type) do
		self.categoryNewDict[category] = self:buildCategoryNewFlag(category)
	end
end

function AchievementMainCommonModel:buildCategoryNewFlag(category)
	local cfgList = self._infoDict[category]

	if cfgList then
		for i, achievementCo in ipairs(cfgList) do
			if AchievementModel.instance:achievementHasNew(achievementCo.id) then
				return true
			end
		end
	end
end

function AchievementMainCommonModel:categoryHasNew(category)
	return self.categoryNewDict[category]
end

function AchievementMainCommonModel:getCurrentCategory()
	return self._curCategory
end

function AchievementMainCommonModel:getCurrentViewType()
	return self._curViewType
end

function AchievementMainCommonModel:switchSortType(sortType)
	if self._curSortType ~= sortType then
		self._curSortType = sortType

		self:refreshScroll()
	end
end

function AchievementMainCommonModel:getViewExcuteModelInstance(viewType)
	if self._curCategory == AchievementEnum.Type.NamePlate then
		return AchievementMainListModel.instance
	elseif viewType == AchievementEnum.ViewType.Tile then
		return AchievementMainTileModel.instance
	else
		return AchievementMainListModel.instance
	end
end

function AchievementMainCommonModel:getCurViewExcuteModelInstance()
	return self:getViewExcuteModelInstance(self._curViewType)
end

function AchievementMainCommonModel:getCategoryAchievementConfigList(targetCategory)
	return self._infoDict and self._infoDict[targetCategory]
end

function AchievementMainCommonModel:getCategoryAchievementUnlockInfo(category)
	local totalAchievementCount, unlockAchievementCount = 0, 0

	if not self._categoryAchievementCountMap[category] then
		totalAchievementCount, unlockAchievementCount = self:buildCategoryAchievementCountMap(category)
		self._categoryAchievementCountMap[category] = totalAchievementCount
		self._categoryUnlockAchievementCountMap[category] = unlockAchievementCount
	else
		totalAchievementCount = self._categoryAchievementCountMap[category] or 0
		unlockAchievementCount = self._categoryUnlockAchievementCountMap[category] or 0
	end

	return totalAchievementCount, unlockAchievementCount
end

function AchievementMainCommonModel:buildCategoryAchievementCountMap(category)
	local achievementList = self:getCategoryAchievementConfigList(category)
	local unlockAchievementCount = 0
	local totalAchievementCount = 0

	if achievementList then
		for _, achievementCfg in pairs(achievementList) do
			local taskList = AchievementConfig.instance:getTasksByAchievementId(achievementCfg.id)
			local isAchievementFinished = false

			if taskList then
				for _, taskCfg in ipairs(taskList) do
					isAchievementFinished = AchievementModel.instance:isAchievementTaskFinished(taskCfg.id)

					if isAchievementFinished then
						break
					end
				end
			end

			totalAchievementCount = totalAchievementCount + 1
			unlockAchievementCount = isAchievementFinished and unlockAchievementCount + 1 or unlockAchievementCount
		end
	end

	return totalAchievementCount, unlockAchievementCount
end

function AchievementMainCommonModel:getCurrentSortType()
	return self._curSortType
end

function AchievementMainCommonModel:getCurrentScrollType()
	return self._curViewType
end

function AchievementMainCommonModel:getCurrentFilterType()
	return self._curFilterType
end

function AchievementMainCommonModel:getViewAchievementIndex(viewType, achievementType, dataId)
	local viewExcuteModelInstance = self:getViewExcuteModelInstance(viewType)
	local isSucc = false
	local achievementIndex = 0
	local scrollPixel = 0

	if viewExcuteModelInstance and viewExcuteModelInstance.getAchievementIndexAndScrollPixel then
		isSucc, achievementIndex, scrollPixel = viewExcuteModelInstance:getAchievementIndexAndScrollPixel(achievementType, dataId)
	end

	return isSucc, achievementIndex, scrollPixel
end

function AchievementMainCommonModel:getNewestUnlockAchievementId(category, filterType)
	local categoryAchievementCfgs = self._infoDict[category]
	local curExcuteModelInstance = self:getViewExcuteModelInstance(self._curViewType)
	local fitCateogryCfgs = curExcuteModelInstance:getFitCategoryAchievementCfgs(category, filterType, categoryAchievementCfgs)

	if fitCateogryCfgs then
		local newUnlockAchievementId, newUnlockTime

		for _, achievementCfg in ipairs(fitCateogryCfgs) do
			local achievementId = achievementCfg.id
			local isAchievementPlayEffect = self:isAchievementPlayEffect(achievementId)

			if not isAchievementPlayEffect then
				local newTaskFinishTime = self:getAchievementNewFinishedTask(achievementId)

				if newTaskFinishTime and (not newUnlockTime or newUnlockTime < newTaskFinishTime) then
					newUnlockTime = newTaskFinishTime
					newUnlockAchievementId = achievementId
				end
			end
		end

		return newUnlockAchievementId
	end
end

function AchievementMainCommonModel:getAchievementNewFinishedTask(achievementId)
	local taskCfgs = AchievementModel.instance:getAchievementTaskCoList(achievementId)
	local newTaskFinishTime, newFinishTaskId

	if taskCfgs then
		for _, taskCfg in ipairs(taskCfgs) do
			local taskId = taskCfg.id
			local taskMO = AchievementModel.instance:getById(taskId)
			local isTaskFinished = taskMO and taskMO.hasFinished

			if isTaskFinished then
				local isTaskNew = taskMO and taskMO.isNew
				local taskFinishTime = taskMO and taskMO.finishTime
				local taskHasPlayEffect = self:isTaskPlayFinishedEffect(taskId)

				if isTaskNew and not taskHasPlayEffect and (not newTaskFinishTime or newTaskFinishTime < taskFinishTime) then
					newTaskFinishTime = taskFinishTime
					newFinishTaskId = taskMO.id
				end
			else
				break
			end
		end
	end

	return newTaskFinishTime, newFinishTaskId
end

function AchievementMainCommonModel:getNewestUpgradeGroupId(category, filterType)
	if category ~= AchievementEnum.Type.Activity or self._curViewType ~= AchievementEnum.ViewType.Tile then
		return
	end

	local categoryAchievementCfgs = self._infoDict[category]
	local curExcuteModelInstance = self:getViewExcuteModelInstance(self._curViewType)
	local fitCateogryCfgs = curExcuteModelInstance:getFitCategoryAchievementCfgs(category, filterType, categoryAchievementCfgs)

	if fitCateogryCfgs then
		local newestUpgradeGroupId, newestUpgradeTime
		local checkGroupMap = {}

		for _, achievementCfg in ipairs(fitCateogryCfgs) do
			local groupId = achievementCfg and achievementCfg.groupId
			local isGroupPlayEffect = self:isGroupPlayUpgradeEffect(groupId)

			if groupId ~= 0 and not checkGroupMap[groupId] and not isGroupPlayEffect then
				checkGroupMap[groupId] = true

				local groupCfg = AchievementConfig.instance:getGroup(groupId)
				local upgradeTaskId = groupCfg and groupCfg.unLockAchievement
				local taskMO = AchievementModel.instance:getById(upgradeTaskId)

				if taskMO then
					local isTaskFinished = taskMO and taskMO.hasFinished
					local isTaskNew = taskMO and taskMO.isNew

					if isTaskFinished and isTaskNew then
						local taskFinishTime = taskMO and taskMO.finishTime

						if not newestUpgradeTime or newestUpgradeTime < taskFinishTime then
							newestUpgradeGroupId = groupId
							newestUpgradeTime = taskFinishTime
						end
					end
				end
			end
		end

		return newestUpgradeGroupId
	end
end

function AchievementMainCommonModel:isCurrentViewBagEmpty()
	local curExcuteModelInstance = self:getViewExcuteModelInstance(self._curViewType)
	local isEmpty = false

	if curExcuteModelInstance then
		local count = curExcuteModelInstance:getCount()

		isEmpty = count <= 0
	end

	return isEmpty
end

function AchievementMainCommonModel:markAchievementPlayEffect(achievementId)
	self._achievementEffectMap = self._achievementEffectMap or {}
	self._achievementEffectMap[achievementId] = true
end

function AchievementMainCommonModel:isAchievementPlayEffect(achievementId)
	return self._achievementEffectMap and self._achievementEffectMap[achievementId]
end

function AchievementMainCommonModel:markTaskPlayFinishedEffect(taskId)
	self._taskEffectMap = self._taskEffectMap or {}
	self._taskEffectMap[taskId] = true
end

function AchievementMainCommonModel:isTaskPlayFinishedEffect(taskId)
	return self._taskEffectMap and self._taskEffectMap[taskId]
end

function AchievementMainCommonModel:markGroupPlayUpgradeEffect(groupId)
	self._groupUpgradeEffectMap = self._groupUpgradeEffectMap or {}
	self._groupUpgradeEffectMap[groupId] = true
end

function AchievementMainCommonModel:isGroupPlayUpgradeEffect(groupId)
	return self._groupUpgradeEffectMap and self._groupUpgradeEffectMap[groupId]
end

function AchievementMainCommonModel:isCurrentScrollFocusing()
	return self._isCurrentScrollFocusing
end

function AchievementMainCommonModel:markCurrentScrollFocusing(isFocusing)
	self._isCurrentScrollFocusing = isFocusing
end

function AchievementMainCommonModel:checkIsNamePlate()
	return self._curCategory == AchievementEnum.Type.NamePlate
end

AchievementMainCommonModel.instance = AchievementMainCommonModel.New()

return AchievementMainCommonModel
