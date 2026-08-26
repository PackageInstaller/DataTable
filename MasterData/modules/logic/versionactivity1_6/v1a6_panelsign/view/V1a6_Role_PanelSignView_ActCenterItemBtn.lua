-- chunkname: @modules/logic/versionactivity1_6/v1a6_panelsign/view/V1a6_Role_PanelSignView_ActCenterItemBtn.lua

module("modules.logic.versionactivity1_6.v1a6_panelsign.view.V1a6_Role_PanelSignView_ActCenterItemBtn", package.seeall)

local V1a6_Role_PanelSignView_ActCenterItemBtn = class("V1a6_Role_PanelSignView_ActCenterItemBtn", ActCenterItemBase)

function V1a6_Role_PanelSignView_ActCenterItemBtn:onInit(go)
	return
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:onAddEvent()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._refreshRedDot, self)
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:onRemoveEvent()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._refreshRedDot, self)
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:onClick()
	local viewName = self:_viewNameAndParam()

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	local actId = self:_actId()

	Activity101Rpc.instance:sendGet101InfosRequest(actId, self._onReceiveGet101InfosReply, self)
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:_onReceiveGet101InfosReply(_, resultCode)
	if resultCode == 0 then
		local viewName, viewParam = self:_viewNameAndParam()

		ViewMgr.instance:openView(viewName, viewParam)
	else
		GameFacade.showToast(ToastEnum.BattlePass)
	end
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:_viewNameAndParam()
	local data = self:getCustomData()
	local viewParam = data.viewParam
	local viewName = data.viewName

	return viewName, viewParam
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:_actId()
	local data = self:getCustomData()
	local viewParam = data.viewParam

	return viewParam.actId
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:_tryInit()
	local actId = self:_actId()

	if not ActivityType101Model.instance:isInit(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	end
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:onOpen()
	self:_tryInit()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:onRefresh()
	self:_setMainSprite("v1a6_act_icon3")
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:_checkRed()
	local actId = self:_actId()

	return not not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

function V1a6_Role_PanelSignView_ActCenterItemBtn:_gm_ActIds()
	return {
		ActivityEnum.Activity.RoleSignViewPart1_1_6,
		ActivityEnum.Activity.RoleSignViewPart2_1_6
	}
end

return V1a6_Role_PanelSignView_ActCenterItemBtn
