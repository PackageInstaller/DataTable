-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/model/OriginPowersClgExteremeFmtMo.lua

module("logic.extensions.originpowersclg.model.OriginPowersClgExteremeFmtMo", package.seeall)

local OriginPowersClgExteremeFmtMo = class("OriginPowersClgExteremeFmtMo", BaseCustomFmtMo)

function OriginPowersClgExteremeFmtMo:onInit()
	OriginPowersClgExteremeFmtMo.super.onInit(self)
end

function OriginPowersClgExteremeFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local stageCfg = OriginPowersClgConfig.instance:getExtremeStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = OriginPowersClgConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = OriginPowersClgConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self._lockRaceIdMap = OriginPowersClgController.instance:getExtAllLockPetMap(self.activityId)
end

function OriginPowersClgExteremeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginPowersClgAgent.instance:sendPM_OriginPowersExtremeChallengeReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginPowersClgExteremeFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginPowersClgExteremeFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function OriginPowersClgExteremeFmtMo:checkPetIsForbit(petMo, baseCheck)
	if self._lockRaceIdMap[petMo.raceId] == true then
		return true
	end

	return false
end

function OriginPowersClgExteremeFmtMo:showForbitPetAlert(petMo)
	if self._lockRaceIdMap[petMo.raceId] == true then
		FloatWordMgr.instance:show(lang("该精灵已被封印"))
	end
end

return OriginPowersClgExteremeFmtMo
