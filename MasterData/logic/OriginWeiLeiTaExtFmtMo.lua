-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/model/OriginWeiLeiTaExtFmtMo.lua

module("logic.extensions.originweileita.model.OriginWeiLeiTaExtFmtMo", package.seeall)

local OriginWeiLeiTaExtFmtMo = class("OriginWeiLeiTaExtFmtMo", BaseCustomFmtMo)

function OriginWeiLeiTaExtFmtMo:initParams(activityId, stageId, creepsMasterId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = creepsMasterId
	self._masterData = OriginWeiLeiTaConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginWeiLeiTaConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._stageCfg = OriginWeiLeiTaConfig.instance:getExtStageCfg(self._activityId, self._stageId)
	self._lockRaceIdMap = OriginWeiLeiTaModel.instance:getExtLockRaceIdMap(activityId)

	self:clearAllFixedEffects()

	for posId, signId in ipairs(self._stageCfg.selfPositionBuffs) do
		if signId > 0 then
			local signCfg = OriginWeiLeiTaConfig.instance:getSignCfg(activityId, signId)

			self:setFixedEffect(posId, signCfg.effect)
		end
	end
end

function OriginWeiLeiTaExtFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc
	self.validatorDescStr = string.format("激活所有标记为通关：厄运（紫色光圈）：存活且超杀≥%s；烈焰（红色光圈）：存活且击杀≥%s", self._stageCfg.winScoreRequirements[1], self._stageCfg.winScoreRequirements[2])

	self:setFormCondition(self._masterData.formCondition)
end

function OriginWeiLeiTaExtFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginWeiLeiTaAgent.instance:sendPM_OriginWeiLeiTaExtremeChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginWeiLeiTaExtFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginWeiLeiTaExtFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginWeiLeiTaExtFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self._lockRaceIdMap[petMo.raceId]
end

function OriginWeiLeiTaExtFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show("精灵锁定，无法上阵")
end

function OriginWeiLeiTaExtFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	for posId, buffId in ipairs(self._stageCfg.selfPositionBuffs) do
		if buffId > 0 then
			if self:getCurFormation():GetPosition(posId) <= 0 then
				FloatWordMgr.instance:show("标记站位未上满精灵")

				return true
			end
		end
	end

	return (OriginWeiLeiTaExtFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack))
end

return OriginWeiLeiTaExtFmtMo
