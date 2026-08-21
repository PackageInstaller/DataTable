-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/LotteryUtil.lua

module("logic.common.util.LotteryUtil", package.seeall)

local keyWordNum = {
	7,
	7
}
local keyWordGap = {
	4,
	4
}
local kMaxPosNum = 9

function getItemKeyByTS(type, subType)
	return type * 1000 + subType
end

function _parseTime(timeStr)
	if timeStr == "" then
		return
	end

	local strList = string.split(timeStr, "#")
	local openStr = strList[1]
	local endStr = strList[2]
	local openTime = LotteryUtil._parseTimeByStr(openStr)
	local endTime = LotteryUtil._parseTimeByStr(endStr)

	return openTime, endTime
end

function _parseTimeByStr(timeStr)
	local strList = string.split(timeStr, " ")
	local preList = string.split(strList[1], "-")
	local nextList = string.split(strList[2], ":")
	local timeTable = {}

	timeTable.year = tonumber(preList[1])
	timeTable.month = tonumber(preList[2])
	timeTable.day = tonumber(preList[3])
	timeTable.hour = tonumber(nextList[1])
	timeTable.min = tonumber(nextList[2])
	timeTable.sec = tonumber(nextList[3])

	return timeTable
end

function isProbabilityUp(group)
	if group.floatWeight ~= 0 then
		local beginTime, endTime = LotteryUtil._parseTime(group.floatTimeRange)

		if beginTime == nil then
			return false
		else
			local nowTime = ServerTime.now()
			local conditionBeginTime = ServerTime.dateToTimeServerLook(beginTime)
			local conditionEndTime = ServerTime.dateToTimeServerLook(endTime)

			if nowTime < conditionBeginTime or conditionEndTime <= nowTime then
				return false
			else
				return true
			end
		end
	else
		return false
	end
end

function _resultConfigSort(dataA, dataB)
	if dataA.sortOrder < dataB.sortOrder then
		return false
	elseif dataA.sortOrder > dataB.sortOrder then
		return true
	elseif dataA.code < dataB.code then
		return true
	else
		return false
	end
end

function _randomMojitu(lotteryResultList)
	local lotteryResultList = LotteryCardController.instance:getCacheLotteryResult()
	local lotteryType = RetrieveEnum.LotterySimpleType.Card

	if not LotteryCardController.instance:getIsTest() then
		local lotteryId = LotteryCardController.instance:getLotteryId()
		local lotteryData = ActivityController.instance:getActivityById(lotteryId)

		lotteryType = lotteryData:getLotterySimpleType()
	end

	local qualityList = {}
	local campList = {}

	for i, characterInfo in ipairs(lotteryResultList) do
		local quality = false

		if lotteryType == RetrieveEnum.LotterySimpleType.Card then
			local characterCO = CharacterConfig.instance:getCfgInfoByID(characterInfo.characterCode)

			quality = characterCO.quality

			local camp = characterCO.camp

			qualityList[quality] = qualityList[quality] and qualityList[quality] + 1 or 1
			campList[camp] = campList[camp] and campList[camp] + 1 or 1
		else
			local itemCO = BackpackConfig.instance:getItemInfoByItemId(characterInfo.characterCode)

			quality = itemCO.quality
			qualityList[quality] = qualityList[quality] + 1 or 1
		end
	end

	local dataList = LotteryCardConfig.instance:getConfigList(ConfigName.LotteryResult)

	table.sort(dataList, LotteryUtil._resultConfigSort)

	for i, data in ipairs(dataList) do
		local limitList = data.param

		for i, limit in ipairs(limitList) do
			local rawList = string.split(limit, ",")
			local qualityLimit = tonumber(rawList[1])
			local campLimit = tonumber(rawList[2])
			local numLimit = tonumber(rawList[3])
			local qualityNum = 0

			for i = qualityLimit, GameEnum.QualityEnum.S do
				qualityList[i] = qualityList[i] or 0
				qualityNum = qualityNum + qualityList[i]
			end

			local campNum = campList[campLimit] or 0

			if numLimit <= qualityNum or numLimit <= campNum then
				local groupId = LotteryCardController.instance:getMojitu() or 1
				local co = LotteryCardConfig.instance:getMojituByGroupAndKey(groupId, data.code)
				local mojituList = co.mojitu
				local randomNum = math.random(1, #mojituList)

				return mojituList[randomNum]
			end
		end
	end
end

function _insertList(list, var)
	if var and var ~= "" then
		table.insert(list, var)
	end
end

function _getKeyWord(characterCode)
	local keyword = LotteryCardConfig.instance:getConfigByKey(ConfigName.LotteryKeyWord, characterCode)

	if isInEditorMode then
		local keywordEdit = LotteryLogModel.instance:getKeyword()

		if keywordEdit then
			keyword = keywordEdit
		end
	end

	local keyWordDataList = {}

	if not keyword then
		return keyWordDataList
	end

	local keywordList = {}

	LotteryUtil._insertList(keywordList, keyword.keyword1)
	LotteryUtil._insertList(keywordList, keyword.keyword2)
	LotteryUtil._insertList(keywordList, keyword.keyword3)
	LotteryUtil._insertList(keywordList, keyword.keyword4)
	LotteryUtil._insertList(keywordList, keyword.keyword5)
	LotteryUtil._insertList(keywordList, keyword.keyword6)
	LotteryUtil._insertList(keywordList, keyword.keyword7)
	LotteryUtil._insertList(keywordList, keyword.keyword8)

	local randomNum = math.random(keyWordNum[1], keyWordNum[2])

	randomNum = math.min(randomNum, #keywordList)

	local randomList = LotteryUtil._randomNumList(randomNum, #keywordList)
	local randomPosList = LotteryCardConfig.instance:getKeyWordPosByRandom()

	for i, num in ipairs(randomList) do
		local keywordRawStr = keywordList[num]
		local keywordRawStrList = string.split(keywordRawStr, ";")
		local randomGap = math.random(keyWordGap[1], keyWordGap[2]) / 10

		if i == 1 then
			randomGap = 0
		end

		table.insert(keyWordDataList, {
			index = i,
			keyword = keywordRawStrList[2],
			type = tonumber(keywordRawStrList[1]),
			time = randomGap,
			audio = keywordRawStrList[3],
			pos = randomPosList[i]
		})
	end

	return keyWordDataList
end

function _randomList(num)
	local list = {}
	local randomList = {}

	for i = 1, num do
		table.insert(list, i)
	end

	for i = num, 1, -1 do
		local randomNum = math.random(1, i)

		table.insert(randomList, list[randomNum])
		table.remove(list, randomNum)
	end

	return randomList
end

function _randomNumLegal(randomList, min, max)
	local preNum = 0

	if #randomList ~= 0 then
		preNum = randomList[#randomList]
	end

	local numDivisor = math.ceil(preNum / 3)
	local numRemainder = preNum % 3
	local ilegalNumList = {}

	if numRemainder % 3 == 2 then
		table.insert(ilegalNumList, preNum - 1)
		table.insert(ilegalNumList, preNum + 1)
	elseif numRemainder % 3 == 0 and numDivisor ~= 0 then
		table.insert(ilegalNumList, preNum - 1)
	elseif numRemainder % 3 == 1 then
		table.insert(ilegalNumList, preNum + 1)
	end

	for i, ilegalNum in ipairs(ilegalNumList) do
		if ilegalNum < min or max < ilegalNum then
			table.remove(ilegalNumList, i)
		end
	end

	table.insertto(ilegalNumList, randomList)

	for i, randomNum in ipairs(randomList) do
		if not table.indexof(ilegalNumList, randomNum) then
			table.insert(ilegalNumList, randomNum)
		end
	end

	local randomRawNum = math.random(1, max - min + 1 - #ilegalNumList)

	for i = min, max do
		if not table.indexof(ilegalNumList, i) then
			randomRawNum = randomRawNum - 1

			if randomRawNum == 0 then
				return i
			end
		end
	end
end

function _randomNumList(num, maxNum)
	local randomList = {}

	for i = 1, num do
		local randomNum = LotteryUtil._randomNumLegal(randomList, 1, maxNum)

		table.insert(randomList, randomNum)
	end

	return randomList
end

function sortlotteryPool(lotteryA, lotteryB)
	local sortOrderA = lotteryA:getSortOrder()
	local sortOrderB = lotteryB:getSortOrder()
	local idA = lotteryA:getId()
	local idB = lotteryB:getId()

	if sortOrderA < sortOrderB then
		return true
	elseif sortOrderB < sortOrderA then
		return false
	end

	if idA < idB then
		return true
	end

	return false
end

function loadLotteryPanelByLotteryData(lotteryData)
	local lotteryPrefabList = lotteryData:getPrefabName()

	if not lotteryPrefabList or #lotteryPrefabList == 0 then
		return
	end

	local sceneFlow = SceneFace.instance:getCurSceneFlow()
	local urlList = {}

	for i, lotteryPrefabName in ipairs(lotteryPrefabList) do
		local url = string.format("ui/views/summoncard/summoncardpane/%s.prefab", lotteryPrefabName)
		local resource = sceneFlow.resMgr:getPrefabResource(url)

		if not resource then
			table.insert(urlList, url)
		end
	end

	sceneFlow.resMgr:addPrefabList(urlList)
end

function loadLotteryBg(bgPrefabName)
	local url = GameUrl.getLotteryPrefabPath(bgPrefabName)
	local sceneFlow = SceneFace.instance:getCurSceneFlow()
	local qualityPrefab = sceneFlow.resMgr:getInst(url)

	return qualityPrefab
end

function loadLotteryTitle(titleName)
	local url = GameUrl.getLotteryPrefabPath(titleName)
	local sceneFlow = SceneFace.instance:getCurSceneFlow()
	local qualityPrefab = sceneFlow.resMgr:getInst(url)

	return qualityPrefab
end

function getAllLotteryBgRes()
	local bgResList = {}
	local pools = RetrieveConfig.instance:getConfigList(ConfigName.LotteryPool)

	for _, v in pairs(pools) do
		if not string.nilorempty(v.sceneBg) then
			local path = GameUrl.getRetrieveSceneBgMat(v.sceneBg)

			table.insert(bgResList, path)
		end
	end

	return bgResList
end
