-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/model/KdChallengeModel.lua

module("logic.extensions.kingdragonchallenge.model.KdChallengeModel", package.seeall)

local KdChallengeModel = class("KdChallengeModel", BaseModel)

function KdChallengeModel:ctor()
	return
end

function KdChallengeModel:onInit()
	self:onReset()
end

function KdChallengeModel:onReset()
	self._challengeId = 0
	self._loginTaskReceiveIds = {}
end

function KdChallengeModel:handlePM_TQKingDragonGetInfoRes(msg)
	self._challengeId = msg.challengeId
	self._bossInfo = msg.bossInfo
	self._stageInfo = msg.stageInfo
	self._unitInfo = msg.unitInfo
	self._loginDays = msg.loginDays
	self._loginTaskReceiveIds = msg.loginTaskReceiveIds
end

function KdChallengeModel:handlePM_TQKingDragonBossClgRes(msg)
	return
end

function KdChallengeModel:handlePM_TQKingDragonBossSweepRes(msg)
	self._bossInfo = msg.bossInfo
end

function KdChallengeModel:handlePM_TQKingDragonResultConfirmRes(msg)
	self._bossInfo = msg.bossInfo
	self._stageInfo = msg.stageInfo
	self._unitInfo = msg.unitInfo
	self._bossDamageInFlg = msg.bossDamage
end

function KdChallengeModel:handlePM_TQKingDragonBossGetPrizeRes(msg)
	return
end

function KdChallengeModel:handlePM_TQKingDragonBossBuyRes(msg)
	self._bossInfo = msg.bossInfo
end

function KdChallengeModel:handlePM_TQKingDragonUnitClgRes(msg)
	return
end

function KdChallengeModel:handlePM_TQKingDragonUnitBattleEndRes(msg)
	self._unitIdAsUnitBattleEnd = msg.unitId
	self._petHpInfoListAsUnitBattleEnd = msg.petHp
end

function KdChallengeModel:handlePM_TQKingDragonUnitResetRes(msg)
	self._unitInfo = msg.unitInfo
end

function KdChallengeModel:handlePM_TQKingDragonStageClgRes(msg)
	return
end

function KdChallengeModel:handlePM_TQKingDragonStageResetRes(msg)
	self._stageInfo = msg.stageInfo
end

function KdChallengeModel:handlePM_TQKingDragonStageForcePrizeRes(msg)
	self._stageInfo = msg.stageInfo
end

function KdChallengeModel:handlePM_TQKingDragonStageBattleWinRes(msg)
	self._stageInfo = msg.stageInfo
end

function KdChallengeModel:handlePM_TQKingDragonGetLoginTaskPrizeRes(msg)
	table.insert(self._loginTaskReceiveIds, msg)
end

function KdChallengeModel:getCurChallengeId()
	return self._challengeId
end

function KdChallengeModel:getCustomFmtMoAsKd(kdType)
	if self._customFmtMoPool == nil then
		self._customFmtMoPool = {}
	end

	local mo

	if kdType == GameEnum.KingDragonType.Boss then
		mo = self._customFmtMoPool[kdType] or KdBossCustomFmtMo.New()
	elseif kdType == GameEnum.KingDragonType.Stage then
		mo = self._customFmtMoPool[kdType] or KdStageCustomFmtMo.New()
	elseif kdType == GameEnum.KingDragonType.Unit then
		mo = self._customFmtMoPool[kdType] or KdUnitCustomFmtMo.New()
	end

	self._customFmtMoPool[kdType] = mo

	return mo
end

function KdChallengeModel:getBossInfo()
	return self._bossInfo
end

function KdChallengeModel:getChallengeTimesAsBoss()
	local info = self:getBossInfo()

	return (info or nil) and (info.tdChallengeTimes or 0)
end

function KdChallengeModel:getChallengeBuyTimesAsBoss()
	local info = self:getBossInfo()

	return (info or nil) and (info.tdChallengeBuyTimes or 0)
end

function KdChallengeModel:getTotalDmgAsBoss()
	local info = self:getBossInfo()

	return (info or nil) and (info.totalDmg or 0)
end

function KdChallengeModel:isHasGainPrizeAsBoss(id)
	local isHasGain = false
	local info = self:getBossInfo()

	if info == nil or info.gainPrize == nil then
		return isHasGain
	end

	for _, v in ipairs(info.gainPrize) do
		if v == id then
			isHasGain = true

			break
		end
	end

	return isHasGain
end

function KdChallengeModel:getMaxDmgAsBoss()
	local info = self:getBossInfo()

	return (info or nil) and (info.maxDmg or 0)
end

function KdChallengeModel:getBossDamageInFlg()
	return self._bossDamageInFlg or 0
end

function KdChallengeModel:getStageInfo()
	return self._stageInfo
end

function KdChallengeModel:getStageIdListAsStage()
	local info = self:getStageInfo()

	return (info or nil) and (info.stageIds or {})
end

function KdChallengeModel:getPassStageNumAsStage()
	local num = 0
	local stageIdList = self:getStageIdListAsStage()

	for _, stageId in ipairs(stageIdList) do
		if self:isPassStageAsStage(stageId) then
			num = num + 1
		end
	end

	return num
end

function KdChallengeModel:isPassStageAsStage(stageId)
	local isPass = false
	local info = self:getStageInfo()

	if info == nil or info.passStageIds == nil then
		return isPass
	end

	for _, v in ipairs(info.passStageIds) do
		if v == stageId then
			isPass = true

			break
		end
	end

	return isPass
end

function KdChallengeModel:isHasGainPrizeAsStage(stageId)
	local isHasGain = false
	local info = self:getStageInfo()

	if info == nil or info.prizeStageIds == nil then
		return isPisHasGainass
	end

	for _, v in ipairs(info.prizeStageIds) do
		if v == stageId then
			isHasGain = true

			break
		end
	end

	return isHasGain
end

function KdChallengeModel:getPrizeStageIdListAsStage()
	local info = self:getStageInfo()

	return (info or nil) and (info.prizeStageIds or {})
end

function KdChallengeModel:getPetHpRatioAsStage(petId)
	local info = self:getPetHpInfoAsStage(petId)

	return (info or nil) and (info.hpRatio or 10000)
end

function KdChallengeModel:getPetHpInfoAsStage(petId)
	local res
	local info = self:getStageInfo()

	if info == nil or info.petHp == nil then
		return res
	end

	for _, v in ipairs(info.petHp) do
		if v.id == petId then
			res = v

			break
		end
	end

	return res
end

function KdChallengeModel:getUnitInfo()
	return self._unitInfo
end

function KdChallengeModel:getRecordAsUnit(unitId)
	local res
	local info = self:getUnitInfo()

	if info == nil or info.unitRecord == nil then
		return res
	end

	for _, v in ipairs(info.unitRecord) do
		if v.unitId == unitId then
			res = v

			break
		end
	end

	return res
end

function KdChallengeModel:getBuffIdsAsUnit(unitId)
	local info = self:getRecordAsUnit(unitId)

	return (info or nil) and (info.buffIds or {})
end

function KdChallengeModel:isPassUnitAsUnit(unitId)
	local info = self:getRecordAsUnit(unitId)

	return (info or nil) and (info.pass or false)
end

function KdChallengeModel:getPetHpRatioAsUnit(petId)
	local info = self:getPetHpInfoAsUnit(petId)

	return (info or nil) and (info.hpRatio or 100000)
end

function KdChallengeModel:getPetHpInfoAsUnit(petId)
	local res
	local info = self:getUnitInfo()

	if info == nil or info.petHp == nil then
		return res
	end

	for _, v in ipairs(info.petHp) do
		if v.id == petId then
			res = v

			break
		end
	end

	return res
end

function KdChallengeModel:getUnitIdAsUnitBattleEnd()
	return self._unitIdAsUnitBattleEnd
end

function KdChallengeModel:getPetHpInfoListAsUnitBattleEnd()
	return self._petHpInfoListAsUnitBattleEnd
end

function KdChallengeModel:getLoginDays()
	return self._loginDays or 0
end

function KdChallengeModel:getLoginTaskIds()
	return self._loginTaskReceiveIds or {}
end

function KdChallengeModel:getLoginTaskList()
	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()
	local challengeCfg = KdChallengeConfig.instance:getKdChallengeData(challengeId)
	local taskCfg = KdChallengeConfig.instance:getTaskCfgByPlan(challengeCfg.loginTaskPlanId)
	local loginTaskReceiveIds = self:getLoginTaskIds()
	local list = {}

	if taskCfg then
		for k, v in pairs(taskCfg) do
			local state = self:getLoginDays() >= v.days

			v.state = table.indexof(loginTaskReceiveIds, v.days) and 3 or state and 1 or 2

			table.insert(list, v)
		end

		table.sort(list, function(a, b)
			if a.state == b.state then
				return a.days < b.days
			end

			return a.state < b.state
		end)
	end

	return list
end

function KdChallengeModel:addViewInfo(viewName, ...)
	self._viewInfo = self._viewInfo or {}

	local info = {}

	info.viewName = viewName
	info.params = {
		...
	}

	table.insert(self._viewInfo, info)
end

function KdChallengeModel:getViewInfos()
	return self._viewInfo or {}
end

function KdChallengeModel:clearViewInfos()
	self._viewInfo = {}
end

KdChallengeModel.instance = KdChallengeModel.New()

return KdChallengeModel
