-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/data/MMTeamPassportSubMo.lua

module("logic.extensions.mmteampassport.data.MMTeamPassportSubMo", package.seeall)

local MMTeamPassportSubMo = class("MMTeamPassportSubMo")

MMTeamPassportSubMo.TEAM_MAX_MEMBER_COUNT = 3

function MMTeamPassportSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function MMTeamPassportSubMo:_resetData()
	self._isInfoLoaded = false

	self:_clearTeamInfo()
	self:_clearTeamHallInfo()
	self:_clearApplyList()

	self._gainedTeamPrizeMap = {}
	self._hasApplyLeft = false
end

function MMTeamPassportSubMo:_clearTeamInfo()
	self._hasTeam = false
	self._hasTeamInfo = false
	self._teamInfo = nil
	self._teamMemberCount = 0
	self._teamMaxProgress = 0
end

function MMTeamPassportSubMo:_clearTeamHallInfo()
	self._teamHallList = {}
end

function MMTeamPassportSubMo:_clearApplyList()
	self._applyList = {}
end

function MMTeamPassportSubMo:dispose()
	self:_resetData()
end

function MMTeamPassportSubMo:handlePM_MMTeamPassportGetInfoRes(msg)
	self._isInfoLoaded = true

	self:_clearTeamInfo()

	self._gainedTeamPrizeMap = {}
	self._hasApplyLeft = false

	for _, prizeId in ipairs(msg.gainedTeamPrizeIds or {}) do
		self._gainedTeamPrizeMap[prizeId] = true
	end

	if msg:HasField("team") then
		self:_setTeamInfo(msg.team)
	end

	if msg:HasField("hasApplyLeft") then
		self._hasApplyLeft = checkbool(msg.hasApplyLeft)
	end
end

function MMTeamPassportSubMo:handlePM_MMTeamPassportGetTeamHallInfoRes(msg)
	self:_clearTeamHallInfo()

	for _, teamInfo in ipairs(msg.teamList or {}) do
		table.insert(self._teamHallList, teamInfo)
	end
end

function MMTeamPassportSubMo:handlePM_MMTeamPassportApproveApplyRes(msg)
	return
end

function MMTeamPassportSubMo:handlePM_MMTeamPassportOpenApplyListRes(msg)
	self:_clearApplyList()

	for _, applyInfo in ipairs(msg.applyList or {}) do
		table.insert(self._applyList, applyInfo)
	end
end

function MMTeamPassportSubMo:handlePM_MMTeamPassportGainTeamPrizeRes(msg)
	self._gainedTeamPrizeMap[msg.prizeId] = true
end

function MMTeamPassportSubMo:getActivityId()
	return self._activityId
end

function MMTeamPassportSubMo:isInfoLoaded()
	return self._isInfoLoaded
end

function MMTeamPassportSubMo:hasTeamInfo()
	return self._hasTeamInfo
end

function MMTeamPassportSubMo:isSelfOnlyTeam()
	if not self:hasTeamInfo() then
		return false
	end

	local teamInfo = self:getTeamInfo()

	if tostring(teamInfo.captainId) ~= tostring(RoleModel.instance:getUserId()) then
		return false
	end

	return self:getOtherMemberCount() <= 0
end

function MMTeamPassportSubMo:hasEffectiveTeam()
	return self:getOtherMemberCount() > 0
end

function MMTeamPassportSubMo:canApplyJoinOtherTeam()
	return not self:hasEffectiveTeam()
end

function MMTeamPassportSubMo:getTeamInfo()
	return self._teamInfo
end

function MMTeamPassportSubMo:getTeamMemberCount()
	return self._teamMemberCount
end

function MMTeamPassportSubMo:getOtherMemberCount()
	local count = 0
	local selfUserId = tostring(RoleModel.instance:getUserId())
	local teamInfo = self:getTeamInfo()

	if teamInfo == nil then
		return count
	end

	for _, memberInfo in ipairs(teamInfo.memberList or {}) do
		local userId = self:_getMemberUserId(memberInfo)

		if userId ~= nil and tostring(userId) ~= selfUserId then
			count = count + 1
		end
	end

	return count
end

function MMTeamPassportSubMo:getTeamMaxProgress()
	return self._teamMaxProgress
end

function MMTeamPassportSubMo:getTeamMaxMemberCount()
	return MMTeamPassportSubMo.TEAM_MAX_MEMBER_COUNT
end

function MMTeamPassportSubMo:getTeamHallList()
	return self._teamHallList
end

function MMTeamPassportSubMo:getApplyList()
	return self._applyList
end

function MMTeamPassportSubMo:hasApplyLeft()
	return self._hasApplyLeft
end

function MMTeamPassportSubMo:hasApplyRedPoint()
	return self:hasApplyLeft() and not self:isTeamFull()
end

function MMTeamPassportSubMo:isTeamFull()
	return self._teamMemberCount >= self:getTeamMaxMemberCount()
end

function MMTeamPassportSubMo:getMemberActiveDay(memberInfo)
	local activeDay = 0
	local lastOnlineTime = checknumber(memberInfo and memberInfo.lastOnlineTime)

	if lastOnlineTime >= 0 then
		local lastOnlineSec = math.floor(lastOnlineTime / 1000)
		local leftTime = math.max(0, ServerTime.now() - lastOnlineSec)

		activeDay = math.floor(leftTime / 86400)
	end

	return activeDay
end

function MMTeamPassportSubMo:isGainTeamPrize(prizeId)
	return self._gainedTeamPrizeMap[prizeId] == true
end

function MMTeamPassportSubMo:isCanGetTeamPrize(prizeId)
	if self:isGainTeamPrize(prizeId) then
		return false
	end

	local cfg = MMTeamPassportConfig.instance:getTeamPrizeData(self._activityId, prizeId)

	if not cfg then
		return false
	end

	return self:getOtherMemberCount() >= cfg.memberCount
end

function MMTeamPassportSubMo:_getMemberUserId(memberInfo)
	if memberInfo == nil or memberInfo.headInfo == nil then
		return nil
	end

	return memberInfo.headInfo.userId
end

function MMTeamPassportSubMo:_setTeamInfo(teamInfo)
	self._hasTeam = true
	self._hasTeamInfo = true
	self._teamInfo = teamInfo

	self:_refreshTeamSummary()
end

function MMTeamPassportSubMo:_refreshTeamSummary()
	self._teamMemberCount = 0
	self._teamMaxProgress = 0

	for _, memberInfo in ipairs((self._teamInfo or nil) and (self._teamInfo.memberList or {})) do
		self._teamMemberCount = self._teamMemberCount + 1
		self._teamMaxProgress = math.max(self._teamMaxProgress, checknumber(memberInfo.progress))
	end
end

return MMTeamPassportSubMo
