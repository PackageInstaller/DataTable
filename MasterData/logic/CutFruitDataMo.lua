-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/cutfruit/CutFruitDataMo.lua

module("logic.extensions.godlongyan.view.cutfruit.CutFruitDataMo", package.seeall)

local CutFruitDataMo = class("CutFruitDataMo")

function CutFruitDataMo:ctor()
	self._gamePlanId = 0
	self._curStageIdx = 0
	self._curAreaIdx = 0
	self._curStageScore = 0
	self._scoreDic = {}
	self._curStageTime = 0
end

function CutFruitDataMo:init(gamePlanId, stageIdx)
	self._gamePlanId = gamePlanId

	self:setCurStageIdx(stageIdx)
	self:setCurStageTime(self:getCurMaxStageTime())
	self:setCurAreaIdx(0)
	self:setStageScore(0)
	self:initPropFmt()
end

function CutFruitDataMo:startNextArea()
	local curAreaIdx = self:getCurAreaIdx()
	local curMaxAreaIdx = self:getCurMaxAreaIdx()

	curAreaIdx = math.max((curAreaIdx + 1) % (curMaxAreaIdx + 1), 1)

	self:setCurAreaIdx(curAreaIdx)
end

function CutFruitDataMo:setStageScore(score)
	self._curStageScore = score
end

function CutFruitDataMo:addStageScore(delta)
	self._curStageScore = Mathf.Clamp(self._curStageScore + delta, 0, self:getMaxStageScore())
end

function CutFruitDataMo:getStageScore()
	return self._curStageScore
end

function CutFruitDataMo:getMaxStageScore()
	return GodLongYanConfig.instance:getMaxScorePerGame()
end

function CutFruitDataMo:setCurStageTime(time)
	self._curStageTime = time
end

function CutFruitDataMo:addCurStageTime(delta)
	self._curStageTime = Mathf.Clamp(self:getCurStageTime() + delta, 0, self:getCurMaxStageTime())
end

function CutFruitDataMo:getCurStageTime()
	return self._curStageTime
end

function CutFruitDataMo:getCurMaxStageTime()
	local gameData = GodLongYanConfig.instance:getGameDataById(self._gamePlanId)

	return checknumber(gameData.stageTimeArray[self:getCurStageIdx()])
end

function CutFruitDataMo:setCurStageIdx(stageIdx)
	self._curStageIdx = stageIdx
end

function CutFruitDataMo:getCurStageIdx()
	return self._curStageIdx
end

function CutFruitDataMo:getCurMaxStageIdx()
	local stageCfg = GodLongYanConfig.instance:getGameStageCfg(self._gamePlanId)

	return #stageCfg
end

function CutFruitDataMo:setCurAreaIdx(areaIdx)
	self._curAreaIdx = areaIdx
end

function CutFruitDataMo:getCurAreaIdx()
	return self._curAreaIdx
end

function CutFruitDataMo:getCurAreaData()
	return GodLongYanConfig.instance:getGameAreaData(self._gamePlanId, self:getCurStageIdx(), self:getCurAreaIdx())
end

function CutFruitDataMo:getCurRowNum()
	return self:getCurAreaData().rowNum
end

function CutFruitDataMo:getCurColNum()
	return self:getCurAreaData().colNum
end

function CutFruitDataMo:getCurRowInterval()
	return self:getCurAreaData().rowInterval
end

function CutFruitDataMo:getCurAreaInterval()
	return self:getCurAreaData().areaInterval
end

function CutFruitDataMo:getCurMoveDuration()
	return self:getCurAreaData().moveDuration
end

function CutFruitDataMo:getCurMaxAreaIdx()
	local stageData = GodLongYanConfig.instance:getGameStageData(self._gamePlanId, self:getCurStageIdx())

	return #stageData
end

function CutFruitDataMo:initPropFmt()
	local stageData = GodLongYanConfig.instance:getGameStageData(self._gamePlanId, self:getCurStageIdx())

	self._propfmt = {}

	for areaIdx, areaData in ipairs(stageData) do
		self._propfmt[areaIdx] = self:initAreaPropFmt(areaData)
	end
end

function CutFruitDataMo:initAreaPropFmt(areaData)
	local propList = {}
	local totalPropNum = 0
	local propSettingArray = string.split(areaData.propSettingStr, "#")

	for _, propInfoStr in ipairs(propSettingArray) do
		local propInfo = string.split(propInfoStr, ":")
		local propId = checknumber(propInfo[1])
		local propNum = checknumber(propInfo[2])

		totalPropNum = totalPropNum + propNum

		for num = 1, propNum do
			table.insert(propList, propId)
		end
	end

	local areaPropFmt = {}
	local propNum = 0

	for rowIdx = 1, areaData.rowNum do
		areaPropFmt[rowIdx] = {}

		for colIdx = 1, areaData.colNum do
			propNum = propNum + 1
			areaPropFmt[rowIdx][colIdx] = propList[propNum] or 0
		end
	end

	if propNum < totalPropNum then
		printError("配置道具数量超过限制,超过部分不会被使用,请检查配置表")
	end

	for row = 1, areaData.rowNum do
		for col = 1, areaData.colNum do
			local tarRow = Mathf.Random(1, areaData.rowNum)
			local tarCol = Mathf.Random(1, areaData.colNum)

			areaPropFmt[row][col] = areaPropFmt[tarRow][tarCol]
			areaPropFmt[tarRow][tarCol] = areaPropFmt[row][col]
		end
	end

	return areaPropFmt
end

function CutFruitDataMo:getCurAreaPropFmt()
	return self._propfmt[self:getCurAreaIdx()]
end

return CutFruitDataMo
