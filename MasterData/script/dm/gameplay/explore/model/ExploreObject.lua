-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreObject.lua

ExploreObject = class("ExploreObject", objectlua.Object)

ExploreObject:has("_id", {
	is = "r"
})
ExploreObject:has("_configId", {
	is = "r"
})
ExploreObject:has("_block", {
	is = "rb"
})
ExploreObject:has("_x", {
	is = "r"
})
ExploreObject:has("_y", {
	is = "r"
})
ExploreObject:has("_cellIndex", {
	is = "r"
})
ExploreObject:has("_triggerRect", {
	is = "rw"
})
ExploreObject:has("_blockRect", {
	is = "rw"
})
ExploreObject:has("_exploreStatus", {
	is = "rw"
})
ExploreObject:has("_tips", {
	is = "rw"
})
ExploreObject:has("_clickPics", {
	is = "rw"
})
ExploreObject:has("_diffCallBack", {
	is = "rw"
})
ExploreObject:has("_lastCase", {
	is = "rw"
})
ExploreObject:has("_res", {
	is = "rw"
})

function ExploreObject:initialize(configId, id, resConfig)
	super.initialize(self)

	self._id = id
	self._configId = configId
	self._config = configId and ConfigReader:requireRecordById("MapObject", configId)
	self._res = resConfig or self._config.Caseimg
	self._clickPics = ""
	self._lastCase = ""

	self:updateResConfig()
end

function ExploreObject:synchronize(data)
	for i, v in pairs(data) do
		if self._diffCallBack and self["_" .. i] ~= v then
			self["_" .. i] = v

			self._diffCallBack()
		end

		self["_" .. i] = v

		if i == "res" then
			self:updateResConfig()
		end
	end
end

function ExploreObject:updateResConfig()
	self._resConfig = ConfigReader:getRecordById("MapObjectRes", self._res) or {}
end

function ExploreObject:getConfigByKey(key)
	return self._config and self._config[key]
end

function ExploreObject:getResConfigByKey(key)
	return self._resConfig[key]
end

function ExploreObject:createCellIndex(cellWidthNum, cellHeithtNum)
	self._cellIndex = {}
	self._cellIndex.y = math.floor(self._y / cellHeithtNum)
	self._cellIndex.localRow = self._y % cellHeithtNum
	self._cellIndex.x = math.floor(self._x / cellWidthNum)
	self._cellIndex.localCol = self._x % cellWidthNum

	return self._cellIndex
end
