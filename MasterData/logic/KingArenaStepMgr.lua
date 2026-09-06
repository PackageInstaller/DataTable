-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/data/KingArenaStepMgr.lua

module("logic.extensions.kingarena.data.KingArenaStepMgr", package.seeall)

local KingArenaStepMgr = class("KingArenaStepMgr")

function KingArenaStepMgr:ctor()
	local seasonDataList = KingArenaConfig.instance:getSeasonDataList()

	self._seasonTimeStamps = {}
	self._periodTimeStamps = {}

	for seasonId, seasonData in ipairs(seasonDataList) do
		self._seasonTimeStamps[seasonId] = {
			GameUtil.string2time(seasonData.openTime),
			GameUtil.string2time(seasonData.endTime)
		}
		self._periodTimeStamps[seasonId] = {}

		local periodCfg = KingArenaConfig.instance:getPeriodCfg(seasonId)

		for periodId, periodData in ipairs(periodCfg) do
			self._periodTimeStamps[seasonId][periodId] = {
				GameUtil.string2time(periodData.openTime),
				GameUtil.string2time(periodData.endTime)
			}
		end
	end

	self._maxSeasonId = #seasonDataList
end

function KingArenaStepMgr:onEnter()
	self._curTimeStamp = ServerTime.now()
	self._newestSeasonId = self:_getNewestSeasonId()
	self._newestPeriodId = self:_getNewestPeriodId(self._newestSeasonId)
	self._pointSeasonId = self:_getPointSeasonId(self._newestSeasonId)
	self._pointPeriodId = self:_getPointPeriodId(self._newestSeasonId, self._newestPeriodId)
	self._oldPointSeasonId = self._pointSeasonId
	self._oldPointPeriodId = self._pointPeriodId

	self:_onTicking()
	settimer(1, self._onTicking, self)
end

function KingArenaStepMgr:onExit()
	removetimer(self._onTicking, self)
end

function KingArenaStepMgr:onDestroy()
	self._seasonTimeStamps = nil
	self._periodTimeStamps = nil
end

function KingArenaStepMgr:_onTicking()
	self._curTimeStamp = ServerTime.now()
	self._pointSeasonId = self:_getPointSeasonId(self._newestSeasonId)

	if self._pointSeasonId ~= self._oldPointSeasonId then
		self._oldPointSeasonId = self._pointSeasonId
		self._newestSeasonId = self:_getNewestSeasonId()
		self._newestPeriodId = self:_getNewestPeriodId(self._newestSeasonId)

		GlobalDispatcher:dispatch(GlobalNotify.KingArenaStepChange, KingArenaEnum.StepChangeState_Season)
	else
		self._pointPeriodId = self:_getPointPeriodId(self._newestSeasonId, self._newestPeriodId)

		if self._pointPeriodId ~= self._oldPointPeriodId then
			self._oldPointPeriodId = self._pointPeriodId
			self._newestPeriodId = self:_getNewestPeriodId(self._newestSeasonId)

			GlobalDispatcher:dispatch(GlobalNotify.KingArenaStepChange, KingArenaEnum.StepChangeState_Period)
		end
	end
end

function KingArenaStepMgr:_getNewestSeasonId()
	local newestSeasonId = 0

	for seasonId, v in ipairs(self._seasonTimeStamps) do
		local timePeriod = GameUtil.getTimePeriodBySecWithOther(self._curTimeStamp, v[1], v[2])

		if timePeriod < GameUtil.inTimePeriod then
			break
		elseif timePeriod == GameUtil.inTimePeriod then
			newestSeasonId = seasonId

			break
		elseif timePeriod > GameUtil.inTimePeriod then
			newestSeasonId = seasonId
		end
	end

	return newestSeasonId
end

function KingArenaStepMgr:_getNewestPeriodId(seasonId)
	local newestPeriodId = 0

	if self._periodTimeStamps[seasonId] then
		for periodId, v in ipairs(self._periodTimeStamps[seasonId]) do
			local timePeriod = GameUtil.getTimePeriodBySecWithOther(self._curTimeStamp, v[1], v[2])

			if timePeriod < GameUtil.inTimePeriod then
				break
			elseif timePeriod == GameUtil.inTimePeriod then
				newestPeriodId = periodId

				break
			elseif timePeriod > GameUtil.inTimePeriod then
				newestPeriodId = periodId
			end
		end
	end

	return newestPeriodId
end

function KingArenaStepMgr:_getPointSeasonId(seasonId)
	local pointSeasonId = seasonId

	if self._seasonTimeStamps[seasonId] then
		local curTimeStamps = self._seasonTimeStamps[seasonId]
		local timePeriod = GameUtil.getTimePeriodBySecWithOther(self._curTimeStamp, curTimeStamps[1], curTimeStamps[2])

		if timePeriod == GameUtil.inTimePeriod then
			pointSeasonId = seasonId
		elseif timePeriod == GameUtil.beforeTimePeriod then
			if seasonId <= 1 then
				pointSeasonId = pointSeasonId - 0.5
			else
				local timeStamp = self._seasonTimeStamps[Mathf.Max(seasonId - 1, 1)]

				if timeStamp then
					pointSeasonId = self._curTimeStamp > timeStamp[2] and pointSeasonId - 0.5 or pointSeasonId - 1
				end
			end
		elseif timePeriod == GameUtil.afterTimePeriod then
			if seasonId >= self._maxSeasonId then
				pointSeasonId = pointSeasonId + 0.5
			else
				local timeStamp = self._seasonTimeStamps[Mathf.Min(seasonId + 1, self._maxSeasonId)]

				if timeStamp then
					pointSeasonId = self._curTimeStamp < timeStamp[1] and pointSeasonId + 0.5 or pointSeasonId + 1
				end
			end
		end
	end

	return pointSeasonId
end

function KingArenaStepMgr:_getPointPeriodId(seasonId, periodId)
	local pointPeriodId = periodId

	if self._periodTimeStamps[seasonId] and self._periodTimeStamps[seasonId][periodId] then
		local curTimeStamps = self._periodTimeStamps[seasonId][periodId]
		local timePeriod = GameUtil.getTimePeriodBySecWithOther(self._curTimeStamp, curTimeStamps[1], curTimeStamps[2])

		if timePeriod == GameUtil.inTimePeriod then
			pointPeriodId = periodId
		elseif timePeriod == GameUtil.beforeTimePeriod then
			if periodId <= 1 then
				pointPeriodId = pointPeriodId - 0.5
			else
				local last = Mathf.Max(periodId - 1, 1)
				local timeStamp = self._periodTimeStamps[seasonId][last]

				if timeStamp then
					pointPeriodId = self._curTimeStamp > timeStamp[2] and pointPeriodId - 0.5 or pointPeriodId - 1
				end
			end
		elseif timePeriod == GameUtil.afterTimePeriod then
			if periodId >= #self._periodTimeStamps[seasonId] then
				pointPeriodId = pointPeriodId + 0.5
			else
				local next = Mathf.Min(periodId + 1, #self._periodTimeStamps[seasonId])
				local timeStamp = self._periodTimeStamps[seasonId][next]

				if timeStamp then
					pointPeriodId = self._curTimeStamp < timeStamp[1] and pointPeriodId + 0.5 or pointPeriodId + 1
				end
			end
		end
	end

	return pointPeriodId
end

function KingArenaStepMgr:getNewestSeasonId()
	return self._newestSeasonId
end

function KingArenaStepMgr:getNewestPeriodId()
	return self._newestPeriodId
end

function KingArenaStepMgr:getLeftSeasonTimeStamp()
	local now = self._curTimeStamp
	local stamps = self._seasonTimeStamps[self._newestSeasonId]

	if stamps then
		return Mathf.Max(stamps[2] - now, 0)
	else
		return 0
	end
end

function KingArenaStepMgr:getLeftPeriodTimeStamp()
	local now = self._curTimeStamp

	if self._periodTimeStamps[self._newestSeasonId] then
		if self._periodTimeStamps[self._newestSeasonId] then
			return Mathf.Max(self._periodTimeStamps[self._newestSeasonId][2] - now, 0)
		else
			return 0
		end
	end
end

return KingArenaStepMgr
