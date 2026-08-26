-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3BtnItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3BtnItem", package.seeall)

local Anniversary3BtnItem = class("Anniversary3BtnItem", ActCenterItemBase)

function Anniversary3BtnItem:onOpen()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function Anniversary3BtnItem:onInit()
	self:refresh()
end

function Anniversary3BtnItem:onRefresh()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_9")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function Anniversary3BtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
end

function Anniversary3BtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
end

function Anniversary3BtnItem:onClick()
	Anniversary3Controller.instance:openAnniversary3MainView()
end

function Anniversary3BtnItem:_checkRed()
	local reddotId = RedDotEnum.DotNode.V3a7Anniversary3Main

	self:_checkRedotShowType(reddotId)

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a7Anniversary3Main, 0) then
		return true
	end

	local reportRead = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Anniversary3ReportReaded), "")
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_7Enum.ActivityId.Anniversary3Report]
	local isExpire = actInfoMo:isExpired()
	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isExpire and isUnlock and LuaUtil.isEmptyStr(reportRead) then
		return true
	end

	local hasMultiRewardCouldGet = GuessGameModel.instance:hasMultiRewardCouldGet(VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame)

	if hasMultiRewardCouldGet then
		return true
	end

	return false
end

function Anniversary3BtnItem:refreshDot()
	self:_refreshRedDot()
end

function Anniversary3BtnItem:_gm_ActIds()
	return {
		VersionActivity3_7Enum.ActivityId.Anniversary3Report
	}
end

return Anniversary3BtnItem
