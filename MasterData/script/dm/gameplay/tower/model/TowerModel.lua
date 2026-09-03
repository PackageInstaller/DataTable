-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/model/TowerModel.lua

TowerModel = class("TowerModel", objectlua.Object, _M)

TowerModel:has("_towerList", {
	is = "rw"
})

function TowerModel:initialize()
	super.initialize(self)

	self._towerList = {}
	self._towerMap = {}
end

function TowerModel:synchronize(data)
	for k, v in pairs(data) do
		local towerData = self:getTowerDataByTowerId(k)

		if not towerData then
			towerData = Tower:new()
			self._towerMap[k] = towerData
		end

		towerData:synchronize(v)
	end

	self:sortTowerList()
end

function TowerModel:deleteTower(data)
	for towerId, value in pairs(data) do
		if self._towerMap[towerId] then
			self._towerMap[towerId]:deleteTower(value)
		end
	end
end

function TowerModel:getTowerDataByTowerId(towerId)
	return self._towerMap[towerId]
end

function TowerModel:sortTowerList()
	self._towerList = {}

	for i, v in pairs(self._towerMap) do
		table.insert(self._towerList, v)
	end

	table.sort(self._towerList, function(a, b)
		return tonumber(a._towerBase._config.Order) < tonumber(b._towerBase._config.Order)
	end)
end

function TowerModel:getTowerById(id)
	return self._towerMap[id]
end
