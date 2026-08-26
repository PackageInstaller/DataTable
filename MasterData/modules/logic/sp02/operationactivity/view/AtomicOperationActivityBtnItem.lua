-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityBtnItem.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityBtnItem", package.seeall)

local AtomicOperationActivityBtnItem = class("AtomicOperationActivityBtnItem", ActCenterItemBase)

function AtomicOperationActivityBtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
end

function AtomicOperationActivityBtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
end

function AtomicOperationActivityBtnItem:onClick()
	local actId = self:onGetActId()
	local _, viewParam = self:onGetViewNameAndParam()

	AtomicOperationActivityController.instance:openMainView(actId, viewParam)
end

function AtomicOperationActivityBtnItem:refreshData()
	local actId = ActivityEnum.Activity.SP02_AtomicOperationActivityMain
	local data = {
		viewName = ViewName.AtomicOperationActivityEnterView,
		viewParam = {
			actId = actId,
			entranceList = AtomicOperationActivityEnum.EntranceIdList
		}
	}

	self:setCustomData(data)
end

function AtomicOperationActivityBtnItem:onOpen()
	self:refreshData()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function AtomicOperationActivityBtnItem:_checkRed()
	local actId = self:onGetActId()
	local reddotId = ActivityConfig.instance:getActivityRedDotId(actId)

	self:_checkRedotShowType(reddotId)

	local isDotShow = RedDotModel.instance:isDotShow(reddotId, 0)

	return isDotShow or self:_checkGameFirstEnter()
end

function AtomicOperationActivityBtnItem:_checkGameFirstEnter()
	return (TimeUtil.getDayFirstLoginRed(AtomicOperationActivityEnum.GameFirstEnterKey))
end

function AtomicOperationActivityBtnItem:onRefresh()
	self:refreshData()

	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_10")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function AtomicOperationActivityBtnItem:onGetViewNameAndParam()
	local data = self:getCustomData()
	local viewParam = data.viewParam
	local viewName = data.viewName

	return viewName, viewParam
end

function AtomicOperationActivityBtnItem:onGetActId()
	local data = self:getCustomData()
	local viewParam = data.viewParam

	return viewParam.actId
end

function AtomicOperationActivityBtnItem:refreshDot()
	self:_refreshRedDot()
end

function AtomicOperationActivityBtnItem:onDailyRefresh()
	self:refreshDot()
end

function AtomicOperationActivityBtnItem:_gm_ActIds()
	return {
		ActivityEnum.Activity.SP02_AtomicOperationActivityMain
	}
end

return AtomicOperationActivityBtnItem
