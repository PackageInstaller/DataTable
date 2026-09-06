-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/GeneTipView.lua

module("logic.extensions.zoo.view.GeneTipView", package.seeall)

local GeneTipView = class("GeneTipView", ViewComponent)

function GeneTipView:buildUI()
	GeneTipView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._bg = self:getGo("bg")
	self._nameTxt = goutil.findChildTextComponent(self._bg, "title/name")
	self._descTxt = goutil.findChildTextComponent(self._bg, "describe/Viewport/Content")
end

function GeneTipView:bindEvents()
	GeneTipView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function GeneTipView:unbindEvents()
	GeneTipView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function GeneTipView:onEnter()
	GeneTipView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._nameTxt.text = openParam[1].name
	self._descTxt.text = openParam[1].desc
end

return GeneTipView
