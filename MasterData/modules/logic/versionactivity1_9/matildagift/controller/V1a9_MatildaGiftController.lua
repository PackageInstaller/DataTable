-- chunkname: @modules/logic/versionactivity1_9/matildagift/controller/V1a9_MatildaGiftController.lua

module("modules.logic.versionactivity1_9.matildagift.controller.V1a9_MatildaGiftController", package.seeall)

local V1a9_MatildaGiftController = class("V1a9_MatildaGiftController", BaseController)

function V1a9_MatildaGiftController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._checkActivityInfo, self)
end

function V1a9_MatildaGiftController:reInit()
	return
end

function V1a9_MatildaGiftController:_checkActivityInfo(actId)
	local _actId = V1a9_MatildaGiftModel.instance:getMatildagiftActId()

	if ActivityHelper.getActivityStatus(_actId) == ActivityEnum.ActivityStatus.Normal then
		self:sendGet101InfosRequest()
	end
end

function V1a9_MatildaGiftController:openMatildaGiftView()
	local isOpen = V1a9_MatildaGiftModel.instance:isMatildaGiftOpen(true)

	if not isOpen then
		return
	end

	self:sendGet101InfosRequest(self._realOpenMatildaGiftView)
end

function V1a9_MatildaGiftController:_realOpenMatildaGiftView()
	local isShowRedDot = V1a9_MatildaGiftModel.instance:isShowRedDot()

	ViewMgr.instance:openView(ViewName.V1a9_MatildagiftView, {
		isDisplayView = not isShowRedDot
	})
end

function V1a9_MatildaGiftController:sendGet101InfosRequest(callback)
	local actId = V1a9_MatildaGiftModel.instance:getMatildagiftActId()

	Activity101Rpc.instance:sendGet101InfosRequest(actId, callback, self)
end

V1a9_MatildaGiftController.instance = V1a9_MatildaGiftController.New()

return V1a9_MatildaGiftController
