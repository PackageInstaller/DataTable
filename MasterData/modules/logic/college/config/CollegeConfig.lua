-- chunkname: @modules/logic/college/config/CollegeConfig.lua

module("modules.logic.college.config.CollegeConfig", package.seeall)

local CollegeConfig = class("CollegeConfig", BaseConfig)

function CollegeConfig:reqConfigNames()
	return {
		"college_actor",
		"college_actor_growth",
		"college_entry",
		"college_building",
		"college_building_level",
		"college_location",
		"college_const",
		"college_stage",
		"college_event",
		"college_event_option",
		"college_item",
		"college_reward",
		"college_skill",
		"college_bubble",
		"college_bubble_group",
		"college_bubble_group_step",
		"college_story_node",
		"college_story_theme",
		"college_story_dialog",
		"college_task",
		"college_character",
		"college_character_chain",
		"college_character_state",
		"college_character_camp",
		"college_event_text"
	}
end

function CollegeConfig:onConfigLoaded(configName, configTable)
	local func = self["process_" .. configName]

	if func then
		func(self, configTable)
	end

	if isDebugBuild then
		local inst = CollegeConfigCheck.instance

		func = inst["process_" .. configName]

		if inst["process_" .. configName] then
			func(inst, configTable)
		end
	end
end

function CollegeConfig:process_college_stage(configTable)
	self._sortStageList = {}
	self._sortStageIndexMap = {}

	local sortStageIdList = {}

	for _, stageCo in ipairs(configTable.configList) do
		local nextStageId = stageCo.nextStageId
		local stageIndex = tabletool.indexOf(sortStageIdList, nextStageId) or #sortStageIdList + 1

		table.insert(self._sortStageList, stageIndex, stageCo)
		table.insert(sortStageIdList, stageIndex, stageCo.id)
	end

	for i, stageCo in ipairs(self._sortStageList) do
		self._sortStageIndexMap[stageCo.id] = i
	end
end

function CollegeConfig:process_college_item(configTable)
	self._type2ItemList = {}

	for _, itemCo in ipairs(configTable.configList) do
		local type = itemCo.type

		self._type2ItemList[type] = self._type2ItemList[type] or {}

		table.insert(self._type2ItemList[type], itemCo)
	end
end

function CollegeConfig:process_college_bubble(configTable)
	self._bubbleDict = {}

	for _, bubbleCo in ipairs(configTable.configList) do
		self._bubbleDict[bubbleCo.buildingId] = self._bubbleDict[bubbleCo.buildingId] or {}

		table.insert(self._bubbleDict[bubbleCo.buildingId], bubbleCo)
	end
end

function CollegeConfig:process_college_task(configTable)
	self._stageId2TaskList = {}

	for _, taskCo in ipairs(configTable.configList) do
		local stageId = taskCo.stageId

		self._stageId2TaskList[stageId] = self._stageId2TaskList[stageId] or {}

		table.insert(self._stageId2TaskList[stageId], taskCo)
	end
end

function CollegeConfig:process_college_entry(configTable)
	local tagToBuildingMap = {}

	for i, v in ipairs(lua_college_building.configList) do
		if not string.nilorempty(v.tags) then
			local tags = string.split(v.tags, "#")

			for _, tag in ipairs(tags) do
				GameUtil.setTbValue(tagToBuildingMap, tag, v.id, true)
			end
		end
	end

	for i, v in ipairs(lua_college_location.configList) do
		if not string.nilorempty(v.tags) then
			local tags = string.split(v.tags, "#")

			for _, tag in ipairs(tags) do
				GameUtil.setTbValue(tagToBuildingMap, tag, v.id, true)
			end
		end
	end

	self._entryId2BuildingMap = {}

	for _, entryCo in ipairs(configTable.configList) do
		if not string.nilorempty(entryCo.tags) then
			local tags = string.split(entryCo.tags, "#")

			for _, tag in ipairs(tags) do
				local buildingIds = GameUtil.getTbValue(tagToBuildingMap, tag)

				if buildingIds then
					for buildingId in pairs(buildingIds) do
						GameUtil.setTbValue(self._entryId2BuildingMap, entryCo.id, buildingId, true)
					end
				end
			end
		end
	end
end

function CollegeConfig:process_college_story_node(configTable)
	self._themeId2StoryList = {}

	for _, storyCo in ipairs(configTable.configList) do
		local themeId = storyCo.themeId

		self._themeId2StoryList[themeId] = self._themeId2StoryList[themeId] or {}

		table.insert(self._themeId2StoryList[themeId], storyCo)
	end
end

function CollegeConfig:getConstVal(constId)
	local co = lua_college_const.configDict[constId]

	if not co then
		return "", ""
	end

	return co.value, co.mlvalue
end

function CollegeConfig:getConstNum(constId)
	return tonumber((self:getConstVal(constId))) or 0
end

function CollegeConfig:getStageSortIndex(stageId)
	if self._sortStageIndexMap then
		return self._sortStageIndexMap or 0
	end
end

function CollegeConfig:getItemListByType(type)
	if self._type2ItemList then
		return self._type2ItemList
	end
end

function CollegeConfig:getActorGrowthCost(roleId, level)
	self._allActCostMap = self._allActCostMap or {}

	local actorCostMap = self._allActCostMap[roleId]
	local levelCostTab = actorCostMap and actorCostMap[level]

	if not levelCostTab then
		local growthMap = lua_college_actor_growth.configDict[roleId]
		local growthCo = growthMap and growthMap[level]

		if not growthCo then
			return
		end

		local levelCostStr = growthCo.cost

		levelCostTab = GameUtil.splitString2(levelCostStr, true, "&", ":")
		actorCostMap = actorCostMap or {}
		actorCostMap[level] = levelCostTab
		self._allActCostMap[roleId] = actorCostMap
	end

	return levelCostTab
end

function CollegeConfig:getBuildingUpgradeCost(buildingId, level)
	self._allBuildingCostMap = self._allBuildingCostMap or {}

	local buildingCostMap = self._allBuildingCostMap[buildingId]
	local levelCostTab = buildingCostMap and buildingCostMap[level]

	if not levelCostTab then
		local growthMap = lua_college_building_level.configDict[buildingId]
		local growthCo = growthMap and growthMap[level]

		if not growthCo then
			return
		end

		local upgradeCostStr = growthCo and growthCo.upgradeCost

		levelCostTab = GameUtil.splitString2(upgradeCostStr, true, "&", ":")
		buildingCostMap = buildingCostMap or {}
		buildingCostMap[level] = levelCostTab
		self._allBuildingCostMap[buildingId] = buildingCostMap
	end

	return levelCostTab
end

function CollegeConfig:getItemConfig(itemId)
	local itemCo = lua_college_item.configDict[itemId]

	if not itemCo then
		logError(string.format("指挥部道具配置不存在 itemId = %s", itemId))
	end

	return itemCo
end

function CollegeConfig:getTaskListByStageId(stageId)
	return self._stageId2TaskList and self._stageId2TaskList[stageId]
end

function CollegeConfig:getBuildingSlotInfo(buildingId)
	if self._slotUpdateMap then
		local slotUpdateInfo = self._slotUpdateMap[buildingId]

		if not self._slotUpdateMap then
			local maxSlotNum = 0
			local slotNumUpdateMap = {}
			local levelList = lua_college_building_level.configDict[buildingId]

			for _, levelCo in ipairs(levelList or {}) do
				local slotNum = levelCo.slots

				if maxSlotNum < slotNum then
					for i = maxSlotNum + 1, slotNum do
						slotNumUpdateMap[i] = levelCo.level
					end

					maxSlotNum = slotNum
				end
			end

			slotUpdateInfo = {
				maxSlotNum = maxSlotNum,
				slotNumUpdateMap = slotNumUpdateMap
			}
			self._slotUpdateMap = self._slotUpdateMap or {}
			self._slotUpdateMap[buildingId] = self._slotUpdateMap
		end

		return self._slotUpdateMap
	end
end

function CollegeConfig:getBuildingMaxLvConfig(buildingId)
	local levelMap = lua_college_building_level.configDict[buildingId]

	return levelMap and levelMap[#levelMap]
end

function CollegeConfig:isAnyEntryTendencyBuilding(entryMoList, buildingId)
	if not entryMoList then
		return false
	end

	for _, entryMo in ipairs(entryMoList) do
		if self:isEntryTendencyBuilding(entryMo.id, buildingId) then
			return true
		end
	end

	return false
end

function CollegeConfig:isEntryTendencyBuilding(entryId, buildingId)
	return GameUtil.getTbValue(self._entryId2BuildingMap, entryId, buildingId) or false
end

function CollegeConfig:process_college_character_camp(configTable)
	self._campLocationMap = {}

	for i, v in ipairs(configTable.configList) do
		if v.location > 0 then
			self._campLocationMap[v.location] = v.id
		end
	end
end

function CollegeConfig:process_college_character_chain(configTable)
	self._page1ChainStateList = {}

	for i, v in ipairs(configTable.configList) do
		for _, stateId in ipairs(v.stateId) do
			if v.id < CollegeEnum.Page2_ChainId then
				self._page1ChainStateList[stateId] = true
			elseif self._page1ChainStateList[stateId] then
				logError("CollegeConfig page2 chain stateId repeat:" .. stateId)
			end
		end
	end
end

function CollegeConfig:process_college_character_state(configTable)
	self._characterFirstStateList = {}
	self._characterLastStateList = {}
	self._characterPosMap = {}
	self._characterFirstStateList2 = {}
	self._characterLastStateList2 = {}
	self._characterPosMap2 = {}

	for i, v in ipairs(configTable.configList) do
		if self._page1ChainStateList then
			local isPage1 = self._page1ChainStateList[v.stateId]

			if isPage1 then
				if not self._characterPosMap then
					local _characterPosMap = self._characterPosMap2

					if isPage1 then
						if not self._characterFirstStateList then
							local _characterFirstStateList = self._characterFirstStateList2

							if isPage1 then
								if not self._characterLastStateList then
									local _characterLastStateList = self._characterLastStateList2
									local chaId = tonumber(v.chaId)

									if SLFramework.FrameworkSettings.IsEditor then
										if _characterPosMap[chaId] and _characterPosMap[chaId] ~= v.positionId then
											logError(string.format("CollegeConfig _initCharacterState chaId:%s stateId:%s oldPos:%s newPos:%s", chaId, v.stateId, _characterPosMap[chaId], v.positionId))
										end

										if #v.relationshipCha ~= #v.relationshipTxt then
											logError(string.format("CollegeConfig _initCharacterState stateId:%s relationshipCha:%s relationshipTxt:%s 长度不一致", v.stateId, #v.relationshipCha, #v.relationshipTxt))
										end
									end

									_characterPosMap[chaId] = v.positionId
									_characterFirstStateList[chaId] = _characterFirstStateList[chaId] or v.stateId

									if not _characterLastStateList[chaId] then
										_characterLastStateList[chaId] = v
									elseif #v.chaTxt > #_characterLastStateList[chaId].chaTxt then
										_characterLastStateList[chaId] = v
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function CollegeConfig:getCampByLocation(location)
	return self._campLocationMap and self._campLocationMap[location]
end

function CollegeConfig:getCharacterPos(stateId, chaId)
	if self._page1ChainStateList and self._page1ChainStateList[stateId] then
		return self._characterPosMap and self._characterPosMap[chaId]
	end

	return self._characterPosMap2 and self._characterPosMap2[chaId]
end

function CollegeConfig:getCharacterLastShowState(stateId, chaId)
	if self._page1ChainStateList and self._page1ChainStateList[stateId] then
		if self._characterLastStateList then
			local config = self._characterLastStateList[chaId]

			return (config or nil) and (config.stateId or 0)
		end
	end

	if self._characterLastStateList2 then
		local config = self._characterLastStateList2[chaId]

		return (config or nil) and (config.stateId or 0)
	end
end

function CollegeConfig:getCharacterFirstShowState(stateId, chaId)
	if self._page1ChainStateList and self._page1ChainStateList[stateId] then
		return self._characterFirstStateList and self._characterFirstStateList[chaId]
	end

	return self._characterFirstStateList2 and self._characterFirstStateList2[chaId]
end

function CollegeConfig:getStoryListByThemeId(themeId)
	return self._themeId2StoryList and self._themeId2StoryList[themeId]
end

function CollegeConfig:getBubbleByBuildingId(buildingId)
	return self._bubbleDict[buildingId] or {}
end

CollegeConfig.instance = CollegeConfig.New()

return CollegeConfig
