-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/model/DreamChallengeMap.lua

DreamChallengeMap = class("DreamChallengeMap", objectlua.Object)

DreamChallengeMap:has("_mapId", {
	is = "rw"
})
DreamChallengeMap:has("_mapConfig", {
	is = "rw"
})
DreamChallengeMap:has("_pointIds", {
	is = "rw"
})
DreamChallengeMap:has("_dreamPoints", {
	is = "rw"
})
DreamChallengeMap:has("_boxs", {
	is = "rw"
})
DreamChallengeMap:has("_endTime", {
	is = "rw"
})
DreamChallengeMap:has("_openByServer", {
	is = "rw"
})

function DreamChallengeMap:initialize(mapId)
	super.initialize(self)

	self._mapId = mapId
	self._mapConfig = ConfigReader:requireRecordById("DreamChallengeMap", self._mapId)
	self._pointIds = self._mapConfig.BlockPoint
	self._dreamPoints = {}

	for i = 1, #self._pointIds do
		self._dreamPoints[self._pointIds[i]] = DreamChallengePoint:new(self._pointIds[i])
	end

	self._boxs = {}
	self._endTime = 0
	self._openByServer = false
end

function DreamChallengeMap:synchronize(data)
	self._openByServer = true

	if data.dreamPoints then
		for k, v in pairs(data.dreamPoints) do
			if self._dreamPoints[k] then
				self._dreamPoints[k]:synchronize(v)
			end
		end
	end

	if data.boxs then
		for pid, v in pairs(data.boxs) do
			self._boxs[pid] = self._boxs[pid] or {}

			for bid, s in pairs(v) do
				self._boxs[pid][bid] = s
			end
		end
	end

	if data.endTime then
		self._endTime = data.endTime / 1000
	end
end

function DreamChallengeMap:delete(data)
	if type(data) == "table" then
		if data.dreamPoints then
			for k, v in pairs(data.dreamPoints) do
				self._dreamPoints[k]:delete(v)
			end
		end
	else
		self._openByServer = false
	end
end

function DreamChallengeMap:getPointData(pointId)
	if self._dreamPoints then
		return self._dreamPoints[pointId]
	end

	return nil
end

function DreamChallengeMap:isPointHasPass(pointId)
	local pointData = self:getPointData(pointId)
	local battleIds = pointData:getBattleIds()
	local passPointNum = 0

	if self._boxs[pointId] then
		for key, value in pairs(self._boxs[pointId]) do
			passPointNum = passPointNum + 1
		end

		if passPointNum >= #battleIds then
			return true
		end
	end

	return false
end

function DreamChallengeMap:isBattleHasPass(pointId, battleId)
	local pointData = self:getPointData(pointId)

	if self._boxs[pointId] then
		for key, value in pairs(self._boxs[pointId]) do
			if battleId == key then
				return true
			end
		end
	end

	return false
end

function DreamChallengeMap:getMapName()
	return self._mapConfig.Name
end

function DreamChallengeMap:getMapTabImage()
	return self._mapConfig.TabPic
end

function DreamChallengeMap:checkRedPoint()
	for _, points in pairs(self._boxs) do
		for k, v in pairs(points) do
			if v == 1 then
				return true
			end
		end
	end

	return false
end

function DreamChallengeMap:checkRedPointByPointId(pointId)
	if self._boxs and self._boxs[pointId] then
		for k, v in pairs(self._boxs[pointId]) do
			if v == 1 then
				return true
			end
		end
	end

	return false
end

function DreamChallengeMap:getMapShowCondition()
	return self._mapConfig.ShowCondition
end

function DreamChallengeMap:getMapEndCondition()
	return self._mapConfig.TimeFactor
end

function DreamChallengeMap:getMapLockCondition()
	return self._mapConfig.UnlockCondition
end

function DreamChallengeMap:getMapTimeDesc()
	return self._mapConfig.LimitTimeTxt
end

function DreamChallengeMap:getMapBGM()
	return self._mapConfig.BGM
end

function DreamChallengeMap:getControl()
	return self._mapConfig.Control
end

function DreamChallengeMap:getDCType()
	return self._mapConfig.DCType
end

function DreamChallengeMap:checkMapPass()
	for i = 1, #self._pointIds do
		if not self:isPointHasPass(self._pointIds[i]) then
			return false
		end
	end

	return true
end

function DreamChallengeMap:checkBattleRewarded(pointId, battleId)
	if self._boxs and self._boxs[pointId] then
		if self._boxs[pointId][battleId] == 1 then
			return false
		elseif self._boxs[pointId][battleId] == 2 then
			return true
		end
	end

	return false
end

function DreamChallengeMap:checkBattleRewardLock(pointId, battleId)
	if self._boxs and self._boxs[pointId] and self._boxs[pointId][battleId] then
		return true
	end

	return false
end

function DreamChallengeMap:checkHeroTired(pointId, heroId)
	local pointData = self:getPointData(pointId)

	if pointData then
		return pointData:checkHeroTired(heroId)
	end

	return false
end

function DreamChallengeMap:checkHeroRecomand(pointId, heroInfo)
	local pointData = self:getPointData(pointId)

	if pointData then
		return pointData:checkHeroRecomand(heroInfo)
	end

	return false
end
