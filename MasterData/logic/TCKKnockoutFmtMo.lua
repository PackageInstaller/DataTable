-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/model/TCKKnockoutFmtMo.lua

module("logic.extensions.teenchampionking.model.TCKKnockoutFmtMo", package.seeall)

local TCKKnockoutFmtMo = class("TCKKnockoutFmtMo", BaseCustomFmtMo)

function TCKKnockoutFmtMo:initParams(activityId, startTime)
	self.activityId = activityId
	self.gameRoundId = 1
	self.curRoundStartTime = checknumber(startTime)
	self.isOnlyUpdateExistPet = true
	self.isShowBtnFormationUse = false
	self.isShowBtnFormationEdit = false
	self.isShowBtnFormation = false
	self.isShowBtnContractPet = true
	self.isShowBtnBuffForm = false
	self.isShowMaxBuffFormLv = false
	self.isShowBtnCutePet = false
	self.isStartButtonAvailable = false
	self.isShowOneKey = false
	self.isShowClean = false
	self.isShowPetBag = false
	self.topTitleStr = "奥奇竞技大赛"
	self.ruleDescStr = "击败敌阵全部精灵"
	self.needUpPetCount = 1
	self._selectPetIds = {}
	self._isUseSystem = false
	self._actCfg = TeenChampionKingConfig.instance:getActCfg(self.activityId)
	self._curSummonMasterId = TeenChampionKingController.instance:getSummonMasterId(self.activityId)
	self._curSummonMonsterId = TeenChampionKingController.instance:getSummonMonsterId(self.activityId)

	local info = TeenChampionKingModel.instance:getGlobalInfo(self.activityId)

	if info then
		self._isUseSystem = info.useSysProperty

		if not info.selectPetIds then
			do
				local selectPetIds = {}

				for _, petId in ipairs(selectPetIds) do
					table.insert(self._selectPetIds, petId)
				end
			end

			local formMo = self:getCurFormation()

			formMo:ResetPosition(true)
			self:initPetList()
		end
	end
end

function TCKKnockoutFmtMo:getFixedPosList()
	return {}
end

function TCKKnockoutFmtMo:initPetList()
	self:clearAllPetList()

	local zhsRaceIds = {}
	local raceMap = {}

	for _, petId in ipairs(self._selectPetIds) do
		local petMo = self:_getPetMo(petId)

		if petMo then
			raceMap[petMo.raceId] = petMo

			if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi) then
				table.insert(zhsRaceIds, petMo.raceId)
				self:addPetToList(self:_changePetMo(petMo))
			end
		end
	end

	for _, zhsRaceId in ipairs(zhsRaceIds) do
		local cfgList = ContractConfig.instance:getSummonBySummonMasterId(zhsRaceId)

		for _, cfg in ipairs(cfgList) do
			local matchPetMo = raceMap[cfg.summonRaceId]

			if matchPetMo then
				self:addPetToList(self:_changePetMo(matchPetMo))
			end
		end
	end
end

function TCKKnockoutFmtMo:_getPetMo(petId)
	local petMo
	local sysCfg = TeenChampionKingConfig.instance:getSystemPetByCreepsId(petId)

	if sysCfg then
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(sysCfg)

		petMo = fMo:toBaseBagPetMo()
		petMo.isSupportedPet = true
	else
		petMo = BagPetsController.instance:getPet(petId)
	end

	return petMo
end

function TCKKnockoutFmtMo:_changePetMo(petMo)
	if not petMo then
		return
	end

	if self._isUseSystem and not petMo.isSupportedPet then
		local maxPetMo = FightingPowerPetMo.getMaxPetMoByData(petMo)

		for k, v in pairs(GameEnum.AttrModelType) do
			maxPetMo.attrMo.extModelBaseAttrRate[v] = checknumber(self._actCfg.sysZdlWanPercent) / 10000
		end

		maxPetMo.isMyPackPet = false

		maxPetMo:calcAllAttr()

		maxPetMo.isMyPackPet = petMo.isMyPackPet

		if self._curSummonMonsterId == maxPetMo.petId then
			maxPetMo.summonMasterId = self._curSummonMasterId
		end

		if self._curSummonMasterId == maxPetMo.petId then
			maxPetMo.summonedPetId = self._curSummonMonsterId
		end

		return maxPetMo
	else
		local petMoForm = petMo:GetClone()

		if self._curSummonMonsterId == petMoForm.petId then
			petMoForm.summonMasterId = self._curSummonMasterId
		end

		if self._curSummonMasterId == petMoForm.petId then
			petMoForm.summonedPetId = self._curSummonMonsterId
		end

		petMoForm.attrMo:resetPublicAttr()
		petMoForm.attrMo:calcTotalAttrs()
		petMoForm:refreshAllAttr()

		return petMoForm
	end
end

function TCKKnockoutFmtMo:initFightHandler()
	self:setFightHandler(function()
		return
	end, nil)
end

function TCKKnockoutFmtMo:getMonsterConfigList()
	return {}
end

function TCKKnockoutFmtMo:getFmtInfoConfig()
	return ""
end

function TCKKnockoutFmtMo:onClickCloseBtn(handler)
	TipsFacade.instance:openPopupWindow("提示", "主动退出布阵将视为战斗失败，是否退出？", function()
		TeenChampionKingController.instance:leaveGame(self.activityId)
	end)
end

function TCKKnockoutFmtMo:getExtendViewName()
	return ViewName.TCKFmtExView
end

return TCKKnockoutFmtMo
