-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/model/FormTeamModel.lua

module("logic.extensions.formteam.model.FormTeamModel", package.seeall)

local FormTeamModel = class("FormTeamModel", BaseModel)

function FormTeamModel:onInit()
	self:onReset()
end

function FormTeamModel:onReset()
	self._unlockTeamGroupIdList = nil
	self._matchTeamList = nil
	self._matchTeamHashList = nil
	self._curTeamInfo = nil
	self._curOnlineFailyMemberList = nil
	self._inviteInfoList = nil
	self._inviteInfoHash = nil
	self._curGainCoins = 0
end

function FormTeamModel:onGetUnlockTabList(msg)
	self._unlockTeamGroupIdList = msg.unlockedGroupIds
	self._curGainCoins = checkint(msg.dailyGained)
end

function FormTeamModel:onGetTeamList(msg)
	self._matchTeamList = {}
	self._matchTeamHashList = {}

	for k, v in ipairs(msg.teamViews) do
		local teamData = FormTeamData.New()

		teamData:setData(v)

		self._matchTeamList[k] = teamData
		self._matchTeamHashList[teamData.id] = teamData
	end
end

function FormTeamModel:onJoinTeam(msg)
	self._curTeamInfo = FormTeamCurTeamData.New()

	self._curTeamInfo:setData(msg)

	self._inviteInfoList = nil
	self._inviteInfoHash = nil
end

function FormTeamModel:onLeaveCurTeam(msg)
	self._curTeamInfo = nil
end

function FormTeamModel:onTeammateChange(msg)
	if self._curTeamInfo then
		self._curTeamInfo:setTeammateListData(msg)
	end
end

function FormTeamModel:onTeammateReady(msg)
	if self._curTeamInfo then
		self._curTeamInfo:setTeammateReady(msg.playerId)
	end
end

function FormTeamModel:onBeKick()
	self._curTeamInfo = nil
end

function FormTeamModel:onGetOnlineFailyList(msg)
	self._curOnlineFailyMemberList = msg.onlineFamilyMembers
end

function FormTeamModel:onGetBuddiesZdl(msg)
	for k, v in ipairs(msg.zdls) do
		local data = self._onlineBuddies[v.userId]

		if data then
			data.zdl = v.zdl
		end
	end
end

function FormTeamModel:getOnlineBuddiesUserIdList()
	local userIds = {}

	self._onlineBuddies = {}

	local buddiesMos = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	for k, v in ipairs(buddiesMos) do
		if v:getIsOnline() then
			local data = {}

			data.headInfo = v.headInfo
			data.zdl = 0
			self._onlineBuddies[v.headInfo.userId] = data

			table.insert(userIds, v.headInfo.userId)
		end
	end

	return userIds
end

function FormTeamModel:onBeInvited(msg)
	self._inviteInfoList = self._inviteInfoList or {}
	self._inviteInfoHash = self._inviteInfoHash or {}

	if not self:getInviteInfoByTeamId(msg.teamId) then
		local data = {}

		data.timeRefuse = -1
		data.teamId = msg.teamId
		data.groupId = msg.groupId
		data.teamCode = msg.teamCode
		data.headInfo = msg.headInfo

		local timeNow = ServerTime.now()
		local timeAdd = checkint(FormTeamConfig.instance:getCommonValue("INVITE_EXPIRE_SEC"))

		data.timeRefuse = timeNow + timeAdd

		table.insert(self._inviteInfoList, data)

		self._inviteInfoHash[data.teamId] = data
	end
end

function FormTeamModel:onGetReformTime(msg)
	if self._curTeamInfo then
		self._curTeamInfo.timeAutoStart = checkint(msg.autoBeginMillis)
	end
end

function FormTeamModel:onGetCurFetter(msg)
	if self._curTeamInfo then
		for _, info in ipairs(msg.teamInfo) do
			self._curTeamInfo:setCurTeammateCurFetterInfo(info)
		end
	end
end

function FormTeamModel:getMatchTeamListNum()
	return (self._matchTeamList or nil) and (#self._matchTeamList or 0)
end

function FormTeamModel:getMatchTeamByTeamId(teamId)
	return self._matchTeamHashList and self._matchTeamHashList[teamId]
end

function FormTeamModel:getMatchTeamList()
	return self._matchTeamList
end

function FormTeamModel:getCurTeamInfo()
	return self._curTeamInfo
end

function FormTeamModel:getCurGainCoins()
	return self._curGainCoins
end

function FormTeamModel:checkFormTeamTabShow(tabId)
	local tabCfg = FormTeamConfig.instance:getTabCfgByTabId(tabId)

	if tabCfg then
		local funId = checkint(tabCfg.funId)

		if funId > 0 and not FuncOpenModel.instance:getFuncIsOpen(funId) then
			return false
		end

		if not string.nilorempty(tabCfg.onlineTime) then
			local timePrams = string.split(tabCfg.onlineTime, "#")

			return GameUtil.checkIsInTimePeriod(timePrams[1], timePrams[2])
		end
	end

	return false
end

function FormTeamModel:checkFormTeamTabOpen(tabId)
	local tabCfg = FormTeamConfig.instance:getTabCfgByTabId(tabId)

	if tabCfg then
		if not GameUtil.checkTimeStr(tabCfg.openPeriodLimit) then
			return false
		end

		local teamCfgs = FormTeamConfig.instance:getTeamCfgsByTabId(tabId)

		for k, v in pairs(teamCfgs) do
			if v and self:checkIsUnlockBygroupId(v.groupId) then
				return true
			end
		end
	end

	return false
end

function FormTeamModel:checkIsUnlockBygroupId(groupId)
	local teamCfg = FormTeamConfig.instance:getTeamCfgByGroupId(groupId)

	if teamCfg and self._unlockTeamGroupIdList then
		return table.keyof(self._unlockTeamGroupIdList, groupId)
	end
end

function FormTeamModel:getCurOnlineFailyMemberList()
	return self._curOnlineFailyMemberList or {}
end

function FormTeamModel:getCurOnlineBuddiesList()
	local dataList = {}

	if self._onlineBuddies then
		for k, v in pairs(self._onlineBuddies) do
			table.insert(dataList, v)
		end
	end

	return dataList
end

function FormTeamModel:getInviteInfoList()
	local matchDataList = {}
	local notMatchIdList = {}

	if self._inviteInfoList then
		local timeNow = ServerTime.now()

		for k, v in ipairs(self._inviteInfoList) do
			if timeNow <= v.timeRefuse then
				table.insert(matchDataList, v)
			else
				table.insert(notMatchIdList, v.teamId)
			end
		end

		for k, v in ipairs(notMatchIdList) do
			self:removeInviteInfo(v)
		end
	end

	return matchDataList
end

function FormTeamModel:getLastInviteInfo()
	return self._inviteInfoList and self._inviteInfoList[#self._inviteInfoList]
end

function FormTeamModel:removeInviteInfo(teamId)
	local info = self:getInviteInfoByTeamId(teamId)

	if info and self._inviteInfoList then
		table.removebyvalue(self._inviteInfoList, info, true)

		self._inviteInfoHash[teamId] = nil
	end
end

function FormTeamModel:getInviteInfoByTeamId(teamId)
	return self._inviteInfoHash and self._inviteInfoHash[teamId]
end

function FormTeamModel:resetCurTeamData()
	self._curTeamInfo = nil
end

function FormTeamModel:getTeamAutoReadyState(gridId)
	local teamCfg = FormTeamConfig.instance:getTeamCfgByGroupId(gridId)

	if teamCfg then
		local userDataKey = "FROM_TEAM_AUTO_READY_STATE" .. gridId

		return checkint(GameUtil.getUserData(userDataKey))
	end

	if teamCfg then
		local data = FormTeamConfig.instance:getTabCfgByTabId(teamCfg.typeId)

		if data and data.isNotAutoReady then
			return GameEnum.FormTeamAutoReadyState.Not_Ready
		end
	end

	return GameEnum.FormTeamAutoReadyState.Not_Play_Before
end

function FormTeamModel:setTeamAutoReadyState(gridId, state)
	local teamCfg = FormTeamConfig.instance:getTeamCfgByGroupId(gridId)
	local isValueState = table.keyof(GameEnum.FormTeamAutoReadyState, state)

	if teamCfg then
		local userDataKey = "FROM_TEAM_AUTO_READY_STATE" .. gridId

		if isValueState and state ~= GameEnum.FormTeamAutoReadyState.Not_Play_Before then
			GameUtil.saveUserData(userDataKey, state)
		else
			GameUtil.saveUserData(userDataKey, GameEnum.FormTeamAutoReadyState.Not_Ready)
		end
	end
end

FormTeamModel.instance = FormTeamModel.New()

return FormTeamModel
