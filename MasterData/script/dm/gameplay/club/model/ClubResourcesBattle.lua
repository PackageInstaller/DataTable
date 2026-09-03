-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/ClubResourcesBattle.lua

ClubResourcesBattle = class("ClubResourcesBattle", objectlua.Object)

ClubResourcesBattle:has("_isLoadedData", {
	is = "r"
})
ClubResourcesBattle:has("_configId", {
	is = "r"
})
ClubResourcesBattle:has("_status", {
	is = "r"
})
ClubResourcesBattle:has("_clubId", {
	is = "r"
})
ClubResourcesBattle:has("_clubName", {
	is = "r"
})
ClubResourcesBattle:has("_clubHeadImg", {
	is = "r"
})
ClubResourcesBattle:has("_point", {
	is = "r"
})
ClubResourcesBattle:has("_keyPoints", {
	is = "r"
})
ClubResourcesBattle:has("_win", {
	is = "r"
})
ClubResourcesBattle:has("_players", {
	is = "r"
})
ClubResourcesBattle:has("_canJoin", {
	is = "r"
})
ClubResourcesBattle:has("_gotRewards", {
	is = "r"
})
ClubResourcesBattle:has("_targetClubId", {
	is = "r"
})
ClubResourcesBattle:has("_targetClubName", {
	is = "r"
})
ClubResourcesBattle:has("_targetClubHeadImg", {
	is = "r"
})
ClubResourcesBattle:has("_targetPoint", {
	is = "r"
})
ClubResourcesBattle:has("_targetPlayers", {
	is = "r"
})
ClubResourcesBattle:has("_nextMillis", {
	is = "r"
})

local allResouces = {
	GOLD = {
		type = CurrencyType.kGold,
		id = CurrencyIdKind.kGold
	},
	DIAMOND = {
		type = CurrencyType.kDiamond,
		id = CurrencyIdKind.kDiamond
	},
	CRYSTAL = {
		type = CurrencyType.kCrystal,
		id = CurrencyIdKind.kCrystal
	},
	POWER = {
		type = CurrencyType.kActionPoint,
		id = CurrencyIdKind.kPower
	},
	EXP = {
		type = CurrencyType.kExp,
		id = CurrencyIdKind.kGold
	}
}

function ClubResourcesBattle:initialize()
	super.initialize(self)

	self._isLoadedData = false
	self._configId = ""
	self._status = ""
	self._clubId = ""
	self._clubName = ""
	self._clubHeadImg = ""
	self._point = 0
	self._keyPoints = {}
	self._win = false
	self._players = {}
	self._canJoin = false
	self._gotRewards = {}
	self._targetClubId = ""
	self._targetClubName = ""
	self._targetClubHeadImg = ""
	self._targetPoint = 0
	self._targetPlayers = {}
	self._nextMillis = -1
end

function ClubResourcesBattle:sync(data)
	self._isLoadedData = true

	if data.configId then
		self._configId = data.configId

		if self._configId ~= "" and self._configId ~= nil then
			self._config = ConfigReader:getRecordById("HitCharts", self._configId)

			if self._config.HitChartsConfig then
				self._gitChartsConfig = ConfigReader:getRecordById("HitChartsRank", self._config.HitChartsConfig)
			end
		end
	end

	if data.status then
		self._status = data.status
	end

	if data.clubId then
		self._clubId = data.clubId
	end

	if data.clubName then
		self._clubName = data.clubName
	end

	if data.clubHeadImg then
		self._clubHeadImg = data.clubHeadImg
	end

	if data.point then
		self._point = data.point
	end

	if data.keyPoints then
		self._keyPoints = data.keyPoints
	end

	if data.win ~= nil then
		self._win = data.win
	end

	if data.players then
		self._players = data.players
	end

	if data.canJoin ~= nil then
		self._canJoin = data.canJoin
	end

	if data.gotRewards then
		self._gotRewards = data.gotRewards
	end

	if data.targetClubId then
		self._targetClubId = data.targetClubId
	end

	if data.targetClubName then
		self._targetClubName = data.targetClubName
	end

	if data.targetClubHeadImg then
		self._targetClubHeadImg = data.targetClubHeadImg
	end

	if data.targetPoint then
		self._targetPoint = data.targetPoint
	end

	if data.targetPlayers then
		self._targetPlayers = data.targetPlayers
	end

	if data.nextMillis then
		self._nextMillis = data.nextMillis
	end
end

function ClubResourcesBattle:getResouceBassInfo()
	if self._config == nil then
		return nil
	end

	local data = {}

	if self._config and self._config.UI then
		data = allResouces[self._config.UI]

		if allResouces[self._config.UI] and data.id and data.id ~= "" then
			local config = ConfigReader:getRecordById("ItemConfig", data.id)

			if config and config.Id then
				data.nameDes = config.Name
			end
		end

		data.icon = self._config.Icon
		data.titleName = self._config.Name
		data.Desc_1 = self._config.Desc_1
		data.Desc_2 = self._config.Desc_2
	end

	return data
end

function ClubResourcesBattle:getSelfClubSocreList()
	local list = {}

	for k, value in pairs(self._players) do
		local rankData = {}

		rankData.name = k
		rankData.score = value
		list[#list + 1] = rankData
	end

	table.sort(list, function(a, b)
		return a.score > b.score
	end)

	return list
end

function ClubResourcesBattle:getTargetClubSocreList()
	local list = {}

	for k, value in pairs(self._targetPlayers) do
		local rankData = {}

		rankData.name = k
		rankData.score = value
		list[#list + 1] = rankData
	end

	table.sort(list, function(a, b)
		return a.score > b.score
	end)

	return list
end

function ClubResourcesBattle:getScoreRewardData()
	local rewardBaseShow = self._gitChartsConfig.RewardBaseShow
	local rewardBaseShowList = {}

	for i = 1, #rewardBaseShow do
		local rewardData = {}
		local rewardDataDic = rewardBaseShow[i]

		rewardData.baseRewardEmpty = true

		for k, value in pairs(rewardDataDic) do
			rewardData.baseRewardEmpty = false
			rewardData.rewardId = k
			rewardData.isBaseBig = value
		end

		rewardBaseShowList[#rewardBaseShowList + 1] = rewardData
	end

	local rewardWinShow = self._gitChartsConfig.RewardWinShow
	local rewardWinShowList = {}

	for i = 1, #rewardWinShow do
		local rewardData = {}
		local rewardDataDic = rewardWinShow[i]

		rewardData.winRewardEmpty = true

		for k, value in pairs(rewardDataDic) do
			rewardData.winRewardEmpty = false
			rewardData.rewardId = k
			rewardData.isWinBig = value
		end

		rewardWinShowList[#rewardWinShowList + 1] = rewardData
	end

	local resultList = {}

	for i = 1, #self._keyPoints do
		local resultData = {}

		resultData.targetScore = self._keyPoints[i]
		resultData.index = i

		if i <= #rewardBaseShowList then
			local rewardData_1 = rewardBaseShowList[i]

			resultData.baseRewardEmpty = rewardData_1.baseRewardEmpty

			if rewardData_1.baseRewardEmpty == false then
				resultData.baseRewardId = rewardData_1.rewardId

				local rewards = ConfigReader:getRecordById("Reward", rewardData_1.rewardId).Content

				if rewards then
					resultData.baseRewardData = rewards[1]
					resultData.isBaseRewardBox, resultData.baseBoxRewardId = self:checkHasGetReward(resultData.baseRewardData)
				end

				resultData.baseRewardHasGet = self:checkHasGetReward(rewardData_1.rewardId)

				if self._point >= resultData.targetScore then
					resultData.canBaseReward = true
				end

				resultData.isBaseBig = rewardData_1.isBaseBig
			end
		end

		if i <= #rewardWinShowList then
			local rewardData_2 = rewardWinShowList[i]

			resultData.winRewardEmpty = rewardData_2.winRewardEmpty

			if rewardData_2.winRewardEmpty == false then
				resultData.winRewardId = rewardData_2.rewardId

				local rewards = ConfigReader:getRecordById("Reward", rewardData_2.rewardId).Content

				if rewards then
					resultData.winRewardData = rewards[1]
					resultData.isWinRewardBox, resultData.winBoxRewardId = self:checkIsRewardBox(resultData.winRewardData)
				end

				resultData.winRewardHasGet = self:checkHasGetReward(rewardData_2.rewardId)
				resultData.winScoreEnough = false

				if self._point >= resultData.targetScore then
					resultData.winScoreEnough = true

					if self._status == "END" and self._win == true then
						resultData.canWinReward = true
					end
				end

				resultData.isWinBig = rewardData_2.isWinBig
			end
		end

		resultList[#resultList + 1] = resultData
	end

	return resultList
end

function ClubResourcesBattle:checkHasGetReward(rewardId)
	local result = false

	for k, value in pairs(self._gotRewards) do
		if rewardId == value then
			result = true

			break
		end
	end

	return result
end

function ClubResourcesBattle:checkIsRewardBox(rewardData)
	local result = false
	local resultRewardID = ""

	return result, resultRewardID
end

function ClubResourcesBattle:getStartTimeAndEndTime()
	if self._tiemData == nil then
		local tiemData = {}

		if self._config and self._config.TimeFactor then
			local timeStamp = self._config.TimeFactor
			local _, _, y, mon, d, h, m, s = string.find(timeStamp.start, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
			local table = {
				year = y,
				month = mon,
				day = d,
				hour = h,
				min = m,
				sec = s
			}
			local startTime = TimeUtil:timeByRemoteDate(table)
			local _, _, y, mon, d, h, m, s = string.find(timeStamp["end"], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
			local table = {
				year = y,
				month = mon,
				day = d,
				hour = h,
				min = m,
				sec = s
			}

			tiemData.startTime = startTime
			tiemData.endTime = TimeUtil:timeByRemoteDate(table)
			self._tiemData = tiemData
		end
	end

	return self._tiemData
end
