-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/model/OriginDiShiTianFmtMo.lua

module("logic.extensions.originpowersclg.model.OriginDiShiTianFmtMo", package.seeall)

local OriginDiShiTianFmtMo = class("OriginDiShiTianFmtMo", BaseCustomFmtMo)

function OriginDiShiTianFmtMo:onInit()
	OriginDiShiTianFmtMo.super.onInit(self)
end

function OriginDiShiTianFmtMo:initParams(activityId, stageId, missionView)
	self.activityId = activityId
	self.stageId = stageId

	local stageCfg = OriginDiShiTianConfig.instance:getStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = OriginDiShiTianConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = OriginDiShiTianConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self._lockRaceIdMap = OriginDiShiTianController.instance:getAllLockPetMap(self.activityId)
	self._missionView = missionView
end

function OriginDiShiTianFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginDiShiTianClgAgent.instance:sendPM_OriginDiShiTianClgFightReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginDiShiTianFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginDiShiTianFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function OriginDiShiTianFmtMo:getExtendViewName()
	if self._missionView then
		return self._missionView
	end

	return ViewName.OriginDiShiTianFmtView
end

function OriginDiShiTianFmtMo:checkPetIsForbit(petMo, baseCheck)
	if self._lockRaceIdMap[petMo.raceId] == true then
		return true
	end

	return false
end

function OriginDiShiTianFmtMo:showForbitPetAlert(petMo)
	if self._lockRaceIdMap[petMo.raceId] == true then
		FloatWordMgr.instance:show(lang("该精灵已被封印"))
	end
end

return OriginDiShiTianFmtMo
