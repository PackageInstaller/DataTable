-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/controller/XuChallengeController.lua

module("logic.extensions.xuchallenge.controller.XuChallengeController", package.seeall)

local XuChallengeController = class("XuChallengeController", BaseController)

function XuChallengeController:onInit()
	self:onReset()
end

function XuChallengeController:onReset()
	self._fmtMo = nil
end

function XuChallengeController:sendPM_XuChallengeInfoReq(activityId)
	XuAgent.instance:sendPM_XuChallengeInfoReq(activityId)
end

function XuChallengeController:handlePM_XuChallengeInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_XuChallengeInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_XuChallengeInfoRes, msg)
end

function XuChallengeController:sendPM_XuChallengeClgReq(activityId, stageId, stageToPetId, form)
	XuAgent.instance:sendPM_XuChallengeClgReq(activityId, stageId, stageToPetId, form)
end

function XuChallengeController:handlePM_XuChallengeClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_XuChallengeClgRes, msg)
end

function XuChallengeController:handlePM_XuChallengeNotifyClgRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_XuChallengeNotifyClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_XuChallengeNotifyClgRes, msg)
end

function XuChallengeController:sendPM_XuChallengeResetReq(activityId)
	XuAgent.instance:sendPM_XuChallengeResetReq(activityId)
end

function XuChallengeController:handlePM_XuChallengeResetRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_XuChallengeResetRes(msg)
	self:_clearFmtMoCache()
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_XuChallengeResetRes, msg)
end

function XuChallengeController:sendPM_XuChallengeReplacePetReq(activityId, stageToPetId)
	XuAgent.instance:sendPM_XuChallengeReplacePetReq(activityId, stageToPetId)
end

function XuChallengeController:handlePM_XuChallengeReplacePetRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_XuChallengeReplacePetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_XuChallengeReplacePetRes, msg)
end

function XuChallengeController:getSubMo(activityId)
	return XuChallengeModel.instance:getSubMo(activityId)
end

function XuChallengeController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function XuChallengeController:getActivityType()
	return GameEnum.ActivityType.XuChallenge
end

function XuChallengeController:enterBattle(activityId, stageId)
	local fmtMo = self:_getFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function XuChallengeController:_getFmtMo()
	self._fmtMo = self._fmtMo or XuChallengeFmtMo.New()

	return self._fmtMo
end

function XuChallengeController:_clearFmtMoCache()
	if self._fmtMo then
		self._fmtMo:clearChallengeCache()

		self._fmtMo = nil
	end
end

function XuChallengeController:isPetMoMatchStageValidator(activityId, stageId, petMo)
	if petMo == nil then
		return false
	end

	local petContext = PetExpressValidator.buildContextByPetMo(petMo)
	local raceId = petContext.raceId

	if raceId <= 0 then
		return false
	end

	return self:_isPetContextMatchStageValidator(activityId, stageId, petContext)
end

function XuChallengeController:checkPetMoCanSelectForStage(activityId, stageId, petMo, selectedStageToPetId, ignoreStageId)
	local reason = XuChallengeEnum.SelectPetFailReason

	if petMo == nil then
		return false, reason.EmptyPet
	end

	local raceId = petMo:getDefineId()

	if raceId <= 0 then
		return false, reason.EmptyPet
	end

	if not self:isPetMoMatchStageValidator(activityId, stageId, petMo) then
		return false, reason.ValidatorNotMatch
	end

	if self:_isRaceIdBoundInServer(activityId, raceId) then
		return false, reason.BoundRaceId
	end

	if self:_isRaceIdSacrificed(activityId, raceId) then
		return false, reason.SacrificedRaceId
	end

	if selectedStageToPetId == nil then
		selectedStageToPetId = self:getSubMo(activityId):getPreviewStageToRaceIds()
	end

	if self:_isRaceIdSelectedInStageData(selectedStageToPetId, raceId, ignoreStageId) then
		return false, reason.SelectedRaceId
	end

	return true, reason.None
end

function XuChallengeController:filterPetMoListForStage(activityId, stageId, petMoList, selectedStageToPetId, ignoreStageId)
	local result = {}

	for _, petMo in ipairs(petMoList or {}) do
		local isCanSelect = self:checkPetMoCanSelectForStage(activityId, stageId, petMo, selectedStageToPetId, ignoreStageId)

		if isCanSelect then
			table.insert(result, petMo)
		end
	end

	return result
end

function XuChallengeController:_isPetContextMatchStageValidator(activityId, stageId, petContext)
	local stageData = XuChallengeConfig.instance:getStageData(activityId, stageId)
	local validator = stageData and stageData.petValidator

	if validator == nil or validator == "" then
		return true
	end

	return PetExpressValidator.match(validator, petContext)
end

function XuChallengeController:_isRaceIdBoundInServer(activityId, raceId)
	raceId = checknumber(raceId)

	if raceId <= 0 then
		return false
	end

	local subMo = self:getSubMo(activityId)

	for _, stageId in ipairs(subMo:getStageIds() or {}) do
		if subMo:getBindRaceId(stageId) == raceId then
			return true
		end

		local petId = checknumber(subMo:getServerPetIdByStageId(stageId))
		local petMo

		if petId > 0 then
			petMo = BagPetsController.instance:getPet(petId)
		end

		if petMo ~= nil and petMo:getDefineId() == raceId then
			return true
		end
	end

	return false
end

function XuChallengeController:_isRaceIdSacrificed(activityId, raceId)
	raceId = checknumber(raceId)

	if raceId <= 0 then
		return false
	end

	local subMo = self:getSubMo(activityId)

	for _, stageId in ipairs(subMo:getStageIds() or {}) do
		for _, sacrificeRaceId in ipairs(subMo:getSacrificeRaceIds(stageId) or {}) do
			if checknumber(sacrificeRaceId) == raceId then
				return true
			end
		end
	end

	return false
end

function XuChallengeController:_isRaceIdSelectedInStageData(stageDataList, raceId, ignoreStageId)
	raceId = checknumber(raceId)
	ignoreStageId = checknumber(ignoreStageId)

	if raceId <= 0 then
		return false
	end

	for _, data in ipairs(stageDataList or {}) do
		local stageId = checknumber((not data.stageId or nil) and data.left)

		if stageId ~= ignoreStageId then
			local selectedRaceId = checknumber(data.raceId)

			if selectedRaceId <= 0 then
				local petId = checknumber((not data.petId or nil) and data.right)
				local petMo

				if petId > 0 then
					petMo = BagPetsController.instance:getPet(petId)
				end

				selectedRaceId = petMo and petMo:getDefineId() or 0
			end

			if selectedRaceId == raceId then
				return true
			end
		end
	end

	return false
end

XuChallengeController.instance = XuChallengeController.New()

return XuChallengeController
