-- chunkname: @modules/logic/milestone/model/MileStoneListMO.lua

module("modules.logic.milestone.model.MileStoneListMO", package.seeall)

local MileStoneListMO = pureTable("MileStoneListMO")

function MileStoneListMO:init(id, config)
	self.id = id
	self.config = config
end

function MileStoneListMO:getConfig()
	return self.config
end

function MileStoneListMO:getProgress()
	return self.config.needProgress
end

return MileStoneListMO
