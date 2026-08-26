-- chunkname: @modules/logic/versionactivity2_0/dungeon/model/Activity161MO.lua

module("modules.logic.versionactivity2_0.dungeon.model.Activity161MO", package.seeall)

local Activity161MO = pureTable("Activity161MO")

function Activity161MO:ctor()
	self.id = 0
	self.state = 0
	self.cdBeginTime = nil
	self.config = nil
end

function Activity161MO:init(info, config)
	self.id = info.id
	self.state = info.state
	self.cdBeginTime = tonumber(info.mainElementCdBeginTime)
	self.config = config
end

function Activity161MO:isInCdTime()
	if self.cdBeginTime and self.cdBeginTime > 0 then
		return ServerTime.now() - self.cdBeginTime / 1000 < self.config.mainElementCd
	end

	return false
end

function Activity161MO:getRemainUnlockTime()
	if self.cdBeginTime and self.cdBeginTime > 0 then
		local unlockTime = self.cdBeginTime / 1000 + self.config.mainElementCd

		return Mathf.Max(unlockTime - ServerTime.now(), 0)
	end

	return 0
end

function Activity161MO:updateInfo(info)
	self.state = info.state
	self.cdBeginTime = tonumber(info.mainElementCdBeginTime)
end

return Activity161MO
