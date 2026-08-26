-- chunkname: @modules/logic/versionactivity3_6/activitycollect/model/ActivityCollectModel.lua

module("modules.logic.versionactivity3_6.activitycollect.model.ActivityCollectModel", package.seeall)

local ActivityCollectModel = class("ActivityCollectModel", BaseModel)

function ActivityCollectModel:onInit()
	self:reInit()
end

function ActivityCollectModel:reInit()
	return
end

function ActivityCollectModel:getCurActivityId()
	return ActivityConfig.instance:getConstAsNum(ActivityEnum.ConstId.ActivityCollect, VersionActivity3_5Enum.ActivityId.ActivityCollect)
end

ActivityCollectModel.instance = ActivityCollectModel.New()

return ActivityCollectModel
