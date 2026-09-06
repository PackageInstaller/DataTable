-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/model/DivineXiuNuoFmtMo.lua

module("logic.extensions.divinexiunuo.model.DivineXiuNuoFmtMo", package.seeall)

local DivineXiuNuoFmtMo = class("DivineXiuNuoFmtMo", BaseCustomFmtMo)

function DivineXiuNuoFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId
	self._lockedRaceMap = {}

	local info = DivineXiuNuoModel.instance:getInfo(self.activityId) or {}

	if not info.stageInfo then
		local stageInfoList = {}

		for i, v in pairs(stageInfoList) do
			if v.raceIdLocked then
				for j, raceId in ipairs(v.raceIdLocked) do
					self._lockedRaceMap[raceId] = true
				end
			end
		end

		local groupCfg = DivineXiuNuoConfig.instance:getStageCfgById(activityId, phaseId, stageId) or {}

		self._supportPetId = checknumber(groupCfg.creepsId)
		self._supportPetPosId = 0
		self._fixPosList = {}

		if self._supportPetId > 0 then
			local supportCfg = DivineXiuNuoConfig.instance:getSupportCfgById(self.activityId, self._supportPetId)

			self._supportPetPosId = checknumber(supportCfg.posId)

			table.insert(self._fixPosList, self._supportPetPosId)
		end

		self.creepsMasterId = groupCfg.creepsMasterId
		self.masterCfg = DivineXiuNuoConfig.instance:getMonsterCfgById(self.creepsMasterId)
		self.creeps = DivineXiuNuoConfig.instance:getCreepsById(self.creepsMasterId)

		self:setFormCondition(self.masterCfg.formCondition)

		self.isShowTab = false
		self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
		self.strShowRuleFlagKey = "DivineXiuNuoFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
		self.topTitleStr = self.masterCfg.name
		self.ruleDescStr = self.masterCfg.ruleDesc
		self.isPopRuleDesc = true
	end
end

function DivineXiuNuoFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivineXiuNuoFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineXiuNuoFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineXiuNuoController.instance:sendStartFight(self.activityId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function DivineXiuNuoFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
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
		return DivineXiuNuoFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end
end

function DivineXiuNuoFmtMo:_createSuppopPetMo(petId)
	local petMo
	local supportCfg = DivineXiuNuoConfig.instance:getSupportCfgById(self.activityId, petId)

	if supportCfg then
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(supportCfg)
		fmo:setSupportedPet(true)

		petMo = fmo:toBaseBagPetMo()
		petMo.hideZdl = true
	end

	return petMo
end

function DivineXiuNuoFmtMo:updateData()
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

function DivineXiuNuoFmtMo:getFixedPosList()
	return self._fixPosList
end

function DivineXiuNuoFmtMo:getExtendViewName()
	if self.phaseId == DivineXiuNuoController.SPECIAL_PHASE_ID then
		return ViewName.DivinexiunuoextView
	end

	return nil
end

function DivineXiuNuoFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function DivineXiuNuoFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

return DivineXiuNuoFmtMo
