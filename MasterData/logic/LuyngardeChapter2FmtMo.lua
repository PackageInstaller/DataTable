-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/model/LuyngardeChapter2FmtMo.lua

module("logic.extensions.luyngarde.model.LuyngardeChapter2FmtMo", package.seeall)

local LuyngardeChapter2FmtMo = class("LuyngardeChapter2FmtMo", BaseCustomFmtMo)

function LuyngardeChapter2FmtMo:initParams(activityId, creepsMasterId, simulated)
	self.activityId = activityId

	local actCfg = LuyngardeConfig.instance:getActCfg(self.activityId)

	self.lockRackId = actCfg.lockRaceId
	self.creepId = creepsMasterId
	self.simulated = simulated
	self.creeps = LuyngardeConfig.instance:getTeamCfg(self.creepId)
	self.masterCfg = LuyngardeConfig.instance:getCreepCfgs(self.creepId)

	self:setFormCondition(self.creeps.formCondition)

	self.chapterCfg = LuyngardeConfig.instance:getChapterCfg(self.activityId, 2)
	self.helpCfgs = LuyngardeConfig.instance:getSupportPetCfgs(self.activityId, self.chapterCfg.supportPetPoolId)

	local baseInfo = LuyngardeModel.instance:getBaseInfoByActId(self.activityId)

	self.levelCfg = LuyngardeConfig.instance:getPetUpgradeCfgByLevel(self.activityId, baseInfo.level)
	self.needSupPetId = self.levelCfg.creepsId
	self.needSupPetCfg = LuyngardeConfig.instance:getSupportPetCfg(self.activityId, self.needSupPetId)
end

function LuyngardeChapter2FmtMo:getMonsterConfigList()
	return self.masterCfg
end

function LuyngardeChapter2FmtMo:getFmtInfoConfig()
	return self.creeps
end

function LuyngardeChapter2FmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		LuyngardeController.instance:startChapter2Challenge(self.activityId, self.creepId, self.simulated, self:getCurSimpleForm())
	end, nil)
end

function LuyngardeChapter2FmtMo:updateData()
	self:tryInitPetList()

	self.validatorDescStr = string.format("支援精灵:%s必须上阵", self.needSupPetCfg.creepsName)

	if self._lastNeedSupPetId ~= self.needSupPetId then
		self._curNeedSupPetIds = self._curNeedSupPetIds or {}

		for _, petId in ipairs(self._curNeedSupPetIds) do
			self:tryRemovePetByIds(petId)
		end

		table.clear(self._curNeedSupPetIds)

		self._lastNeedSupPetId = self.needSupPetId

		self:_addSupportPet(self.needSupPetId)
		table.insert(self._curNeedSupPetIds, self.needSupPetId)
	end
end

function LuyngardeChapter2FmtMo:_addSupportPet(petId)
	local supportCfg = LuyngardeConfig.instance:getSupportPetCfg(self.activityId, petId)

	if supportCfg then
		local fmo = self:_getFightPowerPetMo()

		fmo:fromChallengeCreepCo(supportCfg)

		local petMo = fmo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end
end

function LuyngardeChapter2FmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(bagPetMoList) do
		self:addPetToList(petMo)
	end

	if self.helpCfgs then
		local fmo = self:_getFightPowerPetMo()

		for _, helpData in pairs(self.helpCfgs) do
			fmo:fromChallengeCreepCo(helpData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end
	end
end

function LuyngardeChapter2FmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function LuyngardeChapter2FmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self:_checkSupPetId() then
		return LuyngardeChapter2FmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	else
		FloatWordMgr.instance:show(string.format("支援精灵:%s必须上阵", self.needSupPetCfg.creepsName))

		return true
	end
end

function LuyngardeChapter2FmtMo:onFormationChangeFinish()
	self:setValidatorDescYesOrNo(self:_checkSupPetId())
end

function LuyngardeChapter2FmtMo:_checkSupPetId()
	local formation = self:getCurFormation()
	local poses = formation:GetPositions()

	for i, id in ipairs(poses) do
		if id > 0 then
			local petMo = self:getPetMoById(id)

			if petMo and petMo.isSupportedPet and petMo.petId == self.needSupPetId then
				return true
			end
		end
	end

	return false
end

function LuyngardeChapter2FmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function LuyngardeChapter2FmtMo:checkPetIsForbit(petMo, baseCheck)
	return petMo.raceId == self.lockRackId and not petMo.isSupportedPet
end

return LuyngardeChapter2FmtMo
