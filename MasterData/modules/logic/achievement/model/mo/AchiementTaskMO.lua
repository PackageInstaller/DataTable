-- chunkname: @modules/logic/achievement/model/mo/AchiementTaskMO.lua

module("modules.logic.achievement.model.mo.AchiementTaskMO", package.seeall)

local AchiementTaskMO = pureTable("AchiementTaskMO")

function AchiementTaskMO:init(config)
	self.cfg = config
	self.id = config.id
end

function AchiementTaskMO:updateByServerData(serverData)
	self.progress = serverData.progress
	self.hasFinished = serverData.hasFinish
	self.isNew = serverData.new
	self.finishTime = serverData.finishTime
end

return AchiementTaskMO
