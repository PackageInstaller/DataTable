-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/controller/DivineFarnasController.lua

module("logic.extensions.divineeternaldragonclg.controller.DivineFarnasController", package.seeall)

local DivineFarnasController = class("DivineFarnasController", BaseController)

DivineFarnasController.EXT_TYPE_HUIMIE = 1
DivineFarnasController.EXT_TYPE_XINSHENG = 2

function DivineFarnasController:ctor()
	return
end

function DivineFarnasController:onInit()
	self:onReset()
end

function DivineFarnasController:onReset()
	return
end

function DivineFarnasController:sendPM_DivineFarnasClgGetInfoReq(activityId)
	DivineFarnasAgent.instance:sendPM_DivineFarnasClgGetInfoReq(activityId)
end

function DivineFarnasController:handlePM_DivineFarnasClgGetInfoRes(msg)
	DivineFarnasModel.instance:handlePM_DivineFarnasClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineFarnasClgGetInfoRes)
end

function DivineFarnasController:sendPM_DivineFarnasClgExtremeFightReq(activityId, stageId, form)
	DivineFarnasAgent.instance:sendPM_DivineFarnasClgExtremeFightReq(activityId, stageId, form)
end

function DivineFarnasController:handlePM_DivineFarnasClgExtremeFightNotifyRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEndExt, self, msg))

	if msg.isWin then
		DivineFarnasModel.instance:handlePM_DivineFarnasClgExtremeFightNotifyRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineFarnasClgExtremeFightNotifyRes)
end

function DivineFarnasController:_onResFightEndExt(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)

	if msg.isWin then
		local extStageXfgs = DivineFarnasConfig.instance:getExtStageCfgs(msg.activityId)
		local extStageNum = #extStageXfgs

		if msg.stageId <= extStageNum / 2 then
			UIStateManager.instance:push(ViewName.DivineFarnasExtFightEndView, msg)
		else
			UIStateManager.instance:push(ViewName.DivineFarnasExtFightSecondEndView, msg)
		end

		return true
	end

	return false
end

function DivineFarnasController:enterBattleClgExt(activityId, stageId)
	local customFmtMo = DivineFarnasModel.instance:getExtFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineFarnasController:sendPM_DivineFarnasClgResetReq(activityId, stageId)
	DivineFarnasAgent.instance:sendPM_DivineFarnasClgResetReq(activityId, stageId)
end

function DivineFarnasController:handlePM_DivineFarnasClgResetRes(msg)
	DivineFarnasModel.instance:handlePM_DivineFarnasClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineFarnasClgResetRes)
end

function DivineFarnasController:sendPM_DivineFarnasClgNormalFightReq(activityId, stageId, form)
	DivineFarnasAgent.instance:sendPM_DivineFarnasClgNormalFightReq(activityId, stageId, form)
end

function DivineFarnasController:handlePM_DivineFarnasClgNormalFightNotifyRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEndNor, self, msg))
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineFarnasClgNormalFightNotifyRes, msg)
end

function DivineFarnasController:_onResFightEndNor(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)

	if msg.isWin then
		UIStateManager.instance:push(ViewName.DivineFarnasNorFightEndView, msg)

		return true
	end

	return false
end

function DivineFarnasController:enterBattleClgNor(activityId, stageId)
	local customFmtMo = DivineFarnasModel.instance:getNorFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineFarnasController:sendPM_DivineFarnasClgGainPrizeReq(activityId, prizeId)
	DivineFarnasAgent.instance:sendPM_DivineFarnasClgGainPrizeReq(activityId, prizeId)
end

function DivineFarnasController:handlePM_DivineFarnasClgGainPrizeRes(msg)
	DivineFarnasModel.instance:handlePM_DivineFarnasClgGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineFarnasClgGainPrizeRes)
end

function DivineFarnasController:getNorStageGroupId(activityId)
	local nowTimeStamp = ServerTime.now()
	local activityType = 522
	local startTimeStamp, endTimeStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local time = nowTimeStamp - startTimeStamp
	local day = math.ceil(time / 86400)
	local norStagePlanCfgs = DivineFarnasConfig.instance:getNorPlanCfgs(activityId)
	local groupNum = #norStagePlanCfgs

	return (day - 1) % groupNum + 1
end

function DivineFarnasController:getTotalExtRaceCount(activityId)
	local info = DivineFarnasModel.instance:getInfo(activityId)
	local extRaceCount = 0

	if info then
		local extremeStages = info.extremeStages

		for i, extStage in ipairs(extremeStages) do
			if extStage.activeRaceIds ~= nil then
				if not #extStage.activeRaceIds then
					local raceNum = 0

					extRaceCount = extRaceCount + raceNum
				end
			end
		end
	end

	return extRaceCount
end

function DivineFarnasController:stageIsPass(activityId, stageId)
	local info = DivineFarnasModel.instance:getInfo(activityId)
	local extStageInfo = info.extremeStages[stageId]

	if extStageInfo then
		return extStageInfo.pass
	end

	return false
end

function DivineFarnasController:getActiveBuffCfgLevel(activityId)
	local totalRaceCount = DivineFarnasModel.instance:getTotalRaceIdNum(activityId)
	local buffCfgs = DivineFarnasConfig.instance:getBuffCfgs(activityId)

	for i, cfg in ipairs(buffCfgs) do
		if totalRaceCount <= cfg.raceCount then
			return cfg.buffId
		end
	end

	return 1
end

DivineFarnasController.instance = DivineFarnasController.New()

return DivineFarnasController
