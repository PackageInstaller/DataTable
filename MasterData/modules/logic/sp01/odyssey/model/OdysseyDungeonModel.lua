-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyDungeonModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyDungeonModel", package.seeall)

local OdysseyDungeonModel = class("OdysseyDungeonModel", BaseModel)

function OdysseyDungeonModel:onInit()
	self:reInit()
end

function OdysseyDungeonModel:reInit()
	self.finishElementMap = {}
	self.hasFinishElementMap = {}
	self.newElementList = {}
	self.isDraggingMap = false
	self.isInMapSelectState = false
	self.needFocusMainMapSelectItem = false
	self.curInElementId = 0
	self.mapInfoTab = {}
	self.curElementMoTab = {}
	self.jumpNeedOpenElement = 0
	self.storyOptionParam = nil
	self.elementFightParam = nil
	self.curFightEpisodeId = nil
	self.curMapId = nil
end

function OdysseyDungeonModel:updateMapInfo(mapInfo)
	self:setMapInfo(mapInfo.maps)
	self:setCurInElementId(mapInfo.currEleId)
	self:setMapElementInfo(mapInfo)
end

function OdysseyDungeonModel:setCurInElementId(elementId)
	self.curInElementId = elementId
end

function OdysseyDungeonModel:getCurInElementId()
	return self.curInElementId
end

function OdysseyDungeonModel:setMapInfo(mapsInfo)
	for index, mapInfo in ipairs(mapsInfo) do
		local mapMo = self.mapInfoTab[mapInfo.id]

		if not mapMo then
			mapMo = OdysseyMapMo.New()

			mapMo:init(mapInfo.id)

			self.mapInfoTab[mapInfo.id] = mapMo
		end

		mapMo:updateInfo(mapInfo)
	end

	self.mapInfoList = {}

	for mapId, mapMo in pairs(self.mapInfoTab) do
		table.insert(self.mapInfoList, mapMo)
	end

	table.sort(self.mapInfoList, function(a, b)
		return a.id < b.id
	end)
end

function OdysseyDungeonModel:getMapInfo(mapId)
	return self.mapInfoTab[mapId]
end

function OdysseyDungeonModel:getMapInfoList()
	return self.mapInfoList
end

function OdysseyDungeonModel:setMapElementInfo(mapInfo)
	for _, elementId in ipairs(mapInfo.finishedEleIds) do
		self:setHasFinishElementMap(elementId)
	end

	self:setAllElementInfo(mapInfo.elements)
end

function OdysseyDungeonModel:setHasFinishElementMap(elementId)
	self.hasFinishElementMap[elementId] = true
end

function OdysseyDungeonModel:setFinishElementMap(elementId)
	self.finishElementMap[elementId] = true
end

function OdysseyDungeonModel:setAllElementInfo(elementInfos)
	for _, elementInfo in ipairs(elementInfos) do
		self:updateElementInfo(elementInfo)
	end
end

function OdysseyDungeonModel:updateElementInfo(elementInfo)
	local elementMo = self.curElementMoTab[elementInfo.id]

	if not elementMo then
		elementMo = OdysseyElementMo.New()

		elementMo:init(elementInfo.id)

		self.curElementMoTab[elementInfo.id] = elementMo
	end

	elementMo:updateInfo(elementInfo)
end

function OdysseyDungeonModel:getElementMo(elementId)
	return self.curElementMoTab[elementId]
end

function OdysseyDungeonModel:getNewElementList()
	return self.newElementList
end

function OdysseyDungeonModel:cleanNewElements()
	self.newElementList = {}
end

function OdysseyDungeonModel:addNewElement(elementInfos)
	for _, elementInfo in ipairs(elementInfos) do
		if elementInfo.status == OdysseyEnum.ElementStatus.Normal then
			local elementCo = OdysseyConfig.instance:getElementConfig(elementInfo.id)

			table.insert(self.newElementList, elementCo)
		end
	end
end

function OdysseyDungeonModel:setDraggingMapState(isDragging)
	self.isDraggingMap = isDragging
end

function OdysseyDungeonModel:getDraggingMapState()
	return self.isDraggingMap
end

function OdysseyDungeonModel:setCurMapId(mapId)
	self.curMapId = mapId
end

function OdysseyDungeonModel:getCurMapId()
	return self.curMapId or self:getHeroInMapId()
end

function OdysseyDungeonModel:getHeroInMapId()
	local elementCo = OdysseyConfig.instance:getElementConfig(self.curInElementId)

	return (elementCo or nil) and (elementCo.mapId or 1)
end

function OdysseyDungeonModel:getElemenetInMapId(elementId)
	local elementCo = OdysseyConfig.instance:getElementConfig(elementId)

	return (elementCo or nil) and (elementCo.mapId or 0)
end

function OdysseyDungeonModel:getCurAllElementCoList(mapId)
	local curElementsList = {}

	for elementId, elementMo in pairs(self.curElementMoTab) do
		if self:checkElementCanShow(mapId, elementId) then
			table.insert(curElementsList, elementMo.config)
		end
	end

	return curElementsList
end

function OdysseyDungeonModel:checkElementCanShow(mapId, elementId)
	local isElementFinish = self:isElementFinish(elementId)
	local elementMo = self.curElementMoTab[elementId]
	local var_26_0

	if elementMo then
		::label_26_0::

		var_26_0 = elementMo.config and elementMo.config.mapId == mapId and not isElementFinish
	end

	return var_26_0
end

function OdysseyDungeonModel:getCurMainElement()
	for mapId, mapMo in pairs(self.mapInfoTab) do
		local elementList = self:getCurAllElementCoList(mapId)

		for index, elementCo in ipairs(elementList) do
			if elementCo.main == OdysseyEnum.DungeonMainElement then
				return mapMo.config, elementCo
			end
		end
	end
end

function OdysseyDungeonModel:isElementFinish(elementId)
	return self.finishElementMap[elementId]
end

function OdysseyDungeonModel:setLastElementFightParam(param)
	self.elementFightParam = {}
	self.elementFightParam.lastEpisodeId = param.episodeId
	self.elementFightParam.lastElementId = param.elementId

	self:setCurFightEpisodeId(param.episodeId)
end

function OdysseyDungeonModel:getLastElementFightParam()
	return self.elementFightParam
end

function OdysseyDungeonModel:cleanLastElementFightParam()
	self.elementFightParam = nil
end

function OdysseyDungeonModel:setCurFightEpisodeId(episodeId)
	self.curFightEpisodeId = episodeId
end

function OdysseyDungeonModel:getCurFightEpisodeId()
	return self.curFightEpisodeId
end

function OdysseyDungeonModel:checkConditionCanUnlock(conditionStr)
	local canUnlock = true

	if string.nilorempty(conditionStr) then
		return canUnlock
	end

	local unlockInfoParam = {}
	local unlockConditionList = GameUtil.splitString2(conditionStr)

	for index, conditionData in ipairs(unlockConditionList) do
		if conditionData[1] == OdysseyEnum.ConditionType.Time then
			local offsetTime = tonumber(conditionData[2])
			local activityInfoMo = ActivityModel.instance:getActMO(VersionActivity2_9Enum.ActivityId.Dungeon2)

			if activityInfoMo then
				local startTime = activityInfoMo:getRealStartTimeStamp()
				local openTime = startTime + offsetTime * TimeUtil.OneDaySecond
				local remainTimeStamp = openTime - ServerTime.now()

				if remainTimeStamp > 0 then
					canUnlock = false
				end

				unlockInfoParam = {
					type = conditionData[1],
					remainTimeStamp = remainTimeStamp
				}
			else
				canUnlock = false
				unlockInfoParam = {
					remainTimeStamp = 0,
					type = conditionData[1]
				}
			end
		elseif conditionData[1] == OdysseyEnum.ConditionType.Finish then
			if not self:isElementFinish(tonumber(conditionData[2])) then
				canUnlock = false
			end

			unlockInfoParam = {
				type = conditionData[1],
				elementId = tonumber(conditionData[2])
			}
		elseif conditionData[1] == conditionData[1] == OdysseyEnum.ConditionType.FinishOption then
			if not self:isElementFinish(tonumber(conditionData[2])) then
				canUnlock = false
			end

			unlockInfoParam = {
				type = conditionData[1],
				elementId = tonumber(conditionData[2])
			}
		elseif conditionData[1] == OdysseyEnum.ConditionType.Level then
			local heroLevel = OdysseyModel.instance:getHeroCurLevelAndExp()

			if heroLevel < tonumber(conditionData[2]) then
				canUnlock = false
			end

			unlockInfoParam = {
				type = conditionData[1],
				heroLevel = heroLevel,
				unlockLevel = tonumber(conditionData[2])
			}
		elseif conditionData[1] == OdysseyEnum.ConditionType.Item then
			local itemId, itemCount = tonumber(conditionData[2]), tonumber(conditionData[3])
			local curItemCount = OdysseyItemModel.instance:getItemCount(itemId)

			if curItemCount < itemCount then
				canUnlock = false
			end

			unlockInfoParam = {
				type = conditionData[1],
				curItemCount = curItemCount,
				itemId = tonumber(conditionData[2]),
				unlockItemCount = tonumber(conditionData[3])
			}
		end

		if not canUnlock then
			break
		end
	end

	return canUnlock, unlockInfoParam
end

function OdysseyDungeonModel:getCurMercenaryElements()
	local mercenaryElementMoList = {}

	for index, elementMo in pairs(self.curElementMoTab) do
		if not elementMo.config then
			logError(elementMo.id .. "元件配置不存在")
		end

		if elementMo.config and elementMo.config.type == OdysseyEnum.ElementType.Fight and not elementMo:isFinish() then
			local fightElementConfig = OdysseyConfig.instance:getElementFightConfig(elementMo.id)

			if fightElementConfig and fightElementConfig.type == OdysseyEnum.FightType.Mercenary then
				table.insert(mercenaryElementMoList, elementMo)
			end
		end
	end

	return mercenaryElementMoList
end

function OdysseyDungeonModel:getMercenaryElementsByMap(mapId)
	local mapMercenaryEleMoList = {}
	local allMercenaryEleMoList = self:getCurMercenaryElements()

	for _, elementMo in ipairs(allMercenaryEleMoList) do
		if elementMo.config.mapId == mapId then
			table.insert(mapMercenaryEleMoList, elementMo)
		end
	end

	return mapMercenaryEleMoList
end

function OdysseyDungeonModel:getMapFightElementMoList(mapId, fightType)
	local mapFightElementMoList = {}

	for _, elementMo in pairs(self.curElementMoTab) do
		if elementMo.config.type == OdysseyEnum.ElementType.Fight and elementMo.config.mapId == mapId then
			local fightElementConfig = OdysseyConfig.instance:getElementFightConfig(elementMo.id)

			if fightElementConfig and fightElementConfig.type == fightType then
				table.insert(mapFightElementMoList, elementMo)
			end
		end
	end

	return mapFightElementMoList
end

function OdysseyDungeonModel:getMapNotFinishFightElementMoList(mapId, fightType)
	local mapFightElementMoList = {}

	for _, elementMo in pairs(self.curElementMoTab) do
		if elementMo.config.type == OdysseyEnum.ElementType.Fight and elementMo.config.mapId == mapId then
			local fightElementConfig = OdysseyConfig.instance:getElementFightConfig(elementMo.id)
			local isFinish = self:isElementFinish(elementMo.id)

			if fightElementConfig and fightElementConfig.type == fightType and not isFinish then
				table.insert(mapFightElementMoList, elementMo)
			end
		end
	end

	return mapFightElementMoList
end

function OdysseyDungeonModel:setIsMapSelect(state)
	self.isInMapSelectState = state
end

function OdysseyDungeonModel:getIsInMapSelectState()
	return self.isInMapSelectState
end

function OdysseyDungeonModel:setNeedFocusMainMapSelectItem(state)
	self.needFocusMainMapSelectItem = state
end

function OdysseyDungeonModel:getNeedFocusMainMapSelectItem()
	return self.needFocusMainMapSelectItem
end

function OdysseyDungeonModel:setJumpNeedOpenElement(elementId)
	self.jumpNeedOpenElement = elementId
end

function OdysseyDungeonModel:getJumpNeedOpenElement()
	return self.jumpNeedOpenElement
end

function OdysseyDungeonModel:setStoryOptionParam(param)
	self.storyOptionParam = param
end

function OdysseyDungeonModel:getStoryOptionParam()
	return self.storyOptionParam
end

function OdysseyDungeonModel:getMapRes(mapId)
	local mapConfig = OdysseyConfig.instance:getDungeonMapConfig(mapId)

	return mapConfig.res
end

function OdysseyDungeonModel:getMythCoMyMapId(mapId)
	local mythConfigList = OdysseyConfig.instance:getMythConfigList()

	for index, mythCo in ipairs(mythConfigList) do
		local elementMapId = self:getElemenetInMapId(mythCo.elementId)

		if elementMapId == mapId then
			return mythCo
		end
	end
end

function OdysseyDungeonModel:checkHasFightTypeElement(fightElementType)
	for index, elementMo in pairs(self.curElementMoTab) do
		if elementMo.config and elementMo.config.type == OdysseyEnum.ElementType.Fight then
			local fightElementConfig = OdysseyConfig.instance:getElementFightConfig(elementMo.id)

			if fightElementConfig and fightElementConfig.type == fightElementType then
				return true
			end
		end
	end

	return false
end

function OdysseyDungeonModel:getCanAutoExposeReligionCoList()
	local canAutoExposeList = {}
	local religionCoList = OdysseyConfig.instance:getReligionConfigList()

	for index, religionCo in ipairs(religionCoList) do
		if religionCo.autoExpose == 1 then
			local religionInfo = OdysseyModel.instance:getReligionInfoData(religionCo.id)

			if not religionInfo then
				table.insert(canAutoExposeList, religionCo)
			end
		end
	end

	return canAutoExposeList
end

function OdysseyDungeonModel:checkHasNewUnlock(key, curUnlockIdList)
	local curSaveStrList = self:getCurSaveLocalNewUnlock(key)
	local newUnlockIdList = {}

	for index, id in ipairs(curUnlockIdList) do
		if not tabletool.indexOf(curSaveStrList, id) then
			table.insert(newUnlockIdList, id)
		end
	end

	return #newUnlockIdList > 0, newUnlockIdList
end

function OdysseyDungeonModel:saveLocalCurNewLock(key, curUnlockIdList)
	local curSaveStrList = self:getCurSaveLocalNewUnlock(key)
	local newSaveIdList = curSaveStrList

	for index, id in ipairs(curUnlockIdList) do
		if not tabletool.indexOf(curSaveStrList, id) then
			table.insert(newSaveIdList, id)
		end
	end

	OdysseyDungeonController.instance:setPlayerPrefs(key, table.concat(newSaveIdList, "#"))
end

function OdysseyDungeonModel:getCurSaveLocalNewUnlock(key)
	local saveLocalStr = OdysseyDungeonController.instance:getPlayerPrefs(key, "")

	return (not string.nilorempty(saveLocalStr) or nil) and string.splitToNumber(saveLocalStr, "#")
end

function OdysseyDungeonModel:getCurUnlockMythIdList()
	local curUnlockMythIdList = {}
	local mythConfigList = OdysseyConfig.instance:getMythConfigList()

	for index, mythCo in ipairs(mythConfigList) do
		if self:getElementMo(mythCo.elementId) then
			table.insert(curUnlockMythIdList, mythCo.id)
		end
	end

	return curUnlockMythIdList
end

function OdysseyDungeonModel:getCurUnlockMapIdList()
	local curUnlockMapIdList = {}
	local mapConfigList = OdysseyConfig.instance:getAllDungeonMapCoList()

	for index, mapCo in ipairs(mapConfigList) do
		if self:getMapInfo(mapCo.id) then
			table.insert(curUnlockMapIdList, mapCo.id)
		end
	end

	return curUnlockMapIdList
end

OdysseyDungeonModel.instance = OdysseyDungeonModel.New()

return OdysseyDungeonModel
