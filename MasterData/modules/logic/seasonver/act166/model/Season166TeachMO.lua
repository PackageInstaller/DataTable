-- chunkname: @modules/logic/seasonver/act166/model/Season166TeachMO.lua

module("modules.logic.seasonver.act166.model.Season166TeachMO", package.seeall)

local Season166TeachMO = pureTable("Season166TeachMO")

function Season166TeachMO:ctor()
	self.id = 0
	self.passCount = 0
end

function Season166TeachMO:setData(info)
	self.id = info.id
	self.passCount = info.passCount
end

return Season166TeachMO
