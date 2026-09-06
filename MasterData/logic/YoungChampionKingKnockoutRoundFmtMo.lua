-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/model/YoungChampionKingKnockoutRoundFmtMo.lua

module("logic.extensions.youngchampionking.model.YoungChampionKingKnockoutRoundFmtMo", package.seeall)

local YoungChampionKingKnockoutRoundFmtMo = class("YoungChampionKingKnockoutRoundFmtMo", ICustomFmtMo)

function YoungChampionKingKnockoutRoundFmtMo:initParams(activityId, gameRoundId, myForm, emenyForm, startTime)
	self.activityId = activityId
	self.gameRoundId = gameRoundId
	self.myForm = myForm
	self.emenyForm = emenyForm
	self.curRoundStartTime = checknumber(startTime)
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
	self._lastRoundPetMap = {}
	self.needUpPetCount = 0

	if self.myForm then
		local pos = self.myForm.pos

		for i = 1, 9 do
			local petId = checknumber(pos[i])

			if petId > 0 then
				table.insert(self._fixPosList, i)

				self._lastRoundPetMap[petId] = true

				local petMo = BagPetsController.instance:getPet(petId)

				if not petMo:isSummonedPet() then
					self.needUpPetCount = self.needUpPetCount + 1
				end
			end
		end
	end

	local gameRoundCfg = YoungChampionKingConfig.instance:getKnockoutGameCfg(self.activityId, self.gameRoundId)

	self.needUpPetCount = self.needUpPetCount + gameRoundCfg.petNum

	self:initPetList()
	self:refreshMyFmts()

	local banPetList = YoungChampionKingModel.instance:getBanPetRaceIds()

	self._lockedRaceIdMap = {}

	for _, raceId in ipairs(banPetList) do
		self._lockedRaceIdMap[raceId] = true
	end
end

function YoungChampionKingKnockoutRoundFmtMo:refreshMyFmts()
	self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))

	local formMo = self:getCurFormation()

	formMo:SetData(self.myForm)
end

function YoungChampionKingKnockoutRoundFmtMo:getFixedPosList()
	return self._fixPosList
end

function YoungChampionKingKnockoutRoundFmtMo:getFailedTips()
	if self.gameRoundId == 4 then
		return lang("本轮不能调整阵上精灵")
	else
		return nil
	end
end

function YoungChampionKingKnockoutRoundFmtMo:getCurFormation()
	self.formationMo = self.formationMo or FormationMO.New(GameUtil.handler(self.getPetMoById, self))

	return self.formationMo
end

function YoungChampionKingKnockoutRoundFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if self.emenyForm then
		local opForm = self.emenyForm

		for _, basePetView in ipairs(opForm.petSimpleView) do
			local posId

			for i = 1, 9 do
				if basePetView.petId == opForm.curForm.pos[i] then
					posId = i
				end
			end

			if posId then
				local petMo = FightingPowerPetMo.fromBasePetView(basePetView, nil, posId)

				table.insert(teams, petMo)

				formations[posId] = petMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function YoungChampionKingKnockoutRoundFmtMo:updateData()
	self:initPetList()
end

function YoungChampionKingKnockoutRoundFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		local petMoForm = self:_changePetMo(petMo)
		local petId = petMoForm:getPetId()

		if not self._lastRoundPetMap[petId] and (petMoForm:isSummonedMaster() or petMoForm:isSummonedPet()) then
			petMoForm.summonedPetId = 0
			petMoForm.summonMasterId = 0
		end

		self:addPetToList(petMoForm)
	end
end

function YoungChampionKingKnockoutRoundFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function YoungChampionKingKnockoutRoundFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function YoungChampionKingKnockoutRoundFmtMo:initFightHandler()
	self:setFightHandler(function()
		return
	end, nil)
end

function YoungChampionKingKnockoutRoundFmtMo:getMonsterConfigList()
	return {}
end

function YoungChampionKingKnockoutRoundFmtMo:getFmtInfoConfig()
	if self.emenyForm then
		return self.emenyForm.curForm.extParams
	end

	return ""
end

function YoungChampionKingKnockoutRoundFmtMo:onClickCloseBtn(handler)
	TipsFacade.instance:openTipWindowNoX("提示", "进入淘汰赛比赛，不能退出", function()
		return
	end)
end

function YoungChampionKingKnockoutRoundFmtMo:showForbitPetAlert(petMo)
	local boo, tips = self:checkPetIsForbit(petMo)

	FloatWordMgr.instance:show(tips)
end

function YoungChampionKingKnockoutRoundFmtMo:checkPetIsForbit(checkPetMo)
	local isForbit = false
	local tips = ""

	if isForbit == false and self:_isPetNotCanUp(checkPetMo:getDefineId()) then
		isForbit = true
		tips = lang("该精灵已被禁用")
	end

	return isForbit, tips
end

function YoungChampionKingKnockoutRoundFmtMo:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] == true
	else
		return false
	end
end

function YoungChampionKingKnockoutRoundFmtMo:getExtendViewName()
	return ViewName.YoungChampionKingFmtExView
end

function YoungChampionKingKnockoutRoundFmtMo:getLastRoundPetMap()
	return self._lastRoundPetMap or {}
end

function YoungChampionKingKnockoutRoundFmtMo:getSetSummonPetTips()
	return lang("上阵成功")
end

return YoungChampionKingKnockoutRoundFmtMo
