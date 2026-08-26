-- chunkname: @modules/logic/sp01/act205/model/Act205OceanModel.lua

module("modules.logic.sp01.act205.model.Act205OceanModel", package.seeall)

local Act205OceanModel = class("Act205OceanModel", BaseModel)

function Act205OceanModel:onInit()
	self:reInit()
end

function Act205OceanModel:reInit()
	self.curRandomGoldList = {}
	self.curRandomDiceList = {}
	self.randomDiceMap = {}
	self.curSelectGoldId = 0
	self.curSelectDiceIdList = {}
end

function Act205OceanModel:getGoldList()
	local goldList = {}

	self.curRandomGoldList = {}

	local saveLocalGoldStr = Act205Controller.instance:getPlayerPrefs(Act205Enum.saveLocalOceanGoldKey, "")

	if not string.nilorempty(saveLocalGoldStr) then
		goldList = string.splitToNumber(saveLocalGoldStr, "#")
		self.curRandomGoldList = goldList
	else
		goldList = self:getRandomGoldList()
	end

	return goldList
end

function Act205OceanModel:getRandomGoldList()
	if #self.curRandomGoldList >= 3 then
		math.randomseed(os.time())
		table.sort(self.curRandomGoldList, function()
			return math.random() < 0.5
		end)
		Act205Controller.instance:setPlayerPrefs(Act205Enum.saveLocalOceanGoldKey, table.concat(self.curRandomGoldList, "#"))

		return self.curRandomGoldList
	end

	local goldCoList = {}
	local allGoldCoList = self:getAllNormalTypeGoldIdList()

	for _, goldCo in ipairs(allGoldCoList) do
		if not tabletool.indexOf(self.curRandomGoldList, goldCo.id) then
			table.insert(goldCoList, goldCo)
		end
	end

	local allWeight = 0

	for _, goldCo in ipairs(goldCoList) do
		allWeight = allWeight + goldCo.weight
	end

	local randomWeight = math.random(1, allWeight)
	local curWeight = 0

	for _, goldCo in ipairs(goldCoList) do
		curWeight = curWeight + goldCo.weight

		if randomWeight <= curWeight then
			table.insert(self.curRandomGoldList, goldCo.id)

			break
		end
	end

	if #self.curRandomGoldList == 2 then
		local hardCo = self:getRandomHardTypeGold()

		table.insert(self.curRandomGoldList, hardCo.id)
	end

	return self:getRandomGoldList()
end

function Act205OceanModel:getRandomHardTypeGold()
	local allHardTypeCoList = {}
	local allGoldCoList = Act205Config.instance:getDiceGoalConfigList()

	for _, goldCo in ipairs(allGoldCoList) do
		if goldCo.hardType == Act205Enum.oceanGoldHardType.Hard then
			table.insert(allHardTypeCoList, goldCo)
		end
	end

	local randomIndex = math.random(1, #allHardTypeCoList)

	return allHardTypeCoList[randomIndex]
end

function Act205OceanModel:getAllNormalTypeGoldIdList()
	local allNormalTypeCoList = {}
	local allGoldCoList = Act205Config.instance:getDiceGoalConfigList()

	for _, goldCo in ipairs(allGoldCoList) do
		if goldCo.hardType == Act205Enum.oceanGoldHardType.Normal then
			table.insert(allNormalTypeCoList, goldCo)
		end
	end

	return allNormalTypeCoList
end

function Act205OceanModel:getDiceList(goldIndex)
	local diceList = {}

	self.curRandomDiceList = {}

	local saveLocalDiceStr = Act205Controller.instance:getPlayerPrefs(Act205Enum.saveLocalOceanDiceKey, "")

	if not string.nilorempty(saveLocalDiceStr) then
		local saveDiceList = cjson.decode(saveLocalDiceStr)

		for _, saveDiceStr in ipairs(saveDiceList) do
			local info = GameUtil.splitString2(saveDiceStr, true)

			self.randomDiceMap[info[1][1]] = info[2]
		end

		if self.randomDiceMap[goldIndex] then
			diceList = self.randomDiceMap[goldIndex]
		else
			diceList = self:createRandomDiceList(goldIndex)
			self.randomDiceMap[goldIndex] = diceList
		end
	else
		diceList = self:createRandomDiceList(goldIndex)
		self.randomDiceMap[goldIndex] = diceList
	end

	self:saveLocalDiceMap()

	return diceList
end

function Act205OceanModel:createRandomDiceList(goldIndex)
	local gameInfoMo = Act205Model.instance:getGameInfoMo(Act205Enum.ActId, Act205Enum.GameStageId.Ocean)

	self.curFailTimes = string.nilorempty(gameInfoMo:getGameInfo()) and 0 or tonumber(gameInfoMo:getGameInfo())

	local FailToWinTimes = Act205Config.instance:getAct205Const(Act205Enum.ConstId.OceanGameFailTimesToWin, true)
	local winDiceCo = Act205Config.instance:getWinDiceConfig()

	if FailToWinTimes <= self.curFailTimes then
		for i = 1, 3 do
			table.insert(self.curRandomDiceList, winDiceCo.id)
		end

		return self.curRandomDiceList
	end

	local goldId = self.curRandomGoldList[goldIndex]
	local goldCo = Act205Config.instance:getDiceGoalConfig(goldId)

	if not string.nilorempty(goldCo.bindingDice) then
		local bindingDiceList = string.splitToNumber(goldCo.bindingDice, "#")

		for _, bindingDice in ipairs(bindingDiceList) do
			table.insert(self.curRandomDiceList, bindingDice)
		end
	end

	local WinDiceAddWeight = Act205Config.instance:getAct205Const(Act205Enum.ConstId.OceanGameAddWinWeight, true) * self.curFailTimes
	local winDiceCo = Act205Config.instance:getWinDiceConfig()
	local winDiceWeight = winDiceCo.weight + WinDiceAddWeight

	self.newWinDiceCo = tabletool.copy(winDiceCo)
	self.newWinDiceCo.weight = winDiceWeight

	return self:getRandomDiceList(goldIndex)
end

function Act205OceanModel:getRandomDiceList(goldIndex)
	if #self.curRandomDiceList >= 3 then
		local hasWinDice = false

		for index, diceId in ipairs(self.curRandomDiceList) do
			if diceId == self.newWinDiceCo.id then
				hasWinDice = true

				break
			end
		end

		if hasWinDice then
			self.curRandomDiceList = {}

			for i = 1, 3 do
				table.insert(self.curRandomDiceList, self.newWinDiceCo.id)
			end
		else
			return self.curRandomDiceList
		end
	end

	local diceCoList = {}
	local allDiceCoList = Act205Config.instance:getDicePoolConfigList()

	for _, diceCo in ipairs(allDiceCoList) do
		if not tabletool.indexOf(self.curRandomDiceList, diceCo.id) and diceCo.winDice ~= 1 then
			table.insert(diceCoList, diceCo)
		end
	end

	table.insert(diceCoList, self.newWinDiceCo)

	local allWeight = 0

	for _, diceCo in ipairs(diceCoList) do
		allWeight = allWeight + diceCo.weight
	end

	local randomWeight = math.random(1, allWeight)
	local curWeight = 0

	for _, diceCo in ipairs(diceCoList) do
		curWeight = curWeight + diceCo.weight

		if randomWeight <= curWeight then
			table.insert(self.curRandomDiceList, diceCo.id)

			break
		end
	end

	return self:getRandomDiceList(goldIndex)
end

function Act205OceanModel:saveLocalDiceMap()
	local diceSaveStrTab = {}

	for index, diceList in pairs(self.randomDiceMap) do
		local saveStr = string.format("%s|%s", index, table.concat(diceList, "#"))

		table.insert(diceSaveStrTab, saveStr)
	end

	Act205Controller.instance:setPlayerPrefs(Act205Enum.saveLocalOceanDiceKey, cjson.encode(diceSaveStrTab))
end

function Act205OceanModel:setCurSelectGoldId(goldId)
	self.curSelectGoldId = goldId
end

function Act205OceanModel:getCurSelectGoldId()
	return self.curSelectGoldId
end

function Act205OceanModel:getGoldIndexByGoldId(curGoldId)
	for index, goldId in ipairs(self.curRandomGoldList) do
		if curGoldId == goldId then
			return index
		end
	end
end

function Act205OceanModel:setcurSelectDiceIdList(diceIdList)
	self.curSelectDiceIdList = diceIdList
end

function Act205OceanModel:getcurSelectDiceIdList()
	return self.curSelectDiceIdList
end

function Act205OceanModel:cleanLocalSaveKey()
	Act205Controller.instance:setPlayerPrefs(Act205Enum.saveLocalOceanGoldKey, "")
	Act205Controller.instance:setPlayerPrefs(Act205Enum.saveLocalOceanDiceKey, "")

	self.curRandomGoldList = {}
	self.curRandomDiceList = {}
	self.randomDiceMap = {}
end

function Act205OceanModel:cleanSelectData()
	self.curSelectDiceIdList = {}
	self.curSelectGoldId = 0
end

Act205OceanModel.instance = Act205OceanModel.New()

return Act205OceanModel
