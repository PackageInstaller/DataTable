-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/controller/KunWuController.lua

module("logic.extensions.kunwu.controller.KunWuController", package.seeall)

local KunWuController = class("KunWuController", BaseController)

KunWuController.instance = KunWuController.New()

function KunWuController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function KunWuController:getActivityType()
	return GameEnum.ActivityType.KunWu
end

function KunWuController:getSkinId(activityId)
	return KunWuConfig.instance:getSkinId(activityId)
end

function KunWuController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function KunWuController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function KunWuController:sendPM_KunWuClgGetInfoReq(activityId)
	KunWuAgent.instance:sendPM_KunWuClgGetInfoReq(activityId)
end

function KunWuController:handlePM_KunWuClgGetInfoRes(msg)
	KunWuModel.instance:handlePM_KunWuClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_KunWuClgGetInfoRes)
end

function KunWuController:sendPM_KunWuNormalFightReq(activityId, teamIndex, form)
	KunWuAgent.instance:sendPM_KunWuNormalFightReq(activityId, teamIndex, form)
end

function KunWuController:handlePM_NotifyKunWuNormalFightEndRes(msg)
	KunWuModel.instance:handlePM_NotifyKunWuNormalFightEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyKunWuNormalFightEndRes)
end

function KunWuController:sendPM_KunWuClgGainProgressPrizeReq(activityId, dataBitId)
	KunWuAgent.instance:sendPM_KunWuClgGainProgressPrizeReq(activityId, dataBitId)
end

function KunWuController:handlePM_KunWuClgGainProgressPrizeRes(msg)
	KunWuModel.instance:handlePM_KunWuClgGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_KunWuClgGainProgressPrizeRes)
end

function KunWuController:sendPM_KunWuExtremeFightReq(activityId, phaseId, stageId, form)
	KunWuAgent.instance:sendPM_KunWuExtremeFightReq(activityId, phaseId, stageId, form)
end

function KunWuController:handlePM_NotifyKunWuExtremeFightEndRes(msg)
	KunWuModel.instance:handlePM_NotifyKunWuExtremeFightEndRes(msg)

	if msg.win then
		BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEndExt, self, msg.activityId, msg.curFightPhaseId, msg.curFightStageId, msg.curFightValue, msg.confirmNum))
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyKunWuExtremeFightEndRes)
end

function KunWuController:sendPM_KunWuClgConfirmReq(activityId, confirmNum, save)
	KunWuAgent.instance:sendPM_KunWuClgConfirmReq(activityId, confirmNum, save)
end

function KunWuController:handlePM_KunWuClgConfirmRes(msg)
	KunWuModel.instance:handlePM_KunWuClgConfirmRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_KunWuClgConfirmRes)
end

function KunWuController:sendPM_KunWuResetExtremeClgPhaseReq(activityId, phaseId)
	KunWuAgent.instance:sendPM_KunWuResetExtremeClgPhaseReq(activityId, phaseId)
end

function KunWuController:handlePM_KunWuResetExtremeClgPhaseRes(msg)
	KunWuModel.instance:handlePM_KunWuResetExtremeClgPhaseRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_KunWuResetExtremeClgPhaseRes)
end

function KunWuController:enterNorBattleClg(activityId, groupId, creepIdx)
	local customNorFmtMo = KunWuModel.instance:getNorFmtMo(activityId)

	customNorFmtMo:updateCfg(activityId, groupId, creepIdx)
	CustomFmtController.instance:showMissionView(customNorFmtMo)
end

function KunWuController:enterExtBattleClg(activityId, phase, stageId)
	local customExtFmtMo = KunWuModel.instance:getExtFmtMo(activityId)

	customExtFmtMo:updateCfg(activityId, phase, stageId)
	CustomFmtController.instance:showMissionView(customExtFmtMo)
end

function KunWuController:_onResFightEndExt(activityId, phase, stageId, score, confirmNum)
	local canPass = KunWuModel.instance:canPassedPhase(activityId, phase, stageId, score)

	if canPass then
		TipsFacade.instance:openTipWindowNoX("提示", "本层通过条件已达成！", function()
			self:sendPM_KunWuClgConfirmReq(activityId, confirmNum, true)
			BattleController.instance:endBattle()
		end, "确定")
	else
		UIStateManager.instance:push(ViewName.KunWuExtTipView, activityId, phase, score)
	end

	return true
end

function KunWuController:isPassNor(activityId)
	local curNorProgress = KunWuModel.instance:getCurNorProgress(activityId)
	local cfgProgress = KunWuConfig.instance:getNorTotalProgress(activityId)

	return cfgProgress <= curNorProgress
end

function KunWuController:isCanGetNorPrizeInAll(activityId)
	local result = false
	local cfg = KunWuConfig.instance:getKunWuNorProgressData(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isCanGetNorPrize(activityId, data.dataBitId) then
				result = true

				break
			end
		end
	end

	return result
end

function KunWuController:isCanGetNorPrize(activityId, dataBitId)
	return not self:isHasGainNorPrize(activityId, dataBitId) and self:isEnoughGetNorPrize(activityId, dataBitId)
end

function KunWuController:isHasGainNorPrize(activityId, dataBitId)
	local info = KunWuModel.instance:getInfo(activityId)

	if info.normalClgGainedDataBitId then
		return table.indexof(info.normalClgGainedDataBitId, dataBitId) ~= false
	end

	return false
end

function KunWuController:isEnoughGetNorPrize(activityId, dataBitId)
	local data = KunWuConfig.instance:getKunWuNorProgressDataById(activityId, dataBitId)

	if data then
		if not data.progress then
			local progress = 0
			local info = KunWuModel.instance:getInfo(activityId)

			if info then
				if not info.normalClgProgress then
					local cur = 0

					return progress <= cur
				end
			end
		end
	end
end

return KunWuController
