-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/wishtreebottle/WishTreeBottleTaskFrameView.lua

module("logic.extensions.eventtasksummary.view.tab.wishtreebottle.WishTreeBottleTaskFrameView", package.seeall)

local WishTreeBottleTaskFrameView = class("WishTreeBottleTaskFrameView", EventTaskTabFrameView)

function WishTreeBottleTaskFrameView:ctor()
	WishTreeBottleTaskFrameView.super.ctor(self)
end

function WishTreeBottleTaskFrameView:unbindEvents()
	WishTreeBottleTaskFrameView.super.unbindEvents(self)
end

function WishTreeBottleTaskFrameView:bindEvents()
	WishTreeBottleTaskFrameView.super.bindEvents(self)
end

function WishTreeBottleTaskFrameView:buildUI()
	WishTreeBottleTaskFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
end

function WishTreeBottleTaskFrameView:onExit()
	WishTreeBottleTaskFrameView.super.onExit(self)
end

function WishTreeBottleTaskFrameView:onEnter()
	WishTreeBottleTaskFrameView.super.onEnter(self)
end

return WishTreeBottleTaskFrameView
