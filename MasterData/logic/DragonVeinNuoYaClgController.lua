-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonveinnuoyaclg/controller/DragonVeinNuoYaClgController.lua

module("logic.extensions.dragonveinnuoyaclg.controller.DragonVeinNuoYaClgController", package.seeall)

local DragonVeinNuoYaClgController = class("DragonVeinNuoYaClgController", BaseController)

function DragonVeinNuoYaClgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdragonveinnuoyaclgmainview", self._enterEventOpenView, self)
end

function DragonVeinNuoYaClgController:onReset()
	return
end

function DragonVeinNuoYaClgController:handlePM_DragonVeinNuoYaClgGetInfoRes(msg)
	DragonVeinNuoYaClgModel.instance:saveData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DragonVeinNuoYaClgGetInfoRes)
end

function DragonVeinNuoYaClgController:handlePM_DragonVeinNuoYaClgDigRes(msg)
	DragonVeinNuoYaClgModel.instance:saveDigData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DragonVeinNuoYaClgDigRes, msg.gridInfo.gridId)
end

function DragonVeinNuoYaClgController:handlePM_DragonVeinNuoYaClgNotifyFightResultRes(msg)
	if msg.win then
		DragonVeinNuoYaClgModel.instance:saveBattleData(msg)

		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

		if isAoqiGodProcessType then
			local allPass = self:_allPass(msg.activityId)

			if allPass then
				AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DragonVeinNuoYaClg, msg.activityId)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DragonVeinNuoYaClgDigRes, msg.gridId)
end

function DragonVeinNuoYaClgController:handlePM_DragonVeinNuoYaClgGainBoxRes(msg)
	DragonVeinNuoYaClgModel.instance:saveBoxData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DragonVeinNuoYaClgDigRes, msg.gridId)
end

function DragonVeinNuoYaClgController:handlePM_DragonVeinNuoYaClgJump2NextStageRes(msg)
	DragonVeinNuoYaClgModel.instance:saveNextStageData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DragonVeinNuoYaClgJump2NextStageRes)
end

function DragonVeinNuoYaClgController:_allPass(activityId)
	local stageId = DragonVeinNuoYaClgModel.instance:getStageId(activityId)
	local stageCfgs = DragonVeinNuoYaClgConfig.instance:getStageCfgs(activityId)
	local isDoneBoss = DragonVeinNuoYaClgModel.instance:isDoneBoss(activityId)
	local isCurStage = stageId >= #stageCfgs

	return isCurStage and isDoneBoss
end

function DragonVeinNuoYaClgController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.DragonVeinNuoYaClgMainView, actId)
end

DragonVeinNuoYaClgController.instance = DragonVeinNuoYaClgController.New()

return DragonVeinNuoYaClgController
