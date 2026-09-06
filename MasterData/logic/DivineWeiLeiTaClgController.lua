-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/controller/DivineWeiLeiTaClgController.lua

module("logic.extensions.divineweileitaclg.controller.DivineWeiLeiTaClgController", package.seeall)

local DivineWeiLeiTaClgController = class("DivineWeiLeiTaClgController", BaseController)

DivineWeiLeiTaClgController.SPECIAL_PHASE_ID = 3

function DivineWeiLeiTaClgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivineweileitaclgmainview", self._enterEventOpenView, self)
end

function DivineWeiLeiTaClgController:onReset()
	self._fmtMo = DivineXiuNuoFmtMo.New()
end

function DivineWeiLeiTaClgController:handlePM_DivineWeiLeiTaClgExtremeInfoRes(msg)
	DivineWeiLeiTaClgModel.instance:saveExtremeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineWeiLeiTaClgExtremeRefresh)
end

function DivineWeiLeiTaClgController:handlePM_DivineWeiLeiTaClgExtremeResetRes(msg)
	DivineWeiLeiTaClgModel.instance:saveExtremeReset(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineWeiLeiTaClgExtremeRefresh)
end

function DivineWeiLeiTaClgController:handlePM_DivineWeiLeiTaClgExtremeConfirmRes(msg)
	if msg.save == true then
		DivineWeiLeiTaClgModel.instance:saveExtremeConfirm(msg)
	end

	DivineWeiLeiTaClgModel.instance:resetExtBattleTempData(msg.activityId)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

	if isAoqiGodProcessType then
		local extMaxStageId = DivineWeiLeiTaClgModel.instance:getExtMaxStageId(msg.activityId)
		local stageCfgs = DivineWeiLeiTaClgConfig.instance:getExtremeStageCfgs(msg.activityId)

		if extMaxStageId >= #stageCfgs then
			UIStateManager.instance:popByName(ViewName.DivineWeiLeiTaClgMainView)
			UIStateManager.instance:popByName(ViewName.DivineWeiLeiTaClgExtremeView)

			local activityType = ActivityDefineController.instance:getActTypeByActId(msg.activityId)

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, msg.activityId)
		else
			GlobalDispatcher:dispatch(GlobalNotify.DivineWeiLeiTaClgExtremeRefresh)
		end
	else
		GlobalDispatcher:dispatch(GlobalNotify.DivineWeiLeiTaClgExtremeRefresh)
	end
end

function DivineWeiLeiTaClgController:handlePM_NotifyDivineWeiLeiTaExtremeClgFinishRes(msg)
	if msg.isWin then
		DivineWeiLeiTaClgModel.instance:saveExtBattle(msg)
		BattleFacade.instance:registerResultHandler(function()
			BattleController.instance:endBattle()

			return true
		end)
	end

	GlobalDispatcher:dispatch(GlobalNotify.DivineWeiLeiTaClgExtremeRefresh)
end

function DivineWeiLeiTaClgController:handlePM_DivineWeiLeiTaClgNormalInfoRes(msg)
	DivineWeiLeiTaClgModel.instance:saveNormalInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineWeiLeiTaClgNormalRefresh)
end

function DivineWeiLeiTaClgController:handlePM_DivineWeiLeiTaClgGainPrizeRes(msg)
	DivineWeiLeiTaClgModel.instance:saveNormalGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineWeiLeiTaClgNormalRefresh)
end

function DivineWeiLeiTaClgController:handlePM_NotifyDivineWeiLeiTaNormalClgFinishRes(msg)
	DivineWeiLeiTaClgModel.instance:saveNormalBattle(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleController.instance:endBattle()

		return true
	end)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyDivineWeiLeiTaNormalClgFinishRes)
end

function DivineWeiLeiTaClgController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.DivineWeiLeiTaClgMainView, actId)
end

DivineWeiLeiTaClgController.instance = DivineWeiLeiTaClgController.New()

return DivineWeiLeiTaClgController
