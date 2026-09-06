-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/controller/DivineEmpressController.lua

module("logic.extensions.divineempress.controller.DivineEmpressController", package.seeall)

local DivineEmpressController = class("DivineEmpressController", BaseController)

function DivineEmpressController:ctor()
	return
end

function DivineEmpressController:onInit()
	self:onReset()
end

function DivineEmpressController:onReset()
	return
end

function DivineEmpressController:handlePM_DivineEmpressClgGetInfoRes(msg)
	DivineEmpressModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineEmpressClgGetInfo)
end

function DivineEmpressController:handlePM_DivineEmpressResetExtremeStageRes(msg)
	DivineEmpressModel.instance:saveExtremeResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineEmpressClgGetInfo)
end

function DivineEmpressController:handlePM_DivineEmpressNotifyExtremeClgRes(msg)
	if msg.isWin == true and msg.isReachPassCondition == true then
		DivineEmpressModel.instance:saveExtremeInfo(msg)
	end

	DivineEmpressModel.instance:saveTempBattleResult(msg)

	if msg.changeSetId then
		DivineEmpressModel.instance:saveTempChangeSetId(msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	BattleFacade.instance:registerResultHandler(function()
		BattleController.instance:endBattle()

		return true
	end, self)
	GlobalDispatcher:dispatch(GlobalNotify.DivineEmpressClgGetInfo)
end

function DivineEmpressController:handlePM_DivineEmpressResetNormalClgBuffRes(msg)
	DivineEmpressModel.instance:saveResetDailyBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineEmpressResetNormalClgBuffRes)
end

function DivineEmpressController:handlePM_DivineEmpressNotifyNormalClgRes(msg)
	if msg.isWin == true then
		DivineEmpressModel.instance:saveNormalClgInfo(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineEmpressNotifyNormalClgRes)
end

function DivineEmpressController:handlePM_DivineEmpressGainProgreePrizeRes(msg)
	DivineEmpressModel.instance:saveNormalClgGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineEmpressGainProgreePrizeRes)
end

function DivineEmpressController:openExtraMissionView(activityId, stageId)
	local fmtMo = DivineEmpressModel.instance:getExtraFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineEmpressController:openNormalMissionView(activityId, groupId, stagId)
	local fmtMo = DivineEmpressModel.instance:getNormalFmtMo()

	fmtMo:initParams(activityId, groupId, stagId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineEmpressController:getScoreCfgByTotalScore(activityId, score)
	local scoreCfgs = DivineEmpressConfig.instance:getScoreCfgs(activityId)
	local maxScore, minScore = math.huge, 0

	for k, v in pairs(scoreCfgs) do
		if score <= v.scoreRange and maxScore > v.scoreRange then
			maxScore = v.scoreRange
		elseif score > v.scoreRange and minScore < v.scoreRange then
			minScore = v.scoreRange
		end
	end

	local scoreCfg

	if maxScore ~= math.huge and minScore ~= 0 then
		scoreCfg = scoreCfgs[maxScore]
	elseif maxScore ~= math.huge then
		scoreCfg = scoreCfgs[maxScore]
	elseif minScore ~= 0 then
		scoreCfg = scoreCfgs[minScore]
	end

	return scoreCfg
end

function DivineEmpressController:getNormalClgTodayGroupId(activityId)
	local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)
	local cfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)
	local startTime = GameUtil.string2time(cfg.startTime)
	local day = GameUtil.getDaysByTimestamp(startTime, ServerTime.now())
	local groupCfgs = DivineEmpressConfig.instance:getNormalClgGroupCfgs(activityId)
	local circleCount = #groupCfgs
	local groupId = day % circleCount

	if groupId == 0 then
		groupId = #groupCfgs
	end

	return groupId
end

DivineEmpressController.instance = DivineEmpressController.New()

return DivineEmpressController
