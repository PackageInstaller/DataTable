-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionFmtView.lua

module(..., package.seeall)

local MissionFmtView = class("MissionFmtView", ViewComponent)

function MissionFmtView:bindEvents()
	self._pwBtn:AddClickListener(self._onClickPower, self)
	self._speedBtn:AddClickListener(self._onClickSpeed, self)

	if self._btnPsychicSkill then
		self._btnPsychicSkill:AddClickListener(self._onClickPsychicSkill, self)
	end

	if self._Btn_SpiritInvocationSkill then
		self._Btn_SpiritInvocationSkill:AddClickListener(self._onClickSpiritInvocationSkill, self)
	end

	if self._btnDomainSkill then
		self._btnDomainSkill:AddClickListener(self._onClickDomainSkill, self)
	end

	if self._Btn_HeroSkill then
		self._Btn_HeroSkill:AddClickListener(self._onClickHeroSkill, self)
	end

	if self._Btn_CutePet then
		self._Btn_CutePet:AddClickListener(self._onClickCutePet, self)
	end

	GameUtil.addClickHandler(self._heavenAwakenSummonSkillGo, self._onClickBtnHeavenAwakenSummon, self)
end

function MissionFmtView:unbindEvents()
	self._pwBtn:RemoveClickListener()
	self._speedBtn:RemoveClickListener()

	if self._Btn_HeroSkill then
		self._Btn_HeroSkill:RemoveClickListener()
	end

	if self._Btn_CutePet then
		self._Btn_CutePet:RemoveClickListener()
	end

	if self._btnDomainSkill then
		self._btnDomainSkill:RemoveClickListener()
	end

	if self._btnPsychicSkill then
		self._btnPsychicSkill:RemoveClickListener()
	end

	if self._Btn_SpiritInvocationSkill then
		self._Btn_SpiritInvocationSkill:RemoveClickListener()
	end

	GameUtil.rmClickHandler(self._heavenAwakenSummonSkillGo)
end

function MissionFmtView:_buildOneFrom()
	local cellRoot = self:getGo("FmtRight/Nego_Seats")
	local layerRoleGo = self:getGo("FmtRight/layerRole")
	local layerUIGo = self:getGo("FmtRight/layerUI")
	local layerBg = self:getGo("FmtRight/layerBg")

	for i = 1, 9 do
		local go = goutil.findChild(cellRoot, string.format("Item_Seat_%d", i))
		local layerRoleItem = goutil.findChild(layerRoleGo, string.format("item%d", i))
		local layerUIItem = goutil.findChild(layerUIGo, string.format("item%d", i))
		local layerBgItem = goutil.findChild(layerBg, string.format("item%d", i))

		self._fromCells[i] = go
		self._spineGos[i] = goutil.findChild(layerRoleItem, "Nego_Character")
		self._ImgC_Forbid[i] = goutil.findChild(layerBgItem, "ImgC_Forbid")
		self._layerUIGos[i] = layerUIItem
	end
end

function MissionFmtView:buildUI()
	self._fromCells = {}
	self._spineGos = {}
	self._ImgC_Forbid = {}
	self._layerUIGos = {}

	self:_buildOneFrom()

	self._speed = self:getGo("FmtRight/Nego_TeamInfo/Nego_TeamSpeed/TxtC_TeamSpeed"):GetComponent("Text")
	self._powerTxt = self:getGo("FmtRight/Nego_TeamInfo/Nego_TeamPower/TxtC_TeamPower"):GetComponent("Text")
	self._pwBtn = self:getBtn("FmtRight/Nego_TeamInfo/Nego_TeamPower")
	self._speedBtn = self:getBtn("FmtRight/Nego_TeamInfo/Nego_TeamSpeed/BtnSpeed")

	self:_buildTeamEffectsView()

	if not self._effViewContent then
		self._Btn_HeroSkill = self:getBtn("FmtRight/Btn_HeroSkill")
		self._heroIcon = self:getGo("FmtRight/Btn_HeroSkill/Icon")
		self._heroTxt = self:getGo("FmtRight/Btn_HeroSkill/TxtC_HeroSkill"):GetComponent("Text")
		self._heroSpr = self:getGo("FmtRight/Btn_HeroSkill"):GetComponent("UIImageSpriteChange")
		self._Btn_ContractPet = self:getGo("FmtRight/Btn_ContractPet")
		self._monIcon = self:getGo("FmtRight/Btn_ContractPet/IconBg/Icon")
		self._monTxt = self:getGo("FmtRight/Btn_ContractPet/TxtC_ContractPet"):GetComponent("Text")
		self._monSpr = self:getGo("FmtRight/Btn_ContractPet"):GetComponent("UIImageSpriteChange")
		self._Btn_CutePet = self:getBtn("FmtRight/Btn_CutePet")
		self._cutePetIcon = self:getGo("FmtRight/Btn_CutePet/Icon")
		self._cutePetSpr = self:getGo("FmtRight/Btn_CutePet"):GetComponent("UIImageSpriteChange")

		GameUtil.SetActive(self._Btn_CutePet, false)

		local btn_ContractPet = self:getGo("FmtRight/Btn_ContractPet")

		btn_ContractPet:SetActive(false)
	end
end

function MissionFmtView:_buildTeamEffectsView()
	local contentPath = "FmtRight/TeamEffectsView/Viewport/Content"
	local effViewContent = self:getGo(contentPath)

	if not effViewContent then
		return
	end

	self._effViewContent = effViewContent.transform
	self._Btn_CutePet = self:getBtn(contentPath .. "/TeamEffects/Btn_CutePet")
	self._cutePetIcon = self:getGo(contentPath .. "/TeamEffects/Btn_CutePet/Icon")
	self._cutePetSpr = self:getGo(contentPath .. "/TeamEffects/Btn_CutePet"):GetComponent(ComponentType.UIImageSpriteChange)
	self._Btn_HeroSkill = self:getBtn(contentPath .. "/TeamEffects/Btn_HeroSkill")
	self._heroIcon = self:getGo(contentPath .. "/TeamEffects/Btn_HeroSkill/Icon")
	self._heroTxt = self:getGo(contentPath .. "/TeamEffects/Btn_HeroSkill/TxtC_HeroSkill"):GetComponent("Text")
	self._heroSpr = self:getGo(contentPath .. "/TeamEffects/Btn_HeroSkill"):GetComponent(ComponentType.UIImageSpriteChange)
	self._Btn_ContractPet = self:getGo(contentPath .. "/TeamEffects/Btn_ContractPet")

	self._Btn_ContractPet:SetActive(false)

	self._monIcon = self:getGo(contentPath .. "/TeamEffects/Btn_ContractPet/IconBg/Icon")
	self._monTxt = self:getGo(contentPath .. "/TeamEffects/Btn_ContractPet/TxtC_ContractPet"):GetComponent("Text")
	self._monSpr = self:getGo(contentPath .. "/TeamEffects/Btn_ContractPet"):GetComponent(ComponentType.UIImageSpriteChange)

	local psychicSkill = self:getGo(contentPath .. "/TeamEffects/Btn_Psychic")
	local domainSkill = self:getGo(contentPath .. "/TeamEffects/Btn_DomainSkill")
	local elementSkill = self:getGo(contentPath .. "/TeamEffects/Btn_Element")
	local heavenAwakenSkill = self:getGo(contentPath .. "/TeamEffects/Btn_HeavenAwaken")
	local spiritInvocationSkill = self:getGo(contentPath .. "/TeamEffects/Btn_SpiritInvocationSkill")

	self:_initDomainSkills(domainSkill)
	self:_initPsychicSkill(psychicSkill)
	self:_initSpiritInvocationSkill(spiritInvocationSkill)
	self:_initElementSkill(elementSkill)
	self:_initHeavenAwakenSummonSkill(heavenAwakenSkill)
end

function MissionFmtView:_initHeavenAwakenSummonSkill(go)
	if go then
		self._heavenAwakenSummonSkillGo = go
		self._heavenAwakenSummonSkillIcon = goutil.findChild(go, "IconBg/Icon")
		self._heavenAwakenSummonSkillName = goutil.findChildTextComponent(go, "txt")
	end
end

function MissionFmtView:_initElementSkill(elementSkill)
	if elementSkill then
		self._elementSkillGo = elementSkill
		self._elementSkillIcon = goutil.findChild(self._elementSkillGo.gameObject, "IconBg/Icon")
		self._elementSkillName = goutil.findChildTextComponent(self._elementSkillGo.gameObject, "TxtC_Psychic")
	end
end

function MissionFmtView:_initDomainSkills(domainSkill)
	if domainSkill then
		self._domainSkillGo = domainSkill
		self._btnDomainSkill = Framework.ButtonAdapter.GetFrom(domainSkill, "DomainSkill")
		self._domainSkillIcon = goutil.findChild(self._btnDomainSkill.gameObject, "Icon")
		self._domainSkillName = goutil.findChildTextComponent(self._btnDomainSkill.gameObject, "imgBg/Text")
	end
end

function MissionFmtView:_initPsychicSkill(psychicSkill)
	if psychicSkill then
		self._psychicSkillGo = psychicSkill
		self._btnPsychicSkill = Framework.ButtonAdapter.Get(psychicSkill)
		self._psychicSkillIcon = goutil.findChild(psychicSkill, "IconBg/Icon")
		self._psychicSkillName = goutil.findChildTextComponent(psychicSkill, "TxtC_Psychic")
	end
end

function MissionFmtView:_initSpiritInvocationSkill(spiritInvocationSkill)
	if spiritInvocationSkill then
		self._spiritInvocationSkillGo = spiritInvocationSkill
		self._Btn_SpiritInvocationSkill = Framework.ButtonAdapter.Get(spiritInvocationSkill)
		self._spiritInvocationSkillIcon = goutil.findChild(spiritInvocationSkill, "Icon")
		self._spiritInvocationSkillName = goutil.findChildTextComponent(spiritInvocationSkill, "imgBg/Text")
		self._spiritInvocationSkillSpr = spiritInvocationSkill:GetComponent(ComponentType.UIImageSpriteChange)
	end
end

function MissionFmtView:destroyUI()
	self._fromCells = nil
	self._spineGos = nil
	self._ImgC_Forbid = nil
	self._layerUIGos = nil
end

function MissionFmtView:onEnter()
	self:onEnterInherit()
	self:_refreshFromation()
	self:_setHeroSkillEffect()
end

function MissionFmtView:onEnterInherit()
	GlobalDispatcher:addListener(GlobalNotify.UpdateStartOrder, self._updateStartOrder, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationBeginDragSeat, self._onFormationBeginDragSeat, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationEndDragSeat, self._onFormationEndDragSeat, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationDragBegin, self._onBagBeginDrag, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationDropBag, self._onBagEndDrag, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationEnterSeat, self._onFormationEnterSeat, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationExitSeat, self._onFormationExitSeat, self)

	self._existPetPoses = {}
	self._charas = {}
	self._loader = {}
	self._lastCallBack = {}
	self._infoSeats = {}
	self._heroSkillEff = {}

	self:_initRestrainItems()
	self:_initAtkEnemyItems()

	if self._effViewContent then
		Framework.TransformUtil.SetAnchoredPos(self._effViewContent, 0, 0)
	end
end

function MissionFmtView:onEnterFinished()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChangeFinish)
end

function MissionFmtView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.UpdateStartOrder, self._updateStartOrder, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationBeginDragSeat, self._onFormationBeginDragSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEndDragSeat, self._onFormationEndDragSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationDragBegin, self._onBagBeginDrag, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationDropBag, self._onBagEndDrag, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEnterSeat, self._onFormationEnterSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationExitSeat, self._onFormationExitSeat, self)
	self:_removeAllFixedEffs()

	if self._domainSkillIcon then
		MaterialMgr.clearIcon(self._domainSkillIcon)
	end

	if self._psychicSkillIcon then
		MaterialMgr.clearIcon(self._psychicSkillIcon)
	end

	if self._spiritInvocationSkillIcon then
		MaterialMgr.clearIcon(self._spiritInvocationSkillIcon)
	end

	if self._elementSkillIcon then
		MaterialMgr.clearIcon(self._elementSkillIcon)
	end

	MissionModel.instance:setPetPoses({})
	MissionModel.instance:setEnemyFormations(nil)

	self._existPetPoses = {}
	self._heroSkillId = 0
	self._infoSeats = nil

	for i = 1, 9 do
		local cell = self._fromCells[i]
		local btn = Framework.ButtonAdapter.Get(cell.gameObject)

		btn:RemoveClickListener()

		self._loader[cell], self._lastCallBack[cell], self._charas[cell] = RoleObjectPool.instance:resetLoader(self._loader[cell], self._lastCallBack[cell], self._charas[cell])
	end

	self._heroSkillEff = nil

	self:_removeRestrainItems()
	self:_destroyAtkEnemyItems()
end

function MissionFmtView:onExitFinished()
	return
end

function MissionFmtView:_getPosByRaceId(raceId)
	if not self._infoSeats then
		return nil
	end

	for i, v in ipairs(self._infoSeats) do
		if v.raceId == raceId then
			return i
		end
	end

	return nil
end

function MissionFmtView:_onFormationBeginDragSeat(bagPetMo, startPosIndex)
	local raceId = bagPetMo:getDefineId()
	local skinId = bagPetMo.curFaceId

	self:_setRestrainItems(true, raceId, skinId)
	self:_setAtkEnemyItemState(bagPetMo:getId(), startPosIndex)
end

function MissionFmtView:_onFormationEndDragSeat()
	self:_setRestrainItems(false)
	self:_closeAllAtkEnemyItem()
end

function MissionFmtView:_onBagBeginDrag(bagPetMo)
	local raceId = bagPetMo:getDefineId()
	local skinId = bagPetMo.curFaceId

	self:_setRestrainItems(true, raceId, skinId)
end

function MissionFmtView:_onBagEndDrag()
	self:_setRestrainItems(false)
	self:_closeAllAtkEnemyItem()
end

function MissionFmtView:_onFormationEnterSeat(petId, enterPosIndex)
	self:_setAtkEnemyItemState(petId, enterPosIndex)
end

function MissionFmtView:_onFormationExitSeat(petId, enterPosIndex)
	self:_closeAllAtkEnemyItem()
end

function MissionFmtView:initHeroAndContract()
	self._monIcon:SetActive(false)

	self._monTxt.text = lang("契约兽")

	self._monSpr:ChangeStateNow(1)
	self._heroIcon:SetActive(false)

	self._heroTxt.text = lang("英雄技")

	self._heroSpr:ChangeStateNow(1)
	self:_setSpiritInvocationSkillInfo(0)
end

function MissionFmtView:initCutePet()
	GameUtil.SetActive(self._cutePetIcon, false)
	self._cutePetSpr:ChangeStateNow(1)
end

function MissionFmtView:_refreshFromation()
	local phase = self._viewPresentor._openParam[1]
	local branch = self._viewPresentor._openParam[2]

	self:updateInfo(phase, branch)
end

function MissionFmtView:_getCreepCos()
	return {}
end

function MissionFmtView:_getMonsterCo()
	return {}
end

function MissionFmtView:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if creepCfg then
		for i, v in pairs(creepCfg) do
			if checknumber(v.posId) > 0 then
				local petMo = FightingPowerPetMo.New()

				petMo:fromChallengeCreepCo(v, creepCfg)

				petMo.creepName = v.creepName

				table.insert(teams, petMo)

				formations[v.posId] = petMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function MissionFmtView:getheroSkillId(monsterCo, teams)
	local heroSkillId = 0

	if monsterCo and monsterCo.heroSkillId then
		heroSkillId = checknumber(monsterCo.heroSkillId)
	end

	if heroSkillId <= 0 and teams then
		local heroSkillIs = FightingPowerFormula.instance:getHeroValidSkills(teams, self:getCurElementRelationMap(), self._summonMasterPetId, self._summonedPetId)

		if heroSkillIs and #heroSkillIs > 0 then
			heroSkillId = heroSkillIs[1]
		end
	end

	return heroSkillId
end

function MissionFmtView:_innerrefreshFromation()
	local cCfg = self:_getCreepCos()
	local monsterCo = self:_getMonsterCo()
	local teams, formations = self:getTeamAndFormation(cCfg)

	MissionModel.instance:setEnemyFormations(formations)
	self:_createExtParams(formations)
	self:initFormation(formations, teams, (self:getheroSkillId(monsterCo, teams)))
	self:_initFixedEffs()
end

function MissionFmtView:_createExtParams(formations)
	local _curMasterId = 0
	local _targetId = 0
	local curFaceId = 0
	local _heavenAwakenMasterId = 0
	local _heavenAwakenSummonPetId = 0
	local masterId = 0
	local summonId = 0
	local spiritInvocationPetId = 0
	local creepCfg = self:_getCreepCos()

	if creepCfg then
		for i, v in pairs(creepCfg) do
			local elementalMasterId = checknumber(v.elementalMasterId)
			local elementalTargetId = checknumber(v.elementalTargetId)

			if elementalMasterId > 0 then
				_curMasterId = elementalMasterId
			end

			if elementalTargetId > 0 then
				_targetId = elementalTargetId

				if checknumber((checknumber(v.faceId))) == 0 then
					curFaceId = checknumber(v.raceId)
				end
			end

			local heavenAwakenMasterId = checknumber(v.heavenAwakenMasterId)
			local heavenAwakenSummonPetId = checknumber(v.heavenAwakenSummonPetId)

			if heavenAwakenMasterId > 0 then
				_heavenAwakenMasterId = heavenAwakenMasterId
			end

			if heavenAwakenSummonPetId > 0 then
				_heavenAwakenSummonPetId = heavenAwakenSummonPetId
			end

			if checknumber(v.summonMasterId) > 0 then
				masterId = checknumber(v.summonMasterId)
			end

			if checknumber(v.summonedPetId) > 0 then
				summonId = checknumber(v.summonedPetId)
			end

			if checknumber(v.spiritInvocationPetId) > 0 then
				spiritInvocationPetId = checknumber(v.spiritInvocationPetId)
			end
		end
	end

	local extParams = {}

	extParams.elementalMasterId = _curMasterId
	extParams.elementalTargetId = _targetId
	extParams.heavenAwakenMasterId = _heavenAwakenMasterId
	extParams.heavenAwakenSummonPetId = _heavenAwakenSummonPetId
	extParams.summonMasterPetId = masterId
	extParams.summonedPetId = summonId
	extParams.spiritInvocationPetId = spiritInvocationPetId

	self:setExtParams(extParams)
end

function MissionFmtView:setExtParams(obj)
	self._extParams = obj
	self._summonMasterPetId = 0
	self._summonedPetId = 0
	self._spiritInvocationPetId = 0

	if self._extParams then
		self._summonMasterPetId = checknumber(self._extParams.summonMasterPetId)
		self._summonedPetId = checknumber(self._extParams.summonedPetId)
		self._spiritInvocationPetId = checknumber(self._extParams.spiritInvocationPetId)
	end
end

function MissionFmtView:initFormation(formations, teams, heroSkillId, fid, flvl)
	MissionModel.instance:setEnemyFormations(formations)

	local eleMap = self:getCurElementRelationMap()
	local cutePetRaceId, cutePetQuality = self:_getCutePetInfo()

	self:initHeroAndContract()
	self:initCutePet()
	GameUtil.SetActive(self._Btn_CutePet, true)

	if cutePetRaceId > 0 then
		GameUtil.SetActive(self._Btn_CutePet, true)

		if self._cutePetIcon and self._cutePetSpr then
			self._cutePetSpr:ChangeStateNow(cutePetRaceId > 0 and 0 or 1)
			MaterialMgr.setIcon(self._cutePetIcon, MatType.CutePet, cutePetRaceId)
			GameUtil.SetActive(self._cutePetIcon, true)
		end
	end

	if not self._effViewContent then
		GameUtil.SetActive(self._Btn_CutePet, false)
	end

	local masterId = 0
	local summonId = 0
	local order = 0
	local speed = 0

	for i = 1, 9 do
		local petMo = formations[i]
		local raceId = -1
		local name = ""
		local isSummon

		if petMo then
			raceId = petMo.raceId
			name = petMo.name
			isSummon = petMo:isSummonedPet()

			if checknumber(petMo.summonMasterId) > 0 then
				summonId = petMo.petId
				masterId = petMo.summonMasterId
			end
		end

		if raceId > 0 then
			order = order + 1

			if not isSummon then
				speed = speed + petMo._speed
			end
		end

		self:_setExistPetPoses(i, raceId)
		self:_setStartOrderObjActive(i, raceId > 0 and not isSummon)
		self:_setMonShow(isSummon, raceId, name)
	end

	if checknumber(self._summonMasterPetId) > 0 and checknumber(self._summonedPetId) > 0 then
		masterId = checknumber(self._summonMasterPetId)
		summonId = checknumber(self._summonedPetId)
	else
		self._summonMasterPetId = masterId
		self._summonedPetId = summonId
	end

	local speed = 0

	for i = 1, 9 do
		local petMo = formations[i]
		local raceId = -1
		local name = ""

		self:_setMonShow(false, raceId, name)

		if petMo then
			raceId = petMo.raceId
			name = petMo.name

			if petMo.petId ~= self._summonedPetId then
				speed = speed + petMo._speed
			end

			if petMo.petId == self._summonMasterPetId then
				self:_setMonShow(true, raceId, name)
			end

			order = order + 1
		end

		self:_updateOneCell(self._fromCells[i], raceId, petMo, order)
	end

	local zdlRadix = FightingPowerFormula.instance:getTeamFightingPower(teams, heroSkillId, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, masterId, summonId)

	self:_setFmtParams(heroSkillId, speed, zdlRadix)
end

function MissionFmtView:updateInfo(phase, branch)
	if ChallengeModel.instance:getBranchState(phase, branch) ~= GameEnum.ChallengeBranchState.UNLOCKED then
		return
	end

	self._curInfo = ChallengeModel.instance:getTeamInfo(phase, branch)

	self:_setFmtInfo(self._curInfo.teamId)
end

function MissionFmtView:_setFmtInfo(teamId)
	local cCfg = ChallengeConfig.instance:getCreepCfg(teamId)
	local monsterCo = ChallengeConfig.instance:getMissionCfg(teamId)
	local teams, formations = self:getTeamAndFormation(cCfg)

	self:_createExtParams(formations)

	local heroSkillId = self:getheroSkillId(monsterCo, teams)

	self:initFormation(formations, teams, heroSkillId)
end

function MissionFmtView:_setMonShow(isSummon, raceId, name)
	if isSummon then
		self._monIcon:SetActive(true)
		self._monSpr:ChangeStateNow(0)
		BagPetsFacade.setHeadIconByRaceId(self._monIcon, raceId)

		self._monTxt.text = name
	end
end

function MissionFmtView:_setRightSpeedAndPower(speed, zdlRadix)
	self._speed.text = speed
	self._power = zdlRadix
	self._powerTxt.text = zdlRadix

	MissionModel.instance:setRightPower(zdlRadix)
	MissionModel.instance:setRightSpeed(speed)
end

function MissionFmtView:_setFmtParams(heroSkillId, speed, zdlRadix)
	self:_setHeroSkill(heroSkillId)
	self:_updateDomainSkill()
	self:_updatePsychicedSkill()
	self:_updateSpiritInvocationSkill()
	self:_updateElementSkill()
	self:_updateHeavenAwakenSkill()
	self:_setRightSpeedAndPower(speed, zdlRadix)
	GlobalDispatcher:dispatch(GlobalNotify.FormationSpeedUpdate)

	local petPoses = {}

	for k, v in pairs(self._existPetPoses) do
		table.insert(petPoses, k)
	end

	MissionModel.instance:setPetPoses(petPoses)
	self:setSimpleForm()
end

function MissionFmtView:_setExistPetPoses(index, raceId)
	if raceId > 0 then
		self._existPetPoses = self._existPetPoses or {}
		self._existPetPoses[index] = true
	end
end

function MissionFmtView:_setStartOrderObjActive(index, isActive)
	return
end

function MissionFmtView:_updateStartOrder(params)
	return
end

function MissionFmtView:getExistPetPoses()
	return self._existPetPoses
end

function MissionFmtView:_setHeroSkill(heroSkillId)
	heroSkillId = checknumber(heroSkillId)
	self._heroSkillId = heroSkillId

	self._heroIcon:SetActive(heroSkillId > 0)
	self._heroSpr:ChangeStateNow(heroSkillId > 0 and 0 or 1)
	BagPetsFacade.setHeadIconByRaceId(self._heroIcon, math.fmod(heroSkillId, 100000))
end

function MissionFmtView:_updateDomainSkill()
	if not self._domainSkillGo then
		return
	end

	local raceId = 0

	if self._infoSeats then
		for i = 1, #self._infoSeats do
			if self._infoSeats[i] and checknumber(self._infoSeats[i].curFaceId) > 0 then
				local petCo = PetSkinConfig.instance:getPetSkinCfg(checknumber(self._infoSeats[i].curFaceId))

				if petCo.domainSkillId ~= 0 then
					raceId = checknumber(self._infoSeats[i].curFaceId)

					break
				end
			end
		end
	end

	self:_setDomainSkillInfo(raceId)
end

function MissionFmtView:_setDomainSkillInfo(raceId)
	if not self._domainSkillGo then
		return
	end

	if checknumber(raceId) == 0 then
		self._domainSkillGo:SetActive(false)
	else
		self._domainSkillGo:SetActive(true)

		self._domainSkillName.text = ConstString.SkillType[GameEnum.SkillRaceType.Domain]

		MaterialMgr.setIcon(self._domainSkillIcon, MatType.Pet, raceId)
	end
end

function MissionFmtView:getElementMasterAndTarget()
	local _curMasterId = 0
	local _targetId = 0

	if self._extParams then
		_curMasterId = checknumber(self._extParams.elementalMasterId)
		_targetId = checknumber(self._extParams.elementalTargetId)
	end

	return _curMasterId, _targetId
end

function MissionFmtView:getHeavenAwakenMasterAndTarget()
	local _curMasterId = 0
	local _targetId = 0

	if self._extParams then
		_curMasterId = self._extParams.heavenAwakenMasterId
		_targetId = self._extParams.heavenAwakenSummonPetId
	end

	return _curMasterId or 0, _targetId or 0
end

function MissionFmtView:getChangeRaceTypes()
	local changeRaceTypes

	return (self._extParams or nil) and self._extParams.changeRaceTypes
end

function MissionFmtView:getCurElementRelationMap()
	self._elementRelationMap = self._elementRelationMap or {}

	local changeRaceTypes = self:getChangeRaceTypes()

	if changeRaceTypes then
		for i, v in ipairs(changeRaceTypes) do
			if not string.nilorempty(v.raceType) then
				self._elementRelationMap[v.petId] = GameEnum.Races[v.raceType]
			end
		end
	end

	local _curMasterId, _targetId = self:getElementMasterAndTarget()
	local curFaceId = 0
	local enemyFormations = MissionModel.instance:getEnemyFormations()

	for k, v in pairs(enemyFormations or {}) do
		if v and v.petId == _curMasterId then
			curFaceId = v.curFaceId

			break
		end
	end

	if _curMasterId > 0 and _targetId > 0 and curFaceId > 0 and self._elementRelationMap[_targetId] == nil then
		self._elementRelationMap = {}

		local skinId = curFaceId

		self._elementRelationMap[_targetId] = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)
	end

	return self._elementRelationMap
end

function MissionFmtView:_getCutePetInfo()
	local cutePetRaceId, cutePetQuality = 0, 0
	local monsterCo = self:_getMonsterCo()

	if monsterCo then
		return checknumber(monsterCo.cutePetRaceId), checknumber(monsterCo.cutePetQuality)
	end

	return cutePetRaceId, cutePetQuality
end

function MissionFmtView:_updateElementSkill()
	local _curMasterId, _targetId = self:getElementMasterAndTarget()
	local curFaceId = 0
	local enemyFormations = MissionModel.instance:getEnemyFormations()

	for k, v in pairs(enemyFormations or {}) do
		if v and v.petId == _curMasterId then
			curFaceId = v.curFaceId

			break
		end
	end

	GameUtil.SetActive(self._elementSkillGo, _curMasterId > 0)
	GameUtil.SetActive(self._elementSkillIcon, false)

	if self._elementSkillName then
		self._elementSkillName.text = lang("元素师")
	end

	if _curMasterId > 0 and _targetId > 0 and curFaceId > 0 and self._elementSkillIcon then
		GameUtil.SetActive(self._elementSkillIcon, true)
		MaterialMgr.setIcon(self._elementSkillIcon, MatType.Pet, curFaceId)
	end
end

function MissionFmtView:_updatePsychicedSkill()
	if not self._psychicSkillGo then
		return
	end

	local skillId, curFaceId = self:_getPsychicedSkillId()

	self._psychicSkillGo:SetActive(false)

	if curFaceId == 0 then
		self._psychicSkillIcon:SetActive(false)
	else
		self._psychicSkillGo:SetActive(true)
		self._psychicSkillIcon:SetActive(true)

		self._psychicSkillName.text = ConstString.SkillType[GameEnum.SkillRaceType.PsychicSkill]

		MaterialMgr.setIcon(self._psychicSkillIcon, MatType.Pet, curFaceId)
	end
end

function MissionFmtView:_getPsychicedSkillId()
	if not self._infoSeats then
		return 0, 0
	end

	local monsterCo = self:_getMonsterCo()

	if monsterCo then
		local skillId = checknumber(monsterCo.psychicSkillId)

		if skillId > 0 then
			return skillId, self:_getPsychicedFaceId(skillId)
		end
	end

	return self:_getFormationPsychicedInfo()
end

function MissionFmtView:_getFormationPsychicedInfo()
	for i = 1, #self._infoSeats do
		if self._infoSeats[i] and checknumber(self._infoSeats[i].curFaceId) > 0 then
			local petCo = PetSkinConfig.instance:getPetSkinCfg(checknumber(self._infoSeats[i].curFaceId))

			if petCo.psychicSkillId ~= 0 then
				return petCo.psychicSkillId, checknumber(self._infoSeats[i].curFaceId)
			end
		end
	end

	return 0, 0
end

function MissionFmtView:_getPsychicedFaceId(skillId)
	skillId = checknumber(skillId)

	if skillId == 0 then
		return 0
	end

	for i = 1, #self._infoSeats do
		if self._infoSeats[i] and checknumber(self._infoSeats[i].curFaceId) > 0 then
			local petCo = PetSkinConfig.instance:getPetSkinCfg(checknumber(self._infoSeats[i].curFaceId))

			if petCo.psychicSkillId == skillId then
				return checknumber(self._infoSeats[i].curFaceId)
			end
		end
	end

	return 0
end

function MissionFmtView:_updateSpiritInvocationSkill()
	local petId, curFaceId = self:_getSpiritInvocationPetId()

	self:_setSpiritInvocationSkillInfo(petId, curFaceId)
end

function MissionFmtView:_setSpiritInvocationSkillInfo(petId, curFaceId)
	if not self._spiritInvocationSkillGo then
		return
	end

	petId = checknumber(petId)
	curFaceId = checknumber(curFaceId)

	GameUtil.SetActive(self._spiritInvocationSkillGo, false)
	GameUtil.SetActive(self._spiritInvocationSkillIcon, false)

	if self._spiritInvocationSkillSpr then
		self._spiritInvocationSkillSpr:ChangeStateNow(petId > 0 and 0 or 1)
	end

	self._spiritInvocationSkillName.text = ConstString.SkillType[GameEnum.SkillRaceType.SpiritInvocationSkill]

	if petId > 0 and curFaceId > 0 then
		GameUtil.SetActive(self._spiritInvocationSkillGo, true)
		GameUtil.SetActive(self._spiritInvocationSkillIcon, true)
		MaterialMgr.setIcon(self._spiritInvocationSkillIcon, MatType.Pet, curFaceId)
	end
end

function MissionFmtView:_getSpiritInvocationPetId()
	if not self._infoSeats then
		return 0, 0
	end

	local petId = checknumber(self._spiritInvocationPetId)

	if petId <= 0 then
		return 0, 0
	end

	local curFaceId = self:_getSpiritInvocationFaceId(petId)

	if curFaceId <= 0 then
		return 0, 0
	end

	return petId, curFaceId
end

function MissionFmtView:_getSpiritInvocationFaceId(petId)
	petId = checknumber(petId)

	if petId == 0 then
		return 0
	end

	for i = 1, #self._infoSeats do
		if self._infoSeats[i] and checknumber(self._infoSeats[i].petId) == petId then
			local curFaceId = checknumber(self._infoSeats[i].curFaceId)

			if curFaceId > 0 then
				local petCo = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

				if checknumber(petCo.spiritInvocationSkillId) ~= 0 then
					return curFaceId
				end
			end

			return 0
		end
	end

	return 0
end

function MissionFmtView:_updateHeavenAwakenSkill()
	if not self._heavenAwakenSummonSkillGo then
		return
	end

	goutil.setActive(self._heavenAwakenSummonSkillGo, false)
end

function MissionFmtView:_updateOneCell(cell, state, info, order)
	local index = string.sub(cell.name, -1)

	self._infoSeats[checknumber(index)] = info or {}

	local fmtRightGo = cell.transform.parent.parent
	local layerBgItem = goutil.findChild(fmtRightGo, string.format("layerBg/item%s", index))
	local layerRoleItem = goutil.findChild(fmtRightGo, string.format("layerRole/item%s", index))
	local layerUIItem = goutil.findChild(fmtRightGo, string.format("layerUI/item%s", index))
	local bg = goutil.findChild(layerBgItem, "ImgC_Forbid"):GetComponent("UIImageSpriteChange")
	local petBase = goutil.findChild(layerRoleItem, "Nego_Character")
	local attrIcon = goutil.findChild(layerUIItem, "ImgC_Info"):GetComponent("UIImageSpriteChange")
	local summonBtn = goutil.findChild(layerUIItem, "Btn_Summon")
	local txtLv = goutil.findChild(layerUIItem, "txtLv"):GetComponent(goutil.Type_UIText)
	local txtAtkTypeBg = goutil.findChild(layerUIItem, "bg")
	local txtAtkType = goutil.findChild(layerUIItem, "txtAtkType"):GetComponent(goutil.Type_UIText)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local ImgC_Title = goutil.findChildComponent(layerUIItem, "ImgC_Title", "UIImageSpriteChange")
	local txtTitle = goutil.findChildTextComponent(layerUIItem, "txtTitle")

	GameUtil.SetActive(ImgC_Title, false)
	GameUtil.SetActive(txtTitle, false)

	local isActive = state > 0

	petBase.gameObject:SetActive(isActive)
	attrIcon.gameObject:SetActive(isActive)
	summonBtn.gameObject:SetActive(isActive)
	txtLv.gameObject:SetActive(isActive)
	txtAtkTypeBg:SetActive(isActive)
	txtAtkType.gameObject:SetActive(isActive)
	bg:SetState(0)
	btn:RemoveClickListener()

	if state > 0 and info then
		local petCO = CharacterConfig.instance:getPetCo(info.raceId)

		if checknumber(info.curFaceId) <= 0 then
			if not Framework.OSDef.isEditor then
				info.curFaceId = checknumber(info.raceId)
			else
				error(">>>>>>>>>>>>>>>>>只在电脑上报错 麻烦传个 皮肤ID 进来")
			end
		end

		local raceMap = self:getCurElementRelationMap()
		local race = 0

		race = raceMap and raceMap[checknumber(info.petId)] ~= nil and raceMap[checknumber(info.petId)] or PetSkinConfig.instance:getFisrtEleAttrIdx(info.curFaceId)

		local rareNum = CharacterConfig.instance:getInitRare(info.raceId)

		bg:SetState(rareNum)

		race = race % 10

		local attrIndex = race - 1

		attrIcon:SetState(attrIndex)

		txtLv.text = info.level

		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(info.curFaceId)

		txtAtkType.text = ConstString.AtkTypeByIdx[firstJobIdx]

		btn:AddClickListener(function()
			self:_selectItem(checknumber(index), isUp)
		end)
		summonBtn:SetActive(info.petId == checknumber(self._summonedPetId))

		local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(info.curFaceId)

		if not modelCfg[1] then
			if not modelCfg[2] then
				if not (modelCfg[3] * 0.35) then
					local scale = 0.35

					self._loader[cell], self._lastCallBack[cell], self._charas[cell] = RoleObjectPool.instance:resetLoader(self._loader[cell], self._lastCallBack[cell], self._charas[cell])
					self._loader[cell], self._lastCallBack[cell] = RoleObjectPool.instance:getRoleAsset(info.curFaceId, function(go)
						if not goutil.isNil(go) then
							go:SetActive(true)
							goutil.addChildToParent(go, petBase)
							Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
							Framework.TransformUtil.SetLocalScale(go.transform, -1 * scale, scale, scale)

							self._charas[cell] = go
						end
					end, false)

					if ImgC_Title and txtTitle then
						local petTitleId = info.petTitleId
						local hasPetTitle = petTitleId and petTitleId > 0

						if hasPetTitle then
							local petTitleConf = PetTitleConfig.instance:getPetTitleConfig(petTitleId)

							txtTitle.text = petTitleConf.simpleName

							ImgC_Title:ChangeSprite(petTitleConf.icon2)
						end

						txtTitle.gameObject:SetActive(hasPetTitle)
						ImgC_Title.gameObject:SetActive(hasPetTitle)
					end
				end
			end
		end
	elseif state == 0 then
		-- block empty
	elseif state == -1 then
		-- block empty
	end
end

function MissionFmtView:_selectItem(index, isUp)
	if self._infoSeats[index] then
		CommonTipsMgr.instance:showPetTips(self._infoSeats[index])
	end
end

function MissionFmtView:_onClickPower()
	FloatWordMgr.instance:show(langPara("全员战斗力:%s", self._powerTxt.text))
end

function MissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show(langPara("全员速度:%s", self._speed.text))
end

function MissionFmtView:_onClickHeroSkill()
	if self._heroSkillId and self._heroSkillId > 0 then
		CommonTipsMgr.instance:openMaterialTips(self._Btn_HeroSkill, MatType.Skill, self._heroSkillId)
	end
end

function MissionFmtView:_onClickCutePet()
	return
end

function MissionFmtView:_onClickDomainSkill()
	local petDatas = {}

	for i = 1, #self._infoSeats do
		if self._infoSeats[i] and checknumber(self._infoSeats[i].curFaceId) > 0 then
			local petCo = PetSkinConfig.instance:getPetSkinCfg(checknumber(self._infoSeats[i].curFaceId))

			if petCo.domainSkillId ~= 0 then
				local curFaceId = checknumber(self._infoSeats[i].curFaceId)
				local petMo
				local bagPetMo = (checknumber(self._infoSeats[i].level) > 0 and FightingPowerPetMo.New(self._infoSeats[i].raceId, self._infoSeats[i].level) or checknumber(self._infoSeats[i].lv) > 0 and FightingPowerPetMo.New(self._infoSeats[i].raceId, self._infoSeats[i].lv) or FightingPowerPetMo.New(self._infoSeats[i].raceId, 100)):toBaseBagPetMo()

				bagPetMo.curFaceId = curFaceId
				bagPetMo.summonMasterId = checknumber(self._infoSeats[i].summonMasterId)
				bagPetMo.summonedPetId = checknumber(self._infoSeats[i].summonedPetId)

				table.insert(petDatas, bagPetMo)
			end
		end
	end

	ViewMgr.instance:open(ViewName.MissionDomainSkills, petDatas)
end

function MissionFmtView:_onClickPsychicSkill()
	local skillId = self:_getPsychicedSkillId()

	if checknumber(skillId) == 0 then
		FloatWordMgr.instance:show(lang("阵上没有通灵师"))

		return
	end

	local petDatas = {}

	for i = 1, #self._infoSeats do
		if self._infoSeats[i] and checknumber(self._infoSeats[i].curFaceId) > 0 then
			local petCo = PetSkinConfig.instance:getPetSkinCfg(checknumber(self._infoSeats[i].curFaceId))

			if petCo.psychicSkillId == skillId then
				local bagPetMo = self._infoSeats[i]:toBaseBagPetMo()

				table.insert(petDatas, bagPetMo)

				break
			end
		end
	end

	ViewMgr.instance:open(ViewName.MissionPsychicsedSkills, skillId, petDatas, true)
end

function MissionFmtView:_onClickSpiritInvocationSkill()
	local petId = self:_getSpiritInvocationPetId()

	if checknumber(petId) == 0 then
		FloatWordMgr.instance:show(lang("阵上没有唤灵师"))

		return
	end

	local petDatas = {}

	for i = 1, #self._infoSeats do
		if self._infoSeats[i] and checknumber(self._infoSeats[i].curFaceId) > 0 then
			local petCo = PetSkinConfig.instance:getPetSkinCfg(checknumber(self._infoSeats[i].curFaceId))

			if checknumber(petCo.spiritInvocationSkillId) ~= 0 then
				local bagPetMo = self._infoSeats[i]:toBaseBagPetMo()

				table.insert(petDatas, bagPetMo)
			end
		end
	end

	ViewMgr.instance:open(ViewName.MissionSpiritInvocationSkillView, petId, petDatas, true)
end

function MissionFmtView:_onClickBtnHeavenAwakenSummon()
	return
end

function MissionFmtView:_setHeroSkillEffect()
	local heroSkillId = self._heroSkillId
	local teams = MissionModel.instance:getEnemyFormations()
	local isRight = self:_isFightingPowerPetMo(teams)

	if isRight then
		teams = table.values(teams)

		local t = FightingPowerFormula.instance:getHeroSkillsWhichPetValid(heroSkillId, teams, self:getCurElementRelationMap(), self._summonMasterPetId, self._summonedPetId)
		local setedTeam = {}
		local setedPos = {}

		for i, v in ipairs(self._infoSeats) do
			self:_setHeroSkillEffectByPos(i)

			if t ~= nil then
				for team, buffs in pairs(t) do
					if not setedTeam[team] and not setedPos[i] and team.raceId == v.raceId then
						setedTeam[team] = true
						setedPos[i] = true

						self:_setHeroSkillEffectByPos(i, buffs)
					end
				end
			end
		end
	else
		for i = 1, 9 do
			self:_setHeroSkillEffectByPos(i, nil)
		end
	end
end

function MissionFmtView:_setHeroSkillEffectByPos(pos, buffs)
	local parentGo = self._ImgC_Forbid[pos]

	self._heroSkillEff[pos] = self._heroSkillEff[pos] or {}

	if buffs then
		local loadedPaths = {}

		for i, v in ipairs(buffs) do
			if not string.nilorempty(v.effectPath) and loadedPaths[v.effectPath] == nil then
				loadedPaths[v.effectPath] = true

				local effectPath = {
					GameUrl.getFuncIconUrl(v.effectPath)
				}
				local effect = UIEffectManager.instance:playEffect(self, effectPath, parentGo.transform, 0, 0, true, false)

				effect:setParent(parentGo.transform)

				local scale = self:_getEffectScaleFactor(pos)

				effect:setScale(scale)
				effect:setLocalPos(0, 3, 0)
				effect:setLocalEulerAngle(25, 0, 0)
				effect:setSortingOrder(180)

				effect.hideEffWhileNotOnTop = nil

				table.insert(self._heroSkillEff[pos], effect)
			end
		end
	else
		self:_removeHeroSkillEffect(pos)
	end
end

function MissionFmtView:_getEffectScaleFactor(posId)
	local num = posId % 3

	if num == 1 then
		return 10
	elseif num == 2 then
		return 11
	else
		return 12
	end
end

function MissionFmtView:_removeHeroSkillEffect(pos)
	if self._heroSkillEff and self._heroSkillEff[pos] then
		for i, v in ipairs(self._heroSkillEff[pos]) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._heroSkillEff[pos])
	end
end

function MissionFmtView:_removeAllHeroSkillEffect()
	for i = 1, 9 do
		self:_removeHeroSkillEffect(i)
	end
end

function MissionFmtView:_isFightingPowerPetMo(formations)
	if not TableUtil.isTableEmpty(formations) then
		local result = true

		for k, v in pairs(formations) do
			if v.__cname ~= "FightingPowerPetMo" and v.__cname ~= "BagPetMo" then
				result = false
			end
		end

		return result
	end

	return false
end

function MissionFmtView:setSimpleForm()
	return
end

function MissionFmtView:_initRestrainItems()
	self._restrainItemGos = {}
	self._kezhiGos = {}
	self._beikezhiGos = {}

	local prefabGo = self:getPrefab(MissionViewPresentor.RestrainItem)

	for index = 1, 9 do
		self:_setRestrainItemGo(index, prefabGo)
	end
end

function MissionFmtView:_removeRestrainItems()
	for index = 1, 9 do
		local go = self._restrainItemGos[index]

		self._restrainItemGos[index] = nil
		self._kezhiGos[index] = nil
		self._beikezhiGos[index] = nil

		goutil.destroy(go)
	end
end

function MissionFmtView:_setRestrainItems(isOpen, dragRaceId, skinId)
	if isOpen then
		local isOff = GameUtil.getUserData(ViewName.MissionSettingView .. GameEnum.MissionSetting.Restrain)

		if isOff then
			return
		end
	end

	for i = 1, #self._infoSeats do
		self:_setRestrainItemOpen(i, isOpen)

		if self._infoSeats[i] and checknumber(self._infoSeats[i].raceId) > 0 then
			self:_setRestrainItemState(i, dragRaceId, skinId, self._infoSeats[i].raceId, self._infoSeats[i].curFaceId)
		end
	end
end

function MissionFmtView:_setRestrainItemGo(index, prefabGo)
	local parentGo = self._layerUIGos[index]
	local go = goutil.cloneAndSetParent(prefabGo, parentGo.transform, prefabGo.name)

	self._restrainItemGos[index] = go
	self._kezhiGos[index] = goutil.findChild(go, "kezhi")
	self._beikezhiGos[index] = goutil.findChild(go, "beikezhi")

	goutil.setActive(go, false)
end

function MissionFmtView:_setRestrainItemOpen(index, isOpen)
	if self._restrainItemGos then
		goutil.setActive(self._restrainItemGos[index], isOpen)
		goutil.setActive(self._kezhiGos[index], false)
		goutil.setActive(self._beikezhiGos[index], false)
	end
end

function MissionFmtView:_setRestrainItemState(index, frontRaceId, frontSkinId, backRaceId, backSkinId)
	if checknumber(frontSkinId) == 0 then
		frontSkinId = frontRaceId
	end

	if checknumber(backSkinId) == 0 then
		backSkinId = backRaceId
	end

	if checknumber(frontRaceId) <= 0 or checknumber(frontSkinId) <= 0 then
		return
	end

	local frontType = PetSkinConfig.instance:getFisrtEleAttrIdx(frontSkinId)
	local backType = PetSkinConfig.instance:getFisrtEleAttrIdx(backSkinId)

	if frontType == GameEnum.RaceType.Guang and backType == GameEnum.RaceType.An or backType == GameEnum.RaceType.Guang and frontType == GameEnum.RaceType.An then
		goutil.setActive(self._kezhiGos[index], true)
		goutil.setActive(self._beikezhiGos[index], false)
	else
		local num = BattleConfig.instance:getPetRaceRestrainById(frontType, backType)

		if num > 1 then
			goutil.setActive(self._kezhiGos[index], true)
			goutil.setActive(self._beikezhiGos[index], false)
		elseif num < 1 then
			goutil.setActive(self._kezhiGos[index], false)
			goutil.setActive(self._beikezhiGos[index], true)
		else
			goutil.setActive(self._kezhiGos[index], false)
			goutil.setActive(self._beikezhiGos[index], false)
		end
	end
end

function MissionFmtView:_initAtkEnemyItems()
	local prefabGo = self:getPrefab(MissionViewPresentor.AtkEnemyItem)

	if not goutil.isNil(prefabGo) then
		self._atkEnemyItems = {}

		for index = 1, 9 do
			local atkEnemyItem = AtkEnemyItem.New()

			atkEnemyItem:init(self._layerUIGos[index], prefabGo)
			table.insert(self._atkEnemyItems, atkEnemyItem)
		end
	end
end

function MissionFmtView:_destroyAtkEnemyItems()
	if not self._atkEnemyItems then
		return
	end

	for i, v in ipairs(self._atkEnemyItems) do
		v:destroy()
	end

	self._atkEnemyItems = nil
end

function MissionFmtView:_setAtkEnemyItemIsOpen(index, isOpen)
	if not self._atkEnemyItems then
		return
	end

	self._atkEnemyItems[index]:setIsOpen(isOpen)
end

function MissionFmtView:_closeAllAtkEnemyItem()
	if not self._infoSeats or not self._atkEnemyItems then
		return
	end

	for i = 1, 9 do
		self:_setAtkEnemyItemIsOpen(i, false)
	end
end

function MissionFmtView:_setAtkEnemyItemState(petId, enterPosIndex)
	local isOff = GameUtil.getUserData(ViewName.MissionSettingView .. GameEnum.MissionSetting.AtkTarget)

	if isOff then
		return
	end

	if not self._infoSeats or not self._atkEnemyItems then
		return
	end

	local raceIds = {}

	for i = 1, 9 do
		if self._infoSeats[i] then
			raceIds[i] = checknumber(self._infoSeats[i].raceId)
		end
	end

	local param = AtkTargetStrategy.instance:createEnemyParam()

	param.dragPetId = petId
	param.enterPosIndex = enterPosIndex
	param.raceIds = raceIds

	local result = AtkTargetStrategy.instance:getResult(param)

	for i = 1, 9 do
		self:_setAtkEnemyItemIsOpen(i, result[i])
	end
end

function MissionFmtView:_initFixedEffs()
	return
end

function MissionFmtView:_setFixedEffs(effMap)
	self:_removeAllFixedEffs()

	if effMap then
		for pos = 1, 9 do
			local effPath = effMap[pos]

			if not string.nilorempty(effPath) then
				local ItemSeatCls = self:_getItemSeatCls()
				local itemSeat = ItemSeatCls.AddOnce(self._fromCells[pos])

				itemSeat:playFixedEffect(self, effPath)
			end
		end
	end
end

function MissionFmtView:_removeAllFixedEffs()
	local ItemSeatCls = self:_getItemSeatCls()

	for pos = 1, 9 do
		local itemSeat = ItemSeatCls.AddOnce(self._fromCells[pos])

		itemSeat:removeFixedEffect()
	end
end

function MissionFmtView:_getItemSeatCls()
	return ItemSeat
end

return MissionFmtView
