-- chunkname: @modules/logic/versionactivity1_5/dungeon/model/VersionActivity1_5DispatchMo.lua

module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DispatchMo", package.seeall)

local VersionActivity1_5DispatchMo = pureTable("DispatchMo")

function VersionActivity1_5DispatchMo:init(dispatchInfo)
	self.id = dispatchInfo.id
	self.config = VersionActivity1_5DungeonConfig.instance:getDispatchCo(self.id)

	self:update(dispatchInfo)
end

function VersionActivity1_5DispatchMo:update(dispatchInfo)
	self.endTime = Mathf.Floor(tonumber(dispatchInfo.endTime) / 1000)
	self.heroIdList = {}

	for _, heroId in ipairs(dispatchInfo.heroIds) do
		table.insert(self.heroIdList, heroId)
	end
end

function VersionActivity1_5DispatchMo:isFinish()
	return self.endTime <= ServerTime.now()
end

function VersionActivity1_5DispatchMo:isRunning()
	return self.endTime > ServerTime.now()
end

function VersionActivity1_5DispatchMo:getRemainTime()
	return Mathf.Max(self.endTime - ServerTime.now(), 0)
end

function VersionActivity1_5DispatchMo:getRemainTimeStr(maxTime)
	local remainSecond = self:getRemainTime()
	local hours = math.floor(remainSecond / TimeUtil.OneHourSecond)
	local minutes = math.floor(remainSecond % TimeUtil.OneHourSecond / 60)
	local seconds = remainSecond % 60

	return string.format("%02d : %02d : %02d", hours, minutes, seconds)
end

return VersionActivity1_5DispatchMo
