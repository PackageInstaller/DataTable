-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/model/OriginLightDimensionExtremeFmtMo.lua

module("logic.extensions.originlightdimension.model.OriginLightDimensionExtremeFmtMo", package.seeall)

local OriginLightDimensionExtremeFmtMo = class("OriginLightDimensionExtremeFmtMo", BaseCustomFmtMo)

function OriginLightDimensionExtremeFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self._stageCfg = OriginLightDimensionConfig.instance:getExtremeStageCfg(self.activityId, self.stageId)

	local creepsMasterId = checknumber(self._stageCfg.creepsMasterId)

	self._cfgEnemy = OriginLightDimensionConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = OriginLightDimensionConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	local lastBuffId = OriginLightDimensionModel.instance:getLastBuff(self.activityId)
	local lastBuffCfg = OriginLightDimensionConfig.instance:getExtremeBuffCfg(self.activityId, lastBuffId)

	self.validatorDescStr = lastBuffCfg and langPara("本次战斗将从%s空间开始", lastBuffCfg.name) or langPara("己方精灵每累计出手3次后将依次并循环激活虚空、次元、万象三大空间")
end

function OriginLightDimensionExtremeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		BattleSettlementModel.instance:setBattleTopExtView(ViewName.OriginLightDimensionBattleExView)
		OriginLightDimensionController.instance:setExBuffParam(self._stageCfg)

		local lastBuffId = OriginLightDimensionModel.instance:getLastBuff(self.activityId)

		OriginLightDimensionModel.instance:saveTempExtClgLastBuff(lastBuffId)
		OriginLightDimensionAgent.instance:sendPM_OriginLightDimensionExtremeClgReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginLightDimensionExtremeFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginLightDimensionExtremeFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function OriginLightDimensionExtremeFmtMo:checkPetIsForbit(petMo, baseCheck)
	return OriginLightDimensionModel.instance:isExtremePetLock(self.activityId, petMo.raceId)
end

function OriginLightDimensionExtremeFmtMo:showForbitPetAlert(petMo)
	if OriginLightDimensionModel.instance:isExtremePetLock(self.activityId, petMo.raceId) == true then
		FloatWordMgr.instance:show(lang("精灵已被封印"))
	end
end

return OriginLightDimensionExtremeFmtMo
