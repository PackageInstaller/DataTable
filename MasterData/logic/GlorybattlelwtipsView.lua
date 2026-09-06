-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattlelwtipsView.lua

module("logic.extensions.glorybattle.view.GlorybattlelwtipsView", package.seeall)

local GlorybattlelwtipsView = class("GlorybattlelwtipsView", ViewComponent)

function GlorybattlelwtipsView:ctor()
	GlorybattlelwtipsView.super.ctor(self)
end

function GlorybattlelwtipsView:unbindEvents()
	GlorybattlelwtipsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GlorybattlelwtipsView:bindEvents()
	GlorybattlelwtipsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function GlorybattlelwtipsView:buildUI()
	GlorybattlelwtipsView.super.buildUI(self)

	self._txtDesctxt = self:getTxt("bg/cell/desctxt")
	self._txtName = self:getTxt("bg/cell/txtNname")
	self._iconGo = self:getGo("bg/cell/icon")
	self._btnClose = self:getBtn("btnClose")
end

function GlorybattlelwtipsView:onExit()
	GlorybattlelwtipsView.super.onExit(self)
	uGuiUtil.clearImage(self._iconGo)
end

function GlorybattlelwtipsView:onEnter()
	GlorybattlelwtipsView.super.onEnter(self)

	self._suitId = self:getFirstParam()
	self._suitCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(self._suitId)

	self:_updateUI()
end

function GlorybattlelwtipsView:_onClickbtnClose()
	self:close()
end

function GlorybattlelwtipsView:_updateUI()
	local url = string.format("%s.png", self._suitCfg.iconUrl)

	uGuiUtil.setSpriteToImage(self._iconGo, uGuiUtil.SpriteType.BigBg, url)

	self._txtName.text = self._suitCfg.suitName
	self._txtDesctxt.text = self._suitCfg.suitDesc
end

return GlorybattlelwtipsView
