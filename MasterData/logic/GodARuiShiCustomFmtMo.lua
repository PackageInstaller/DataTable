-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/model/GodARuiShiCustomFmtMo.lua

module("logic.extensions.godaruishichallenge.model.GodARuiShiCustomFmtMo", package.seeall)

local GodARuiShiCustomFmtMo = class("GodARuiShiCustomFmtMo", ICustomFmtMo)

GodARuiShiCustomFmtMo.LifeAltar = 1
GodARuiShiCustomFmtMo.LifeImmune = 2
GodARuiShiCustomFmtMo.LifeWithered = 3
GodARuiShiCustomFmtMo.LifeAll = 4
GodARuiShiCustomFmtMo.Boss = 5

function GodARuiShiCustomFmtMo:initParams(challengeId, stageId, isBoss)
	self._challengeId = challengeId
	self._fixPos = nil
	self._isBoss = isBoss or false

	if self._isBoss then
		self._isBoss = true
		self._customType = GodARuiShiCustomFmtMo.Boss

		local bossCfg = GodARuiShiChallengeConfig.instance:getBossInfo(challengeId, stageId)

		self._creepsMasterId = bossCfg.bossCreepsMasterId
		self._stageId = stageId

		if bossCfg.supportPetId then
			self._supportPetCfg = GodARuiShiChallengeConfig.instance:getSupportCfg(bossCfg.supportPetId)
			self._fixPos = {
				self._supportPetCfg.posId
			}
		else
			self._supportPetCfg = nil
		end
	else
		self._isBoss = false

		local stage = GodARuiShiChallengeConfig.instance:getStageInfo(challengeId, stageId)

		self._stageId = stageId
		self._customType = stage.type == 1 and GodARuiShiCustomFmtMo.LifeAltar or stage.type == 2 and GodARuiShiCustomFmtMo.LifeImmune or stage.type == 3 and GodARuiShiCustomFmtMo.LifeWithered or stage.type == 4 and GodARuiShiCustomFmtMo.LifeAll or nil
		self._creepsMasterId = stage.creepsMasterId

		if stage.supportPetId then
			self._supportPetCfg = GodARuiShiChallengeConfig.instance:getSupportCfg(stage.supportPetId)
			self._fixPos = {
				self._supportPetCfg.posId
			}
		else
			self._supportPetCfg = nil
		end
	end

	self._masterList = GodARuiShiChallengeConfig.instance:getCreeps(self._creepsMasterId)
	self._cfgEnemy = GodARuiShiChallengeConfig.instance:getTeam(self._creepsMasterId)
end

function GodARuiShiCustomFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = "击败所有敌人"
	self.ruleViewName = ViewName.GodARuiShiChallengeRuleView
	self.ruleViewArgs = {
		self._isBoss,
		self._stageId,
		self._challengeId
	}

	GodARuiShiChallengeModel.instance:setTempShowRuleEffect(true)

	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_UserSet

	if self._isBoss and GodARuiShiChallengeModel.instance:getReadBossRule() then
		self.strShowRuleFlagKey = nil
		self.isPopRuleDesc = false
	else
		self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_Always
		self.isPopRuleDesc = true
	end

	self.validatorDescStr = self._cfgEnemy.description

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
	self:clearAllPetList()

	local tempFmt, tempStageId, tempIsBoss

	tempFmt, tempStageId, tempIsBoss = GodARuiShiChallengeModel.instance:getTempFmt(self._stageId, self._isBoss)

	if tempFmt ~= nil then
		self.formationMo = tempFmt
	else
		GodARuiShiChallengeModel.instance:resetTempStageInfo()

		self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end

	if self._supportPetCfg then
		self:getCurFormation():SetPosition(self._supportPetCfg.posId, self._supportPetCfg.creepsId)
	end
end

function GodARuiShiCustomFmtMo:initFightHandler()
	local function handler()
		local raceId
		local cfg = EvolveConfig.instance:getDivineEvolveCfgByChallengeId(self._challengeId)

		if cfg then
			raceId = cfg.raceId
		end

		UIJumper.instance:pushOneStack(ViewName.DivineEvolveEnterView, true)
		UIJumper.instance:pushOneStack(ViewName.DivineEvolveMainView, true, raceId)
		printInfo("test 开始战斗", self._cfgEnemy.winId)

		local simpleForm = self:getCurSimpleForm()

		BattleFacade.instance:startGodARuiShiFight(self._challengeId, self._stageId, self._isBoss)

		if self._isBoss then
			GodARuiShiChallengeModel.instance:saveFmtStatus(self:getCurFormation(), self._stageId, self._isBoss, self._challengeId)
			GodARuiShiChallengeAgent.instance:sendPM_GodARuiShiChallengeBossReq(self._challengeId, simpleForm)
		else
			GodARuiShiChallengeModel.instance:saveFmtStatus(self:getCurFormation(), self._stageId, self._isBoss, self._challengeId)
			GodARuiShiChallengeAgent.instance:sendPM_GodARuiShiChallengeStageReq(self._challengeId, self._stageId, simpleForm)
		end
	end

	self:setFightHandler(handler, nil)
end

function GodARuiShiCustomFmtMo:initPetList()
	self:clearAllPetList()

	local supportCfgs = {}
	local cfgMaster = self._supportPetCfg

	table.insert(supportCfgs, cfgMaster)

	for i, v in ipairs(supportCfgs) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true
		self._supportPetName = petMo:getName()

		self:addPetToList(petMo)
	end

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function GodARuiShiCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function GodARuiShiCustomFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function GodARuiShiCustomFmtMo:getFixedPosList()
	return self._fixPos
end

function GodARuiShiCustomFmtMo:setFormCondition(condition)
	if condition == 0 then
		self._formCondition = nil
	else
		self._formCondition = condition
	end
end

function GodARuiShiCustomFmtMo:getCustomType()
	return self._customType
end

function GodARuiShiCustomFmtMo:getChallengeId()
	return self._challengeId
end

function GodARuiShiCustomFmtMo:checkOnPos(pos)
	return false
end

function GodARuiShiCustomFmtMo:getFinalFmoList(posList, petPool, needPets)
	local maxNum = self.needUpPetCount
	local count = 0
	local posIds = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9
	}
	local petMos = {}

	for _, posId in ipairs(posIds) do
		local isFixPos = MissionModel.instance:isFixedPos(posId)

		if isFixPos then
			local petId = self:getCurFormation():GetPosition(posId)
			local petMo = self:getPetMoById(petId)

			if petMo then
				petMos[posId] = petMo

				if not petMo:isSummonedPet() then
					count = count + 1
				end
			end
		end
	end

	local exPetMoList = {}

	for idx, posId in ipairs(posList) do
		local petMo = petPool[idx]
		local isHavePet = petMo ~= nil
		local isRepeatRaceId = false
		local raceId = petMo and petMo:getDefineId() or -1

		for _, mo in pairs(petMos) do
			local mRaceId = mo:getDefineId()

			isRepeatRaceId = isRepeatRaceId or raceId == mRaceId
		end

		if isHavePet and not isRepeatRaceId then
			local isNilSeat = petMos[posId] == nil

			if isNilSeat then
				local isSummonedPet = petMo:isSummonedPet()
				local isFitCount = count < maxNum

				if isSummonedPet then
					petMos[posId] = petMo
				elseif not isSummonedPet and isFitCount then
					petMos[posId] = petMo
					count = count + 1
				end
			else
				table.insert(exPetMoList, petMo)
			end
		end
	end

	for _, exPetMo in ipairs(exPetMoList) do
		local fitPosId

		for _, posId in ipairs(posIds) do
			if petMos[posId] == nil then
				fitPosId = posId
			end
		end

		if fitPosId == nil then
			break
		end

		local isSummonedPet = exPetMo:isSummonedPet()
		local isFitCount = count < maxNum

		if isSummonedPet then
			petMos[fitPosId] = exPetMo
		elseif not isSummonedPet and isFitCount then
			petMos[fitPosId] = exPetMo
			count = count + 1
		end
	end

	return posIds, petMos
end

function GodARuiShiCustomFmtMo:getExtendViewName()
	return ViewName.GodARuiShiChallengeFmtView
end

function GodARuiShiCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if self._formCondition then
		return FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._formCondition, self:getCurFormation(), isShowTip)
	else
		return true
	end
end

return GodARuiShiCustomFmtMo
