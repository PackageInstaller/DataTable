-- chunkname: @modules/logic/act236/view/Act236BtnItem.lua

module("modules.logic.act236.view.Act236BtnItem", package.seeall)

local Act236BtnItem = class("Act236BtnItem", ActCenterItemBase)

function Act236BtnItem:onOpen()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function Act236BtnItem:onInit()
	self:refresh()
end

function Act236BtnItem:onRefresh()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(true, "icon_6")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function Act236BtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
end

function Act236BtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
end

function Act236BtnItem:onClick()
	Act236Controller.instance:openMainView(ActivityEnum.Activity.V3a7_Act236)
end

function Act236BtnItem:_checkRed()
	if not ActivityHelper.isOpen(ActivityEnum.Activity.V3a7_Act236) then
		return false
	end

	local redDotId = RedDotEnum.DotNode.V3a7Act236

	self:_checkRedotShowType(redDotId)

	local redDotInfo = RedDotModel.instance:getRedDotInfo(redDotId)

	for _, dotInfo in pairs(redDotInfo.infos) do
		if dotInfo.value > 0 then
			return true
		end
	end

	return false
end

function Act236BtnItem:refreshDot()
	self:_refreshRedDot()
end

function Act236BtnItem:_gm_ActIds()
	return {
		ActivityEnum.Activity.V3a7_Act236
	}
end

return Act236BtnItem
