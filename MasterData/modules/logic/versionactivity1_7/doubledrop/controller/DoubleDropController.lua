-- chunkname: @modules/logic/versionactivity1_7/doubledrop/controller/DoubleDropController.lua

module("modules.logic.versionactivity1_7.doubledrop.controller.DoubleDropController", package.seeall)

local DoubleDropController = class("DoubleDropController", BaseController)

function DoubleDropController:onInit()
	return
end

function DoubleDropController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
end

function DoubleDropController:_checkActivityInfo(actId)
	local doubleDropId = DoubleDropModel.instance:getActId()

	if doubleDropId and not actId or actId == doubleDropId then
		if ActivityModel.instance:isActOnLine(doubleDropId) then
			Activity153Rpc.instance:sendGet153InfosRequest(doubleDropId)
		else
			ActivityController.instance:dispatchEvent(ActivityEvent.RefreshDoubleDropInfo)
		end
	end
end

function DoubleDropController:dailyRefresh()
	local doubleDropId = DoubleDropModel.instance:getActId()

	if doubleDropId and ActivityModel.instance:isActOnLine(doubleDropId) then
		Activity153Rpc.instance:sendGet153InfosRequest(doubleDropId)
	end
end

DoubleDropController.instance = DoubleDropController.New()

return DoubleDropController
