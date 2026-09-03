-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/model/CrusadeFloor.lua

require("dm.gameplay.crusade.model.CrusadePoint")

CrusadeFloor = class("CrusadeFloor", objectlua.Object)

CrusadeFloor:has("_id", {
	is = "r"
})
CrusadeFloor:has("_index", {
	is = "rw"
})

function CrusadeFloor:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("CrusadeFloor", self._id)
	self._index = 0
	self._points = {}

	local length = #self:getSubPoint()

	for i = 1, length do
		local pointId = self:getSubPoint()[i]

		self._points[pointId] = CrusadePoint:new(pointId)

		self._points[pointId]:setIndex(i)
	end
end

function CrusadeFloor:synchronizeBuffs(buffs)
	for pointId, buffId in pairs(buffs) do
		if self._points[pointId] then
			self._points[pointId]:synchronizeBuff(buffId)
		end
	end
end

function CrusadeFloor:getCrusadePointById(pointId)
	return self._points[pointId]
end

function CrusadeFloor:getName()
	return Strings:get(self._config.Name)
end

function CrusadeFloor:getBuffDesc()
	return "48454646464646"
end

function CrusadeFloor:getQuality()
	return self._config.Rarity or 1
end

function CrusadeFloor:getBackground()
	return self._config.Background
end

function CrusadeFloor:getSubPoint()
	return self._config.SubPoint
end

function CrusadeFloor:getCombatValue()
	return self._config.CombatValue
end

function CrusadeFloor:getCombatNeed()
	return self._config.CombatNeed
end

function CrusadeFloor:getReward()
	return self._config.Reward
end

function CrusadeFloor:getBgName()
	return self._config.Background
end

function CrusadeFloor:getRewards()
	return (RewardSystem:getRewardsById(self:getReward()))
end

function CrusadeFloor:getDynamicDifficulty()
	return self._config.Crusade_Dynamic_Difficlt_Ratio
end
