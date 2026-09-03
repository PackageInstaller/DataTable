-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/model/TSoul.lua

TSoul = class("TSoul", objectlua.Object, _M)

TSoul:has("_id", {
	is = "rw"
})
TSoul:has("_configId", {
	is = "rw"
})
TSoul:has("_rarity", {
	is = "rw"
})
TSoul:has("_baseAttr", {
	is = "rw"
})
TSoul:has("_addAttr", {
	is = "rw"
})
TSoul:has("_levelId", {
	is = "rw"
})
TSoul:has("_level", {
	is = "rw"
})
TSoul:has("_exp", {
	is = "rw"
})
TSoul:has("_lock", {
	is = "rw"
})
TSoul:has("_heroId", {
	is = "rw"
})
TSoul:has("_config", {
	is = "rw"
})
TSoul:has("_effect", {
	is = "rw"
})

local Tsoul_LevelMax = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_LevelMax", "content")

function TSoul:initialize(id)
	super.initialize(self)

	self._id = id
	self._configId = ""
	self._heroId = ""
	self._levelId = ""
	self._exp = 0
	self._level = 0
	self._lock = true
	self._config = {}
	self._baseAttr = {}
	self._addAttr = {}
	self._effect = nil
	self._rarity = 0
end

function TSoul:synchronize(data)
	if not data then
		return
	end

	if data.id then
		self._id = data.id
	end

	if data.baseId then
		self._configId = data.baseId
		self._config = ConfigReader:getRecordById("Tsoul", self._configId)
	end

	if data.heroId then
		self._heroId = data.heroId
	end

	if data.levelId then
		self._levelId = data.levelId
	end

	if data.level then
		self._level = data.level
	end

	if data.baseAttr then
		self._baseAttr = data.baseAttr
	end

	if data.addAttr then
		for k, v in pairs(data.addAttr) do
			self._addAttr[k] = v
		end
	end

	if data.exp then
		self._exp = data.exp
	end

	if data.lock ~= nil then
		self._lock = data.lock
	end

	if data.rarity then
		self._rarity = data.rarity
	end
end

function TSoul:getRarity()
	return self._rarity
end

function TSoul:getLock()
	return self._lock
end

function TSoul:getAllAttr()
	local ret = {}

	for k, v in pairs(self._baseAttr) do
		ret[k] = ret[k] or 0
		ret[k] = ret[k] + v
	end

	for k, v in pairs(self._addAttr) do
		ret[k] = ret[k] or 0
		ret[k] = ret[k] + v
	end

	dump(ret, "============ getAllAttr")

	return ret
end

function TSoul:getName()
	return Strings:get(self._config.Name)
end

function TSoul:getDesc()
	return ""
end

function TSoul:getSort()
	return self._config.Sort
end

local TSoulIconFile = "asset/items/"

function TSoul:getIcon()
	return TSoulIconFile .. self._config.Icon .. ".png"
end

function TSoul:getShowIcon()
	return TSoulIconFile .. self._config.Showicon .. ".png"
end

function TSoul:getPosition()
	return self._config.Type
end

function TSoul:getOccupation()
	return self._config.Profession
end

function TSoul:getHeroLimit()
	return self._config.HeroLimit
end

function TSoul:getConfigBaseAttr()
	return self._config.Baseattr
end

function TSoul:getBaseAttrNum()
	return self._config.Baseattrnum
end

function TSoul:getMaxAttrNum()
	return self._config.Attrnum or 0
end

function TSoul:getSuitId()
	return self._config.Suitid
end

function TSoul:getSuitData()
	if self._config.Suitid then
		return ConfigReader:getRecordById("TsoulSuit", self._config.Suitid)
	end

	return nil
end

function TSoul:getMaxLevel()
	return Tsoul_LevelMax[tostring(self._config.Rareity)] or 0
end

function TSoul:getIsMaxLevel()
	return self._level >= self:getMaxLevel()
end
