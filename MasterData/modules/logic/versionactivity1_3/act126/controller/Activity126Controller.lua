-- chunkname: @modules/logic/versionactivity1_3/act126/controller/Activity126Controller.lua

module("modules.logic.versionactivity1_3.act126.controller.Activity126Controller", package.seeall)

local Activity126Controller = class("Activity126Controller", BaseController)

function Activity126Controller:onInit()
	return
end

function Activity126Controller:reInit()
	return
end

function Activity126Controller:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self, LuaEventSystem.Low)
end

function Activity126Controller:dailyRefresh()
	if not Activity126Model.instance.isInit then
		return
	end

	if not ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act310) then
		return
	end

	Activity126Rpc.instance:sendGet126InfosRequest(VersionActivity1_3Enum.ActivityId.Act310)
end

Activity126Controller.instance = Activity126Controller.New()

LuaEventSystem.addEventMechanism(Activity126Controller.instance)

return Activity126Controller
