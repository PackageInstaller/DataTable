-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/model/YoungChampionKingKnockoutFmtMo.lua

module("logic.extensions.youngchampionking.model.YoungChampionKingKnockoutFmtMo", package.seeall)

local YoungChampionKingKnockoutFmtMo = class("YoungChampionKingKnockoutFmtMo", ICustomFmtMo)

function YoungChampionKingKnockoutFmtMo:initParams(activityId, gameRoundId)
	self.activityId = activityId
	self.gameRoundId = gameRoundId
	self.curRoundStartTime = 0
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

	local banPetList = YoungChampionKingModel.instance:getBanPetRaceIds()

	self._lockedRaceIdMap = {}

	for _, raceId in ipairs(banPetList) do
		self._lockedRaceIdMap[raceId] = true
	end

	self:clearAllPetList()
end

function YoungChampionKingKnockoutFmtMo:getFixedPosList()
	return {}
end

function YoungChampionKingKnockoutFmtMo:updateData()
	self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))

	self:initPetList()
end

function YoungChampionKingKnockoutFmtMo:initPetList()
	self:clearAllPetList()

	local limitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL"))
	local zhsRaceIds = {}
	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		if limitLv <= petMo.level and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi) then
			self:addPetToList(self:_changePetMo(petMo))
			table.insert(zhsRaceIds, petMo:getDefineId())
		end
	end

	for _, zhsRaceId in ipairs(zhsRaceIds) do
		local cfgList = ContractConfig.instance:getSummonBySummonMasterId(zhsRaceId)

		for i, cfg in ipairs(cfgList) do
			for k, petMo in pairs(bagPetMoList) do
				if petMo.raceId == cfg.summonRaceId and limitLv <= petMo.level then
					self:addPetToList(self:_changePetMo(petMo))
				end
			end
		end
	end
end

function YoungChampionKingKnockoutFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function YoungChampionKingKnockoutFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function YoungChampionKingKnockoutFmtMo:initFightHandler()
	self:setFightHandler(function()
		return
	end, nil)
end

function YoungChampionKingKnockoutFmtMo:getMonsterConfigList()
	return {}
end

function YoungChampionKingKnockoutFmtMo:getFmtInfoConfig()
	return ""
end

function YoungChampionKingKnockoutFmtMo:onClickCloseBtn(handler)
	TipsFacade.instance:openTipWindowNoX("提示", "进入淘汰赛比赛，不能退出", function()
		return
	end)
end

function YoungChampionKingKnockoutFmtMo:showForbitPetAlert(petMo)
	local boo, tips = self:checkPetIsForbit(petMo)

	FloatWordMgr.instance:show(tips)
end

function YoungChampionKingKnockoutFmtMo:checkPetIsForbit(checkPetMo)
	local isForbit = false
	local tips = ""

	if isForbit == false and self:_isPetNotCanUp(checkPetMo:getDefineId()) then
		isForbit = true
		tips = lang("该精灵已被禁用")
	end

	return isForbit, tips
end

function YoungChampionKingKnockoutFmtMo:getExtendViewName()
	return ViewName.YoungChampionKingFmtExView
end

function YoungChampionKingKnockoutFmtMo:setPetFilterList()
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_FMT_RIGHT)

	PetFilterMgr.instance:resetData(data)

	for k, v in pairs(GameEnum.CareerType) do
		data.jobClickAble[v] = false

		if v == GameEnum.CareerType.Zhaohuanshi then
			data.jobSelectList[GameEnum.CareerType.Zhaohuanshi] = true
		end
	end
end

function YoungChampionKingKnockoutFmtMo:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] == true
	else
		return false
	end
end

function YoungChampionKingKnockoutFmtMo:onExitView()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_FMT_RIGHT)
end

return YoungChampionKingKnockoutFmtMo
