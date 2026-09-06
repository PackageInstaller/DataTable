-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeBuffView.lua

module("logic.extensions.luyngarde.view.LuyngardeBuffView", package.seeall)

local LuyngardeBuffView = class("LuyngardeBuffView", ViewComponent)

function LuyngardeBuffView:ctor()
	LuyngardeBuffView.super.ctor(self)
end

function LuyngardeBuffView:unbindEvents()
	LuyngardeBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LuyngardeBuffView:bindEvents()
	LuyngardeBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function LuyngardeBuffView:buildUI()
	LuyngardeBuffView.super.buildUI(self)

	self._txtDesc = self:getTxt("txtDesc")
	self._showPet = self:getGo("showPet")
	self._btnClose = self:getGo("btnClose")
end

function LuyngardeBuffView:onExit()
	LuyngardeBuffView.super.onExit(self)
	MaterialMgr.resetAll(self._showPet)
end

function LuyngardeBuffView:onEnter()
	LuyngardeBuffView.super.onEnter(self)

	local cfg = self:getFirstParam()

	self._txtDesc.text = cfg.buffDesc

	MaterialMgr.setCell(MatType.Pet, cfg.raceId, self._showPet)
end

return LuyngardeBuffView
