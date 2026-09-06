-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineSuccessView.lua

module("logic.extensions.divinejieshen.view.DivineSuccessView", package.seeall)

local DivineSuccessView = class("DivineSuccessView", ViewComponent)

function DivineSuccessView:ctor()
	DivineSuccessView.super.ctor(self)
end

function DivineSuccessView:buildUI()
	DivineSuccessView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
end

function DivineSuccessView:bindEvents()
	DivineSuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineSuccessView:unbindEvents()
	DivineSuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineSuccessView:onEnter()
	DivineSuccessView.super.onEnter(self)
end

function DivineSuccessView:onExit()
	DivineSuccessView.super.onExit(self)
end

return DivineSuccessView
