-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/model/HuiDiaoLanGameModel.lua

module("modules.logic.versionactivity3_2.huidiaolan.model.HuiDiaoLanGameModel", package.seeall)

local HuiDiaoLanGameModel = class("HuiDiaoLanGameModel", BaseModel)

function HuiDiaoLanGameModel:onInit()
	self.winStateMap = {}
end

function HuiDiaoLanGameModel:reInit()
	self:reInitData()

	self.winStateMap = {}
end

function HuiDiaoLanGameModel:reInitData()
	self.planeDataMap = {}
	self.elementDataMap = {}
	self.createRandomElementDataList = {}
	self.createRandomElementPosList = {}
	self.emptyPlaneList = {}
	self.gameInfoData = {}
	self.spPlanePosIndexList = {}
end

function HuiDiaoLanGameModel:initConfigData(mapId)
	self:reInitData()

	local mapData = addGlobalModule("modules.configs.huidiaolan.lua_huidiaolan_map_" .. tostring(mapId))

	self.gameInfoData = mapData.gameConfig

	for _, elementCo in ipairs(mapData.elementConfig) do
		self:createElement(elementCo.posIndex, elementCo)
	end

	for _, planeCo in ipairs(mapData.planeConfig) do
		local indexList = string.split(planeCo.posIndexList, "|")

		if not self.planeDataMap[planeCo.id] then
			self.planeDataMap[planeCo.id] = {}
			self.spPlanePosIndexList[planeCo.id] = {}
		end

		self.spPlanePosIndexList[planeCo.id] = {
			indexList = indexList,
			planeType = planeCo.planeType
		}

		for index, indexStr in ipairs(indexList) do
			local planeData = {}

			planeData.planeType = planeCo.planeType
			planeData.posIndexList = indexList
			planeData.param = planeCo.param
			planeData.spIndex = index
			self.planeDataMap[planeCo.id][indexStr] = planeData
		end
	end

	self.gameInfoData.planeItemWidth = Mathf.Floor(HuiDiaoLanEnum.PlaneSize / self.gameInfoData.planeWidthCount)
	self.gameInfoData.planeItemHeight = Mathf.Floor(HuiDiaoLanEnum.PlaneSize / self.gameInfoData.planeHeightCount)
	self.gameInfoData.planeWidth = self.gameInfoData.planeWidthCount * self.gameInfoData.planeItemWidth + (self.gameInfoData.planeWidthCount - 1) * HuiDiaoLanEnum.PlaneSpace
	self.gameInfoData.planeHeight = self.gameInfoData.planeHeightCount * self.gameInfoData.planeItemHeight + (self.gameInfoData.planeHeightCount - 1) * HuiDiaoLanEnum.PlaneSpace

	local curEpisodeId = HuiDiaoLanModel.instance:getCurEpisodeId()
	local episodeConfig = HuiDiaoLanConfig.instance:getEpisodeConfig(curEpisodeId)

	self.gameInfoData.isSpEpisode = episodeConfig.type == HuiDiaoLanEnum.SpEpisodeType
	self.changeColorSkillState = false
	self.exchangePosSkillState = false
	self.changeColorSkillisCd = false
	self.exchangePosSkillisCd = false
end

function HuiDiaoLanGameModel:createElement(posIndex, data)
	local elementData = self.elementDataMap[posIndex]

	if not data then
		self.elementDataMap[posIndex] = nil

		return
	end

	elementData = elementData or {}
	elementData.posIndex = posIndex
	elementData.color = data.color
	elementData.level = data.level
	self.elementDataMap[posIndex] = elementData
end

function HuiDiaoLanGameModel:updateElementDataMap(elementDataMap)
	self.elementDataMap = elementDataMap
end

function HuiDiaoLanGameModel:getGameInfoData()
	return self.gameInfoData
end

function HuiDiaoLanGameModel:getAllElementData()
	return self.elementDataMap
end

function HuiDiaoLanGameModel:getElementData(posIndex)
	return self.elementDataMap[posIndex]
end

function HuiDiaoLanGameModel:cleanElement(posIndex)
	self.elementDataMap[posIndex] = nil
end

function HuiDiaoLanGameModel:checkAndGetSpPlaneData(posIndex)
	for id, planeDataList in pairs(self.planeDataMap) do
		for indexStr, planeData in pairs(planeDataList) do
			if indexStr == posIndex then
				return true, planeData
			end
		end
	end

	return false
end

function HuiDiaoLanGameModel:getSpPlanePosIndexList()
	return self.spPlanePosIndexList
end

function HuiDiaoLanGameModel:getPlaneItemAnchorPos(posIndex)
	local posIndexList = string.splitToNumber(posIndex, "#")
	local posXIndex = posIndexList[1]
	local posYIndex = posIndexList[2]
	local posX = (posXIndex - 1) * (self.gameInfoData.planeItemWidth + HuiDiaoLanEnum.PlaneSpace) + self.gameInfoData.planeItemWidth / 2
	local posY = (posYIndex - 1) * (self.gameInfoData.planeItemHeight + HuiDiaoLanEnum.PlaneSpace) + self.gameInfoData.planeItemHeight / 2

	return posX, -posY
end

function HuiDiaoLanGameModel:getRandomElemenetList(createCount)
	math.randomseed(os.time())

	self.randomCount = 0
	self.createRandomElementDataList = {}

	local redCount, greenCount, blueCount = self:getElementsTypeCount(self.elementDataMap)
	local colorDataList = {
		{
			createCount = 0,
			color = HuiDiaoLanEnum.ElementColor.Red,
			count = redCount,
			totalCount = redCount
		},
		{
			createCount = 0,
			color = HuiDiaoLanEnum.ElementColor.Green,
			count = greenCount,
			totalCount = greenCount
		},
		{
			createCount = 0,
			color = HuiDiaoLanEnum.ElementColor.Blue,
			count = blueCount,
			totalCount = blueCount
		}
	}

	for i = 1, createCount do
		local tempColorDataList = tabletool.copy(colorDataList)
		local newCreateElementData = self:createRandomElement(tempColorDataList, colorDataList)

		table.insert(self.createRandomElementDataList, newCreateElementData)
	end

	self.randomCount = 0

	return self.createRandomElementDataList
end

function HuiDiaoLanGameModel:createRandomElement(tempColorDataList, colorDataList)
	self.randomCount = self.randomCount + 1

	if self.randomCount > 100 then
		logError("获取随机宝石的递归次数超了")

		return
	end

	local createRedCount, createGreenCount, createBlueCount = self:getElementsTypeCount(self.createRandomElementDataList)

	for index, colorData in ipairs(tempColorDataList) do
		if colorData.color == HuiDiaoLanEnum.ElementColor.Red then
			colorData.createCount = createRedCount
			colorData.totalCount = colorData.count + colorData.createCount
		elseif colorData.color == HuiDiaoLanEnum.ElementColor.Green then
			colorData.createCount = createGreenCount
			colorData.totalCount = colorData.count + colorData.createCount
		elseif colorData.color == HuiDiaoLanEnum.ElementColor.Blue then
			colorData.createCount = createBlueCount
			colorData.totalCount = colorData.count + colorData.createCount
		end
	end

	for _, colorData in ipairs(colorDataList) do
		for _, tempColorData in ipairs(tempColorDataList) do
			if colorData.color == tempColorData.color then
				colorData.totalCount = tempColorData.totalCount
				colorData.createCount = tempColorData.createCount
			end
		end
	end

	local randomIndex = math.random(#tempColorDataList)
	local randomColorData = tempColorDataList[randomIndex]
	local minColorData = self:getMinCountColorData(tempColorDataList)

	if randomColorData.totalCount + 1 - minColorData.totalCount < HuiDiaoLanEnum.CheckRandomCountOffset then
		return randomColorData
	else
		table.remove(tempColorDataList, randomIndex)

		return self:createRandomElement(tempColorDataList, colorDataList)
	end
end

function HuiDiaoLanGameModel:getMinCountColorData(colorDataList)
	local minData

	for index, colorData in ipairs(colorDataList) do
		if not minData or colorData.totalCount <= minData.totalCount then
			minData = colorData
		end
	end

	return minData
end

function HuiDiaoLanGameModel:getElementsTypeCount(elementDataMap)
	local redCount, greenCount, blueCount = 0, 0, 0

	for _, elementData in pairs(elementDataMap) do
		if not elementData.level or elementData.level < HuiDiaoLanEnum.MaxElementLevel then
			if elementData.color == HuiDiaoLanEnum.ElementColor.Red then
				redCount = redCount + 1
			elseif elementData.color == HuiDiaoLanEnum.ElementColor.Green then
				greenCount = greenCount + 1
			elseif elementData.color == HuiDiaoLanEnum.ElementColor.Blue then
				blueCount = blueCount + 1
			end
		end
	end

	return redCount, greenCount, blueCount
end

function HuiDiaoLanGameModel:cleanRandomElementDataList()
	self.createRandomElementDataList = {}
end

function HuiDiaoLanGameModel:getRandomElementPosList()
	self.createRandomElementPosList = {}
	self.emptyPlaneList = self:getEmptyPlaneMap()

	for index = 1, #self.createRandomElementDataList do
		if #self.emptyPlaneList == 0 then
			return self.createRandomElementPosList
		end

		local randomIndex = math.random(#self.emptyPlaneList)
		local posIndex = self.emptyPlaneList[randomIndex]

		table.remove(self.emptyPlaneList, randomIndex)
		table.insert(self.createRandomElementPosList, posIndex)
	end

	return self.createRandomElementPosList
end

function HuiDiaoLanGameModel:getEmptyPlaneMap()
	self.emptyPlaneList = {}

	for posYIndex = 1, self.gameInfoData.planeHeightCount do
		for posXIndex = 1, self.gameInfoData.planeWidthCount do
			local posIndex = string.format("%d#%d", posXIndex, posYIndex)

			if not self.elementDataMap[posIndex] then
				table.insert(self.emptyPlaneList, posIndex)
			end
		end
	end

	return self.emptyPlaneList
end

function HuiDiaoLanGameModel:setChangeColorSkillState(state)
	self.changeColorSkillState = state
end

function HuiDiaoLanGameModel:getChangeColorSkillState()
	return self.changeColorSkillState
end

function HuiDiaoLanGameModel:setExchangePosSkillState(state)
	self.exchangePosSkillState = state
end

function HuiDiaoLanGameModel:getExchangePosSkillState()
	return self.exchangePosSkillState
end

function HuiDiaoLanGameModel:setChangeColorSkillCdState(state)
	self.changeColorSkillisCd = state
end

function HuiDiaoLanGameModel:getChangeColorSkillCdState()
	return self.changeColorSkillisCd
end

function HuiDiaoLanGameModel:setExchangePosSkillCdState(state)
	self.exchangePosSkillisCd = state
end

function HuiDiaoLanGameModel:getExchangePosSkillCdState()
	return self.exchangePosSkillisCd
end

function HuiDiaoLanGameModel:setWinState(episodeId, state)
	local isEpisodeFinish = HuiDiaoLanModel.instance:getEpisodeFinishState(self.curEpisodeId)

	if isEpisodeFinish then
		self.winStateMap[episodeId] = true
	elseif state then
		self.winStateMap[episodeId] = state
	end
end

function HuiDiaoLanGameModel:getWinState(episodeId)
	return self.winStateMap[episodeId]
end

HuiDiaoLanGameModel.instance = HuiDiaoLanGameModel.New()

return HuiDiaoLanGameModel
