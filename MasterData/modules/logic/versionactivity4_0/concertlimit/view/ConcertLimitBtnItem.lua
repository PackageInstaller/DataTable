-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/ConcertLimitBtnItem.lua

module("modules.logic.versionactivity4_0.concertlimit.view.ConcertLimitBtnItem", package.seeall)

local ConcertLimitBtnItem = class("ConcertLimitBtnItem", ActCenterItemBase)

function ConcertLimitBtnItem:onOpen()
	self._addNotEventRedDot(self, self._checkRed, self)
end

function ConcertLimitBtnItem:onInit()
	self:refresh()
end

function ConcertLimitBtnItem:onRefresh()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_9")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function ConcertLimitBtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.refreshDot, self)
end

function ConcertLimitBtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.refreshDot, self)
end

function ConcertLimitBtnItem:onClick()
	ConcertLimitController.instance:openConcertLimitMainView()
end

function ConcertLimitBtnItem:_checkRed()
	local reddotId = RedDotEnum.DotNode.V4a0ConcertMain

	self:_checkRedotShowType(reddotId)

	if RedDotModel.instance:isDotShow(reddotId, 0) then
		return true
	end

	local showGameReddot = MusicGameModel.instance:showScoreTipReddot(VersionActivity4_0Enum.ActivityId.ConcertMusicGame)

	if showGameReddot then
		return true
	end

	return false
end

function ConcertLimitBtnItem:refreshDot()
	self:_refreshRedDot()
end

function ConcertLimitBtnItem:_gm_ActIds()
	local actIds = {}

	table.insert(actIds, VersionActivity4_0Enum.ActivityId.ConcertLimitMain)
	table.insert(actIds, VersionActivity4_0Enum.ActivityId.ConcertCandyRoom)
	table.insert(actIds, VersionActivity4_0Enum.ActivityId.ConcertFlipCardAct)
	table.insert(actIds, VersionActivity4_0Enum.ActivityId.ConcertSelfSelect)
	table.insert(actIds, VersionActivity4_0Enum.ActivityId.ConcertMusicGame)

	return actIds
end

return ConcertLimitBtnItem
