-- chunkname: @modules/logic/sp01/act204/view/Activity204MainBtnItem.lua

module("modules.logic.sp01.act204.view.Activity204MainBtnItem", package.seeall)

local Activity204MainBtnItem = class("Activity204MainBtnItem", ActCenterItemBase)

function Activity204MainBtnItem:onAddEvent()
	gohelper.addUIClickAudio(self._btnitem)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	Activity204Controller.instance:registerCallback(Activity204Event.UpdateTask, self.refreshDot, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
end

function Activity204MainBtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	Activity204Controller.instance:unregisterCallback(Activity204Event.UpdateTask, self.refreshDot, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
end

function Activity204MainBtnItem:onClick()
	local actId = self:onGetActId()
	local _, viewParam = self:onGetViewNameAndParam()

	Activity204Controller.instance:jumpToActivity(actId, viewParam)
end

function Activity204MainBtnItem:refreshData()
	local actId = ActivityEnum.Activity.V2a9_ActCollection
	local data = {
		viewName = ViewName.Act130517View,
		viewParam = {
			actId = actId,
			entranceIds = Activity204Enum.EntranceIdList
		}
	}

	self:setCustomData(data)
end

function Activity204MainBtnItem:onOpen()
	self:refreshData()
	self:_initOceanRedDot()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function Activity204MainBtnItem:_checkRed()
	local actId = self:onGetActId()
	local reddotId = ActivityConfig.instance:getActivityRedDotId(actId)
	local isDotShow = RedDotModel.instance:isDotShow(reddotId, 0)

	return isDotShow or Activity204Model.instance:hasNewTask()
end

function Activity204MainBtnItem:onRefresh()
	self:refreshData()

	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_6")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function Activity204MainBtnItem:onGetViewNameAndParam()
	local data = self:getCustomData()
	local viewParam = data.viewParam
	local viewName = data.viewName

	return viewName, viewParam
end

function Activity204MainBtnItem:onGetActId()
	local data = self:getCustomData()
	local viewParam = data.viewParam

	return viewParam.actId
end

function Activity204MainBtnItem:refreshDot()
	self:_refreshRedDot()
end

function Activity204MainBtnItem:_initOceanRedDot()
	Activity204Controller.instance:checkOceanNewOpenRedDot()
end

function Activity204MainBtnItem:onDailyRefresh()
	self:_initOceanRedDot()
	self:refreshDot()
end

function Activity204MainBtnItem:_gm_ActIds()
	return {
		ActivityEnum.Activity.V2a9_ActCollection
	}
end

return Activity204MainBtnItem
