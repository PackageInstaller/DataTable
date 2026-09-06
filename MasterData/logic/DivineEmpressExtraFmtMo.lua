-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/model/DivineEmpressExtraFmtMo.lua

module("logic.extensions.divineempress.model.DivineEmpressExtraFmtMo", package.seeall)

local DivineEmpressExtraFmtMo = class("DivineEmpressExtraFmtMo", BaseCustomFmtMo)

function DivineEmpressExtraFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local stageCfg = DivineEmpressConfig.instance:getExtraStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = DivineEmpressConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = DivineEmpressConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self._blockRaceIdMap = {}
	self.selectBuffId = 1

	local buffCfgs = DivineEmpressConfig.instance:getBuffCfgs(self.activityId)

	for i, v in ipairs(buffCfgs) do
		if not DivineEmpressModel.instance:isBuffUsed(self.activityId, v.buffId) then
			self.selectBuffId = v.buffId

			break
		end
	end

	local debuffCfgs = DivineEmpressConfig.instance:getDebuffCfgs(self.activityId)

	self.selectDebuffId = 1

	for i, v in ipairs(debuffCfgs) do
		if not DivineEmpressModel.instance:isDebuffUsed(self.activityId, v.buffId) then
			self.selectDebuffId = v.buffId

			break
		end
	end
end

function DivineEmpressExtraFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineEmpressChallengeAgent.instance:sendPM_DivineEmpressExtremeClgReq(self.activityId, self.stageId, simpleForm, self.selectBuffId, self.selectDebuffId)
	end

	self:setFightHandler(handler, nil)
end

function DivineEmpressExtraFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineEmpressExtraFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DivineEmpressExtraFmtMo:getExtendViewName()
	return ViewName.DivineEmpressExtreFmtView
end

function DivineEmpressExtraFmtMo:checkPetIsForbit(petMo, baseCheck)
	if DivineEmpressModel.instance:isRaceLock(self.activityId, petMo.raceId) == true then
		return true
	end

	return false
end

function DivineEmpressExtraFmtMo:showForbitPetAlert(petMo)
	if self:checkPetIsForbit(petMo) == true then
		FloatWordMgr.instance:show(lang("该精灵已被封印"))
	end
end

return DivineEmpressExtraFmtMo
