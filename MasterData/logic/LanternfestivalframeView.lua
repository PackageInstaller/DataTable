-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/lanternfestival/LanternfestivalframeView.lua

module("logic.extensions.eventtasksummary.view.tab.lanternfestival.LanternfestivalframeView", package.seeall)

local LanternfestivalframeView = class("LanternfestivalframeView", EventTaskTabFrameView)

function LanternfestivalframeView:ctor()
	LanternfestivalframeView.super.ctor(self)
end

function LanternfestivalframeView:unbindEvents()
	LanternfestivalframeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJumpTo)
end

function LanternfestivalframeView:bindEvents()
	LanternfestivalframeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJumpTo, self._onClickJumpTo, self)
end

function LanternfestivalframeView:buildUI()
	LanternfestivalframeView.super.buildUI(self)

	self._btnJumpTo = self:getGo("btnJump")
	self._txtTime = self:getTxt("time/txt")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
end

function LanternfestivalframeView:onExit()
	LanternfestivalframeView.super.onExit(self)
end

function LanternfestivalframeView:onEnter()
	LanternfestivalframeView.super.onEnter(self)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function LanternfestivalframeView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local UIChangeGroup = mainGo:GetComponent(typeof(UIChangeGroup))

	txtName.text = data.pageName

	self:_setIsCellRed(cell, data)
	UIChangeGroup:SetState(self._curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))

	local bg = goutil.findChild(mainGo, "bg")

	goutil.setActive(bg, self._curTabIdx == tabIdx)
end

function LanternfestivalframeView:_onClickJumpTo()
	GotoMgr.gotoByString("func#191#17#17146")
end

return LanternfestivalframeView
