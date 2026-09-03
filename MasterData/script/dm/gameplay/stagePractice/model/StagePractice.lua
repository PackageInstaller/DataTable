-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/model/StagePractice.lua

StagePractice = class("StagePractice", objectlua.Object, _M)

StagePractice:has("_list", {
	is = "r"
})
StagePractice:has("_array", {
	is = "r"
})
StagePractice:has("_rankList", {
	is = "r"
})

StagePracticeType = {
	kActivity = "ACTIVITY",
	kNormal = "NORMAL"
}

function StagePractice:initialize()
	super.initialize(self)
	self:initMaps()

	self._rankList = StagePracticeRankList:new()
end

function StagePractice:sync(data)
	for mapId, mapData in pairs(data) do
		if self._list[mapId] then
			self._list[mapId]:sync(mapData)
		end
	end
end

function StagePractice:syncRankList(data)
	self._rankList:synchronize(data)
end

function StagePractice:initMaps()
	self._list = {}
	self._array = {}

	local config = ConfigReader:getKeysOfTable("StagePracticeMap")
	local newconfig = {}

	for i = 1, #config do
		newconfig[i] = config[i]
	end

	for i = 1, #newconfig do
		local id = newconfig[i]
		local stagePracticeMap = StagePracticeMap:new(id)

		self._array[i] = stagePracticeMap
		self._list[id] = stagePracticeMap
	end
end

function StagePractice:getMapById(id)
	return self._list[id]
end

function StagePractice:getMapByIndex(index)
	return self._array[index]
end
