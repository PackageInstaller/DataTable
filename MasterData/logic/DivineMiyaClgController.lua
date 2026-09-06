-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/controller/DivineMiyaClgController.lua

module("logic.extensions.divinemiyaclg.controller..DivineMiyaClgController", package.seeall)

local DivineMiyaClgController = class("DivineMiyaClgController", BaseController)

function DivineMiyaClgController:onInit()
	return
end

function DivineMiyaClgController:handlePM_DivineMiYaClgGetInfoRes(msg)
	DivineMiyaClgModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineMiYaClgGetInfoRes)
end

function DivineMiyaClgController:handlePM_DivineMiYaClgNotifyFightResultRes(msg)
	if msg.win then
		DivineMiyaClgModel.instance:saveBattleInfo(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineMiYaClgGetInfoRes)
end

function DivineMiyaClgController:handlePM_DivineMiYaClgSwitchStageRes(msg)
	DivineMiyaClgModel.instance:saveChangeStageInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineMiYaClgSwitchStageRes)
end

function DivineMiyaClgController:handlePM_DivineMiYaClgReset2StageRes(msg)
	DivineMiyaClgModel.instance:saveChangeStageInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineMiYaClgGetInfoRes)
end

function DivineMiyaClgController:handlePM_DivineMiYaClgGainProgressPrizeRes(msg)
	DivineMiyaClgModel.instance:saveProgressPrizeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineMiYaClgGainProgressPrizeRes)
end

DivineMiyaClgController.instance = DivineMiyaClgController.New()

return DivineMiyaClgController
