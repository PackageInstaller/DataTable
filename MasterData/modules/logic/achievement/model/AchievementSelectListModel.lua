-- chunkname: @modules/logic/achievement/model/AchievementSelectListModel.lua

module("modules.logic.achievement.model.AchievementSelectListModel", package.seeall)

local AchievementSelectListModel = class("AchievementSelectListModel", ListScrollModel)

function AchievementSelectListModel:initDatas(tabType)
	self._curCategory = tabType or 1
	self.isGroup = false

	self:decodeShowAchievement()

	self.isGroup = self:getGroupSelectedCount() > 0
	self.infoDict = self:packInfos()
	self.moTypeCache = {}
	self.moTypeGroupCache = {}
	self._itemAniHasShownIndex = 0

	self:refreshTabData()
end

function AchievementSelectListModel:release()
	self.moTypeCache = nil
	self.moTypeGroupCache = nil
	self.singleSet = nil
	self.singleSelectList = nil
	self.groupSet = nil
	self.selectSingleCategoryMap = nil
	self.selectGroupCategoryMap = nil
end

function AchievementSelectListModel:packInfos()
	local infoDict = {}

	for category, v in ipairs(AchievementEnum.Type) do
		infoDict[category] = {}
	end

	local allCfgList = AchievementConfig.instance:getAllAchievements()

	for i, cfg in ipairs(allCfgList) do
		infoDict[cfg.category] = infoDict[cfg.category] or {}

		local list = infoDict[cfg.category]

		table.insert(list, cfg)
	end

	return infoDict
end

function AchievementSelectListModel:decodeShowAchievement()
	local showStr = PlayerModel.instance:getShowAchievement()
	local singeTaskSet, groupTaskSet = AchievementUtils.decodeShowStr(showStr)

	self.singleSet = {}
	self.singleSelectList = {}

	for _, taskId in ipairs(singeTaskSet) do
		local taskCO = AchievementConfig.instance:getTask(taskId)

		self.singleSet[taskCO.achievementId] = true

		table.insert(self.singleSelectList, taskCO.achievementId)
		self:updateSingleSelectCategoryMap(taskCO.achievementId, true)
	end

	self.groupSet = {}
	self.groupSelectList = {}

	for _, taskId in pairs(groupTaskSet) do
		local taskCO = AchievementConfig.instance:getTask(taskId)

		if taskCO then
			local achievementCO = AchievementConfig.instance:getAchievement(taskCO.achievementId)

			if AchievementUtils.isActivityGroup(taskCO.achievementId) and not self.groupSet[achievementCO.groupId] then
				self.groupSet[achievementCO.groupId] = true

				table.insert(self.groupSelectList, achievementCO.groupId)
				self:updateGroupSelectCategoryMap(achievementCO.groupId, true)
			end
		end
	end

	self.originSingleSet = tabletool.copy(self.singleSet)
	self.originGroupSet = tabletool.copy(self.groupSet)
	self.originSingleSelectList = tabletool.copy(self.singleSelectList)
	self.originGroupSelectList = tabletool.copy(self.groupSelectList)
end

function AchievementSelectListModel:resumeToOriginSelect()
	self.groupSet = tabletool.copy(self.originGroupSet)
	self.singleSet = tabletool.copy(self.originSingleSet)
	self.singleSelectList = tabletool.copy(self.originSingleSelectList)
	self.groupSelectList = tabletool.copy(self.originGroupSelectList)

	self:buildSelectCategoryMap()
end

function AchievementSelectListModel:buildSelectCategoryMap()
	self.selectSingleCategoryMap = {}
	self.selectGroupCategoryMap = {}

	if self.singleSelectList then
		for _, achievementId in ipairs(self.singleSelectList) do
			self:updateSingleSelectCategoryMap(achievementId, true)
		end
	end

	if self.groupSelectList then
		for _, groupId in ipairs(self.groupSelectList) do
			self:updateGroupSelectCategoryMap(groupId, true)
		end
	end
end

function AchievementSelectListModel:updateSingleSelectCategoryMap(achievementId, isSelect)
	local achievementCfg = AchievementConfig.instance:getAchievement(achievementId)

	if achievementCfg then
		local category = achievementCfg.category

		if isSelect then
			self.selectSingleCategoryMap = self.selectSingleCategoryMap or {}
			self.selectSingleCategoryMap[category] = self.selectSingleCategoryMap[category] or {}
			self.selectSingleCategoryMap[category][achievementId] = true
		elseif not isSelect and self.selectSingleCategoryMap and self.selectSingleCategoryMap[category] then
			self.selectSingleCategoryMap[category][achievementId] = nil
		end
	end
end

function AchievementSelectListModel:updateGroupSelectCategoryMap(groupId, isSelect)
	local groupCfg = AchievementConfig.instance:getGroup(groupId)

	if groupCfg then
		local category = groupCfg.category

		if isSelect then
			self.selectGroupCategoryMap = self.selectGroupCategoryMap or {}
			self.selectGroupCategoryMap[category] = self.selectGroupCategoryMap[category] or {}
			self.selectGroupCategoryMap[category][groupId] = isSelect
		elseif not isSelect and self.selectGroupCategoryMap and self.selectGroupCategoryMap[category] then
			self.selectGroupCategoryMap[category][groupId] = nil
		end
	end
end

function AchievementSelectListModel:setTab(tabType)
	self._curCategory = tabType

	if self:checkIsNamePlate() then
		self.isGroup = true
	end

	self:refreshTabData()
end

function AchievementSelectListModel:setIsSelectGroup(isGroup)
	self.isGroup = isGroup

	self:refreshTabData()
end

function AchievementSelectListModel:refreshTabData()
	if not self.infoDict then
		return
	end

	if self.isGroup then
		if not self.moTypeGroupCache then
			local targetCache = self.moTypeCache
			local moList = targetCache[self._curCategory]

			if not moList then
				moList = self._curCategory == AchievementEnum.Type.NamePlate and self:buildNamePlateMOList(self._curCategory) or self.isGroup and self:buildGroupMOList(self._curCategory) or self:buildSingleMOList(self._curCategory)
				targetCache[self._curCategory] = moList
			end

			self:setList(moList)
		end
	end
end

function AchievementSelectListModel:buildNamePlateMOList(category)
	local moList = {}
	local achievementList = {}
	local targetList = self.infoDict[category]

	if not targetList then
		return moList
	end

	table.sort(targetList, self.sortAchievement)

	for _, cfg in ipairs(targetList) do
		local level = AchievementModel.instance:getAchievementLevel(cfg.id)
		local taskCO = AchievementConfig.instance:getTaskByAchievementLevel(cfg.id, level)

		if level > 0 then
			local mo = {}

			mo.achievementId = cfg.id
			mo.taskCo = taskCO
			mo.maxLevel = level
			mo.taskId = taskCO.id
			mo.co = cfg

			table.insert(achievementList, mo)
		end
	end

	if #achievementList > 0 then
		self:buildMO(moList, achievementList, 0)
	end

	return moList
end

function AchievementSelectListModel:buildSingleMOList(category)
	local moList = {}
	local achievementList = {}
	local targetList = self.infoDict[category]

	if not targetList then
		return moList
	end

	table.sort(targetList, self.sortAchievement)

	for _, cfg in ipairs(targetList) do
		local level = AchievementModel.instance:getAchievementLevel(cfg.id)

		if level > 0 then
			if #achievementList >= AchievementEnum.MainListLineCount then
				self:buildMO(moList, achievementList, 0)

				achievementList = {}
			end

			table.insert(achievementList, cfg)
		end
	end

	if #achievementList > 0 then
		self:buildMO(moList, achievementList, 0)
	end

	return moList
end

function AchievementSelectListModel:buildGroupMOList(category)
	local moList = {}
	local achievementList = {}
	local targetList = self.infoDict[category]

	if not targetList then
		return moList
	end

	table.sort(targetList, self.sortAchievement)

	local lastGroupId = 0

	for _, cfg in ipairs(targetList) do
		if AchievementUtils.isActivityGroup(cfg.id) then
			if lastGroupId ~= cfg.groupId then
				if lastGroupId == 0 then
					lastGroupId = cfg.groupId
				else
					self:buildMO(moList, achievementList, lastGroupId)

					achievementList = {}
					lastGroupId = cfg.groupId
				end
			end

			table.insert(achievementList, cfg)
		end
	end

	if #achievementList > 0 then
		self:buildMO(moList, achievementList, lastGroupId)
	end

	return moList
end

function AchievementSelectListModel:buildMO(moList, achievementList, groupId)
	if groupId ~= 0 then
		local hasFinished = false

		for _, achievementCO in ipairs(achievementList) do
			local level = AchievementModel.instance:getAchievementLevel(achievementCO.id)

			if level > 0 then
				hasFinished = true

				break
			end
		end

		if not hasFinished then
			return
		end
	end

	local mo = AchievementTileMO.New()

	mo:init(achievementList, groupId)
	table.insert(moList, mo)
end

function AchievementSelectListModel.sortAchievement(a, b)
	local aIsSelected = AchievementSelectListModel.instance:checkIsSelected(a)
	local bIsSelected = AchievementSelectListModel.instance:checkIsSelected(b)

	if aIsSelected ~= bIsSelected then
		return aIsSelected
	elseif aIsSelected and bIsSelected then
		local isGroup = AchievementSelectListModel.instance.isGroup

		if isGroup then
			if not AchievementSelectListModel.instance.groupSelectList then
				local sortList = AchievementSelectListModel.instance.singleSelectList

				if not tabletool.indexOf(sortList, (isGroup or nil) and (a.groupId or a.id)) then
					local aOrderIndex = 0

					if not tabletool.indexOf(sortList, (isGroup or nil) and (b.groupId or b.id)) then
						local bOrderIndex = 0

						return aOrderIndex < bOrderIndex
					end
				end
			end
		end
	end

	local aGroup = a.groupId ~= 0
	local bGroup = b.groupId ~= 0

	if aGroup ~= bGroup then
		return not aGroup
	end

	if aGroup then
		if a.groupId ~= b.groupId then
			local aGroupCfg = AchievementConfig.instance:getGroup(a.groupId)
			local bGroupCfg = AchievementConfig.instance:getGroup(b.groupId)

			if aGroupCfg and bGroupCfg and aGroupCfg.order ~= bGroupCfg.order then
				return aGroupCfg.order < bGroupCfg.order
			end

			return a.groupId < b.groupId
		end

		if a.order ~= b.order then
			return a.order < b.order
		end
	end

	return a.id < b.id
end

function AchievementSelectListModel:checkIsSelected(achievementCfg)
	if self.isGroup and achievementCfg.groupId ~= 0 then
		return self:isGroupSelected(achievementCfg.groupId)
	else
		return self.singleSet[achievementCfg.id] == true
	end
end

function AchievementSelectListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(1, mo:getLineHeight(), i)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

function AchievementSelectListModel:isSingleSelected(taskId)
	local taskCO = AchievementConfig.instance:getTask(taskId)

	if taskCO then
		return self.singleSet[taskCO.achievementId]
	end

	return false
end

function AchievementSelectListModel:getSelectOrderIndex(taskId)
	local taskCO = AchievementConfig.instance:getTask(taskId)

	if taskCO then
		return tabletool.indexOf(self.singleSelectList, taskCO.achievementId)
	end
end

function AchievementSelectListModel:isGroupSelected(groupId)
	return self.groupSet[groupId]
end

function AchievementSelectListModel:getSingleSelectedCount()
	return tabletool.len(self.singleSet) - self:getNamePlateSelectedCount()
end

function AchievementSelectListModel:getGroupSelectedCount()
	return tabletool.len(self.groupSet) + self:getNamePlateSelectedCount()
end

function AchievementSelectListModel:getNamePlateSelectedCount()
	return self:getSelectCountByCategory(AchievementEnum.Type.NamePlate)
end

function AchievementSelectListModel:setSingleSelect(taskId, isSelect)
	local taskCO = AchievementConfig.instance:getTask(taskId)

	if not taskCO then
		return
	end

	tabletool.removeValue(self.singleSelectList, taskCO.achievementId)

	if isSelect then
		self.singleSet[taskCO.achievementId] = true

		table.insert(self.singleSelectList, taskCO.achievementId)
	else
		self.singleSet[taskCO.achievementId] = nil
	end

	self:updateSingleSelectCategoryMap(taskCO.achievementId, isSelect)
end

function AchievementSelectListModel:setGroupSelect(groupId, isSelect)
	tabletool.removeValue(self.groupSelectList, groupId)

	if isSelect then
		self.groupSet[groupId] = true

		table.insert(self.groupSelectList, groupId)
	else
		self.groupSet[groupId] = nil
	end

	self:updateGroupSelectCategoryMap(groupId, isSelect)
end

function AchievementSelectListModel:getSaveRequestParam()
	local taskIdList = {}
	local groupIdResult = 0

	if self.isGroup and not self:checkIsNamePlate() then
		for _, groupId in ipairs(self.groupSelectList) do
			self:fillGroupTaskIds(taskIdList, groupId)

			groupIdResult = groupId
		end
	else
		for _, achievementId in ipairs(self.singleSelectList) do
			self:fillSingleTaskId(taskIdList, achievementId)
		end
	end

	return taskIdList, groupIdResult
end

function AchievementSelectListModel:getCurrentCategory()
	return self._curCategory
end

function AchievementSelectListModel:checkIsNamePlate()
	return self._curCategory == AchievementEnum.Type.NamePlate
end

function AchievementSelectListModel:fillGroupTaskIds(taskIdList, groupId)
	local achievementCOs = AchievementConfig.instance:getAchievementsByGroupId(groupId)

	for _, achievementCO in ipairs(achievementCOs) do
		self:fillSingleTaskId(taskIdList, achievementCO.id)
	end
end

function AchievementSelectListModel:fillSingleTaskId(taskIdList, achievementId)
	local level = AchievementModel.instance:getAchievementLevel(achievementId)

	if level > 0 then
		local taskCO = AchievementConfig.instance:getTaskByAchievementLevel(achievementId, level)

		if taskCO ~= nil then
			table.insert(taskIdList, taskCO.id)
		end
	end
end

function AchievementSelectListModel:checkDirty(isGroup)
	if isGroup then
		if tabletool.len(self.groupSet) == tabletool.len(self.originGroupSet) then
			for k, v in pairs(self.groupSet) do
				if v ~= self.originGroupSet[k] then
					return true
				end
			end
		else
			return true
		end
	elseif #self.singleSelectList == #self.originSingleSelectList then
		for k, v in ipairs(self.singleSelectList) do
			if v ~= self.originSingleSelectList[k] then
				return true
			end
		end
	else
		return true
	end

	return false
end

function AchievementSelectListModel:clearAllSelect()
	self.singleSet = {}
	self.singleSelectList = {}
	self.groupSet = {}
	self.groupSelectList = {}
	self.selectSingleCategoryMap = {}
	self.selectGroupCategoryMap = {}
end

function AchievementSelectListModel:clearNamePlateAllSelect()
	if self.selectSingleCategoryMap then
		local list = self.selectSingleCategoryMap[AchievementEnum.Type.NamePlate]

		if list then
			for id in pairs(list) do
				tabletool.removeValue(self.singleSelectList, id)

				self.singleSet[id] = nil
			end

			self.selectSingleCategoryMap[AchievementEnum.Type.NamePlate] = nil
		end
	end
end

function AchievementSelectListModel:getSelectCount()
	if self.isGroup then
		return self.groupSet and tabletool.len(self.groupSet) or 0
	else
		return self.singleSet and tabletool.len(self.singleSet) or 0
	end
end

function AchievementSelectListModel:getSelectCountByCategory(category)
	if self.isGroup then
		if not self.selectGroupCategoryMap then
			local selectMap = self.selectSingleCategoryMap

			if category == AchievementEnum.Type.NamePlate then
				selectMap = self.selectSingleCategoryMap
			end

			local categoryMap = selectMap and selectMap[category]

			return categoryMap and tabletool.len(categoryMap) or 0
		end
	end
end

function AchievementSelectListModel:getItemAniHasShownIndex()
	return self._itemAniHasShownIndex
end

function AchievementSelectListModel:setItemAniHasShownIndex(index)
	self._itemAniHasShownIndex = index or 0
end

AchievementSelectListModel.instance = AchievementSelectListModel.New()

return AchievementSelectListModel
