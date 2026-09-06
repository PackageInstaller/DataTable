-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/model/TrueOrFalseChallengeCustomFmtMo.lua

module("logic.extensions.godxiuerchallenge.model.TrueOrFalseChallengeCustomFmtMo", package.seeall)

local TrueOrFalseChallengeCustomFmtMo = class("TrueOrFalseChallengeCustomFmtMo", ICustomFmtMo)

function TrueOrFalseChallengeCustomFmtMo:onReset()
	TrueOrFalseChallengeCustomFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function TrueOrFalseChallengeCustomFmtMo:initParams(challengeId, id, stage, form)
	self._challengeId = challengeId
	self._typeInfoId = id
	self._stage = stage
	self._selfForm = form
end

function TrueOrFalseChallengeCustomFmtMo:updateData()
	local info = GoodOrEvilChallengeConfig.instance:getChallengeTypeInfo(self._challengeId)
	local cfg = GoodOrEvilChallengeConfig.instance:getGodHyurChallengeTrueTeam(info[self._typeInfoId].creepsMasterId)
	local isShowPetInfo = not not self._selfForm

	self.topTitleStr = cfg.name
	self.ruleDescStr = cfg.description
	self.isShowOneKey = true
	self.isShowClean = true
	self.isShowPetList = not isShowPetInfo

	self:setFormCondition(cfg.formCondition)
	self:initPetList()
	self:_refreshFormationMo()
end

function TrueOrFalseChallengeCustomFmtMo:initFormationMo()
	self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
end

function TrueOrFalseChallengeCustomFmtMo:_refreshFormationMo()
	local form = GodXiuerChallengeModel.instance:getWholePeopleWrongForm(self._challengeId)

	if not self._selfForm and form then
		self.formationMo:SetData(form)
	end
end

function TrueOrFalseChallengeCustomFmtMo:initFightHandler()
	local function handler()
		GodXiuerChallengeController.instance:fightResult(self._challengeId, ViewName.GodXiuerRightWrongView)

		local simpleForm = self:getCurSimpleForm()

		GodHyurChallengeAgent.instance:sendPM_GodHyurWholePeopleChallengeReq(self._challengeId, simpleForm, self._stage, self._typeInfoId)
	end

	self:setFightHandler(handler, nil)
end

function TrueOrFalseChallengeCustomFmtMo:initPetList()
	self:clearAllPetList()

	if not self._selfForm then
		local pets = BagPetsController.instance:getFightBagPet()

		for i, petMo in ipairs(pets) do
			local mo = FightingPowerPetMo.getMaxPetMoByData(petMo)

			self:addPetToList(mo)
		end
	else
		local info = GoodOrEvilChallengeConfig.instance:getChallengeTypeInfo(self._challengeId)
		local pets = GoodOrEvilChallengeConfig.instance:getChallengerueCreeps(info[self._typeInfoId].creepsMasterId)

		for i, petMo in ipairs(pets) do
			local mo = FightingPowerPetMo.New()

			mo:fromChallengeCreepCo(petMo)
			self:addPetToList(mo:toBaseBagPetMo())
		end
	end
end

function TrueOrFalseChallengeCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function TrueOrFalseChallengeCustomFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if not self._selfForm then
		if creepCfg then
			for i, v in pairs(creepCfg) do
				if checknumber(v.posId) > 0 then
					local petMo = FightingPowerPetMo.New()

					petMo:fromChallengeCreepCo(v, creepCfg)

					petMo.creepName = v.creepName

					table.insert(teams, petMo)

					formations[v.posId] = petMo
				end
			end
		end
	else
		teams, formations = self:_setForm()
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function TrueOrFalseChallengeCustomFmtMo:getMonsterConfigList()
	if not self._selfForm then
		local info = GoodOrEvilChallengeConfig.instance:getChallengeTypeInfo(self._challengeId)

		return GoodOrEvilChallengeConfig.instance:getChallengerueCreeps(info[self._typeInfoId].creepsMasterId)
	end

	return self:_setForm()
end

function TrueOrFalseChallengeCustomFmtMo:getFmtInfoConfig()
	if not self._selfForm then
		local info = GoodOrEvilChallengeConfig.instance:getChallengeTypeInfo(self._challengeId)

		return (GoodOrEvilChallengeConfig.instance:getGodHyurChallengeTrueTeam(info[self._typeInfoId].creepsMasterId))
	end

	return self._selfForm.extParams
end

function TrueOrFalseChallengeCustomFmtMo:_setForm()
	local teams = {}
	local formations = {}

	if self._selfForm and self._selfForm.pos then
		for k, v in pairs(self._selfForm.pos) do
			local mo = BagModel.instance:getBagPetById(v)

			if mo then
				local petMo = FightingPowerPetMo.getMaxPetMoByData(mo)

				table.insert(teams, petMo)

				formations[k] = petMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

return TrueOrFalseChallengeCustomFmtMo
