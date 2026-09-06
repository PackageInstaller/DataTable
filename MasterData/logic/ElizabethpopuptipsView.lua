-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/view/ElizabethpopuptipsView.lua

module("logic.extensions.elizabethgame.view.ElizabethElizabethpopuptipsView", package.seeall)

local ElizabethpopuptipsView = class("ElizabethpopuptipsView", ItemGetFlyView)

function ElizabethpopuptipsView:onExit()
	ElizabethpopuptipsView.super.onExit(self)
end

function ElizabethpopuptipsView:buildUI()
	self.itemtipflyClone = self:getGo("GameObject/itemtipfly")

	GameUtil.SetActive(self.itemtipflyClone, false)

	self._cloneCell = self:getGo("GameObject/itemtipfly")

	goutil.setActive(self._cloneCell, false)

	self._cells = {}
	self._maxCellCount = 3
	self._parentGo = self:getGo("GameObject")
end

function ElizabethpopuptipsView:onEnter()
	self.addGEvent(self, GlobalNotify.ElizabethBallClicked, self._onBallClicked, self)
end

function ElizabethpopuptipsView:_onBallClicked()
	local cell = self:_getFreeCell()

	self:_updateCell(cell, data)
	self:_startTweenPos()
end

function ElizabethpopuptipsView:_updateCell(go, obj)
	cell = goutil.findChild(go, "container")

	goutil.setActive(go, false)
	goutil.setActive(go, true)
end

return ElizabethpopuptipsView
