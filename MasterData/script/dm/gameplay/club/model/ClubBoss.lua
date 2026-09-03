-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/ClubBoss.lua

ClubBossTVType = {
	kLuxury = 3,
	kMiddle = 2,
	kDefault = 0,
	kNormal = 1
}
ClubBossHurtRewardStatus = {
	kCanGet = 2,
	kCannotGetButTip = 4,
	kHadGet = 3,
	kCanNotGet = 1
}
ClubBoss = class("ClubBoss", objectlua.Object, _M)

ClubBoss:has("_open", {
	is = "r"
})
ClubBoss:has("_season", {
	is = "r"
})
ClubBoss:has("_hurtTarget", {
	is = "r"
})
ClubBoss:has("_hurt", {
	is = "r"
})
ClubBoss:has("_nowPoint", {
	is = "r"
})
ClubBoss:has("_nowPointNum", {
	is = "r"
})
ClubBoss:has("_hpRate", {
	is = "r"
})
ClubBoss:has("_passAll", {
	is = "r"
})
ClubBoss:has("_tips", {
	is = "r"
})
ClubBoss:has("_curRound", {
	is = "r"
})
ClubBoss:has("_score", {
	is = "r"
})
ClubBoss:has("_roundInfo", {
	is = "r"
})
ClubBoss:has("_bossFightTimes", {
	is = "r"
})
ClubBoss:has("_bossFightTimesUpdataTime", {
	is = "r"
})
ClubBoss:has("_joinPoint", {
	is = "r"
})
ClubBoss:has("_hasGetAwards", {
	is = "r"
})
ClubBoss:has("_tiredHero", {
	is = "r"
})
ClubBoss:has("_hasGetHurtAward", {
	is = "r"
})
ClubBoss:has("_readTipTime", {
	is = "r"
})
ClubBoss:has("_team", {
	is = "r"
})
ClubBoss:has("_lastTeam", {
	is = "r"
})
ClubBoss:has("_lastFightTime", {
	is = "r"
})
ClubBoss:has("_name", {
	is = "r"
})
ClubBoss:has("_monsterHpAddRate", {
	is = "r"
})
ClubBoss:has("_isRestState", {
	is = "rw"
})

function ClubBoss:initialize()
	super.initialize(self)

	self._open = false
	self._season = ""
	self._hurtTarget = 0
	self._hurt = 0
	self._nowPoint = ""
	self._curRound = 1
	self._nowPointNum = 1
	self._hpRate = 0
	self._passAll = false
	self._allBossPoints = {}
	self._tips = {}
	self._passedPointMap = {}
	self._roundInfo = {}
	self._score = {}
	self._bossFightTimes = 0
	self._bossFightTimesUpdataTime = 0
	self._joinPoint = 0
	self._hasGetAwards = {}
	self._tiredHero = {}
	self._hasGetHurtAward = false
	self._readTipTime = 0
	self._team = {}
	self._lastTeam = {}
	self._lastFightTime = 0
	self._name = Strings:get("clubBoss_TeamName")
end

function ClubBoss:cleanData()
	self._passedPointMap = {}
	self._roundInfo = {}
end

function ClubBoss:sync(data, scoreData)
	if data.open ~= nil then
		self._open = data.open
	end

	if data.season then
		self._season = data.season
	end

	if data.hurtTarget then
		self._hurtTarget = data.hurtTarget
	end

	if data.hurt then
		self._hurt = data.hurt
	end

	if data.nowPointId then
		self._nowPoint = data.nowPointId

		local ids = string.split(self._nowPoint, "_")

		self._nowPointNum = (tonumber(ids[1]) - 1) * 6 + tonumber(ids[2])
	end

	if data.curRound then
		self._curRound = data.curRound
	end

	if data.passAll ~= nil then
		self._passAll = data.passAll
	end

	if data.hpRate then
		self._hpRate = data.hpRate
	end

	if data.monsterHpAddRate then
		self._monsterHpAddRate = data.monsterHpAddRate
	end

	if data.clubBossPointMap then
		for index, dataValue in pairs(data.clubBossPointMap) do
			if self._allBossPoints[index] == nil then
				local oneBossPoint = ClubBossPoint:new(index)

				oneBossPoint:syncPassInfo(dataValue)
				oneBossPoint:setMonsterHpAddRate(self._monsterHpAddRate)

				self._allBossPoints[index] = oneBossPoint
			else
				self._allBossPoints[index]:syncPassInfo(dataValue)
			end
		end
	end

	if data.roundInfo then
		for k, v in pairs(data.roundInfo) do
			self._roundInfo[k] = v
		end
	end

	if data.passedPointMap then
		for k, v in pairs(data.passedPointMap) do
			self._passedPointMap[k] = v
		end
	end

	if data.tips then
		self._tips = {}

		for ttype, tlist in pairs(data.tips) do
			local ntype = tonumber(ttype)

			self._tips[ntype] = self._tips[ntype] or {}

			for _, vtip in ipairs(tlist) do
				local bossTip = ClubBossTip:new()

				bossTip:sync(vtip)
				table.insert(self._tips[ntype], bossTip)
			end
		end
	end

	if scoreData ~= nil then
		self._score = scoreData
	end
end

function ClubBoss:pushSync(data)
	if data.hurt then
		self._hurt = data.hurt
	end

	if data.pointId then
		local pointId = data.pointId

		if pointId ~= "" and pointId == self._nowPoint and data.rate then
			self._hpRate = data.rate
		end
	end
end

function ClubBoss:syncBasicInfo(data)
	if data.bossFightTimes then
		if data.bossFightTimes.value then
			self._bossFightTimes = data.bossFightTimes.value
		end

		if data.bossFightTimes.updateTime then
			self._bossFightTimesUpdataTime = data.bossFightTimes.updateTime
		end
	end

	if data.joinPointId and data.joinPointId ~= "" then
		local ids = string.split(data.joinPointId, "_")

		self._joinPoint = (tonumber(ids[1]) - 1) * 6 + tonumber(ids[2])
	end

	if data.getAwardsPointIdSet then
		self._hasGetAwards = data.getAwardsPointIdSet
	end

	if data.tiredHero then
		self._tiredHero = data.tiredHero
	end

	if data.getHurtAward ~= nil then
		self._hasGetHurtAward = data.getHurtAward
	end

	if data.readTipTime then
		self._readTipTime = data.readTipTime
	end

	if data.team then
		self._team = data.team
	end

	if data.lastteam then
		self._lastTeam = data.lastteam
	end

	if data.lastFightTime then
		self._lastFightTime = data.lastFightTime
	end

	if data.lastJoinTime then
		self._lastJoinTime = data.lastJoinTime
	end

	if data.joinedClubCount then
		self._joinedClubCount = data.joinedClubCount
	end
end

function ClubBoss:isBossPassed(id)
	if self._passedPointMap and self._passedPointMap[id] then
		return true
	end

	return false
end

function ClubBoss:getShowAllBossList(round)
	local result = {}
	local bossIds = self._roundInfo[tostring(round)]

	for i = 1, #bossIds do
		local onePoint = self._allBossPoints[bossIds[i]]

		result[onePoint:getPointNum()] = onePoint
	end

	return result
end

function ClubBoss:checkHasGetHurtAward(id)
	local result = ClubBossHurtRewardStatus.kCanGet
	local ids = string.split(id, "_")
	local pointNum = (tonumber(ids[1]) - 1) * 6 + tonumber(ids[2])

	if pointNum < self._joinPoint then
		result = ClubBossHurtRewardStatus.kCannotGetButTip

		return ClubBossHurtRewardStatus.kCannotGetButTip
	end

	if pointNum > self._nowPointNum then
		result = ClubBossHurtRewardStatus.kCanNotGet

		return ClubBossHurtRewardStatus.kCanNotGet
	end

	for k, onePonitNum in pairs(self._hasGetAwards) do
		if id == onePonitNum then
			result = ClubBossHurtRewardStatus.kHadGet
		end
	end

	return (pointNum == self._nowPointNum or nil) and ClubBossHurtRewardStatus.kCanNotGet
end

function ClubBoss:checkHasGetHurtAwardByNum(pointNum)
	local result = ClubBossHurtRewardStatus.kCanGet

	if pointNum < self._joinPoint then
		result = ClubBossHurtRewardStatus.kCannotGetButTip

		return ClubBossHurtRewardStatus.kCannotGetButTip
	end

	if pointNum > self._nowPointNum then
		result = ClubBossHurtRewardStatus.kCanNotGet

		return ClubBossHurtRewardStatus.kCanNotGet
	end

	for k, onePonit in pairs(self._hasGetAwards) do
		local ids = string.split(onePonit, "_")
		local onePonitNum = (tonumber(ids[1]) - 1) * 6 + tonumber(ids[2])

		if pointNum == onePonitNum then
			result = ClubBossHurtRewardStatus.kHadGet
		end
	end

	return (pointNum == self._nowPointNum or nil) and ClubBossHurtRewardStatus.kCanNotGet
end

function ClubBoss:checkHasRewardCanGet()
	local result = false

	if self._joinPoint > 0 then
		if not self._joinPoint then
			local beganNum = 1

			for pointNum = beganNum, self._nowPointNum do
				if self:checkHasGetHurtAwardByNum(pointNum) == ClubBossHurtRewardStatus.kCanGet then
					result = true

					break
				end
			end

			return result
		end
	end
end

function ClubBoss:checkDelayHurtRewardMark()
	return (self._hurt >= self._hurtTarget and self._hasGetHurtAward == false and self._hurtTarget > 0 or nil) and true
end

function ClubBoss:getAllScore()
	local result = 0

	if self._score then
		for k, v in pairs(self._score) do
			result = result + v
		end
	end

	return result
end

function ClubBoss:getCurrentSeasonConfig()
	return (ConfigReader:getRecordById("ClubBlockArena", self._season))
end

function ClubBoss:getAllBossPointsVector()
	local allBossPointsVector = {}

	for k, v in pairs(self._allBossPoints) do
		allBossPointsVector[getPointNum()] = v
	end

	return allBossPointsVector
end

function ClubBoss:getBossPointsById(id)
	return self._allBossPoints[id]
end

function ClubBoss:getBossPointsByPonitId(pointId)
	for k, v in pairs(self._allBossPoints) do
		if v:getPointId() == pointId then
			return v
		end
	end

	return nil
end

function ClubBoss:getShowTVInfo()
	local showType = ClubBossTVType.kDefault

	for i = ClubBossTVType.kLuxury, ClubBossTVType.kNormal, -1 do
		if self._tips[i] and #self._tips[i] > 0 then
			showType = i

			break
		end
	end

	local tvinfo

	if showType ~= ClubBossTVType.kDefault then
		tvinfo = self._tips[showType][1]

		table.remove(self._tips[showType], 1)
	end

	return showType, tvinfo
end

function ClubBoss:insertTVInfo(tip)
	local type = tip:getType()

	if self._tips and self._tips[type] then
		table.insert(self._tips[type], tip)
	end
end

ClubBossPoint = class("ClubBossPoint", objectlua.Object, _M)

ClubBossPoint:has("_id", {
	is = "r"
})
ClubBossPoint:has("_pointId", {
	is = "r"
})
ClubBossPoint:has("_passTime", {
	is = "r"
})
ClubBossPoint:has("_winIde", {
	is = "r"
})
ClubBossPoint:has("_winName", {
	is = "r"
})
ClubBossPoint:has("_winShowId", {
	is = "r"
})
ClubBossPoint:has("_round", {
	is = "r"
})
ClubBossPoint:has("_num", {
	is = "r"
})
ClubBossPoint:has("_tableConfig", {
	is = "r"
})
ClubBossPoint:has("_blockId", {
	is = "r"
})
ClubBossPoint:has("_monsterHpAddRate", {
	is = "r"
})

function ClubBossPoint:initialize(id)
	super.initialize(self)

	self._id = id
	self._pointId = ""
	self._blockId = ""
	self._passTime = 0
	self._winIde = ""
	self._winName = ""
	self._winShowId = ""
	self._nextId = ""
	self._tableConfig = {}
	self._addRate = 0
end

function ClubBossPoint:setMonsterHpAddRate(rate)
	self._monsterHpAddRate = rate
end

function ClubBossPoint:syncPassInfo(data)
	if data.clubBlockPointId then
		self._pointId = data.clubBlockPointId

		local config = ConfigReader:getRecordById("ClubBlockPoint", self._pointId)

		if config ~= nil then
			self._tableConfig = config
		end
	end

	if data.clubBattleId then
		self._blockId = data.clubBattleId
	end

	if data.nextId then
		self._nextId = data.nextId
	end

	if data.passTime then
		self._passTime = data.passTime
	end

	if data.winId then
		self._winIde = data.winId
	end

	if data.winName then
		self._winName = data.winName
	end

	if data.winShowId then
		self._winShowId = data.winShowId
	end

	if data.round then
		self._round = data.round
	end

	if data.num then
		self._num = data.num
	end

	if data.addRate then
		self._addRate = data.addRate
	end
end

function ClubBossPoint:getPointName()
	return (self._tableConfig ~= nil and self._tableConfig.Name ~= nil or nil) and Strings:get(self._tableConfig.Name)
end

function ClubBossPoint:getPointNum()
	return self._num
end

function ClubBossPoint:getPointType()
	return (self._tableConfig ~= nil and self._tableConfig.Type ~= nil or nil) and self._tableConfig.Type
end

function ClubBossPoint:getZoom()
	return (self._tableConfig ~= nil and self._tableConfig.Amplify ~= nil or nil) and checknumber(self._tableConfig.Amplify)
end

function ClubBossPoint:getNextPoint()
	return (self._tableConfig ~= nil and self._tableConfig.NextPoint ~= nil or nil) and self._tableConfig.NextPoint
end

function ClubBossPoint:getBlockConfig()
	return (ConfigReader:getRecordById("ClubBlockBattle", self._blockId))
end

function ClubBossPoint:getBossHp()
	local config = self:getBlockConfig()
	local masterHp = ConfigReader:getDataByNameIdAndKey("EnemyMaster", config.EnemyMaster, "Hp")
	local hp = masterHp * self._tableConfig.BattleFactor[3]

	if self._monsterHpAddRate > 0 then
		local clubBossStandard = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_Standard", "content")

		if clubBossStandard >= self._tableConfig.Num then
			hp = hp * (1 + self._monsterHpAddRate)
		end
	end

	if self._addRate > 0 then
		hp = hp * self._addRate
	end

	return hp
end

ClubBossTip = class("ClubBossTip", objectlua.Object, _M)

ClubBossTip:has("_type", {
	is = "r"
})
ClubBossTip:has("_name", {
	is = "r"
})
ClubBossTip:has("_gate", {
	is = "r"
})
ClubBossTip:has("_hurt", {
	is = "r"
})
ClubBossTip:has("_heroId", {
	is = "r"
})
ClubBossTip:has("_time", {
	is = "r"
})
ClubBossTip:has("_head", {
	is = "r"
})
ClubBossTip:has("_headFrame", {
	is = "r"
})
ClubBossTip:has("_id", {
	is = "r"
})
ClubBossTip:has("_item", {
	is = "r"
})

function ClubBossTip:initialize()
	super.initialize(self)

	self._type = 0
	self._name = ""
	self._gate = 0
	self._hurt = 0
	self._heroId = ""
	self._time = 0
	self._head = ""
	self._headFrame = ""
	self._id = ""
	self._item = {}
end

function ClubBossTip:sync(data)
	if data.type then
		self._type = data.type
	end

	if data.name then
		self._name = data.name
	end

	if data.gate then
		self._gate = data.gate
	end

	if data.hurt then
		self._hurt = data.hurt
	end

	if data.getHeroId then
		local cjson = require("cjson.safe")
		local logs = cjson.decode(data.getHeroId)

		if logs ~= nil then
			self._item = logs
		else
			self._heroId = data.getHeroId
		end
	end

	if data.time then
		self._time = data.time
	end

	if data.head then
		self._head = data.head
	end

	if data.headFrame then
		self._headFrame = data.headFrame
	end

	if data.id then
		self._id = data.id
	end
end
