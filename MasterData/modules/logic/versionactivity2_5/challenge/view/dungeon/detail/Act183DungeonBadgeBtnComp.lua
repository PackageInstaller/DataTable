-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonBadgeBtnComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBadgeBtnComp", package.seeall)

local Act183DungeonBadgeBtnComp = class("Act183DungeonBadgeBtnComp", Act183DungeonBaseComp)
local BadgeBtnPos_HasRestart_HasRerpress = {
	660,
	-416
}
local BadgeBtnPos_HasRestart_NotRepress = {
	445,
	-416
}
local BadgeBtnPos_HasStart = {
	445,
	-416
}

function Act183DungeonBadgeBtnComp:init(go)
	Act183DungeonBadgeBtnComp.super.init(self, go)

	self._btnbadge = gohelper.getClickWithDefaultAudio(self.go)
	self._imagebadgebtn = gohelper.onceAddComponent(self.go, gohelper.Type_Image)
	self._txtusebadgenum = gohelper.findChildText(self.go, "#txt_usebadgenum")
	self._readyUseBadgeNum = 0
end

function Act183DungeonBadgeBtnComp:addEventListeners()
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateSelectBadgeNum, self._onUpdateSelectBadgeNum, self)
	self._btnbadge:AddClickListener(self._btnbadgeOnClick, self)
end

function Act183DungeonBadgeBtnComp:removeEventListeners()
	self._btnbadge:RemoveClickListener()
end

function Act183DungeonBadgeBtnComp:_btnbadgeOnClick()
	local selectBadgeComp = self.mgr:getComp(Act183DungeonSelectBadgeComp)

	if selectBadgeComp then
		selectBadgeComp:_onUpdateBadgeDetailVisible(true, self._readyUseBadgeNum)
	end

	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateBadgeDetailVisible, true, self._readyUseBadgeNum)
end

function Act183DungeonBadgeBtnComp:updateInfo(episodeMo)
	Act183DungeonBadgeBtnComp.super.updateInfo(self, episodeMo)

	local actInfo = Act183Model.instance:getActInfo()

	self._totalBadgeNum = actInfo and actInfo:getBadgeNum() or 0
	self._useBadgeNum = self._episodeMo:getUseBadgeNum()
	self._readyUseBadgeNum = self._useBadgeNum or 0
end

function Act183DungeonBadgeBtnComp:checkIsVisible()
	return self._status ~= Act183Enum.EpisodeStatus.Locked and self._totalBadgeNum > 0 and self._groupType == Act183Enum.GroupType.NormalMain
end

function Act183DungeonBadgeBtnComp:show()
	Act183DungeonBadgeBtnComp.super.show(self)

	local badgeBtnPos = BadgeBtnPos_HasStart
	local isRepressBtnVisible = self.mgr:isCompVisible(Act183DungeonRepressBtnComp)
	local isRestartBtnVisible = self.mgr:isCompVisible(Act183DungeonRestartBtnComp)

	if isRestartBtnVisible then
		badgeBtnPos = isRepressBtnVisible and BadgeBtnPos_HasRestart_HasRerpress or BadgeBtnPos_HasRestart_NotRepress
	end

	recthelper.setAnchor(self.tran, badgeBtnPos[1], badgeBtnPos[2])
	self:_refreshBadgeNum()
end

function Act183DungeonBadgeBtnComp:_refreshBadgeNum()
	if self._readyUseBadgeNum then
		local isReadyUseBadge = self._readyUseBadgeNum > 0

		gohelper.setActive(self._txtusebadgenum.gameObject, isReadyUseBadge)

		self._txtusebadgenum.text = self._readyUseBadgeNum

		local btnBgName = isReadyUseBadge and "v2a5_challenge_dungeon_iconbtn2" or "v2a5_challenge_dungeon_iconbtn1"

		UISpriteSetMgr.instance:setChallengeSprite(self._imagebadgebtn, btnBgName)
	end
end

function Act183DungeonBadgeBtnComp:_onUpdateSelectBadgeNum(episodeId, readyUseBadgeNum)
	if self._episodeId ~= episodeId then
		return
	end

	self._readyUseBadgeNum = readyUseBadgeNum or 0

	self:refresh()
end

function Act183DungeonBadgeBtnComp:onDestroy()
	Act183DungeonBadgeBtnComp.super.onDestroy(self)
end

return Act183DungeonBadgeBtnComp
