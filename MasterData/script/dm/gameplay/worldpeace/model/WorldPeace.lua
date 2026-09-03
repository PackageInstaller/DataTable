-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/model/WorldPeace.lua

WorldPeace = class("WorldPeace", objectlua.Object)

WorldPeace:has("_isSign", {
	is = "rw"
})
WorldPeace:has("_clubLevel", {
	is = "rw"
})
WorldPeace:has("_clubCon", {
	is = "rw"
})
WorldPeace:has("_groupNames", {
	is = "rw"
})
WorldPeace:has("_memberRankList", {
	is = "rw"
})
WorldPeace:has("_matchGroup", {
	is = "rw"
})
WorldPeace:has("_matchGroupChat", {
	is = "rw"
})
WorldPeace:has("_groupPlayerRank", {
	is = "rw"
})
WorldPeace:has("_rewardStatus", {
	is = "rw"
})
WorldPeace:has("_clubRankList", {
	is = "rw"
})
WorldPeace:has("_status", {
	is = "rw"
})
WorldPeace:has("_battleFieldId", {
	is = "rw"
})
WorldPeace:has("_battleGroup", {
	is = "rw"
})
WorldPeace:has("_matched", {
	is = "rw"
})
WorldPeace:has("_bossList", {
	is = "rw"
})
WorldPeace:has("_joinDay", {
	is = "rw"
})
WorldPeace:has("_joinChatDay", {
	is = "rw"
})
WorldPeace:has("_resultShowData", {
	is = "rw"
})
WorldPeace:has("_clubChatReward", {
	is = "rw"
})
WorldPeace:has("_chatPlayerRewards", {
	is = "rw"
})
WorldPeace:has("_clubPoint", {
	is = "rw"
})
WorldPeace:has("_clubRankMap", {
	is = "rw"
})

WPRewardType = {
	kClubSeason = 4,
	kMemberHurt = 2,
	kPersonTask = 10,
	kClubDaily = 1
}
WPStatus = {
	kApply = 1,
	kBattle = 4,
	kResultShow = 5,
	kPrepare = 2,
	kBattleRest = 3
}
WPChatStatue = {
	kChat1 = 1,
	kChat2 = 2
}

function WorldPeace:initialize(id)
	super.initialize(self)

	self._id = id
	self._isSign = false
	self._clubLevel = 0
	self._clubCon = 0
	self._groupNames = {}
	self._memberRankList = {}
	self._clubRankList = {}
	self._status = 1
	self._rewardStatus = {}
	self._matchGroup = {}
	self._battleGroup = {}
	self._matched = false
	self._bossList = {}
	self.clubPoint = {}
	self._resultShowData = {}
	self._clubRankMap = {}
end

function WorldPeace:synchronize(data)
	if not data then
		return
	end

	if data.isSign ~= nil then
		self._isSign = data.isSign
	end

	if data.clubLevel ~= nil then
		self._clubLevel = data.clubLevel
	end

	if data.clubCon ~= nil then
		self._clubCon = data.clubCon
	end

	if data.groupNames ~= nil then
		self._groupNames = data.groupNames
	end

	if data.matchGroup ~= nil then
		self._matchGroup = data.matchGroup
		self._matchGroupChat = data.matchGroup

		table.sort(self._matchGroup, function(a, b)
			return a.totalCombat > b.totalCombat
		end)
	end

	if data.groupNum ~= nil then
		self._clubRankList = data.groupNum
	end

	if data.groupPlayerRank ~= nil then
		self._memberRankList = data.groupPlayerRank
	end

	if data.rewardStatus ~= nil then
		self._rewardStatus = data.rewardStatus
	end

	if data.status ~= nil then
		self._status = data.status
	end

	if data.joinDay ~= nil then
		self._joinDay = data.joinDay
	end

	if data.joinChatDay ~= nil then
		self._joinChatDay = data.joinChatDay
	end

	if data.battleFieldId ~= nil then
		self._battleFieldId = data.battleFieldId
	end

	if data.battleInfo then
		self._battleGroup = {}

		for k, v in pairs(data.battleInfo) do
			self._battleGroup[#self._battleGroup + 1] = v
		end

		table.sort(self._battleGroup, function(a, b)
			return a.totalCombat > b.totalCombat
		end)
	end

	if data.matched ~= nil then
		self._matched = data.matched
	end

	if data.clubChatReward ~= nil then
		self._clubChatReward = data.clubChatReward
	end

	if data.chatPlayerRewards ~= nil then
		self._chatPlayerRewards = data.chatPlayerRewards
	end

	if data.bossInfo then
		for k, v in pairs(data.bossInfo) do
			self._bossList[k] = self._bossList[k] or Boss:new(k)

			self._bossList[k]:synchronize(v)
		end
	end

	if data.firstGroup then
		self._resultShowData.firstGroup = data.firstGroup
	end

	if data.firstPlayer then
		self._resultShowData.firstPlayer = data.firstPlayer
	end

	if data.myScore then
		self._resultShowData.myScore = data.myScore
	end

	if data.myScoreRank then
		self._resultShowData.myScoreRank = data.myScoreRank
	end

	if data.myKill then
		self._resultShowData.myKill = data.myKill
	end

	if data.myKillRank then
		self._resultShowData.myKillRank = data.myKillRank
	end

	if data.clubRank then
		self._resultShowData.clubRank = data.clubRank
	end

	if data.groupRank and next(data.groupRank) then
		self._resultShowData.groupRank = data.groupRank

		table.sort(self._resultShowData.groupRank, function(a, b)
			return a.rank < b.rank
		end)
	end
end

function WorldPeace:syncClubRankData(data)
	if not data then
		return
	end

	if data.clubPoint ~= nil then
		self._clubPoint = data.clubPoint
	end

	if data.clubRank then
		self._clubRankMap = data.clubRank
	end

	if data.clubChatReward ~= nil then
		self._clubChatReward = data.clubChatReward
	end
end

function WorldPeace:syncMatchGroup(data)
	self._matchGroup = {}

	for k, v in pairs(data) do
		self._matchGroup[#self._matchGroup + 1] = v
	end

	table.sort(self._matchGroup, function(a, b)
		return a.totalCombat > b.totalCombat
	end)
end

function WorldPeace:getMemberDataByRid(rid)
	for i, v in pairs(self._memberRankList) do
		if v.rid == rid then
			return v
		end
	end
end

function WorldPeace:getShowGroupNames()
	local serverNum = table.nums(self._groupNames)
	local list = {}
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapFakeGuild", "content")

	if serverNum < 20 then
		local function inList(index)
			for i, v in pairs(list) do
				if v == index then
					return true
				end
			end
		end

		local function random()
			local index = math.random(1, #config)

			if inList(index) then
				random()

				return
			end

			list[#list + 1] = index

			if serverNum + #list < 20 then
				random()
			end
		end

		random()
	end

	local showList = {}

	for k, v in pairs(self._groupNames) do
		showList[#showList + 1] = "S" .. v .. "." .. k
	end

	for i, v in pairs(list) do
		showList[#showList + 1] = Strings:get(config[v])
	end

	return showList
end

function WorldPeace:getRewardStatusByType(type)
	return self._rewardStatus[tostring(type)] or 0
end

function WorldPeace:clearData()
	self._matchGroup = {}
	self._battleGroup = {}
	self._resultShowData = {}
end

function WorldPeace:clearCLubRankData()
	self._clubChatReward = {}
	self._clubPoint = {}
end
