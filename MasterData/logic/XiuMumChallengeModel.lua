-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/model/XiuMumChallengeModel.lua

module("logic.extensions.xiumumchallenge.model.XiuMumChallengeModel", package.seeall)

local XiuMumChallengeModel = class("XiuMumChallengeModel", BaseModel)

function XiuMumChallengeModel:onInit()
	self:onReset()
end

function XiuMumChallengeModel:onReset()
	self._curActId = 0
	self._curPassStageId = 0
	self._curTier = 0
	self._roadIds = {}
	self._mapInfos = {}
	self._hpInfos = {}
	self._curPlace = 0
	self._CSId = 0
	self._customFmtMo = nil
	self._isTimeToMove = false
	self._isBattleWin = false
	self._isTimeDailyRefresh = false
end

XiuMumChallengeModel.PipeType = {
	EndPos = 4,
	StartPos = 1,
	StraigntLine = 2,
	BrokenLine = 3,
	None = 0
}
XiuMumChallengeModel.FaceType = {
	Bottom = 2,
	Right = 1,
	Top = 4,
	Left = 3,
	None = 0
}

function XiuMumChallengeModel:setDailyRefresh(state)
	self._isTimeDailyRefresh = state
end

function XiuMumChallengeModel:getDailyRefresh()
	return self._isTimeDailyRefresh
end

function XiuMumChallengeModel:getCurActId()
	return self._curActId
end

function XiuMumChallengeModel:onGetInfo(msg)
	self._isBattleWin = false
	self._curActId = msg.activityId
	self._curPassStageId = msg.passStageNum
	self._curTier = msg.curTier
	self._mapInfos = {}

	for _, info in ipairs(msg.map) do
		self._mapInfos[info.id] = info.time
	end

	self._roadIds = {}

	for _, id in ipairs(msg.road) do
		table.insert(self._roadIds, id)
	end

	self._hpInfos = {}

	for _, info in ipairs(msg.petHpInfos) do
		table.insert(self._roadIds, id)

		self._hpInfos[info.raceId] = info.hp
	end

	self._curPlace = msg.curPlace
	self._isTimeDailyRefresh = false
	self._isPassStage = false
end

function XiuMumChallengeModel:onPassGame(msg)
	self._isTimeToMove = true
end

function XiuMumChallengeModel:passCurStage()
	self._curPassStageId = self._curPassStageId + 1
	self._roadIds = {}
	self._mapInfos = {}
end

function XiuMumChallengeModel:onFinshChallenge(msg)
	self._hpInfos = {}

	for _, info in ipairs(msg.petHpInfos) do
		table.insert(self._roadIds, id)

		self._hpInfos[info.raceId] = info.hp
	end

	self._CSId = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	self._isBattleWin = false

	if msg.win then
		self._isBattleWin = true
		self._curPlace = msg.curPlace

		if not msg:HasField("nextBossPlace") then
			self:setIsPassStage(true)
		end

		self._isTimeToMove = true
	end
end

function XiuMumChallengeModel:setBattleSettlementCI()
	BattleSettlementModel.instance:setChangeSetId(self._CSId)

	self._CSId = nil
end

function XiuMumChallengeModel:checkPetHpInfo(raceId)
	local info = self._hpInfos[raceId]

	if info then
		return info
	else
		return 10000
	end
end

function XiuMumChallengeModel:getCurIsBattleWin()
	return self._isBattleWin
end

function XiuMumChallengeModel:getCurRoadData()
	return self._roadIds
end

function XiuMumChallengeModel:saveRoadData(dataList)
	self._roadIds = {}

	for _, data in ipairs(dataList) do
		table.insert(self._roadIds, checkint(data))
	end
end

function XiuMumChallengeModel:getCurMapData()
	return self._mapInfos
end

function XiuMumChallengeModel:saveMapData(dataList)
	self._mapInfos = {}

	for k, data in pairs(dataList) do
		self._mapInfos[k] = data
	end
end

function XiuMumChallengeModel:setCurPlace(placeId)
	self._curPlace = placeId
end

function XiuMumChallengeModel:getCurPlace()
	return self._curPlace
end

function XiuMumChallengeModel:getCurLevelCfgs()
	local tierCfg = XiuMumChallengeConfig.instance:getTierCfg(self._curActId, self._curTier)

	if tierCfg then
		return XiuMumChallengeConfig.instance:getStageCfgs(tierCfg.stagePlanId)
	end

	return {}
end

function XiuMumChallengeModel:getCurLevelCfg()
	local cfgs = self:getCurLevelCfgs()

	if cfgs then
		return cfgs[self._curPassStageId + 1]
	end

	return nil
end

function XiuMumChallengeModel:getCurPassStageId()
	return self._curPassStageId
end

function XiuMumChallengeModel:ShowCI()
	return
end

function XiuMumChallengeModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = XiuMumChallengeFmtMo.New()
	end

	return self._customFmtMo
end

function XiuMumChallengeModel:setIsTimeToMove(moveState)
	self._isTimeToMove = moveState
end

function XiuMumChallengeModel:getIsTimeToMove()
	return self._isTimeToMove
end

function XiuMumChallengeModel:getIsPassStage()
	return self._isPassStage
end

function XiuMumChallengeModel:setIsPassStage(bool)
	self._isPassStage = bool
end

XiuMumChallengeModel.instance = XiuMumChallengeModel.New()

return XiuMumChallengeModel
