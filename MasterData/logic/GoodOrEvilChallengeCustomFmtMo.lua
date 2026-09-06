-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/model/GoodOrEvilChallengeCustomFmtMo.lua

module("logic.extensions.godxiuerchallenge.model.GoodOrEvilChallengeCustomFmtMo", package.seeall)

local GoodOrEvilChallengeCustomFmtMo = class("GoodOrEvilChallengeCustomFmtMo", ICustomFmtMo)

function GoodOrEvilChallengeCustomFmtMo:onReset()
	GoodOrEvilChallengeCustomFmtMo.super.onReset(self)
end

function GoodOrEvilChallengeCustomFmtMo:initParams(challengeId, id)
	self._challengeId = challengeId
	self._typeInfoId = id
end

function GoodOrEvilChallengeCustomFmtMo:updateData()
	local info = GoodOrEvilChallengeConfig.instance:getChallengeTypeInfo(self._challengeId)
	local cfg = GoodOrEvilChallengeConfig.instance:getChallengeTeam(info[self._typeInfoId].creepsMasterId)

	self.topTitleStr = cfg.name
	self.ruleDescStr = cfg.description

	self:setFormCondition(cfg.formCondition)
	self:initPetList()
end

function GoodOrEvilChallengeCustomFmtMo:initFightHandler()
	local function handler()
		GodXiuerChallengeController.instance:fightResult(self._challengeId, ViewName.GodXiuerGoodOrEvilView)

		local simpleForm = self:getCurSimpleForm()

		GodHyurChallengeAgent.instance:sendPM_GodHyurLimitChallengeReq(self._challengeId, self._typeInfoId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function GoodOrEvilChallengeCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function GoodOrEvilChallengeCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function GoodOrEvilChallengeCustomFmtMo:getMonsterConfigList()
	local info = GoodOrEvilChallengeConfig.instance:getChallengeTypeInfo(self._challengeId)

	return GoodOrEvilChallengeConfig.instance:getHyurLimintChallengeCreeps(info[self._typeInfoId].creepsMasterId)
end

function GoodOrEvilChallengeCustomFmtMo:getFmtInfoConfig()
	local info = GoodOrEvilChallengeConfig.instance:getChallengeTypeInfo(self._challengeId)

	return (GoodOrEvilChallengeConfig.instance:getChallengeTeam(info[self._typeInfoId].creepsMasterId))
end

return GoodOrEvilChallengeCustomFmtMo
