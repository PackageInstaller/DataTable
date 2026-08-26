-- chunkname: @modules/logic/versionactivity2_3/act174/model/Act174BadgeMO.lua

module("modules.logic.versionactivity2_3.act174.model.Act174BadgeMO", package.seeall)

local Act174BadgeMO = pureTable("Act174BadgeMO")

function Act174BadgeMO:init(badgeCo)
	self.config = badgeCo
	self.id = badgeCo.id
	self.count = 0
	self.act = false
	self.sp = false
end

function Act174BadgeMO:update(info)
	self.count = info.count
	self.act = info.act
	self.sp = info.sp
end

function Act174BadgeMO:getState()
	if self.sp then
		return Activity174Enum.BadgeState.Sp
	elseif self.act then
		return Activity174Enum.BadgeState.Light
	end

	return Activity174Enum.BadgeState.Normal
end

return Act174BadgeMO
