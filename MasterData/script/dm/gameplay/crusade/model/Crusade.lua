-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/model/Crusade.lua

require("dm.gameplay.crusade.model.CrusadeWeek")

Crusade = class("Crusade", objectlua.Object)

Crusade:has("_crusadeWeekId", {
	is = "r"
})
Crusade:has("_crusadeFloorId", {
	is = "r"
})
Crusade:has("_firstReward", {
	is = "r"
})
Crusade:has("_crusadePointId", {
	is = "r"
})
Crusade:has("_crusadeWeekModel", {
	is = "r"
})
Crusade:has("_curWeek", {
	is = "r"
})
Crusade:has("_wipeFloor", {
	is = "r"
})
Crusade:has("_maxWipeFloor", {
	is = "r"
})
Crusade:has("_dynamicDifficulty", {
	is = "r"
})
Crusade:has("_totalPoint", {
	is = "r"
})
Crusade:has("_finish", {
	is = "r"
})
Crusade:has("_leftTime", {
	is = "r"
})
Crusade:has("_lastTotalPoint", {
	is = "r"
})
Crusade:has("_lastWeekFloor", {
	is = "r"
})
Crusade:has("_curWeekFloor", {
	is = "r"
})
Crusade:has("_limitHero", {
	is = "r"
})
Crusade:has("_floorCombat", {
	is = "r"
})
Crusade:has("_resetTimes", {
	is = "r"
})

function Crusade:initialize()
	super.initialize(self)

	self._crusadeWeekId = ""
	self._crusadeFloorId = ""
	self._firstReward = {}
	self._crusadePointId = ""
	self._curWeek = 0
	self._wipeFloor = 0
	self._maxWipeFloor = 0
	self._dynamicDifficulty = 0
	self._totalPoint = 0
	self._finish = false
	self._leftTime = 0
	self._lastTotalPoint = 0
	self._lastWeekFloor = {
		quality = 1,
		name = Strings:get("Crusade_UI22")
	}
	self._curWeekFloor = {
		quality = 1,
		name = ""
	}
	self._limitHero = {}
	self._resetTimes = 0
end

function Crusade:synchronize(data)
	dump(data, "Crusade:synchronize")

	if data.leftTime then
		self._leftTime = data.leftTime
	end

	if data.curWeek then
		self._curWeek = data.curWeek
	end

	if data.maxWipeFloor then
		self._maxWipeFloor = data.maxWipeFloor
	end

	if data.dynamicDifficulty then
		self._dynamicDifficulty = data.dynamicDifficulty
	end

	if data.totalPoint then
		self._totalPoint = data.totalPoint
	end

	if data.finish ~= nil then
		self._finish = data.finish
	end

	if data.curFloorId then
		self._crusadeFloorId = data.curFloorId
	end

	if data.fisrtReward and self._firstReward then
		for floorNum, floorData in pairs(data.fisrtReward) do
			for k, v in pairs(floorData) do
				self._firstReward[floorNum] = self._firstReward[floorNum] or {}
				self._firstReward[floorNum][k] = v
			end
		end
	end

	if data.curPointId then
		self._crusadePointId = data.curPointId
	end

	if data.curWeekId then
		self._crusadeWeekId = data.curWeekId
		self._crusadeWeekModel = self._crusadeWeekModel or CrusadeWeek:new()

		self._crusadeWeekModel:synchronize(self._crusadeWeekId)
	end

	if data.buffs and self._crusadeWeekModel then
		self._crusadeWeekModel:synchronizeBuffs(data.buffs)
	end

	if data.lastTotalPoint then
		self._lastTotalPoint = data.lastTotalPoint

		self:refreshLastWeekFloor()
	end

	if data.wipeFloor then
		self._wipeFloor = data.wipeFloor

		self:refreshCurWeekFloor()
	end

	if data.limitHero then
		self._limitHero = data.limitHero
	end

	if data.combat then
		self._floorCombat = data.combat
	end

	if data.resetTimes then
		self._resetTimes = data.resetTimes
	end
end

function Crusade:refreshLastWeekFloor()
	if self._lastTotalPoint <= 0 then
		return
	end

	self._lastWeekFloor = {}

	local lastTotalPoint = self._lastTotalPoint
	local subFloor = self._crusadeWeekModel:getSubPoint()

	for i = 1, #subFloor do
		local floorId = subFloor[i]
		local floor = self._crusadeWeekModel:getCrusadeFloorModel(floorId)
		local subPoint = floor:getSubPoint()
		local length = #subPoint

		if lastTotalPoint <= 0 then
			break
		end

		local pointIndex = lastTotalPoint == 0 and 5 or lastTotalPoint

		self._lastWeekFloor.name = floor:getName() .. GameStyle:intNumToRomaString(pointIndex)
		self._lastWeekFloor.quality = floor:getQuality()
		lastTotalPoint = lastTotalPoint - length
	end
end

function Crusade:refreshCurWeekFloor()
	if self._wipeFloor <= 0 then
		return
	end

	self._curWeekFloor = {}

	local subFloor = self._crusadeWeekModel:getSubPoint()
	local floorId = subFloor[self._wipeFloor]
	local floor = self._crusadeWeekModel:getCrusadeFloorModel(floorId)
	local subPoint = floor:getSubPoint()
	local length = #subPoint

	self._curWeekFloor.name = floor:getName() .. GameStyle:intNumToRomaString(length)
	self._curWeekFloor.quality = floor:getQuality()
end

function Crusade:getCurCrusadeFloorModel()
	return self._crusadeWeekModel:getCurCrusadeFloorModel(self._crusadeFloorId)
end

function Crusade:getCurCrusadePointModel()
	local curCrusadeFloorModel = self:getCurCrusadeFloorModel()

	return curCrusadeFloorModel:getCrusadePointById(self._crusadePointId)
end

function Crusade:canSweep()
	local hasSweepTimes = self._wipeFloor > 0
	local curFloor = self:getCurCrusadeFloorModel()
	local canSweep = curFloor:getIndex() <= self._wipeFloor

	return hasSweepTimes and canSweep
end

function Crusade:getPointIndexById(floorId, pointId)
	local floor = self._crusadeWeekModel:getCrusadeFloorModel(floorId)
	local point = floor:getCrusadePointById(pointId)

	if point then
		return point:getIndex()
	end

	return 1
end
