-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186MainBtnItem.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186MainBtnItem", package.seeall)

local Activity186MainBtnItem = class("Activity186MainBtnItem", ActCenterItemBase)

function Activity186MainBtnItem:onAddEvent()
	gohelper.addUIClickAudio(self._btnitem)
	Activity186Controller.instance:registerCallback(Activity186Event.RefreshRed, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
end

function Activity186MainBtnItem:onRemoveEvent()
	Activity186Controller.instance:unregisterCallback(Activity186Event.RefreshRed, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
end

function Activity186MainBtnItem:onClick()
	local actId = self:onGetActId()

	Activity186Rpc.instance:sendGetAct186InfoRequest(actId, self._onReceiveGetInfosReply, self)
end

function Activity186MainBtnItem:_onReceiveGetInfosReply(_, resultCode)
	if resultCode == 0 then
		local viewName, viewParam = self:onGetViewNameAndParam()

		ViewMgr.instance:openView(viewName, viewParam)
	end
end

function Activity186MainBtnItem:refreshData()
	local actId = Activity186Model.instance:getActId()
	local data = {
		viewName = "Activity186View",
		viewParam = {
			actId = actId
		}
	}

	self:setCustomData(data)
end

function Activity186MainBtnItem:onOpen()
	self:refreshData()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function Activity186MainBtnItem:_checkRed()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a5_Act186, 0) then
		return true
	end

	if Activity186Model.instance:isShowSignRed() then
		return true
	end

	local actId = Activity186Model.instance:getActId()
	local actMO = Activity186Model.instance:getById(actId)

	if actMO and actMO:isCanShowAvgBtn() then
		return true
	end

	return false
end

function Activity186MainBtnItem:onRefresh()
	self:refreshData()

	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_6")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function Activity186MainBtnItem:onGetViewNameAndParam()
	local data = self:getCustomData()
	local viewParam = data.viewParam
	local viewName = data.viewName

	return viewName, viewParam
end

function Activity186MainBtnItem:onGetActId()
	local data = self:getCustomData()
	local viewParam = data.viewParam

	return viewParam.actId
end

function Activity186MainBtnItem:refreshDot()
	self:_refreshRedDot()
end

function Activity186MainBtnItem:_gm_ActIds()
	return {
		Activity186Model.instance:getActId()
	}
end

return Activity186MainBtnItem
