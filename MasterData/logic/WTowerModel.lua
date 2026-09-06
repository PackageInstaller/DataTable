-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/model/WTowerModel.lua

module("logic.extensions.warriortower.model.WTowerModel", package.seeall)

local WTowerModel = class("WTowerModel", BaseModel)

WTowerModel.REFRESH_TOWER_INFO = "refreshtowerinfo"
WTowerModel.FAST_REVENUE_RED = "fastRevenueRed"
WTowerModel.ReceiveEff = "ReceiveEff"
WTowerModel.ReceiveAuto = "ReceiveAuto"
WTowerModel.TowerType = {
	RightWrong = 6,
	Wisdom = 3,
	Time = 5,
	Life = 2,
	Kong = 7,
	Warrior = 1,
	Chuang = 8,
	Power = 4
}
WTowerModel.TowerTitle = {
	"勇者之塔",
	"生命之塔",
	"智慧之塔",
	"力量之塔",
	"时间之塔",
	"是非之塔",
	"时空之塔",
	"创造之塔"
}
WTowerModel.TowerBg = {
	"ui/bigbg/warriortower/bg_yzzl01.png",
	"ui/bigbg/warriortower/bg_grass.png",
	"ui/bigbg/warriortower/bg_water.png",
	"ui/bigbg/warriortower/bg_fire.png",
	"ui/bigbg/warriortower/bg_light_0.png",
	"ui/bigbg/warriortower/bg_dark.png",
	"ui/bigbg/warriortower/bg_air.png",
	"ui/bigbg/warriortower/bg_yzzl01.png"
}
WTowerModel.TowerCellBg = {
	"ui/bigbg/warriortower/board_grass.png",
	"ui/bigbg/warriortower/board_grass.png",
	"ui/bigbg/warriortower/board_water.png",
	"ui/bigbg/warriortower/board_fire.png",
	"ui/bigbg/warriortower/board_grass.png",
	"ui/bigbg/warriortower/board_dark.png",
	"ui/bigbg/warriortower/board_air.png",
	"ui/bigbg/warriortower/board_grass.png"
}

function WTowerModel:ctor()
	return
end

function WTowerModel:onInit()
	self:onReset()

	self._teamId = 1
end

function WTowerModel:onReset()
	self._curPhase = {
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1
	}
	self._canGainExp = 0
	self._challengeLevelInfos = {}
	self._towerId = WTowerModel.TowerType.Warrior
	self._teamId = self._teamId or 1
	self._svrFormation = {}
	self._formation = {}
	self._towerFmtLoaded = {}
	self._boxInfos = {}
	self._timestamp = nil
	self._turnTotalTimes = 0
	self._turnFreeTimes = 0
end

function WTowerModel:getTowerId()
	return self._towerId or 1
end

function WTowerModel:setTowerId(towerId)
	self._towerId = towerId
end

function WTowerModel:_initBoxInfos()
	for towerId = 1, #WTowerModel.TowerTitle do
		self._boxInfos[towerId] = {}

		local cfgs = WTowerConfig.instance:getCfgs(towerId)

		for i, v in ipairs(cfgs) do
			if v.progressBox ~= "" then
				local info = {}

				info._state = 3
				info._level = v.creepsMasterId % tonumber(WTowerConfig.instance:getParaCfg("MaxLayer"))
				info._id = #self._boxInfos[towerId]
				info._prizeStr = v.progressBox

				table.insert(self._boxInfos[towerId], info)
			end
		end
	end
end

function WTowerModel:_creepMasterId_to_level(creepsMasterId)
	local temp = creepsMasterId

	for towerId = 1, #WTowerModel.TowerTitle do
		local count = WTowerConfig.instance:getCfgCount(towerId)

		if temp <= count then
			return temp
		else
			temp = temp - count
		end
	end

	return 0
end

function WTowerModel:setBoxStates(towerId, boxStates)
	for i, v in ipairs(boxStates) do
		local boxInfo = self:getBoxInfo(towerId)

		if i > #boxInfo then
			break
		end

		boxInfo[i]._state = self._curPhase[towerId] >= boxInfo[i]._level and (v and 1 or 2) or 3
	end

	local test
end

function WTowerModel:refreshBoxStates()
	local boxInfo = self:getBoxInfo(self._towerId)

	for i, v in ipairs(boxInfo) do
		if v._state == 3 and self._curPhase[self._towerId] >= boxInfo[i]._level then
			boxInfo[i]._state = 2
		end
	end
end

function WTowerModel:getBox(prizeId)
	local arr = self:getBoxInfo(self._towerId)

	arr[prizeId + 1]._state = 1
end

function WTowerModel:getBoxes(prizeIds)
	local arr = self:getBoxInfo(self._towerId)

	for _, prizeId in ipairs(prizeIds) do
		arr[prizeId + 1]._state = 1
	end
end

function WTowerModel:getBoxInfos(all)
	if all then
		return self:getBoxInfo(self._towerId)
	end

	local infos = {}
	local index = self:getCurPage() - 1
	local boxInfo = self:getBoxInfo(self._towerId)

	if index * 4 + 4 < #boxInfo then
		for i = index * 4 + 1, index * 4 + 4 do
			table.insert(infos, boxInfo[i])
		end
	else
		for i = #boxInfo - 4, #boxInfo - 1 do
			table.insert(infos, boxInfo[i])
		end
	end

	infos[5] = self:getBoxInfo(self._towerId)[#self._boxInfos]

	return infos
end

function WTowerModel:getProgValue()
	local boxInfo = self:getBoxInfo(self._towerId)
	local gap = boxInfo[2]._level - boxInfo[1]._level

	return (self._curPhase - self:getBoxInfos()[1]._level + gap + 0.05) / (gap * 5)
end

function WTowerModel:getCurPage()
	local boxInfo = self:getBoxInfo(self._towerId)

	for i, v in ipairs(boxInfo) do
		if v._state ~= 1 then
			return math.ceil(i / 4)
		end
	end

	return 1
end

function WTowerModel:getBoxInfo(towerId)
	if self._boxInfos[towerId] == nil then
		self:_initBoxInfos()
	end

	return self._boxInfos[towerId]
end

function WTowerModel:getCanGainExp()
	return self._canGainExp
end

function WTowerModel:getLevelInfos(towerId)
	return self._challengeLevelInfos[towerId]
end

function WTowerModel:setChallengeInfos(towerId, curphase)
	self._challengeLevelInfos[towerId] = {}
	self._curPhase[towerId] = curphase

	if towerId == 1 then
		WTowerController.instance:setMainProgress(curphase)
	end

	local count = WTowerConfig.instance:getCfgCount(towerId)

	for i = 1, count do
		local info = WTowerLevelInfo.New()

		info._id = i
		info._state = i <= curphase and 1 or i == curphase + 1 and 4 or 3

		local cfg = WTowerConfig.instance:getCfgById(i, towerId)

		if cfg then
			info._faceId = cfg.showFaceId
			info._power = cfg.recommendZdl
		end

		table.insert(self._challengeLevelInfos[towerId], info)
	end
end

function WTowerModel:isCurMofangLock()
	local curLv = MofangModel.instance:getCurLv()
	local curStage = self:getCurLevel(self._towerId)
	local cfg = WTowerConfig.instance:getCfgById(curStage, self._towerId)

	if cfg == nil then
		return true
	else
		return false
	end
end

function WTowerModel:getCurLevel(towerId)
	if towerId and self._curPhase[towerId] then
		return self._curPhase[towerId] + 1
	else
		return self._curPhase[self._towerId] + 1
	end
end

function WTowerModel:getMaxReachLevel(towerId)
	return self._curPhase[towerId]
end

function WTowerModel:passedAllLevel(towerId)
	return self._curPhase[towerId] >= WTowerConfig.instance:getCfgCount(towerId)
end

function WTowerModel:getTowerUnlockLevel(towerId)
	return WTowerConfig.instance:getDicCfg(towerId).unlock
end

function WTowerModel:setFormation(form)
	local formationMo = self:getFormation(self._towerId)

	formationMo:SetData(form)

	local masterId = 0
	local summonId = 0

	for i, v in pairs(formationMo:GetPositions() or {}) do
		local petMo = WTowerModel.instance:getPet(v)

		if petMo and checknumber(petMo.summonMasterId) > 0 then
			summonId = petMo.petId
			masterId = checknumber(petMo.summonMasterId)
		end
	end

	if checknumber(formationMo.summonMasterPetId) <= 0 and checknumber(formationMo.summonedPetId) <= 0 and masterId > 0 and summonId > 0 then
		formationMo.summonMasterPetId = masterId
		formationMo.summonedPetId = summonId
	end

	formationMo:resetHasPet(5)
	self:_saveAsSvrFometion(form)
end

function WTowerModel:getCurFormationId()
	return self:getFormation(self._towerId):GetId()
end

function WTowerModel:getFormation(towerId)
	if self._formation[towerId] == nil then
		self._formation[towerId] = FormationMO.New(function(petId)
			return WTowerModel.instance:getPet(petId)
		end)
	end

	return self._formation[towerId]
end

function WTowerModel:getCurFormation()
	return self:getFormation(self._towerId)
end

function WTowerModel:saveCurrFormation()
	if self._towerId == WTowerModel.TowerType.Warrior then
		return
	end

	local isDirty = false
	local formation = self:getFormation(self._towerId)
	local poses = formation:GetPositions()
	local skillId = formation:GetHeroSkillId()
	local psychicSkillId = formation:GetPsychicedSkillId()
	local svrFormation = self:getSvrFormation(self._towerId)

	if not isDirty and svrFormation.extParams.heroSkillId ~= skillId then
		isDirty = true
	end

	if not isDirty and svrFormation.extParams.psychicSkillId ~= psychicSkillId then
		isDirty = true
	end

	local elementalMasterId = formation:GetElementalMasterId()
	local elementalTargetId = formation:GetElementalTargetId()

	if not isDirty and (svrFormation.extParams.elementalMasterId ~= elementalMasterId or svrFormation.extParams.elementalTargetId ~= elementalTargetId) then
		isDirty = true
	end

	if not isDirty then
		local svrPoses = svrFormation.pos

		for i = 1, #poses do
			if poses[i] ~= svrPoses[i] then
				isDirty = true

				break
			end
		end
	end

	local form = formation:createFormPb()

	WarriorTowerAgent.instance:sendSetWarriorTowerFormReq(self._towerId, form, function(msg)
		self:_saveAsSvrFometion(msg.simpleForm)
		self:setFormation(msg.simpleForm)
		GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
	end)

	return isDirty
end

function WTowerModel:getFormPetsHeroSkills()
	local formation = self:getCurFormation()
	local pet_poisition = formation:GetPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local summonId = formation:GetSummonPetId()
	local masterId = formation:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, formation:getCurElementRelationMap(), masterId, summonId))
end

function WTowerModel:getHeroSkillId()
	return self:getFormation(self._towerId):GetHeroSkillId()
end

function WTowerModel:changeSkillId(id)
	self:getFormation(self._towerId):SetHeroSkillId(id)
end

function WTowerModel:getAllPets()
	local allPets = {}
	local pets = BagPetsController.instance:getFightBagPet()

	for k, v in pairs(pets) do
		allPets[#allPets + 1] = clone(v)
	end

	return allPets
end

function WTowerModel:getPet(petId)
	if not petId or petId == 0 then
		return
	end

	return BagPetsController.instance:getPet(petId)
end

function WTowerModel:setTeamId(id)
	self._teamId = id
end

function WTowerModel:getTeamId()
	return self._teamId
end

function WTowerModel:_saveAsSvrFometion(form)
	local formation = {}

	formation.formId = form.formId
	formation.pos = {}

	for k, j in ipairs(form.pos) do
		formation.pos[k] = j
	end

	formation.extParams = {}
	formation.extParams.heroSkillId = form.extParams.heroSkillId
	formation.extParams.psychicSkillId = form.extParams.psychicSkillId
	formation.extParams.elementalMasterId = form.extParams.elementalMasterId
	formation.extParams.elementalTargetId = form.extParams.elementalTargetId
	self._svrFormation[self._towerId] = formation
end

function WTowerModel:getSvrFormation(towerId)
	if self._svrFormation[towerId] == nil then
		self._svrFormation[towerId] = FormationMO.New(function(petId)
			return WTowerModel.instance:getPet(petId)
		end)
	end

	return self._svrFormation[towerId]
end

function WTowerModel:getTowerFromFmt(towerId)
	return self._towerFmtLoaded[towerId] or false
end

function WTowerModel:setTowerFromFmt(towerId, torf)
	self._towerFmtLoaded[towerId] = torf
end

function WTowerModel:getCurrBuffFormId()
	local info = self:getFormation(self._towerId):GetFormStrengthInfo()

	if info and info.formStrengthId then
		return info.formStrengthId
	end
end

function WTowerModel:setCurrBuffFormInfo(formStrengthId)
	local info = FormationNewModel.instance:getFormStrengthInfo(formStrengthId)

	if info then
		local fomation = self:getFormation(self._towerId)

		if fomation and fomation._formStrengInfo ~= formStrengthId then
			fomation:SetFormStrengthInfo(info)
		end
	end
end

function WTowerModel:isCurFormationEmpty()
	local formation = self:getCurFormation()
	local pet_poisition = formation:GetPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			return
		end
	end

	return true
end

function WTowerModel:diffRacePetCount()
	local allPets = self:getAllPets()
	local tem = WTFastFormation.instance:_filterByRace(allPets)

	return #tem
end

function WTowerModel:checkHasInTeamByRaceId(raceId)
	local formation = self:getCurFormation()

	for _, petId in ipairs(formation:GetPositions()) do
		if petId > 0 then
			local pet = BagPetsController.instance:getPet(petId)

			if pet and pet.raceId == raceId then
				return true
			end
		end
	end

	return false
end

function WTowerModel:GetSortParms()
	local names, opt = BagModel.instance:GetSortParms()

	names[1] = function(data)
		local res = 0

		if data ~= nil then
			if self:getCurFormation():HasPet(data.petId) then
				res = 1
			end
		end

		return res
	end

	return names, opt
end

function WTowerModel:setTimeBoxInfo(timestamp, turnTotalTimes, turnFreeTimes)
	self._timestamp = math.floor(timestamp / 1000)
	self._turnTotalTimes = turnTotalTimes
	self._turnFreeTimes = turnFreeTimes
end

function WTowerModel:setTimeBoxFreeTimes(turnFreeTimes)
	self._turnFreeTimes = turnFreeTimes
end

function WTowerModel:setTimeBoxTotalTimes(totalTimes)
	self._turnTotalTimes = totalTimes
end

function WTowerModel:setBoxGainTime(timestamp)
	self._timestamp = math.floor(timestamp / 1000)
end

function WTowerModel:getBoxGainTime()
	return self._timestamp
end

function WTowerModel:getTimeBoxTimes()
	return self._turnTotalTimes, self._turnFreeTimes
end

function WTowerModel:getOriginalCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function WTowerModel:_getCurFormation()
	if WTowerModel.instance:getTowerId() ~= WTowerModel.TowerType.Warrior then
		return WTowerModel.instance:getCurFormation()
	else
		return (PetHireModel.instance:getFormationMoByFormId(PetHireModel.ID_TYPE_NORMAL))
	end
end

WTowerModel.instance = WTowerModel.New()

return WTowerModel
