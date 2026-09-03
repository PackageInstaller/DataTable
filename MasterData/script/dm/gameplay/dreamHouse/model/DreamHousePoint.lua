-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamHouse/model/DreamHousePoint.lua

DreamHousePoint = class("DreamHousePoint", objectlua.Object)

DreamHousePoint:has("_pointId", {
	is = "rw"
})
DreamHousePoint:has("_pointConfig", {
	is = "rw"
})
DreamHousePoint:has("_boxes", {
	is = "rw"
})
DreamHousePoint:has("_points", {
	is = "rw"
})
DreamHousePoint:has("_stars", {
	is = "rw"
})
DreamHousePoint:has("_fatigue", {
	is = "rw"
})
DreamHousePoint:has("_passPoint", {
	is = "rw"
})
DreamHousePoint:has("_totalStar", {
	is = "rw"
})
DreamHousePoint:has("_isUnLock", {
	is = "rw"
})
DreamHousePoint:has("_infoDiSrc", {
	is = "rw"
})
DreamHousePoint:has("_battleDiSrc", {
	is = "rw"
})
DreamHousePoint:has("_btnDiSrc", {
	is = "rw"
})

local kChineseNumEnum = {
	Strings:get("DreamHouse_Main_UI07"),
	Strings:get("DreamHouse_Main_UI08"),
	Strings:get("DreamHouse_Main_UI09"),
	Strings:get("DreamHouse_Main_UI10"),
	Strings:get("DreamHouse_Main_UI11"),
	Strings:get("DreamHouse_Main_UI12"),
	Strings:get("DreamHouse_Main_UI13"),
	Strings:get("DreamHouse_Main_UI14"),
	Strings:get("DreamHouse_Main_UI15"),
	Strings:get("DreamHouse_Main_UI16")
}

function DreamHousePoint:initialize(pointId)
	super.initialize(self)

	self._pointId = pointId
	self._pointConfig = ConfigReader:requireRecordById("DreamHousePoint", self._pointId)
	self._boxes = {}
	self._points = {}
	self._stars = {}
	self._fatigue = {}
	self._passPoint = {}
	self._totalStar = 0
	self._isUnLock = false
	self._battleIds = self:getBattleIds()
	self._infoDiSrc = ""
	self._battleDiSrc = ""
	self._btnDiSrc = ""
end

function DreamHousePoint:synchronize(data)
	if data and data.boxes then
		self._boxes = data.boxes
	end

	if data and data.points then
		for k, v in pairs(data.points) do
			self._points[k] = v
		end
	end

	if data and data.stars then
		self._stars = data.stars
	end

	if data and data.fatigue then
		for k, v in pairs(data.fatigue) do
			self._fatigue[k] = v
		end
	end

	if data and data.passPoint then
		self._passPoint = {}

		for _, v in pairs(data.passPoint) do
			table.insert(self._passPoint, v)
		end
	end

	if data and data.totalStar then
		self._totalStar = data.totalStar
	end

	self._isUnLock = true
end

function DreamHousePoint:delete(data)
	if data and data.points then
		self._points = {}
	end

	if data and data.fatigue then
		for k, v in pairs(data.fatigue) do
			self._fatigue[k] = v
		end
	end
end

function DreamHousePoint:isPass()
	return #self._passPoint == #self._battleIds
end

function DreamHousePoint:isPerfectPass()
	local totalStarNum = 0

	for i = 1, #self._battleIds do
		local battleId = self._battleIds[i]
		local starCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "Star")

		totalStarNum = totalStarNum + #starCond
	end

	return self:isPass() and self._totalStar == totalStarNum
end

function DreamHousePoint:isCurrentPerfectPass()
	local totalStarNum = 0
	local starNum = 0

	for i = 1, #self._battleIds do
		local battleId = self._battleIds[i]
		local num = self:getBattleStarNum(battleId)
		local starCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "Star")

		totalStarNum = totalStarNum + #starCond
		starNum = starNum + num
	end

	return starNum == totalStarNum
end

function DreamHousePoint:getBattleStarNum(battleId)
	local num = 0

	for k, v in pairs(self._points) do
		if battleId == k then
			for _, value in pairs(v.stars) do
				num = num + 1
			end
		end
	end

	return num
end

function DreamHousePoint:getLastBattleId()
	for i = 1, #self._battleIds do
		local battleId = self._battleIds[i]

		if self:isPass() then
			local starCond = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", battleId, "Star")

			if self:getBattleStarNum(battleId) < #starCond then
				return battleId, i
			end
		elseif self:getBattleStarNum(battleId) == 0 then
			return battleId, i
		end
	end

	return self._battleIds[1], 1
end

function DreamHousePoint:isBosRewarded(starNum)
	for _, v in pairs(self._boxes) do
		if starNum == tonumber(v) then
			return true
		end
	end

	return false
end

function DreamHousePoint:getBattleIds()
	local nextBattleId = self._pointConfig.BlockId
	local battleIds = {}

	while true do
		if nextBattleId == nil or nextBattleId == "" then
			break
		end

		table.insert(battleIds, nextBattleId)

		nextBattleId = ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", nextBattleId, "NextBattle")
	end

	return battleIds
end

function DreamHousePoint:getBattleById(id)
	if self._points[id] then
		return self._points[id]
	end

	return nil
end

function DreamHousePoint:getPointName()
	return Strings:get(self._pointConfig.Name)
end

function DreamHousePoint:getBattleNameById(id)
	local numWorld = Strings:get("DreamHouse_Main_UI16")

	for i = 1, #self._battleIds do
		if self._battleIds[i] == id and kChineseNumEnum[i] then
			numWorld = kChineseNumEnum[i]
		end
	end

	return numWorld .. "-" .. Strings:get(ConfigReader:getDataByNameIdAndKey("DreamHouseBattle", id, "Name"))
end

function DreamHousePoint:getBattleNumWorldById(id)
	local numWorld = Strings:get("DreamHouse_Main_UI16")

	for i = 1, #self._battleIds do
		if self._battleIds[i] == id and kChineseNumEnum[i] then
			numWorld = kChineseNumEnum[i]
		end
	end

	return numWorld
end

function DreamHousePoint:isHasRedPoint()
	local starNums = self._pointConfig.StarNum

	for i = 1, #starNums do
		if self._totalStar >= starNums[i] and not self:isBosRewarded(starNums[i]) then
			return true
		end
	end

	return false
end
