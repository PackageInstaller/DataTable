-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiurep/view/HeartofaojiurepmainView.lua

module("logic.extensions.heartofaojiurep.view.HeartofaojiurepmainView", package.seeall)

local HeartofaojiurepmainView = class("HeartofaojiurepmainView", HeartofjieshenmainView)

function HeartofaojiurepmainView:ctor()
	HeartofaojiurepmainView.super.ctor(self)
end

function HeartofaojiurepmainView:unbindEvents()
	HeartofaojiurepmainView.super.unbindEvents(self)
end

function HeartofaojiurepmainView:bindEvents()
	HeartofaojiurepmainView.super.bindEvents(self)
end

function HeartofaojiurepmainView:buildUI()
	HeartofaojiurepmainView.super.buildUI(self)
end

function HeartofaojiurepmainView:onExit()
	HeartofaojiurepmainView.super.onExit(self)
end

function HeartofaojiurepmainView:onEnter()
	HeartofaojiurepmainView.super.onEnter(self)
end

function HeartofaojiurepmainView:_showRoles()
	local raceId1 = self._actCfg.skinId
	local raceId2 = self._actCfg.skinId2

	self._roleObj1 = self:_showRole(raceId1, self._roleObj1, self._petCon1, self._petRare1, self._txtPetName1)
	self._roleObj2 = self:_showRole(raceId2, self._roleObj2, self._petCon2, self._petRare2, self._txtPetName2)
end

function HeartofaojiurepmainView:_onClickFight()
	if self:_isInChallengeTime() then
		UIStateManager.instance:push(ViewName.HeartofaojiurepclgView, self._activityId)
	else
		FloatWordMgr.instance:show("未在开放时间")
	end
end

function HeartofaojiurepmainView:_onClickRankChallenge()
	UIStateManager.instance:push(ViewName.HeartofaojiureprankView, self._activityId, HeartofjieshenModel.TAB_HISTORY)
end

function HeartofaojiurepmainView:_onClickRule()
	TipsFacade.instance:openRulesView("heartofaojiurepmainview_rule")
end

function HeartofaojiurepmainView:_onClickRank()
	local gotoStr = self._actCfg.jumpStr1

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function HeartofaojiurepmainView:_onClickShop()
	local gotoStr = self._actCfg.jumpStr2

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function HeartofaojiurepmainView:_onClickInfo1()
	local raceId = self._actCfg.skinId

	PetbookController.instance:openPetinfoView(raceId)
end

function HeartofaojiurepmainView:_onClickInfo2()
	local raceId = self._actCfg.skinId2

	PetbookController.instance:openPetinfoView(raceId)
end

function HeartofaojiurepmainView:_setOpenTime()
	if not self._actCfg.challengeClosedTimeRange then
		local arr = string.split(self._actCfg.challengeClosedTimeRange, "-") or {}
		local startStr = "0-0-0 " .. arr[2]
		local endStr = "0-0-0 " .. arr[1]
		local startDate = GameUtil.string2date(startStr)
		local endDate = GameUtil.string2date(endStr)

		self._txtOpenTime.text = langPara("挑战时间：%02d:%02d-%02d:%02d", startDate.hour, startDate.min, endDate.hour, endDate.min)
	end
end

return HeartofaojiurepmainView
