-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/balloongame/SunWuKongChallengeBalloonTipsView.lua

module("logic.extensions.sunwukongchallenge.view.balloongame.SunWuKongChallengeBalloonTipsView", package.seeall)

local SunWuKongChallengeBalloonTipsView = class("SunWuKongChallengeBalloonTipsView", ItemGetFlyView)

function SunWuKongChallengeBalloonTipsView:onExit()
	SunWuKongChallengeBalloonTipsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SunWuKongBalloonClick, self._onBallClicked, self)
end

function SunWuKongChallengeBalloonTipsView:buildUI()
	self.itemtipflyClone = self:getGo("GameObject/itemtipfly")

	GameUtil.SetActive(self.itemtipflyClone, false)

	self._cloneCell = self:getGo("GameObject/itemtipfly")

	goutil.setActive(self._cloneCell, false)

	self._cells = {}
	self._maxCellCount = 3
	self._parentGo = self:getGo("GameObject")
end

function SunWuKongChallengeBalloonTipsView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.SunWuKongBalloonClick, self._onBallClicked, self)
end

function SunWuKongChallengeBalloonTipsView:_onBallClicked()
	local cell = self:_getFreeCell()

	self:_updateCell(cell, nil)
	self:_startTweenPos()
end

function SunWuKongChallengeBalloonTipsView:_updateCell(go, obj)
	local cell = goutil.findChild(go, "container")

	goutil.setActive(go, false)
	goutil.setActive(go, true)
end

return SunWuKongChallengeBalloonTipsView
