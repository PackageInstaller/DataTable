-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/controller/DivineNuoYaChallengeController.lua

module("logic.extensions.divinenuoyachallenge.controller.DivineNuoYaChallengeController", package.seeall)

local DivineNuoYaChallengeController = class("DivineNuoYaChallengeController", BaseController)

DivineNuoYaChallengeController.SelectEvent = "selectevent"

function DivineNuoYaChallengeController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.DivineNuoYaClgNotifyNormalFightResultRes, self._onNotifyNormalFightResultRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DivineNuoYaClgNotifyExtremeFightResultRes, self._onNotifyExtremeFightResultRes, self)
end

function DivineNuoYaChallengeController:_onNotifyNormalFightResultRes()
	UIJumper.instance:pushOneStack(ViewName.DivineNuoYaClgMainView, true)

	local activityId = DivineNuoYaChallengeModel.instance:getActivityId()

	if not DivineNuoYaChallengeModel.instance:isPassNormalClgProgress(activityId) then
		UIJumper.instance:pushOneStack(ViewName.DivineNuoYaEntireView, true, activityId)
	end
end

function DivineNuoYaChallengeController:_onNotifyExtremeFightResultRes()
	UIJumper.instance:pushOneStack(ViewName.DivineNuoYaClgMainView, true)

	local activityId = DivineNuoYaChallengeModel.instance:getActivityId()

	if not DivineNuoYaChallengeModel.instance:isPassExtremeClgStageProgress(activityId) then
		UIJumper.instance:pushOneStack(ViewName.DivineNuoYaExtremeView, true, activityId)

		if DivineNuoYaChallengeModel.instance:isBattlePassBigStage() then
			UIJumper.instance:pushOneStack(ViewName.DivineNuoYaTipView, true, activityId, DivineNuoYaChallengeModel.PassStage)
		else
			local stageId = DivineNuoYaChallengeModel.instance:getExtremeBigStageProgress() + 1

			UIJumper.instance:pushOneStack(ViewName.DivineNuoYaExtremeClgView, true, activityId, stageId)
		end
	end
end

function DivineNuoYaChallengeController:openNormalMissionView(activityId, stageId, planId)
	local customFmtMo = DivineNuoYaChallengeModel.instance:getNormalCustomFmtMo()

	customFmtMo:initParams(activityId, stageId, planId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineNuoYaChallengeController:openExtremeMissionView(activityId, stageId, monsterId)
	local customFmtMo = DivineNuoYaChallengeModel.instance:getExtremeCustomFmtMo()

	customFmtMo:initParams(activityId, stageId, monsterId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineNuoYaChallengeController:openBattleResultView()
	UIStateManager.instance:push(ViewName.DivineNuoYaResultView, DivineNuoYaChallengeModel.instance:getActivityId())
end

DivineNuoYaChallengeController.instance = DivineNuoYaChallengeController.New()

return DivineNuoYaChallengeController
