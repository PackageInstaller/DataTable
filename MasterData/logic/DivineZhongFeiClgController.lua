-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/controller/DivineZhongFeiClgController.lua

module("logic.extensions.divinezhongfeiclg.controller.DivineZhongFeiClgController", package.seeall)

local DivineZhongFeiClgController = class("DivineZhongFeiClgController", BaseController)

function DivineZhongFeiClgController:ctor()
	return
end

function DivineZhongFeiClgController:onInit()
	self:onReset()
end

function DivineZhongFeiClgController:onReset()
	return
end

function DivineZhongFeiClgController:openExtemeMissionView(activityId, stageId)
	local fmtMo = DivineZhongFeiClgModel.instance:getExtemeFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineZhongFeiClgController:openNormalMissionView(activityId)
	local fmtMo = DivineZhongFeiClgModel.instance:getNormalFmtMo()

	fmtMo:initParams(activityId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineZhongFeiClgController:handlePM_DivineZhongFeiClgExtremeInfoRes(msg)
	DivineZhongFeiClgModel.instance:saveExtInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineZhongFeiClgGetInfo)
end

function DivineZhongFeiClgController:handlePM_NotifyDivineZhongFeiClgExtremeFinishRes(msg)
	if msg.isWin then
		DivineZhongFeiClgModel.instance:saveExtBattle(msg)
		BattleFacade.instance:registerResultHandler(function()
			UIStateManager.instance:push(ViewName.DivineZhongFeiClgExtResultView)

			return true
		end)
	end

	GlobalDispatcher:dispatch(GlobalNotify.DivineZhongFeiClgGetInfo)
end

function DivineZhongFeiClgController:handlePM_DivineZhongFeiClgExtremeConfirmRes(msg)
	if msg.save == true then
		DivineZhongFeiClgModel.instance:saveExtConfirmInfo(msg)
	end

	if msg.isFinish == true and msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	BattleController.instance:endBattle()
	GlobalDispatcher:dispatch(GlobalNotify.DivineZhongFeiClgGetInfo)
end

function DivineZhongFeiClgController:handlePM_DivineZhongFeiClgExtremeResetRes(msg)
	DivineZhongFeiClgModel.instance:saveResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineZhongFeiClgGetInfo)
end

function DivineZhongFeiClgController:handlePM_DivineZhongFeiClgNormalInfoRes(msg)
	DivineZhongFeiClgModel.instance:saveNormalInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineZhongFeiClgGetInfo)
end

function DivineZhongFeiClgController:handlePM_NotifyDivineZhongFeiClgNormalFinishRes(msg)
	DivineZhongFeiClgModel.instance:saveNormalBattleInfo(msg)
	BattleFacade.instance:registerResultHandler(function()
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)

		return true
	end)

	local params = {
		title = "目 标",
		content = langPara("本次造成伤害：%d\n今日最高伤害：%d", checknumber(msg.damage), DivineZhongFeiClgModel.instance:getNormalTodayDamage(msg.activityId))
	}

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.SimplyDesc, params)
	GlobalDispatcher:dispatch(GlobalNotify.DivineZhongFeiClgGetInfo)
end

function DivineZhongFeiClgController:handlePM_DivineZhongFeiClgNormalGainPrizeRes(msg)
	DivineZhongFeiClgModel.instance:saveGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineZhongFeiClgGetInfo)
end

function DivineZhongFeiClgController:isAllNormalPrizeGain(activityId)
	local isGainAll = true
	local prizeCfg = DivineZhongFeiClgConfig.instance:getNormalPrizeCfgs(activityId)

	for i, v in ipairs(prizeCfg) do
		if not DivineZhongFeiClgModel.instance:isGainNormalPrize(activityId, v.prizeId) then
			isGainAll = false

			break
		end
	end

	return isGainAll
end

DivineZhongFeiClgController.instance = DivineZhongFeiClgController.New()

return DivineZhongFeiClgController
