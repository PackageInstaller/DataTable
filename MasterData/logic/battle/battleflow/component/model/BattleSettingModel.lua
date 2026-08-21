-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/model/BattleSettingModel.lua

module("logic.battle.battleflow.component.model.BattleSettingModel", package.seeall)

local BattleSettingModel = class("BattleSettingModel", IBattleFlowComp)

function BattleSettingModel:onInit()
	self._maxRoundCount = 0
	self._isEnableCampAdjustment = false
	self._isSupportRestart = false
	self._isSupportUndo = false
	self._entityCountLimit = 0
	self._sortPriorityCareer = 0
	self._availableHeroMOList = {}
	self._bornUnionIndexList = {}
	self._bornDirectionList = {}
	self._lockedCharacterCodeList = {}
	self._assistantCharacterCodeList = {}
	self._forbiddenCareerList = {}
	self._forbiddenCampList = {}
	self._forbiddenRoleList = {}
	self._readyTimeLimit = 0
	self._trialHeroList = {}
	self._teamInfoMOList = {}
	self._killEntityCodeList = {}
	self._protectEntityCodeList = {}
	self._cameraWalkUnionIndexList = {}
	self._extensionViewClassList = {}
	self._enableAutoBattle = false
	self._enableShake = false
	self._isRequestUndo = false
	self._forbiddenMove = false
	self._forbiddenAutoPlay = false
	self._forbiddenSanityStrengthen = false
	self._forbiddenSkillTypeList = {}
	self._forbiddenSkillPurposeList = {}
end

function BattleSettingModel:onClear()
	self._maxRoundCount = 0
	self._entityCountLimit = 0
	self._sortPriorityCareer = 0
	self._isEnableCampAdjustment = false
	self._isSupportRestart = false
	self._isSupportUndo = false
	self._enableAutoBattle = false
	self._enableShake = false
	self._isRequestUndo = false
	self._readyTimeLimit = 0

	BattleTableUtil.clearReusableTable(self._teamInfoMOList)
	BattleTableUtil.clearTable(self._availableHeroMOList)
	BattleTableUtil.clearTable(self._bornUnionIndexList)
	BattleTableUtil.clearTable(self._bornDirectionList)
	BattleTableUtil.clearTable(self._cameraWalkUnionIndexList)
	BattleTableUtil.clearTable(self._lockedCharacterCodeList)
	BattleTableUtil.clearTable(self._assistantCharacterCodeList)
	BattleTableUtil.clearTable(self._killEntityCodeList)
	BattleTableUtil.clearTable(self._protectEntityCodeList)
	BattleTableUtil.clearTable(self._forbiddenCareerList)
	BattleTableUtil.clearTable(self._forbiddenCampList)
	BattleTableUtil.clearTable(self._forbiddenRoleList)
	BattleTableUtil.clearTable(self._trialHeroList)
	BattleTableUtil.clearTable(self._extensionViewClassList)
	BattleTableUtil.clearTable(self._forbiddenSkillTypeList)
	BattleTableUtil.clearTable(self._forbiddenSkillPurposeList)

	self._forbiddenMove = false
	self._forbiddenAutoPlay = false
	self._forbiddenSanityStrengthen = false
end

function BattleSettingModel:onStart()
	local flow = self.flow

	flow:fillExtensionViewClassList(self:getExtensionViewClassList())
end

function BattleSettingModel:internal_SetupSettings()
	local flow = self.flow
	local model = flow.model
	local operateCampId = model:getOperateCampId()

	self:setMaxRoundCount(flow:getMaxRoundCount())
	self:setEnableCampAdjustment(flow:isEnableCampAdjustment())
	self:setSupportRestart(flow:isSupportRestart())
	self:setSupportUndo(flow:isSupportUndo())
	self:setEntityCountLimit(flow:getEntityCountLimitOfCamp(operateCampId))
	self:setSortPriorityCareer(flow:getSortPriorityCareer())
	flow:fillCameraWalkUnionIndexListOfCamp(operateCampId, self:getCameraWalkUnionIndexList())
	flow:fillBornUnionIndexListOfCamp(operateCampId, self:getBornUnionIndexList(), self:getBornDirectionList())
	flow:fillLockedCharacterCodeListOfCamp(operateCampId, self:getLockedCharacterCodeList())
	flow:fillAssistantCharacterCodeListOfCamp(operateCampId, self:getAssistantCharacterCodeList())
	flow:fillKillEntityCodeListOfCamp(self:getKillEntityCodeList())
	flow:fillProtectEntityCodeListOfCamp(self:getProtectEntityCodeList())
	flow:fillForbiddenCareerList(self:getForbiddenCareerList())
	flow:fillForbiddenCampList(self:getForbiddenCampList())
	flow:fillForbiddenRoleList(self:getForbiddenRoleList())
	flow:fillAvailableHeroMOList(self:getAvailableHeroMOList())
	flow:fillForbiddenSkillTypeList(self:getForbiddenSkillByType())
	flow:fillForbiddenSkillPurposeList(self:getForbiddenSkillByPurpose())
	flow:fillTrialCharacterCodeList(self:getTrialHeroList())
	self:setForbiddenMove(flow:getForbiddenMoveStatus())

	local forbiddenAuto = flow:getForbiddenAutoStatus()

	self:setForbiddenAutoPlay(forbiddenAuto)

	if forbiddenAuto then
		self:setAutoBattle(false)
	end

	self:setShakeEnable(PlayerLocalStorageModel.instance:getShakeEnable())
	self:setForbiddenSanityStrengthen(flow:getForbiddenSkillStrengthenStatus())

	if model:isMultiPlayerMode() then
		self:setReadyTimeLimit(flow:getReadyTimeLimit())
		flow:fillTeamInfoMOList(self:getTeamInfoMOList())
	end
end

function BattleSettingModel:setEntityCountLimit(entityCountlimit)
	self._entityCountLimit = entityCountlimit
end

function BattleSettingModel:getEntityCountLimit()
	return self._entityCountLimit
end

function BattleSettingModel:setSortPriorityCareer(career)
	self._sortPriorityCareer = career
end

function BattleSettingModel:getSortPriorityCareer()
	return self._sortPriorityCareer
end

function BattleSettingModel:setMaxRoundCount(maxRoundCount)
	self._maxRoundCount = maxRoundCount
end

function BattleSettingModel:getMaxRoundCount()
	return self._maxRoundCount
end

function BattleSettingModel:isEnableCampAdjustment()
	return self._isEnableCampAdjustment
end

function BattleSettingModel:setEnableCampAdjustment(isEnableCampAdjustment)
	self._isEnableCampAdjustment = isEnableCampAdjustment
end

function BattleSettingModel:isSupportRestart()
	return self._isSupportRestart
end

function BattleSettingModel:setSupportRestart(isSupportRestart)
	self._isSupportRestart = isSupportRestart
end

function BattleSettingModel:isSupportUndo()
	return self._isSupportUndo
end

function BattleSettingModel:setSupportUndo(isSupportUndo)
	self._isSupportUndo = isSupportUndo
end

function BattleSettingModel:getAvailableHeroMOList()
	return self._availableHeroMOList
end

function BattleSettingModel:getBornUnionIndexList()
	return self._bornUnionIndexList
end

function BattleSettingModel:getBornDirectionList()
	return self._bornDirectionList
end

function BattleSettingModel:getCameraWalkUnionIndexList()
	return self._cameraWalkUnionIndexList
end

function BattleSettingModel:getLockedCharacterCodeList()
	return self._lockedCharacterCodeList
end

function BattleSettingModel:getAssistantCharacterCodeList()
	return self._assistantCharacterCodeList
end

function BattleSettingModel:getKillEntityCodeList()
	return self._killEntityCodeList
end

function BattleSettingModel:getProtectEntityCodeList()
	return self._protectEntityCodeList
end

function BattleSettingModel:getForbiddenCareerList()
	return self._forbiddenCareerList
end

function BattleSettingModel:getForbiddenCampList()
	return self._forbiddenCampList
end

function BattleSettingModel:getForbiddenRoleList()
	return self._forbiddenRoleList
end

function BattleSettingModel:getTrialHeroList()
	return self._trialHeroList
end

function BattleSettingModel:isForbiddenMove()
	return self._forbiddenMove
end

function BattleSettingModel:isForbiddenAutoPlay()
	return self._forbiddenAutoPlay
end

function BattleSettingModel:isForbiddenSanityStrengthen()
	return self._forbiddenSanityStrengthen
end

function BattleSettingModel:setForbiddenMove(status)
	self._forbiddenMove = status
end

function BattleSettingModel:setForbiddenAutoPlay(status)
	self._forbiddenAutoPlay = status
end

function BattleSettingModel:setForbiddenSanityStrengthen(status)
	self._forbiddenSanityStrengthen = status
end

function BattleSettingModel:getForbiddenSkillByType()
	return self._forbiddenSkillTypeList
end

function BattleSettingModel:getForbiddenSkillByPurpose()
	return self._forbiddenSkillPurposeList
end

function BattleSettingModel:isSkillForbiddenByType(skillType)
	return self._forbiddenSkillTypeList[skillType]
end

function BattleSettingModel:isSkillForbiddenByPurpose(skillPurpose)
	return self._forbiddenSkillPurposeList[skillPurpose]
end

function BattleSettingModel:getExtensionViewClassList()
	return self._extensionViewClassList
end

function BattleSettingModel:isAutoBattle()
	return self._enableAutoBattle
end

function BattleSettingModel:setAutoBattle(auto)
	self._enableAutoBattle = auto

	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleAutoModeUpdate, self._enableAutoBattle)
end

function BattleSettingModel:isRequestUndo()
	return self._isRequestUndo
end

function BattleSettingModel:setRequestUndo(isRequestUndo)
	self._isRequestUndo = isRequestUndo
end

function BattleSettingModel:isAutoFinishTurn()
	return PlayerLocalStorageModel.instance:getAutoEnd()
end

function BattleSettingModel:setEnableAutoFinishTurn(enable)
	PlayerLocalStorageModel.instance:setAutoEnd(enable)
end

function BattleSettingModel:isDoubleClickIdle()
	return PlayerLocalStorageModel.instance:getDoubleClickStandby()
end

function BattleSettingModel:setEnableDoubleClickIdle(enable)
	PlayerLocalStorageModel.instance:setDoubleClickStandby(enable)
end

function BattleSettingModel:isDoubleClickAttack()
	return PlayerLocalStorageModel.instance:getClickEnsure()
end

function BattleSettingModel:setEnableDoubleClickAttack(enable)
	PlayerLocalStorageModel.instance:setClickEnsure(enable)
end

function BattleSettingModel:isEnableDangerArea()
	return PlayerLocalStorageModel.instance:getAutoShowDangerous()
end

function BattleSettingModel:setEnableDangerArea(enable)
	PlayerLocalStorageModel.instance:setAutoShowDangerous(enable)
end

function BattleSettingModel:isEnableAIForecast()
	return PlayerLocalStorageModel.instance:getTargetPrediction()
end

function BattleSettingModel:setEnableAIForecast(enable)
	PlayerLocalStorageModel.instance:setTargetPrediction(enable)
end

function BattleSettingModel:getBattleSpeed()
	return PlayerLocalStorageModel.instance:getSpeedAdjust()
end

function BattleSettingModel:setBattleSpeed(speed)
	PlayerLocalStorageModel.instance:setSpeedAdjust(speed)
end

function BattleSettingModel:isEnableSkillPerformance(unit)
	if self.flow.model:isGamePlayConsecutive() then
		return false
	end

	local quality = PlayerLocalStorageModel.instance:getBattleAnimationQuality()

	if quality == 1 then
		return true
	end

	if quality == 2 then
		return false
	end

	return BattleCampRelationUtil.isSameOfOperateCamp(unit)
end

function BattleSettingModel:setReadyTimeLimit(readyTimeLimit)
	self._readyTimeLimit = readyTimeLimit
end

function BattleSettingModel:getReadyTimeLimit()
	return self._readyTimeLimit
end

function BattleSettingModel:getTeamInfoMOList()
	return self._teamInfoMOList
end

function BattleSettingModel:setShakeEnable(enable)
	self._enableShake = enable

	PlayerLocalStorageModel.instance:setShakeEnable(enable)
end

function BattleSettingModel:getShakeEnable()
	return self._enableShake
end

return BattleSettingModel
