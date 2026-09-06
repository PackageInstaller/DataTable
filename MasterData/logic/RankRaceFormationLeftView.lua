-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceFormationLeftView.lua

module("logic.extensions.rankrace.view.RankRaceFormationLeftView", package.seeall)

local RankRaceFormationLeftView = class("RankRaceFormationLeftView", FormationLeftView)

function RankRaceFormationLeftView:onEnter()
	RankRaceFormationLeftView.super.onEnter(self)

	local _matchType = RankRaceController.instance:getCurViewType()

	if _matchType == RankRaceController.MatchTypeLimit then
		goutil.setActive(self._MarkNotActive_BuffForm, false)
	end
end

function RankRaceFormationLeftView:_getPowerAndSpeed()
	local _matchType = RankRaceController.instance:getCurViewType()

	if _matchType == RankRaceController.MatchTypeClassics then
		local power, speed = RankRaceFormationLeftView.super._getPowerAndSpeed(self)

		return power, speed
	else
		local formation = self:_getCurFormation()
		local fid = 0
		local flvl = 0
		local info = formation:GetFormStrengthInfo()

		if info and info.formStrengthId and info.formStrengthId > 0 then
			fid = info.formStrengthId
			flvl = BattleConfig.instance:getFormStrengthMaxLv(info.formStrengthId)
		end

		local power, speed = RankRaceController.instance:calMaxFightPowerAnfSpeed(formation, self:_getHeroSkillId(), fid, flvl)

		return power, speed
	end
end

function RankRaceFormationLeftView:_getPet(petId)
	if RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeClassics then
		return BagPetsController.instance:getPet(petId)
	elseif RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeLimit then
		local petMo = BagPetsController.instance:getPet(petId)

		return FightingPowerPetMo.getMaxPetMoByData(petMo)
	end
end

function RankRaceFormationLeftView:_getItemSeatCls()
	if RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeClassics then
		return ItemSeat
	elseif RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeLimit then
		return RankRaceItemSeat
	end
end

function RankRaceFormationLeftView:_OnClickBtnBuffForm()
	local _curViewType = RankRaceController.instance:getCurViewType()

	if not _curViewType then
		return
	end

	if _curViewType == RankRaceController.MatchTypeClassics then
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
	elseif _curViewType == RankRaceController.MatchTypeLimit then
		local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

		UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, false, true)
	end
end

function RankRaceFormationLeftView:_onUpdateBuffFormById(info)
	local _matchType = RankRaceController.instance:getCurViewType()

	if not _matchType then
		RankRaceFormationLeftView.super._onUpdateBuffFormById(self, info)

		return
	end

	if _matchType == RankRaceController.MatchTypeClassics then
		RankRaceFormationLeftView.super._onUpdateBuffFormById(self, info)
	elseif _matchType == RankRaceController.MatchTypeLimit then
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

function RankRaceFormationLeftView:_refreshBuffForm()
	local _matchType = RankRaceController.instance:getCurViewType()

	if not _matchType then
		RankRaceFormationLeftView.super._refreshBuffForm(self)

		return
	end

	if _matchType == RankRaceController.MatchTypeClassics then
		RankRaceFormationLeftView.super._refreshBuffForm(self)
	elseif _matchType == RankRaceController.MatchTypeLimit then
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

function RankRaceFormationLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local result = RankRaceFormationLeftView.super._isPosValidatorMatchOnSelect(self, pos, petId, isShowTip)

	if result then
		if petId > 0 then
			local petMo = self:_getPet(petId)
			local raceId = petMo:getDefineId()
			local _matchType = self:getFirstParam()

			return not RankRaceController.instance:iscurBanPet(_matchType, raceId)
		else
			return true
		end
	end

	return result
end

function RankRaceFormationLeftView:checkPetIsForbit(petId)
	local petMo = self:_getPet(petId)

	if petMo then
		local _matchType = self:getFirstParam()

		return RankRaceController.instance:iscurBanPet(_matchType, petMo.raceId)
	else
		return false
	end
end

return RankRaceFormationLeftView
