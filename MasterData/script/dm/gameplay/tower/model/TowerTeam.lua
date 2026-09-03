-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/model/TowerTeam.lua

TowerTeam = class("TowerTeam", objectlua.Object, _M)

TowerTeam:has("_master", {
	is = "rw"
})
TowerTeam:has("_teamHeroes", {
	is = "rw"
})
TowerTeam:has("_unTeamHeroes", {
	is = "rw"
})
TowerTeam:has("_allHeroes", {
	is = "rw"
})
TowerTeam:has("_maxBaseValue", {
	is = "rw"
})
TowerTeam:has("_minBaseValue", {
	is = "rw"
})
TowerTeam:has("_avgBaseValue", {
	is = "rw"
})

function TowerTeam:initialize()
	super.initialize(self)

	self._master = nil
	self._teamHeroes = {}
	self._unTeamHeroes = {}
	self._allHeroes = {}
	self._maxBaseValue = 0
	self._minBaseValue = 0
	self._avgBaseValue = 0
end

function TowerTeam:synchronize(data)
	if data.master then
		self._master = self._master or TowerMaster:new()

		self._master:synchronize(data.master)
	end

	if data.allHeroes then
		for id, value in pairs(data.allHeroes) do
			if not self._allHeroes[id] then
				local player = DmGame:getInstance()._injector:getInstance("DevelopSystem"):getPlayer()

				self._allHeroes[id] = TowerHero:new(id, player)
			end

			self._allHeroes[id]:synchronize(value)
		end

		self:initUnTeamHeroes()
	end

	if data.teamHeroes then
		if #data.teamHeroes <= 1 then
			self._teamHeroes = {}
		end

		for index, value in pairs(data.teamHeroes) do
			self._teamHeroes[index + 1] = value
		end

		self:initUnTeamHeroes()
	end

	if data.maxBaseValue then
		self._maxBaseValue = data.maxBaseValue
	end

	if data.minBaseValue then
		self._minBaseValue = data.minBaseValue
	end

	if data.avgBaseValue then
		self._avgBaseValue = data.avgBaseValue
	end
end

function TowerTeam:initUnTeamHeroes()
	self._unTeamHeroes = {}

	for id, towerHero in pairs(self._allHeroes) do
		local h = table.indexof(self._teamHeroes, id)

		if not h then
			self._unTeamHeroes[#self._unTeamHeroes + 1] = id
		end
	end
end

function TowerTeam:sortOnTeamPets(idList, sortType)
	local StarBuffNum = tonumber(ConfigReader:getRecordById("ConfigValue", "Tower_1_Star_Buff_Minimum_Star").content)

	table.sort(idList, function(a, b)
		local infoA = self:getHeroInfoById(a)
		local infoB = self:getHeroInfoById(b)
		local awakenLevelA = infoA:getAwakenLevel()
		local awakenLevelB = infoB:getAwakenLevel()
		local starA = infoA:getStar() >= StarBuffNum and 1 or 0
		local starB = infoB:getStar() >= StarBuffNum and 1 or 0

		if awakenLevelA == awakenLevelB then
			if starA == starB then
				if infoA:getCombat() == infoB:getCombat() then
					if infoA:getRarity() == infoB:getRarity() then
						return infoA:getExp() > infoB:getExp()
					end

					return infoA:getRarity() > infoB:getRarity()
				end

				return infoA:getCombat() > infoB:getCombat()
			else
				return starB < starA
			end
		else
			return awakenLevelB < awakenLevelA
		end
	end)
end

KOrderType = {
	Aoe = 4,
	Attack = 7,
	Support = 2,
	Curse = 1,
	Defense = 6,
	Summon = 3,
	Cure = 5
}

function TowerTeam:sortStrengthPets(idList)
	table.sort(idList, function(a, b)
		local infoA = self:getHeroInfoById(a)
		local infoB = self:getHeroInfoById(b)
		local typeA = KOrderType[infoA:getType()]
		local typeB = KOrderType[infoB:getType()]

		if infoA:getRarity() == infoB:getRarity() then
			if typeA == typeB then
				if infoA:getBaseId() == infoB:getBaseId() then
					if infoA:getCombat() == infoB:getCombat() then
						return false
					end

					return infoA:getCombat() > infoB:getCombat()
				end

				return infoA:getBaseId() > infoB:getBaseId()
			end

			return typeB < typeA
		end

		return infoA:getRarity() > infoB:getRarity()
	end)
end

function TowerTeam:getHeroInfoById(id)
	return self._allHeroes[id]
end

function TowerTeam:hasSamePet(idList, targetId)
	local infoA = self:getHeroInfoById(targetId)

	for index, heroId in pairs(idList) do
		local infoB = self:getHeroInfoById(heroId)

		if infoA:getBaseId() == infoB:getBaseId() then
			return true
		end
	end

	return false
end

function TowerTeam:getTeamSpecialSound(targetId, ids)
	local heroIds = {}

	for k, v in pairs(ids) do
		heroIds[#heroIds + 1] = self:getHeroInfoById(targetId):getBaseId()
	end

	local hero = self:getHeroInfoById(targetId)
	local specialSounds = hero:getTeamSpecialVoice()
	local sounds = {}

	for id, sound in pairs(specialSounds) do
		if table.indexof(heroIds, id) then
			sounds[#sounds + 1] = sound
		end
	end

	local length = #sounds

	if length > 0 then
		local index = math.random(1, length)

		return sounds[index]
	end

	return nil
end

function TowerTeam:deleteTeam(data)
	for k, v in pairs(data) do
		if k == "teamHeroes" then
			for heroId, _ in pairs(v) do
				self._teamHeroes[heroId] = nil
			end

			self:initUnTeamHeroes()
		elseif k == "allHeroes" then
			for heroId, _ in pairs(v) do
				self._allHeroes[heroId] = nil
			end
		end
	end
end

function TowerTeam:getMasterId()
	if self._master then
		return self._master:getId()
	end

	return nil
end

function TowerTeam:getTeamHero()
	return self._teamHeroes
end

function TowerTeam:getTeamHeroNum()
	local num = 0

	if self._teamHeroes then
		for _, v in pairs(self._teamHeroes) do
			num = num + 1
		end
	end

	return num
end
