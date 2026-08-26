-- chunkname: @modules/logic/main/view/Activity101SignViewBtnBase.lua

module("modules.logic.main.view.Activity101SignViewBtnBase", package.seeall)

local Activity101SignViewBtnBase = class("Activity101SignViewBtnBase", ActCenterItemBase)

function Activity101SignViewBtnBase:onAddEvent()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._refreshRedDot, self)
end

function Activity101SignViewBtnBase:onRemoveEvent()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._refreshRedDot, self)
end

function Activity101SignViewBtnBase:onClick()
	local viewName, _ = self:onGetViewNameAndParam()

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	local actId = self:onGetActId()

	Activity101Rpc.instance:sendGet101InfosRequest(actId, self._onReceiveGet101InfosReply, self)
end

function Activity101SignViewBtnBase:_onReceiveGet101InfosReply(_, resultCode)
	if resultCode == 0 then
		local viewName, viewParam = self:onGetViewNameAndParam()

		ViewMgr.instance:openView(viewName, viewParam)
	else
		GameFacade.showToast(ToastEnum.BattlePass)
	end
end

function Activity101SignViewBtnBase:_tryInit()
	local actId = self:onGetActId()

	if not ActivityType101Model.instance:isInit(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	end
end

function Activity101SignViewBtnBase:onOpen()
	self:_tryInit()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function Activity101SignViewBtnBase:_checkRed()
	local actId = self:onGetActId()

	return not not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

function Activity101SignViewBtnBase:onRefresh()
	assert(false, "please override this function")
end

function Activity101SignViewBtnBase:onGetViewNameAndParam()
	local data = self:getCustomData()
	local viewParam = data.viewParam
	local viewName = data.viewName

	return viewName, viewParam
end

function Activity101SignViewBtnBase:onGetActId()
	local data = self:getCustomData()
	local viewParam = data.viewParam

	return viewParam.actId
end

return Activity101SignViewBtnBase
