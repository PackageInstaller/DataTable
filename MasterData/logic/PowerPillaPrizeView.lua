-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaPrizeView.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaPrizeView", package.seeall)

local PowerPillaPrizeView = class("PowerPillaPrizeView", ViewComponent)

function PowerPillaPrizeView:ctor()
	PowerPillaPrizeView.super.ctor(self)
end

function PowerPillaPrizeView:unbindEvents()
	PowerPillaPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
end

function PowerPillaPrizeView:bindEvents()
	PowerPillaPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self.close, self)
end

function PowerPillaPrizeView:buildUI()
	PowerPillaPrizeView.super.buildUI(self)

	self._btnGet = self:getGo("btnGet")
	self._goItems = self:getGo("items")
	self._txt1 = self:getTxt("txt1")
end

function PowerPillaPrizeView:onExit()
	PowerPillaPrizeView.super.onExit(self)
	PowerPillaController.instance:showCI()
	MaterialMgr.resetAll(self._goItems)
end

function PowerPillaPrizeView:onEnter()
	PowerPillaPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local cfg = params[1]

	MaterialMgr.setCellListByCfg(cfg.prize, self._goItems)

	self._txt1.text = cfg.showTxt
end

return PowerPillaPrizeView
