-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/model/TunTianNorClgCustomFmtMo.lua

module("logic.extensions.tuntianchallenge.model.TunTianNorClgCustomFmtMo", package.seeall)

local TunTianNorClgCustomFmtMo = class("TunTianNorClgCustomFmtMo", ICustomFmtMo)

function TunTianNorClgCustomFmtMo:onReset()
	TunTianNorClgCustomFmtMo.super.onReset(self)
end

function TunTianNorClgCustomFmtMo:updateCfg(activityId, slotId, monsterId)
	self._activityId = activityId
	self._slotId = slotId
	self._monsterId = monsterId
	self._masterData = TunTianChallengeConfig.instance:getTtMasterData(self._monsterId)
	self._creepsCfg = TunTianChallengeConfig.instance:getTtCreepsDataList(self._monsterId)
end

function TunTianNorClgCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isHideFmtZdl = true
end

function TunTianNorClgCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		TunTianChallengeController.instance:sendPM_TunTianNormalClgFightReq(self._activityId, self._slotId, self._monsterId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function TunTianNorClgCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function TunTianNorClgCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function TunTianNorClgCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function TunTianNorClgCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return TunTianNorClgCustomFmtMo
