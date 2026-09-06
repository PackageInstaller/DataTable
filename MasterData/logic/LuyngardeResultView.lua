-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeResultView.lua

module("logic.extensions.luyngarde.view.LuyngardeResultView", package.seeall)

local LuyngardeResultView = class("LuyngardeResultView", ViewComponent)

function LuyngardeResultView:ctor()
	LuyngardeResultView.super.ctor(self)
end

function LuyngardeResultView:unbindEvents()
	LuyngardeResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LuyngardeResultView:bindEvents()
	LuyngardeResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function LuyngardeResultView:buildUI()
	LuyngardeResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txt = self:getTxt("txt")
end

function LuyngardeResultView:onExit()
	LuyngardeResultView.super.onExit(self)
end

function LuyngardeResultView:onEnter()
	LuyngardeResultView.super.onEnter(self)

	local info = self:getFirstParam()

	self._txt.text = info.damage
end

function LuyngardeResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

return LuyngardeResultView
