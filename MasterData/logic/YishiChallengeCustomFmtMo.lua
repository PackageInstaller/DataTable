-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/model/YishiChallengeCustomFmtMo.lua

module("logic.extensions.yishichallenge.model.YishiChallengeCustomFmtMo", package.seeall)

local YishiChallengeCustomFmtMo = class("YishiChallengeCustomFmtMo", ICustomFmtMo)

function YishiChallengeCustomFmtMo:onReset()
	YishiChallengeCustomFmtMo.super.onReset(self)
end

function YishiChallengeCustomFmtMo:initParams(challengeId, stage)
	self._challengeId = challengeId
	self._stage = stage
end

function YishiChallengeCustomFmtMo:updateData()
	local info = YishiChallengeConfig.instance:getChallengeCfgById(self._challengeId)
	local cfg = YishiChallengeConfig.instance:getChallengeTeamCfgById(info[self._stage].creepsMasterId)

	self.topTitleStr = cfg.name
	self.ruleDescStr = cfg.description

	self:setFormCondition(cfg.formCondition)
	self:initPetList()
end

function YishiChallengeCustomFmtMo:initFormationMo()
	self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
end

function YishiChallengeCustomFmtMo:initFightHandler()
	local function handler()
		local fmo = self:getCurFormation()
		local simpleForm = fmo:createFormPb()

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		YiShiChallengeAgent.instance:sendPM_YiShiChallengeReq(self._challengeId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function YishiChallengeCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function YishiChallengeCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function YishiChallengeCustomFmtMo:getExtendViewName()
	return ViewName.YishiChallengeFmtView
end

function YishiChallengeCustomFmtMo:getMonsterConfigList()
	local info = YishiChallengeConfig.instance:getChallengeCfgById(self._challengeId)

	return YishiChallengeConfig.instance:getChallengeCreepsCfgById(info[self._stage].creepsMasterId)
end

function YishiChallengeCustomFmtMo:getFmtInfoConfig()
	local info = YishiChallengeConfig.instance:getChallengeCfgById(self._challengeId)

	return YishiChallengeConfig.instance:getChallengeTeamCfgById(info[self._stage].creepsMasterId)
end

function YishiChallengeCustomFmtMo:getParams()
	return self._challengeId, self._stage
end

return YishiChallengeCustomFmtMo
