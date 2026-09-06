-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/controller/DivineTunTianController.lua

module("logic.extensions.divinetuntian.controller.DivineTunTianController", package.seeall)

local DivineTunTianController = class("DivineTunTianController", BaseController)

function DivineTunTianController:onInit()
	self:onReset()
end

function DivineTunTianController:onReset()
	self._petMap = nil
	self._petPowerMap = {}
end

function DivineTunTianController:sendPM_DivineTunTianClgGetInfoReq(activityId)
	DivineTunTianAgent.instance:sendPM_DivineTunTianClgGetInfoReq(activityId)
end

function DivineTunTianController:handlePM_DivineTunTianClgGetInfoRes(msg)
	DivineTunTianModel.instance:handlePM_DivineTunTianClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineTunTianClgGetInfoRes)
end

function DivineTunTianController:sendPM_DivineTunTianClgExtremeConfirmReq(activityId, stageId, confirm)
	DivineTunTianAgent.instance:sendPM_DivineTunTianClgExtremeConfirmReq(activityId, stageId, confirm)
end

function DivineTunTianController:handlePM_DivineTunTianClgExtremeConfirmRes(msg)
	if msg.changeSetId > 0 then
		DivineTunTianModel.instance:handlePM_DivineTunTianClgExtremeConfirmRes(msg)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineTunTianClgExtremeConfirmRes)
end

function DivineTunTianController:sendPM_DivineTunTianClgExtremeResetReq(activityId)
	DivineTunTianAgent.instance:sendPM_DivineTunTianClgExtremeResetReq(activityId)
end

function DivineTunTianController:handlePM_DivineTunTianClgExtremeResetRes(msg)
	DivineTunTianModel.instance:handlePM_DivineTunTianClgExtremeResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineTunTianClgExtremeResetRes)
end

function DivineTunTianController:sendPM_DivineTunTianClgGainNormalProgressPrizeReq(activityId, prizeId)
	DivineTunTianAgent.instance:sendPM_DivineTunTianClgGainNormalProgressPrizeReq(activityId, prizeId)
end

function DivineTunTianController:handlePM_DivineTunTianClgGainNormalProgressPrizeRes(msg)
	DivineTunTianModel.instance:handlePM_DivineTunTianClgGainNormalProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineTunTianClgGainNormalProgressPrizeRes)
end

function DivineTunTianController:handlePM_Notify_DivineTunTianClgExtremeChallengeResultRes(msg)
	DivineTunTianModel.instance:handlePM_Notify_DivineTunTianClgExtremeChallengeResultRes(msg)
end

function DivineTunTianController:sendPM_DivineTunTianClgNormalChallengeReq(activityId, index, form)
	DivineTunTianAgent.instance:sendPM_DivineTunTianClgNormalChallengeReq(activityId, index, form)
end

function DivineTunTianController:sendPM_DivineTunTianClgExtremeChallengeReq(activityId, stageId, form)
	DivineTunTianAgent.instance:sendPM_DivineTunTianClgExtremeChallengeReq(activityId, stageId, form)
end

function DivineTunTianController:handlePM_Notify_DivineTunTianClgExtremeChallengeResultRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResExtFightEnd, self, msg))
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_DivineTunTianClgExtremeChallengeResultRes)
end

function DivineTunTianController:_onResExtFightEnd(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(ViewName.DivineTunTianExtFightendView, msg)

	return true
end

function DivineTunTianController:enterExtBattleClg(activityId, stageId)
	local customFmtMo = DivineTunTianModel.instance:getExtFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineTunTianController:enterNorBattleClg(activityId, day, index)
	local customFmtMo = DivineTunTianModel.instance:getNorFmtMo(activityId)

	customFmtMo:updateCfg(activityId, day, index)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineTunTianController:handlePM_Notify_DivineTunTianClgNormalChallengeResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_DivineTunTianClgNormalChallengeResultRes)
end

function DivineTunTianController:getTotalPower(activityId)
	local info = DivineTunTianModel.instance:getInfo(activityId)
	local totalPower = 0

	for k, curStageInfo in pairs((info or nil) and info.extremeStageInfoMap) do
		local getPassPower = DivineTunTianModel.instance:getPassPower(activityId, curStageInfo.stageId)
		local power = curStageInfo.score + getPassPower

		totalPower = totalPower + power
	end

	return totalPower
end

function DivineTunTianController:getExtCurActivateBuffIdx(activityId)
	local actCfg = DivineTunTianConfig.instance:getActCfg(activityId)
	local buffPlanId = actCfg.extremeBuffPlanId
	local buffCfgs = DivineTunTianConfig.instance:getBuffCfgs(buffPlanId)
	local totalPower = self:getTotalPower(activityId)
	local maxIdx = #buffCfgs

	for i, cfg in ipairs(buffCfgs) do
		local powerArr = string.split(cfg.powerArrDesc, "-")
		local hasActivate = totalPower >= checknumber(powerArr[1]) and totalPower <= cfg.progress

		if hasActivate then
			return i
		end
	end

	return maxIdx
end

function DivineTunTianController:getNorCurActivateBuffIdx(activityId)
	local actCfg = DivineTunTianConfig.instance:getActCfg(activityId)
	local buffPlanId = actCfg.normalBuffPlanId
	local buffCfgs = DivineTunTianConfig.instance:getBuffCfgs(buffPlanId)
	local totalPower = DivineTunTianModel.instance:getAllNorScores(activityId)
	local maxIdx = #buffCfgs

	for i, cfg in ipairs(buffCfgs) do
		local powerArr = string.split(cfg.powerArrDesc, "-")
		local hasActivate = totalPower >= checknumber(powerArr[1]) and totalPower <= cfg.progress

		if hasActivate then
			return i
		end
	end

	return maxIdx
end

function DivineTunTianController:calcPlayerPet()
	if self._petMap == nil then
		self._petMap = {}

		local pets = BagModel.instance:getPets()

		for _, pet in pairs(pets) do
			local maxPower = checknumber(self._petPowerMap[pet.raceId])
			local curPower = pet:getFightingPower()

			if maxPower <= curPower then
				self._petPowerMap[pet.raceId] = curPower
				self._petMap[pet.raceId] = pet
			end
		end
	end
end

function DivineTunTianController:getMaxFightPowerPetIdByRaceId(raceId)
	return self._petMap[raceId]
end

DivineTunTianController.instance = DivineTunTianController.New()

return DivineTunTianController
