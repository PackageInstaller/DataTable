-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonSelectBadgeComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonSelectBadgeComp", package.seeall)

local Act183DungeonSelectBadgeComp = class("Act183DungeonSelectBadgeComp", Act183DungeonBaseComp)
local BadgeDetailPos_HasRestart_HasRerpress = {
	610,
	-416
}
local BadgeDetailPos_HasRestart_NotRepress = {
	395,
	-416
}
local BadgeDetailPos_HasStart = {
	394.33,
	-416
}

function Act183DungeonSelectBadgeComp:init(go)
	Act183DungeonSelectBadgeComp.super.init(self, go)

	self._gobadgeitem = gohelper.findChild(self.go, "#go_badges/#go_badgeitem")
	self._btnresetbadge = gohelper.findChildButtonWithAudio(self.go, "#go_badges/#btn_resetbadge")
	self._btnclosebadge = gohelper.findChildButtonWithAudio(self.go, "#btn_closebadge")
	self._badgeItemTab = self:getUserDataTb_()
end

function Act183DungeonSelectBadgeComp:addEventListeners()
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateBadgeDetailVisible, self._onUpdateBadgeDetailVisible, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateSelectBadgeNum, self._onUpdateSelectBadgeNum, self)
	self._btnresetbadge:AddClickListener(self._btnresetbadgeOnClick, self)
	self._btnclosebadge:AddClickListener(self._btnclosebadgeOnClick, self)
end

function Act183DungeonSelectBadgeComp:removeEventListeners()
	self._btnresetbadge:RemoveClickListener()
	self._btnclosebadge:RemoveClickListener()
end

function Act183DungeonSelectBadgeComp:updateInfo(episodeMo)
	Act183DungeonSelectBadgeComp.super.updateInfo(self, episodeMo)

	self._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(self._episodeId)
	self._useBadgeNum = self._episodeMo:getUseBadgeNum()
	self._readyUseBadgeNum = self._useBadgeNum or 0

	local actInfo = Act183Model.instance:getActInfo()

	self._totalBadgeNum = actInfo and actInfo:getBadgeNum() or 0
	self._isVisibe = false
end

function Act183DungeonSelectBadgeComp:checkIsVisible()
	return self._isVisibe
end

function Act183DungeonSelectBadgeComp:show()
	Act183DungeonSelectBadgeComp.super.show(self)
	self:createObjListNum(self._totalBadgeNum, self._badgeItemTab, self._gobadgeitem, self._initBadgeItemFunc, self._refreshBadgeItemFunc, self._defaultItemFreeFunc)
	self:_setPosition()
end

function Act183DungeonSelectBadgeComp:_setPosition()
	local badgeDetailPos = BadgeDetailPos_HasStart
	local isRepressBtnVisible = self.mgr:isCompVisible(Act183DungeonRepressBtnComp)
	local isRestartBtnVisible = self.mgr:isCompVisible(Act183DungeonRestartBtnComp)

	if isRestartBtnVisible then
		badgeDetailPos = isRepressBtnVisible and BadgeDetailPos_HasRestart_HasRerpress or BadgeDetailPos_HasRestart_NotRepress
	end

	recthelper.setAnchor(self.tran, badgeDetailPos[1], badgeDetailPos[2])
end

function Act183DungeonSelectBadgeComp:_initBadgeItemFunc(goItem, index)
	goItem.imageicon = gohelper.findChildImage(goItem.go, "image_icon")
	goItem.btnclick = gohelper.findChildButtonWithAudio(goItem.go, "btn_click")

	goItem.btnclick:AddClickListener(self._onClickBadgeItem, self, index)
end

function Act183DungeonSelectBadgeComp:_refreshBadgeItemFunc(goItem, badgeCo, index)
	local isUse = index <= self._readyUseBadgeNum
	local iconName = isUse and "v2a5_challenge_badge1" or "v2a5_challenge_badge2"

	UISpriteSetMgr.instance:setChallengeSprite(goItem.imageicon, iconName)
end

function Act183DungeonSelectBadgeComp:_releaseBadgeItems()
	for _, badgeItem in pairs(self._badgeItemTab) do
		badgeItem.btnclick:RemoveClickListener()
	end
end

function Act183DungeonSelectBadgeComp:_onClickBadgeItem(index)
	if self._readyUseBadgeNum == index then
		return
	end

	self._readyUseBadgeNum = index

	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateSelectBadgeNum, self._episodeId, self._readyUseBadgeNum)
end

function Act183DungeonSelectBadgeComp:_btnresetbadgeOnClick()
	if self._readyUseBadgeNum == 0 then
		return
	end

	self._readyUseBadgeNum = 0

	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateSelectBadgeNum, self._episodeId, self._readyUseBadgeNum)
end

function Act183DungeonSelectBadgeComp:_btnclosebadgeOnClick()
	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateBadgeDetailVisible, false, self._readyUseBadgeNum)
end

function Act183DungeonSelectBadgeComp:_onUpdateSelectBadgeNum(episodeId, badgeNum)
	if self._episodeId ~= episodeId or not self._isVisibe then
		return
	end

	self._readyUseBadgeNum = badgeNum

	self:refresh()
end

function Act183DungeonSelectBadgeComp:getReadyUseBadgeNum()
	return self._readyUseBadgeNum or 0
end

function Act183DungeonSelectBadgeComp:_onUpdateBadgeDetailVisible(isVisible, readyUseBadgeNum)
	self._isVisibe = isVisible
	self._readyUseBadgeNum = readyUseBadgeNum or 0

	self:refresh()
end

function Act183DungeonSelectBadgeComp:onDestroy()
	self:_releaseBadgeItems()
	Act183DungeonSelectBadgeComp.super.onDestroy(self)
end

return Act183DungeonSelectBadgeComp
