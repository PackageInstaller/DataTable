-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/controller/WeeklyGroupController.lua

module("logic.extensions.weeklygroup.controller.WeeklyGroupController", package.seeall)

local WeeklyGroupController = class("WeeklyGroupController", BaseController)

function WeeklyGroupController:ctor()
	return
end

function WeeklyGroupController:onInit()
	self:onReset()
end

function WeeklyGroupController:onReset()
	removetimer(self.tickCdTimer, self)
end

function WeeklyGroupController:sendPM_WeeklyGroupGetInfoReq(activityId)
	WeeklyGroupAgent.instance:sendPM_WeeklyGroupGetInfoReq(activityId)
end

function WeeklyGroupController:handlePM_WeeklyGroupGetInfoRes(status, msg)
	WeeklyGroupModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WeeklyGroupGetInfoRes, msg)
end

function WeeklyGroupController:sendPM_WeeklyGroupGainPrizeReq(activityId, prizeId)
	WeeklyGroupAgent.instance:sendPM_WeeklyGroupGainPrizeReq(activityId, prizeId)
end

function WeeklyGroupController:handlePM_WeeklyGroupGainPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.WeeklyGroupGainPrizeRes, msg)
end

function WeeklyGroupController:sendPM_WeeklyGroupGainPersonPrizeReq(activityId, prizeId)
	WeeklyGroupAgent.instance:sendPM_WeeklyGroupGainPersonPrizeReq(activityId, prizeId)
end

function WeeklyGroupController:handlePM_WeeklyGroupGainPersonPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.WeeklyGroupGainPersonPrizeRes, msg)
end

function WeeklyGroupController:sendPM_WeeklyGroupInviteReq(activityId, buddyIds)
	if #buddyIds > 0 then
		WeeklyGroupAgent.instance:sendPM_WeeklyGroupInviteReq(activityId, buddyIds)
	end
end

function WeeklyGroupController:handlePM_WeeklyGroupInviteRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.WeeklyGroupInviteRes, msg)
end

function WeeklyGroupController:sendPM_WeeklyGroupJoinTeamReq(activityId, teamId)
	WeeklyGroupAgent.instance:sendPM_WeeklyGroupJoinTeamReq(activityId, teamId)
end

function WeeklyGroupController:handlePM_WeeklyGroupJoinTeamRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.WeeklyGroupJoinTeamRes, msg)
end

function WeeklyGroupController:sendPM_WeeklyGroupRankViewReq(activityId, rankType)
	WeeklyGroupAgent.instance:sendPM_WeeklyGroupRankViewReq(activityId, rankType)
end

function WeeklyGroupController:handlePM_WeeklyGroupRankViewRes(status, msg)
	WeeklyGroupModel.instance:setRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WeeklyGroupRankViewRes, msg)
end

function WeeklyGroupController:handlePM_NotifyIniviteMsgRes(status, msg)
	return
end

function WeeklyGroupController:handlePM_NotifyNewTeamStateRes(status, msg)
	return
end

function WeeklyGroupController:getPeriodCfgs(activityId)
	local cfgs = WeeklyGroupConfig.instance:getPeriodCfgById(activityId)

	for _, v in ipairs(cfgs) do
		local isInTime = GameUtil.checkIsInTimePeriod(v.startTime, v.endTime)

		if isInTime then
			return v
		end
	end

	return cfgs[1]
end

function WeeklyGroupController:getNeedInviteCount(activityId)
	local maxPlayerCount = WeeklyGroupConfig.instance:getWeeklyGroupCfgById(activityId).maxPlayerCount
	local invitedCount = WeeklyGroupModel.instance:getTeamPlayerCount()

	return maxPlayerCount - invitedCount
end

function WeeklyGroupController:friendSelectedCd()
	settimer(1, self.tickCdTimer, self, true)
end

function WeeklyGroupController:tickCdTimer()
	local curCdTime = WeeklyGroupModel.instance:getCdTime() or 0
	local inviteCd = WeeklyGroupModel.instance:getinviteCd() or 0

	if inviteCd <= curCdTime then
		removetimer(self.tickCdTimer, self)
	else
		WeeklyGroupModel.instance:setCdTime(curCdTime + 1)
	end
end

function WeeklyGroupController:isCaptain()
	local userId = checknumber(RoleModel.instance:getUserId())
	local captainId = WeeklyGroupModel.instance:getCaptainId()

	return checknumber(userId) == captainId
end

function WeeklyGroupController:isInTeam(invitedTeamId)
	local info = WeeklyGroupModel.instance:getInfo().team

	return WeeklyGroupModel.instance:getTeamPlayerCount() > 1
end

function WeeklyGroupController:isCanGet(prizeId, typeId)
	if typeId == 0 then
		local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WeeklyGroup)
		local cfg = WeeklyGroupConfig.instance:getPrizeCfgById(activityId, prizeId)
		local teamScore = WeeklyGroupModel.instance:getTeamScore()

		return teamScore >= cfg.needItemCount and not self:isGainPrize(prizeId, typeId)
	else
		local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WeeklyGroup)
		local cfg = WeeklyGroupConfig.instance:getPersonPrizeCfgById(activityId, prizeId)
		local personScore = WeeklyGroupModel.instance:getPersonScore()

		return personScore >= cfg.needItemCount and not self:isGainPrize(prizeId, typeId)
	end
end

function WeeklyGroupController:isGainPrize(prizeId, typeId)
	if typeId == 0 then
		local info = WeeklyGroupModel.instance:getInfo().gainPrizeIds

		return TableUtil.isHad(info, prizeId)
	else
		local info = WeeklyGroupModel.instance:getInfo().personGainPrizeIds

		return TableUtil.isHad(info, prizeId)
	end
end

function WeeklyGroupController:sendGetInfoRes()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WeeklyGroup)
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if isInTime then
		self:sendPM_WeeklyGroupGetInfoReq(activityId)
	end
end

WeeklyGroupController.instance = WeeklyGroupController.New()

return WeeklyGroupController
