-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/model/WeeklyGroupModel.lua

module("logic.extensions.weeklygroup.model.WeeklyGroupModel", package.seeall)

local WeeklyGroupModel = class("WeeklyGroupModel", BaseModel)

function WeeklyGroupModel:ctor()
	return
end

function WeeklyGroupModel:onInit()
	self:onReset()
end

function WeeklyGroupModel:onReset()
	self.info = {}
	self.rankInfo = {}
	self.cdTime = nil
end

function WeeklyGroupModel:setInfo(msg)
	GameUtil.pbToTable(msg, self.info)
end

function WeeklyGroupModel:getInfo()
	return self.info or {}
end

function WeeklyGroupModel:getTeamInfo()
	local info = self:getInfo().team
	local teamInfo = {}

	if info and info.teammateList and not TableUtil.isTableEmpty(info.teammateList) then
		for _, v in pairs(info.teammateList) do
			table.insert(teamInfo, v)
		end
	end

	local captainId = checknumber(info and info.captainId)

	table.sort(teamInfo, function(a, b)
		return checknumber(a.headInfo.userId) == captainId
	end)

	return teamInfo
end

function WeeklyGroupModel:getTeamPlayerCount()
	local info = self:getInfo().team

	return info and table.nums(info.teammateList) or 0
end

function WeeklyGroupModel:getCaptainId()
	local info = self:getInfo().team

	return checknumber(info and info.captainId)
end

function WeeklyGroupModel:getTeamScore()
	local info = self:getInfo().team
	local teamScore = 0

	if info and info.teammateList then
		for _, v in pairs(info.teammateList) do
			teamScore = teamScore + v.itemCount
		end
	end

	return teamScore
end

function WeeklyGroupModel:getPersonScore()
	local info = self:getInfo()

	return (info or nil) and info.personItemCount
end

function WeeklyGroupModel:getCdTime()
	return self.cdTime
end

function WeeklyGroupModel:setCdTime(time)
	self.cdTime = time
end

function WeeklyGroupModel:getinviteCd()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WeeklyGroup)
	local actCfg = WeeklyGroupConfig.instance:getWeeklyGroupCfgById(activityId) or {}

	return actCfg.inviteCd
end

function WeeklyGroupModel:setRankInfo(msg)
	self.rankInfo = {}

	GameUtil.pbToTable(msg, self.rankInfo)
end

function WeeklyGroupModel:getRankInfo()
	if not TableUtil.isTableEmpty(self.rankInfo.rankInfoList) then
		table.sort(self.rankInfo.rankInfoList, function(a, b)
			return a.rank < b.rank
		end)
	end

	return self.rankInfo.rankInfoList
end

function WeeklyGroupModel:getMyRank()
	return checknumber(self.rankInfo.myRank)
end

WeeklyGroupModel.instance = WeeklyGroupModel.New()

return WeeklyGroupModel
