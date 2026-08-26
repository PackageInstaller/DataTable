-- chunkname: @modules/logic/seasonver/act166/model/Season166TrainMO.lua

module("modules.logic.seasonver.act166.model.Season166TrainMO", package.seeall)

local Season166TrainMO = pureTable("Season166TrainMO")

function Season166TrainMO:ctor()
	self.id = 0
	self.passCount = 0
end

function Season166TrainMO:setData(info)
	self.id = info.id
	self.passCount = info.passCount
end

return Season166TrainMO
