-- chunkname: @modules/logic/versionactivity3_2/cruise/view/ActivityCruiseMainBtnItem.lua

module("modules.logic.versionactivity3_2.cruise.view.ActivityCruiseMainBtnItem", package.seeall)

local ActivityCruiseMainBtnItem = class("ActivityCruiseMainBtnItem", ActCenterItemBase)

function ActivityCruiseMainBtnItem:onAddEvent()
	Activity218Controller.instance:registerCallback(Activity218Event.OnMsgInfoChange, self.refreshDot, self)
	Activity218Controller.instance:registerCallback(Activity218Event.OnReceiveAcceptRewardReply, self.refreshDot, self)
	Activity216Controller.instance:registerCallback(Activity216Event.onInfoChanged, self.refreshDot, self)
	Activity216Controller.instance:registerCallback(Activity216Event.onTaskInfoUpdate, self.refreshDot, self)
	Activity216Controller.instance:registerCallback(Activity216Event.onBonusStateChange, self.refreshDot, self)
	Activity215Controller.instance:registerCallback(Activity215Event.onItemSubmitCountChange, self.refreshDot, self)
	Activity215Controller.instance:registerCallback(Activity215Event.OnInfoChanged, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
end

function ActivityCruiseMainBtnItem:onRemoveEvent()
	Activity218Controller.instance:unregisterCallback(Activity218Event.OnMsgInfoChange, self.refreshDot, self)
	Activity218Controller.instance:unregisterCallback(Activity218Event.OnReceiveAcceptRewardReply, self.refreshDot, self)
	Activity216Controller.instance:unregisterCallback(Activity216Event.onInfoChanged, self.refreshDot, self)
	Activity216Controller.instance:unregisterCallback(Activity216Event.onTaskInfoUpdate, self.refreshDot, self)
	Activity216Controller.instance:unregisterCallback(Activity216Event.onBonusStateChange, self.refreshDot, self)
	Activity215Controller.instance:unregisterCallback(Activity215Event.onItemSubmitCountChange, self.refreshDot, self)
	Activity215Controller.instance:unregisterCallback(Activity215Event.OnInfoChanged, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
end

function ActivityCruiseMainBtnItem:onClick()
	CruiseController.instance:openCruiseMainView()
end

function ActivityCruiseMainBtnItem:refreshData()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseMain
	local data = {
		viewName = "CruiseMainView",
		viewParam = {
			actId = actId
		}
	}

	self:setCustomData(data)
end

function ActivityCruiseMainBtnItem:onOpen()
	self:refreshData()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function ActivityCruiseMainBtnItem:_checkRed()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CruiseMainBtn, 0) then
		return true
	end

	return false
end

function ActivityCruiseMainBtnItem:onRefresh()
	self:refreshData()

	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_7")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function ActivityCruiseMainBtnItem:onGetViewNameAndParam()
	local data = self:getCustomData()
	local viewParam = data.viewParam
	local viewName = data.viewName

	return viewName, viewParam
end

function ActivityCruiseMainBtnItem:onGetActId()
	local data = self:getCustomData()
	local viewParam = data.viewParam

	return viewParam.actId
end

function ActivityCruiseMainBtnItem:refreshDot()
	self:_refreshRedDot()
end

function ActivityCruiseMainBtnItem:_gm_ActIds()
	return {
		VersionActivity3_2Enum.ActivityId.CruiseMain
	}
end

return ActivityCruiseMainBtnItem
