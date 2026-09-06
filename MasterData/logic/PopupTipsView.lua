-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/elizabeth/PopupTipsView.lua

module("logic.extensions.timelimitedchallenge.view.elizabeth.PopupTipsView", package.seeall)

local PopupTipsView = class("PopupTipsView", ItemGetFlyView)

function PopupTipsView:onExit()
	PopupTipsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EliBallClicked, self._onBallClicked, self)
end

function PopupTipsView:buildUI()
	self.itemtipflyClone = self:getGo("GameObject/itemtipfly")

	GameUtil.SetActive(self.itemtipflyClone, false)

	self._cloneCell = self:getGo("GameObject/itemtipfly")

	goutil.setActive(self._cloneCell, false)

	self._cells = {}
	self._maxCellCount = 3
	self._parentGo = self:getGo("GameObject")
end

function PopupTipsView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.EliBallClicked, self._onBallClicked, self)
end

function PopupTipsView:_onBallClicked()
	local cell = self:_getFreeCell()

	self:_updateCell(cell, data)
	self:_startTweenPos()
end

function PopupTipsView:_updateCell(go, obj)
	cell = goutil.findChild(go, "container")

	goutil.setActive(go, false)
	goutil.setActive(go, true)
end

return PopupTipsView
