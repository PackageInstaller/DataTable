-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/model/OriginaresmomExtFmtMo.lua

module("logic.extensions.originaresmom.model.OriginaresmomExtFmtMo", package.seeall)

local OriginaresmomExtFmtMo = class("OriginaresmomExtFmtMo", BaseCustomFmtMo)

function OriginaresmomExtFmtMo:initParams(activityId, stageId, creepsMasterId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = creepsMasterId
	self._masterData = OriginaresmomConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginaresmomConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._lockRaceIdMap = OriginaresmomModel.instance:getExtLockRaceIdMap(activityId)
end

function OriginaresmomExtFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginaresmomExtFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginAresMomClgAgent.instance:sendPM_OriginAresMomClgExtremeChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginaresmomExtFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginaresmomExtFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginaresmomExtFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self._lockRaceIdMap[petMo.raceId]
end

function OriginaresmomExtFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show("精灵锁定，无法上阵")
end

return OriginaresmomExtFmtMo
