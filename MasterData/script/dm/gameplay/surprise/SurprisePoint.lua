-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/surprise/SurprisePoint.lua

SurprisePoint = class("SurprisePoint", objectlua.Object, _M)

SurprisePoint:has("_map", {
	is = "rw"
})

function SurprisePoint:initialize()
	super.initialize(self)

	self._map = {}

	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ContinueDiamonds", "content")

	for id, value in pairs(config) do
		self._map[id] = SurpriseTimesPoint:new(id, value)
	end
end

function SurprisePoint:dispose()
	super.dispose(self)
end

function SurprisePoint:sync(data)
	if data then
		for id, value in pairs(data) do
			if self._map[id] then
				self._map[id]:sync(value)
			end
		end
	end
end

function SurprisePoint:getSurprisePointById(id)
	return self._map[id]
end

SurpriseTimesPoint = class("SurpriseTimesPoint", objectlua.Object, _M)

SurpriseTimesPoint:has("_config", {
	is = "rw"
})
SurpriseTimesPoint:has("_curTimes", {
	is = "rw"
})

function SurpriseTimesPoint:initialize(id, config)
	super.initialize(self)

	self._curTimes = 0
	self._config = config
end

function SurpriseTimesPoint:dispose()
	super.dispose(self)
end

function SurpriseTimesPoint:sync(data)
	if data then
		self._curTimes = data
	end
end

function SurpriseTimesPoint:getMaxTimes()
	return self._config.amount
end

function SurpriseTimesPoint:getSurpriseGift()
	local reward = ConfigReader:getRecordById("Reward", self._config.reward).Content

	return reward[1]
end
