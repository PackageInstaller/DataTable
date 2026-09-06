-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/model/MiyaChallengeFmtMo.lua

module("logic.extensions.miyachallenge.model.MiyaChallengeFmtMo", package.seeall)

local MiyaChallengeFmtMo = class("MiyaChallengeFmtMo", ICustomFmtMo)

function MiyaChallengeFmtMo:initParams(mainviewName, levelviewName)
	self._mainviewName = mainviewName
	self._levelviewName = levelviewName
	self._activityCfg = MiyaChallengeConfig.instance:getActivityCfg(MiyaChallengeModel.instance:getActivityId())
	self._tierCfg = MiyaChallengeConfig.instance:getTierStageCfg(self._activityCfg.tierPlanId, MiyaChallengeModel.instance:getTierId())

	if MiyaChallengeModel.instance:getBigStageId() == 1 then
		self._stageCfg = MiyaChallengeConfig.instance:getStageCfg(self._tierCfg.firstPlanId, MiyaChallengeModel.instance:getShowStageId())
	elseif MiyaChallengeModel.instance:getBigStageId() == 2 then
		self._stageCfg = MiyaChallengeConfig.instance:getStageCfg(self._tierCfg.secondPlanId, MiyaChallengeModel.instance:getShowStageId())
	elseif MiyaChallengeModel.instance:getBigStageId() == 3 then
		self._stageCfg = MiyaChallengeConfig.instance:getStageCfg(self._tierCfg.thirdPlanId, MiyaChallengeModel.instance:getShowStageId())
	end

	self._cfgEnemy = MiyaChallengeConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = MiyaChallengeConfig.instance:getEnemyCreepsCfg(self._stageCfg.creepsMasterId)

	if MiyaChallengeModel.instance:getBuff().limitId ~= 0 then
		self:setFormCondition(MiyaChallengeModel.instance:getBuff().limitId)
	else
		self:setFormCondition()
	end

	self.limitCfg = nil

	if checknumber(self:getFormCondition()) > 0 then
		local totalCfg = FormationValidatorConfig.instance:getFormationValidatorCfg(self:getFormCondition())
		local conditionList = ConditionValidator.instance:getAllConditions(totalCfg.validator)

		for i, v in ipairs(conditionList) do
			local str = string.split(v, "$")

			if str[1] and str[1] == "All" and str[2] then
				local idIndex = checknumber(str[2])

				self.limitCfg = FormationValidatorConfig.instance:getFormationAllValidatorCfg(idIndex)

				if string.find(self.limitCfg.validator, "!RaceType") and self.limitCfg.count <= 0 then
					break
				else
					self.limitCfg = nil
				end
			end
		end
	end
end

function MiyaChallengeFmtMo:updateData()
	local buff = MiyaChallengeModel.instance:getBuff()

	self.topTitleStr = self._cfgEnemy.name

	local rule = ""

	if checknumber(buff.buffId) > 0 then
		rule = langPara("%s属性加成：%s\n", rule, MiyaChallengeConfig.instance:getBuffCfg(buff.buffId).des)
	end

	if checknumber(buff.limitId) > 0 then
		rule = langPara("%s上阵限制：%s\n", rule, FormationValidatorConfig.instance:getFormationValidatorCfg(buff.limitId).desc)
	end

	if checknumber(buff.conditionId) > 0 then
		rule = langPara("%s通关条件：%s\n", rule, MiyaChallengeConfig.instance:getWindDesc(3, buff.conditionId))
	end

	self.ruleDescStr = rule
	self.isPopRuleDesc = true
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_Always

	if MiyaChallengeModel.instance:getBuff().limitId ~= 0 then
		self:setFormCondition(MiyaChallengeModel.instance:getBuff().limitId)
	else
		self:setFormCondition()
	end

	self:initPetList()

	self.formationMo = FormationModel.instance:getTeamFormation()
end

function MiyaChallengeFmtMo:initFightHandler()
	local function handler()
		if string.nilorempty(self._mainviewName) then
			UIJumper.instance:pushOneStack(ViewName.MiyaChallengeMainView, true)
		else
			UIJumper.instance:pushOneStack(self._mainviewName, true)
		end

		if string.nilorempty(self._levelviewName) then
			UIJumper.instance:pushOneStack(ViewName.MiyaChallengeLevelView, true, MiyaChallengeModel.instance:getActivityId())
		else
			UIJumper.instance:pushOneStack(self._levelviewName, true, MiyaChallengeModel.instance:getActivityId())
		end

		if MiyaChallengeModel.instance:getBigStageId() == 1 then
			MiyaChallengeAgent.instance:sendPM_MiyaChallengeBossReq(MiyaChallengeModel.instance:getActivityId(), MiyaChallengeModel.instance:getShowStageId())
		else
			MiyaChallengeAgent.instance:sendPM_MiyaFormChallengeReq(MiyaChallengeModel.instance:getActivityId(), MiyaChallengeModel.instance:getBigStageId(), MiyaChallengeModel.instance:getShowStageId())
		end
	end

	self:setFightHandler(handler, nil)
end

function MiyaChallengeFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function MiyaChallengeFmtMo:getMonsterConfigList()
	return self._masterList
end

function MiyaChallengeFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function MiyaChallengeFmtMo:setFormCondition(condition)
	if condition == 0 then
		self._formCondition = nil
	else
		self._formCondition = condition
	end
end

function MiyaChallengeFmtMo:checkPetIsForbit(petMo)
	if self.limitCfg then
		local isMatch = ConditionValidator.instance:isMatch(self.limitCfg.validator, FormationValidatorController._doSingleValidator, petMo, self.formationMo)

		if isMatch then
			return true
		end
	end

	return false
end

return MiyaChallengeFmtMo
