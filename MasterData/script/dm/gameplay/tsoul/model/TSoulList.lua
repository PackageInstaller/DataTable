-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/model/TSoulList.lua

require("dm.gameplay.tsoul.model.TSoul")

TSoulList = class("TSoulList", objectlua.Object, _M)

TSoulList:has("_tSoulMap", {
	is = "rw"
})
TSoulList:has("_tsoulPositionMap", {
	is = "rw"
})

function TSoulList:initialize(Player)
	super.initialize(self)

	self._tSoulMap = {}
	self._bag = Player._bag
	self._tsoulPositionMap = {}

	for i, type in pairs(HeroTSoulType) do
		self._tsoulPositionMap[type] = {}
	end
end

function TSoulList:synchronize(data)
	for id, value in pairs(data) do
		self._tSoulMap[id] = self._tSoulMap[id] or TSoul:new(id)

		self._tSoulMap[id]:synchronize(value)

		local type = self._tSoulMap[id]:getPosition()

		self._tsoulPositionMap[type][id] = 1
	end

	self._bag:synTSoulList(self._tSoulMap)
end

function TSoulList:deleteTSoul(data)
	for id, v in pairs(data) do
		if self._tSoulMap[id] then
			local type = self._tSoulMap[id]:getPosition()

			self._tsoulPositionMap[type][id] = nil
			self._tSoulMap[id] = nil
		end
	end

	self._bag:delTSoulList(data)
end

function TSoulList:getTSoulById(id)
	return self._tSoulMap[id]
end

function TSoulList:getTSoulsAll()
	return self._tSoulMap
end

function TSoulList:getTSoulsByPosition(type)
	return self._tsoulPositionMap[type]
end

function TSoulList:getTSoulsList()
	local list = {}

	for id, tsoul in pairs(self._tSoulMap) do
		list[#list + 1] = tsoul
	end

	return list
end
