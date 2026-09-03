-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/Explore.lua

Explore = class("Explore", objectlua.Object)

Explore:has("_resetValues", {
	is = "r"
})
Explore:has("_stamina", {
	is = "r"
})
Explore:has("_curPointId", {
	is = "r"
})
Explore:has("_curGroupId", {
	is = "r"
})
Explore:has("_totalDp", {
	is = "r"
})
Explore:has("_exploreBag", {
	is = "r"
})
Explore:has("_pointMap", {
	is = "r"
})
Explore:has("_pointIdArray", {
	is = "r"
})
Explore:has("_pointTypeMap", {
	is = "r"
})
Explore:has("_mapTypeDic", {
	is = "r"
})
Explore:has("_mapTypeArr", {
	is = "r"
})
Explore:has("_autoBattle", {
	is = "rw"
})
Explore:has("_speedRate", {
	is = "rw"
})
Explore:has("_enterTimes", {
	is = "rw"
})

function Explore:initialize()
	super.initialize(self)

	self._pointMap = {}
	self._pointIdArray = {}
	self._pointTypeMap = {}
	self._mapTypeArr = {}
	self._mapTypeDic = {}
	self._init = false
	self._autoBattle = false
end

function Explore:initPointMap()
	local config = ConfigReader:getDataTable("MapType")

	for type, value in pairs(config) do
		local pointIds = value.MapPointId

		for i = 1, #pointIds do
			local id = pointIds[i]
			local pointConfig = ConfigReader:getRecordById("MapPoint", id)

			if pointConfig then
				self._pointIdArray[#self._pointIdArray + 1] = id

				local obj = self:getInjector():getInstance(ExploreMap)

				self._pointMap[id] = obj

				obj:setId(id)
				obj:setMapType(type)
				obj:initConfig()

				local mapType = obj:getMapType()

				self._pointTypeMap[mapType] = self._pointTypeMap[mapType] or {}

				local length = #self._pointTypeMap[mapType]

				self._pointTypeMap[mapType][length + 1] = obj
			end
		end
	end
end

function Explore:synchronize(data)
	if not self._init then
		self._exploreBag = self:getInjector():getInstance(ExploreBag)
		self._init = true

		self:initPointMap()
	end

	for k, v in pairs(data) do
		if k == "points" then
			for key, value in pairs(v) do
				if self._pointMap[key] then
					self._pointMap[key]:synchronize(value)
				end
			end
		elseif k == "groups" then
			for key, value in pairs(v) do
				if not self._mapTypeDic[key] then
					local mapType = ExploreType:new(key)

					self._mapTypeDic[key]:synchronize(value)

					self._mapTypeDic[key] = self._mapTypeDic[key]
				end
			end

			self:syncMapTypes()
		elseif k == "bag" then
			if v.items then
				self._exploreBag:synchronize(v.items)
			end
		elseif k == "equipsReward" then
			self._exploreBag:synEquipList(v)
		else
			self["_" .. k] = v
		end
	end
end

function Explore:synchronizeDel(data)
	if data.equipsReward then
		self._exploreBag:removeEquip()
	end

	if data.bag and data.bag.items then
		for k, v in pairs(data.bag.items) do
			self._exploreBag:removeItem(k)
		end
	end

	if data.points then
		for key, value in pairs(data.points) do
			local info = self._pointMap[key]

			if info then
				info:synchronizeDel(value)
			end
		end
	end
end

function Explore:syncMapTypes()
	self._mapTypeArr = {}

	for type, mapTypeObj in pairs(self._mapTypeDic) do
		self._mapTypeArr[#self._mapTypeArr + 1] = mapTypeObj
	end

	table.sort(self._mapTypeArr, function(a, b)
		return a:getSortNum() < b:getSortNum()
	end)
end

function Explore:getMapPointObjById(id)
	return self._pointMap[id]
end

function Explore:getEnterTimes()
	return self._enterTimes.value or 0
end
