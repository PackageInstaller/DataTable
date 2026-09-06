-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/model/FormationNewModel.lua

module("logic.extensions.formation.model.FormationNewModel", package.seeall)

local FormationNewModel = class("FormationNewModel", BaseModel)
local FormationSeats

FormationNewModel.arenaTeamId = 999
FormationNewModel.recordTeamId = 9999
FormationNewModel.familyWarTeamId = 10000

function FormationNewModel:ctor()
	self._isInit = false
	self._curTeamId = nil
	self._teams = {}
	self._arenaTeam = nil
	self._familyWarTeam = nil
	self._serverData = FormationServerMo.New()
end

function FormationNewModel:onInit()
	self:onReset()
end

function FormationNewModel:onReset()
	self._isInit = false
	self._curTeamId = nil
	self._teams = {}
	self._arenaTeam = nil
	self._familyWarTeam = nil
	self._serverData = FormationServerMo.New()
	self._formStrengthInfos = {}
	self._defensebuzhenTabType = 0
	self._isdefensebuzhen = false
end

function FormationNewModel:IsInited()
	return self._isInit
end

function FormationNewModel:UpdateData(data)
	self:_setData(data)
	self._serverData:saveServeData(data)
end

function FormationNewModel:RecoverFmtFromServerData()
	printInfo(">>>>>>>>> 重置数据")

	local curTab = self._serverData:getCurTab()
	local userFormTab = self._serverData:getUserFormTab()
	local data = {
		curTab = curTab,
		userFormTab = userFormTab
	}

	self:_setData(data)
end

function FormationNewModel:_setData(data)
	self:SetCurTeamId(data.curTab)

	for _, v in ipairs(data.userFormTab) do
		local team = self._teams[v.tabId]

		if not team then
			team = TeamMO.New()
			self._teams[v.tabId] = team
		end

		team:SetData(v)
	end

	if not self._isInit then
		self._isInit = true

		GlobalDispatcher:dispatch(GlobalNotify.FormationEnter)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
	end
end

function FormationNewModel:setArenaTeam(_simpleForm)
	local teamData = {}

	teamData.tabId = FormationNewModel.arenaTeamId
	teamData.curFormId = _simpleForm.formId

	print("set !!!!!!!!!", teamData.curFormId)

	teamData.simpleForm = {}
	teamData.simpleForm = _simpleForm

	local team = self._arenaTeam

	if not team then
		team = TeamMO.New()
		self._arenaTeam = team
	end

	team:SetData(teamData)

	for k, fmo in pairs(team:GetAllFormations() or {}) do
		if checknumber(fmo.summonedPetId) <= 0 and checknumber(fmo.summonMasterPetId) <= 0 then
			local pet_poisition = fmo:GetPositions() or {}
			local masterId = 0
			local summonId = 0

			for i, v in ipairs(pet_poisition) do
				local petMo = fmo:_getPet(v, true)

				if petMo then
					if checknumber(petMo.summonMasterId) > 0 then
						summonId = petMo.petId
					end

					if checknumber(petMo.summonedPetId) > 0 then
						masterId = petMo.petId
					end
				end
			end

			fmo.summonedPetId = summonId
			fmo.summonMasterPetId = masterId
		end
	end
end

function FormationNewModel:setRecordTeam(_simpleForm)
	local teamData = {}

	teamData.tabId = FormationNewModel.recordTeamId
	teamData.curFormId = _simpleForm.formId

	print("set !!!!!!!!!", teamData.curFormId)

	teamData.simpleForm = {}
	teamData.simpleForm = _simpleForm
	self._recordTeam = self._recordTeam or TeamMO.New()

	self._recordTeam:SetData(teamData)

	for k, fmo in pairs(self._recordTeam:GetAllFormations() or {}) do
		if checknumber(fmo.summonedPetId) <= 0 and checknumber(fmo.summonMasterPetId) <= 0 then
			local pet_poisition = fmo:GetPositions() or {}
			local masterId = 0
			local summonId = 0

			for i, v in ipairs(pet_poisition) do
				local petMo = fmo:_getPet(v, true)

				if petMo then
					if checknumber(petMo.summonMasterId) > 0 then
						summonId = petMo.petId
					end

					if checknumber(petMo.summonedPetId) > 0 then
						masterId = petMo.petId
					end
				end
			end

			fmo.summonedPetId = summonId
			fmo.summonMasterPetId = masterId
		end
	end
end

function FormationNewModel:setFamilyWarTeam(simpleForm)
	self._familyWarTeam = self._familyWarTeam or TeamMO.New()

	self._familyWarTeam:SetData({
		tabId = FormationNewModel.familyWarTeamId,
		curFormId = simpleForm.formId,
		simpleForm = simpleForm
	})
end

function FormationNewModel:isInArena()
	return self._curTeamId == FormationNewModel.arenaTeamId
end

function FormationNewModel:isRecordTeam()
	return self._curTeamId == FormationNewModel.recordTeamId
end

function FormationNewModel:isFamilyWarTeam()
	return self._curTeamId == FormationNewModel.familyWarTeamId
end

function FormationNewModel:FormChanged(form)
	for i, v in ipairs(form) do
		local team = self._teams[v.tabId]

		if not team then
			team = TeamMO.New()
			self._teams[v.tabId] = team
		end

		team:RefreshFormData(v)
	end

	self._serverData:RefreshServeData(form)
end

function FormationNewModel:compareSeverData(tabId, formId, formData)
	return self._serverData:compareFormData(tabId, formId, formData)
end

function FormationNewModel:GetCurTeamId()
	return self._curTeamId
end

function FormationNewModel:SetCurTeamId(id)
	printInfo("设置当前出战的队伍id", self._curTeamId, id)

	if self._curTeamId ~= id then
		self._curTeamId = id

		GlobalDispatcher:dispatch(GlobalNotify.TeamChanged, id)

		return true
	end

	return false
end

function FormationNewModel:checkHasFormId(fid)
	for k, teamMo in pairs(self._teams) do
		if teamMo:checkHasFormationId(fid) then
			return true
		end
	end

	return false
end

function FormationNewModel:GetAllTeams()
	return self._teams
end

function FormationNewModel:GetTeam(teamId)
	if teamId == FormationNewModel.arenaTeamId then
		return self._arenaTeam
	elseif teamId == FormationNewModel.recordTeamId then
		return self._recordTeam
	elseif teamId == FormationNewModel.familyWarTeamId then
		return self._familyWarTeam
	else
		return self:GetAllTeams()[teamId]
	end
end

function FormationNewModel:GetCurTeam()
	if self._curTeamId == FormationNewModel.arenaTeamId then
		return self._arenaTeam
	elseif self._curTeamId == FormationNewModel.recordTeamId then
		return self._recordTeam
	elseif self._curTeamId == FormationNewModel.familyWarTeamId then
		return self._familyWarTeam
	else
		return self:GetAllTeams()[self._curTeamId]
	end
end

function FormationNewModel:getHasPets()
	local team = self:GetCurTeam()

	if team then
		local formation = team:GetCurFormation()

		if formation then
			return formation:getHasPets()
		end
	end

	return {}
end

function FormationNewModel:GetCurFormId()
	local team = self:GetCurTeam()

	if team then
		return team:GetCurFormationId()
	end

	return 0
end

function FormationNewModel:GetCurFormationMo()
	local team = self:GetCurTeam()

	if team then
		return (team:GetCurFormation())
	end

	return nil
end

function FormationNewModel:HasPet(petId)
	return (TableUtil.Any(self._teams, function(k, v)
		return v:HasPet(petId)
	end, pairs))
end

function FormationNewModel:HasPetAtCurFormation(petId)
	local fmo = self:GetCurFormationMo()

	if fmo then
		return fmo:HasPet(petId)
	end

	return false
end

function FormationNewModel:checkHasInTeamByRaceId(raceId)
	local formation = self:GetCurFormationMo()

	if formation then
		for _, petId in ipairs(formation:GetPositions()) do
			if petId > 0 then
				local pet = BagPetsController.instance:getPet(petId)

				if pet and pet.raceId == raceId then
					return true
				end
			end
		end
	end

	return false
end

function FormationNewModel:setTeamTabName(tabId, tabName)
	local team = self._teams[tabId]

	if team then
		team:setTabName(tabName)
		GlobalDispatcher:dispatch(GlobalNotify.FormationNameChange, tabId, tabName)
	end
end

function FormationNewModel:ToString()
	local str = tostring(self:GetCurTeamId()) .. "\n"

	for id, team in ipairs(self:GetAllTeams()) do
		str = str .. string.format("team %d :", id) .. team:ToString() .. "\n"
	end

	return str
end

function FormationNewModel:updateFormStrengthInfo(infos)
	self._formStrengthInfos = {}

	for i, v in ipairs(infos) do
		self._formStrengthInfos[v.formStrengthId] = v
	end

	BagPetsController.instance:calcAllPetFormStreangthAttr()
end

function FormationNewModel:initFormStrengthInfo(formId)
	local oldInfo = self._formStrengthInfos[formId]

	if not oldInfo then
		self._formStrengthInfos[formId] = {
			formStrengthLv = 1,
			formStrengthId = formId
		}
	end

	BagPetsController.instance:calcAllPetFormStreangthAttr()
end

function FormationNewModel:getFormStrengthInfo(formStrengthId)
	return self._formStrengthInfos[formStrengthId]
end

function FormationNewModel:getAllFormStrengthInfo()
	return self._formStrengthInfos
end

function FormationNewModel:setCurrBuffFormInfo(formStrengthId)
	local modify = false
	local team = self:GetCurTeam()

	if team then
		local fomation = team:GetCurFormation()

		if fomation and (fomation._formStrengInfo == nil or fomation._formStrengInfo.formStrengthId ~= formStrengthId) then
			local info = self:getFormStrengthInfo(formStrengthId)

			if info then
				fomation:SetFormStrengthInfo(info)

				modify = true
			else
				if fomation._formStrengInfo ~= nil and fomation._formStrengInfo.formStrengthId ~= formStrengthId then
					modify = true
				end

				fomation:SetFormStrengthInfo(nil)
			end
		end
	end

	return modify
end

function FormationNewModel:setCurrBuffFormId(formStrengthId)
	FormationController.instance:setCurrBuffFormInfo(formStrengthId)
end

function FormationNewModel:getCurrBuffFormId()
	local formId = false
	local team = FormationNewModel.instance:GetCurTeam()

	if team then
		local fomation = team:GetCurFormation()

		if fomation then
			local info = fomation:GetFormStrengthInfo()

			if info and info.formStrengthId and info.formStrengthId > 0 then
				formId = info.formStrengthId
			end
		end
	end

	return formId
end

function FormationNewModel:upGradeFormSuccessed(id)
	local info = self:getFormStrengthInfo(id)

	if info then
		info.formStrengthLv = info.formStrengthLv + 1

		UIStateManager.instance:push(ViewName.NineplaceuplvsuccessedView, info)
	end

	BagPetsController.instance:calcAllPetFormStreangthAttr()
	GlobalDispatcher:dispatch(GlobalNotify.BuffFormStrengthSuccessed)
end

function FormationNewModel:checkUpgradeFuncRed()
	local red = false
	local open = FuncOpenModel.instance:getFuncIsOpen(96)

	if open then
		local cfgs = NinePlaceConfig.instance:getStageCfgs()

		for i, v in ipairs(cfgs) do
			red = self:checkStageCanUpgrade(v.stageId)

			if red then
				break
			end
		end
	end

	return red
end

function FormationNewModel:checkStageCanUpgrade(stageId)
	local red = false
	local cfg = NinePlaceConfig.instance:getStageCfgById(stageId)
	local strengthInfo = self:getFormStrengthInfo(stageId)

	if strengthInfo then
		local nextCfg = BattleConfig.instance:getFormStrengthLvCfg(strengthInfo.formStrengthId, strengthInfo.formStrengthLv + 1)

		if nextCfg and not string.nilorempty(nextCfg.upgradeCost) then
			local arrs = string.split(nextCfg.upgradeCost, "#")

			for i, v in ipairs(arrs) do
				red = true

				local arrs2 = string.split(v, ":")
				local matType = checknumber(arrs2[1])
				local matId = checknumber(arrs2[2])
				local useNum = checknumber(arrs2[3])
				local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

				if has_num < useNum then
					red = false

					break
				end
			end
		end
	end

	return red
end

function FormationNewModel:getDefenseBuzhenParams()
	return self._defensebuzhenTabType
end

FormationNewModel.instance = FormationNewModel.New()

return FormationNewModel
