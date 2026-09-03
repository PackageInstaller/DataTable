-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreZombieHero.lua

require("dm.gameplay.develop.model.hero.Hero")

ExploreZombieHero = class("ExploreZombieHero", objectlua.Object, _M)

ExploreZombieHero:has("_id", {
	is = "r"
})
ExploreZombieHero:has("_pointId", {
	is = "r"
})
ExploreZombieHero:has("_configId", {
	is = "r"
})
ExploreZombieHero:has("_zombieSkills", {
	is = "r"
})
ExploreZombieHero:has("_attrDegree", {
	is = "r"
})
ExploreZombieHero:has("_level", {
	is = "r"
})
ExploreZombieHero:has("_exp", {
	is = "r"
})

function ExploreZombieHero:initialize()
	super.initialize(self)

	self._id = ""
	self._pointId = ""
	self._configId = ""
	self._zombieSkills = {}
	self._exp = 0
	self._attrDegree = 0
	self._level = 0
end

function ExploreZombieHero:synchronizeZombie(data)
	if data.id then
		self._id = data.id
	end

	if data.pointId then
		self._pointId = data.pointId
	end

	if data.configId then
		self._configId = data.configId
	end

	if data.zombieSkills then
		self._zombieSkills = data.zombieSkills
	end

	if data.exp then
		self._exp = data.exp
	end

	if data.attrDegree then
		self._attrDegree = data.attrDegree
	end

	if data.level then
		self._level = data.level
	end
end

function ExploreZombieHero:getCombat()
	local pointId = self._pointId
	local configId = self._configId
	local attrDegree = self._attrDegree
	local level = self._level
	local key = ConfigReader:getDataByNameIdAndKey("MapPoint", pointId, "MechanismValue").ZombiesValue
	local data = ConfigReader:getDataByNameIdAndKey("MapMechanismValue", key, "content")
	local config = data[configId]
	local atk = config.atk
	local hp = config.hp
	local def = config.def
	local speed = config.speed
	local combat = config.combat
	local attrData = {
		hurtRate = 0,
		critRate = 0,
		reflection = 0,
		skillLevel = 0,
		blockRate = 0,
		blockStrg = 0,
		unblockRate = 0,
		uncritRate = 0,
		unhurtRate = 0,
		critStrg = 0,
		absorption = 0,
		star = 0,
		attack = math.floor(atk[level] * attrDegree),
		defense = math.floor(def[level] * attrDegree),
		hp = math.floor(hp[level] * attrDegree),
		speed = math.floor(speed[level] * attrDegree)
	}
	local combat = math.floor(combat[level] * attrDegree)

	return combat, attrData
end
