-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/model/StarGodChaCustomFmtMo.lua

module("logic.extensions.stargodchallenge.model.StarGodChaCustomFmtMo", package.seeall)

local StarGodChaCustomFmtMo = class("StarGodChaCustomFmtMo", ICustomFmtMo)

function StarGodChaCustomFmtMo:initParams(cfgEnemy)
	self._cfgEnemy = cfgEnemy
	self._masterList = StarGodChallengeConfig.instance:getCreepsCfg(self._cfgEnemy.creepsMasterId)
end

function StarGodChaCustomFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.levelDescription
	self.isShowBtnFormation = true
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_First
	self.strShowRuleFlagKey = StarGodChallengeModel.RuleDescKey .. self._cfgEnemy.tier

	self:setFormCondition(self._cfgEnemy.singleFormCondition)
end

function StarGodChaCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function StarGodChaCustomFmtMo:initFightHandler()
	local function handler()
		StarGodChallengeController.instance:pushOneStackView()

		local simpleForm = self:getCurSimpleForm()

		StarGodChallengeAgent.instance:sendPM_StarGodChallengeSingleFightReq(simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function StarGodChaCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function StarGodChaCustomFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function StarGodChaCustomFmtMo:refreshPetList(changePetMoMap)
	print(">>>>>> GodLongYanCustomFmtMo 更新 列表 ")

	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function StarGodChaCustomFmtMo:initPetList()
	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

return StarGodChaCustomFmtMo
