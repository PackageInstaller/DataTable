-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/MiracleHeroModel.lua

module("logic.extensions.miraclehero.model.MiracleHeroModel", package.seeall)

local MiracleHeroModel = class("MiracleHeroModel", BaseModel)

function MiracleHeroModel:ctor()
	return
end

function MiracleHeroModel:onInit()
	self:onReset()
end

function MiracleHeroModel:onReset()
	self._curMo = nil
	self._moList = {}
end

function MiracleHeroModel:_getActMo(actId)
	if self._moList then
		local mo = self._moList[actId]

		if not self._moList then
			mo = {
				assistId = 0,
				myRank = -1,
				actId = actId,
				challengeInfoMap = {},
				positionInfoMap = {},
				rankInfos = {}
			}
			self._moList[actId] = self._moList
		end

		return self._moList
	end
end

function MiracleHeroModel:_createPositionMo(info)
	local posMo = {
		curRace = -1,
		posId = -1,
		level = 1
	}

	if info then
		posMo.posId = info.posId
		posMo.level = info.level
	end

	return posMo
end

function MiracleHeroModel:setCurActMo(actId)
	self._curMo = self._moList[actId]
end

function MiracleHeroModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	if not info.challenges then
		mo.challengeInfoMap = {}

		for _, challengeInfo in ipairs(info.challenges) do
			mo.challengeInfoMap[challengeInfo.challengeId] = challengeInfo.curStageId
		end

		mo.positionInfoMap = {}

		if not info.positions then
			for _, posInfo in ipairs(info.positions) do
				local posMo = self:_createPositionMo(posInfo)

				mo.positionInfoMap[posMo.posId] = posMo
			end
		end
	end
end

function MiracleHeroModel:onGetRankInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.rankInfos = info.rankInfos or {}
	mo.myRank = info.myRank or -1
end

function MiracleHeroModel:onUpgradePosition(msg)
	local info = GameUtil.pbToTable(msg)
	local posMo = self:getPositionMo(info.activityId, info.posId)

	posMo.level = info.curLevel
end

function MiracleHeroModel:onGetFormation(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	if not info.formation.raceIds then
		for posId, race in ipairs(info.formation.raceIds) do
			local posMo = self:_createPositionMo()
			local posMo = self:getPositionMo(info.activityId, posId)

			posMo.curRace = race
		end

		mo.assistId = info.formation.assistId
	end
end

function MiracleHeroModel:onSetFormation(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	if not info.formation.raceIds then
		for posId, race in ipairs(info.formation.raceIds) do
			local posMo = self:_createPositionMo()
			local posMo = self:getPositionMo(info.activityId, posId)

			posMo.curRace = race
		end

		mo.assistId = info.formation.assistId
	end
end

function MiracleHeroModel:onChallenge(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)
end

function MiracleHeroModel:onNotifyChallengeEnd(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	if info.isWin then
		mo.challengeInfoMap[info.challengeId] = info.stageId
	end
end

function MiracleHeroModel:getCurActId()
	return 383001
end

function MiracleHeroModel:getRankInfos(actId)
	local mo = self:_getActMo(actId)

	return mo.rankInfos
end

function MiracleHeroModel:getMyRank(actId)
	local mo = self:_getActMo(actId)

	return mo.myRank
end

function MiracleHeroModel:getPositionMap(actId)
	local mo = self:_getActMo(actId)

	return mo.positionInfoMap
end

function MiracleHeroModel:getPositionMo(actId, posId)
	local mo = self:_getActMo(actId)
	local posMo = mo.positionInfoMap[posId]

	if not posMo then
		posMo = self:_createPositionMo()
		posMo.posId = posId
		mo.positionInfoMap[posId] = posMo
	end

	return posMo
end

function MiracleHeroModel:getCurChallengeStageId(actId, challengeId)
	local mo = self:_getActMo(actId)

	return mo.challengeInfoMap[challengeId] or 0
end

function MiracleHeroModel:getIsPassChallenge(actId, challengeId)
	local curStageId = self:getCurChallengeStageId(actId, challengeId)
	local stageCfgs = MiracleHeroConfig.instance:getStageCfgs(actId, challengeId)

	return curStageId >= #stageCfgs
end

function MiracleHeroModel:getCurUnlockRaceId(actId)
	local petCfgs = MiracleHeroConfig.instance:getPetCfgs(actId)
	local unlockRaceIds = {}

	for _, cfg in pairs(petCfgs) do
		local unlockItemId = checknumber(cfg.unlockItemId)

		if unlockItemId > 0 then
			if MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, unlockItemId) > 0 then
				table.insert(unlockRaceIds, cfg.raceId)
			end
		elseif unlockItemId < 0 then
			-- block empty
		else
			table.insert(unlockRaceIds, cfg.raceId)
		end
	end

	return unlockRaceIds
end

function MiracleHeroModel:getCurUnlockAssistId(actId)
	local assistCfgs = MiracleHeroConfig.instance:getAssistCfgs(actId)
	local unlockAssists = {}

	for _, cfg in ipairs(assistCfgs) do
		local unlockItemId = checknumber(cfg.unlockItemId)

		if unlockItemId > 0 then
			if MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, unlockItemId) > 0 then
				table.insert(unlockAssists, cfg.assistId)
			end
		elseif unlockItemId < 0 then
			-- block empty
		else
			table.insert(unlockAssists, cfg.assistId)
		end
	end

	return unlockAssists
end

function MiracleHeroModel:checkRaceIdIsOnForm(actId, raceId)
	local mo = self:_getActMo(actId)

	for _, posMo in pairs(mo.positionInfoMap) do
		if posMo.curRace == raceId then
			return true
		end
	end

	return false
end

function MiracleHeroModel:getCurAssistId(actId)
	local mo = self:_getActMo(actId)

	return mo.assistId
end

function MiracleHeroModel:checkIsUnlock(actId, raceId)
	local unlockIds = self:getCurUnlockRaceId(actId) or {}

	return table.indexof(unlockIds, raceId)
end

MiracleHeroModel.SwitchRaceResult = {
	switchPos = 1,
	existSameElement = 3,
	switchRace = 2,
	none = 0
}

function MiracleHeroModel:switchRaceIdOnFormation(actId, raceIdList, setRaceId, setPosId)
	local result = MiracleHeroModel.SwitchRaceResult.none
	local setRaceOnFormPosId = table.indexof(raceIdList, setRaceId)
	local setPosRace = raceIdList[setPosId]

	if setRaceOnFormPosId then
		if setRaceId == setPosRace then
			result = MiracleHeroModel.SwitchRaceResult.none
		else
			raceIdList[setPosId] = setRaceId
			raceIdList[setRaceOnFormPosId] = setPosRace
			result = MiracleHeroModel.SwitchRaceResult.switchPos
		end
	else
		local setRaceCfg = MiracleHeroConfig.instance:getPetCfg(actId, setRaceId)
		local isNotExistSameElement = true

		for _, raceId in ipairs(raceIdList) do
			local raceCfg = MiracleHeroConfig.instance:getPetCfg(actId, raceId)

			if raceId ~= setPosRace and raceCfg.elementId == setRaceCfg.elementId then
				isNotExistSameElement = false

				break
			end
		end

		if isNotExistSameElement then
			raceIdList[setPosId] = setRaceId
			result = MiracleHeroModel.SwitchRaceResult.switchRace
		else
			result = MiracleHeroModel.SwitchRaceResult.existSameElement
		end
	end

	return raceIdList, result
end

function MiracleHeroModel:isAbleLevelUPPos(actId, posId)
	local posMo = self:getPositionMo(actId, posId)
	local positUpgradeCfgs = MiracleHeroConfig.instance:getPositUpgradeCfgs(actId)
	local curLevel = posMo.level

	if curLevel >= #positUpgradeCfgs then
		return false
	end

	local costStr = positUpgradeCfgs[curLevel + 1].cost

	return MaterialMgr.getMatEnough(costStr)
end

function MiracleHeroModel:getMyTeamTotalSpeed(actId, raceIdList)
	local mo = self:_getActMo(actId)
	local totalSpeed = 0

	for posId, raceId in ipairs(raceIdList) do
		local petCfg = MiracleHeroConfig.instance:getPetCfg(actId, raceId)
		local propertyCfgs = MiracleHeroConfig.instance:getPropertyCfgs(petCfg.propertyStrategyId)
		local posMo = self:getPositionMo(actId, posId)
		local propertyCfg = propertyCfgs[posMo.level]

		totalSpeed = totalSpeed + checknumber(propertyCfg.speed)
	end

	return totalSpeed
end

function MiracleHeroModel:getenemyTeamTotalSpeed(actId, creepsMasterId)
	local cfgs = MiracleHeroConfig.instance:getCreepsCfg(actId, creepsMasterId)
	local totalSpeed = 0

	for i, v in ipairs(cfgs) do
		local paramsStr = v.extproperties

		if not GameUtil.isEmptyString(paramsStr) then
			local attrs = FightingPowerFormula.instance:parseAttrValues(paramsStr)

			if attrs then
				totalSpeed = totalSpeed + (attrs[GameEnum.AttrType.Speed] or 0)
			end
		end
	end

	return totalSpeed
end

MiracleHeroModel.instance = MiracleHeroModel.New()

return MiracleHeroModel
