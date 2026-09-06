-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/model/LuyngardeChapter3HelpFmtMo.lua

module("logic.extensions.luyngarde.model.LuyngardeChapter3HelpFmtMo", package.seeall)

local LuyngardeChapter3HelpFmtMo = class("LuyngardeChapter3HelpFmtMo", BaseCustomFmtMo)

function LuyngardeChapter3HelpFmtMo:initParams(activityId, otherUserId, helpId, positionInfo)
	self.activityId = activityId

	local actCfg = LuyngardeConfig.instance:getActCfg(self.activityId)

	self.lockRackId = actCfg.lockRaceId
	self.otherUserId = otherUserId
	self.helpId = helpId

	local cfgId = positionInfo.id
	local exploreStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarCfg(self.activityId, cfgId)

	self.creepId = exploreStarCfg.creepsMasterId
	self.curPosId = positionInfo.positionId
	self.creeps = LuyngardeConfig.instance:getTeamCfg(self.creepId)
	self.masterCfg = LuyngardeConfig.instance:getCreepCfgs(self.creepId)

	self:setFormCondition(self.creeps.formCondition)

	self.chapterCfg = LuyngardeConfig.instance:getChapterCfg(self.activityId, 3)
	self.helpCfgs = LuyngardeConfig.instance:getSupportPetCfgs(self.activityId, self.chapterCfg.supportPetPoolId)

	local baseInfo = LuyngardeModel.instance:getBaseInfoByActId(self.activityId)

	self.levelCfg = LuyngardeConfig.instance:getPetUpgradeCfgByLevel(self.activityId, baseInfo.level)
	self.needSupPetId = self.levelCfg.creepsId
	self.needSupPetCfg = LuyngardeConfig.instance:getSupportPetCfg(self.activityId, self.needSupPetId)
end

function LuyngardeChapter3HelpFmtMo:getMonsterConfigList()
	return self.masterCfg
end

function LuyngardeChapter3HelpFmtMo:getFmtInfoConfig()
	return self.creeps
end

function LuyngardeChapter3HelpFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		LuyngardeController.instance:chapter3HelpClg(self.activityId, self.otherUserId, self.helpId, self.curPosId, self:getCurSimpleForm())
	end, nil)
end

function LuyngardeChapter3HelpFmtMo:updateData()
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

function LuyngardeChapter3HelpFmtMo:_addSupportPet(petId)
	local supportCfg = LuyngardeConfig.instance:getSupportPetCfg(self.activityId, petId)

	if supportCfg then
		local fmo = self:_getFightPowerPetMo()

		fmo:fromChallengeCreepCo(supportCfg)

		local petMo = fmo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end
end

function LuyngardeChapter3HelpFmtMo:initPetList()
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

function LuyngardeChapter3HelpFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function LuyngardeChapter3HelpFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self:_checkSupPetId() then
		return LuyngardeChapter3HelpFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	else
		FloatWordMgr.instance:show(string.format("支援精灵:%s必须上阵", self.needSupPetCfg.creepsName))

		return true
	end
end

function LuyngardeChapter3HelpFmtMo:onFormationChangeFinish()
	self:setValidatorDescYesOrNo(self:_checkSupPetId())
end

function LuyngardeChapter3HelpFmtMo:_checkSupPetId()
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

function LuyngardeChapter3HelpFmtMo:_getFightPowerPetMo()
	self._powerPetMo = self._powerPetMo or FightingPowerPetMo.New()

	return self._powerPetMo
end

function LuyngardeChapter3HelpFmtMo:checkPetIsForbit(petMo, baseCheck)
	return petMo.raceId == self.lockRackId and not petMo.isSupportedPet
end

return LuyngardeChapter3HelpFmtMo
