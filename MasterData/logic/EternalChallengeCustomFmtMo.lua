-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/model/EternalChallengeCustomFmtMo.lua

module("logic.extensions.eternalchallenge.model.EternalChallengeCustomFmtMo", package.seeall)

local EternalChallengeCustomFmtMo = class("EternalChallengeCustomFmtMo", ICustomFmtMo)

function EternalChallengeCustomFmtMo:onReset()
	EternalChallengeCustomFmtMo.super.onReset(self)
end

function EternalChallengeCustomFmtMo:updateCfg(activityId)
	self._activityId = activityId
	self._ecActData = EternalChallengeConfig.instance:getEcActData(self._activityId)
	self._creepsMasterId = self._ecActData.creepsMasterId
	self._masterData = EternalChallengeConfig.instance:getEcMasterData(self._creepsMasterId)
	self._creepsDataList = EternalChallengeConfig.instance:getECreepsDataList(self._creepsMasterId)
end

function EternalChallengeCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.WinDesc
	self.validatorDescStr = self._masterData.missionDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isShowBtnCutePet = false

	self:initPetList()
end

function EternalChallengeCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		EternalChallengeController.instance:sendPM_EternalChallengeFightReq(self._activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function EternalChallengeCustomFmtMo:initPetList()
	self:clearAllPetList()

	local raceIdList = EternalChallengeController.instance:getRaceIdList(self._activityId)

	for _, raceId in ipairs(raceIdList) do
		if EternalChallengeController.instance:getPetCanFmt(self._activityId, raceId) then
			local petMo = EternalChallengeController.instance:getPetMo(self._activityId, raceId)

			self:addPetToList(petMo)
		end
	end
end

function EternalChallengeCustomFmtMo:getMonsterConfigList()
	return self._creepsDataList
end

function EternalChallengeCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function EternalChallengeCustomFmtMo:onClickCloseBtn(handler)
	EternalChallengeCustomFmtMo.super.onClickCloseBtn(self, handler)
	UIJumper.instance:clear()
end

return EternalChallengeCustomFmtMo
