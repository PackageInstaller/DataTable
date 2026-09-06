-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/model/KCYCLimitFmtMo.lua

module("logic.extensions.kingciyuanchallenge.model.KCYCLimitFmtMo", package.seeall)

local KCYCLimitFmtMo = class("KCYCLimitFmtMo", ICustomFmtMo)

function KCYCLimitFmtMo:onReset()
	KCYCLimitFmtMo.super.onReset(self)
end

function KCYCLimitFmtMo:initParams(activityId, extChallengeConfig)
	self._activityId = activityId
	self._extChallengeConfig = extChallengeConfig
	self._activityConfig = KingCiYuanChallengeConfig.instance:getActivityConfig(self._activityId)

	self:updateData()
end

function KCYCLimitFmtMo:updateData()
	if self._extChallengeConfig then
		self._masterConfig = KingCiYuanChallengeConfig.instance:getCreepMasterConfig(self._extChallengeConfig.monsterId)
		self.topTitleStr = self._masterConfig.name
		self.ruleDescStr = self._masterConfig.description
	end

	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_Always

	self:initPetList()
end

function KCYCLimitFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()
		local passStageId = KingCiYuanChallengeModel.instance:getJxPassStageId()

		KingCiYuanChallengeController.instance:reqLimitFight(self._activityId, passStageId + 1, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KCYCLimitFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function KCYCLimitFmtMo:getMonsterConfigList()
	return KingCiYuanChallengeConfig.instance:getCreepConfig(self._extChallengeConfig.monsterId)
end

function KCYCLimitFmtMo:getFmtInfoConfig()
	return KingCiYuanChallengeConfig.instance:getCreepMasterConfig(self._extChallengeConfig.monsterId)
end

function KCYCLimitFmtMo:updateCellTop(cell, petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		proxy.binder:onUpdateHp(KingCiYuanChallengeModel.instance:getJXPetHpByPetId(petMo.petId))
	end
end

function KCYCLimitFmtMo:checkPetIsForbit(petMo)
	return KingCiYuanChallengeModel.instance:getJXPetHpByPetId(petMo.petId) <= 0
end

function KCYCLimitFmtMo:getExtendViewName()
	return ViewName.KingciyuanchallengelimitfmtView
end

return KCYCLimitFmtMo
