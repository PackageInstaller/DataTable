-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/controller/OriginJiuController.lua

module("logic.extensions.originjiu.controller.OriginJiuController", package.seeall)

local OriginJiuController = class("OriginJiuController", BaseController)

function OriginJiuController:onInit()
	self:onReset()
end

function OriginJiuController:onReset()
	return
end

function OriginJiuController:sendGetInfo(activityId)
	OriginJiuClgAgent.instance:sendPM_OriginJiuClgInfoReq(activityId)
end

function OriginJiuController:onGetInfo(msg)
	OriginJiuModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_JIU_INFO_UPDATE)
end

function OriginJiuController:sendPM_OriginJiuClgChallengeReq(activityId, modelId, phaseId, stageId, stageRoad, simpleForm)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local stageClgType = OriginJiuModel.instance:getStageClgType(activityId, modelId, phaseId)

		if stageClgType == OriginJiuModel.ClgType_Wheel then
			local msg = OriginJiuModel.instance:getFightResultMsg()

			if msg and msg.isWin then
				result = true

				UIStateManager.instance:push(ViewName.OriginJiuBattleResultLockHpView, msg)
			end
		elseif stageClgType == OriginJiuModel.ClgType_LockPet then
			local msg = OriginJiuModel.instance:getFightResultMsg()

			if msg and msg.isWin then
				result = true

				UIStateManager.instance:push(ViewName.OriginJiuBattleResultLockPetView, msg)
			end
		end

		return result
	end)
	OriginJiuClgAgent.instance:sendPM_OriginJiuClgChallengeReq(activityId, modelId, phaseId, stageId, stageRoad, simpleForm)
end

function OriginJiuController:handlePM_NotifyOriginJiuClgChallengeFinishRes(msg)
	OriginJiuModel.instance:handlePM_NotifyOriginJiuClgChallengeFinishRes(msg)

	local stageType = OriginJiuModel.instance:getStageClgType(msg.activityId, msg.modelId, msg.phaseId)

	if stageType == OriginJiuModel.ClgType_Wheel then
		local wheelBattleResult = msg.wheelBattleResult

		if wheelBattleResult and #wheelBattleResult > 0 then
			BattleController.instance:viewUserFightMonsterBtlResultWithList(msg.wheelBattleResult)
		else
			printError(string.format("错误wheelBattleResult，是车轮战关卡但缺失连续战斗数据 -> activityId: %s, modelId: %s, phaseId: %s, stageId: %s, stageRoad: %s", msg.activityId, msg.modelId, msg.phaseId, msg.stageId, msg.stageRoad))
		end
	end
end

function OriginJiuController:sendPM_OriginJiuClgPhaseResetReq(activityId, modelId, phaseId)
	OriginJiuClgAgent.instance:sendPM_OriginJiuClgPhaseResetReq(activityId, modelId, phaseId)
end

function OriginJiuController:handlePM_OriginJiuClgPhaseResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_JIU_RESET)
end

function OriginJiuController:sendPM_OriginJiuClgResetReq(activityId, modelId)
	OriginJiuClgAgent:sendPM_OriginJiuClgResetReq(activityId, modelId)
end

function OriginJiuController:handlePM_OriginJiuClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_JIU_RESET)
end

function OriginJiuController:enterStageBattleWithCommon(activityId, modelId, phaseId, stageId, stageRoad)
	local fmtMo = OriginJiuModel.instance:getCommonFmtMo(activityId)

	fmtMo:initParams(activityId, modelId, phaseId, stageId, stageRoad)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginJiuController:enterStageBattleWithTab(activityId, modelId, phaseId, stageId, stageRoad)
	local fmtMo = OriginJiuModel.instance:getTabFmtMo(activityId)

	fmtMo:initParams(activityId, modelId, phaseId, stageId, stageRoad)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginJiuController:enterBossBattle(activityId, modelId)
	local fmtMo = OriginJiuModel.instance:getBossFmtMo(activityId)

	fmtMo:initParams(activityId, modelId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

OriginJiuController.instance = OriginJiuController.New()

return OriginJiuController
