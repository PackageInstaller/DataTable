-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/data/GroupRegressSubMo.lua

module("logic.extensions.groupregress.data.GroupRegressSubMo", package.seeall)

local GroupRegressSubMo = class("GroupRegressSubMo")

function GroupRegressSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function GroupRegressSubMo:_resetData()
	self._myCode = ""
	self._bindCode = ""
	self._bindPlayerId = "0"
	self._playerType = ""
	self._bindInviteCode = ""
	self._bindResultCode = 0
	self._gainProgressPrizeTeamType = 0
	self._gainProgressPrizeChangeSetId = 0
	self._gainOncePrizeIsNewPlayer = false
	self._gainOncePrizeChangeSetId = 0
	self._teamMemberListMap = {}
	self._teamGainPrizeIdMap = {}
	self._teamGainInviteNewPlayerPrizeMap = {}
	self._teamGainInviteRegressPlayerPrizeMap = {}
	self._newMemberInfoMap = {}
end

function GroupRegressSubMo:dispose()
	self:_resetData()
end

function GroupRegressSubMo:handlePM_GroupRegressGetInfoRes(msg)
	self._myCode = msg.myCode

	if msg:HasField("bindCode") then
		self._bindCode = msg.bindCode or ""
	end

	self._bindPlayerId = msg.bindPlayerId
	self._playerType = msg.playerType
end

function GroupRegressSubMo:handlePM_GroupRegressBindRes(msg)
	self._bindInviteCode = msg.inviteCode
	self._bindResultCode = msg.resultCode

	if self._bindResultCode == 0 then
		self._bindCode = self._bindInviteCode
	end
end

function GroupRegressSubMo:handlePM_GroupRegressGainProgressPrizeRes(msg)
	self._gainProgressPrizeTeamType = msg.teamType
	self._gainProgressPrizeChangeSetId = msg.changeSetId

	local teamType = msg.teamType

	self._teamGainPrizeIdMap[teamType] = self._teamGainPrizeIdMap[teamType] or {}

	for _, prizeId in ipairs(msg.prizeIds) do
		self._teamGainPrizeIdMap[teamType][prizeId] = true
	end
end

function GroupRegressSubMo:handlePM_GroupRegressGainOncePrizeRes(msg, teamType)
	self._gainOncePrizeIsNewPlayer = checkbool(msg.inviteNewPlayerPrize)
	self._gainOncePrizeChangeSetId = msg.changeSetId
	teamType = checknumber(teamType)

	if teamType <= 0 then
		return
	end

	if self._gainOncePrizeIsNewPlayer then
		self:_setGainInviteOncePrize(teamType, GroupRegressEnum.PlayerType.New, true)
	else
		self:_setGainInviteOncePrize(teamType, GroupRegressEnum.PlayerType.Regress, true)
	end
end

function GroupRegressSubMo:handlePM_GroupRegressGetTeamInfoRes(msg)
	local teamInfo = msg.teamList
	local teamType = teamInfo.teamType
	local memberList = self:_getTeamMemberList(teamType)

	self._teamGainPrizeIdMap[teamType] = {}

	table.clear(memberList)

	for _, memberInfo in ipairs(teamInfo.memberList) do
		table.insert(memberList, memberInfo)
	end

	for _, prizeId in ipairs(teamInfo.gainPrizeIds) do
		self._teamGainPrizeIdMap[teamType][prizeId] = true
	end

	if teamInfo:HasField("gainInviteNewPlayerPrize") then
		self:_setGainInviteOncePrize(teamType, GroupRegressEnum.PlayerType.New, teamInfo.gainInviteNewPlayerPrize)
	end

	if teamInfo:HasField("gainInviteRegressPlayerPrize") then
		self:_setGainInviteOncePrize(teamType, GroupRegressEnum.PlayerType.Regress, teamInfo.gainInviteRegressPlayerPrize)
	end
end

function GroupRegressSubMo:handlePM_GroupRegressNotifyNewMemberRes(msg)
	local teamType = msg.teamType
	local memberList = self:_getTeamMemberList(teamType)

	table.insert(memberList, msg.playerInfo)

	self._newMemberInfoMap[teamType] = msg.playerInfo
end

function GroupRegressSubMo:getActivityId()
	return self._activityId
end

function GroupRegressSubMo:getMyCode()
	return self._myCode
end

function GroupRegressSubMo:getBindCode()
	return self._bindCode
end

function GroupRegressSubMo:getBindPlayerId()
	return self._bindPlayerId
end

function GroupRegressSubMo:getPlayerType()
	return self._playerType
end

function GroupRegressSubMo:getBindInviteCode()
	return self._bindInviteCode
end

function GroupRegressSubMo:getBindResultCode()
	return self._bindResultCode
end

function GroupRegressSubMo:getGainProgressPrizeChangeSetId()
	return self._gainProgressPrizeChangeSetId
end

function GroupRegressSubMo:getGainOncePrizeChangeSetId()
	return self._gainOncePrizeChangeSetId
end

function GroupRegressSubMo:getTeamMemberList(teamType)
	return self._teamMemberListMap[teamType] or {}
end

function GroupRegressSubMo:getTeamMemberListCaptainFirst(teamType)
	local memberList = {}
	local normalMemberList = {}

	for _, memberInfo in ipairs(self:getTeamMemberList(teamType)) do
		if self:isTeamCaptain(teamType, memberInfo) then
			table.insert(memberList, memberInfo)
		else
			table.insert(normalMemberList, memberInfo)
		end
	end

	for _, memberInfo in ipairs(normalMemberList) do
		table.insert(memberList, memberInfo)
	end

	return memberList
end

function GroupRegressSubMo:getTeamScore(teamType)
	local score = 0

	for _, memberInfo in ipairs(self:getTeamMemberList(teamType)) do
		score = score + checknumber(memberInfo.activityItemCount)
	end

	return score
end

function GroupRegressSubMo:getTeamPlayerTypeCount(teamType, playerType)
	local count = 0

	for _, memberInfo in ipairs(self:getTeamMemberList(teamType)) do
		if memberInfo.playerType == playerType then
			count = count + 1
		end
	end

	return count
end

function GroupRegressSubMo:getInvitePlayerTypeCount(teamType, playerType)
	local count = 0

	if teamType == GroupRegressEnum.TeamType.InviteOwner then
		local myUserId = tostring(RoleModel.instance:getUserId())

		for _, memberInfo in ipairs(self:getTeamMemberList(teamType)) do
			if memberInfo.headInfo then
				if memberInfo.playerType == playerType and memberInfo.headInfo and tostring(memberInfo.headInfo) ~= myUserId then
					count = count + 1
				end
			end
		end
	else
		count = self:getTeamPlayerTypeCount(teamType, playerType)
	end

	return count
end

function GroupRegressSubMo:isTeamCaptain(teamType, memberInfo)
	local headInfo = memberInfo and memberInfo.headInfo
	local userId = headInfo and headInfo.userId
	local isCaptain = false

	if userId then
		if teamType == GroupRegressEnum.TeamType.InviteOwner then
			isCaptain = tostring(userId) == tostring(RoleModel.instance:getUserId())
		elseif teamType == GroupRegressEnum.TeamType.BindOwner then
			isCaptain = tostring(userId) == tostring(self._bindPlayerId)
		end
	end

	return isCaptain
end

function GroupRegressSubMo:isGainProgressPrize(teamType, prizeId)
	local gainPrizeIdMap = self._teamGainPrizeIdMap[teamType]

	return gainPrizeIdMap and gainPrizeIdMap[prizeId] == true
end

function GroupRegressSubMo:isEnoughProgressPrize(teamType, needProgress)
	return self:getTeamScore(teamType) >= checknumber(needProgress)
end

function GroupRegressSubMo:isCanGetProgressPrize(teamType, prizeId, needProgress)
	return not self:isGainProgressPrize(teamType, prizeId) and self:isEnoughProgressPrize(teamType, needProgress)
end

function GroupRegressSubMo:isGainInviteOncePrize(teamType, playerType)
	if playerType == GroupRegressEnum.PlayerType.New then
		return checkbool(self._teamGainInviteNewPlayerPrizeMap[teamType])
	elseif playerType == GroupRegressEnum.PlayerType.Regress then
		return checkbool(self._teamGainInviteRegressPlayerPrizeMap[teamType])
	end

	return false
end

function GroupRegressSubMo:isCanGetInviteOncePrize(teamType, playerType)
	local needCount = self:_getInviteOncePrizeNeedCount(playerType)

	return needCount > 0 and not self:isGainInviteOncePrize(teamType, playerType) and needCount <= self:getInvitePlayerTypeCount(teamType, playerType)
end

function GroupRegressSubMo:getNewMemberInfo(teamType)
	return self._newMemberInfoMap[teamType]
end

function GroupRegressSubMo:_getInviteOncePrizeNeedCount(playerType)
	if playerType == GroupRegressEnum.PlayerType.New or playerType == GroupRegressEnum.PlayerType.Regress then
		return 1
	end

	return 0
end

function GroupRegressSubMo:_setGainInviteOncePrize(teamType, playerType, isGain)
	if playerType == GroupRegressEnum.PlayerType.New then
		self._teamGainInviteNewPlayerPrizeMap[teamType] = checkbool(isGain)
	elseif playerType == GroupRegressEnum.PlayerType.Regress then
		self._teamGainInviteRegressPlayerPrizeMap[teamType] = checkbool(isGain)
	end
end

function GroupRegressSubMo:_getTeamMemberList(teamType)
	self._teamMemberListMap[teamType] = self._teamMemberListMap[teamType] or {}

	return self._teamMemberListMap[teamType]
end

return GroupRegressSubMo
