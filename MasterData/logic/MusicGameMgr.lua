-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/data/MusicGameMgr.lua

module("logic.extensions.musicgame.data.MusicGameMgr", package.seeall)

local MusicGameMgr = class("MusicGameMgr")

function MusicGameMgr:ctor(stageId)
	self._stageId = stageId
	self._stageData = MusicGameConfig.instance:getStageData(self._stageId)
	self._mapData = MusicGameConfig.instance:getMapData(self._stageId)

	self:onReset()
end

function MusicGameMgr:onReset()
	self._curGameTime = 0
	self._dischargeTime = self._stageData.gameTime
	self._maxGameTime = self._dischargeTime + 5
	self._curComboNum = -1
	self._maxComboNum = 0
	self._curHitNum = 0
	self._symbolScoreRate = self._stageData.symbolScoreRate
	self._lineStarVec = {}
	self._lineEndVec = {}
	self._lineCount = 0

	for _, field in ipairs(MusicGameEnum.LineFields) do
		local points = self._mapData[field]

		if points then
			local startX, startY = points[1], points[2]
			local endX, endY = points[3], points[4]

			table.insert(self._lineStarVec, Vector3.New(startX, startY, 0))
			table.insert(self._lineEndVec, Vector3.New(endX, endY, 0))

			self._lineCount = self._lineCount + 1
		end
	end

	self._curDischargeCount = 0
	self._dischargeTypeList = {}

	for dischargeType, field in ipairs(MusicGameEnum.DischargeTypeFields) do
		local count = self._stageData[field]

		for idx = 1, count do
			table.insert(self._dischargeTypeList, dischargeType)
		end
	end

	self._totalDischargeCount = #self._dischargeTypeList

	GameUtil.permuteArray(self._dischargeTypeList)
	self:_changeState(MusicGameEnum.State_Preparing)
end

function MusicGameMgr:resetGame()
	self:onReset()
end

function MusicGameMgr:endGame()
	self:_changeState(MusicGameEnum.State_Ended)
end

function MusicGameMgr:stopGame()
	self:_changeState(MusicGameEnum.State_Stoping)
end

function MusicGameMgr:continueGame()
	self:_changeState(MusicGameEnum.State_Runing)
end

function MusicGameMgr:getCurState()
	return self._state
end

function MusicGameMgr:_changeState(state)
	self._state = state
end

function MusicGameMgr:getDischargeType(index)
	return self._dischargeTypeList[index]
end

function MusicGameMgr:getCurDischargeCount()
	return self._curDischargeCount
end

function MusicGameMgr:setCurDischargeCount(value)
	self._curDischargeCount = value
end

function MusicGameMgr:getTotalDischargeCount()
	return self._totalDischargeCount
end

function MusicGameMgr:getLineStartVec(lineId)
	return self._lineStarVec[lineId]
end

function MusicGameMgr:getLineEndVec(lineId)
	return self._lineEndVec[lineId]
end

function MusicGameMgr:getLineCount()
	return self._lineCount
end

function MusicGameMgr:getCurGameTime()
	return self._curGameTime
end

function MusicGameMgr:setCurGameTime(value)
	self._curGameTime = value
end

function MusicGameMgr:getMaxGameTime()
	return self._maxGameTime
end

function MusicGameMgr:getLeftGameTime()
	return Mathf.Max(self._maxGameTime - self._curGameTime, 0)
end

function MusicGameMgr:getDischargeTime()
	return self._dischargeTime
end

function MusicGameMgr:getCurTotalScore()
	return self._curHitNum * self._symbolScoreRate
end

function MusicGameMgr:getCurHitNum()
	return self._curHitNum
end

function MusicGameMgr:addHitNum(delta)
	self._curHitNum = self._curHitNum + delta
end

function MusicGameMgr:getCurComboNum()
	return self._curComboNum
end

function MusicGameMgr:addComboNum(delta)
	self._curComboNum = self._curComboNum + delta
	self._maxComboNum = Mathf.Max(self._maxComboNum, self._curComboNum)
end

function MusicGameMgr:resetComboNum()
	self._curComboNum = -1
end

function MusicGameMgr:getMaxComboNum()
	return self._maxComboNum
end

return MusicGameMgr
