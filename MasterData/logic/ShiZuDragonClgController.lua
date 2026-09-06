-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/controller/ShiZuDragonClgController.lua

module("logic.extensions.shizudragonclg.controller.ShiZuDragonClgController", package.seeall)

local ShiZuDragonClgController = class("ShiZuDragonClgController", BaseController)

function ShiZuDragonClgController:onInit()
	return
end

function ShiZuDragonClgController:handlePM_ShiZuDragonClgInfoRes(msg)
	ShiZuDragonClgModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ShiZuDragonClgGetInfo)
end

function ShiZuDragonClgController:sendPM_ShiZuDragonClgResetReq(msg)
	ShiZuDragonClgModel.instance:saveReset(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ShiZuDragonClgGetInfo)
end

function ShiZuDragonClgController:handlePM_NotifyShiZuDragonClgFinishRes(msg)
	ShiZuDragonClgModel.instance:saveClgTempInfo(msg)

	if msg.isWin == true then
		ShiZuDragonClgModel.instance:saveChallenge(msg)

		if checknumber(msg.changeSetId) > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

			local phaseCfgs = ShiZuDragonClgConfig.instance:getPhaseCfgs(msg.activityId)

			if msg.phaseId < #phaseCfgs then
				ShiZuDragonClgModel.instance:resetStageInfo(msg.activityId, msg.phaseId)
			elseif msg.phaseId == #phaseCfgs then
				ShiZuDragonClgModel.instance:saveNewPhaseId(msg.activityId, msg.phaseId)
			end
		end

		BattleFacade.instance:registerResultHandler(function()
			UIStateManager.instance:push(ViewName.ShiZuDragonClgResultView)

			return true
		end)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ShiZuDragonClgGetInfo)
end

function ShiZuDragonClgController:openMissionView(activityId, phaseId, stagId)
	local fmtMo = ShiZuDragonClgModel.instance:getFmtMo()

	fmtMo:initParams(activityId, phaseId, stagId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

ShiZuDragonClgController.instance = ShiZuDragonClgController.New()

return ShiZuDragonClgController
