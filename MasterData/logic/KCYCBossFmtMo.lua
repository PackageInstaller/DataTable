-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/model/KCYCBossFmtMo.lua

module("logic.extensions.kingciyuanchallenge.model.KCYCBossFmtMo", package.seeall)

local KCYCBossFmtMo = class("KCYCBossFmtMo", ICustomFmtMo)

function KCYCBossFmtMo:onReset()
	KCYCBossFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function KCYCBossFmtMo:initParams(activityId, bossId)
	self._activityId = activityId
	self._activityConfig = KingCiYuanChallengeConfig.instance:getActivityConfig(self._activityId)
	self._planData = KingCiYuanChallengeConfig.instance:getBossChallengePlan(self._activityConfig.bossPlanId, bossId)

	self:updateData()
end

function KCYCBossFmtMo:updateData()
	if self._planData then
		self._masterConfig = KingCiYuanChallengeConfig.instance:getCreepMasterConfig(self._planData.monsterId)
		self.topTitleStr = self._masterConfig.name
		self.ruleDescStr = self._masterConfig.description
		self.isPopRuleDesc = true
	end

	self:initPetList()
end

function KCYCBossFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		KingCiYuanChallengeController.instance:reqBossFight(self._activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KCYCBossFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function KCYCBossFmtMo:getMonsterConfigList()
	return KingCiYuanChallengeConfig.instance:getCreepConfig(self._planData.monsterId)
end

function KCYCBossFmtMo:getFmtInfoConfig()
	return KingCiYuanChallengeConfig.instance:getCreepMasterConfig(self._planData.monsterId)
end

return KCYCBossFmtMo
