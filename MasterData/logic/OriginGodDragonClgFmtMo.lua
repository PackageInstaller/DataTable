-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/model/OriginGodDragonClgFmtMo.lua

module("logic.extensions.origingoddragonclg.model.OriginGodDragonClgFmtMo", package.seeall)

local OriginGodDragonClgFmtMo = class("OriginGodDragonClgFmtMo", BaseCustomFmtMo)

function OriginGodDragonClgFmtMo:onReset()
	OriginGodDragonClgFmtMo.super.onReset(self)
end

function OriginGodDragonClgFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = OriginGodDragonClgConfig.instance:getStageData(self._activityId, self._stageId)

	self._zoneId = stageData.zoneId
	self._subMo = OriginGodDragonClgController.instance:getSubMo(self._activityId)
	self._creepsMasterId = stageData.creepsMasterId
	self._creepsTeamData = OriginGodDragonClgConfig.instance:getCreepsTeamData(self._creepsMasterId)
	self._creepsCfg = OriginGodDragonClgConfig.instance:getCreepsDatas(self._creepsMasterId)
	self.topTitleStr = self._creepsTeamData.name
	self.validatorDescStr = self._creepsTeamData.missionDesc
	self.ruleDescStr = self._creepsTeamData.WinDesc

	self:setFormCondition(self._creepsTeamData.formCondition)

	self._lockedRaceIdMap = self._subMo:getAllLockRaceIds()
end

function OriginGodDragonClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginGodDragonClgController.instance:sendPM_OriginGodDragonClgChallengeReq(self._activityId, self._zoneId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginGodDragonClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginGodDragonClgFmtMo:getFmtInfoConfig()
	return self._creepsTeamData
end

function OriginGodDragonClgFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function OriginGodDragonClgFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function OriginGodDragonClgFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if OriginGodDragonClgFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function OriginGodDragonClgFmtMo:_isPetLock(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	return self._lockedRaceIdMap[raceId]
end

return OriginGodDragonClgFmtMo
