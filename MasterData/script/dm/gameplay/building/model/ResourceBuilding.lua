-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/model/ResourceBuilding.lua

ResourceBuilding = class("ResourceBuilding", BaseBuilding, _M)

function ResourceBuilding:initialize()
	super.initialize(self)

	self._subOreList = nil
	self._output = 0
	self._storage = 0
	self._resSec = 0
	self._limit = 0
end

function ResourceBuilding:dispose()
	super.dispose(self)
end

function ResourceBuilding:synchronize(data)
	if not data then
		return
	end

	if data.output then
		self._output = data.output
	end

	if data.storage then
		self._storage = data.storage
	end

	if data.resSec then
		self._resSec = data.resSec
	end

	if data.limit then
		self._limit = data.limit
	end

	super.synchronize(self, data)
end

function ResourceBuilding:getResouseNum()
	if not self._buildingSystem:isSelfBuilding() then
		return 0
	end

	local stageSystem = self._buildingSystem:getStageSystem()
	local gameServerAgent = self._buildingSystem._gameServerAgent
	local timeNow = gameServerAgent:remoteTimestamp()
	local num = math.floor(self._storage + (timeNow - self._resSec) / 3600 * self._output)

	if GameConfigs.printBuildingOutPut then
		print("BuildingOutPut", self._storage, self._output, num, self._configId)
	end

	if self._type == KBuildingType.kGoldOre then
		local condition = ConfigReader:getDataByNameIdAndKey("ConfigValue", "GoldOreMinHit", "content")
		local value = condition.value
		local pointId = condition.change
		local point = stageSystem:getPointById(pointId)

		if point and point:isPass() then
			if not condition.time[2] then
				local time = condition.time[1]

				if value <= num and time < timeNow - self._resSec then
					if num < self._limit then
						return num
					else
						return self._limit
					end
				end
			end
		end
	elseif self._type == KBuildingType.kExpOre then
		local condition = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ExpOreMinHit", "content")
		local value = condition.value
		local pointId = condition.change
		local point = stageSystem:getPointById(pointId)

		if point and point:isPass() then
			if not condition.time[2] then
				local time = condition.time[1]
				local prototype = ItemPrototype:new(value)

				value = prototype:getReward() and prototype:getReward()[1].amount or 1

				if value <= num and time < timeNow - self._resSec then
					if num < self._limit then
						return num
					else
						return self._limit
					end
				end
			end
		end
	elseif self._type == KBuildingType.kCrystalOre then
		local condition = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CrystalOreMinHit", "content")
		local value = condition.value
		local pointId = condition.change
		local point = stageSystem:getPointById(pointId)

		if point and point:isPass() then
			if not condition.time[2] then
				local time = condition.time[1]

				if value <= num and time < timeNow - self._resSec then
					if num < self._limit then
						return num
					else
						return self._limit
					end
				end
			end
		end
	end

	return 0
end

function ResourceBuilding:getResouseNumNoLimit()
	local gameServerAgent = self._buildingSystem._gameServerAgent
	local timeNow = gameServerAgent:remoteTimestamp()
	local num = math.floor(self._storage + (timeNow - self._resSec) / 3600 * self._output)

	if num < self._limit then
		return num
	else
		return self._limit
	end
end

function ResourceBuilding:getOutput()
	return self._output
end

function ResourceBuilding:getStorage()
	return self._storage
end

function ResourceBuilding:getLimit()
	return self._limit
end
