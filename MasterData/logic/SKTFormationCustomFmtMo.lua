-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/model/SKTFormationCustomFmtMo.lua

module("logic.extensions.saintknighttask.model.SKTFormationCustomFmtMo", package.seeall)

local SKTFormationCustomFmtMo = class("SKTFormationCustomFmtMo", BaseCustomFmtMo)

function SKTFormationCustomFmtMo:updateCfg(activityId)
	self._activityId = checknumber(activityId)
	self._verifyData = SaintKnightTaskConfig.instance:getSktVerifyData(self._activityId)
	self._raceIdList = TableUtil.deepcopy(self._verifyData.raceIds)
	self._raceIdMaps = {}

	for _, v in ipairs(self._raceIdList) do
		self._raceIdMaps[v] = v
	end

	self.needUpPetCount = Mathf.Max(#self._raceIdList, 5)
	self.isShowBtnFormation = false
	self.isShowBtnBuffForm = false
	self.isShowClean = false
	self.isShowNegoRight = false
	self.isOnlyUpdateExistPet = false

	self:initPetList()
	self:updateFixedPos()
end

function SKTFormationCustomFmtMo:getActivityId()
	return self._activityId
end

function SKTFormationCustomFmtMo:getRaceIdList()
	return self._raceIdList
end

function SKTFormationCustomFmtMo:isUpFmt(raceId)
	local petMo = self:getPetMoInFmtByRaceId(raceId)

	return petMo ~= nil
end

function SKTFormationCustomFmtMo:getPetZdlInFmtByRaceId(raceId)
	local petMo = self:getPetMoInFmtByRaceId(raceId)

	return (petMo or nil) and petMo:getFightingPower()
end

function SKTFormationCustomFmtMo:getPetZdlInListByRaceId(raceId)
	local petMo = self:getPetMoInListByRaceId(raceId)

	return (petMo or nil) and petMo:getFightingPower()
end

function SKTFormationCustomFmtMo:getPetMoInFmtByRaceId(raceId)
	local fmtMo = self:getCurFormation()

	for posId, petId in ipairs(fmtMo:GetPositions()) do
		local petMo = fmtMo:_getPet(petId)

		if petMo and petMo:getDefineId() == raceId then
			return petMo
		end
	end

	return nil
end

function SKTFormationCustomFmtMo:getPetMoInListByRaceId(raceId)
	local petMo

	if self._rightPetList then
		for _, petMo in ipairs(self._rightPetList) do
			if petMo:getDefineId() == raceId then
				return petMo
			end
		end
	end

	return petMo
end

function SKTFormationCustomFmtMo:updateFixedPos()
	local fmtMo = self:getCurFormation()
	local posIdList = {}

	for posId, petId in ipairs(fmtMo:GetPositions()) do
		if petId > 0 then
			table.insert(posIdList, posId)
		end
	end

	MissionModel.instance:setFixedPos(posIdList)
end

function SKTFormationCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getBagPets()
	local petMoMap = {}
	local raceId = 0

	for _, petMo in ipairs(pets) do
		raceId = petMo:getDefineId()

		if self._raceIdMaps[raceId] and (petMoMap[raceId] == nil or petMo:getFightingPower() > petMoMap[raceId]:getFightingPower()) then
			petMoMap[raceId] = petMo
		end
	end

	for raceId, petMo in pairs(petMoMap) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function SKTFormationCustomFmtMo:refreshPetList(changePetMoMap)
	local map = {}

	for _, petMo in pairs(changePetMoMap) do
		local raceId = petMo:getDefineId()

		if self._raceIdMaps[raceId] and petMo:isBagPet() then
			map[petMo:getPetId()] = petMo
		end
	end

	SKTFormationCustomFmtMo.super.refreshPetList(self, map)
end

function SKTFormationCustomFmtMo:_changePetMo(petMo)
	if self._verifyData.excludePublicStrengthens then
		local mo = petMo:GetClone()

		mo.attrMo:resetPublicAttr()
		mo.attrMo:calcBaseAttrs(mo)
		mo.attrMo:calcEquipmentAttr(mo)
		mo.attrMo:calcPetRelationAttr(mo)
		mo:calcStarGodPlusAttr(true)
		mo:calcHolyStripesAttr(true)
		mo:refreshAllAttr()

		petMo = mo
	end

	return petMo
end

function SKTFormationCustomFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtVerifyReq, self)
end

function SKTFormationCustomFmtMo:fmtVerifyReq()
	if self:isEmptyFmt() then
		return
	end

	local simpleForm = self:getCurSimpleForm()

	SaintKnightTaskController.instance:sendSKVerifyFormZdlReq(self._activityId, simpleForm)
end

function SKTFormationCustomFmtMo:getFormationExtendViewName()
	return ViewName.SKTVerifyFormationExView
end

function SKTFormationCustomFmtMo:onFmoSetDown()
	self:updateFixedPos()
	GlobalDispatcher:dispatch(GlobalNotify.SKTaskWorldTasksVerifyFmtUpdate)
end

function SKTFormationCustomFmtMo:getFinalFmoList(posList, petPool, needPets)
	if self.needUpPetCount > 5 then
		posList, petPool = CustomFmtController.instance:extraPetAtFormation(self.needUpPetCount, needPets, petPool, posList, self:getCurFormation())
	end

	local petNum = 0

	for _, v in pairs(petPool) do
		if v:getPetId() > 0 then
			petNum = petNum + 1
		end
	end

	if petNum <= 0 then
		FloatWordMgr.instance:show("暂无精灵可上阵")
	end

	return posList, petPool
end

function SKTFormationCustomFmtMo:autoCloneFormation()
	self:revertLastFormation()
end

function SKTFormationCustomFmtMo:GetFormStrengthIdAndLv()
	return 0, 0
end

function SKTFormationCustomFmtMo:getFmtPowerByParams(team, heroSkill, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, summonMasterId, summonPetId)
	local zdl = 0
	local fmtMo = self:getCurFormation()
	local posList = fmtMo:GetPositions()

	for i, petId in ipairs(posList) do
		local petMo = fmtMo:_getPet(petId)

		if petMo then
			zdl = zdl + petMo:getFightingPower()
		end
	end

	return zdl
end

function SKTFormationCustomFmtMo:isEmptyFmt()
	return self:getCurFormation():isEmpty()
end

return SKTFormationCustomFmtMo
