-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegoddragonclg/controller/DivineGodDragonClgController.lua

module("logic.extensions.divinegoddragonclg.controller.DivineGodDragonClgController", package.seeall)

local DivineGodDragonClgController = class("DivineGodDragonClgController", BaseController)

function DivineGodDragonClgController:ctor()
	return
end

function DivineGodDragonClgController:onInit()
	self:onReset()
end

function DivineGodDragonClgController:onReset()
	return
end

function DivineGodDragonClgController:handlePM_DivineGodDragonClgInfoRes(msg)
	DivineGodDragonClgModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineGodDragonClgInfoRes)
end

function DivineGodDragonClgController:handlePM_DivineGodDragonChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineGodDragonChallengeRes)
end

function DivineGodDragonClgController:handlePM_NotifyDivineGodDragonChallengeEndRes(msg)
	if msg.isWin and msg.killNum then
		DivineGodDragonClgModel.instance:saveKillNum(activityId, stageId, msg.killNum)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyDivineGodDragonChallengeEndRes)
end

function DivineGodDragonClgController:handlePM_DivineGodDragonGainPrizeRes(msg)
	DivineGodDragonClgModel.instance:savePrizeGain(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineGodDragonGainPrizeRes)
end

function DivineGodDragonClgController:handlePM_DivineGodDragonGetRankRes(msg)
	DivineGodDragonClgModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineGodDragonGetRankRes)
end

DivineGodDragonClgController.instance = DivineGodDragonClgController.New()

return DivineGodDragonClgController
