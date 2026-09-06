-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/model/TripleMacthesModel.lua

module("logic.extensions.triplemacthesgame.model.TripleMacthesModel", package.seeall)

local TripleMacthesModel = class("TripleMacthesModel", BaseModel)

function TripleMacthesModel:ctor()
	return
end

function TripleMacthesModel:onInit()
	return
end

function TripleMacthesModel:onReset()
	self._targetGroup = {}
	self._gianPrizeIds = {}
	self._maxScore = -1
end

function TripleMacthesModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.TripleMacthesGame)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.TripleMacthesGame)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.TripleMacthesGame, v.activityId) then
			local cfg = TripleMachesGameConfig.instance:getActivityCfgById(v.activityId)

			if cfg then
				actId = cfg.activityId
			end

			break
		end
	end

	return actId
end

function TripleMacthesModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._dailyGameTimes = data.dailyGameTimes
	self._dailyBuyStepTimes = data.dailyBuyStepTimes
	self._gianPrizeIds = data.gianPrizeIds or {}
	self._maxScore = data.maxScore
end

function TripleMacthesModel:initGameInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._activityId = data.activityId
	self._stageId = data.stageId
	self._targetGroup = {}
	self._step = 0
	self._maxStep = 0
	self._comboScore = 0
	self._activityCfg = TripleMachesGameConfig.instance:getActivityCfgById(self._activityId)
	self._stageCfg = TripleMachesGameConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._maxStep = self._stageCfg.step
	self._buyStepCount = 0
	self._targetCfgs = TripleMachesGameConfig.instance:getTargetCfg(self._stageCfg.targetPlanId)

	local randomResult = GameUtil.getRandomMap(#self._targetCfgs, self._stageCfg.targetCount)

	for i, v in pairs(randomResult) do
		if v == true then
			table.insert(self._targetGroup, self._targetCfgs[i])
		end
	end

	table.sort(self._targetGroup, function(a, b)
		return a.targetId < b.targetId
	end)
end

function TripleMacthesModel:handlePM_TripleMatchesGameSweepRes(msg)
	self._dailyGameTimes = msg.dailyGameTimes
end

function TripleMacthesModel:getTotalScore()
	local removeCellType = TripleMacthesGameModel.instance:getRemoveCellType()
	local totalScore = 0

	for type, num in pairs(removeCellType or {}) do
		local blockCfg = TripleMachesGameConfig.instance:getBlockInfo(type)

		if blockCfg and num > 0 then
			totalScore = totalScore + blockCfg.score * num
		end
	end

	local createCellType = TripleMacthesGameModel.instance:getCreateCellType()

	for i, v in ipairs(self._targetGroup) do
		if v.type == "Collect" then
			local collectCount = 0
			local arr = string.split(v.params, "#")
			local typesArr = string.split(arr[1], ":")

			for j, typeStr in ipairs(typesArr) do
				local type = checknumber(typeStr)

				if removeCellType and removeCellType[type] then
					collectCount = collectCount + removeCellType[type]
				end
			end

			if collectCount >= checknumber(arr[2]) then
				totalScore = totalScore + v.score
			end
		elseif v.type == "CreateSpeical" then
			local collectCount = 0
			local arr = string.split(v.params, "#")
			local typesArr = string.split(arr[1], ":")

			for j, typeStr in ipairs(typesArr) do
				local type = checknumber(typeStr)

				if createCellType and createCellType[type] then
					collectCount = collectCount + createCellType[type]
				end
			end

			if collectCount >= checknumber(arr[2]) then
				totalScore = totalScore + v.score
			end
		end
	end

	totalScore = totalScore + self._comboScore

	return totalScore
end

function TripleMacthesModel:getStep()
	return self._maxStep - TripleMacthesGameModel.instance:getCurStep()
end

function TripleMacthesModel:getTargetGroup()
	return self._targetGroup
end

function TripleMacthesModel:setCombo(combo)
	local config = TripleMachesGameConfig.instance:getComboCfg()
	local comboScore = 0

	for i, v in ipairs(config.dataList) do
		if combo >= v.combo and comboScore < v.score then
			comboScore = v.score
		end
	end

	self._comboScore = self._comboScore + comboScore
end

function TripleMacthesModel:getActivityId()
	return self._activityId
end

function TripleMacthesModel:saveGameInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if data.save == true then
		self._dailyGameTimes = data.dailyGameTimes
		self._dailyBuyStepTimes = self._dailyBuyStepTimes + self._buyStepCount
	end

	self._buyStepCount = 0
end

function TripleMacthesModel:saveBuyStep(msg)
	self._buyStepCount = msg.buyStepCount
	self._maxStep = self._maxStep + self._activityCfg.addBuyStep
end

function TripleMacthesModel:getDailyBuyStepTimes()
	return self._dailyBuyStepTimes + (self._buyStepCount or 0)
end

function TripleMacthesModel:getBuyStepCount()
	return self._buyStepCount
end

function TripleMacthesModel:getStageId()
	return self._stageId
end

function TripleMacthesModel:getDailyGameTimes()
	return self._dailyGameTimes
end

function TripleMacthesModel:getMaxScore()
	return self._maxScore
end

function TripleMacthesModel:saveRankInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._myRank = data.myRank
	self._rankInfoList = data.rankInfoList
	self._dailyScore = checknumber(data.myScore)
end

function TripleMacthesModel:getRankInfo()
	return self._rankInfoList or {}
end

function TripleMacthesModel:getMyRank()
	return self._myRank
end

function TripleMacthesModel:getDailyScore()
	return self._dailyScore
end

function TripleMacthesModel:isGainProgressPrize(activityId, prizeId)
	return table.indexof(self._gianPrizeIds, prizeId)
end

function TripleMacthesModel:isCanGainProgressPrize(activityId, prizeId)
	if self:isGainProgressPrize(activityId, prizeId) then
		return false
	end

	local progressCfg = TripleMachesGameConfig.instance:getProgressPrizeCfg(activityId, prizeId)
	local gameCfg = TripleMachesGameConfig.instance:getActivityCfgById(activityId)
	local matStr = string.format("%s:%s", gameCfg.itemId, progressCfg.progress)

	return MaterialMgr.getMatEnough(matStr)
end

function TripleMacthesModel:updateGainPrizeId(activityId, prizeId)
	table.insert(self._gianPrizeIds, prizeId)
end

function TripleMacthesModel:initGameCfgByTourArena(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._targetGroup = {}
	self._step = 0
	self._maxStep = 0
	self._comboScore = 0
	self._activityCfg = TripleMachesGameConfig.instance:getActivityCfgById(self._activityId)
	self._stageCfg = TripleMachesGameConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._maxStep = self._stageCfg.step
	self._buyStepCount = 0
	self._targetCfgs = TripleMachesGameConfig.instance:getTargetCfg(self._stageCfg.targetPlanId)

	local randomResult = GameUtil.getRandomMap(#self._targetCfgs, self._stageCfg.targetCount)

	for i, v in pairs(randomResult) do
		if v == true then
			table.insert(self._targetGroup, self._targetCfgs[i])
		end
	end

	table.sort(self._targetGroup, function(a, b)
		return a.targetId < b.targetId
	end)
end

TripleMacthesModel.instance = TripleMacthesModel.New()

return TripleMacthesModel
