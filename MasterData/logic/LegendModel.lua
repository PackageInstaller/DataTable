-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/model/LegendModel.lua

module("logic.extensions.legend.model.LegendModel", package.seeall)

local LegendModel = class("LegendModel", BaseModel)

LegendModel.XiongMaoGame = 1
LegendModel.QianNiaoWanGame = 2
LegendModel.OldXiongMaoId = 18
LegendModel.OldQianNiaoWanId = 17

function LegendModel:ctor()
	return
end

LegendModel._texNames = {
	"cstz_bg03",
	"cstz_bg06",
	"cstz_bg02",
	"cstz_bg04",
	"cstz_bg05"
}
LegendModel._effectPath = {
	"fx_ui_chuanshuotiaozhan/fx_ui_chuanshuotiaozhan_cao.prefab",
	"fx_ui_chuanshuotiaozhan/fx_ui_chuanshuotiaozhan_shui.prefab",
	"fx_ui_chuanshuotiaozhan/fx_ui_chuanshuotiaozhan_huo.prefab",
	"fx_ui_chuanshuotiaozhan/fx_ui_chuanshuotiaozhan_guang.prefab",
	"fx_ui_chuanshuotiaozhan/fx_ui_chuanshuotiaozhan_an.prefab"
}

function LegendModel:onInit()
	self:onReset()
end

function LegendModel:onReset()
	self._challengeProcessInfoRes = nil
	self._legendChallengeInfoRes = nil
	self._challengeRes = nil
	self._buyChallengeTimesRes = nil
	self._buyIndependentTimesRes = nil
	self._notifyAfterChallengeRes = nil
	self._sweepsByTimesRes = nil
	self._sweepAutoRes = nil
	self._legendChallengeTimesInfoRes = nil
	self._independentTimesInfos = {}
	self._challengeProcessInfos = {}
	self._curOpenChallengeId = 1
	self._curOpenStageId = 1
	self._recordChallengeId = 1
	self._higestVerifiedZdl = 0
	self._verifyPlanId = 1
	self._blockId = 1
	self._state = 1
	self._getedBoxIds = {}
	self._svrFormation = {}
	self._supportPet = {}
	self._formation = {}
	self._teamId = 1
end

function LegendModel:getTexNameByRaceTypes(raceType)
	local num = GameEnum.Races[raceType]

	return (self._texNames[num] or nil) and (self._texNames[num] or "")
end

function LegendModel:getEffectPath(raceType)
	local num = GameEnum.Races[raceType]

	return (self._effectPath[num] or nil) and (self._effectPath[num] or "")
end

function LegendModel:getUpdateTime()
	self._updateTime = self._updateTime or 0.3

	return self._updateTime
end

function LegendModel:onChallengeProcessInfoRes(msg)
	self._challengeProcessInfoRes = msg

	for i, v in ipairs(msg.process) do
		self._challengeProcessInfos[v.challengeId] = {
			challengeId = v.challengeId,
			stagePassBit = v.stagePassBit
		}
	end

	for i, id in ipairs(msg.gainedIds) do
		self:updateGetedBox(id)
	end

	for i, v in ipairs(msg.independentTimes) do
		self._independentTimesInfos[v.challengeId] = v
	end
end

function LegendModel:onLegendChallengeInfoRes(msg)
	self._legendChallengeInfoRes = msg
	self._independentTimesInfos[msg.challengeId] = msg.independentTimes
	self._recordChallengeId = msg.challengeId
	self._challengeProcessInfos[msg.challengeId] = {
		challengeId = msg.challengeId,
		stagePassBit = msg.stagePassBit
	}
end

function LegendModel:onChallengeRes(msg)
	self._challengeRes = msg
end

function LegendModel:onBuyChallengeTimesRes(msg)
	self._buyChallengeTimesRes = msg
end

function LegendModel:onBuyIndependentTimesRes(msg)
	self._buyIndependentTimesRes = msg
	self._independentTimesInfos[msg.times.challengeId] = msg.times
end

function LegendModel:onNotifyAfterChallengeRes(msg)
	self._notifyAfterChallengeRes = msg
end

function LegendModel:onSweepsByTimesRes(msg)
	self._sweepsByTimesRes = msg
end

function LegendModel:onSweepAutoRes(msg)
	self._sweepAutoRes = msg
end

function LegendModel:onLegendChallengeTimesInfoRes(msg)
	self._legendChallengeTimesInfoRes = msg

	for i, v in ipairs(msg.independentTimes) do
		self._independentTimesInfos[v.challengeId] = v
	end
end

function LegendModel:onTreasureInfoRes(msg)
	for i, id in ipairs(msg.gainedIds) do
		self:updateGetedBox(id)
	end
end

function LegendModel:updateGetedBox(getedBoxId)
	self._getedBoxIds[getedBoxId] = self._getedBoxIds[getedBoxId] or true
end

function LegendModel:isTreasureBoxGeted(id)
	return self._getedBoxIds[id]
end

function LegendModel:getLeftCountByChallengeId(challengeId)
	if self._independentTimesInfos[challengeId] then
		return self._independentTimesInfos[challengeId].curTimes
	end

	return 0
end

function LegendModel:getPublicBuyTimes()
	if self._timesInfo and self._timesInfo.buyTimes then
		return self._timesInfo.buyTimes
	end

	return 0
end

function LegendModel:getIndependentBuyTimes(challengeId)
	if self._independentTimesInfos[challengeId] then
		return self._independentTimesInfos[challengeId].buyTimes
	end

	return 0
end

function LegendModel:reduceCurIndependentTimes(challengeId, num)
	if self._independentTimesInfos[challengeId] then
		local tempNum = self._independentTimesInfos[challengeId].curTimes

		tempNum = tempNum - num
		tempNum = tempNum > 0 and tempNum or 0
		self._independentTimesInfos[challengeId].curTimes = tempNum
	end
end

function LegendModel:getCurIndependentTimes(challengeId)
	if self._independentTimesInfos[challengeId] then
		return self._independentTimesInfos[challengeId].curTimes
	end

	printInfo("legend 这里执行了")

	return 0
end

function LegendModel:isStagePass(challengeId, stageId)
	if self._challengeProcessInfos[challengeId] then
		local stagePassBit = self._challengeProcessInfos[challengeId].stagePassBit

		return GameUtil.isBitOpenByDigit(stagePassBit, stageId)
	end

	return false
end

function LegendModel:isChallengePass(challengeId)
	if self._challengeProcessInfos[challengeId] then
		local challengeCfg = LegendConfig.instance:getLegendChallengeStageCfgList(challengeId)
		local challengeLen = 0

		for k, v in pairs(challengeCfg) do
			challengeLen = challengeLen + 1
		end

		local stagePassBit = self._challengeProcessInfos[challengeId].stagePassBit

		return GameUtil.isBitOpenByDigit(stagePassBit, challengeLen)
	end

	return false
end

function LegendModel:getRecordChallengeId()
	return self._recordChallengeId
end

function LegendModel:getOpenChallengeIdAndStageId()
	return self._curOpenChallengeId, self._curOpenStageId
end

function LegendModel:setCurOpenChallenge(challengeId, stageId)
	self._curOpenChallengeId = challengeId
	self._curOpenStageId = stageId
end

function LegendModel:isStageOpen(challengeId, stageId)
	local cfg = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)

	if cfg then
		return (FuncOpenModel.instance:getFuncIsOpen(cfg.unlockId))
	end

	return false
end

function LegendModel:_getRecoverTimesList()
	if not self._timesList then
		self._timesList = {}

		local cfg = LegendConfig.instance:getLegendChallengeCommonCfg("RECOVERY_TIMES")
		local times = string.split(cfg.value, "|")

		for i, v in ipairs(times) do
			local str = string.split(v, ":")

			self._timesList[i] = {
				hour = checknumber(str[1]),
				min = checknumber(str[2]),
				sec = checknumber(str[3])
			}
		end
	end

	return self._timesList
end

function LegendModel:getVerifyPlanId()
	return self._verifyPlanId
end

function LegendModel:setVerifyPlanId(planId)
	self._verifyPlanId = planId
end

function LegendModel:getBlockId()
	return self._blockId
end

function LegendModel:setBlockId(blockId)
	self._blockId = blockId
end

function LegendModel:getMapState()
	return self._state
end

function LegendModel:setMapState(state)
	self._state = state
end

function LegendModel:isExistSupportPet()
	local challengeId, stageId = self:getOpenChallengeIdAndStageId()
	local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)

	return cfgStage and cfgStage.supportPetId > 0
end

function LegendModel:setSupportFormRes(challengeId, stageId, simpleForm_pb)
	self:setFormation(challengeId, stageId, simpleForm_pb)
end

function LegendModel:setFormation(challengeId, stageId, form)
	local supportCfg = LegendConfig.instance:getSuportCfgByChallengeId(challengeId, stageId)

	form.pos[supportCfg.posId] = supportCfg.creepsId

	local fmt = self:_getFormationById(challengeId, stageId)

	fmt:SetData(form)
	self:_saveAsSvrFometion(challengeId, stageId, form)
end

function LegendModel:_saveAsSvrFometion(challengeId, stageId, simpleForm_pb)
	self._svrFormation[challengeId] = self._svrFormation[challengeId] or {}
	self._svrFormation[challengeId][stageId] = self._svrFormation[challengeId][stageId] or {}

	local supportInfo = self._svrFormation[challengeId][stageId]
	local simpleForm = {}
	local extParams = {}

	supportInfo.challengeId = challengeId
	supportInfo.stageId = stageId
	supportInfo.simpleForm = simpleForm
	simpleForm.extParams = extParams
	simpleForm.formId = simpleForm_pb.formId

	local pos = {}

	simpleForm.pos = pos

	for i, v in ipairs(simpleForm_pb.pos) do
		pos[i] = v
	end

	extParams.heroSkillId = simpleForm_pb.extParams.heroSkillId
	extParams.psychicSkillId = simpleForm_pb.extParams.psychicSkillId
	extParams.formStrengthId = simpleForm_pb.extParams.formStrengthId
	extParams.formStrengthLv = simpleForm_pb.extParams.formStrengthLv
	extParams.elementalMasterId = simpleForm_pb.extParams.elementalMasterId
	extParams.elementalTargetId = simpleForm_pb.extParams.elementalTargetId
	extParams.cutePetId = simpleForm_pb.extParams.cutePetId
	extParams.cutePetRaceId = simpleForm_pb.extParams.cutePetRaceId
	extParams.cutePetQuality = simpleForm_pb.extParams.cutePetQuality
	self._svrFormation[challengeId][stageId] = supportInfo
end

function LegendModel:saveCurrFormation(challengeId, stageId)
	if challengeId == nil then
		challengeId, stageId = self:getOpenChallengeIdAndStageId()
	end

	local isDirty = false

	if not self._svrFormation or not self._svrFormation[challengeId] or not self._svrFormation[challengeId][stageId] then
		printError("test svrFormation can be nil", challengeId, stageId)

		return
	end

	local svrFormation = self._svrFormation[challengeId][stageId]
	local curFormation = self:_getFormationById(challengeId, stageId)

	if svrFormation.simpleForm.extParams.heroSkillId ~= curFormation:GetHeroSkillId() then
		isDirty = true
	end

	if not isDirty and svrFormation.simpleForm.extParams.psychicSkillId ~= curFormation:GetPsychicedSkillId() then
		isDirty = true
	end

	if not isDirty and (svrFormation.simpleForm.extParams.elementalMasterId ~= curFormation:GetElementalMasterId() or svrFormation.simpleForm.extParams.elementalTargetId ~= curFormation:GetElementalTargetId()) then
		isDirty = true
	end

	if not isDirty then
		local poses = curFormation:GetPositions()
		local svrPoses = svrFormation.simpleForm.pos

		for i = 1, #poses do
			if poses[i] ~= svrPoses[i] then
				isDirty = true

				break
			end
		end
	end

	local form = curFormation:createFormPb()

	LegendController.instance:sendSupportSetFormReq(challengeId, stageId, form)

	return isDirty
end

function LegendModel:getCurFormationId()
	local challengeId, stageId = self:getOpenChallengeIdAndStageId()

	return self:_getFormationById(challengeId, stageId):GetId()
end

function LegendModel:getFormation()
	local challengeId, stageId = self:getOpenChallengeIdAndStageId()

	return self:_getFormationById(challengeId, stageId)
end

function LegendModel:_getFormationById(challengeId, stageId)
	if self:isExistSupportPet() then
		if self._formation[challengeId] and self._formation[challengeId][stageId] then
			return self._formation[challengeId][stageId]
		else
			self._formation[challengeId] = self._formation[challengeId] or {}
			self._formation[challengeId][stageId] = self._formation[challengeId][stageId] or LegendFormationMO.New()

			return self._formation[challengeId][stageId]
		end
	else
		return FormationNewModel.instance:GetCurTeam():GetCurFormation()
	end
end

function LegendModel:getFormPetsHeroSkills()
	local formation = self:getFormation()
	local pet_poisition = formation:GetPositions()
	local heroskills = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:getPet(checknumber(v))
			local petCo = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

			if petCo.heroSkillId > 0 and not TableUtil.isHad(heroskills, petCo.heroSkillId) then
				table.insert(heroskills, petCo.heroSkillId)
			end
		end
	end

	return heroskills
end

function LegendModel:getHeroSkillId()
	local challengeId, stageId = self:getOpenChallengeIdAndStageId()

	return self:_getFormationById(challengeId, stageId):GetHeroSkillId()
end

function LegendModel:changeSkillId(id)
	local challengeId, stageId = self:getOpenChallengeIdAndStageId()

	return self:_getFormationById(challengeId, stageId):SetHeroSkillId(id)
end

function LegendModel:getAllPets(needSupportId)
	local allPets = BagPetsController.instance:getFightBagPet() or {}

	if needSupportId then
		local creepId = self:getCreepsId()
		local mo = self:getSupportPet(creepId)

		if mo then
			allPets[#allPets + 1] = mo
		end
	else
		allPets = PetHireModel.instance:appendListByHirePets(allPets)
	end

	return allPets
end

function LegendModel:setTeamId(id)
	self._teamId = id
end

function LegendModel:getTeamId()
	return self._teamId
end

function LegendModel:getPet(petId)
	if checknumber(petId) <= 0 then
		return
	end

	local pet = BagPetsController.instance:getPet(petId)

	pet = PetHireModel.instance:tryGetHirePetMo(petId, pet)

	if pet == nil then
		pet = self:getSupportPet(petId)
	end

	return pet
end

function LegendModel:checkHasInTeamByRaceId(raceId)
	local formation

	if self:isExistSupportPet() then
		local creepId = self:getCreepsId()
		local suppportCfg = LegendConfig.instance:getSupportCfg(creepId)

		if suppportCfg and raceId == suppportCfg.raceId then
			return true
		end

		formation = self:getOriginalCurFormation()
	else
		formation = self:_getCurFormation()
	end

	for _, petId in ipairs(formation:GetPositions()) do
		if petId > 0 then
			local pet = self:getPetMoById(petId)

			if pet and pet.raceId == raceId then
				return true
			end
		end
	end

	return false
end

function LegendModel:getPetMoById(petId)
	local mo

	if LegendModel.instance:isExistSupportPet() then
		mo = LegendModel.instance:getPet(petId)
	else
		mo = BagPetsController.instance:getPet(petId)
		mo = PetHireModel.instance:tryGetHirePetMo(petId, mo)
	end

	return mo
end

function LegendModel:diffRacePetCount()
	local isExist = self:isExistSupportPet()
	local allPets = self:getAllPets(isExist)

	ArraySort.sortOn(allPets, "raceId")

	local lastId = -1
	local num = 0

	for i, v in ipairs(allPets) do
		if lastId ~= v.raceId then
			lastId = v.raceId
			num = num + 1
		end
	end

	return num
end

function LegendModel:getCreepsId()
	local challengeId, stageId = self:getOpenChallengeIdAndStageId()
	local cfg = LegendConfig.instance:getSuportCfgByChallengeId(challengeId, stageId)

	return (cfg or nil) and (cfg.creepsId or 0)
end

function LegendModel:getSupportPet(creepsId)
	self._supportPet[creepsId] = self._supportPet[creepsId] or self:createPet(creepsId)

	return self._supportPet[creepsId]
end

function LegendModel:createPet(creepsId)
	local creepCfg = LegendConfig.instance:getSupportCfg(creepsId)

	if creepCfg ~= nil then
		local fPowerPet = FightingPowerPetMo.New()

		fPowerPet:fromChallengeCreepCo(creepCfg)

		local petMo = fPowerPet:toBaseBagPetMo()

		petMo.petId = creepsId
		petMo.isSupportedPet = true

		return petMo
	end

	return nil
end

function LegendModel:getOriginalCurFormation()
	if LegendModel.instance:isExistSupportPet() then
		return LegendModel.instance:getFormation()
	else
		return FormationNewModel.instance:GetCurTeam():GetCurFormation()
	end
end

function LegendModel:_getCurFormation()
	return PetHireModel.instance:getFormationMoByFormId(PetHireModel.ID_TYPE_NORMAL)
end

LegendModel.instance = LegendModel.New()

return LegendModel
