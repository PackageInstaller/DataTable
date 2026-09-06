-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/model/SummerTreasureSnatchPvpFmtMo.lua

module("logic.extensions.summertreasuresnatch.model.SummerTreasureSnatchPvpFmtMo", package.seeall)

local SummerTreasureSnatchPvpFmtMo = class("SummerTreasureSnatchPvpFmtMo", BaseCustomFmtMo)

function SummerTreasureSnatchPvpFmtMo:updateCfg(activityId)
	self._activityId = checknumber(activityId)
	self._lockedRaceIdMap = {}
	self.isShowTab = true
	self.topTitleStr = lang("匹配布阵")
	self.ruleDescStr = lang("预设3支队伍，匹配时按顺序依次出战")
	self._pvpMatchInfo = SummerTreasureSnatchModel.instance:getPvpMatchInfo(self._activityId)

	if self._pvpMatchInfo then
		if not self._pvpMatchInfo.view then
			local view = {}

			self._curPvpInfo = view and view[self.curTabIndex]
			self._petExperienceMap = SummerTreasureSnatchModel.instance:getPetExperienceMap(self._activityId)

			self:initPetList()
		end
	end
end

function SummerTreasureSnatchPvpFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	for cardId, v in pairs(self._petExperienceMap) do
		local supportPetCfg = SummerTreasureSnatchConfig.instance:getSupportPetCfg(self._activityId, cardId)
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(supportPetCfg)

		local supportPetMo = fMo:toBaseBagPetMo()

		supportPetMo.isSupportedPet = true

		self:addPetToList(self:_changePetMo(supportPetMo))
	end
end

function SummerTreasureSnatchPvpFmtMo:initFightHandler()
	local function handler()
		if self:checkStartFight() then
			self:_sendPvpFightReq()
		else
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
		end
	end

	self:setFightHandler(handler, nil)
end

function SummerTreasureSnatchPvpFmtMo:_sendPvpFightReq()
	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

	local simpleFormList = {}

	for formId = 1, self.maxTabCount do
		local formationMo = self.forMationMap[formId]

		table.insert(simpleFormList, CustomFmtController.instance:createFormPb(formationMo))
	end

	SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchPvpFightReq(self._activityId, simpleFormList)
end

function SummerTreasureSnatchPvpFmtMo:getMonsterConfigList()
	return {}
end

function SummerTreasureSnatchPvpFmtMo:getFmtInfoConfig()
	return self._curPvpInfo and self._curPvpInfo.curForm.extParams
end

function SummerTreasureSnatchPvpFmtMo:getExtParams()
	return self._curPvpInfo and self._curPvpInfo.curForm.extParams
end

function SummerTreasureSnatchPvpFmtMo:jumpToTabIndex(idx)
	self.curTabIndex = idx

	if self._pvpMatchInfo then
		if not self._pvpMatchInfo.view then
			local view = {}

			self._curPvpInfo = view[self.curTabIndex]

			GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
		end
	end
end

function SummerTreasureSnatchPvpFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if self._curPvpInfo then
		local totalZdl = 0

		for _, basePetView in ipairs(self._curPvpInfo.petSimpleView) do
			local posId

			for i = 1, 9 do
				if basePetView.petId == self._curPvpInfo.curForm.pos[i] then
					posId = i
				end
			end

			if posId then
				local petMo = FightingPowerPetMo.fromBasePetView(basePetView, nil, posId)

				totalZdl = totalZdl + petMo:getFightingPower()

				table.insert(teams, petMo)

				formations[posId] = petMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function SummerTreasureSnatchPvpFmtMo:checkStartFight()
	return not self:checkFormationLimitAndPopWin()
end

function SummerTreasureSnatchPvpFmtMo:checkFormationLimitAndPopWin()
	local isLimit = false

	for formId = 1, self.maxTabCount do
		local formationMo = self.forMationMap[formId]

		if formationMo == nil or formationMo:isEmpty() then
			isLimit = true

			break
		end
	end

	if isLimit then
		TipsFacade.instance:openTipWindowNoX(lang("提示"), lang("存在空阵，无法正常参与匹配，请保证每个阵容至少有1个精灵上阵后继续"), function()
			return
		end)
	end

	return isLimit
end

function SummerTreasureSnatchPvpFmtMo:checkPetIsForbit(checkPetMo)
	local isForbit = false
	local tips = ""
	local raceId = checkPetMo and checknumber(checkPetMo.raceId) or 0

	if self:_isPetNotCanUp(raceId) then
		isForbit = true
		tips = lang("该精灵已被禁用")
	end

	if not isForbit then
		for i = 1, self.maxTabCount do
			if i ~= self.curTabIndex then
				if self.forMationMap then
					local positions = self.forMationMap and self.forMationMap:GetPositions() or {}

					for _, petId in ipairs(positions) do
						if petId ~= 0 then
							local petMo = self:getPetMoById(petId)
							local otherRaceId = petMo and checknumber(petMo.raceId) or 0

							if raceId > 0 and raceId == otherRaceId then
								isForbit = true
								tips = langPara("已在%s号队伍中上阵", i)

								break
							end
						end
					end
				end
			end
		end
	end

	return isForbit, tips
end

function SummerTreasureSnatchPvpFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if not ICustomFmtMo.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		return false
	end

	if petId <= 0 then
		return true
	end

	local petMo = self:getPetMoById(petId)
	local raceId = petMo and checknumber(petMo.raceId) or 0

	return not self:_isPetNotCanUp(raceId)
end

function SummerTreasureSnatchPvpFmtMo:_isPetNotCanUp(raceId)
	return raceId > 0 and self._lockedRaceIdMap[raceId] == true
end

return SummerTreasureSnatchPvpFmtMo
