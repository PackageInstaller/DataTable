-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/model/OriginWeiLeiTaNorFmtMo.lua

module("logic.extensions.originweileita.model.OriginWeiLeiTaNorFmtMo", package.seeall)

local OriginWeiLeiTaNorFmtMo = class("OriginWeiLeiTaNorFmtMo", BaseCustomFmtMo)

function OriginWeiLeiTaNorFmtMo:initParams(activityId, stageId, creepsMasterId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = creepsMasterId
	self._masterData = OriginWeiLeiTaConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginWeiLeiTaConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self.useMaxFightPower = true
end

function OriginWeiLeiTaNorFmtMo:updateData()
	local maxScore = OriginWeiLeiTaModel.instance:getTodayMaxScore(self._activityId)
	local cfg = OriginWeiLeiTaConfig.instance:getBuffCfgByScore(self._activityId, maxScore)

	if cfg then
		self.validatorDescStr = cfg.desc or "暂无敌阵加成"
	end

	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginWeiLeiTaNorFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginWeiLeiTaAgent.instance:sendPM_OriginWeiLeiTaNormalChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginWeiLeiTaNorFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginWeiLeiTaNorFmtMo:getFmtInfoConfig()
	return self._masterData
end

return OriginWeiLeiTaNorFmtMo
