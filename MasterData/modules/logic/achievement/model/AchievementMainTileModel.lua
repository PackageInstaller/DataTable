-- chunkname: @modules/logic/achievement/model/AchievementMainTileModel.lua

module("modules.logic.achievement.model.AchievementMainTileModel", package.seeall)

local AchievementMainTileModel = class("AchievementMainTileModel", ListScrollModel)

function AchievementMainTileModel:initDatas()
	self._moCacheMap = {}
	self._infoDict = AchievementConfig.instance:getCategoryAchievementMap()
	self._groupStateMap = {}
	self._fitAchievementCfgTab = {}
	self._curScrollFocusIndex = 1
	self._hasPlayOpenAnim = false
end

function AchievementMainTileModel:refreshTabData(category, sortType, filterType, categoryAchievementCfgs)
	local moList = self:getAchievementMOList(category, sortType, filterType)

	if not moList then
		local fitAchievements = self:getFitCategoryAchievementCfgs(category, filterType, categoryAchievementCfgs)
		local sortFunction = self:getSortFunction(sortType)

		table.sort(fitAchievements, sortFunction)

		moList = self:buildAchievementMOList(fitAchievements)
		self._moCacheMap[category][sortType][filterType] = moList
	end

	self:setList(moList)
end

function AchievementMainTileModel:getAchievementMOList(category, sortType, filterType)
	self._moCacheMap[category] = self._moCacheMap[category] or {}
	self._moCacheMap[category][sortType] = self._moCacheMap[category][sortType] or {}

	return self._moCacheMap[category][sortType][filterType]
end

function AchievementMainTileModel:getFitCategoryAchievementCfgs(category, filterType, categoryAchievementCfgs)
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

function AchievementMainTileModel:getSearchFilterFunction(filterType)
	self._searchFilterFuncMap = self._searchFilterFuncMap or {
		[AchievementEnum.SearchFilterType.Unlocked] = self.filterAchievementByUnlocked,
		[AchievementEnum.SearchFilterType.Locked] = self.filterAchievementByLocked,
		[AchievementEnum.SearchFilterType.All] = self.filterAchievementByAll
	}

	return self._searchFilterFuncMap[filterType]
end

function AchievementMainTileModel:filterAchievementByAll(achievementCfg)
	return true
end

function AchievementMainTileModel:filterAchievementByUnlocked(achievementCfg)
	local groupId = achievementCfg.groupId
	local isGroup = AchievementUtils.isActivityGroup(achievementCfg.id)
	local isFit = false

	if isGroup then
		if self._groupStateMap[groupId] == nil then
			self._groupStateMap[groupId] = AchievementModel.instance:achievementGroupHasLocked(groupId)
		end

		isFit = not self._groupStateMap[groupId]
	else
		isFit = not AchievementModel.instance:achievementHasLocked(achievementCfg.id)
	end

	return isFit
end

function AchievementMainTileModel:filterAchievementByLocked(achievementCfg)
	local groupId = achievementCfg.groupId
	local isGroup = AchievementUtils.isActivityGroup(achievementCfg.id)
	local isFit = false

	if isGroup then
		if self._groupStateMap[groupId] == nil then
			self._groupStateMap[groupId] = AchievementModel.instance:achievementGroupHasLocked(groupId)
		end

		isFit = self._groupStateMap[groupId]
	else
		isFit = AchievementModel.instance:achievementHasLocked(achievementCfg.id)
	end

	return isFit
end

function AchievementMainTileModel:buildAchievementMOList(achievementCfgList)
	local moList = {}
	local achievementList = {}

	if not achievementCfgList then
		return
	end

	local lastGroupId = 0
	local isGroupTop = true

	for _, cfg in ipairs(achievementCfgList) do
		if lastGroupId == 0 then
			if cfg.groupId ~= 0 or #achievementList >= AchievementEnum.MainListLineCount then
				if #achievementList > 0 then
					self:buildMO(moList, achievementList, lastGroupId)

					achievementList = {}
				end

				lastGroupId = cfg.groupId
			end
		else
			local isBreakLine = cfg.category == AchievementEnum.Type.GamePlay and #achievementList >= AchievementEnum.MainListLineCount
			local isNewGroup = cfg.groupId ~= lastGroupId

			if isNewGroup or isBreakLine then
				self:buildMO(moList, achievementList, lastGroupId, isGroupTop)

				lastGroupId = cfg.groupId
				achievementList = {}
				isGroupTop = not not isNewGroup
			end
		end

		table.insert(achievementList, cfg)
	end

	if #achievementList > 0 then
		self:buildMO(moList, achievementList, lastGroupId, isGroupTop)
	end

	return moList
end

function AchievementMainTileModel:buildMO(moList, achievementList, groupId, isGroupTop)
	local mo = AchievementTileMO.New()

	mo:init(achievementList, groupId, isGroupTop)
	table.insert(moList, mo)
end

function AchievementMainTileModel:getSortFunction(sortType)
	self._sortFuncMap = self._sortFuncMap or {
		[AchievementEnum.SortType.RareDown] = self.sortAchievementByRareDown,
		[AchievementEnum.SortType.RareUp] = self.sortAchievementByRareUp
	}

	return self._sortFuncMap[sortType]
end

function AchievementMainTileModel.sortAchievementByRareDown(a, b)
	local aGroup = a.groupId ~= 0
	local bGroup = b.groupId ~= 0

	if aGroup ~= bGroup then
		return not aGroup
	end

	if aGroup then
		if a.groupId ~= b.groupId then
			local aGroupCfg = AchievementConfig.instance:getGroup(a.groupId)
			local bGroupCfg = AchievementConfig.instance:getGroup(b.groupId)

			if aGroupCfg then
				if not aGroupCfg.order then
					local aGroupOrder = 0

					if bGroupCfg then
						if not bGroupCfg.order then
							local bGroupOrder = 0

							if aGroupOrder ~= bGroupOrder then
								return aGroupOrder < bGroupOrder
							end

							return a.groupId < b.groupId
						end
					end
				end
			end
		end

		if a.order ~= b.order then
			return a.order < b.order
		end
	else
		local aLocked = AchievementModel.instance:achievementHasLocked(a.id)
		local bLocked = AchievementModel.instance:achievementHasLocked(b.id)

		if aLocked ~= bLocked then
			return not aLocked
		end
	end

	return a.id < b.id
end

function AchievementMainTileModel.sortAchievementByRareUp(a, b)
	local aGroup = a.groupId ~= 0
	local bGroup = b.groupId ~= 0

	if aGroup ~= bGroup then
		return not aGroup
	end

	if aGroup then
		if a.groupId ~= b.groupId then
			local aGroupLevel = AchievementModel.instance:getGroupLevel(a.groupId)
			local bGroupLevel = AchievementModel.instance:getGroupLevel(b.groupId)

			if aGroupLevel ~= bGroupLevel then
				if aGroupLevel * bGroupLevel == 0 then
					return aGroupLevel ~= 0
				end

				return aGroupLevel < bGroupLevel
			end

			return a.groupId < b.groupId
		end

		return a.order < b.order
	else
		local aAchievementId = a.id
		local bAchievementId = b.id
		local aLevel = AchievementModel.instance:getAchievementLevel(aAchievementId)
		local bLevel = AchievementModel.instance:getAchievementLevel(bAchievementId)

		if aLevel ~= bLevel then
			if aLevel * aLevel == 0 then
				return aLevel ~= 0
			end

			return aLevel < bLevel
		end

		return aAchievementId < bAchievementId
	end
end

function AchievementMainTileModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		local isFold = mo:getIsFold()
		local listItemHeight = mo:getLineHeight(nil, isFold)
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(mo:getAchievementType(), listItemHeight, i)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

function AchievementMainTileModel:getAchievementIndexAndScrollPixel(achievementType, dataId)
	local isSucc = false
	local achievementIndex = 0
	local scrollPixel = 0
	local moList = self:getList()

	if moList then
		for index, mo in ipairs(moList) do
			local isMatch = mo:isAchievementMatch(achievementType, dataId)

			if not isMatch then
				local lineHeight = mo:getLineHeight()

				scrollPixel = scrollPixel + lineHeight
			else
				achievementIndex = index
				isSucc = true

				break
			end
		end
	end

	return isSucc, achievementIndex, scrollPixel
end

function AchievementMainTileModel:getCurrentAchievementIds()
	local result = {}
	local curCategory = AchievementMainCommonModel.instance:getCurrentCategory()
	local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()
	local fitCategoryCfgs = self:getFitCategoryAchievementCfgs(curCategory, curFilterType)
	local curSortType = AchievementMainCommonModel.instance:getCurrentSortType()
	local sortFunction = self:getSortFunction(curSortType)

	table.sort(fitCategoryCfgs, sortFunction)

	for _, achievementCfg in ipairs(fitCategoryCfgs) do
		table.insert(result, achievementCfg.id)
	end

	return result
end

function AchievementMainTileModel:markTaskHasShowNewEffect(taskId)
	if taskId then
		self._newEffectTaskDict = self._newEffectTaskDict or {}
		self._newEffectTaskDict[taskId] = true
	end
end

function AchievementMainTileModel:isTaskHasShowNewEffect(taskId)
	return self._newEffectTaskDict and self._newEffectTaskDict[taskId]
end

function AchievementMainTileModel:hasPlayOpenAnim()
	return self._hasPlayOpenAnim
end

function AchievementMainTileModel:setHasPlayOpenAnim(hasPlay)
	self._hasPlayOpenAnim = hasPlay
end

function AchievementMainTileModel:markScrollFocusIndex(focusIndex)
	self._curScrollFocusIndex = focusIndex
end

function AchievementMainTileModel:getScrollFocusIndex()
	return self._curScrollFocusIndex
end

function AchievementMainTileModel:resetScrollFocusIndex()
	self._curScrollFocusIndex = nil
end

function AchievementMainTileModel:getCurGroupMoList(groupId)
	local moList = {}

	for _, mo in ipairs(self:getCurMoList()) do
		if mo.groupId == groupId then
			table.insert(moList, mo)
		end
	end

	return moList
end

function AchievementMainTileModel:getCurMoList()
	local category = AchievementMainCommonModel.instance:getCurrentCategory()
	local sortType = AchievementMainCommonModel.instance:getCurrentSortType()
	local filterType = AchievementMainCommonModel.instance:getCurrentFilterType()

	return self:getAchievementMOList(category, sortType, filterType)
end

AchievementMainTileModel.instance = AchievementMainTileModel.New()

return AchievementMainTileModel
