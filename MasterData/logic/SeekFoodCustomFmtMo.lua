-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/model/SeekFoodCustomFmtMo.lua

module("logic.extensions.seekfood.model.SeekFoodCustomFmtMo", package.seeall)

local SeekFoodCustomFmtMo = class("SeekFoodCustomFmtMo", ICustomFmtMo)

function SeekFoodCustomFmtMo:onReset()
	SeekFoodCustomFmtMo.super.onReset(self)
end

function SeekFoodCustomFmtMo:updateCfg(activityId, foodId)
	self._activityId = checknumber(activityId)
	self._foodId = checknumber(foodId)
	self._foodData = SeekFoodConfig.instance:getSfFoodData(self._activityId, self._foodId)
	self._masterData = SeekFoodConfig.instance:getSfMasterData(self._foodData.creepsMasterId)
	self._creepsCfg = SeekFoodConfig.instance:getSfCreepsCfg(self._foodData.creepsMasterId)
end

function SeekFoodCustomFmtMo:updateData()
	if not string.nilorempty(self._masterData.name) then
		self.topTitleStr = self._masterData.name
	end

	if not string.nilorempty(self._masterData.WinDesc) then
		self.ruleDescStr = self._masterData.WinDesc
	end

	if not string.nilorempty(self._masterData.missionDesc) then
		self.validatorDescStr = self._masterData.missionDesc
	end

	if checknumber(self._masterData.formCondition) > 0 then
		self:setFormCondition(self._masterData.formCondition)
	end
end

function SeekFoodCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		SeekFoodController.instance:sendPM_SeekFoodFightBossReq(self._activityId, self._foodId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function SeekFoodCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	self:refreshPetList(pets)
end

function SeekFoodCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function SeekFoodCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function SeekFoodCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return SeekFoodCustomFmtMo
