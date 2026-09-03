-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneEnemyGroup.lua

PlaneEnemyGroup = class("PlaneEnemyGroup", objectlua.Object, _M)

PlaneEnemyGroup:has("_list", {
	is = "r"
})
PlaneEnemyGroup:has("_groupId", {
	is = "r"
})
PlaneEnemyGroup:has("_type", {
	is = "r"
})

function PlaneEnemyGroup:initialize(groupId)
	super.initialize(self)

	self._groupId = groupId
	self._list = {}
	self._config = ConfigReader:getRecordById("MiniPlaneBattle", groupId)
	self._type = self._config.enemyType

	self:initList()
end

function PlaneEnemyGroup:dispose()
	super.dispose(self)
end

function PlaneEnemyGroup:initList()
	local configData = self._config.enemyQueue

	if self._type == PlaneEnemyAppearType.normal or self._type == PlaneEnemyAppearType.random then
		for i = 1, #configData do
			self._list[#self._list + 1] = configData[i]
		end
	end
end

function PlaneEnemyGroup:firstCreateEnemy()
	self:rCreateEnemyQueue()
end

function PlaneEnemyGroup:rCreateEnemyQueue(appearType, enemyQueue)
	local appearType = appearType or self._type
	local configData = enemyQueue or self._config.enemyQueue

	if appearType == PlaneEnemyAppearType.random then
		if #self._list == 0 then
			for i = 1, #configData do
				self._list[#self._list + 1] = configData[i]
			end
		end

		local times = #configData

		for i = 1, times do
			local randIndex = math.random(1, times) % times
			local cIndex = i % times

			if cIndex ~= randIndex and self._list[cIndex] and self._list[randIndex] then
				self._list[cIndex], self._list[randIndex] = self._list[randIndex], self._list[cIndex]
			end
		end
	elseif appearType == PlaneEnemyAppearType.item then
		self._list = {}
		self._list[1] = configData[(#configData > 1 or nil) and math.random(1, #configData)]
	end

	if appearType == PlaneEnemyAppearType.randomGroup then
		local configData = self._config.enemyWave
		local randomCount = math.random(1, #configData)

		self._newConfig = ConfigReader:getRecordById("MiniPlaneBattle", tostring(configData[randomCount]))

		for i = 1, #self._newConfig.enemyQueue do
			self._list[#self._list + 1] = self._newConfig.enemyQueue[i]
		end
	end
end

function PlaneEnemyGroup:needRefeshList()
	if self._type == PlaneEnemyAppearType.random or self._type == PlaneEnemyAppearType.item or self._type == PlaneEnemyAppearType.randomGroup then
		return true
	end

	return false
end

function PlaneEnemyGroup:getEnemyIdByIndex(pointIndex)
	return self._list[pointIndex or 1]
end

function PlaneEnemyGroup:getNextGropSleepTime()
	if self._newConfig then
		if not self._newConfig then
			local config = self._config
			local data = config.timeGap

			if data[1] == data[2] then
				return data[1] / 1000
			end

			return math.random(data[1], data[2]) / 1000
		end
	end
end

function PlaneEnemyGroup:getSleepTime()
	if self._newConfig then
		if not self._newConfig then
			local config = self._config
			local data = config.enemyGap

			if data[1] == data[2] then
				return data[1] / 1000
			end

			return math.random(data[1], data[2]) / 1000
		end
	end
end

function PlaneEnemyGroup:getEnemyType()
	return self._config.enemyType
end

function PlaneEnemyGroup:getEnemyCount()
	return #self._list
end
