-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/controller/MoonKingController.lua

module("logic.extensions.moonking.controller.MoonKingController", package.seeall)

local MoonKingController = class("MoonKingController", BaseController)

function MoonKingController:ctor()
	return
end

function MoonKingController:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onTickDailyRefreshData, self)
end

function MoonKingController:onReset()
	self._curChallStage = nil
end

function MoonKingController:_onTickDailyRefreshData()
	if ViewMgr.instance._views == nil or ViewMgr.instance._views[ViewName.MoonKingBattle] == nil then
		return
	end

	local view = ViewMgr.instance._views[ViewName.MoonKingBattle]

	if view and view:isOpen() then
		local challId = checknumber(view:getFirstParam())

		if challId <= 0 then
			challId = MoonKingModel.instance.challengeId
		end

		self:csGetMoonShadowKingChallengeGetInfoReq(challId)
	end
end

function MoonKingController:csGetMoonShadowKingChallengeGetInfoReq(challId)
	challId = challId or MoonKingModel.instance.challengeId

	if checknumber(challId) <= 0 then
		return
	end

	MoonShadowKingChallengeAgent.instance:sendPM_MoonShadowKingChallengeGetInfoReq(challId)
end

function MoonKingController:scSendMoonShadowKingChallengeGetInfo(msg)
	MoonKingModel.instance:scSendMoonShadowKingChallengeGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateMoonKingInfo, msg.challengeId)
end

function MoonKingController:csGetMoonShadowKingChallengeGetStageInfoReq(challId, groupId, csCfg)
	if csCfg == nil or checknumber(csCfg.stageId) == 0 then
		return
	end

	self._curChallStage = csCfg

	MoonShadowKingChallengeAgent.instance:sendPM_MoonShadowKingChallengeGetStageInfoReq(challId, groupId, csCfg.stageId)
end

function MoonKingController:scSendMoonShadowKingChallengeGetStageInfo(msg)
	MoonKingModel.instance:scSendMoonShadowKingChallengeGetStageInfo(msg)

	local params = {
		challId = msg.challengeId,
		planId = self._curChallStage.stagePlanId,
		stageId = self._curChallStage.stageId,
		masterId = self._curChallStage.creepsMasterId,
		groupId = msg.groupId,
		difPlanId = self._curChallStage.difficultyPlanId
	}

	UIStateManager.instance:push(ViewName.MoonKingMission, params)

	self._curChallStage = nil
end

function MoonKingController:csGetMoonShadowKingChallengeReq(challId, groupId, stageId, masterId)
	local buffList = MoonKingModel.instance:getMoonkingChooseBuff()

	BattleFacade.instance:startMKPBattle(masterId)
	MoonShadowKingChallengeAgent.instance:sendPM_MoonShadowKingChallengeReq(challId, groupId, stageId, buffList)
end

function MoonKingController:scSendMoonShadowKingChallengeEnd(msg)
	return
end

function MoonKingController:csGetMoonShadowKingChallengeGainScorePrizeReq(challId, prizeId)
	MoonShadowKingChallengeAgent.instance:sendPM_MoonShadowKingChallengeGainScorePrizeReq(challId, prizeId)
end

function MoonKingController:scSendMoonShadowKingChallengeGainScorePrize(msg)
	MoonKingModel.instance:scSendMoonShadowKingChallengeGainScorePrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateMoonKingInfo, msg.challengeId, true)
end

function MoonKingController:csGetMoonkingRankReq(challId)
	TimedChallengeAgent.instance:sendPM_TimedChallengeGetPetRankReq(challId, function(msg)
		self:scSendMoonkingRank(msg)
	end, nil, nil)
end

function MoonKingController:scSendMoonkingRank(msg)
	if msg == nil or msg.infoList == nil then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateMoonKingRank, msg.infoList, msg.myRank)
end

MoonKingController.instance = MoonKingController.New()

return MoonKingController
