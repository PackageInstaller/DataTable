-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/model/WeakPathFindingModel.lua

module("logic.extensions.weakpathfinding.model.WeakPathFindingModel", package.seeall)

local WeakPathFindingModel = class("WeakPathFindingModel", BaseModel)

function WeakPathFindingModel:onInit()
	self:onReset()
end

function WeakPathFindingModel:onReset()
	self._curActId = 0
	self._allTimes = 0
	self._todayTimes = 0
	self._curState = 0
	self._curSceneId = 0
	self._curNpcId = 0
	self._curGameStartTime = 0
	self._curGameId = 0
	self._gainPrizeIds = {}
	self._curGainPrizeId = 0
	self._curResult = 2
end

function WeakPathFindingModel:onGetInfo(msg)
	self._allTimes = checkint(msg.allTimes)
	self._todayTimes = checkint(msg.todayTimes)
	self._curState = checkint(msg.state)

	if self._curState == 1 then
		self._curSceneId = checkint(msg.npcSceneId)
		self._curNpcId = checkint(msg.npcId)
	elseif self._curState == 2 then
		self._curGameId = checkint(msg.gameId)
		self._curGameStartTime = checkint(msg.gameStartTime)
	end

	self._gainPrizeIds = msg.prizeId or {}
	self._curGainPrizeId = 0
	self._curResult = 2
end

function WeakPathFindingModel:onStartFinding(msg)
	self._curState = 1
	self._curSceneId = checkint(msg.npcSceneId)
	self._curNpcId = checkint(msg.npcId)
end

function WeakPathFindingModel:onStartGame(msg)
	self._curGameId = checkint(msg.gameId)
	self._curGameStartTime = checkint(msg.gameStartTime)
	self._curSceneId = 0
	self._curNpcId = 0
	self._curState = 2
	self._curResult = 2
end

function WeakPathFindingModel:onEndGame(msg)
	self._curState = 0
	self._curResult = checkint(msg.result)

	if self._curResult == 0 then
		self._todayTimes = self._todayTimes + 1
		self._allTimes = self._allTimes + 1
	end

	self._curGameId = 0
	self._curGameStartTime = 0
end

function WeakPathFindingModel:onGainPrize(msg)
	if self._curGainPrizeId ~= 0 then
		table.insert(self._gainPrizeIds, self._curGainPrizeId)
	end

	self._curGainPrizeId = 0
end

function WeakPathFindingModel:getCurActTimeCfg()
	return ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.WeakPathFinding)
end

function WeakPathFindingModel:getCurActId()
	return self._curActId
end

function WeakPathFindingModel:getCurTodayTimes()
	return self._todayTimes
end

function WeakPathFindingModel:getCurTotalTimes()
	return self._allTimes
end

function WeakPathFindingModel:getCurState()
	return self._curState
end

function WeakPathFindingModel:getIsGainPrizeState(id)
	return table.keyof(self._gainPrizeIds, id)
end

function WeakPathFindingModel:getCurSceneId()
	return self._curSceneId
end

function WeakPathFindingModel:getCurNpcTemId()
	return self._curNpcId
end

function WeakPathFindingModel:getCurNpcId()
	return WeakPathFindingConfig.instance:getNpcId(self._curSceneId, self._curNpcId)
end

function WeakPathFindingModel:getCurGameId()
	return self._curGameId
end

function WeakPathFindingModel:getCurGameStartTime()
	return self._curGameStartTime
end

function WeakPathFindingModel:getCurResult()
	return self._curResult
end

function WeakPathFindingModel:setCurActId(actId)
	self._curActId = checkint(actId)
end

function WeakPathFindingModel:setCurGainPrizeId(id)
	self._curGainPrizeId = checkint(id)
end

WeakPathFindingModel.instance = WeakPathFindingModel.New()

return WeakPathFindingModel
