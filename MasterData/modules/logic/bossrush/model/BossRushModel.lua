-- chunkname: @modules/logic/bossrush/model/BossRushModel.lua

module("modules.logic.bossrush.model.BossRushModel", package.seeall)

local BossRushModel = class("BossRushModel", Activity128Model)

function BossRushModel:onInit()
	BossRushModel.super.onInit(self)

	self._bossdetailMos = nil

	V3a2_BossRushModel.instance:init()
end

function BossRushModel:reInit()
	BossRushModel.super.reInit(self)

	local config = BossRushConfig.instance

	self:_internal_set_config(config)

	self._stage2LastTotalPoint = {}
	self._fightLastScore = 0
	self._fightCurScore = 0
	self._infiniteBossDeadSum = 0
	self._bossBloodCount = 0
	self._bossHP = 0
	self._bossIdList = nil
	self._fightScoreList = nil
	self._bossdetailMos = nil
end

function BossRushModel:setFightScore(num)
	self._fightLastScore = self:getFightScore()
	self._fightCurScore = num
end

function BossRushModel:checkFightScore(extra)
	local score = 0

	if extra then
		if extra.baseScore and extra.ruleScore then
			score = extra.baseScore + extra.ruleScore
		elseif not string.nilorempty(extra.score) then
			score = tonumber(extra.score)
		end
	end

	self:setFightScore(score)
end

function BossRushModel:noticeFightScore(num)
	local last = self._fightLastScore

	num = num or self._fightCurScore

	BossRushController.instance:dispatchEvent(BossRushEvent.OnScoreChange, last, num)
end

function BossRushModel:getFightScore()
	return self._fightCurScore or 0
end

function BossRushModel:checkIsNewHighestPointRecord(stage)
	return self:getFightScore() > self:getHighestPoint(stage)
end

function BossRushModel:getBossCurHP()
	return self._bossHP or 0
end

function BossRushModel:setInfiniteBossDeadSum(num)
	local last = self:getInfiniteBossDeadSum()

	self._infiniteBossDeadSum = num

	if last ~= num then
		BossRushController.instance:dispatchEvent(BossRushEvent.OnBossDeadSumChange, last, num)
	end
end

function BossRushModel:getInfiniteBossDeadSum()
	return self._infiniteBossDeadSum or 0
end

function BossRushModel:setBossBloodCount(num)
	local last = self:getBossBloodCount()

	self._bossBloodCount = num

	if last ~= num then
		BossRushController.instance:dispatchEvent(BossRushEvent.OnBloodCountChange, last, num)
	end
end

function BossRushModel:getBossBloodCount()
	return self._bossBloodCount or 0
end

function BossRushModel:setBossIdList(bossIdList)
	self._bossIdList = bossIdList
end

function BossRushModel:getBossIdList()
	return self._bossIdList
end

function BossRushModel:getBossBloodMaxCount()
	if not self._bossIdList then
		return 0
	end

	return #self._bossIdList
end

function BossRushModel:setBossCurHP(hp)
	local last = self._bossHP

	if hp == last then
		return
	end

	self._bossHP = hp

	BossRushController.instance:dispatchEvent(BossRushEvent.OnHpChange, last, hp)
end

function BossRushModel:getBossCurMaxHP()
	local mo = self:getBossEntityMO()

	if not mo then
		return 0
	end

	return mo.attrMO.hp
end

function BossRushModel:subBossBlood()
	self:setBossBloodCount(self:getBossBloodCount() - 1)
end

function BossRushModel:getCurBossIndex()
	return self:getBossBloodMaxCount() - math.max(0, self:getBossBloodCount())
end

function BossRushModel:_isFightBossId(monsterId)
	local bossIdList = self:getBossIdList()

	if not bossIdList then
		return false
	end

	for _, bossId in ipairs(bossIdList) do
		if monsterId == bossId then
			return true
		end
	end

	return false
end

function BossRushModel:getBossEntityMO()
	local enemyEntityMOList = FightDataHelper.entityMgr:getEnemyNormalList()

	for _, entityMO in ipairs(enemyEntityMOList) do
		local monsterId = entityMO.modelId

		if self:_isFightBossId(monsterId) then
			return entityMO
		end
	end
end

function BossRushModel:getBossEntityMOByCurBloodCount()
	if not self._bossIdList then
		return self:getBossEntityMO()
	end

	local max = self:getBossBloodMaxCount()
	local cur = math.max(0, self:getBossBloodCount())
	local index = max - cur
	local bossId = self._bossIdList[index]

	if not bossId then
		logError("[getBossEntityMOByCurBloodCount]: " .. string.format("max=%s, cur=%s, nowMax=%s", max, cur, #self._bossIdList))

		return self:getBossEntityMO()
	end

	local enemyEntityMOList = FightDataHelper.entityMgr:getEnemyNormalList()

	for _, entityMO in ipairs(enemyEntityMOList) do
		local monsterId = entityMO.modelId

		if bossId == monsterId then
			return entityMO
		end
	end
end

function BossRushModel:getMultiHpInfo()
	return {
		multiHpIdx = self:getBossBloodMaxCount() - self:getBossBloodCount(),
		multiHpNum = self:getBossBloodMaxCount()
	}
end

function BossRushModel:inUnlimit()
	local info = self:getMultiHpInfo()

	return info.multiHpNum - info.multiHpIdx <= 1
end

function BossRushModel:setBattleStageAndLayer(stage, layer, actId)
	self._battleStageTemp = stage
	self._battleLayerTemp = layer
	self._battleActIdTemp = actId
end

function BossRushModel:getBattleStageAndLayer()
	local episodeId = DungeonModel.instance.curSendEpisodeId

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or not episodeId then
		self:setBattleStageAndLayer(nil, nil)

		return 1, 1
	end

	local config = self:getConfig()

	if not self._battleStageTemp then
		self:setBattleStageAndLayer(config:tryGetStageAndLayerByEpisodeId(episodeId))
	end

	return self._battleStageTemp or 1, self._battleLayerTemp or 1, self._battleActIdTemp or BossRushConfig.instance:getActivityId()
end

function BossRushModel:_onReceiveGet128InfosReply(msg)
	self:_initStageLastTotalPoint()
	BossRushRedModel.instance:refreshAllStageLayerUnlockState()
	V3a9_BossRushModel.instance:refreshBossDetailMos(msg)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveGet128InfosReply)
end

function BossRushModel:_onReceiveAct128GetTotalRewardsReply(msg)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveAct128GetTotalRewardsReply)
end

function BossRushModel:_onReceiveAct128DoublePointReply(msg)
	local doublePoint = msg.doublePoint
	local totalPoint = msg.totalPoint

	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveAct128DoublePointRequestReply, totalPoint, doublePoint)
end

function BossRushModel:_onReceiveAct128InfoUpdatePush(msg)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveAct128InfoUpdatePush)
end

function BossRushModel:onEndDungeonExtraStr(extraStr)
	local extra = not string.nilorempty(extraStr) and cjson.decode(extraStr)

	V3a2_BossRushModel.instance:setScore(extra)
	self:checkFightScore(extra)
	self:_setEvaluate(extra and extra.evaluate)
end

function BossRushModel:_setEvaluate(extraStr)
	self._evaluateList = {}

	if extraStr then
		if not string.nilorempty(extraStr) then
			self._evaluateList = string.splitToNumber(extraStr, "#")
		end

		BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveGet128EvaluateReply)
	end
end

function BossRushModel:_onReceiveAct128SingleRewardReply(msg)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveGet128SingleRewardReply, msg)
end

function BossRushModel:getActivityDurationInfo()
	return {
		st = self:getRealStartTimeStamp(),
		ed = self:getRealEndTimeStamp()
	}
end

function BossRushModel:getStagePointInfo(stage)
	local config = self:getConfig()
	local max = config:getStageCOMaxPoints(stage)

	return {
		cur = self:getTotalPoint(stage),
		max = max
	}
end

function BossRushModel:getDoubleTimesInfo(stage)
	local info = self:getStageInfo(stage)
	local config = self:getConfig()
	local max = config:InfiniteDoubleMaxTimes()
	local var_36_0 = {}

	if info then
		var_36_0.cur = max - info.doubleNum or 0
	end

	var_36_0.max = max

	return var_36_0
end

function BossRushModel:getStagesInfo(activityId)
	local res = {}
	local config = self:getConfig()
	local stages = config:getStages()

	if not stages then
		return
	end

	for _, stageCO in pairs(stages) do
		local stage = stageCO.stage

		res[#res + 1] = {
			stage = stage,
			stageCO = stageCO
		}
	end

	table.sort(res, function(a, b)
		return a.stage < b.stage
	end)

	return res
end

function BossRushModel:getStageLayerInfo(stage, layer)
	local infos = self:getStagesInfo()

	for _, v in ipairs(infos) do
		if v.stage == stage then
			v.selectedIndex = self:layer2Index(stage, layer)

			return v
		end
	end
end

function BossRushModel:getStageLayersInfo(stage)
	local res = {}
	local config = self:getConfig()
	local episodeStages = config:getEpisodeStages(stage)

	for _, layerCO in pairs(episodeStages) do
		local layer = layerCO.layer

		res[#res + 1] = {
			layer = layer,
			layerCO = layerCO,
			isInfinite = config:isInfinite(stage, layer),
			isOpen = self:isBossLayerOpen(stage, layer)
		}
	end

	table.sort(res, function(a, b)
		local a_layer = a.layer
		local b_layer = b.layer

		if a_layer ~= b_layer then
			return a_layer < b_layer
		end
	end)

	return res
end

function BossRushModel:getTaskMoListByStage(stage)
	local config = self:getConfig()
	local taskMoList = self:getTaskMoList()
	local res = {}

	for _, taskMO in ipairs(taskMoList) do
		local id = taskMO.id
		local taskCO = config:getTaskCO(id)
		local listenerParam = taskCO.listenerParam

		if taskCO.listenerType == BossRushEnum.TaskListenerType.highestPoint then
			local tmp = string.split(listenerParam, "#")
			local needStage = tonumber(tmp[1])

			if stage == needStage then
				res[#res + 1] = taskMO
			end
		end
	end

	return res
end

function BossRushModel:getLayer4RewardMoListByStage(stage)
	local config = self:getConfig()
	local taskMoList = self:getTaskMoList()
	local res = {}

	for _, taskMO in ipairs(taskMoList) do
		local id = taskMO.id
		local taskCO = config:getTaskCO(id)
		local listenerParam = taskCO.listenerParam

		if taskCO.listenerType == BossRushEnum.TaskListenerType.layer4Reward then
			local tmp = string.split(listenerParam, "#")
			local needStage = tonumber(tmp[1])

			if stage == needStage then
				res[#res + 1] = taskMO
			end
		end
	end

	return res
end

function BossRushModel:getMoListByStageAndType(stage, listenerType, scoreDesc)
	local config = self:getConfig()
	local taskMoList = self:getTaskMoList()
	local res = {}

	for _, taskMO in ipairs(taskMoList) do
		local id = taskMO.id
		local taskCO = config:getTaskCO(id)
		local listenerParam = taskCO.listenerParam

		taskMO.ScoreDesc = scoreDesc

		if taskCO.listenerType == listenerType then
			local tmp = string.split(listenerParam, "#")
			local needStage = tonumber(tmp[1])

			if stage == needStage then
				res[#res + 1] = taskMO
			end
		end
	end

	return res
end

function BossRushModel:getScheduleViewRewardList(stage)
	local res = {}
	local stageRewardList = BossRushConfig.instance:getStageRewardList(stage)

	for _, v in ipairs(stageRewardList) do
		local id = v.id
		local isGot = self:hasGetBonusIds(stage, id)

		res[#res + 1] = {
			isGot = isGot,
			stageRewardCO = v
		}
	end

	return res
end

function BossRushModel:getSpecialScheduleViewRewardList(stage)
	local res = {}
	local stageRewardList = BossRushConfig.instance:getActLayer4rewards(stage)
	local curScore = self:getLayer4CurScore(stage)

	for _, v in ipairs(stageRewardList) do
		local isGot = curScore >= v.maxProgress

		res[#res + 1] = {
			isGot = isGot,
			config = v
		}
	end

	return res
end

function BossRushModel:checkAnyRewardClaim(stage)
	local info = self:getStageInfo(stage)

	if info then
		if not info.totalPoint then
			local totalPoint = 0

			return self:calcRewardClaim(stage, totalPoint, true)
		end
	end
end

function BossRushModel:calcRewardClaim(stage, pointNum, isFirst)
	local stageRewardList = BossRushConfig.instance:getStageRewardList(stage)
	local ok = false
	local index = 0

	for i, stageRewardCO in ipairs(stageRewardList) do
		local id = stageRewardCO.id
		local rewardPointNum = stageRewardCO.rewardPointNum
		local isGot = self:hasGetBonusIds(stage, id)

		if isGot then
			index = i
		elseif rewardPointNum <= pointNum then
			ok = true
			index = i

			if isFirst then
				break
			end
		end
	end

	return ok, index
end

function BossRushModel:getScheduleViewRewardNoGotIndex(stage)
	local stageRewardList = BossRushConfig.instance:getStageRewardList(stage)
	local res = #stageRewardList

	for i, stageRewardCO in ipairs(stageRewardList) do
		local id = stageRewardCO.id
		local isGot = self:hasGetBonusIds(stage, id)

		if not isGot then
			return true, i
		end
	end

	return false, res
end

function BossRushModel:getResultPanelProgressBarPointList(stage, score)
	score = score or 0

	local stageRewardList = BossRushConfig.instance:getStageRewardList(stage)
	local res = {}

	for _, stageRewardCO in ipairs(stageRewardList) do
		local isGray = score < stageRewardCO.rewardPointNum

		res[#res + 1] = {
			isGray = isGray,
			stageRewardCO = stageRewardCO
		}
	end

	return res
end

function BossRushModel:clearStageScore()
	self._fightScoreList = nil
end

function BossRushModel:snapShotFightScore(score)
	self._fightScoreList = self._fightScoreList or {}

	local list = self._fightScoreList

	if self:getBossBloodCount() <= 1 then
		return
	end

	table.insert(list, score)
end

function BossRushModel:getStageScore()
	if not self._fightScoreList then
		return {
			self:getFightScore()
		}
	end

	local res = {}
	local list = self._fightScoreList
	local maxBloodCount = self:getBossBloodMaxCount()
	local sum = 0
	local n = math.min(#list + 1, maxBloodCount)

	for i = 1, n - 1 do
		local score = list[i] - ((not list[i - 1] or nil) and 0)

		res[#res + 1] = score
		sum = sum + score
	end

	if n > 1 then
		local finalScore = self:getFightScore()

		res[#res + 1] = finalScore - sum
	end

	if n < maxBloodCount then
		for i = n + 1, maxBloodCount do
			res[#res + 1] = 0
		end
	end

	return res
end

function BossRushModel:getUnlimitedHpColor()
	return {
		[BossRushEnum.HpColor.Red] = "#B33E2D",
		[BossRushEnum.HpColor.Orange] = "#D9852B",
		[BossRushEnum.HpColor.Yellow] = "#B3A574",
		[BossRushEnum.HpColor.Green] = "#69995E",
		[BossRushEnum.HpColor.Blue] = "#4C8699",
		[BossRushEnum.HpColor.Purple] = "#86568F"
	}
end

function BossRushModel:getUnlimitedTopAndBotHpColor(num)
	local colorTable = self:getUnlimitedHpColor()
	local top = num % #colorTable + 1
	local bot = top + 1 > #colorTable and 1 or top + 1
	local red = colorTable[BossRushEnum.HpColor.Red]
	local topCol = colorTable[top]
	local topColor = string.nilorempty(topCol) and red or topCol
	local botCol = colorTable[bot]
	local botColor = string.nilorempty(botCol) and red or botCol

	if string.nilorempty(topCol) then
		if not BossRushEnum.HpColor.Red then
			local col = top

			return topColor, botColor, col
		end
	end
end

function BossRushModel:syncUnlimitedHp(index, fillAmount)
	self._unlimitHp = self._unlimitHp or {}
	self._unlimitHp.fillAmount = fillAmount

	if index then
		self._unlimitHp.index = index
	end
end

function BossRushModel:resetUnlimitedHp()
	self._unlimitHp = nil
end

function BossRushModel:setStageLastTotalPoint(stage, value)
	self._stage2LastTotalPoint[stage] = tonumber(value)
end

function BossRushModel:_getStageLastTotalPoint(stage)
	return self._stage2LastTotalPoint[stage] or 0
end

function BossRushModel:_initStageLastTotalPoint()
	if next(self._stage2LastTotalPoint) then
		return
	end

	local stages = BossRushConfig.instance:getStages()

	if not stages then
		return
	end

	for _, v in pairs(stages) do
		local stage = v.stage
		local info = self:getStageInfo(stage)

		self:setStageLastTotalPoint(stage, (info or nil) and (info.totalPoint or 0))
	end
end

function BossRushModel:getLastPointInfo(stage)
	local info = self:getStagePointInfo(stage)

	info.last = self:_getStageLastTotalPoint(stage)

	return info
end

local kPlayerPrefsKey1 = "Version1_4_BossRushSelectedLayer_"

function BossRushModel:setLastMarkSelectedLayer(stage, level)
	local key = self:_getSelectedLayerKey(stage)

	if not tonumber(level) then
		return
	end

	GameUtil.playerPrefsSetNumberByUserId(key, level)
end

function BossRushModel:getLastMarkSelectedLayer(stage)
	local key = self:_getSelectedLayerKey(stage)

	return GameUtil.playerPrefsGetNumberByUserId(key, 1)
end

function BossRushModel:_getSelectedLayerKey(stage)
	return (string.format("%s_%s_%s", kPlayerPrefsKey1, BossRushConfig.instance:getActivityId(), stage))
end

function BossRushModel:layer2Index(stage, layer)
	local config = self:getConfig()
	local episodeStages = config:getEpisodeStages(stage)

	for i, layerCO in pairs(episodeStages) do
		if layer == layerCO.layer then
			return i
		end
	end

	return 1
end

function BossRushModel:getEvaluateList()
	return self._evaluateList
end

function BossRushModel:getActivityMo()
	local actId = BossRushConfig.instance:getActivityId()

	if actId then
		local infos = ActivityModel.instance:getActivityInfo()

		return infos and infos[actId]
	end
end

function BossRushModel:isSpecialActivity()
	local stages = BossRushConfig.instance:getStages()

	for _, v in pairs(stages) do
		local stage = v.stage
		local episodeStages = BossRushConfig.instance:getEpisodeStages(stage)

		if #episodeStages > 3 then
			return true
		end
	end
end

function BossRushModel:isEnhanceRole(stage, layer)
	if not stage or not layer then
		return false
	end

	local episodeCo = BossRushConfig.instance:getEpisodeCO(stage, layer)

	if not episodeCo then
		return false
	end

	return episodeCo.enhanceRole == 1
end

function BossRushModel:getLayer4MaxRewardScore(stage)
	local configs = BossRushConfig.instance:getActLayer4rewards(stage)
	local max = 0

	for _, co in pairs(configs) do
		max = co.maxProgress
	end

	return max
end

function BossRushModel:isSpecialLayerCurBattle()
	local isInBossRush = BossRushController.instance:isInBossRushFight()

	if isInBossRush then
		local _, layer = self:getBattleStageAndLayer()

		return self:isSpecialLayer(layer)
	end

	return false
end

function BossRushModel:isSpecialLayer(layer)
	return layer and layer == 4
end

BossRushModel.instance = BossRushModel.New()

return BossRushModel
