-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GodStatuesWarStepMgr.lua

module("logic.extensions.godstatueswar.data.GodStatuesWarStepMgr", package.seeall)

local GodStatuesWarStepMgr = class("GodStatuesWarStepMgr")

function GodStatuesWarStepMgr:ctor(seasonId)
	self._seasonId = seasonId
	self._seasonData = GodStatuesWarConfig.instance:getNfbSeasonData(self._seasonId)
	self._tickingDelta = 0.5

	self:onReset()
end

function GodStatuesWarStepMgr:onReset()
	self._newestStep = 1
	self._curTimeStamp = 0
	self._isNeedNotifyStepChange = false
	self._notifyChangeTickTime = 0
	self._stepTypeList = {}
	self._stepIntervalList = {}

	local stepCfg = GodStatuesWarConfig.instance:getNfbStepCfg(self._seasonId)

	for step, data in ipairs(stepCfg) do
		self._stepTypeList[step] = GodStatuesWarController.instance:getStepTypeOfGsw(self._seasonId, step)
		self._stepIntervalList[step] = GodStatuesWarController.instance:getFirstStepInterval(self._seasonId, step)
	end

	local array = string.split(self._seasonData.cannotFightTime, "#")

	self._notFightTimeStampArray = {
		GameUtil.string2time("0-0-0 " .. array[1]),
		GameUtil.string2time("0-0-0 " .. array[2])
	}
	self._notFightTimePeriod = GameUtil.errorTimePeriod
end

function GodStatuesWarStepMgr:onEnter()
	self:onReset()
	self:_onTicking()
	settimer(self._tickingDelta, self._onTicking, self)
end

function GodStatuesWarStepMgr:onExit()
	removetimer(self._onTicking, self)

	self._isNeedNotifyStepChange = false
end

function GodStatuesWarStepMgr:onDestroy()
	return
end

function GodStatuesWarStepMgr:_onTicking()
	for step, stepInterval in ipairs(self._stepIntervalList) do
		local lastStepInterval = GodStatuesWarController.instance:getLastStepInterval(self._seasonId, step)

		if stepInterval < lastStepInterval then
			self._stepIntervalList[step] = GodStatuesWarController.instance:getStepInterval(self._seasonId, step)

			if stepInterval ~= self._stepIntervalList[step] then
				self._isNeedNotifyStepChange = true
			end
		end
	end

	local notFightTimePeriod = GameUtil.getTimePeriodTypeBySec(self._notFightTimeStampArray[1], self._notFightTimeStampArray[2])

	if self._notFightTimePeriod ~= notFightTimePeriod then
		self._isNeedNotifyStepChange = true
		self._notFightTimePeriod = notFightTimePeriod
	end

	if self._isNeedNotifyStepChange then
		self._notifyChangeTickTime = self._notifyChangeTickTime + self._tickingDelta

		if self._notifyChangeTickTime >= 2 then
			self._isNeedNotifyStepChange = false
			self._notifyChangeTickTime = 0

			GlobalDispatcher:dispatch(GlobalNotify.GodStatuesWarStepChange)
		end
	end
end

function GodStatuesWarStepMgr:getSeasonId()
	return self._seasonId
end

function GodStatuesWarStepMgr:getNewestStep()
	local newestStep

	for step, stepInterval in ipairs(self._stepIntervalList) do
		newestStep = step

		local lastStepInterval = GodStatuesWarController.instance:getLastStepInterval(self._seasonId, step)

		if stepInterval < lastStepInterval then
			break
		end
	end

	return newestStep
end

function GodStatuesWarStepMgr:getStepInterval(step)
	return self._stepIntervalList[step]
end

return GodStatuesWarStepMgr
