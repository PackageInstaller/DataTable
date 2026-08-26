-- chunkname: @modules/logic/versionactivity2_8/activity2nd/view/Activity2ndBtnItem.lua

module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndBtnItem", package.seeall)

local Activity2ndBtnItem = class("Activity2ndBtnItem", ActCenterItemBase)

function Activity2ndBtnItem:onOpen()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function Activity2ndBtnItem:onInit()
	self:refresh()
end

function Activity2ndBtnItem:onRefresh()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_7")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function Activity2ndBtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
end

function Activity2ndBtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
end

function Activity2ndBtnItem:onClick()
	Activity2ndController.instance:enterActivity2ndMainView()
end

function Activity2ndBtnItem:_checkRed()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity2ndEnter, 0) then
		return true
	end

	if Activity2ndModel.instance:checkAnnualReviewShowRed() then
		return true
	end

	return false
end

function Activity2ndBtnItem:refreshDot()
	self:_refreshRedDot()
end

function Activity2ndBtnItem:_gm_ActIds()
	local actIds = tabletool.copy(Activity2ndEnum.ActivityOrder)

	table.insert(actIds, Activity196Enum.ActId)
	table.insert(actIds, Activity2ndEnum.ActivityId.MailActivty)
	table.insert(actIds, Activity2ndEnum.ActivityId.V2a8_PVPopupReward)

	return actIds
end

return Activity2ndBtnItem
