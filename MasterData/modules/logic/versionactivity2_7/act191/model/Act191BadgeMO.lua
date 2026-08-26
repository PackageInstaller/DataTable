-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191BadgeMO.lua

module("modules.logic.versionactivity2_7.act191.model.Act191BadgeMO", package.seeall)

local Act191BadgeMO = pureTable("Act191BadgeMO")

function Act191BadgeMO:init(badgeCo)
	self.config = badgeCo
	self.id = badgeCo.id
	self.count = 0
	self.act = false
	self.sp = false
end

function Act191BadgeMO:update(info)
	self.count = info.count
	self.act = info.act
	self.sp = info.sp
end

function Act191BadgeMO:getState()
	if self.sp then
		return Activity191Enum.BadgeState.Sp
	elseif self.act then
		return Activity191Enum.BadgeState.Light
	end

	return Activity191Enum.BadgeState.Normal
end

return Act191BadgeMO
