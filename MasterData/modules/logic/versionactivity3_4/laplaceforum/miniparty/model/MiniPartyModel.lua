-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/model/MiniPartyModel.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.model.MiniPartyModel", package.seeall)

local MiniPartyModel = class("MiniPartyModel", BaseModel)

function MiniPartyModel:onInit()
	self:reInit()
end

function MiniPartyModel:reInit()
	self._teammateInfo = {}
	self._inviteCode = ""
	self._friendTeams = {}
	self._inviteInfos = {}
	self._curInviteType = 0
end

function MiniPartyModel:setAct223Info(info)
	self:_setTeammateInfo(info.teammateInfo)

	self._inviteCode = info.inviteCode

	self:_setFriendTeams(info.friendTeams)
	self:_setInviteInfos(info.inviteInfo)
end

function MiniPartyModel:_setTeammateInfo(info)
	self._teammateInfo = MiniPartySimplePlayerInfoMO.New()

	self._teammateInfo:init(info)
end

function MiniPartyModel:_setFriendTeams(info)
	self._friendTeams = {}

	for _, friendInfo in ipairs(info) do
		local mo = MiniPartyFriendMO.New()

		mo:init(friendInfo)
		table.insert(self._friendTeams, mo)
	end
end

function MiniPartyModel:_setInviteInfos(info)
	self._inviteInfos = {}

	for _, inviteInfo in ipairs(info) do
		local mo = MiniPartyInviteMO.New()

		mo:init(inviteInfo)
		table.insert(self._inviteInfos, mo)
	end
end

function MiniPartyModel:getTeammateInfo()
	return self._teammateInfo
end

function MiniPartyModel:hasGrouped()
	if not self._teammateInfo then
		return false
	end

	if LuaUtil.isEmptyStr(self._teammateInfo.userId) then
		return false
	end

	if tonumber(self._teammateInfo.userId) and tonumber(self._teammateInfo.userId) > 0 then
		return true
	end

	return false
end

function MiniPartyModel:getInviteCode()
	return self._inviteCode
end

function MiniPartyModel:getFriendTeams()
	for i = #self._friendTeams, 1, -1 do
		local friendMo = SocialModel.instance:getPlayerMO(self._friendTeams[i].friendUid)

		if not friendMo then
			table.remove(self._friendTeams, i)
		end
	end

	table.sort(self._friendTeams, function(a, b)
		local aSort = a.isTeam and 0 or 1
		local bSort = b.isTeam and 0 or 1

		if aSort ~= bSort then
			return bSort < aSort
		end

		local aFriendMo = SocialModel.instance:getPlayerMO(a.friendUid)
		local bFriendMo = SocialModel.instance:getPlayerMO(b.friendUid)
		local timeSortA = tonumber(aFriendMo.time) == 0 and ServerTime.now() or tonumber(aFriendMo.time) / 1000
		local timeSortB = tonumber(bFriendMo.time) == 0 and ServerTime.now() or tonumber(bFriendMo.time) / 1000

		if timeSortA ~= timeSortB then
			return timeSortB < timeSortA
		end

		if aFriendMo.level ~= bFriendMo.level then
			return aFriendMo.level > bFriendMo.level
		end
	end)

	return self._friendTeams
end

function MiniPartyModel:getInviteInfos()
	table.sort(self._inviteInfos, function(a, b)
		local timeSortA = tonumber(a.friendInfo.time) == 0 and ServerTime.now() or tonumber(a.friendInfo.time) / 1000
		local timeSortB = tonumber(b.friendInfo.time) == 0 and ServerTime.now() or tonumber(b.friendInfo.time) / 1000

		if timeSortA ~= timeSortB then
			return timeSortB < timeSortA
		end

		if a.inviteTime ~= b.inviteTime then
			return a.inviteTime > b.inviteTime
		end

		if a.level ~= b.level then
			return a.level > b.level
		end
	end)

	return self._inviteInfos
end

function MiniPartyModel:setCurInviteType(type)
	self._curInviteType = type
end

function MiniPartyModel:getCurInviteType()
	if not self._curInviteType or self._curInviteType < 1 then
		self._curInviteType = MiniPartyEnum.InviteType.Code
	end

	return self._curInviteType
end

function MiniPartyModel:setAllInviteChecked()
	if self._inviteInfos then
		local friendList = {}

		for _, info in ipairs(self._inviteInfos) do
			table.insert(friendList, info.friendInfo.userId)
		end

		local friendStr = table.concat(friendList, "#")

		PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LaplaceMiniPartyInviteFriendList), friendStr)
	end
end

function MiniPartyModel:getAllUncheckInviteCount()
	local hasGrouped = self:hasGrouped()

	if hasGrouped then
		return 0
	end

	local count = 0
	local friendStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LaplaceMiniPartyInviteFriendList), "")
	local friendList = string.splitToNumber(friendStr, "#")

	if self._inviteInfos then
		for _, info in ipairs(self._inviteInfos) do
			local containKey = LuaUtil.tableContains(friendList, tonumber(info.friendInfo.userId))

			if not containKey then
				count = count + 1
			end
		end
	end

	return count
end

MiniPartyModel.instance = MiniPartyModel.New()

return MiniPartyModel
