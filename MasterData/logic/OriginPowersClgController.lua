-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/controller/OriginPowersClgController.lua

module("logic.extensions.originpowersclg.controller.OriginPowersClgController", package.seeall)

local OriginPowersClgController = class("OriginPowersClgController", BaseController)

function OriginPowersClgController:onInit()
	self:onReset()
end

function OriginPowersClgController:onReset()
	return
end

function OriginPowersClgController:openNormalMissionView(activityId, index)
	local fmtMo = OriginPowersClgModel.instance:getNormalFmtMo()
	local day = 1

	fmtMo:initParams(activityId, day, index)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginPowersClgController:openExtermeMissionView(activityId, stageId)
	local fmtMo = OriginPowersClgModel.instance:getExtermeFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginPowersClgController:handlePM_OriginPowersExtremeInfoRes(msg)
	OriginPowersClgModel.instance:saveExtremeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginPowersInfoRes)
end

function OriginPowersClgController:handlePM_NotifyOriginPowersExtremeClgFinishRes(msg)
	if msg.isWin then
		OriginPowersClgModel.instance:saveExtBattleInfo(msg)
	end

	OriginPowersClgModel.instance:saveTempBattleResult(msg)
	BattleFacade.instance:registerResultHandler(self._openExteremeResult, self)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginPowersInfoRes)
end

function OriginPowersClgController:_openExteremeResult()
	if OriginPowersClgModel.instance:getTempBattleResult() ~= nil then
		ViewMgr.instance:open(ViewName.OriginPowersClgExtResultView)

		return true
	else
		return false
	end
end

function OriginPowersClgController:handlePM_OriginPowersExtremeResetRes(msg)
	OriginPowersClgModel.instance:resetExtStageInfo(msg.activityId, msg.stageId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginPowersInfoRes)
end

function OriginPowersClgController:handlePM_OriginPowersCommonInfoRes(msg)
	OriginPowersClgModel.instance:saveNormalInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginPowersInfoRes)
end

function OriginPowersClgController:handlePM_NotifyPM_OriginPowersCommonClgFinishRes(msg)
	if msg.isWin then
		OriginPowersClgModel.instance:saveNormalBattleInfo(msg)
		OriginPowersClgModel.instance:saveTempBattleResult(msg)
		BattleFacade.instance:registerResultHandler(self._openNormalResult, self)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginPowersInfoRes)
end

function OriginPowersClgController:_openNormalResult()
	if OriginPowersClgModel.instance:getTempBattleResult() ~= nil then
		ViewMgr.instance:open(ViewName.OriginPowersClgNormalResultView)

		return true
	else
		return false
	end
end

function OriginPowersClgController:handlePM_OriginPowersCommonGainPrizeRes(msg)
	OriginPowersClgModel.instance:savePrizeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginPowersInfoRes)
end

function OriginPowersClgController:getExtAllLockPetMap(activityId)
	local lockPetMap = {}
	local stageCfgs = OriginPowersClgConfig.instance:getExtremeStageCfgs(activityId)

	for i, v in ipairs(stageCfgs) do
		local stageInfo = OriginPowersClgModel.instance:getExtStageInfo(activityId, v.stageId)

		if stageInfo then
			for j, raceId in ipairs(stageInfo.lockPetRaceIds or {}) do
				lockPetMap[raceId] = true
			end
		end
	end

	return lockPetMap
end

function OriginPowersClgController:getNormalDay(activityId)
	return 1
end

OriginPowersClgController.instance = OriginPowersClgController.New()

return OriginPowersClgController
