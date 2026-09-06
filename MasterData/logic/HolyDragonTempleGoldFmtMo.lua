-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/model/HolyDragonTempleGoldFmtMo.lua

module("logic.extensions.holydragontemple.model.HolyDragonTempleGoldFmtMo", package.seeall)

local HolyDragonTempleGoldFmtMo = class("HolyDragonTempleGoldFmtMo", ICustomFmtMo)

function HolyDragonTempleGoldFmtMo:initParams(activityId, floorId, stageId)
	self._activityId = checknumber(activityId)
	self._floorId = checknumber(floorId)
	self._stageId = checknumber(stageId)
	self._stageData = HolyDragonTempleConfig.instance:getStageData(self._activityId, self._floorId, self._stageId)
	self._masterData = self._stageData and HolyDragonTempleConfig.instance:getMasterData(self._stageData.creepsMasterId) or nil
	self._creepsDatas = self._stageData and HolyDragonTempleConfig.instance:getCreepsDatas(self._stageData.creepsMasterId) or nil
end

function HolyDragonTempleGoldFmtMo:updateData()
	if self._masterData == nil then
		printError("HolyDragonTempleGoldFmtMo masterData is nil", self._activityId, self._floorId, self._stageId)

		return
	end

	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
	self:initPetList()
end

function HolyDragonTempleGoldFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		HolyDragonTempleController.instance:sendPM_HolyDragonTempleChallengeReq(self._activityId, simpleForm, self._floorId, self._stageId)
	end

	self:setFightHandler(handler, nil)
end

function HolyDragonTempleGoldFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList or {}) do
		self:addPetToList(petMo)
	end
end

function HolyDragonTempleGoldFmtMo:getMonsterConfigList()
	return self._creepsDatas
end

function HolyDragonTempleGoldFmtMo:getFmtInfoConfig()
	return self._masterData
end

function HolyDragonTempleGoldFmtMo:getActivityId()
	return self._activityId
end

function HolyDragonTempleGoldFmtMo:getFloorId()
	return self._floorId
end

function HolyDragonTempleGoldFmtMo:getStageId()
	return self._stageId
end

return HolyDragonTempleGoldFmtMo
