-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/model/Tower.lua

require("dm.gameplay.tower.model.TowerTeam")

Tower = class("Tower", objectlua.Object)

Tower:has("_towerId", {
	is = "r"
})
Tower:has("_enterTimes", {
	is = "r"
})
Tower:has("_initMasters", {
	is = "r"
})
Tower:has("_reviveTimes", {
	is = "r"
})
Tower:has("_lastMasterId", {
	is = "r"
})
Tower:has("_status", {
	is = "r"
})
Tower:has("_team", {
	is = "r"
})
Tower:has("_monsters", {
	is = "r"
})
Tower:has("_monsterBase", {
	is = "r"
})
Tower:has("_gotBuffs", {
	is = "r"
})
Tower:has("_pointBuffs", {
	is = "r"
})
Tower:has("_pointCards", {
	is = "r"
})
Tower:has("_towerBase", {
	is = "r"
})
Tower:has("_allCompseHeros", {
	is = "rw"
})

function Tower:initialize()
	super.initialize(self)

	self._towerId = ""
	self._enterTimes = 0
	self._initMasters = {}
	self._reviveTimes = 0
	self._lastMasterId = 0
	self._status = 0
	self._monsters = {}
	self._gotBuffs = {}
	self._pointBuffs = {}
	self._pointCards = {}
	self._monsterBase = 0
	self._allCompseHeros = {}
end

function Tower:synchronize(data)
	if data.towerId then
		self._towerId = data.towerId
		self._towerBase = self._towerBase or TowerBase:new(self._towerId)
	end

	if data.enterTimes then
		self._enterTimes = data.enterTimes
	end

	if data.reviveTimes then
		self._reviveTimes = data.reviveTimes
	end

	if data.initMasters then
		self._initMasters = {}

		for k, towerMasterId in pairs(data.initMasters) do
			local master = TowerMaster:new()

			master:synchronize({
				configId = towerMasterId
			})

			self._initMasters[#self._initMasters + 1] = master
		end
	end

	if data.lastMasterId then
		self._lastMasterId = data.lastMasterId
	end

	if data.status then
		self._status = data.status
	end

	if data.team then
		self._team = self._team or TowerTeam:new()

		self._team:synchronize(data.team)
	end

	if data.monsters then
		for k, v in pairs(data.monsters) do
			local index = k + 1

			self._monsters[index] = self._monsters[index] or TowerPoint:new(v.pointId)

			self._monsters[index]:synchronize(v)
		end
	end

	if data.monsterBase then
		self._monsterBase = data.monsterBase
	end

	if data.gotBuffs then
		self._gotBuffs = {}

		for i, v in pairs(data.gotBuffs) do
			table.insert(self._gotBuffs, v)
		end
	end

	if data.pointBuffs then
		self._pointBuffs = data.pointBuffs
	end

	if data.pointCards then
		for k, v in pairs(data.pointCards) do
			self._pointCards[k] = {}

			for id, data in pairs(v) do
				local hero = TowerHero:new(id)

				hero:synchronize(data)
				table.insert(self._pointCards[k], hero)
			end
		end
	end

	if data.allCompseHeros then
		self._allCompseHeros = data.allCompseHeros

		for k, v in pairs(self._allCompseHeros) do
			for heroId, value in pairs(self._team:getAllHeroes()) do
				if value:getBaseId() == k then
					value:synchronize({
						allCompseHeros = v
					})
				end
			end
		end
	end
end

function Tower:getInitMasterDataByMasterId(masterId)
	for k, v in pairs(self._initMasters) do
		if v:getId() == masterId then
			return v
		end
	end

	return nil
end

function Tower:getBattleIndex()
	for i, v in ipairs(self._monsters) do
		if not v:getWin() then
			return v:getIndex()
		end
	end
end

function Tower:getBattlePointData()
	for i, v in ipairs(self._monsters) do
		if not v:getWin() then
			return v
		end
	end
end

function Tower:getTowerName()
	return Strings:get(self._towerBase:getConfig().Name)
end

function Tower:deleteTower(data)
	for key, v in pairs(data) do
		if key == "initMasters" then
			self:deleteMasters()
		elseif key == "team" then
			self:deleteTeam(v)
		elseif key == "monsters" then
			self:deleteMonsters()
		elseif key == "pointBuffs" then
			self._pointBuffs = {}
		elseif key == "gotBuffs" then
			self._gotBuffs = {}
		elseif key == "pointCards" then
			self._pointCards = {}
		end
	end
end

function Tower:deleteMasters()
	for i = 1, #self._initMasters do
		self._initMasters[i] = nil
	end
end

function Tower:deleteMonsters()
	for i = 1, #self._monsters do
		self._monsters[i] = nil
	end
end

function Tower:deleteTeam(data)
	self._team:deleteTeam(data)
end

function Tower:getTeam()
	return self._team
end

function Tower:getChallengeNum()
	return self._towerBase:getConfig().ChallengeNum
end

function Tower:getPointRewardList()
	local rewardList = {}

	for k, point in pairs(self._monsters) do
		local pointIndx = point:getIndex()

		if point:getWin() then
			rewardList[pointIndx + 1] = point:getRewardList()
		end
	end

	return rewardList
end

function Tower:getMaxExpAwardList()
	local rewardList = {}

	for heroId, value in pairs(self._team:getAllHeroes()) do
		local reward = value:getMaxExpAward()

		if reward then
			local isHave = false

			for k, v in pairs(rewardList) do
				if v.code == reward.code then
					isHave = true
					v.amount = math.max(reward.amount, v.amount)

					break
				end
			end

			if not isHave and reward.amount > 0 then
				rewardList[#rewardList + 1] = reward
			end
		end
	end

	table.sort(rewardList, function(a, b)
		local QualityA = ConfigReader:getRecordById("ItemConfig", a.code).Quality
		local QualityB = ConfigReader:getRecordById("ItemConfig", b.code).Quality

		return QualityB < QualityA
	end)

	return rewardList
end

function Tower:getTowerLoadingType()
	return self._towerBase:getConfig().LoadingType
end
