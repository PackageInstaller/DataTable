-- chunkname: @modules/logic/versionactivity3_2/cruise/controller/Activity217Controller.lua

module("modules.logic.versionactivity3_2.cruise.controller.Activity217Controller", package.seeall)

local Activity217Controller = class("Activity217Controller", BaseController)

function Activity217Controller:onInit()
	return
end

function Activity217Controller:reInit()
	return
end

function Activity217Controller:onInitFinish()
	return
end

function Activity217Controller:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Activity217Controller:onRefreshActivity()
	self:_checkAndGetActInfo()
end

function Activity217Controller:dailyRefresh()
	Activity217Model.instance:reInit()
	self:_checkAndGetActInfo()
end

function Activity217Controller:_checkAndGetActInfo()
	local actIdList = Activity217Config.instance:getActIdList()

	for index, actId in ipairs(actIdList) do
		local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

		if actInfoMo and actInfoMo:isOnline() and actInfoMo:isOpen() and not actInfoMo:isExpired() then
			Activity217Rpc.instance:sendGet217InfosRequest(actId)
		end
	end
end

Activity217Controller.instance = Activity217Controller.New()

return Activity217Controller
