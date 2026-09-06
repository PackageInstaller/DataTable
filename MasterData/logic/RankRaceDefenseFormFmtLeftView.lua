-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceDefenseFormFmtLeftView.lua

module("logic.extensions.rankrace.view.RankRaceDefenseFormFmtLeftView", package.seeall)

local RankRaceDefenseFormFmtLeftView = class("RankRaceDefenseFormFmtLeftView", BuzhenLeftView)

function RankRaceDefenseFormFmtLeftView:onEnter()
	self._matchType = self:getFirstParam()

	RankRaceDefenseFastFormation.instance:setMatchType(self._matchType)
	RankRaceDefenseFormFmtLeftView.super.onEnter(self)
	self:setBtnCutePetActive(true)

	if self._matchType == RankRaceController.MatchTypeLimit then
		goutil.setActive(self._MarkNotActive_BuffForm, false)
		self:setBtnCutePetActive(false)
		self:_setActiveBtnFormationUse(false)
	end
end

function RankRaceDefenseFormFmtLeftView:onExit()
	self:_onExitUnbindingEvent()
	RankRaceFmtModel.instance:onViewClose(self._matchType)
	removetimer(self._doPlayAudio, self)
	removetimer(self._playFormationAni, self)

	self._formationChangeFlag = false
end

function RankRaceDefenseFormFmtLeftView:_onClickClean()
	RankRaceDefenseFastFormation.instance:clean()
end

function RankRaceDefenseFormFmtLeftView:_SetFormationNameAndIcon(id)
	local index = self:_getCurrTeamId()
	local team = FormationNewModel.instance:GetTeam(index)

	self._TxtC_Formation.text = team:getTabName()
end

function RankRaceDefenseFormFmtLeftView:_updateStartOrder()
	local selfPoses = {}
	local fmtPoses = self:_getCurFormation():GetPositions()

	for i, petId in ipairs(fmtPoses) do
		if petId > 0 then
			table.insert(selfPoses, i)
		end
	end

	self:_doUpdateStartOrder(true, selfPoses, {})
end

function RankRaceDefenseFormFmtLeftView:_getCurFormId()
	return RankRaceFmtModel.instance:getCurFormationId(self._matchType)
end

function RankRaceDefenseFormFmtLeftView:_getCurFormation()
	return RankRaceFmtModel.instance:getDefenseForm(self._matchType)
end

function RankRaceDefenseFormFmtLeftView:_changePosition(pos, value)
	RankRaceFmtModel.instance:changePosition(self._matchType, pos, value)
end

function RankRaceDefenseFormFmtLeftView:_getPetsHeroSkills()
	return RankRaceFmtModel.instance:getFormPetsHeroSkills(self._matchType)
end

function RankRaceDefenseFormFmtLeftView:_getHeroSkillId()
	return RankRaceFmtModel.instance:getHeroSkillId(self._matchType)
end

function RankRaceDefenseFormFmtLeftView:_changeHeroSkillId(id)
	RankRaceFmtModel.instance:changeSkillId(self._matchType, id)
end

function RankRaceDefenseFormFmtLeftView:_getPet(id)
	return BagPetsController.instance:getPet(id)
end

function RankRaceDefenseFormFmtLeftView:_changeTeamId(id)
	return
end

function RankRaceDefenseFormFmtLeftView:_getCurrTeamId()
	return 1
end

function RankRaceDefenseFormFmtLeftView:_setPositionForce(positions, forceDispatch)
	RankRaceFmtModel.instance:getDefenseForm(self._matchType):setPositionForce(positions, forceDispatch)
end

function RankRaceDefenseFormFmtLeftView:_getPowerAndSpeed()
	local power = 0
	local team, formation, speed = self:getTeamAndFormation()
	local fmo = self:_getCurFormation()
	local fid = 0
	local flvl = 0
	local info = fmo:GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	if RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeClassics then
		power, speed = fmo:getPowerAndSpeed()
	elseif RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeLimit then
		local fMaxlv = BattleConfig.instance:getFormStrengthMaxLv(fid)

		power, speed = RankRaceController.instance:calMaxFightPowerAnfSpeed(fmo, self:_getHeroSkillId(), fid, fMaxlv)
	end

	return power, speed
end

function RankRaceDefenseFormFmtLeftView:_getPet(petId)
	if RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeClassics then
		return BagPetsController.instance:getPet(petId)
	elseif RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeLimit then
		local petMo = BagPetsController.instance:getPet(petId)

		return FightingPowerPetMo.getMaxPetMoByData(petMo)
	end
end

function RankRaceDefenseFormFmtLeftView:_getItemSeatCls()
	return RankRaceItemSeat
end

function RankRaceDefenseFormFmtLeftView:SetFormStrengthInfo(info)
	RankRaceDefenseFormFmtLeftView.super.SetFormStrengthInfo(self, info)
end

function RankRaceDefenseFormFmtLeftView:_OnClickBtnBuffForm()
	if not self._matchType then
		return
	end

	if self._matchType == RankRaceController.MatchTypeClassics then
		local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

		if not isOpen then
			local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(96)

			if cfgFuncOpen then
				FloatWordMgr.instance:show(cfgFuncOpen.description)
			end

			return
		end

		local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

		UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, false)
	elseif self._matchType == RankRaceController.MatchTypeLimit then
		local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

		UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, false, true)
	end
end

function RankRaceDefenseFormFmtLeftView:_onUpdateBuffFormById(info)
	if not self._matchType then
		RankRaceDefenseFormFmtLeftView.super._onUpdateBuffFormById(self, info)

		return
	end

	if self._matchType == RankRaceController.MatchTypeClassics then
		RankRaceDefenseFormFmtLeftView.super._onUpdateBuffFormById(self, info)
	elseif self._matchType == RankRaceController.MatchTypeLimit then
		goutil.setActive(self._MarkLock_BuffForm, false)
		goutil.setActive(self._MarkNotActive_BuffForm, false)

		local formId
		local formLv = 0

		if info then
			formId = info.formStrengthId
			formLv = BattleConfig.instance:getFormStrengthMaxLv(info.formStrengthId)
			info.formStrengthLv = formLv
		end

		self:SetFormStrengthInfo(info)
		self:_onSelectBuffForm(formId, formLv)

		formId = nil

		if self._CurFormId ~= nil then
			self._CurFormId = checknumber(formId)

			self:_SetPowerAndSpeed()

			if checknumber(formId) > 0 then
				self:_showFormationActive()
			end
		end
	end
end

function RankRaceDefenseFormFmtLeftView:_refreshBuffForm()
	if not self._matchType then
		RankRaceDefenseFormFmtLeftView.super._refreshBuffForm(self)

		return
	end

	if self._matchType == RankRaceController.MatchTypeClassics then
		RankRaceDefenseFormFmtLeftView.super._refreshBuffForm(self)
	elseif self._matchType == RankRaceController.MatchTypeLimit then
		local cfgs = BattleConfig.instance:getFormStrengthTriggerCfgs()
		local positions = self:_getCurPositions()
		local posDataList = {}
		local compA = 0

		for i, petId in ipairs(positions) do
			if petId > 0 then
				local mo = self:_getPet(petId)

				if mo.summonMasterId <= 0 then
					table.insert(posDataList, i)

					compA = compA + math.pow(2, i)
				end
			end
		end

		local fsMap = {}

		for i = 1, 8 do
			local _maxlv = BattleConfig.instance:getFormStrengthMaxLv(i)

			fsMap[i] = {
				formStrengthId = i,
				formStrengthLv = _maxlv
			}
		end

		for k, v in pairs(fsMap or {}) do
			if v.formStrengthLv > 0 then
				local posCfg = BattleConfig.instance:getFormStrengthTriggerCfgByStateId(v.formStrengthId)

				if posCfg then
					local posList = posCfg.posList

					if posList and #posList == #posDataList then
						local compB = 0

						for i = 1, #posList do
							local pp_b = posList[i]

							compB = compB + math.pow(2, pp_b)
						end

						if compA == compB then
							self:_onUpdateBuffFormById(v)

							return
						end
					end
				end
			end
		end

		self:_onUpdateBuffFormById(nil)
	end
end

function RankRaceDefenseFormFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local result = RankRaceDefenseFormFmtLeftView.super._isPosValidatorMatchOnSelect(self, pos, petId, isShowTip)

	if result then
		if petId > 0 then
			local petMo = self:_getPet(petId)

			return not self:isForbitPet(petMo)
		else
			return true
		end
	end

	return result
end

function RankRaceDefenseFormFmtLeftView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	RankRaceDefenseFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), GameUtil.handler(self.notFilterPet, self), function(posList, petPool)
		return posList, petPool
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function RankRaceDefenseFormFmtLeftView:notFilterPet(petMo)
	local forbit = self:isForbitPet(petMo)

	if forbit then
		return false
	end

	return true
end

function RankRaceDefenseFormFmtLeftView:isForbitPet(checkPetMo)
	local isForbit = false
	local tips = ""

	if isForbit == false and self:_isPetNotCanUp(checkPetMo:getDefineId()) then
		isForbit = true
		tips = lang("该精灵已被禁用")
	end

	return isForbit, tips
end

function RankRaceDefenseFormFmtLeftView:_isPetNotCanUp(raceId)
	if raceId > 0 then
		local _matchType = self:getFirstParam()

		return RankRaceController.instance:iscurBanPet(_matchType, raceId)
	else
		return false
	end
end

function RankRaceDefenseFormFmtLeftView:checkPetIsForbit(petId)
	local petMo = self:_getPet(petId)

	if petMo then
		return self:isForbitPet(petMo)
	else
		return false
	end
end

return RankRaceDefenseFormFmtLeftView
