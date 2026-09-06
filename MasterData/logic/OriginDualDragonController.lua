-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/controller/OriginDualDragonController.lua

module("logic.extensions.origindualdragon.controller.OriginDualDragonController", package.seeall)

local OriginDualDragonController = class("OriginDualDragonController", BaseController)
local STAGE_TYPE_KINDNESS = 1
local STAGE_TYPE_EVIL = 2

function OriginDualDragonController:onInit()
	self:onReset()
end

function OriginDualDragonController:onReset()
	self._activityInfo = {}
	self._kindnessStageInfoMaps = {}
end

function OriginDualDragonController:sendInfoReq(activityId)
	OriginDualDragonAgent.instance:sendPM_OriginDualDragonInfoReq(activityId)
end

function OriginDualDragonController:challenge(activityId, stageType, stageId, form, fmtMo)
	OriginDualDragonModel.instance:saveChallengeContext(activityId, stageType, stageId, self:_buildChallengeRaceIdList(fmtMo))
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		if checkbool(OriginDualDragonModel.instance:getTempChallengeResult().isWin) then
			UIStateManager.instance:push(ViewName.OriginDualDragonResultView)

			return true
		end

		return false
	end)
	OriginDualDragonAgent.instance:sendPM_OriginDualDragonChallengeReq(activityId, form, stageType, stageId)
end

function OriginDualDragonController:handlePM_OriginDualDragonInfoRes(msg)
	local kindnessMap = {}

	for _, stageInfo in ipairs(msg.kindNessStageInfo or {}) do
		kindnessMap[stageInfo.stageId] = {
			stageId = stageInfo.stageId,
			raceIdToHpRatio = stageInfo.raceIdToHpRatio
		}
	end

	self._kindnessStageInfoMaps[msg.activityId] = kindnessMap
	self._activityInfo[msg.activityId] = msg

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDualDragonInfoRes)
end

function OriginDualDragonController:handlePM_OriginDualDragonChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDualDragonChallengeRes, msg)
end

function OriginDualDragonController:handlePM_OriginDualDragonNotifyChallengeRes(msg)
	local activityId = msg.activityId

	if not self._activityInfo[activityId] then
		local info = {
			activityId = activityId
		}

		if checkbool(msg.isWin) and checknumber(msg.stageType) == STAGE_TYPE_KINDNESS then
			local var_8_1 = {
				stageId = msg.stageId
			}

			var_8_1.raceIdToHpRatio = msg.raceIdToHpRatio or {}
			var_8_1.maxHealRace = checknumber(msg.maxHealRace)
			var_8_1.maxDamageRace = checknumber(msg.maxDamageRace)
			var_8_1.minHpRace = checknumber(msg.minHpRace)

			local stageInfo = var_8_1

			if not self._kindnessStageInfoMaps[activityId] then
				local kindnessStageInfoMap = {}

				kindnessStageInfoMap[msg.stageId] = stageInfo
				self._kindnessStageInfoMaps[activityId] = kindnessStageInfoMap
			end
		elseif checkbool(msg.isWin) and checknumber(msg.stageType) == STAGE_TYPE_EVIL then
			info.maxPassStageId = math.max(checknumber(info.maxPassStageId), checknumber(msg.stageId))
		end

		self._activityInfo[activityId] = info

		OriginDualDragonModel.instance:saveTempChallengeResult(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDualDragonNotifyChallengeRes, msg)
	end
end

function OriginDualDragonController:handlePM_OriginDualDragonResetStageRes(msg)
	if OriginDualDragonModel.instance:isPendingReChallenge() then
		OriginDualDragonModel.instance:clearPendingReChallenge()

		local context = OriginDualDragonModel.instance:getChallengeContext() or {}

		self:openMissionView(msg.activityId, checknumber(context.stageType), msg.stageId, true)
		BattleController.instance:endBattle()

		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginDualDragonResetStageRes, msg)
end

function OriginDualDragonController:openMissionView(activityId, stageType, stageId, useJumper)
	local fmtMo = OriginDualDragonModel.instance:getFmtMo()

	fmtMo:initParams(activityId, checknumber(stageType), stageId)

	if useJumper then
		UIJumper.instance:pushOneStack(ViewName.CustomMissionView, false, fmtMo)
	else
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function OriginDualDragonController:confirmChallengeResult()
	local resultMsg = OriginDualDragonModel.instance:getTempChallengeResult()

	if resultMsg and resultMsg:HasField("changeSetId") then
		OriginDualDragonModel.instance:saveTempPrizeChangeSet(resultMsg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(resultMsg.changeSetId)
	end

	OriginDualDragonModel.instance:clearTempChallengeResult()
	BattleController.instance:endBattle()
end

function OriginDualDragonController:reChallenge()
	local context = OriginDualDragonModel.instance:getChallengeContext() or {}
	local isWin = checkbool(OriginDualDragonModel.instance:getTempChallengeResult().isWin)
	local stageType = checknumber(context.stageType)

	OriginDualDragonModel.instance:clearTempChallengeResult()

	if isWin then
		if stageType == STAGE_TYPE_KINDNESS then
			OriginDualDragonModel.instance:setPendingReChallenge(true)
			OriginDualDragonAgent.instance:sendPM_OriginDualDragonResetStageReq(context.activityId, context.stageId)
		else
			self:openMissionView(context.activityId, stageType, context.stageId, true)
			BattleController.instance:endBattle()
		end
	else
		self:openMissionView(context.activityId, stageType, context.stageId, true)
		BattleController.instance:endBattle()
	end
end

function OriginDualDragonController:_buildChallengeRaceIdList(fmtMo)
	local raceIdList = {}

	if not fmtMo then
		return raceIdList
	end

	local var_13_0 = ipairs
	local var_13_1 = fmtMo:getCurFormation():GetPositions()

	var_13_1 = var_13_1 or {}

	for _, petId in var_13_0(var_13_1) do
		petId = checknumber(petId)

		if petId > 0 then
			local petMo = fmtMo:getPetMoById(petId)

			if petMo then
				local raceId = checknumber(petMo.raceId)

				if raceId > 0 then
					table.insert(raceIdList, raceId)
				end
			end
		end
	end

	return raceIdList
end

function OriginDualDragonController:getInfo(activityId)
	return self._activityInfo[activityId]
end

function OriginDualDragonController:getMaxPassStageId(activityId)
	local info = self:getInfo(activityId)

	return info and checknumber(info.maxPassStageId) or 0
end

function OriginDualDragonController:hasGainPrize(activityId)
	local info = self:getInfo(activityId)

	return info and checkbool(info.hasGainPrize) or false
end

function OriginDualDragonController:getKindnessStageInfo(activityId, stageId)
	local kindnessStageInfoMap = self._kindnessStageInfoMaps[activityId]

	if kindnessStageInfoMap then
		return kindnessStageInfoMap[stageId]
	end
end

function OriginDualDragonController:isKindnessPassed(activityId, stageId)
	return self:getKindnessStageInfo(activityId, stageId) ~= nil
end

function OriginDualDragonController:isStagePassed(activityId, stageType, stageId)
	if checknumber(stageType) == STAGE_TYPE_KINDNESS then
		return self:isKindnessPassed(activityId, stageId)
	end

	return self:getMaxPassStageId(activityId) >= checknumber(stageId)
end

function OriginDualDragonController:isStageUnlocked(activityId, stageType, stageId)
	stageType = checknumber(stageType)
	stageId = checknumber(stageId)

	local maxPassStageId = self:getMaxPassStageId(activityId)

	if stageType == STAGE_TYPE_KINDNESS then
		return stageId <= maxPassStageId + 1
	end

	if stageId <= maxPassStageId then
		return true
	end

	return stageId == maxPassStageId + 1 and self:isKindnessPassed(activityId, stageId)
end

function OriginDualDragonController:getCurrentSelectableStage(activityId)
	local stageCfgs = OriginDualDragonConfig.instance:getStages(activityId) or {}

	if not stageCfgs[STAGE_TYPE_KINDNESS] then
		local kindnessStageCfgs = {}
		local maxPassStageId = self:getMaxPassStageId(activityId)

		for stageId, _ in ipairs(kindnessStageCfgs) do
			if not self:isKindnessPassed(activityId, stageId) then
				return STAGE_TYPE_KINDNESS, stageId
			end

			if maxPassStageId < stageId then
				return STAGE_TYPE_EVIL, stageId
			end
		end

		local lastStageId = #kindnessStageCfgs

		if lastStageId > 0 then
			return STAGE_TYPE_EVIL, lastStageId
		end

		return STAGE_TYPE_KINDNESS, 1
	end
end

OriginDualDragonController.instance = OriginDualDragonController.New()

return OriginDualDragonController
