-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/model/funcampgame/FunCampGameModel.lua

module("logic.extensions.funcamp.model.funcampgame.FunCampGameModel", package.seeall)

local FunCampGameModel = class("FunCampGameModel", BaseModel)

function FunCampGameModel:ctor()
	self._curStageId = 1
end

function FunCampGameModel:onInit()
	self:onReset()
end

function FunCampGameModel:onReset()
	self:clearGameState()

	self._curStageId = 1
	self._scoreList = {}
	self._curLevel = 1
	self._levelList = {}
	self._totalLevelNum = 0
end

function FunCampGameModel:setLevelList(activityId)
	self._levelList = {}

	local cfg = FunCampConfig.instance:getActivityCfg(activityId)

	if cfg then
		local planId = cfg.gamePlanId
		local cfgStages = FunCampConfig.instance:getInteractionCfgs(planId)

		for i, v in ipairs(cfgStages) do
			table.insert(self._levelList, v)
		end

		self._totalLevelNum = #self._levelList
	else
		printError("test 配置不存在 activityId =", activityId)
	end
end

function FunCampGameModel:clearGameState()
	self:clearSelectState()

	self._eraseList = {}
	self._gameScore = 0
	self._buyChanceCount = 1
end

function FunCampGameModel:clearSelectState()
	self._curSelectIndexs = {}
end

function FunCampGameModel:addToTotalGameScore()
	self._scoreList[self._curLevel] = self._scoreList[self._curLevel] or 0
	self._scoreList[self._curLevel] = self._scoreList[self._curLevel] + self._gameScore
end

function FunCampGameModel:getTotalGameScore()
	local totalScore = 0

	for level, score in pairs(self._scoreList) do
		if self._levelList[level] then
			totalScore = totalScore + score * self._levelList[level].touchEnergy
		end
	end

	return totalScore
end

function FunCampGameModel:getGameScore()
	return self._gameScore
end

function FunCampGameModel:addGameScore()
	local score = 1

	self._gameScore = self._gameScore + score
end

function FunCampGameModel:setNextLevel()
	self._curLevel = (self._curStageId - 1) % self._totalLevelNum + 1
	self._curStageId = self._curStageId + 1
end

function FunCampGameModel:getRowAndColumnNum()
	local x = self._levelList[self._curLevel].cardNum[1]
	local y = self._levelList[self._curLevel].cardNum[2]

	return x, y
end

function FunCampGameModel:addSelectIndex(index, id)
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

function FunCampGameModel:isArriveMaxSelectCount()
	return #self._curSelectIndexs >= 2
end

function FunCampGameModel:isErase()
	return #self._curSelectIndexs >= 2 and self._curSelectIndexs[1].id == self._curSelectIndexs[2].id
end

function FunCampGameModel:getSelectIndexList()
	local list = {}

	for i, v in ipairs(self._curSelectIndexs) do
		table.insert(list, v.index)
	end

	return list
end

function FunCampGameModel:getCurCardTotalNum()
	local row, column = self:getRowAndColumnNum()

	return row * column
end

function FunCampGameModel:addToEraseList(id)
	table.insert(self._eraseList, id)
end

function FunCampGameModel:isArrivedMaxEraseCount()
	return #self._eraseList >= self:getCurCardTotalNum()
end

function FunCampGameModel:getCurLevel()
	return self._curLevel
end

function FunCampGameModel:getNextLevel()
	return self._curLevel + 1
end

function FunCampGameModel:getCurLevelCfg()
	return self._levelList[self._curLevel]
end

function FunCampGameModel:getCurLevelDefaultTime()
	if self._levelList[self._curLevel] then
		return self._levelList[self._curLevel].defaultTime
	else
		return 60
	end
end

function FunCampGameModel:_addToCardList(id, iconNum, cardList)
	if iconNum <= 0 then
		return cardList
	end

	local iconNum = iconNum % 2 == 0 and iconNum or iconNum + 1

	for i = 1, iconNum do
		table.insert(cardList, id)
	end

	return cardList
end

function FunCampGameModel:_randomSort(cardList)
	local maxCount = #cardList

	math.randomseed(os.time())

	for i = 1, maxCount do
		local randomNum = math.random(i, maxCount)

		cardList[i] = cardList[randomNum]
		cardList[randomNum] = cardList[i]
	end

	return cardList
end

function FunCampGameModel:getRandomCardList()
	local cardList = {}
	local totalCardNum = self:getCurCardTotalNum()
	local cfg = self._levelList[self._curLevel]

	if cfg then
		cardList = self:_addToCardList(0, cfg.iconNum1, cardList)
		cardList = self:_addToCardList(1, cfg.iconNum2, cardList)
		cardList = self:_addToCardList(2, cfg.iconNum3, cardList)
		cardList = self:_addToCardList(3, cfg.iconNum4, cardList)
		cardList = self:_addToCardList(4, cfg.iconNum5, cardList)
	else
		for i = 1, totalCardNum do
			table.insert(cardList, 0)
		end
	end

	return self:_randomSort(cardList)
end

FunCampGameModel.instance = FunCampGameModel.New()

return FunCampGameModel
