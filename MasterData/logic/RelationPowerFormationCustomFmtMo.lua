-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/relationpower/model/RelationPowerFormationCustomFmtMo.lua

module("logic.extensions.relationpower.model.RelationPowerFormationCustomFmtMo", package.seeall)

local RelationPowerFormationCustomFmtMo = class("RelationPowerFormationCustomFmtMo", ICustomFmtMo)

function RelationPowerFormationCustomFmtMo:onReset()
	RelationPowerFormationCustomFmtMo.super.onReset(self)
end

function RelationPowerFormationCustomFmtMo:updateCfg(activityId, formId)
	self._activityId = checknumber(activityId)
	self._verifyFromId = checknumber(formId)
	self._verifyData = RelationPowerConfig.instance:getFormCfgByFormId(self._activityId, self._verifyFromId)
	self._raceIdList = TableUtil.deepcopy(self._verifyData.raceIds)
end

function RelationPowerFormationCustomFmtMo:updateData()
	self.needUpPetCount = Mathf.Max(#self._raceIdList, 5)
	self.isShowBtnFormation = false
	self.isShowBtnBuffForm = false
	self.isShowClean = false
	self.isShowNegoRight = false

	self:initPetList()
	self:updateFixedPos()
end

function RelationPowerFormationCustomFmtMo:getActivityId()
	return self._activityId
end

function RelationPowerFormationCustomFmtMo:getVerifyFormId()
	return self._verifyFromId
end

function RelationPowerFormationCustomFmtMo:getRaceIdList()
	return self._raceIdList
end

function RelationPowerFormationCustomFmtMo:isUpFmt(raceId)
	local petMo = self:getPetMoInFmtByRaceId(raceId)

	return petMo ~= nil
end

function RelationPowerFormationCustomFmtMo:getPetZdlInFmtByRaceId(raceId)
	local petMo = self:getPetMoInFmtByRaceId(raceId)

	return (petMo or nil) and petMo:getFightingPower()
end

function RelationPowerFormationCustomFmtMo:getPetZdlInListByRaceId(raceId)
	local petMo = self:getPetMoInListByRaceId(raceId)

	return (petMo or nil) and petMo:getFightingPower()
end

function RelationPowerFormationCustomFmtMo:getPetMoInFmtByRaceId(raceId)
	local fmtMo = self:getCurFormation()

	for posId, petId in ipairs(fmtMo:GetPositions()) do
		local petMo = fmtMo:_getPet(petId)

		if petMo and petMo:getDefineId() == raceId then
			return petMo
		end
	end

	return nil
end

function RelationPowerFormationCustomFmtMo:getPetMoInListByRaceId(raceId)
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

function RelationPowerFormationCustomFmtMo:updateFixedPos()
	local fmtMo = self:getCurFormation()
	local posIdList = {}

	for posId, petId in ipairs(fmtMo:GetPositions()) do
		if petId > 0 then
			table.insert(posIdList, posId)
		end
	end

	MissionModel.instance:setFixedPos(posIdList)
end

function RelationPowerFormationCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagModel.instance:getBagPets()
	local petMoMap = {}
	local raceId = 0

	for _, petMo in ipairs(pets) do
		raceId = petMo:getDefineId()

		if table.indexof(self._raceIdList, raceId) ~= false then
			if petMoMap[raceId] then
				if petMo:getFightingPower() > petMoMap[raceId]:getFightingPower() then
					petMoMap[raceId] = petMo
				end
			else
				petMoMap[raceId] = petMo
			end
		end
	end

	self:refreshPetList(petMoMap)
end

function RelationPowerFormationCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		local mo = petMo:GetClone()

		mo.attrMo:resetPublicAttr()
		mo.attrMo:calcBaseAttrs(mo)
		mo.attrMo:calcEquipmentAttr(mo)
		mo.attrMo:calcPetRelationAttr(mo)
		mo:calcStarGodPlusAttr(true)
		mo:calcHolyStripesAttr(true)
		mo:refreshAllAttr()
		self:updatePetMo(mo)
	end
end

function RelationPowerFormationCustomFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtVerifyReq, self)
end

function RelationPowerFormationCustomFmtMo:fmtVerifyReq()
	if self:isEmptyFmt() then
		return
	end

	local simpleForm = self:getCurSimpleForm()

	RelationPowerController.instance:verifyPower(self._activityId, self._verifyFromId, simpleForm)
end

function RelationPowerFormationCustomFmtMo:getFormationExtendViewName()
	return ViewName.RelationPowerFormationExView
end

function RelationPowerFormationCustomFmtMo:onFmoSetDown()
	self:updateFixedPos()
	GlobalDispatcher:dispatch(GlobalNotify.RelationPowerFmtUpdateVerify)
end

function RelationPowerFormationCustomFmtMo:getFinalFmoList(posList, petPool, needPets)
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

function RelationPowerFormationCustomFmtMo:autoCloneFormation()
	return
end

function RelationPowerFormationCustomFmtMo:GetFormStrengthIdAndLv()
	return 0, 0
end

function RelationPowerFormationCustomFmtMo:getFmtPowerByParams(team, heroSkill, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, summonMasterId, summonPetId)
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

function RelationPowerFormationCustomFmtMo:isEmptyFmt()
	return self:getCurFormation():isEmpty()
end

return RelationPowerFormationCustomFmtMo
