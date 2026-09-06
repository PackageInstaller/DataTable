-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/controller/DivinesuperdragonController.lua

module("logic.extensions.divinesuperdragon.controller.DivinesuperdragonController", package.seeall)

local DivinesuperdragonController = class("DivinesuperdragonController", BaseController)

function DivinesuperdragonController:ctor()
	return
end

function DivinesuperdragonController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivinesuperdragonmainview", self._enterEventOpenView, self)
end

function DivinesuperdragonController:onReset()
	return
end

function DivinesuperdragonController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivinesuperdragonController:getActivityType()
	return GameEnum.ActivityType.DivineSuperDragon
end

function DivinesuperdragonController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(DivinesuperdragonConfig.instance:getSkinId(activityId))
end

function DivinesuperdragonController:enterMission(activityId, clgType, creepsMasterId)
	local customFmtMo = DivinesuperdragonModel.instance:getFmtMo()

	customFmtMo:initParams(activityId, clgType, creepsMasterId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivinesuperdragonController:allChallengePass(activityId)
	local superStageCfgs = DivinesuperdragonConfig.instance:getSuperStageCfgs(activityId)
	local superPassStageId = DivinesuperdragonModel.instance:getSuperStageProgress(activityId)

	return superPassStageId >= #superStageCfgs
end

function DivinesuperdragonController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.DivinesuperdragonmainView, actId)
end

function DivinesuperdragonController:handlePM_DivineSuperDragonClgNotifySuperStageFightResultRes(msg)
	local win = msg.win
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

	if win then
		DivinesuperdragonModel.instance:updateSuperStageProgress(msg.activityId, msg.superStageProgress)
	end

	UIJumper.instance:pushOneStack(ViewName.DivinesuperdragonmainView, false, msg.activityId)
	UIJumper.instance:pushOneStack(ViewName.DivinesuperdragonsuperstageView, false, msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.DivineSuperDragonClgNotifySuperStageFightResultRes)

	if isAoqiGodProcessType then
		local allPass = DivinesuperdragonController.instance:allChallengePass(msg.activityId)

		if isAoqiGodProcessType and allPass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DivineSuperDragon, msg.activityId)
		end
	end
end

DivinesuperdragonController.instance = DivinesuperdragonController.New()

return DivinesuperdragonController
