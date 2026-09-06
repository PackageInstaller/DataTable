-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/DreamspeedgiftView.lua

module("logic.extensions.activitypopup.view.DreamspeedgiftView", package.seeall)

local DreamspeedgiftView = class("DreamspeedgiftView", ViewComponent)

function DreamspeedgiftView:ctor()
	DreamspeedgiftView.super.ctor(self)
end

function DreamspeedgiftView:buildUI()
	DreamspeedgiftView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnGo1 = self:getGo("btnGo1")
	self.btnGo2 = self:getGo("btnGo2")
	self.btnGo3 = self:getGo("btnGo3")
end

function DreamspeedgiftView:bindEvents()
	DreamspeedgiftView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnGo1, GameUtil.handler(self.onClickGO, self, 1))
	GameUtil.addClickHandler(self.btnGo2, GameUtil.handler(self.onClickGO, self, 2))
	GameUtil.addClickHandler(self.btnGo3, GameUtil.handler(self.onClickGO, self, 3))
end

function DreamspeedgiftView:unbindEvents()
	DreamspeedgiftView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnGo1)
	GameUtil.rmClickHandler(self.btnGo2)
	GameUtil.rmClickHandler(self.btnGo3)
end

function DreamspeedgiftView:destroyUI()
	DreamspeedgiftView.super.destroyUI(self)
end

function DreamspeedgiftView:onEnter()
	DreamspeedgiftView.super.onEnter(self)
end

function DreamspeedgiftView:onEnterFinished()
	DreamspeedgiftView.super.onEnterFinished(self)
end

function DreamspeedgiftView:onExit()
	DreamspeedgiftView.super.onExit(self)
end

function DreamspeedgiftView:onExitFinished()
	DreamspeedgiftView.super.onExitFinished(self)
end

function DreamspeedgiftView:onClickGO(idx)
	local giftList = {
		"1004:1005:1",
		"1004:1006:1",
		"1004:1007:1"
	}
	local str = giftList[idx]

	MaterialMgr.openGetSourceByStr(str)
end

return DreamspeedgiftView
