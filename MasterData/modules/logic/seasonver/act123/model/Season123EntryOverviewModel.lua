-- chunkname: @modules/logic/seasonver/act123/model/Season123EntryOverviewModel.lua

module("modules.logic.seasonver.act123.model.Season123EntryOverviewModel", package.seeall)

local Season123EntryOverviewModel = class("Season123EntryOverviewModel", BaseModel)

function Season123EntryOverviewModel:release()
	return
end

function Season123EntryOverviewModel:init(actId)
	self.activityId = actId
end

function Season123EntryOverviewModel:getActId()
	return self.activityId
end

function Season123EntryOverviewModel:getStageMO(stage)
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return nil
	end

	return seasonMO:getStageMO(stage)
end

function Season123EntryOverviewModel:stageIsPassed(stage)
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return false
	end

	local stageMO = seasonMO.stageMap[stage]

	return stageMO and stageMO.isPass
end

Season123EntryOverviewModel.instance = Season123EntryOverviewModel.New()

return Season123EntryOverviewModel
