-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/model/DreamChallenge.lua

DreamChallenge = class("DreamChallenge", objectlua.Object)

DreamChallenge:has("_mapIds", {
	is = "rw"
})
DreamChallenge:has("_dreamMaps", {
	is = "rw"
})

function DreamChallenge:initialize()
	super.initialize(self)

	self._mapIds = ConfigReader:getKeysOfTable("DreamChallengeMap")
	self._dreamMaps = {}

	for i = 1, #self._mapIds do
		self._dreamMaps[self._mapIds[i]] = DreamChallengeMap:new(self._mapIds[i])
	end
end

function DreamChallenge:synchronize(data)
	if data.dreamMaps then
		for k, v in pairs(data.dreamMaps) do
			self._dreamMaps[k]:synchronize(v)
		end
	end
end

function DreamChallenge:delete(data)
	if data.dreamMaps then
		for k, v in pairs(data.dreamMaps) do
			self._dreamMaps[k]:delete(v)
		end
	end
end

function DreamChallenge:getMapData(mapId)
	if self._dreamMaps then
		return self._dreamMaps[mapId]
	end

	return nil
end

function DreamChallenge:getPointData(mapId, pointId)
	local mapData = self:getMapData(mapId)

	if mapData then
		return mapData:getPointData(pointId)
	end

	return nil
end

function DreamChallenge:getPointShowReward(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointShowReward()
end

function DreamChallenge:getBattleIds(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getBattleIds()
end

function DreamChallenge:getBattles(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getDreamBattles()
end

function DreamChallenge:checkRedPoint()
	for i = 1, #self._mapIds do
		if self._dreamMaps[self._mapIds[i]]:checkRedPoint() then
			return true
		end
	end

	return false
end

function DreamChallenge:checkHeroTired(mapId, pointId, heroId)
	local pointData = self:getPointData(mapId, pointId)

	if pointData then
		return pointData:checkHeroTired(heroId)
	end

	return false
end

function DreamChallenge:checkHeroLocked(mapId, pointId, heroInfo)
	local pointData = self:getPointData(mapId, pointId)

	if pointData then
		return pointData:checkHeroLocked(heroInfo)
	end

	return false
end

function DreamChallenge:checkHeroRecomand(mapId, pointId, heroInfo)
	local pointData = self:getPointData(mapId, pointId)

	if pointData then
		return pointData:checkHeroRecomand(heroInfo)
	end

	return false
end

function DreamChallenge:getMasterList(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getMasterList()
end

function DreamChallenge:getPointFatigue(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointFatigue(mapId, pointId)
end

function DreamChallenge:getPointFatigueByHeroId(mapId, pointId, heroId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointFatigueByHeroId(heroId)
end

function DreamChallenge:getRecomandMaster(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getRecomandMaster()
end

function DreamChallenge:getPointScreen(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointScreen()
end

function DreamChallenge:getRecomandHero(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getRecomandHero()
end

function DreamChallenge:getRecomandParty(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getRecomandParty()
end

function DreamChallenge:getRecomandJob(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getRecomandJob()
end

function DreamChallenge:getRecomandTag(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getRecomandTag()
end

function DreamChallenge:getMapName(mapId)
	local mapData = self:getMapData(mapId)

	return mapData:getMapName()
end

function DreamChallenge:getMapTabImage(mapId)
	local mapData = self:getMapData(mapId)

	return mapData:getMapTabImage()
end

function DreamChallenge:getPointName(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointName()
end

function DreamChallenge:getPointTabImage(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointTabImage()
end

function DreamChallenge:getNpc(mapId, pointId, battleId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getNpc(battleId)
end

function DreamChallenge:getNpcForbidId(mapId, pointId, battleId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getNpcForbidId(battleId)
end

function DreamChallenge:getBattleBackground(mapId, pointId, battleId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getBattleBackground(battleId)
end

function DreamChallenge:getMapTimeDesc(mapId)
	local mapData = self:getMapData(mapId)

	return mapData:getMapTimeDesc()
end

function DreamChallenge:getFullStarSkill(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getFullStarSkill()
end

function DreamChallenge:getAwakenSkill(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getAwakenSkill()
end

function DreamChallenge:getBuffs(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getBuffs()
end

function DreamChallenge:checkMapShow(mapId, info, curTime)
	local mapData = self:getMapData(mapId)
	local cond = mapData:getMapShowCondition()

	if mapData:getControl() == 2 then
		return false
	end

	local isShow = not (cond and cond.LEVEL and info:getLevel() < cond.LEVEL)

	if cond and cond.Pass then
		local mapData = self:getMapData(cond.Pass)

		if not mapData:checkMapPass() then
			isShow = false
		end
	end

	if cond and cond.Day then
		local time = TimeUtil:formatStrToRemoteTImestamp(cond.Day)

		if curTime < time then
			isShow = false
		end
	end

	local endCond = mapData:getMapEndCondition()

	if endCond then
		if endCond.type == "Day" then
			local endTime = TimeUtil:formatStrToRemoteTImestamp(endCond.value)

			if endTime < curTime then
				isShow = false
			end
		elseif endCond.type == "SerDay" then
			if cond and cond.Day then
				local time = TimeUtil:formatStrToRemoteTImestamp(cond.Day)
				local endTime = time + cond.value * 24 * 3600

				if endTime < curTime then
					isShow = false
				end
			else
				isShow = false and isShow
			end
		end
	end

	return isShow
end

function DreamChallenge:checkMapLock(mapId, info, curTime)
	local tip = Strings:get("DreamChallenge_Map_Locked")
	local mapData = self:getMapData(mapId)

	if mapData:getOpenByServer() and (mapData:getEndTime() == 0 or curTime < mapData:getEndTime()) then
		return true
	end

	local cond = mapData:getMapLockCondition()

	if mapData:getControl() == 0 then
		return false, Strings:get("DreamChallenge_Mission_Not_Open")
	end

	local isShow = true

	if cond and cond.LEVEL and info:getLevel() < cond.LEVEL then
		tip = Strings:get("DreamChallenge_unlock_Level", {
			num = cond.LEVEL
		})
		isShow = false
	end

	if cond and cond.Pass then
		local mapData = self:getMapData(cond.Pass)

		if not mapData:checkMapPass() then
			isShow = false
		end
	end

	if cond and cond.Day then
		local time = TimeUtil:formatStrToRemoteTImestamp(cond.Day)

		if curTime < time then
			isShow = false
		end
	end

	local endCond = mapData:getMapEndCondition()

	if endCond then
		if endCond.type == "Day" then
			local endTime = TimeUtil:formatStrToRemoteTImestamp(endCond.value)

			if endTime < curTime then
				isShow = false
			end
		elseif endCond.type == "SerDay" then
			if cond and cond.Day then
				local time = TimeUtil:formatStrToRemoteTImestamp(cond.Day)
				local endTime = time + cond.value * 24 * 3600

				if endTime < curTime then
					isShow = false
				end
			else
				isShow = false and isShow
			end
		end
	end

	return isShow, tip
end

function DreamChallenge:checkMapPass(mapId)
	local mapData = self:getMapData(mapId)
	local points = mapData:getPointIds()

	for i = 1, #points do
		if not self:checkPointPass(mapId, points[i]) then
			return false
		end
	end

	return true
end

function DreamChallenge:getMapStartAndEndTime(mapId)
	local mapData = self:getMapData(mapId)
	local cond = mapData:getMapLockCondition()
	local endTime = 0
	local endCond = mapData:getMapEndCondition()

	if endCond then
		if endCond.type == "Day" then
			endTime = TimeUtil:formatStrToRemoteTImestamp(endCond.value)
		elseif endCond.type == "SerDay" and cond and cond.Day then
			local time = TimeUtil:formatStrToRemoteTImestamp(cond.Day)

			endTime = time + cond.value * 24 * 3600
		end
	end

	return (cond and cond.Day or nil) and TimeUtil:formatStrToRemoteTImestamp(cond.Day), endTime
end

function DreamChallenge:checkPointShow(mapId, pointId, info, curTime, ownHeros)
	local pointData = self:getPointData(mapId, pointId)
	local cond = pointData:getPointShowCond()
	local isShow = not (cond and cond.LEVEL and info:getLevel() < cond.LEVEL)

	if cond and cond.Pass then
		local mapData = self:getMapData(mapId)
		local pointIds = mapData:getPointIds()

		for i = 1, #pointIds do
			local tmpData = self:getPointData(mapId, pointIds[i])
			local battleIds = tmpData:getBattleIds()

			for j = 1, #battleIds do
				if cond.Pass == battleIds[j] and not mapData:isBattleHasPass(pointIds[i], cond.Pass) then
					isShow = false
				end
			end
		end
	end

	if cond and cond.Hero then
		for i = 1, #cond.Hero do
			local heroId = cond.Hero[i]
			local isExist = false

			for j = 1, #ownHeros do
				local id = ownHeros[j].id

				if id == heroId then
					isExist = true

					break
				end
			end

			if not isExist then
				isShow = false

				break
			end
		end
	end

	return isShow
end

function DreamChallenge:checkPointLock(mapId, pointId, info, curTime, ownHeros)
	local pointData = self:getPointData(mapId, pointId)
	local cond = pointData:getPointLockCond()
	local isShow = not (cond and cond.LEVEL and info:getLevel() < cond.LEVEL)

	if cond and cond.Pass then
		local mapData = self:getMapData(mapId)
		local pointIds = mapData:getPointIds()

		for i = 1, #pointIds do
			local tmpData = self:getPointData(mapId, pointIds[i])
			local battleIds = tmpData:getBattleIds()

			for j = 1, #battleIds do
				if cond.Pass == battleIds[j] and not mapData:isBattleHasPass(pointIds[i], cond.Pass) then
					isShow = false
				end
			end
		end
	end

	if cond and cond.Hero then
		for i = 1, #cond.Hero do
			local heroId = cond.Hero[i]
			local isExist = false

			for j = 1, #ownHeros do
				local id = ownHeros[j].id

				if id == heroId then
					isExist = true

					break
				end
			end

			if not isExist then
				isShow = false

				break
			end
		end
	end

	return isShow
end

function DreamChallenge:checkPointPass(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:isPass()
end

function DreamChallenge:checkBattleLock(mapId, pointId, battleId, info)
	local pointData = self:getPointData(mapId, pointId)
	local cond = pointData:getBattleLockCond(battleId)
	local isShow = not (cond and cond.LEVEL and info:getLevel() < cond.LEVEL)

	if cond and cond.Pass then
		local mapData = self:getMapData(mapId)
		local pointIds = mapData:getPointIds()

		for i = 1, #pointIds do
			local pointData = self:getPointData(mapId, pointIds[i])
			local battleIds = pointData:getBattleIds()

			for j = 1, #battleIds do
				if battleIds[j] == cond.Pass then
					if pointIds[i] == pointId then
						if not self:checkBattlePass(mapId, pointIds[i], cond.Pass) then
							isShow = false
						end
					elseif not self:isBattleHasPass(mapId, pointIds[i], cond.Pass) then
						isShow = false
					end
				end
			end
		end
	end

	return isShow
end

function DreamChallenge:checkBattlePass(mapId, pointId, battleId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:isBattlePass(battleId)
end

function DreamChallenge:isBattleHasPass(mapId, pointId, battleId)
	local mapData = self:getMapData(mapId)

	return mapData:isBattleHasPass(pointId, battleId)
end

function DreamChallenge:checkBattleRewarded(mapId, pointId, battleId)
	local mapData = self:getMapData(mapId)

	return mapData:checkBattleRewarded(pointId, battleId)
end

function DreamChallenge:checkBattleRewardLock(mapId, pointId, battleId)
	local mapData = self:getMapData(mapId)

	return mapData:checkBattleRewardLock(pointId, battleId)
end

function DreamChallenge:checkActivityDreamChallengeOpen(playerInfo, curTime)
	for i = 1, #self._mapIds do
		local mapData = self:getMapData(self._mapIds[i])

		if mapData:getDCType() == 1 and self:checkMapLock(self._mapIds[i], playerInfo, curTime) and self:checkMapShow(self._mapIds[i], playerInfo, curTime) then
			return true
		end
	end

	return false
end

function DreamChallenge:getBattleReward(mapId, pointId, battleId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getBattleReward(battleId)
end

function DreamChallenge:getPointShowImg(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointShowImg()
end

function DreamChallenge:getPointMapShowImg(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointMapShowImg()
end

function DreamChallenge:getPointLongDesc(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointLongDesc()
end

function DreamChallenge:getPointIds(mapId)
	local mapData = self:getMapData(mapId)

	return mapData:getPointIds()
end

function DreamChallenge:getEndTime(mapId)
	local mapData = self:getMapData(mapId)

	return mapData:getEndTime()
end

function DreamChallenge:getShortDesc(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getShortDesc()
end

function DreamChallenge:getPointLockCond(mapId, pointId)
	local pointData = self:getPointData(mapId, pointId)

	return pointData:getPointLockCond()
end

function DreamChallenge:getMapBGM(mapId)
	local mapData = self:getMapData(mapId)

	return mapData:getMapBGM()
end
