-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/model/DivineDishiTianExtremeTwoFmtMo.lua

module("logic.extensions.divinedishitianclg.model.DivineDishiTianExtremeTwoFmtMo", package.seeall)

local DivineDishiTianExtremeTwoFmtMo = class("DivineDishiTianExtremeTwoFmtMo", BaseCustomFmtMo)

function DivineDishiTianExtremeTwoFmtMo:initParams(activityId, stepId, stageId)
	self._activityId = activityId
	self._stepId = stepId
	self._stageId = stageId

	local cfgStage = DivineDiShiTianClgConfig.instance:getExtremeStage(activityId, stepId, stageId)

	self._creepsMasterId = cfgStage.creepsMasterId
	self._monsterCfg = DivineDiShiTianClgConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = DivineDiShiTianClgConfig.instance:getCreeps(cfgStage.creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.description

	self:setFormCondition(self._monsterCfg.formCondition)
end

function DivineDishiTianExtremeTwoFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.DivineDiShiTianClg)
		DivineDiShiTianClgAgent.instance:sendPM_DivineDiShiTianClgChallengeExtremeReq(self._activityId, self._stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function DivineDishiTianExtremeTwoFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DivineDishiTianExtremeTwoFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function DivineDishiTianExtremeTwoFmtMo:checkPetIsForbit(petMo, baseCheck)
	return DivineDiShiTianClgModel.instance:isPetLock(self._activityId, petMo.petId)
end

function DivineDishiTianExtremeTwoFmtMo:showForbitPetAlert(petMo)
	if DivineDiShiTianClgModel.instance:getPetHp(self._activityId, petMo.petId) == 0 then
		FloatWordMgr.instance:show(string.format("%s血量为0,请使用其他精灵破阵", petMo.name))
	end
end

function DivineDishiTianExtremeTwoFmtMo:getExtendViewName()
	return ViewName.DivineDiShiTianExtremeFmtTwoView
end

function DivineDishiTianExtremeTwoFmtMo:updateCellTop(cell, petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local percent = DivineDiShiTianClgModel.instance:getPetHpPercent(self._activityId, petMo.petId)

		proxy.binder:onUpdateHp(percent)
	end
end

function DivineDishiTianExtremeTwoFmtMo:getCreepsMasterId()
	return self._creepsMasterId
end

return DivineDishiTianExtremeTwoFmtMo
