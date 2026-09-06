-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/controller/DreamIslandController.lua

module("logic.extensions.accumulategift.controller.DreamIslandController", package.seeall)

local DreamIslandController = class("DreamIslandController", BaseController)

function DreamIslandController:ctor()
	return
end

function DreamIslandController:onInit()
	DreamIslandController.super.onInit(self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
	DreamIslanTaskAgent.instance:addHandler(DreamIslanTaskAgent.PM_DreamIslanTaskGetInfoRes, self.SCPushDreamIslandTaskData, self)
end

function DreamIslandController:_TickDailyRefreshData()
	if ViewMgr.instance:isOpen(ViewName.DreamIsland) then
		DreamIslandModel.instance:GetSetChoiseTableNums(true)
		self:CSRequestDreamIslandTaskData()
	end
end

function DreamIslandController:CSRequestDreamIslandTaskData()
	DreamIslanTaskAgent.instance:sendPM_DreamIslanTaskGetInfoReq()
end

function DreamIslandController:SCPushDreamIslandTaskData(msg)
	DreamIslandModel.instance:SCPushDreamIslandTaskData(msg)
end

function DreamIslandController:CSRequestReceiveTask(taskId)
	local actiId = DreamIslandModel.instance._activityId

	if checknumber(actiId) <= 0 or checknumber(taskId) < 0 then
		return
	end

	DreamIslanTaskAgent.instance:sendPM_GainDreamIslandTaskPrizeReq(actiId, taskId, function(msg)
		DreamIslandModel.instance:SCPushReceiveTask(taskId)
	end)
end

function DreamIslandController:CSRequestReceiveScore(index)
	local actiId = DreamIslandModel.instance._activityId

	if checknumber(actiId) <= 0 or checknumber(index) < 0 then
		return
	end

	DreamIslanTaskAgent.instance:sendPM_GainDreamIslanTaskScorePrizeReq(actiId, index, function(msg)
		DreamIslandModel.instance:SCPushReceiveScore(index + 1)
	end)
end

DreamIslandController.instance = DreamIslandController.New()

return DreamIslandController
