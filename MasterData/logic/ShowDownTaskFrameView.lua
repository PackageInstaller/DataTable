-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/showdown/ShowDownTaskFrameView.lua

module("logic.extensions.eventtasksummary.view.tab.dragonpsychicclg.ShowDownTaskFrameView", package.seeall)

local ShowDownTaskFrameView = class("ShowDownTaskFrameView", EventTaskTabFrameView)

function ShowDownTaskFrameView:ctor()
	return
end

function ShowDownTaskFrameView:buildUI()
	ShowDownTaskFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
end

function ShowDownTaskFrameView:bindEvents()
	ShowDownTaskFrameView.super.bindEvents(self)
end

function ShowDownTaskFrameView:unbindEvents()
	ShowDownTaskFrameView.super.unbindEvents(self)
end

function ShowDownTaskFrameView:onEnter()
	ShowDownTaskFrameView.super.onEnter(self)
end

function ShowDownTaskFrameView:onExit()
	ShowDownTaskFrameView.super.onExit(self)
end

return ShowDownTaskFrameView
