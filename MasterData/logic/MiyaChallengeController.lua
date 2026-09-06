-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/controller/MiyaChallengeController.lua

module("logic.extensions.miyachallenge.controller.MiyaChallengeController", package.seeall)

local MiyaChallengeController = class("MiyaChallengeController", BaseController)

function MiyaChallengeController:ctor()
	MiyaChallengeController.super.ctor(self)
end

function MiyaChallengeController:onReset()
	return
end

function MiyaChallengeController:onInit()
	GlobalDispatcher:addListener(MiyaChallengeAgent.PM_MiyaChallengeGetInfoRes, self.PM_MiyaChallengeGetInfoRes, self)
	GlobalDispatcher:addListener(MiyaChallengeAgent.PM_MiyaChallengeGetStageInfoRes, self.PM_MiyaChallengeGetStageInfoRes, self)
	GlobalDispatcher:addListener(MiyaChallengeAgent.PM_MiyaChallengeBuyAndRandomRes, self.PM_MiyaChallengeBuyAndRandomRes, self)
	GlobalDispatcher:addListener(MiyaChallengeAgent.PM_MiyaChallengeChoiceRes, self.PM_MiyaChallengeChoiceRes, self)
	GlobalDispatcher:addListener(MiyaChallengeAgent.PM_MiyaChallengeBossRes, self.PM_MiyaChallengeBossRes, self)
	GlobalDispatcher:addListener(MiyaChallengeAgent.PM_MiyaBossChallengeEndRes, self.PM_MiyaBossChallengeEndRes, self)
	GlobalDispatcher:addListener(MiyaChallengeAgent.PM_MiyaFormChallengeRes, self.PM_MiyaFormChallengeRes, self)
	GlobalDispatcher:addListener(MiyaChallengeAgent.PM_MiyaFormChallengeEndRes, self.PM_MiyaFormChallengeEndRes, self)
end

function MiyaChallengeController:sendPM_MiyaChallengeGetInfoReq(activityId)
	MiyaChallengeModel.instance:setActivityId(activityId)
	MiyaChallengeAgent.instance:sendPM_MiyaChallengeGetInfoReq(activityId)
end

function MiyaChallengeController:PM_MiyaChallengeGetInfoRes(msg, status)
	MiyaChallengeModel.instance:setActiveData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiyaChallengeGetInfoRes)
end

function MiyaChallengeController:sendPM_MiyaChallengeGetStageInfoReq(activityId, tierId, bigStage, stageId)
	MiyaChallengeModel.instance:setStageId(bigStage, stageId)
	MiyaChallengeAgent.instance:sendPM_MiyaChallengeGetStageInfoReq(activityId, tierId, bigStage, stageId)
end

function MiyaChallengeController:PM_MiyaChallengeGetStageInfoRes(msg, status)
	MiyaChallengeModel.instance:setStageData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiyaChallengeGetStageInfo)
end

function MiyaChallengeController:PM_MiyaChallengeBuyAndRandomRes(msg, status)
	MiyaChallengeModel.instance:setStageData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiyaChallengeBuyAndRandom)
end

function MiyaChallengeController:sendPM_MiyaChallengeChoiceReq(finalParam)
	local choiceParam = MiyaChallengeExtension_pb.MiyaChallengeStageParamInfo()

	choiceParam.buffId = finalParam.buffId
	choiceParam.limitId = finalParam.limitId
	choiceParam.conditionId = finalParam.conditionId

	MiyaChallengeAgent.instance:sendPM_MiyaChallengeChoiceReq(MiyaChallengeModel.instance:getActivityId(), MiyaChallengeModel.instance:getBigStageId(), MiyaChallengeModel.instance:getShowStageId(), choiceParam)
end

function MiyaChallengeController:PM_MiyaChallengeChoiceRes(msg, status)
	MiyaChallengeModel.instance:repaceStageData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiyaChallengeChoice)
end

function MiyaChallengeController:PM_MiyaChallengeBossRes(msg, status)
	return
end

function MiyaChallengeController:PM_MiyaBossChallengeEndRes(msg, status)
	local params = {}

	if msg.isWin == true then
		params.damage = msg.damage

		if msg.changeSetId then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		end
	end

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.GodARuiShi, params)
	GlobalDispatcher:dispatch(GlobalNotify.MiyaBossChallengeEnd)
end

function MiyaChallengeController:PM_MiyaFormChallengeRes(msg, status)
	return
end

function MiyaChallengeController:PM_MiyaFormChallengeEndRes(msg, status)
	if msg.isWin == true then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.MiyaFormChallengeEnd)
end

MiyaChallengeController.instance = MiyaChallengeController.New()

return MiyaChallengeController
