-- chunkname: @modules/logic/achievement/model/AchievementMainListModel.lua

module("modules.logic.achievement.model.AchievementMainListModel", package.seeall)

local AchievementMainListModel = class("AchievementMainListModel", MixScrollModel)

function AchievementMainListModel:initDatas()
	self._moCacheMap = {}
	self._moGroupMap = {}
	self._infoDict = AchievementConfig.instance:getCategoryAchievementMap()
	self._fitAchievementCfgTab = {}
	self._isCurTaskNeedPlayIdleAnim = false
	self._isNamePlateShowList = true
end

function AchievementMainListModel:refreshTabData(category, sortType, filterType, categoryAchievementCfgs)
	local moList = self:getAchievementMOList(category, sortType, filterType)

	if not moList then
		local fitAchievements = self:getFitCategoryAchievementCfgs(category, filterType, categoryAchievementCfgs)
		local sortFunction = self:getSortFunction(sortType)

		table.sort(fitAchievements, sortFunction)

		moList = self:buildAchievementMOList(filterType, sortType, fitAchievements)
		self._moCacheMap[category][sortType][filterType] = moList
	end

	local filterMOList = self:filterFolderAchievement(moList)

	self:setList(filterMOList)
end

function AchievementMainListModel:getAchievementMOList(category, sortType, filterType)
	self._moCacheMap[category] = self._moCacheMap[category] or {}
	self._moCacheMap[category][sortType] = self._moCacheMap[category][sortType] or {}

	return self._moCacheMap[category][sortType][filterType]
end

function AchievementMainListModel:getFitCategoryAchievementCfgs(category, filterType, categoryAchievementCfgs)
	self._fitAchievementCfgTab = self._fitAchievementCfgTab or {}

	if self._fitAchievementCfgTab then
		local fitAchievements = self._fitAchievementCfgTab[category]

		if categoryAchievementCfgs and not fitAchievements then
			fitAchievements = {}

			for _, achievementCfg in ipairs(categoryAchievementCfgs) do
				for _, filterType in pairs(AchievementEnum.SearchFilterType) do
					local filterFunction = self:getSearchFilterFunction(filterType)

					fitAchievements[filterType] = fitAchievements[filterType] or {}

					if filterFunction and filterFunction(self, achievementCfg) and AchievementUtils.isShowByAchievementCfg(achievementCfg) then
						table.insert(fitAchievements[filterType], achievementCfg)
					end
				end
			end

			self._fitAchievementCfgTab[category] = fitAchievements
		end

		return self._fitAchievementCfgTab[category][filterType]
	end
end

function AchievementMainListModel:getSearchFilterFunction(filterType)
	self._searchFilterFuncMap = self._searchFilterFuncMap or {
		[AchievementEnum.SearchFilterType.Unlocked] = self.filterAchievementByUnlocked,
		[AchievementEnum.SearchFilterType.Locked] = self.filterAchievementByLocked,
		[AchievementEnum.SearchFilterType.All] = self.filterAchievementByAll
	}

	return self._searchFilterFuncMap[filterType]
end

function AchievementMainListModel:filterAchievementByAll(achievementCfg)
	return true
end

function AchievementMainListModel:filterAchievementByUnlocked(achievementCfg)
	local isFit = AchievementModel.instance:achievementHasLocked(achievementCfg.id)

	return not isFit
end

function AchievementMainListModel:filterAchievementByLocked(achievementCfg)
	local taskCfg = AchievementConfig.instance:getAchievementMaxLevelTask(achievementCfg.id)
	local taskId = taskCfg and taskCfg.id
	local isTaskFinished = AchievementModel.instance:isAchievementTaskFinished(taskId)

	return not isTaskFinished
end

function AchievementMainListModel:buildAchievementMOList(filterType, sortType, achievementCfgList)
	local moList = {}

	if achievementCfgList then
		for _, achievementCfg in ipairs(achievementCfgList) do
			local groupId = achievementCfg.groupId
			local isGroupTop = false
			local mo = AchievementListMO.New()

			if groupId and groupId ~= 0 then
				self._moGroupMap[filterType] = self._moGroupMap[filterType] or {}
				self._moGroupMap[filterType][sortType] = self._moGroupMap[filterType][sortType] or {}

				if not self._moGroupMap[filterType][sortType][groupId] then
					self._moGroupMap[filterType][sortType][groupId] = {}
					isGroupTop = true
				end

				table.insert(self._moGroupMap[filterType][sortType][groupId], mo)
			end

			mo:init(achievementCfg.id, isGroupTop)
			table.insert(moList, mo)
		end
	end

	return moList
end

function AchievementMainListModel:filterFolderAchievement(moList)
	local filterMOList = {}

	if moList then
		for _, v in ipairs(moList) do
			local isFold = v:getIsFold()

			if v.isGroupTop or not isFold then
				table.insert(filterMOList, v)
			end
		end
	end

	return filterMOList
end

function AchievementMainListModel:getSortFunction(sortType)
	self._sortFuncMap = self._sortFuncMap or {
		[AchievementEnum.SortType.RareDown] = self.sortAchievementByRareDown,
		[AchievementEnum.SortType.RareUp] = self.sortAchievementByRareUp
	}

	return self._sortFuncMap[sortType]
end

function AchievementMainListModel.sortAchievementByRareDown(aAchievementCfg, bAchievementCfg)
	local aId = aAchievementCfg and aAchievementCfg.id
	local bId = bAchievementCfg and bAchievementCfg.id
	local aGroupId = aAchievementCfg and aAchievementCfg.groupId
	local bGroupId = bAchievementCfg and bAchievementCfg.groupId

	if aGroupId ~= 0 and bGroupId ~= 0 then
		local aGroupCfg = AchievementConfig.instance:getGroup(aGroupId)
		local bGroupCfg = AchievementConfig.instance:getGroup(bGroupId)

		if aGroupCfg then
			if not aGroupCfg.order then
				local aGroupOrder = 0

				if bGroupCfg then
					if not bGroupCfg.order then
						local bGroupOrder = 0

						if aGroupOrder ~= bGroupOrder then
							return aGroupOrder < bGroupOrder
						end

						if aGroupId ~= bGroupId then
							return aGroupId < bGroupId
						end
					end
				end
			end
		end
	end

	local aLocked = AchievementModel.instance:achievementHasLocked(aId)
	local bLocked = AchievementModel.instance:achievementHasLocked(bId)

	if aLocked ~= bLocked then
		return not aLocked
	end

	return aId < bId
end

function AchievementMainListModel.sortAchievementByRareUp(aAchievementCfg, bAchievementCfg)
	local aId = aAchievementCfg and aAchievementCfg.id
	local bId = bAchievementCfg and bAchievementCfg.id

	if aAchievementCfg.groupId ~= 0 and bAchievementCfg.groupId ~= 0 then
		local aGroupLevel = AchievementModel.instance:getGroupLevel(aAchievementCfg.groupId)
		local bGroupLevel = AchievementModel.instance:getGroupLevel(bAchievementCfg.groupId)

		if aGroupLevel ~= bGroupLevel then
			if aGroupLevel * bGroupLevel == 0 then
				return aGroupLevel ~= 0
			end

			return aGroupLevel < bGroupLevel
		end

		if aAchievementCfg.groupId ~= bAchievementCfg.groupId then
			return aAchievementCfg.groupId < bAchievementCfg.groupId
		end
	end

	local aLevel = AchievementModel.instance:getAchievementLevel(aId)
	local bLevel = AchievementModel.instance:getAchievementLevel(bId)

	if aLevel ~= bLevel then
		if aLevel * bLevel == 0 then
			return aLevel ~= 0
		end

		return aLevel < bLevel
	end

	return aId < bId
end

function AchievementMainListModel:getInfoList(scrollGO)
	local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		local isFold = mo:getIsFold()
		local listItemHeight = mo:getLineHeight(curFilterType, isFold)
		local achievementType = mo:getAchievementType()
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(achievementType, listItemHeight, i)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

function AchievementMainListModel:getAchievementIndexAndScrollPixel(achievementType, dataId)
	local isSucc = false
	local achievementIndex = 0
	local scrollPixel = 0
	local moList = self:getList()

	if moList then
		local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()

		for index, mo in ipairs(moList) do
			local isMatch = mo:isAchievementMatch(achievementType, dataId)

			if not isMatch then
				local listItemHeight = mo:getLineHeight(curFilterType, mo:getIsFold())

				scrollPixel = scrollPixel + listItemHeight
			else
				achievementIndex = index
				isSucc = true

				break
			end
		end
	end

	return isSucc, achievementIndex, scrollPixel
end

function AchievementMainListModel:isCurTaskNeedPlayIdleAnim()
	return self._isCurTaskNeedPlayIdleAnim
end

function AchievementMainListModel:setIsCurTaskNeedPlayIdleAnim(isNeed)
	self._isCurTaskNeedPlayIdleAnim = isNeed
end

function AchievementMainListModel:getCurGroupMoList(groupId)
	local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()
	local curSortType = AchievementMainCommonModel.instance:getCurrentSortType()

	if self._moGroupMap[curFilterType] then
		local sortList = self._moGroupMap[curFilterType][curSortType]

		return sortList and sortList[groupId]
	end
end

function AchievementMainListModel:getCurrentAchievementIds()
	local ids = {}
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		table.insert(ids, mo.id)
	end

	return ids
end

function AchievementMainListModel:setNamePlateShowList(state)
	self._isNamePlateShowList = state
end

function AchievementMainListModel:checkNamePlateShowList()
	return self._isNamePlateShowList
end

AchievementMainListModel.instance = AchievementMainListModel.New()

return AchievementMainListModel
