-- chunkname: @modules/logic/versionactivity3_2/cruise/controller/CruiseController.lua

module("modules.logic.versionactivity3_2.cruise.controller.CruiseController", package.seeall)

local CruiseController = class("CruiseController", BaseController)

function CruiseController:onInit()
	return
end

function CruiseController:reInit()
	return
end

function CruiseController:onInitFinish()
	return
end

function CruiseController:addConstEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function CruiseController:onRefreshActivity()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony]

	if actInfoMo and actInfoMo:isOnline() and actInfoMo:isOpen() and not actInfoMo:isExpired() then
		Activity101Rpc.instance:sendGet101InfosRequest(VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony)
	end
end

function CruiseController:openCruiseMainView()
	ViewMgr.instance:openView(ViewName.CruiseMainView)
end

function CruiseController:openCruiseTripleDropView()
	ViewMgr.instance:openView(ViewName.CruiseTripleDropView)
end

function CruiseController:openCruiseOpenCeremonyView()
	local storyId = CommonConfig.instance:getConstNum(ConstEnum.CruiseOpenStory)
	local isPlayed = StoryModel.instance:isStoryFinished(storyId)

	if not isPlayed then
		StoryController.instance:playStory(storyId)
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	else
		self:_realOpenCeremony()
	end
end

function CruiseController:_onCloseViewFinish(viewName)
	if viewName == ViewName.StoryView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
		self:_realOpenCeremony()
	end
end

function CruiseController:_realOpenCeremony()
	ViewMgr.instance:openView(ViewName.CruiseOpenCeremonyView)
end

function CruiseController:openCruiseGameView()
	ViewMgr.instance:openView(ViewName.CruiseGameMainView)
end

function CruiseController:openCruiseGlobalTaskView()
	ViewMgr.instance:openView(ViewName.CruiseGlobalTaskView)
end

function CruiseController:openCruiseSelfTaskView()
	ViewMgr.instance:openView(ViewName.CruiseSelfTaskView)
end

function CruiseController:openCruiseSelfTaskHeroTypeTipView()
	ViewMgr.instance:openView(ViewName.CruiseSelfTaskHeroTypeTipView)
end

function CruiseController:openCruiseSummonNewCustomPickFullView()
	local param = {}

	param.actId = ActivityEnum.Activity.V3a2_SummonCustomPickNew
	param.refreshData = false

	ViewMgr.instance:openView(ViewName.SummonNewCustomPickFullView, param)
end

CruiseController.instance = CruiseController.New()

return CruiseController
