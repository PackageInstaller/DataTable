-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/model/CrusadeWeek.lua

require("dm.gameplay.crusade.model.CrusadeFloor")

CrusadeWeek = class("CrusadeWeek", objectlua.Object)

CrusadeWeek:has("_id", {
	is = "r"
})

function CrusadeWeek:initialize()
	super.initialize(self)

	self._id = ""
	self._floors = {}
	self._floorRewards = {}
end

function CrusadeWeek:synchronize(id)
	if id then
		self._id = id

		self:updateConfig()
	end
end

function CrusadeWeek:synchronizeBuffs(buffs)
	for floorId, floor in pairs(self._floors) do
		floor:synchronizeBuffs(buffs)
	end
end

function CrusadeWeek:updateConfig()
	self._floorRewards = {}
	self._config = ConfigReader:getRecordById("CrusadeWeek", self._id)

	local length = #self:getSubPoint()

	for i = 1, length do
		local floorId = self:getSubPoint()[i]
		local floor = self._floors[floorId]

		if not floor then
			floor = CrusadeFloor:new(floorId)

			floor:setIndex(i)

			self._floors[floorId] = floor
		end

		local index = floor:getIndex()

		self._floorRewards[i] = {
			name = floor:getName(),
			quality = floor:getQuality(),
			rewards = floor:getRewards(),
			index = floor:getIndex()
		}
	end
end

function CrusadeWeek:getCurCrusadeFloorModel(floorId)
	return self._floors[floorId]
end

function CrusadeWeek:getCrusadeFloorModel(floorId)
	return self._floors[floorId]
end

function CrusadeWeek:getNextWeek()
	return self._config.NextWeek
end

function CrusadeWeek:getWeekDuration()
	return self._config.WeekDuration
end

function CrusadeWeek:getSubPoint()
	return self._config.SubPoint
end

function CrusadeWeek:getAllFloorRewards()
	return self._floorRewards
end
