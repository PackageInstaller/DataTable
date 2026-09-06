-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/model/DivineZhongFeiClgExtFmtMo.lua

module("logic.extensions.divinezhongfeiclg.model.DivineZhongFeiClgExtFmtMo", package.seeall)

local DivineZhongFeiClgExtFmtMo = class("DivineZhongFeiClgExtFmtMo", BaseCustomFmtMo)

function DivineZhongFeiClgExtFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local stageCfg = DivineZhongFeiClgConfig.instance:getExtremeStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = DivineZhongFeiClgConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = DivineZhongFeiClgConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	local buffCfgs = DivineZhongFeiClgConfig.instance:getExtBuffCfgs(self.activityId)
	local list = {}

	for i, v in pairs(buffCfgs) do
		table.insert(list, {
			cfg = v
		})
	end

	table.sort(list, function(a, b)
		return a.cfg.killNum < b.cfg.killNum
	end)

	for i, v in ipairs(list) do
		v.index = i
	end

	local curScore = DivineZhongFeiClgModel.instance:getExtStageTotalScore(self.activityId)
	local activeBuffIndex = 0

	for i, v in ipairs(list) do
		if curScore >= v.cfg.killNum then
			activeBuffIndex = v.index
		end
	end

	self.validatorDescStr = activeBuffIndex > 0 and list[activeBuffIndex].cfg.desc or ""
end

function DivineZhongFeiClgExtFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineZhongFeiClgAgent.instance:sendPM_DivineZhongFeiClgExtremeChallengeReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineZhongFeiClgExtFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineZhongFeiClgExtFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DivineZhongFeiClgExtFmtMo:checkPetIsForbit(petMo, baseCheck)
	return DivineZhongFeiClgModel.instance:isPetLock(self.activityId, petMo.raceId)
end

function DivineZhongFeiClgExtFmtMo:showForbitPetAlert(petMo)
	if DivineZhongFeiClgModel.instance:isPetLock(self.activityId, petMo.raceId) == true then
		FloatWordMgr.instance:show(lang("精灵已被封印"))
	end
end

return DivineZhongFeiClgExtFmtMo
