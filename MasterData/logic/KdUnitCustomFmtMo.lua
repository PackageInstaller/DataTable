-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/model/KdUnitCustomFmtMo.lua

module("logic.extensions.kingdragonchallenge.model.KdUnitCustomFmtMo", package.seeall)

local KdUnitCustomFmtMo = class("KdUnitCustomFmtMo", ICustomFmtMo)

function KdUnitCustomFmtMo:onReset()
	KdUnitCustomFmtMo.super.onReset(self)
end

function KdUnitCustomFmtMo:updateCfg(unitId)
	self._unitId = checknumber(unitId)
	self._challengeId = KdChallengeModel.instance:getCurChallengeId()
	self._unitData = KdChallengeConfig.instance:getKdUnitDataByCId(self._challengeId, self._unitId)
	self._enemyData = KdChallengeConfig.instance:getKdChallengeEnemyCfg(self._unitData.creepsMasterId)
end

function KdUnitCustomFmtMo:updateData()
	self.topTitleStr = self._enemyData.name
	self.ruleDescStr = self._enemyData.WinDesc
	self.validatorDescStr = self._enemyData.missionDesc

	self:setFormCondition(self._enemyData.formCondition)
	self:initPetList()
end

function KdUnitCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		KdChallengeController.instance:sendPM_TQKingDragonUnitClgReq(self._challengeId, self._unitId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function KdUnitCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function KdUnitCustomFmtMo:getMonsterConfigList()
	return KdChallengeConfig.instance:getKdChallengeCreepsCfg(self._enemyData.creepsMasterId)
end

function KdUnitCustomFmtMo:getFmtInfoConfig()
	return self._enemyData
end

function KdUnitCustomFmtMo:updateCellTop(cell, petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local hpRatio = KdChallengeModel.instance:getPetHpRatioAsUnit(petMo:getPetId())

		proxy.binder:onUpdateHp(hpRatio / 10000)
	end
end

function KdUnitCustomFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNoHp(petMo:getPetId())
end

function KdUnitCustomFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNoHp(petMo:getPetId()) then
		FloatWordMgr.instance:show(lang("moyanfmtrightview__1"))
	end
end

function KdUnitCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function KdUnitCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if KdUnitCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		return not self:_isPetNoHp(petId)
	else
		return false
	end
end

function KdUnitCustomFmtMo:_isPetNoHp(petId)
	local hpRatio = KdChallengeModel.instance:getPetHpRatioAsUnit(petId)

	return hpRatio <= 0
end

return KdUnitCustomFmtMo
