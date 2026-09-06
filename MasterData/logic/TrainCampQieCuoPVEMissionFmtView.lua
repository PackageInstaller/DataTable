-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TrainCampQieCuoPVEMissionFmtView.lua

module("logic.extensions.traincampqiecuo.view.TrainCampQieCuoPVEMissionFmtView", package.seeall)

local TrainCampQieCuoPVEMissionFmtView = class("TrainCampQieCuoPVEMissionFmtView", MissionFmtView)

function TrainCampQieCuoPVEMissionFmtView:buildUI()
	TrainCampQieCuoPVEMissionFmtView.super.buildUI(self)
	goutil.setActive(self._Btn_ContractPet, true)

	self._RightView = self._viewPresentor._views[2]

	local _FmtRight = self:getGo("FmtRight")
	local _Nego_Seats = goutil.findChild(_FmtRight, "Nego_Seats")

	self._seats = {}
	self._startOrderGos = {}
	self._startOrderTxts = {}

	for i = 1, 9 do
		local go = goutil.findChild(_Nego_Seats, string.format("Item_Seat_%d", i))

		if not self._noNeedDrag then
			DropHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_OnDropSeat(_go, eventData)
			end)
			BeginDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_OnBeginDragSeat(_go, eventData)
			end)
			EndDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_OnEndDragSeat(_go, eventData)
			end)
			DragHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_OnDragSeat(_go, eventData)
			end)
			PointerEnterHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_onEnterSeat(_go, eventData)
			end)
			PointerExitHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_onExitSeat(_go, eventData)
			end)
		end

		PointerClickHandler.Get(go):AddLuaHandler(function(_go, eventData)
			if eventData.dragging then
				return
			end

			self:_OnClickSeat(_go, eventData)
		end)

		self._seats[i] = go

		local startOrderGo = goutil.findChild(_FmtRight, string.format("startOrder/item%d", i))

		self._startOrderGos[i] = startOrderGo
		self._startOrderTxts[i] = goutil.findChild(startOrderGo, "bg/Text"):GetComponent(goutil.Type_UIText)

		GameUtil.SetActive(startOrderGo, false)

		local pathLayerUI = "layerUI/item" .. i

		GameUtil.SetActive(goutil.findChild(_FmtRight, pathLayerUI .. "/ImgC_Info"), false)
		GameUtil.SetActive(goutil.findChild(_FmtRight, pathLayerUI .. "/Btn_Summon"), false)
		GameUtil.SetActive(goutil.findChild(_FmtRight, pathLayerUI .. "/ImgC_Title"), false)
		GameUtil.SetActive(goutil.findChild(_FmtRight, pathLayerUI .. "/txtTitle"), false)
	end

	self._ImgC_Drop = self:getGo("pkNode/dropThrowAwayArea")
	self._selectEffectGo = self:getGo("Nego_Left/selectEffect")

	GameUtil.SetActive(self._selectEffectGo, false)
	goutil.setActive(self._ImgC_Drop, false)

	self._Nego_Character = self:getGo("Nego_Character")
	self._characterEffect = self:getGo("characterEffect")
end

function TrainCampQieCuoPVEMissionFmtView:bindEvents()
	TrainCampQieCuoPVEMissionFmtView.super.bindEvents(self)

	self._onDropBgHandler = DropHandler.Get(self._ImgC_Drop.gameObject):AddLuaHandler(function(go, eventData)
		self:_OnDropBg()
	end)

	GameUtil.addClickHandler(self._Btn_ContractPet, self._onClickBtnContractPet, self)
	GameUtil.addClickHandler(self._elementSkillGo, self._onClickBtnElement, self)
	GameUtil.addClickHandler(self._heavenAwakenSummonSkillGo, self._onClickHeavenAwakenSummonSkill, self)
end

function TrainCampQieCuoPVEMissionFmtView:unbindEvents()
	TrainCampQieCuoPVEMissionFmtView.super.unbindEvents(self)
	DropHandler.Get(self._ImgC_Drop.gameObject):RemoveLuaHandler(self._onDropBgHandler)
	GameUtil.rmClickHandler(self._Btn_ContractPet)
	GameUtil.rmClickHandler(self._elementSkillGo)
	GameUtil.rmClickHandler(self._heavenAwakenSummonSkillGo)
end

function TrainCampQieCuoPVEMissionFmtView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.UpdateStartOrder, self._updateStartOrder, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationBeginDragSeat, self._onFormationBeginDragSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEndDragSeat, self._onFormationEndDragSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationDragBegin, self._onBagBeginDrag, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationDropBag, self._onBagEndDrag, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEnterSeat, self._onFormationEnterSeat, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationExitSeat, self._onFormationExitSeat, self)

	if self._domainSkillIcon then
		MaterialMgr.clearIcon(self._domainSkillIcon)
	end

	if self._psychicSkillIcon then
		MaterialMgr.clearIcon(self._psychicSkillIcon)
	end

	if self._elementSkillIcon then
		MaterialMgr.clearIcon(self._elementSkillIcon)
	end

	MissionModel.instance:setPetPoses({})
	MissionModel.instance:setEnemyFormations(nil)

	self._existPetPoses = {}
	self._heroSkillId = 0
	self._infoSeats = nil
	self._heroSkillEff = nil

	self:_removeRestrainItems()
	self:_destroyAtkEnemyItems()
	removetimer(self._doPlayAudio, self)
end

function TrainCampQieCuoPVEMissionFmtView:onEnter()
	self._publicPets = {}
	self._powerPerNum = self:getFirstParam()

	TrainCampQieCuoPVEMissionFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormationPet_POS_FINISH, self._onSetFinish, self)
	self:_initRecPos()
	self:_initAtkSelfItems()
	self:_setHeroSkill()
	self.addGEvent(self, GlobalNotify.FormationBeginDragSeat, self._onFormationBeginDragSeat, self)
	self.addGEvent(self, GlobalNotify.FormationEndDragSeat, self._onFormationEndDragSeat, self)
	self.addGEvent(self, GlobalNotify.FormationEnterSeat, self._onFormationEnterSeat, self)
	self.addGEvent(self, GlobalNotify.FormationExitSeat, self._onFormationExitSeat, self)
	self.addGEvent(self, GlobalNotify.FormationPosChanged, self._OnSeatValueChanged, self)
	self.addGEvent(self, GlobalNotify.FormationSelectElementSkill, self._setElementSkill, self)
	self.addGEvent(self, GlobalNotify.FormationSelectPsychicedSkill, self._setPsychicedSkill, self)
	self.addGEvent(self, GlobalNotify.FormationHeroSkillChanged, self._OnHeroSkillChanged, self)
	self.addGEvent(self, GlobalNotify.QiecuoPVEModPower, self._modPower, self)
	goutil.setActive(self._Btn_CutePet.gameObject, false)
end

function TrainCampQieCuoPVEMissionFmtView:_refreshFromation()
	local heroSkillId = self:getheroSkillId()
	local teams, formations = self:getTeamAndFormation()

	self:_createExtParams(formations)
	self:initFormation(formations, teams, heroSkillId)
end

function TrainCampQieCuoPVEMissionFmtView:getheroSkillId()
	return TraincampqiecuoModel.instance:getOtherPVEFormation():GetHeroSkillId()
end

function TrainCampQieCuoPVEMissionFmtView:getCurElementRelationMap()
	return self:_getCurFormation():getCurElementRelationMap()
end

function TrainCampQieCuoPVEMissionFmtView:getTeamAndFormation()
	local teams = {}
	local formations = {}
	local formationPoses = self:_getCurFormation():GetPositions()

	for i = 1, 9 do
		local petId = formationPoses[i]

		if petId > 0 then
			local petInfo = TraincampqiecuoModel.instance:getPetMo(petId)

			if petInfo then
				local petMo = self:_getPet(petId)

				table.insert(teams, petMo)

				formations[i] = petMo
			end
		end
	end

	return teams, formations
end

function TrainCampQieCuoPVEMissionFmtView:_onClickPsychicSkill()
	local currSkillId = self:_getPsychicedSkillId()

	currSkillId = self:_checkPsychicedSkill(currSkillId)

	if currSkillId == 0 then
		FloatWordMgr.instance:show(lang("阵上没有通灵师"))

		return
	end

	local pets = self:_getPetsPsychics()

	ViewMgr.instance:open(ViewName.MissionPsychicsedSkills, currSkillId, pets)
end

function TrainCampQieCuoPVEMissionFmtView:_getCurFormation()
	return TraincampqiecuoModel.instance:getOtherPVEFormation()
end

function TrainCampQieCuoPVEMissionFmtView:_onSetFinish()
	local currOpTeamType = TraincampqiecuoModel.instance:getPVEOpTeamType()

	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		self:_refreshFromation()
	end
end

function TrainCampQieCuoPVEMissionFmtView:_setRightSpeedAndPower(speed, zdlRadix)
	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()
	local power = self._powerPerNum * curPetNumber

	self._power = 0
	self._speed.text = "???"
	self._powerTxt.text = "???"

	MissionModel.instance:setRightPower(power)
	MissionModel.instance:setRightSpeed(speed)
end

function TrainCampQieCuoPVEMissionFmtView:_onClickHeroSkill()
	local skills = self:_getPetsHeroSkills()
	local curBonds, petIdList = self:_getCurBonds(true)
	local petMoMap = self:_getBagPetMoList(petIdList)
	local team, formation, speed = self:getTeamAndFormation()

	if table.getn(skills) == 0 then
		ViewMgr.instance:open(ViewName.FmtFeatureView, skills, nil, curBonds, petMoMap, formation)

		return nil
	else
		ViewMgr.instance:open(ViewName.FmtFeatureView, skills, self:_getHeroSkillId(), curBonds, petMoMap, formation)

		return nil
	end
end

function TrainCampQieCuoPVEMissionFmtView:_getPetsHeroSkills()
	local pet_poisition = self:_getCurFormation():GetPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local formation = self:_getCurFormation()
	local summonId = formation:GetSummonPetId()
	local masterId = formation:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, formation:getCurElementRelationMap(), masterId, summonId))
end

function TrainCampQieCuoPVEMissionFmtView:_getCurBonds(isGetPetIdList)
	local racesInCurFormation = {}
	local positions = self:_getCurFormation():GetPositions()
	local petIdList = {}

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local mo = self:_getPet(petId)

			if mo then
				local raceId = mo.raceId

				table.insert(racesInCurFormation, raceId)
				table.insert(petIdList, petId)
			end
		end
	end

	if isGetPetIdList then
		return CharacterConfig.instance:getMatchBondCfgOnForm(racesInCurFormation, petIdList, self:getIsBoundUseBagPet()), petIdList
	end

	return CharacterConfig.instance:getMatchBondCfgOnForm(racesInCurFormation, petIdList, self:getIsBoundUseBagPet())
end

function TrainCampQieCuoPVEMissionFmtView:_getBagPetMoList(petIdList)
	local list = {}

	for i, v in ipairs(petIdList) do
		local petMo = self:_getPet(v)

		if petMo then
			local raceId = petMo:getDefineId()

			list[raceId] = petMo
		else
			printError(">>>>>>>>>>>>> error 是否没重写  _getPet 方法 找不到 petId:", v, " 注意重写 FormationLeftViewBase:getIsBoundUseBagPet() ")
		end
	end

	return list
end

function TrainCampQieCuoPVEMissionFmtView:_getHeroSkillId()
	return self:_getCurFormation():GetHeroSkillId()
end

function TrainCampQieCuoPVEMissionFmtView:_onClickBtnElement()
	local hasMaster = false
	local positions = self:_getCurFormation():GetPositions()

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Element) then
				hasMaster = true

				break
			end
		end
	end

	if hasMaster then
		UIStateManager.instance:push(ViewName.ElementpopView, self:_getCurFormation())
	else
		FloatWordMgr.instance:show(lang("阵上没有元素师"))
	end
end

function TrainCampQieCuoPVEMissionFmtView:_getPet(petId)
	if petId <= 0 then
		return
	end

	local petMo = self._publicPets[petId]

	if not petMo then
		petMo = TraincampqiecuoModel.instance:getPetMo(petId)

		local petCo = CharacterConfig.instance:getPetCo(petMo.raceId)

		petMo.creepName = petCo.name
		self._publicPets[petId] = petMo
	end

	return petMo
end

function TrainCampQieCuoPVEMissionFmtView:getIsBoundUseBagPet()
	return false
end

function TrainCampQieCuoPVEMissionFmtView:_OnDropSeat(go, eventData)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	local ItemSeatCls = self:_getItemSeatCls()
	local curItemSeat = ItemSeatCls.Get(go)

	if not curItemSeat then
		return
	end

	local targetPetId = curItemSeat:GetData()
	local targetPetMo = self:_getPet(targetPetId)
	local pos = curItemSeat:GetPosition()
	local itemPet = ItemPet.Get(eventData.pointerDrag)

	self:_setSelectEffectState(false)

	if not self._dragSeat and not self._RightView._dragging then
		return
	end

	local itemSeat = ItemSeatCls.Get(eventData.pointerDrag)

	if itemSeat and curItemSeat:IsOpen() ~= itemSeat:IsOpen() or not itemSeat and curItemSeat:GetData() == -1 then
		return
	end

	local isSummonedPetCanUp = false

	if itemPet then
		local data = itemPet:GetData()

		if data and data.summonMasterId > 0 then
			local canNotUp, hasOne = self:checkSummonLimit(self:_getCurFormation(), data)

			isSummonedPetCanUp = not canNotUp

			if targetPetMo and targetPetMo.summonedPetId == data.petId then
				isSummonedPetCanUp = false

				self:_showFailedSummonMasterTips()

				return
			end

			if hasOne then
				if targetPetMo then
					if targetPetMo.summonedPetId == self:_getCurFormation():GetSummonPetId() then
						-- block empty
					elseif targetPetMo.summonMasterId <= 0 then
						isSummonedPetCanUp = false

						self:_showFailedSummonPetTips()

						return
					end
				else
					isSummonedPetCanUp = false

					self:_showFailedSummonPetTips()

					return
				end
			end
		end
	end

	if not isSummonedPetCanUp and not itemSeat and self:_isExceedSpecifiedNumber() and (not itemPet or not itemPet:isInTeam()) then
		if curItemSeat:isHasPet() then
			if targetPetMo and targetPetMo.summonMasterId > 0 then
				self:_showFailedTips()

				return
			end
		else
			self:_showFailedTips()

			return
		end
	end

	local petId

	AudioPlayerEx.instance:playEffect(30008)

	if itemPet then
		local data = itemPet:GetData()

		if data.forbit then
			return
		end

		petId = data.petId

		local isExist, rightPos = self:_isExistPetId(data.petId)

		self._RightView:_OnDropSeat()
	elseif itemSeat then
		local itemPos = itemSeat:GetPosition()

		if self:_isFixedPos(itemPos) then
			return
		end

		petId = itemSeat:GetData()
		self._dragSeat = nil

		local endPetId = curItemSeat:GetData()
		local initPos = itemSeat:GetPosition()

		if endPetId and endPetId > 0 and not self:_isPosValidatorMatchOnSelect(initPos, endPetId) then
			itemSeat:ShowPet()
			itemSeat:recoverPetShow()
			itemSeat:recoverRaceType()
			curItemSeat:ShowPet()
			curItemSeat:recoverPetShow()
			curItemSeat:recoverRaceType()
			self:_playAudio(petId)

			return
		end
	end

	if not petId then
		return
	end

	local pos = curItemSeat:GetPosition()

	if not self:_isPosValidatorMatchOnSelect(pos, petId) then
		if itemSeat then
			itemSeat:ShowPet()
			itemSeat:recoverPetShow()
			itemSeat:recoverRaceType()
		end

		local endPetId = curItemSeat:GetData()

		if endPetId and endPetId > 0 then
			curItemSeat:ShowPet()
			curItemSeat:recoverPetShow()
			curItemSeat:recoverRaceType()
		end

		return
	end

	curItemSeat:playDropEffect(self)

	if not self:_isInTeam(petId) then
		self:_playAudio(petId)
	end

	self:_changePosition(pos, petId)
end

function TrainCampQieCuoPVEMissionFmtView:checkSummonLimit(fmtMo, petMo)
	local canNotUp = false
	local hasOne = false

	if petMo.summonMasterId > 0 then
		for _, petId in ipairs(fmtMo:GetPositions()) do
			if petId > 0 then
				local pet = self:_getPet(petId)

				if pet and pet.summonMasterId > 0 and pet.petId ~= petMo.petId then
					hasOne = true

					break
				end
			end
		end

		canNotUp = not fmtMo:HasPet(petMo.summonMasterId)
	end

	return canNotUp, hasOne
end

function TrainCampQieCuoPVEMissionFmtView:_OnBeginDragSeat(go, eventData)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat then
		return
	end

	self._dragingGo = go

	local pos = itemSeat:GetPosition()
	local petId = itemSeat:GetData()

	if petId <= 0 then
		return
	end

	local pet = self:_getPet(petId)

	if pet == nil then
		return
	end

	self._ImgC_Drop.gameObject:SetActive(true)
	self:_setSelectEffectState(true, itemSeat:getWorldPosition(), itemSeat:GetPosition())
	self:_setCharactorColor()

	self._isDraging = true
	self._Character = goutil.cloneAndSetParent(self._Nego_Character, self._Nego_Character.transform.parent)

	self._Character:SetActive(true)

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()
	self._loader, self._lastCallBack, self._asset = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._asset)
	self._loader, self._lastCallBack = RoleObjectPool.instance:getRoleAsset(pet.curFaceId, function(go)
		self._asset = go

		local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(pet.curFaceId)

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					go:SetActive(true)
					goutil.addChildToParent(go, goutil.findChild(self._Character, "petContainer"))
					Framework.TransformUtil.SetLocalPos(go.transform, modelCfg[1], y, 0)
					Framework.TransformUtil.SetLocalScale(go.transform, -scale, scale, scale)
				end
			end
		end
	end, false)

	if self._dragSeat then
		self._dragSeat:ShowPet()
	end

	itemSeat:HidePet()

	self._dragSeat = itemSeat

	self:_activeCharacterEffect(true)
	GlobalDispatcher:dispatch(GlobalNotify.FormationBeginDragSeat, pet, itemSeat:GetPosition())
end

function TrainCampQieCuoPVEMissionFmtView:_OnEndDragSeat(go, eventData)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	if self._isDraging or self._RightView._dragging then
		self._isDraging = false
		go = go or self._dragingGo

		self._ImgC_Drop.gameObject:SetActive(false)

		local ItemSeatCls = self:_getItemSeatCls()

		if go then
			local itemSeat = ItemSeatCls.Get(go)

			if not itemSeat then
				return
			end

			local pos = itemSeat:GetPosition()
		end

		self:_resetCharactorColor()
		self:_resetPetShow()
		self:_setSelectEffectState(false)
		self:_activeCharacterEffect(false)

		if not self._Character then
			return
		end

		self._loader, self._lastCallBack, self._asset = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._asset)

		goutil.destroy(self._Character, true)

		self._Character = nil
		self._dragingGo = nil

		if self._dragSeat then
			self._dragSeat:ShowPet()

			self._dragSeat = nil
		end

		GlobalDispatcher:dispatch(GlobalNotify.FormationDropFromSeat)
		GlobalDispatcher:dispatch(GlobalNotify.FormationEndDragSeat)
	end
end

function TrainCampQieCuoPVEMissionFmtView:_OnDragSeat(go, eventData)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	if not self._Character then
		return
	end

	local pos = uGuiUtil.GetTouchWorldPosition()

	self._Character.transform.position = pos

	self:_setCharacterEffectPos(pos)
end

function TrainCampQieCuoPVEMissionFmtView:_onEnterSeat(go, eventData)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	if self._isDraging then
		if not eventData.pointerDrag then
			return
		end

		local ItemSeatCls = self:_getItemSeatCls()
		local endSeat = ItemSeatCls.Get(go)

		if not endSeat then
			return
		end

		local endPos = endSeat:GetPosition()
		local itemStartSeat = ItemSeatCls.Get(eventData.pointerDrag)

		if not itemStartSeat then
			return
		end

		local itemStartPos = itemStartSeat:GetPosition()

		if itemStartSeat and itemStartSeat:isHasPet() then
			self:_setSelectEffectState(true, endSeat:getWorldPosition(), endSeat:GetPosition())
		else
			return
		end

		self:_previewOnEnterSeatByDragSeat(itemStartSeat, endSeat)
	elseif self._RightView._dragging then
		local dragingGo = self._RightView._dragingGo

		if not dragingGo then
			return
		end

		local itemPet = ItemPet.Get(dragingGo)

		if itemPet then
			local data = itemPet:GetData()

			if data.forbit then
				return
			end

			local isExist, rightPos = self:_isExistPetId(data.petId)

			if isExist and self:_isFixedPos(rightPos) then
				return
			end
		end

		local ItemSeatCls = self:_getItemSeatCls()
		local endSeat = ItemSeatCls.Get(go)

		if not endSeat then
			return
		end

		local pos = endSeat:GetPosition()

		self:_setSelectEffectState(true, endSeat:getWorldPosition(), endSeat:GetPosition())

		if itemPet then
			self:_previewOnEnterSeatByRightView(itemPet, endSeat)
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_onExitSeat(go, eventData)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	if self._isDraging then
		if not eventData.pointerDrag then
			return
		end

		local ItemSeatCls = self:_getItemSeatCls()
		local endSeat = ItemSeatCls.Get(go)

		if not endSeat then
			return
		end

		local endPos = endSeat:GetPosition()

		self:_setSelectEffectState(false)

		local itemStartSeat = ItemSeatCls.Get(eventData.pointerDrag)

		if not itemStartSeat then
			return
		end

		local itemStartPos = itemStartSeat:GetPosition()

		self:_previewOnExitSeatByDragSeat(itemStartSeat, endSeat)
	elseif self._RightView._dragging then
		local dragingGo = self._RightView._dragingGo

		if not dragingGo then
			return
		end

		local itemPet = ItemPet.Get(dragingGo)

		if itemPet then
			local data = itemPet:GetData()

			if data == nil or data.forbit then
				return
			end

			local isExist, rightPos = self:_isExistPetId(data.petId)
		end

		local ItemSeatCls = self:_getItemSeatCls()
		local endSeat = ItemSeatCls.Get(go)

		if not endSeat then
			return
		end

		local pos = endSeat:GetPosition()

		if itemPet then
			self:_previewOnExitSeatByRightView(itemPet, endSeat)
		end

		self:_setSelectEffectState(false)
	end
end

function TrainCampQieCuoPVEMissionFmtView:_onBagBeginDrag(bagPetMo)
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		local raceId = bagPetMo:getDefineId()

		self:_setRecPos(true, raceId)

		return
	end

	local raceId = bagPetMo:getDefineId()
	local skinId = bagPetMo.curFaceId

	self:_setRestrainItems(true, raceId, skinId)
end

function TrainCampQieCuoPVEMissionFmtView:_onBagEndDrag()
	if not TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		self:_setRecPos(false)
		self:_closeAllAtkSelfItem()

		return
	end

	self:_setRestrainItems(false)
	self:_closeAllAtkEnemyItem()
end

function TrainCampQieCuoPVEMissionFmtView:_getItemSeatCls()
	return TrainFmtItemSeat
end

function TrainCampQieCuoPVEMissionFmtView:_initRecPos()
	local prefabGo = self:getPrefab(MissionViewPresentor.RecPosItem)

	if prefabGo then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

			itemSeat:initRecPosItem(prefabGo)
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_initAtkSelfItems()
	local prefabGo = self:getPrefab(MissionViewPresentor.AtkSelfItem)

	if prefabGo then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

			itemSeat:initAtkSelfItem(prefabGo)
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_setRecPos(isOpen, raceId)
	if isOpen then
		local isOff = GameUtil.getUserData(ViewName.MissionSettingView .. GameEnum.MissionSetting.RecPos)

		if isOff then
			return
		end
	end

	for i = 1, #self._seats do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		itemSeat:setRecPosIsOpen(isOpen)

		if raceId then
			itemSeat:setRecPosState(raceId)
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_closeAllAtkSelfItem()
	if not self._seats then
		return
	end

	for i = 1, #self._seats do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		itemSeat:setAtkSelfItemIsOpen(false)
	end
end

function TrainCampQieCuoPVEMissionFmtView:initFormation(formations, teams, heroSkillId, fid, flvl)
	MissionModel.instance:setEnemyFormations(formations)
	self:initHeroAndContract()

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

			if checknumber(petMo.summonMasterId) then
				masterId = petMo.petId
			end

			if checknumber(petMo.summonedPetId) then
				summonId = petMo.petId
			end
		end

		if raceId > 0 then
			order = order + 1

			if not isSummon then
				speed = speed + petMo._speed
			end
		end

		self:_setExistPetPoses(i, raceId)

		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		itemSeat:SetSeatInfo(i, petMo, self:_getCurElementMap())
		itemSeat:SetSelect(false)
		itemSeat:SetRestrain("", false)
		self:_setStartOrderObjActive(i, raceId > 0 and not isSummon)
		self:_setMonShow(isSummon, raceId, name)
	end

	local zdlRadix = FightingPowerFormula.instance:getTeamFightingPower(teams, heroSkillId, fid, flvl, self:getCurElementRelationMap(), 0, 0, masterId, summonId)

	self:_setFmtParams(heroSkillId, speed, zdlRadix)
	self:_setSummonContractSkillEffect()
end

function TrainCampQieCuoPVEMissionFmtView:_getCurElementMap()
	return self:_getCurFormation():getCurElementRelationMap()
end

function TrainCampQieCuoPVEMissionFmtView:_OnDropBg(go, eventData)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	if self._dragSeat then
		local petId = self._dragSeat:GetData()

		if self._dragSeat:IsOpen() and petId > 0 then
			local pos = self._dragSeat:GetPosition()

			self:_changePosition(pos, 0)

			self._dragSeat = nil
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_changePosition(pos, value)
	if value > 0 then
		local petMo = self:_getPet(value)
		local summonMasterId = self:_getSummonMasterId()

		if petMo.summonMasterId > 0 and petMo.summonMasterId ~= summonMasterId then
			TraincampqiecuoController.instance:onTrySetSummonPetBySendMsg(self:_getCurFormation(), petMo.summonMasterId, -1)
		end
	end

	self:_getCurFormation():SetPosition(pos, value)
end

function TrainCampQieCuoPVEMissionFmtView:_setSelectEffectState(isEnter, worldPosition, posIndex)
	if not self._selectEffectGo then
		return
	end

	self._selectEffectGo:SetActive(isEnter)

	if isEnter then
		if worldPosition then
			self._selectEffectGo.transform.position = worldPosition
		end

		if posIndex then
			local scale = FormationLeftViewBase:_getPerspectiveScale(posIndex)

			Framework.TransformUtil.SetLocalScale(self._selectEffectGo.transform, scale, scale, scale)
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_setCharactorColor()
	if self._seats then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.Get(self._seats[i])

			if itemSeat then
				itemSeat:setCharactorColor()
			end
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_activeCharacterEffect(isActive)
	self._characterEffect:SetActive(isActive)
end

function TrainCampQieCuoPVEMissionFmtView:_onFormationBeginDragSeat(bagPetMo, startPosIndex)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	local raceId = bagPetMo:getDefineId()

	self:_setRecPos(true, raceId)
	self:_setAtkSelfItemState(bagPetMo:getId(), startPosIndex)
end

function TrainCampQieCuoPVEMissionFmtView:_onFormationEndDragSeat()
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	self:_setRecPos(false)
	self:_closeAllAtkSelfItem()
end

function TrainCampQieCuoPVEMissionFmtView:_onFormationEnterSeat(petId, enterPosIndex)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	self:_setAtkSelfItemState(petId, enterPosIndex)
end

function TrainCampQieCuoPVEMissionFmtView:_onFormationExitSeat(petId, enterPosIndex)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	self:_closeAllAtkSelfItem()
end

function TrainCampQieCuoPVEMissionFmtView:_setAtkSelfItemState(petId, enterPosIndex)
	local isOff = GameUtil.getUserData(ViewName.MissionSettingView .. GameEnum.MissionSetting.AtkTarget)

	if isOff then
		return
	end

	if not self._seats then
		return
	end

	local itemSeats = {}
	local tempPetIds = {}

	for i = 1, 9 do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.Get(self._seats[i])

		itemSeats[i] = itemSeat
		tempPetIds[i] = itemSeat:getTempPetId()
	end

	local param = AtkTargetStrategy.instance:createSelfParam()

	param.dragPetId = petId
	param.enterPosIndex = enterPosIndex
	param.tempPetIds = tempPetIds

	local result = AtkTargetStrategy.instance:getResult(param)

	for i = 1, 9 do
		self:_setAtkSelfItemIsOpen(i, result[i])
	end
end

function TrainCampQieCuoPVEMissionFmtView:_setAtkSelfItemIsOpen(index, isOpen)
	if self._seats[index] then
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[index])

		itemSeat:setAtkSelfItemIsOpen(isOpen)
	end
end

function TrainCampQieCuoPVEMissionFmtView:_resetCharactorColor()
	if self._seats then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.Get(self._seats[i])

			if itemSeat then
				itemSeat:resetCharactorColor()
			end
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_resetPetShow()
	if self._seats then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.Get(self._seats[i])

			if itemSeat then
				itemSeat:resetPetShow()
			end
		end
	end

	self:_setSelectEffectState(false)
end

function TrainCampQieCuoPVEMissionFmtView:_showFailedSummonPetTips()
	FloatWordMgr.instance:show(lang("只能同时上阵一只契约精灵哦！"))
end

function TrainCampQieCuoPVEMissionFmtView:_isExceedSpecifiedNumber()
	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()
	local specificNumber = 9

	return specificNumber <= curPetNumber
end

function TrainCampQieCuoPVEMissionFmtView:_showFailedTips()
	local content = langPara("不包含契约精灵，最多上阵%d只精灵哦！", MissionModel.instance:getMaxPetNum())

	FloatWordMgr.instance:show(content)
end

function TrainCampQieCuoPVEMissionFmtView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	return true
end

function TrainCampQieCuoPVEMissionFmtView:_isExistPetId(petId)
	if petId <= 0 then
		return false, 0
	end

	local positions = self:_getCurFormation():GetPositions()

	for pos, id in ipairs(positions) do
		if petId == id then
			return true, pos
		end
	end

	return false, 0
end

function TrainCampQieCuoPVEMissionFmtView:_playAudio(petId)
	if self._playingCVPetId and AudioVoicePlayer.instance:isPlayingCv() and self:_isInTeam(self._playingCVPetId) then
		self._readyToPlayingCvPetId = petId

		return
	end

	self:_doPlayAudio(petId)
end

function TrainCampQieCuoPVEMissionFmtView:_doPlayAudio(petId)
	removetimer(self._doPlayAudio, self)

	petId = petId or self._readyToPlayingCvPetId
	self._readyToPlayingCvPetId = nil
	self._playingCVPetId = nil

	local bagPetMo = self:_getPet(petId)

	if bagPetMo then
		self._playingCVPetId = petId

		PetCvController.instance:playPetCv(bagPetMo.curFaceId, GameEnum.PetCvType.Formation)
	end
end

function TrainCampQieCuoPVEMissionFmtView:_isInTeam(petId)
	local formation = self:_getCurFormation()

	if formation then
		local pet_poisition = formation:GetPositions()

		for i, v in ipairs(pet_poisition) do
			if v > 0 and v == petId then
				return true
			end
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_previewOnEnterSeatByDragSeat(itemStartSeat, endSeat)
	if endSeat:isHasPet() then
		local startPetId = itemStartSeat:GetData()
		local endPetId = endSeat:GetData()

		if startPetId ~= endPetId then
			itemStartSeat:ShowPet()
			itemStartSeat:previewPetShow(endSeat:getPetMo())
			itemStartSeat:setTempPetId(endPetId)
			endSeat:setRaceType(itemStartSeat:getPetMo(), self:_getCurElementMap())
			endSeat:HidePet()
		end
	else
		itemStartSeat:setTempPetId(0)
	end

	local tempPetId = itemStartSeat:GetData()

	endSeat:setTempPetId(tempPetId)
	GlobalDispatcher:dispatch(GlobalNotify.FormationEnterSeat, tempPetId, endSeat:GetPosition())
end

function TrainCampQieCuoPVEMissionFmtView:_isFixedPos(pos)
	return false
end

function TrainCampQieCuoPVEMissionFmtView:_previewOnEnterSeatByRightView(itemPet, endSeat)
	local data = itemPet:GetData()
	local petId = data.petId
	local itemStartSeat = self:_getItemSeatByPetId(petId)

	if itemStartSeat then
		self:_previewOnEnterSeatByDragSeat(itemStartSeat, endSeat)
	end
end

function TrainCampQieCuoPVEMissionFmtView:_getItemSeatByPetId(petId)
	if not self._seats then
		return nil
	end

	for i = 1, #self._seats do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.Get(self._seats[i])

		if itemSeat:GetData() == petId then
			return itemSeat
		end
	end

	return nil
end

function TrainCampQieCuoPVEMissionFmtView:_previewOnExitSeatByDragSeat(itemStartSeat, endSeat)
	endSeat:recoverPetShow()
	endSeat:setCharactorColor()
	endSeat:resetTempPetId()
	itemStartSeat:recoverRaceType()
	itemStartSeat:resetTempPetId()
	itemStartSeat:HidePet()
	GlobalDispatcher:dispatch(GlobalNotify.FormationExitSeat, itemStartSeat:GetData(), endSeat:GetPosition())
end

function TrainCampQieCuoPVEMissionFmtView:_previewOnExitSeatByRightView(itemPet, endSeat)
	local data = itemPet:GetData()
	local petId = data.petId
	local itemStartSeat = self:_getItemSeatByPetId(petId)

	if itemStartSeat then
		self:_previewOnExitSeatByDragSeat(itemStartSeat, endSeat)
	end
end

function TrainCampQieCuoPVEMissionFmtView:_OnSeatValueChanged(pos, petId)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	self:_refreshFromation()
	self:_setHeroSkill()
end

function TrainCampQieCuoPVEMissionFmtView:_setCharacterEffectPos(pos)
	Framework.TransformUtil.SetPos(self._characterEffect.transform, pos.x, pos.y, pos.z)
end

function TrainCampQieCuoPVEMissionFmtView:_setHeroSkill(id)
	local toId = id

	if toId == nil then
		toId = self:_getHeroSkillId()
	end

	local skills = self:_getPetsHeroSkills()

	if TableUtil.isHad(skills, toId) then
		-- block empty
	else
		toId = table.getn(skills) > 0 and skills[1] or 0
	end

	toId = checknumber(toId)

	if self.lastHeroSkollId ~= toId then
		self.lastHeroSkollId = toId

		self:_changeHeroSkillId(toId)
		self:_playEffectOnChangeHeroSkillId(-1, self.lastHeroSkollId)
	end

	BagPetsFacade.setHeadIconByRaceId(self._heroIcon, math.fmod(toId, 100000))
	self:_setHeroSkillEffect(self.lastHeroSkollId)

	self._heroSkillId = toId

	self._heroIcon:SetActive(toId > 0)
	self._heroSpr:ChangeStateNow(toId > 0 and 0 or 1)
	goutil.setActive(self._Btn_HeroSkill.gameObject, toId > 0)
end

function TrainCampQieCuoPVEMissionFmtView:_getHeroSkillId()
	return self:_getCurFormation():GetHeroSkillId()
end

function TrainCampQieCuoPVEMissionFmtView:_getPetsHeroSkills()
	local pet_poisition = self:_getCurPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local formation = self:_getCurFormation()
	local summonId = formation:GetSummonPetId()
	local masterId = formation:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, formation:getCurElementRelationMap(), masterId, summonId))
end

function TrainCampQieCuoPVEMissionFmtView:_getCurPositions()
	return self:_getCurFormation():GetPositions()
end

function TrainCampQieCuoPVEMissionFmtView:_changeHeroSkillId(skillId)
	self:_getCurFormation():SetHeroSkillId(skillId)
	self:onFmoSetDown()
end

function TrainCampQieCuoPVEMissionFmtView:_playEffectOnChangeHeroSkillId(oldHeroSkillId, newHeroSkillId)
	if self._isSkipFirstHeroSkill then
		self._isSkipFirstHeroSkill = nil

		return
	end

	if not newHeroSkillId then
		return
	end

	if newHeroSkillId == oldHeroSkillId then
		return
	end

	local buffList = self:_getHeroSkillBuffList(newHeroSkillId)

	for pos, buffElement in ipairs(buffList) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])
		local isHaveBuff = buffElement.buffs

		itemSeat:playChangeHeroSkillEffect(self:_heroSkillIdToRaceId(newHeroSkillId), self, isHaveBuff, self:_getCurFormation():getCurElementRelationMap())
	end
end

function TrainCampQieCuoPVEMissionFmtView:_heroSkillIdToRaceId(heroSkillId)
	if type(heroSkillId) == "number" then
		return heroSkillId % 100000
	else
		printError("heroSkillId is not number type")

		return 0
	end
end

function TrainCampQieCuoPVEMissionFmtView:_getHeroSkillBuffList(heroSkillId)
	local teams = self:_getFightingPowerFormulaTeams()
	local formation = self:_getCurFormation()
	local summonId = formation:GetSummonPetId()
	local masterId = formation:GetSummonMasterPetId()
	local t = FightingPowerFormula.instance:getHeroSkillsWhichPetValid(heroSkillId, teams, formation:getCurElementRelationMap(), masterId, summonId)
	local positions = self:_getCurFormation():GetPositions()
	local result = {}

	for pos, petId in ipairs(positions) do
		local element = {}

		element.pos = pos
		result[pos] = element

		if t ~= nil then
			for team, buffs in pairs(t) do
				if team.petId == petId then
					element.buffs = buffs

					break
				end
			end
		end
	end

	return result
end

function TrainCampQieCuoPVEMissionFmtView:_getFightingPowerFormulaTeams()
	local formation = self:_getCurFormation()
	local team = {}

	for _, v in ipairs(formation:GetPositions()) do
		if v > 0 then
			local pet = self:_getPet(v)

			if pet then
				local fightingPowerMo = pet:toFightingPowerPetMo()

				fightingPowerMo.petId = v

				table.insert(team, fightingPowerMo)
			end
		end
	end

	return team
end

function TrainCampQieCuoPVEMissionFmtView:_setHeroSkillEffect(heroSkillId)
	heroSkillId = heroSkillId or 0

	local buffList = self:_getHeroSkillBuffList(heroSkillId)

	for pos, buffElement in ipairs(buffList) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])

		itemSeat:removeHeroSkillEff()
		itemSeat:setHeroSkillEffect(self, buffElement.buffs, pos)
	end
end

function TrainCampQieCuoPVEMissionFmtView:onFmoSetDown()
	return
end

function TrainCampQieCuoPVEMissionFmtView:_OnClickSeat(go, eventData)
	if self._dragSeat then
		self._dragSeat:ShowPet()
	end

	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat or not itemSeat:IsOpen() then
		return
	end

	if not itemSeat:isHasPet() then
		printInfo("当前位置没有精灵")

		return
	end

	local petId = itemSeat:GetData()
	local petMo = self:_getPet(petId)

	if petMo then
		self:_onClickShowPetTips(petMo)
	end
end

function TrainCampQieCuoPVEMissionFmtView:_onClickShowPetTips(petMo)
	petMo._zdl = self._powerPerNum

	CommonTipsMgr.instance:showPetTips(petMo)
end

function TrainCampQieCuoPVEMissionFmtView:_updatePsychicedSkill()
	self:_setPsychicedSkill()
end

function TrainCampQieCuoPVEMissionFmtView:_getPsychicedSkillId()
	return self:_getCurFormation():GetPsychicedSkillId()
end

function TrainCampQieCuoPVEMissionFmtView:_setPsychicedSkill(id)
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		self._psychicSkillGo:SetActive(false)

		return
	end

	local toId = self:_checkPsychicedSkill(id)

	self:_changePsychicedSkillId(toId)

	if not self._psychicSkillGo then
		return
	end

	local psychics

	if toId > 0 then
		psychics = self:_getPsychicsPetBySkillId(toId)
	end

	self._psychicSkillGo:SetActive(toId > 0)

	if not psychics then
		self._psychicSkillIcon:SetActive(false)
	else
		self._psychicSkillIcon:SetActive(true)

		self._psychicSkillName.text = ConstString.SkillType[GameEnum.SkillRaceType.PsychicSkill]

		MaterialMgr.setIcon(self._psychicSkillIcon, MatType.Pet, psychics.curFaceId)
	end
end

function TrainCampQieCuoPVEMissionFmtView:_checkPsychicedSkill(id)
	local toId = id

	if toId == nil then
		toId = self:_getPsychicedSkillId()
	end

	toId = checknumber(toId)

	local pets = self:_getPetsPsychics()
	local isValid = false

	if toId > 0 then
		for i = 1, #pets do
			local petCo = PetSkinConfig.instance:getPetSkinCfg(pets[i].curFaceId)

			if petCo.psychicSkillId == toId then
				isValid = true

				break
			end
		end
	end

	if not isValid then
		if #pets > 0 then
			local petCo = PetSkinConfig.instance:getPetSkinCfg(pets[1].curFaceId)

			toId = petCo.psychicSkillId
		else
			toId = 0
		end
	end

	toId = checknumber(toId)

	return toId
end

function TrainCampQieCuoPVEMissionFmtView:_getPetsPsychics()
	local psychicSkillFaceIds = {}
	local pet_poisition = self:_getCurPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				local petCo = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

				if petCo.psychicSkillId ~= 0 then
					table.insert(psychicSkillFaceIds, pet)
				end
			end
		end
	end

	return psychicSkillFaceIds
end

function TrainCampQieCuoPVEMissionFmtView:_changePsychicedSkillId(skillId)
	self:_getCurFormation():SetPsychicedSkillId(skillId)
	self:onFmoSetDown()
end

function TrainCampQieCuoPVEMissionFmtView:_getPsychicsPetBySkillId(skillId)
	if checknumber(skillId) == 0 then
		return
	end

	local pet_poisition = self:_getCurPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				local petCo = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

				if petCo.psychicSkillId == skillId then
					return pet
				end
			end
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_updateElementSkill()
	self:_setElementSkill()
end

function TrainCampQieCuoPVEMissionFmtView:_setElementSkill()
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		GameUtil.SetActive(self._elementSkillGo, false)

		return
	end

	local _curMasterId = self:_getCurFormation():GetElementalMasterId()
	local _targetId = self:_getCurFormation():GetElementalTargetId()

	GameUtil.SetActive(self._elementSkillGo, _curMasterId > 0)
	GameUtil.SetActive(self._elementSkillIcon, false)

	if self._elementSkillName then
		self._elementSkillName.text = lang("元素师")
	end

	if _curMasterId > 0 and self._elementSkillIcon then
		local petMo = self:_getPet(_curMasterId)

		if petMo then
			GameUtil.SetActive(self._elementSkillIcon, true)
			MaterialMgr.setIcon(self._elementSkillIcon, MatType.Pet, petMo.curFaceId)
		end

		local gray = "909090"
		local colorStr = _targetId <= 0 and gray or ColorConst.White

		Framework.ColorUtil.SetImageColor(self._elementSkillIconImage, colorStr)
	end

	local poisitions = self:_getCurPositions()
	local effect_path = "20220930/yuansushixitong/fx_ui_yssxt_qiehuan.prefab"

	effect_path = UIEffectManager.instance:getEffectPath(effect_path)

	for i, v in ipairs(poisitions) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		if v > 0 and v == _targetId then
			local petMo = self:_getPet(_targetId)

			itemSeat:playElementSkillEffect(self, effect_path, 1)
		else
			itemSeat:removeElementSkillEffect()
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_OnHeroSkillChanged(id)
	self:_RefreshViewOnHeroSkillChanged(id)
end

function TrainCampQieCuoPVEMissionFmtView:_RefreshViewOnHeroSkillChanged(id)
	self:_setHeroSkill(id)
	GlobalDispatcher:dispatch(GlobalNotify.FormationChangeFinish)
	self:_refreshFromation()
end

function TrainCampQieCuoPVEMissionFmtView:_modPower(power)
	self._powerPerNum = power

	self:_refreshFromation()
end

function TrainCampQieCuoPVEMissionFmtView:_onClickBtnContractPet()
	if self:checkHasSummonMasterPets() then
		self:_getCurFormation():trySaveMySelf()
		UIStateManager.instance:push(ViewName.TraincampqiecuoContractSelectPopView, self)
	end
end

function TrainCampQieCuoPVEMissionFmtView:checkHasSummonMasterPets()
	local positions = self:_getCurPositions()
	local limitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL"))
	local hasMaster = false

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if petMo and limitLv <= petMo.level and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi) then
				hasMaster = true
			end
		end
	end

	if hasMaster == false then
		FloatWordMgr.instance:show(lang("阵上没有符合条件的召唤师"))
	end

	return hasMaster
end

function TrainCampQieCuoPVEMissionFmtView:_setMonShow(isSummon, raceId, name)
	local summonMasterId = self:_getSummonMasterId()

	goutil.setActive(self._Btn_ContractPet.gameObject, self:_checkHasJob(GameEnum.CareerType.Zhaohuanshi))

	if summonMasterId > 0 then
		self._monIcon:SetActive(true)

		local petMo = self:_getCurFormation():_getPet(summonMasterId)

		if petMo then
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))
			local url = GameUrl.getCharacterIconUrl(modelCo.headName)

			uGuiUtil.setSpriteToImage(self._monIcon, nil, url)
		end
	else
		self._monIcon:SetActive(false)
	end

	self._monTxt.text = "召唤师"
end

function TrainCampQieCuoPVEMissionFmtView:_checkHasJob(idx_GameEnum_CareerType)
	local formationMo = self:_getCurFormation()

	for idx, v in ipairs(formationMo:GetPositions()) do
		local petMo = self:_getPet(v)

		if petMo then
			local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
			local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

			if firstJobIdx == idx_GameEnum_CareerType or secondJobIdx == idx_GameEnum_CareerType then
				return true
			end
		end
	end

	return false
end

function TrainCampQieCuoPVEMissionFmtView:_getSummonMasterId()
	local formationMo = self:_getCurFormation()
	local curSummonedPetId = formationMo:GetSummonPetId()

	if curSummonedPetId > 0 then
		for idx, v in ipairs(formationMo:GetPositions()) do
			local isSummonMaster, summonedPetId = self:IsSummonMaster(formationMo, v)

			if isSummonMaster and summonedPetId == curSummonedPetId then
				return v
			end
		end
	end

	return 0
end

function TrainCampQieCuoPVEMissionFmtView:IsSummonMaster(fmtMo, petId)
	if petId <= 0 then
		return false
	end

	local petDat = TraincampqiecuoModel.instance:getPetMo(petId)

	if not petDat then
		return false
	end

	return petDat.summonedPetId > 0, petDat.summonedPetId
end

function TrainCampQieCuoPVEMissionFmtView:_setSummonContractSkillEffect()
	self:_removeSummonContractSkillEffect()

	local fmtMo = self:_getCurFormation()
	local summonId = fmtMo:GetSummonPetId()
	local masterId = fmtMo:GetSummonMasterPetId()

	if summonId > 0 then
		local effectPath = self:_getContractSkillEffectPath(summonId, masterId)

		if not string.nilorempty(effectPath) then
			local curPos = -1
			local poisitions = self:_getCurPositions()

			for i, v in ipairs(poisitions) do
				if v == summonId then
					curPos = i

					break
				end
			end

			if curPos > 0 then
				local ItemSeatCls = self:_getItemSeatCls()
				local itemSeat = ItemSeatCls.AddOnce(self._seats[curPos])

				itemSeat:playContractSkillEffect(self, effectPath)
			end
		end
	end
end

function TrainCampQieCuoPVEMissionFmtView:_removeSummonContractSkillEffect()
	local ItemSeatCls = self:_getItemSeatCls()

	for pos = 1, 9 do
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])

		itemSeat:removeContractSkillEffect()
	end
end

function TrainCampQieCuoPVEMissionFmtView:_getContractSkillEffectPath(summonId, masterId)
	return "common/buff/fx_buff_zhaohuanshou"
end

function TrainCampQieCuoPVEMissionFmtView:_getContractId(groupId, summonMo)
	return 520006
end

function TrainCampQieCuoPVEMissionFmtView:_onClickHeavenAwakenSummonSkill()
	if TraincampqiecuoModel.instance:isMyPVEOPTeamType() then
		return
	end

	local hasMaster = false
	local positions = self:_getCurPositions()

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if enableDebug and petMo == nil then
				printError("精灵信息为空, FormationLeftViewBase:_onClickBtnHeavenAwakenSummon petMo = nil", v)
			end

			if petMo and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Tianjue) then
				hasMaster = true

				break
			end
		end
	end

	if hasMaster then
		local bagPetMos = self._RightView:getAllShowPetList()

		UIStateManager.instance:push(ViewName.HeavenAwakenSummonPopView, self:_getCurFormation(), bagPetMos)
	else
		FloatWordMgr.instance:show(lang("阵上没有天觉者"))
	end
end

return TrainCampQieCuoPVEMissionFmtView
