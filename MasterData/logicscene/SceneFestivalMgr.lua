-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneFestivalMgr.lua

module("logicscene.scene.SceneFestivalMgr", package.seeall)

local SceneFestivalMgr = class("SceneFestivalMgr")

function SceneFestivalMgr:ctor()
	self._sceneFestivals = {}
end

function SceneFestivalMgr:buildSceneFestivalMO(sceneId)
	if self._sceneFestivals[sceneId] then
		return
	end

	local cfgs = SceneConfig.instance:getSceneFestivals(sceneId)

	if not cfgs then
		return
	end

	local now = ServerTime.now()
	local dTime = ServerTime.nowDateServerLook()

	for k, v in pairs(cfgs) do
		local festivalMo = SceneFestivalMO.New()

		festivalMo.sceneId = sceneId
		festivalMo.festival = k
		festivalMo.startTimeStamp = GameUtil.string2time(v.startTime)
		festivalMo.endTimeStamp = GameUtil.string2time(v.endTime)

		if not string.nilorempty(v.hours) then
			local nHours = string.split(v.hours, "-")

			festivalMo.startHours = checknumber(nHours[1])
			festivalMo.endHours = checknumber(nHours[2])
		end

		self._sceneFestivals[sceneId] = self._sceneFestivals[sceneId] or {}
		self._sceneFestivals[sceneId][k] = festivalMo
	end
end

function SceneFestivalMgr:getActiveFestival(sceneId)
	self:buildSceneFestivalMO(sceneId)

	local festivalMos = self._sceneFestivals[sceneId]

	if not festivalMos then
		return
	end

	local now = ServerTime.now()
	local dTime = ServerTime.nowDateServerLook()

	for k, v in pairs(festivalMos) do
		if self:isFesvitalActive(sceneId, k, now, dTime) then
			return v
		end
	end
end

function SceneFestivalMgr:isFesvitalActive(sceneId, festival, nowStamp, nowDate)
	local mo = self:getFesvital(sceneId, festival)

	if not mo then
		return
	end

	local now = nowStamp or ServerTime.now()
	local dTime = nowDate or ServerTime.nowDateServerLook()
	local startTime = mo.startTimeStamp
	local endTime = mo.endTimeStamp

	if startTime <= now and now < endTime then
		local startHour = mo.startHours
		local endHour = mo.endHours

		if startHour == 0 and endHour == 0 then
			return true
		end

		local day = dTime.day
		local startTimeToday = GameUtil.date2time(dTime.year, dTime.month, day, startHour, 0, 0)

		if endHour < startHour then
			day = day + 1
		end

		local endTimeToday = GameUtil.date2time(dTime.year, dTime.month, day, endHour, 0, 0)

		if startTimeToday <= now and now < endTimeToday then
			return true
		end
	end
end

function SceneFestivalMgr:getFesvital(sceneId, festival)
	if string.nilorempty(festival) then
		return
	end

	self:buildSceneFestivalMO(sceneId)

	local festivalMos = self._sceneFestivals[sceneId]

	if not festivalMos then
		return
	end

	return festivalMos[festival]
end

function SceneFestivalMgr:getNextActiveFesvital(sceneId)
	self:buildSceneFestivalMO(sceneId)

	local festivalMos = self._sceneFestivals[sceneId]

	if not festivalMos then
		return
	end

	local now, dTime, nearestMo
	local nearestTime = math.huge

	for k, v in pairs(festivalMos) do
		now = now or ServerTime.now()

		local endTime = v.endTimeStamp

		if now < endTime then
			dTime = dTime or ServerTime.nowDateServerLook()

			if self:isFesvitalActive(sceneId, k, now, dTime) then
				return v
			end

			local startTime = v.startTimeStamp
			local startHour = v.startHours
			local endHour = v.endHours

			if startHour == 0 and endHour == 0 then
				return v
			end

			local startDate = startTime <= now and dTime or GameUtil.time2date(startTime)
			local day = startDate.day
			local startTimeToday = GameUtil.date2time(startDate.year, startDate.month, day, startHour, 0, 0)

			if startTimeToday < nearestTime then
				nearestTime = startTimeToday
				nearestMo = v
			end
		end
	end

	return nearestMo
end

function SceneFestivalMgr:exchangeFestival(festival)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if not mainPlayer then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	if not scene or not scene.getFestival then
		return
	end

	local currFestival = scene:getFestival()

	if currFestival == festival then
		return
	end

	local sceneId = scene:getSceneId()
	local sceneType = scene:getSceneType()
	local x, y = mainPlayer.transform:getPos()
	local playerUsersVars
	local underBridge = mainPlayer:isUnderBridge()
	local defaultView = scene.defaultView

	SceneMgr.instance:enter(sceneType, sceneId, x, y, underBridge, playerUsersVars, defaultView, festival)
end

function SceneFestivalMgr:clear()
	self._sceneFestivals = {}
end

SceneFestivalMgr.instance = SceneFestivalMgr.New()

return SceneFestivalMgr
