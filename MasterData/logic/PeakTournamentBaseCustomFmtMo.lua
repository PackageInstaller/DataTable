-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/model/PeakTournamentBaseCustomFmtMo.lua

module("logic.extensions.peaktournament.model.PeakTournamentBaseCustomFmtMo", package.seeall)

local PeakTournamentBaseCustomFmtMo = class("PeakTournamentBaseCustomFmtMo", ICustomFmtMo)

function PeakTournamentBaseCustomFmtMo:onReset()
	PeakTournamentBaseCustomFmtMo.super.onReset(self)
end

function PeakTournamentBaseCustomFmtMo:updateCfg(activityId)
	self._activityId = checknumber(activityId)
	self._lockedRaceIdMap = {}

	local banRaceIds = PeakTournamentModel.instance:getMyFormBanRaceIds()

	for _, raceId in ipairs(banRaceIds) do
		self._lockedRaceIdMap[raceId] = true
	end
end

function PeakTournamentBaseCustomFmtMo:updateData()
	self.isShowTab = true
	self.curTabIndex = 1

	self:refreshMyFmts()
	self:initPetList()
end

function PeakTournamentBaseCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function PeakTournamentBaseCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function PeakTournamentBaseCustomFmtMo:initFormationMo()
	if self.formationMoList == nil then
		self.formationMoList = {}
	end

	for formId = 1, 3 do
		if self.formationMoList[formId] == nil then
			self.formationMoList[formId] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
		end
	end
end

function PeakTournamentBaseCustomFmtMo:getCurFormation()
	return self.formationMoList[self.curTabIndex]
end

function PeakTournamentBaseCustomFmtMo:showForbitPetAlert(petMo)
	local boo, tips = self:checkPetIsForbit(petMo)

	FloatWordMgr.instance:show(tips)
end

function PeakTournamentBaseCustomFmtMo:checkPetIsForbit(checkPetMo)
	local isForbit = false
	local tips = ""

	if isForbit == false and self:_isPetNotCanUp(checkPetMo:getDefineId()) then
		isForbit = true
		tips = lang("该精灵已被禁用")
	end

	if isForbit == false then
		for i = 1, 3 do
			if i ~= self.curTabIndex then
				local otherFormationMo = self.formationMoList[i]
				local pet_poisition = otherFormationMo:GetPositions() or {}

				for idx, v in ipairs(pet_poisition) do
					if v ~= 0 then
						local petmo = self:getPetMoById(v)

						if petmo and checkPetMo:getDefineId() == petmo:getDefineId() then
							isForbit = true
							tips = langPara("【%s】阵型中已使用该精灵", i)

							break
						end
					end
				end
			end
		end
	end

	return isForbit, tips
end

function PeakTournamentBaseCustomFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if PeakTournamentBaseCustomFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		if petId > 0 then
			local petMo = self:getPetMoById(petId)

			return not self:_isPetNotCanUp(petMo:getDefineId())
		else
			return true
		end
	else
		return false
	end
end

function PeakTournamentBaseCustomFmtMo:_isPetNotCanUp(raceId)
	if raceId > 0 then
		return self._lockedRaceIdMap[raceId] == true
	else
		return false
	end
end

function PeakTournamentBaseCustomFmtMo:saveMyFmts()
	local simpleFormList = {}

	for formId, fmtMo in ipairs(self.formationMoList) do
		if fmtMo:isEmpty() then
			return
		end

		table.insert(simpleFormList, CustomFmtController.instance:createFormPb(fmtMo))
	end

	PeakTournamentController.instance:sendPM_PeakTournamentSetFormReq(self._activityId, simpleFormList, self:getIsDefense())
end

function PeakTournamentBaseCustomFmtMo:refreshMyFmts()
	local formInfoList = PeakTournamentModel.instance:getMyFormInfoList()

	if formInfoList then
		for _, formInfo in ipairs(formInfoList) do
			self.formationMoList[formInfo.formId]:SetData(formInfo.view.curForm)
		end
	end
end

function PeakTournamentBaseCustomFmtMo:getIsDefense()
	return false
end

return PeakTournamentBaseCustomFmtMo
