-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/model/KdStageCustomFmtMo.lua

module("logic.extensions.kingdragonchallenge.model.KdStageCustomFmtMo", package.seeall)

local KdStageCustomFmtMo = class("KdStageCustomFmtMo", ICustomFmtMo)

function KdStageCustomFmtMo:onReset()
	KdStageCustomFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function KdStageCustomFmtMo:updateCfg(stageId)
	self._stageId = checknumber(stageId)
	self._challengeId = KdChallengeModel.instance:getCurChallengeId()
	self._stageData = KdChallengeConfig.instance:getKdStageDataByCId(self._challengeId, self._stageId)
	self._enemyData = KdChallengeConfig.instance:getKdChallengeEnemyCfg(self._stageData.creepsMasterId)
end

function KdStageCustomFmtMo:updateData()
	self.topTitleStr = self._enemyData.name
	self.ruleDescStr = self._enemyData.WinDesc
	self.validatorDescStr = self._enemyData.missionDesc
	self.needUpPetCount = 6

	self:initFormationMo()
	self:setFormCondition(self._enemyData.formCondition)
	self:initPetList()
end

function KdStageCustomFmtMo:initFormationMo()
	local key = self:_getFormationMoKey()

	if key == nil then
		return
	end

	local userId = RoleModel.instance:getUserId()

	if self._curUserId ~= userId then
		self._curUserId = userId
		self._formationMoPool = nil
	end

	self._formationMoPool = self._formationMoPool or {}
	self.formationMo = self._formationMoPool[key] or FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	self._formationMoPool[key] = self.formationMo
end

function KdStageCustomFmtMo:_getFormationMoKey()
	return self._stageId
end

function KdStageCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		KdChallengeController.instance:sendPM_TQKingDragonStageClgReq(self._challengeId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KdStageCustomFmtMo:initPetList()
	self:clearAllPetList()

	local helpCfg = KdChallengeConfig.instance:getKdHelpPetCfg(self._stageData.helpPlanId)

	if helpCfg then
		local fmo = FightingPowerPetMo.New()

		for _, helpData in pairs(helpCfg) do
			local systemPetData = KdChallengeConfig.instance:getKdChallengeSystemPetData(helpData.creepsSysId)

			fmo:fromChallengeCreepCo(systemPetData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			if checknumber(petMo.petId) < 1100000001 then
				self:addPetToList(petMo)
			end
		end

		fmo = nil
	end
end

function KdStageCustomFmtMo:getMonsterConfigList()
	return KdChallengeConfig.instance:getKdChallengeCreepsCfg(self._enemyData.creepsMasterId)
end

function KdStageCustomFmtMo:getFmtInfoConfig()
	return self._enemyData
end

function KdStageCustomFmtMo:updateCellTop(cell, petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local hpRatio = KdChallengeModel.instance:getPetHpRatioAsStage(petMo:getPetId())

		proxy.binder:onUpdateHp(hpRatio / 10000)
	end
end

function KdStageCustomFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNoHp(petMo:getPetId())
end

function KdStageCustomFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNoHp(petMo:getPetId()) then
		FloatWordMgr.instance:show(lang("moyanfmtrightview__1"))
	end
end

function KdStageCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if KdStageCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		return not self:_isPetNoHp(petId)
	else
		return false
	end
end

function KdStageCustomFmtMo:_isPetNoHp(petId)
	local hpRatio = KdChallengeModel.instance:getPetHpRatioAsStage(petId)

	return hpRatio <= 0
end

function KdStageCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function KdStageCustomFmtMo:getFinalFmoList(posList, petPool, needPets)
	if self.needUpPetCount > 5 then
		posList, petPool = CustomFmtController.instance:extraPetAtFormation(self.needUpPetCount, needPets, petPool, posList, self:getCurFormation())
	end

	return posList, petPool
end

return KdStageCustomFmtMo
