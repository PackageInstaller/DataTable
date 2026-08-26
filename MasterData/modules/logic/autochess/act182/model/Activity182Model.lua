-- chunkname: @modules/logic/autochess/act182/model/Activity182Model.lua

module("modules.logic.autochess.act182.model.Activity182Model", package.seeall)

local Activity182Model = class("Activity182Model", BaseModel)

function Activity182Model:onInit()
	self:reInit()
end

function Activity182Model:reInit()
	self.actMoDic = {}
end

function Activity182Model:setActInfo(info)
	self.curActId = info.activityId

	local mo = self.actMoDic[self.curActId]

	if mo then
		mo:update(info)
	else
		mo = Act182MO.New()

		mo:init(info)

		self.actMoDic[self.curActId] = mo
	end

	Activity182Controller.instance:dispatchEvent(Activity182Event.UpdateInfo)
end

function Activity182Model:getCurActId()
	return self.curActId
end

function Activity182Model:getActMo(actId)
	actId = actId or self.curActId

	local mo = self.actMoDic[actId]

	if not mo then
		logError("不存在活动数据" .. tostring(actId))
	end

	return mo
end

Activity182Model.instance = Activity182Model.New()

return Activity182Model
