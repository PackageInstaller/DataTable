-- chunkname: @modules/logic/versionactivity2_7/act191/model/Activity191Model.lua

module("modules.logic.versionactivity2_7.act191.model.Activity191Model", package.seeall)

local Activity191Model = class("Activity191Model", BaseModel)

function Activity191Model:onInit()
	self:reInit()
end

function Activity191Model:reInit()
	self.actMoDic = {}
end

function Activity191Model:setActInfo(activityId, actInfo)
	self.curActId = activityId
	self.actMoDic[activityId] = self.actMoDic[activityId] or Act191MO.New()

	self.actMoDic[activityId]:initBadgeInfo(activityId)
	self.actMoDic[activityId]:init(actInfo)
	Act191StatController.instance:setActInfo(self.actMoDic[activityId])
end

function Activity191Model:getCurActId()
	return self.curActId
end

function Activity191Model:getActInfo(activityId)
	activityId = activityId or self.curActId

	return self.actMoDic[activityId]
end

function Activity191Model:setGameEndInfo(info)
	self.endInfo = info
end

Activity191Model.instance = Activity191Model.New()

return Activity191Model
