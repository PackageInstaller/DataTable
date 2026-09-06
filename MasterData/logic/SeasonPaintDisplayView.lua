-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPaintDisplayView.lua

module("logic.extensions.season.view.SeasonPaintDisplayView", package.seeall)

local SeasonPaintDisplayView = class("SeasonPaintDisplayView", ViewComponent)

function SeasonPaintDisplayView:ctor()
	SeasonPaintDisplayView.super.ctor(self)
end

function SeasonPaintDisplayView:unbindEvents()
	SeasonPaintDisplayView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	uGuiUtil.clearImage(self._imgPaint)
end

function SeasonPaintDisplayView:bindEvents()
	SeasonPaintDisplayView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SeasonPaintDisplayView:buildUI()
	SeasonPaintDisplayView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._imgPaint = self:getGo("mask/paint")
end

function SeasonPaintDisplayView:onExit()
	SeasonPaintDisplayView.super.onExit(self)
end

function SeasonPaintDisplayView:onEnter()
	SeasonPaintDisplayView.super.onEnter(self)
	uGuiUtil.clearImage(self._imgPaint)

	local params = self._viewPresentor:getOpenParam()

	if params and params[1] then
		uGuiUtil.setSpriteToImage(self._imgPaint, uGuiUtil.SpriteType.BigBg, params[1])
	else
		printError("SeasonPaintDisplayView:未正确传入参数")
		self:close()
	end
end

function SeasonPaintDisplayView:_onClickClose()
	self:close()
end

return SeasonPaintDisplayView
