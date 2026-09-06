-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/controller/CompetitionKingController.lua

module("logic.extensions.competitionking.controller.CompetitionKingController", package.seeall)

local CompetitionKingController = class("CompetitionKingController", BaseController)

function CompetitionKingController:ctor()
	return
end

function CompetitionKingController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("competitionkingopenpopwintips", self._handleCompetitionKingOpenPopWinTips, self)
end

function CompetitionKingController:onReset()
	self._activityId = 0
end

function CompetitionKingController:setActId(activityId)
	self._activityId = activityId
end

function CompetitionKingController:getActId()
	return self._activityId
end

function CompetitionKingController:sendPM_CompetitionKingInfoReq(activityId)
	CompetitionKingAgent.instance:sendPM_CompetitionKingInfoReq(activityId)
end

function CompetitionKingController:handlePM_CompetitionKingInfoRes(status, msg)
	CompetitionKingModel.instance:setGainProgressPrizeIds(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CompetitionKingInfoRes, msg)
end

function CompetitionKingController:sendPM_CompetitionKingGainPrizeReq(activityId, prizeId)
	CompetitionKingAgent.instance:sendPM_CompetitionKingGainPrizeReq(activityId, prizeId)
end

function CompetitionKingController:handlePM_CompetitionKingGainPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.CompetitionKingGainPrizeRes, msg)
end

function CompetitionKingController:sendPM_CompetitionKingGetRankInfoReq(activityId)
	CompetitionKingAgent.instance:sendPM_CompetitionKingGetRankInfoReq(activityId)
end

function CompetitionKingController:handlePM_CompetitionKingGetRankInfoRes(status, msg)
	CompetitionKingModel.instance:setRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CompetitionKingGetRankInfoRes, msg)
end

function CompetitionKingController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function CompetitionKingController:getActivityType()
	return GameEnum.ActivityType.CompetitionKing
end

function CompetitionKingController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function CompetitionKingController:_handleCompetitionKingOpenPopWinTips()
	local activityId = CompetitionKingController.instance:getActivityId()

	if not self:isInActivityTime(activityId) then
		return
	end

	local data = CompetitionKingConfig.instance:getActCfgById(activityId)
	local tipsContent = data.popWinTipsDesc
	local okFunc

	TipsFacade.instance:openTipWindow("提示", tipsContent, okFunc, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

CompetitionKingController.instance = CompetitionKingController.New()

return CompetitionKingController
