-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/model/DivineDishiTianExtremeOneFmtMo.lua

module("logic.extensions.divinedishitianclg.model.DivineDishiTianExtremeOneFmtMo", package.seeall)

local DivineDishiTianExtremeOneFmtMo = class("DivineDishiTianExtremeOneFmtMo", BaseCustomFmtMo)

function DivineDishiTianExtremeOneFmtMo:initParams(activityId, stepId, stageId)
	self._activityId = activityId
	self._stepId = stepId
	self._stageId = stageId

	local cfgStage = DivineDiShiTianClgConfig.instance:getExtremeStage(activityId, stepId, stageId)

	self._monsterCfg = DivineDiShiTianClgConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = {}
	self._tempCreepsCfgs = DivineDiShiTianClgConfig.instance:getCreeps(cfgStage.creepsMasterId)
	self.isHideFmtZdl = true
	self.validatorDescStr = "本挑战敌阵精灵复制己方上阵精灵"
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.description

	self:setFormCondition(self._monsterCfg.formCondition)
end

function DivineDishiTianExtremeOneFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.DivineDiShiTianClg)
		DivineDiShiTianClgAgent.instance:sendPM_DivineDiShiTianClgChallengeExtremeReq(self._activityId, self._stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function DivineDishiTianExtremeOneFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DivineDishiTianExtremeOneFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function DivineDishiTianExtremeOneFmtMo:checkPetIsForbit(petMo, baseCheck)
	return DivineDiShiTianClgModel.instance:isPetLock(self._activityId, petMo.petId)
end

function DivineDishiTianExtremeOneFmtMo:showForbitPetAlert(petMo)
	if DivineDiShiTianClgModel.instance:getPetHp(self._activityId, petMo.petId) == 0 then
		FloatWordMgr.instance:show(string.format("%s血量为0,请使用其他精灵破阵", petMo.name))
	end
end

function DivineDishiTianExtremeOneFmtMo:getExtendViewName()
	return ViewName.DivineDiShiTianExtremeFmtOneView
end

function DivineDishiTianExtremeOneFmtMo:updateCellTop(cell, petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local percent = DivineDiShiTianClgModel.instance:getPetHpPercent(self._activityId, petMo.petId)

		proxy.binder:onUpdateHp(percent)
	end
end

function DivineDishiTianExtremeOneFmtMo:onFormationChangeFinish()
	local cfgCreeps = {}
	local formationMO = self:getCurFormation()
	local positions = formationMO:GetPositions()

	for posId, petId in ipairs(positions) do
		local petMo = BagPetsController.instance:getPet(petId)

		if petMo then
			local tempCfg = TableUtil.deepcopy(self._tempCreepsCfgs[posId])

			tempCfg.raceId = petMo.raceId
			tempCfg.posId = posId
			tempCfg.creepsId = #cfgCreeps + 1

			table.insert(cfgCreeps, tempCfg)
		end
	end

	self._creepsCfgs = cfgCreeps

	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)
	printInfo("test DivineDishiTianExtremeOneFmtMo:onFormationChangeFinish", #cfgCreeps)
end

return DivineDishiTianExtremeOneFmtMo
