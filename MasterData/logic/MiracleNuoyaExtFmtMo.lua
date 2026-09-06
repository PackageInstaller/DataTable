-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/model/MiracleNuoyaExtFmtMo.lua

module("logic.extensions.miraclenuoya.model.MiracleNuoyaExtFmtMo", package.seeall)

local MiracleNuoyaExtFmtMo = class("MiracleNuoyaExtFmtMo", BaseCustomFmtMo)

function MiracleNuoyaExtFmtMo:onInit()
	MiracleNuoyaExtFmtMo.super.onInit(self)

	self.needUpPetCount = 6
end

function MiracleNuoyaExtFmtMo:initParams(activityId, blockId)
	self._activityId = activityId
	self.blockId = blockId
	self._activityType = MiracleNuoyaController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local mapCfg = MiracleNuoyaConfig.instance:getMapBlockCfgById(self._activityId, self.blockId) or {}

	self._supportPetId = MiracleNuoyaController.instance:getMySupportPetIdWithGender(self._activityId)
	self._supportPetPosId = 0
	self._fixPosList = {}

	if mapCfg and checknumber(mapCfg.supportPetPosId) > 0 then
		self._supportPetPosId = checknumber(mapCfg.supportPetPosId)

		table.insert(self._fixPosList, self._supportPetPosId)
	end

	local info = MiracleNuoyaModel.instance:getInfo(self._activityId) or {}

	if not info.extremeClgInfo then
		local extremeClgInfo = {}

		self._supportPetLeftHpPercent = checknumber(extremeClgInfo.extremeClgSupportPetLeftHpPercent)
		self.creepsMasterId = mapCfg.creepsMasterId
		self.masterCfg = MiracleNuoyaConfig.instance:getMonsterCfgById(self.creepsMasterId)
		self.creeps = MiracleNuoyaConfig.instance:getCreepsCfgById(self.creepsMasterId)

		self:setFormCondition(self.masterCfg.formCondition)

		self.isShowTab = false
		self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
		self.strShowRuleFlagKey = "MiracleNuoyaExtFmtMo" .. self._activityId .. "_" .. self.creepsMasterId
		self.topTitleStr = self.masterCfg.name
		self.ruleDescStr = self.masterCfg.ruleDesc
		self.isPopRuleDesc = true
	end
end

function MiracleNuoyaExtFmtMo:getMonsterConfigList()
	return self.creeps
end

function MiracleNuoyaExtFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function MiracleNuoyaExtFmtMo:initFightHandler()
	self:setFightHandler(function()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		MiracleNuoyaController.instance:sendExtStartFight(self._activityId, self.blockId, self:getCurSimpleForm())
	end, nil)
end

function MiracleNuoyaExtFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
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
		FloatWordMgr.instance:show("只上阵奥奇不可开始战斗")

		return true
	else
		return MiracleNuoyaExtFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end
end

function MiracleNuoyaExtFmtMo:_createSuppopPetMo(petId)
	local petMo
	local supportCfg = MiracleNuoyaConfig.instance:getSupportCfgById(petId)

	if supportCfg then
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(supportCfg)
		fmo:setSupportedPet(true)

		petMo = fmo:toBaseBagPetMo()
		petMo.hideZdl = true
	end

	return petMo
end

function MiracleNuoyaExtFmtMo:updateData()
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

function MiracleNuoyaExtFmtMo:getFixedPosList()
	return self._fixPosList
end

function MiracleNuoyaExtFmtMo:getExtendViewName()
	return ViewName.MiraclenuoyatipsView
end

function MiracleNuoyaExtFmtMo:updateCellTop(cell, petMo)
	local petId = petMo:getPetId()

	if self._supportPetId == petId then
		local luaCls = PetHpSlider
		local url = PetHpSlider.prefabUrl
		local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

		if proxy then
			proxy.binder:onUpdateHp((self._supportPetLeftHpPercent > 0 or nil) and self._supportPetLeftHpPercent / 100)
		end
	else
		self:clearCellTop(cell)
	end
end

return MiracleNuoyaExtFmtMo
