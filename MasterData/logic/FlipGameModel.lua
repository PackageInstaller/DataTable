-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/model/FlipGameModel.lua

module("logic.extensions.dreamteam.model.FlipGameModel", package.seeall)

local FlipGameModel = class("FlipGameModel", BaseModel)

function FlipGameModel:ctor()
	self._curStageId = 1
end

function FlipGameModel:onInit()
	self:onReset()
end

function FlipGameModel:onReset()
	self:clearGameState()

	self._curStageId = 1
	self._scoreList = {}
	self._curLevel = 1
	self._levelList = {}
	self._totalLevelNum = 0
end

function FlipGameModel:setLevelList(planId)
	self._levelList = {}

	if planId > 0 then
		local cfgStages = DreamTeamConfig.instance:getInteractionCfgs(planId)

		for i, v in ipairs(cfgStages) do
			table.insert(self._levelList, v)
		end

		self._totalLevelNum = #self._levelList
	else
		printError("test 配置不存在 activityId =", activityId)
	end
end

function FlipGameModel:clearGameState()
	self:clearSelectState()

	self._eraseList = {}
	self._gameScore = 0
	self._buyChanceCount = 1
end

function FlipGameModel:clearSelectState()
	self._curSelectIndexs = {}
end

function FlipGameModel:addToTotalGameScore()
	self._scoreList[self._curLevel] = self._scoreList[self._curLevel] or 0
	self._scoreList[self._curLevel] = self._scoreList[self._curLevel] + self._gameScore
end

function FlipGameModel:getTotalGameScore()
	local totalScore = 0

	for level, score in pairs(self._scoreList) do
		if self._levelList[level] then
			totalScore = totalScore + score * self._levelList[level].touchEnergy
		end
	end

	return totalScore
end

function FlipGameModel:getGameScore()
	return self._gameScore
end

function FlipGameModel:addGameScore()
	local score = 1

	self._gameScore = self._gameScore + score
end

function FlipGameModel:setNextLevel()
	self._curLevel = (self._curStageId - 1) % self._totalLevelNum + 1
	self._curStageId = self._curStageId + 1
end

function FlipGameModel:getRowAndColumnNum()
	local x = self._levelList[self._curLevel].cardNum[1]
	local y = self._levelList[self._curLevel].cardNum[2]

	return x, y
end

function FlipGameModel:addSelectIndex(index, id)
	local isSuccess = false

	if #self._curSelectIndexs < 2 then
		table.insert(self._curSelectIndexs, {
			index = index,
			id = id
		})

		isSuccess = true
	else
		isSuccess = false
	end

	return isSuccess
end

function FlipGameModel:isArriveMaxSelectCount()
	return #self._curSelectIndexs >= 2
end

function FlipGameModel:isErase()
	return #self._curSelectIndexs >= 2 and self._curSelectIndexs[1].id == self._curSelectIndexs[2].id
end

function FlipGameModel:getSelectIndexList()
	local list = {}

	for i, v in ipairs(self._curSelectIndexs) do
		table.insert(list, v.index)
	end

	return list
end

function FlipGameModel:getCurCardTotalNum()
	local row, column = self:getRowAndColumnNum()

	return row * column
end

function FlipGameModel:addToEraseList(id)
	table.insert(self._eraseList, id)
end

function FlipGameModel:isArrivedMaxEraseCount()
	return #self._eraseList >= self:getCurCardTotalNum()
end

function FlipGameModel:isHaveBuyChance()
	return self._buyChanceCount > 0
end

function FlipGameModel:reduceBuyChance()
	self._buyChanceCount = self._buyChanceCount - 1
end

function FlipGameModel:isHaveNextLevel()
	return self._curLevel + 1 <= self._totalLevelNum
end

function FlipGameModel:getCurLevel()
	return self._curLevel
end

function FlipGameModel:getNextLevel()
	return self._curLevel + 1
end

function FlipGameModel:getCurLevelCfg()
	return self._levelList[self._curLevel]
end

function FlipGameModel:getCurLevelDefaultTime()
	if self._levelList[self._curLevel] then
		return self._levelList[self._curLevel].defaultTime
	else
		return 60
	end
end

function FlipGameModel:getCurLevelAddTime()
	if self._levelList[self._curLevel] then
		return self._levelList[self._curLevel].time
	else
		return 30
	end
end

function FlipGameModel:_addToCardList(id, iconNum, cardList)
	if iconNum <= 0 then
		return cardList
	end

	local iconNum = iconNum % 2 == 0 and iconNum or iconNum + 1

	for i = 1, iconNum do
		table.insert(cardList, id)
	end

	return cardList
end

function FlipGameModel:_randomSort(cardList)
	local maxCount = #cardList

	math.randomseed(os.time())

	for i = 1, maxCount do
		local randomNum = math.random(i, maxCount)

		cardList[i] = cardList[randomNum]
		cardList[randomNum] = cardList[i]
	end

	return cardList
end

function FlipGameModel:getRandomCardList()
	local cardList = {}
	local totalCardNum = self:getCurCardTotalNum()
	local cfg = self._levelList[self._curLevel]

	if cfg then
		cardList = self:_addToCardList(0, cfg.iconNum1, cardList)
		cardList = self:_addToCardList(1, cfg.iconNum2, cardList)
		cardList = self:_addToCardList(2, cfg.iconNum3, cardList)
		cardList = self:_addToCardList(3, cfg.iconNum4, cardList)
	else
		for i = 1, totalCardNum do
			table.insert(cardList, 0)
		end
	end

	return self:_randomSort(cardList)
end

function FlipGameModel:getFlipExMo()
	if self._flipExMo == nil then
		self._flipExMo = FlipExMo.New()
	end

	return self._flipExMo
end

function FlipGameModel:resetFlipExMo()
	self._flipExMo = nil
end

FlipGameModel.instance = FlipGameModel.New()

return FlipGameModel
