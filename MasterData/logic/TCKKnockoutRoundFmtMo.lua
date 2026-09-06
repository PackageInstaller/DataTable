-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/model/TCKKnockoutRoundFmtMo.lua

module("logic.extensions.teenchampionking.model.TCKKnockoutRoundFmtMo", package.seeall)

local TCKKnockoutRoundFmtMo = class("TCKKnockoutRoundFmtMo", BaseCustomFmtMo)

function TCKKnockoutRoundFmtMo:initFormationMo()
	TCKKnockoutRoundFmtMo.super.initFormationMo(self)

	self._petMapAsRight = {}
	self._formationMoOfEnemy = FormationMO.New(GameUtil.handler(self.getPetMoByIdOfEnemy, self))
end

function TCKKnockoutRoundFmtMo:getPetMoByIdOfEnemy(petId)
	return self._petMapAsRight[petId]
end

function TCKKnockoutRoundFmtMo:initParams(activityId, gameRoundId, myForm, emenyForm, startTime, opUseSysProperty)
	self.activityId = activityId
	self.gameRoundId = gameRoundId
	self.isOnlyUpdateExistPet = true
	self.myForm = myForm
	self.emenyForm = emenyForm
	self.curRoundStartTime = checknumber(startTime)
	self.opUseSysProperty = opUseSysProperty
	self.isShowBtnFormationUse = false
	self.isShowBtnFormationEdit = false
	self.isShowBtnFormation = false
	self.isShowBtnContractPet = false
	self.isShowBtnBuffForm = false
	self.isShowMaxBuffFormLv = false
	self.isShowBtnCutePet = false
	self.isStartButtonAvailable = false
	self.isShowOneKey = false
	self.isShowClean = false
	self.isShowPetBag = false
	self.topTitleStr = "奥奇竞技大赛"
	self.ruleDescStr = "击败敌阵全部精灵"

	if self.gameRoundId == 4 then
		self.isShowBtnCutePet = true
	end

	self._fixPosList = {}
	self._actCfg = TeenChampionKingConfig.instance:getActCfg(self.activityId)
	self._lastRoundPetMap = {}
	self._selectPetIds = {}
	self._isUseSystem = false

	local info = TeenChampionKingModel.instance:getGlobalInfo(self.activityId)

	if info then
		self._isUseSystem = info.useSysProperty

		if not info.selectPetIds then
			local selectPetIds = {}

			for _, petId in ipairs(selectPetIds) do
				table.insert(self._selectPetIds, petId)
			end
		end
	end

	self._lastMasterPetId = checknumber(self.myForm.summonMasterPetId)

	self:initPetList()
	self:refreshMyFmts()

	local formationMo = self:getCurFormation()

	self.needUpPetCount = 0

	if self.myForm then
		local curSummonId = formationMo:GetSummonPetId()
		local pos = self.myForm.pos

		for i = 1, 9 do
			local petId = checknumber(pos[i])

			if petId > 0 then
				table.insert(self._fixPosList, i)

				self._lastRoundPetMap[petId] = true

				if curSummonId ~= petId then
					self.needUpPetCount = self.needUpPetCount + 1
				end
			end
		end
	end

	local gameRoundCfg = TeenChampionKingConfig.instance:getGameRoundCfg(self.activityId, self.gameRoundId)

	if gameRoundCfg then
		self.needUpPetCount = self.needUpPetCount + gameRoundCfg.petNum
	end

	self:_updateEnemyFmt()
	self:_updateEnemyFmt()
end

function TCKKnockoutRoundFmtMo:refreshMyFmts()
	local formMo = self:getCurFormation()

	formMo:SetData(self.myForm)
end

function TCKKnockoutRoundFmtMo:_updateEnemyFmt()
	local simpleForm = self.emenyForm.curForm

	if not self.emenyForm.petSimpleView then
		local summonedPetId = self.emenyForm.curForm.extParams.summonedPetId
		local summonMasterPetId = self.emenyForm.curForm.extParams.summonMasterPetId

		for _, basePetView in ipairs(self.emenyForm.petSimpleView) do
			local petMo = BagPetMo.New()

			petMo:initBaseView(basePetView)

			local fightingPowerMo = petMo:toFightingPowerPetMo()

			fightingPowerMo.petId = petMo:getPetId()

			if fightingPowerMo.petId == summonedPetId then
				fightingPowerMo.summonMasterId = summonMasterPetId
			end

			if fightingPowerMo.petId == summonMasterPetId then
				fightingPowerMo.summonedPetId = summonedPetId
			end

			if self.opUseSysProperty then
				local sysCfg = TeenChampionKingConfig.instance:getSystemPetByCreepsId(petMo.petId)

				if not sysCfg then
					local maxPetMo = FightingPowerPetMo.getMaxPetMoByData(petMo)

					for k, v in pairs(GameEnum.AttrModelType) do
						maxPetMo.attrMo.extModelBaseAttrRate[v] = checknumber(self._actCfg.sysZdlWanPercent) / 10000
					end

					maxPetMo.isMyPackPet = false

					maxPetMo:calcAllAttr()

					maxPetMo.isMyPackPet = petMo.isMyPackPet
					fightingPowerMo = maxPetMo
				end
			end

			fightingPowerMo.attrMo:calcTotalAttrs()
			fightingPowerMo:refreshAllAttr()

			self._petMapAsRight[fightingPowerMo.petId] = fightingPowerMo
		end

		self._formationMoOfEnemy:SetData(simpleForm)
	end
end

function TCKKnockoutRoundFmtMo:getFixedPosList()
	return self._fixPosList
end

function TCKKnockoutRoundFmtMo:getFailedTips()
	if self.gameRoundId == 4 then
		return lang("本轮不能调整阵上精灵")
	else
		return nil
	end
end

function TCKKnockoutRoundFmtMo:getTeamAndFormation(creepCfg)
	local fmtMo = self._formationMoOfEnemy
	local teams, formations, speed = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	local resultFormations = {}

	for posId, fightingPowerMo in pairs(formations) do
		resultFormations[posId] = fightingPowerMo
	end

	return teams, resultFormations
end

function TCKKnockoutRoundFmtMo:initPetList()
	self:clearAllPetList()

	for _, petId in pairs(self._selectPetIds) do
		local petMo = self:_getPetMo(petId)

		if petMo then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function TCKKnockoutRoundFmtMo:_getPetMo(petId)
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

function TCKKnockoutRoundFmtMo:_changePetMo(petMo)
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

		if maxPetMo.summonedPetId > 0 and maxPetMo.summonedPetId ~= self._lastMasterPetId then
			maxPetMo.summonedPetId = 0
		end

		return maxPetMo
	else
		local petMoForm = petMo:GetClone()

		if petMoForm.summonedPetId > 0 and petMoForm.summonedPetId ~= self._lastMasterPetId then
			petMoForm.summonedPetId = 0
		end

		if not petMo.isSupportedPet then
			petMoForm.attrMo:resetPublicAttr()
		end

		petMoForm.attrMo:calcTotalAttrs()
		petMoForm:refreshAllAttr()

		return petMoForm
	end
end

function TCKKnockoutRoundFmtMo:initFightHandler()
	self:setFightHandler(function()
		return
	end, nil)
end

function TCKKnockoutRoundFmtMo:getMonsterConfigList()
	return {}
end

function TCKKnockoutRoundFmtMo:getFmtInfoConfig()
	if self.emenyForm then
		return self.emenyForm.curForm.extParams
	end

	return ""
end

function TCKKnockoutRoundFmtMo:onClickCloseBtn(handler)
	TipsFacade.instance:openPopupWindow("提示", "主动退出布阵将视为战斗失败，是否退出？", function()
		TeenChampionKingController.instance:leaveGame(self.activityId)
	end)
end

function TCKKnockoutRoundFmtMo:getExtendViewName()
	return ViewName.TCKFmtExView
end

return TCKKnockoutRoundFmtMo
