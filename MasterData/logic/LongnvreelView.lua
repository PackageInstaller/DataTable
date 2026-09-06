-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnvreelView.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnvreelView", package.seeall)

local LongnvreelView = class("LongnvreelView", ViewComponent)

function LongnvreelView:ctor()
	LongnvreelView.super.ctor(self)
end

function LongnvreelView:buildUI()
	LongnvreelView.super.buildUI(self)

	self.btnChallenge = self:getGo("btnChallenge")
end

function LongnvreelView:bindEvents()
	LongnvreelView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnChallenge, self.onClickChallenge, self)
end

function LongnvreelView:unbindEvents()
	LongnvreelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnChallenge)
end

function LongnvreelView:destroyUI()
	LongnvreelView.super.destroyUI(self)
end

function LongnvreelView:onEnter()
	LongnvreelView.super.onEnter(self)
end

function LongnvreelView:onEnterFinished()
	LongnvreelView.super.onEnterFinished(self)
end

function LongnvreelView:onExit()
	LongnvreelView.super.onExit(self)
end

function LongnvreelView:onExitFinished()
	LongnvreelView.super.onExitFinished(self)
end

function LongnvreelView:onClickChallenge()
	UIStateManager.instance:push(ViewName.BinglingwangmainView)
	self:close()
end

return LongnvreelView
