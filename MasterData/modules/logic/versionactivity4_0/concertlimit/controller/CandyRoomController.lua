-- chunkname: @modules/logic/versionactivity4_0/concertlimit/controller/CandyRoomController.lua

module("modules.logic.versionactivity4_0.concertlimit.controller.CandyRoomController", package.seeall)

local CandyRoomController = class("CandyRoomController", BaseController)

function CandyRoomController:onInit()
	self:reInit()
end

function CandyRoomController:reInit()
	self._hasGet = nil
end

function CandyRoomController:addConstEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function CandyRoomController:_onDailyRefresh()
	self._hasGet = nil

	self:onRefreshActivity()
end

function CandyRoomController:onRefreshActivity()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertCandyRoom
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		Activity245Rpc.instance:sendAct245GetInfoRequest(actId)

		local loginActId = CandyRoomModel.instance:getLoginActivityId(actId)
		local loginActInfoMo = ActivityModel.instance:getActivityInfo()[loginActId]
		local isLoginActOnline = loginActInfoMo:isOnline() and loginActInfoMo:isOpen() and loginActInfoMo:getRealEndTimeStamp() - ServerTime.now() > 1

		if isLoginActOnline then
			Activity101Rpc.instance:sendGet101InfosRequest(loginActId)
		end
	end

	self._hasGet = couldGet
end

function CandyRoomController:openCandyRoomMainView()
	ViewMgr.instance:openView(ViewName.CandyRoomMainView)
end

function CandyRoomController:openCandyRoomPanelView()
	ViewMgr.instance:openView(ViewName.CandyRoomPanelView)
end

function CandyRoomController:openCandyRoomRewardDetailView()
	ViewMgr.instance:openView(ViewName.CandyRoomRewardDetailView)
end

function CandyRoomController:openCandyRoomSkinView()
	ViewMgr.instance:openView(ViewName.CandyRoomSkinView)
end

CandyRoomController.instance = CandyRoomController.New()

return CandyRoomController
