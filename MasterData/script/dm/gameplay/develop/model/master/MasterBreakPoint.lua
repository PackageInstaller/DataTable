-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterBreakPoint.lua

MasterBreakPoint = class("MasterBreakPoint", objectlua.Object, _M)

MasterBreakPoint:has("_config", {
	is = "r"
})
MasterBreakPoint:has("_breakPointId", {
	is = "rw"
})
MasterBreakPoint:has("_breakPointLevel", {
	is = "rw"
})
MasterBreakPoint:has("_list", {
	is = "r"
})
MasterBreakPoint:has("_map", {
	is = "r"
})
MasterBreakPoint:has("_effects", {
	is = "r"
})
MasterBreakPoint:has("_headMap", {
	is = "r"
})
MasterBreakPoint:has("_breakPointMap", {
	is = "r"
})

function MasterBreakPoint:initialize(owner, player)
	super.initialize(self)

	self._owner = owner
	self._player = player
	self._masterId = owner:getId()
	self._breakPointId = "Master_PowerBreaking_1"
	self._breakPointLevel = 0
	self._config = ConfigReader:getRecordById("MasterPowerBreaking", self._breakPointId)
	self._effects = {}
	self._headMap = {}
	self._breakPointMap = {}
	self._sortList = {}
	self._map = {}
	self._list = {}

	self:sortedList()
	self:createBreakHeadMap()
	self:createBreakAttrList()
	self:createAttrEffect(self._owner, self._player)
end

function MasterBreakPoint:sortedList()
	local config = ConfigReader:getDataTable("MasterPowerBreaking")
	local sortedList = {}

	for k, v in pairs(config) do
		local num = tonumber(string.match(v.Id, "%d+$"))

		table.insert(sortedList, {
			key = k,
			value = v,
			sortNum = num
		})
	end

	table.sort(sortedList, function(a, b)
		return a.sortNum < b.sortNum
	end)

	self._sortList = sortedList
end

function MasterBreakPoint:createBreakHeadMap()
	self._breakPointMap = self._breakPointMap or {}
	self._headMap = self._headMap or {}

	local config = ConfigReader:getDataTable("MasterPowerBreaking")

	for _, item in ipairs(self._sortList) do
		local k = item.key
		local v = item.value

		self._breakPointMap[v.QualityLevel] = self._breakPointMap[v.QualityLevel] or {}
		self._headMap[v.QualityLevel] = self._headMap[v.QualityLevel] or k

		table.insert(self._breakPointMap[v.QualityLevel], v.Id)
	end
end

function MasterBreakPoint:createBreakAttrList()
	local initalId

	self._list = {}
	self._map = {}

	local breakId = self._breakPointLevel == 0 and "Master_PowerBreaking_1" or self._headMap[self._breakPointLevel]

	for i = 1, 9 do
		local config = ConfigReader:getRecordById("MasterPowerBreaking", breakId)
		local id = config.skill
		local innerAttribute = MasterBreakAttribute:new(id)

		self._map[id] = innerAttribute
		self._list[#self._list + 1] = innerAttribute
		breakId = config.NextQuality and config.NextQuality
	end

	if self._breakPointLevel == 0 then
		self._list[1]:synchronize(1)
	end
end

function MasterBreakPoint:synchronize(data)
	if data ~= "" then
		self._breakPointId = data

		local config = ConfigReader:getRecordById("MasterPowerBreaking", self._breakPointId)

		self._breakPointLevel = config.QualityLevel
		self._config = not self:isMaxLevel() and ConfigReader:getRecordById("MasterPowerBreaking", config.NextQuality) or ""

		self:createBreakAttrList()
		self:refreshBreakAttrList()
	end
end

function MasterBreakPoint:refreshBreakAttrList()
	local breakIds = self._breakPointLevel ~= 0 and self._breakPointMap[self._breakPointLevel]

	for k, v in pairs(breakIds) do
		local config = ConfigReader:getRecordById("MasterPowerBreaking", v)

		if self._breakPointLevel <= config.QualityLevel then
			local lockState = 2

			self._list[k]:synchronize(lockState)

			if v == self._breakPointId then
				if not self:isMaxLevel() and self._list[k + 1] then
					self._list[k + 1]:synchronize(1)
				end

				break
			end
		end
	end
end

function MasterBreakPoint:isMaxLevel()
	if self._breakPointLevel ~= 0 then
		local config = ConfigReader:getRecordById("MasterPowerBreaking", self._breakPointId)

		return config.NextQuality == ""
	end

	return false
end

function MasterBreakPoint:getCost1()
	if not self:isMaxLevel() then
		return self._config.Cost1
	end

	return ""
end

function MasterBreakPoint:getCost2()
	if not self:isMaxLevel() then
		return self._config.Cost2
	end

	return ""
end

function MasterBreakPoint:getShowCondition()
	local ret

	if self._breakPointLevel == 0 then
		local config = ConfigReader:getRecordById("MasterBase", self._masterId)

		ret = Strings:get(config.LeadStageConditionDesc)
	end

	return (self._config ~= "" and self._config.Condition or nil) and Strings:get(self._config.PowerLevelDesc)
end

function MasterBreakPoint:createAttrEffect(owner, player)
	self._effect = SkillAttrEffect:new(AttrSystemName.kMasterBreak)

	self._effect:setOwner(owner, player)
end

function MasterBreakPoint:refreshEffect()
	self._effect:removeEffect()
	self:rCreateEffect()
end

function MasterBreakPoint:rCreateEffect()
	local effects = self:getAttrEffects()

	self._effect:refreshEffects(effects)
	self._effect:rCreateEffect()
end

function MasterBreakPoint:getAttrEffects()
	local effects = {}

	for _, item in ipairs(self._sortList) do
		local v = item.value
		local attrConfig = ConfigReader:getRecordById("SkillAttrEffect", v.skill)

		if attrConfig then
			table.insert(effects, id)
		end

		if v.Id == self._breakPointId then
			break
		end
	end

	return effects
end

MasterBreakAttribute = class("MasterBreakAttribute", objectlua.Object, _M)

MasterBreakAttribute:has("_lockState", {
	is = "rw"
})
MasterBreakAttribute:has("_id", {
	is = "r"
})
MasterBreakAttribute:has("_config", {
	is = "r"
})

function MasterBreakAttribute:initialize(id)
	self._id = id
	self._lockState = 0
	self._config = ConfigReader:getRecordById("SkillAttrEffect", id)
end

function MasterBreakAttribute:synchronize(lockState)
	self._lockState = lockState
end

function MasterBreakAttribute:getLock()
	return self._lockState ~= 2
end
