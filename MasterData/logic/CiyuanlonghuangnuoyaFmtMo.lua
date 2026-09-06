-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/model/CiyuanlonghuangnuoyaFmtMo.lua

module("logic.extensions.ciyuanlonghuangnuoya.model.CiyuanlonghuangnuoyaFmtMo", package.seeall)

local CiyuanlonghuangnuoyaFmtMo = class("CiyuanlonghuangnuoyaFmtMo", BaseCustomFmtMo)

function CiyuanlonghuangnuoyaFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId
	self._lockedRaceMap = {}

	local info = CiyuanlonghuangnuoyaModel.instance:getInfo(self.activityId) or {}

	if not info.stageInfo then
		local stageInfoList = {}

		for i, v in pairs(stageInfoList) do
			if v.raceIdLocked then
				for j, raceId in ipairs(v.raceIdLocked) do
					self._lockedRaceMap[raceId] = true
				end
			end
		end

		local groupCfg = CiyuanlonghuangnuoyaConfig.instance:getStageCfgById(activityId, phaseId, stageId) or {}

		self._supportPetId = checknumber(groupCfg.creepsId)
		self._supportPetPosId = 0
		self._fixPosList = {}

		if self._supportPetId > 0 then
			local supportCfg = CiyuanlonghuangnuoyaConfig.instance:getSupportCfgById(self.activityId, self._supportPetId)

			self._supportPetPosId = checknumber(supportCfg.posId)

			if self._supportPetPosId > 0 then
				table.insert(self._fixPosList, self._supportPetPosId)
			end
		end

		self.creepsMasterId = groupCfg.creepsMasterId
		self.masterCfg = CiyuanlonghuangnuoyaConfig.instance:getMonsterCfgById(self.creepsMasterId)
		self.creeps = CiyuanlonghuangnuoyaConfig.instance:getCreepsById(self.creepsMasterId)

		self:setFormCondition(self.masterCfg.formCondition)

		self.isShowTab = false
		self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
		self.strShowRuleFlagKey = "CiyuanlonghuangnuoyaFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
		self.topTitleStr = self.masterCfg.name
		self.ruleDescStr = self.masterCfg.ruleDesc
		self.isPopRuleDesc = true
	end
end

function CiyuanlonghuangnuoyaFmtMo:getMonsterConfigList()
	return self.creeps
end

function CiyuanlonghuangnuoyaFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function CiyuanlonghuangnuoyaFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		CiyuanlonghuangnuoyaController.instance:sendStartFight(self.activityId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function CiyuanlonghuangnuoyaFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local isOnlySupport = false
	local formationMo = self:getCurFormation()
	local pets = formationMo:getHasPets()

	if #pets == 1 then
		local petId = pets[1]
		local petMo = self:getPetMoById(petId)

		if petMo and petMo.isSupportedPet then
			isOnlySupport = true
		end
	end

	if isOnlySupport then
		FloatWordMgr.instance:show("需要上阵更多精灵才能开始挑战")

		return true
	else
		return CiyuanlonghuangnuoyaFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end
end

function CiyuanlonghuangnuoyaFmtMo:_createSuppopPetMo(petId)
	local petMo
	local supportCfg = CiyuanlonghuangnuoyaConfig.instance:getSupportCfgById(self.activityId, petId)

	if supportCfg then
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(supportCfg)
		fmo:setSupportedPet(true)

		petMo = fmo:toBaseBagPetMo()
	end

	return petMo
end

function CiyuanlonghuangnuoyaFmtMo:updateData()
	self:tryInitPetList()

	if self._lastSupportId ~= self._supportPetId then
		self:tryRemovePetByIds(self._lastSupportId)

		if self._supportPetId > 0 then
			local supportPetMo = self:_createSuppopPetMo(self._supportPetId)

			self:addPetToList(self:_changePetMo(supportPetMo))
		end
	end

	self._lastSupportId = self._supportPetId

	if self._supportPetId > 0 then
		local fmo = self:getCurFormation()

		if self._supportPetPosId > 0 then
			fmo:SetPosition(self._supportPetPosId, self._supportPetId)
		else
			local pos = fmo:GetPetPosition(self._supportPetId)

			if pos then
				fmo:SetPosition(pos, 0)
			end
		end
	end
end

function CiyuanlonghuangnuoyaFmtMo:getFixedPosList()
	return self._fixPosList
end

function CiyuanlonghuangnuoyaFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function CiyuanlonghuangnuoyaFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("封印精灵无法上阵")
end

return CiyuanlonghuangnuoyaFmtMo
