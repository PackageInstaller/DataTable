-- chunkname: @modules/logic/commandstation/model/CommandPostEventInfoMO.lua

module("modules.logic.commandstation.model.CommandPostEventInfoMO", package.seeall)

local CommandPostEventInfoMO = pureTable("CommandPostEventInfoMO")

function CommandPostEventInfoMO:init(info)
	self.hasInit = true
	self.id = info.id
	self.state = info.state
	self.heroIds = {}

	for i, v in ipairs(info.heroIds) do
		table.insert(self.heroIds, v)
	end

	self.startTime = tonumber(info.startTime / 1000)
	self.endTime = tonumber(info.endTime / 1000)
	self.read = info.read
end

function CommandPostEventInfoMO:isFinished()
	if not self.endTime then
		return false
	end

	local now = ServerTime.now()

	return now >= self.endTime
end

function CommandPostEventInfoMO:hasGetReward()
	return self.state == CommandStationEnum.EventState.GetReward
end

function CommandPostEventInfoMO:getTimeInfo()
	local remainTime = self.endTime - ServerTime.now()

	remainTime = math.max(remainTime, 0)

	return remainTime, self.endTime - self.startTime
end

return CommandPostEventInfoMO
