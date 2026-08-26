-- chunkname: @modules/logic/main/view/ActCenterItem_RoleSignViewBtn_1_4.lua

module("modules.logic.main.view.ActCenterItem_RoleSignViewBtn_1_4", package.seeall)

local ActCenterItem_RoleSignViewBtn_1_4 = class("ActCenterItem_RoleSignViewBtn_1_4", ActCenterItemBase)

function ActCenterItem_RoleSignViewBtn_1_4:onInit(go)
	return
end

function ActCenterItem_RoleSignViewBtn_1_4:onAddEvent()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._refreshRedDot, self)
end

function ActCenterItem_RoleSignViewBtn_1_4:onRemoveEvent()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._refreshRedDot, self)
end

function ActCenterItem_RoleSignViewBtn_1_4:onClick()
	local viewName = self:_viewNameAndParam()

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	local actId = self:_actId()

	Activity101Rpc.instance:sendGet101InfosRequest(actId, self._onReceiveGet101InfosReply, self)
end

function ActCenterItem_RoleSignViewBtn_1_4:_onReceiveGet101InfosReply(_, resultCode)
	if resultCode == 0 then
		local viewName, viewParam = self:_viewNameAndParam()

		ViewMgr.instance:openView(viewName, viewParam)
	else
		GameFacade.showToast(ToastEnum.BattlePass)
	end
end

function ActCenterItem_RoleSignViewBtn_1_4:_viewNameAndParam()
	local data = self:getCustomData()
	local viewParam = data.viewParam
	local viewName = data.viewName

	return viewName, viewParam
end

function ActCenterItem_RoleSignViewBtn_1_4:_actId()
	local data = self:getCustomData()
	local viewParam = data.viewParam

	return viewParam.actId
end

function ActCenterItem_RoleSignViewBtn_1_4:_tryInit()
	local actId = self:_actId()

	if not ActivityType101Model.instance:isInit(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	end
end

function ActCenterItem_RoleSignViewBtn_1_4:onOpen()
	self:_tryInit()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function ActCenterItem_RoleSignViewBtn_1_4:onRefresh()
	self:_setMainSprite("icon_6")
end

function ActCenterItem_RoleSignViewBtn_1_4:_checkRed()
	local actId = self:_actId()

	return not not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

return ActCenterItem_RoleSignViewBtn_1_4
