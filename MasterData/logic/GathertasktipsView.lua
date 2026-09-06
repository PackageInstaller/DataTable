-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gathertask/view/GathertasktipsView.lua

module("logic.extensions.gathertask.view.GathertasktipsView", package.seeall)

local GathertasktipsView = class("GathertasktipsView", ViewComponent)

function GathertasktipsView:ctor()
	GathertasktipsView.super.ctor(self)
end

function GathertasktipsView:unbindEvents()
	GathertasktipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function GathertasktipsView:bindEvents()
	GathertasktipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function GathertasktipsView:buildUI()
	GathertasktipsView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
end

function GathertasktipsView:onExit()
	GathertasktipsView.super.onExit(self)
	GameUtil.callBack(self.callBack)
end

function GathertasktipsView:onEnter()
	GathertasktipsView.super.onEnter(self)

	self.callBack = self:getFirstParam()
end

return GathertasktipsView
