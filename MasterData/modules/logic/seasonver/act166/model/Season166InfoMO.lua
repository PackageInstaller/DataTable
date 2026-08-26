-- chunkname: @modules/logic/seasonver/act166/model/Season166InfoMO.lua

module("modules.logic.seasonver.act166.model.Season166InfoMO", package.seeall)

local Season166InfoMO = pureTable("Season166InfoMO")

function Season166InfoMO:init(activityId)
	self.id = 0
	self.stage = 0
	self.bonusStage = 0
	self.activityId = activityId
end

function Season166InfoMO:setData(info)
	self.id = info.id
	self.stage = info.stage
	self.bonusStage = info.bonusStage
end

function Season166InfoMO:hasAnaly()
	local dict = Season166Config.instance:getSeasonInfoAnalys(self.activityId, self.id) or {}

	return dict[self.stage + 1] == nil
end

return Season166InfoMO
