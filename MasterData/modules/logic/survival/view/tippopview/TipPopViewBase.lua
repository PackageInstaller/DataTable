-- chunkname: @modules/logic/survival/view/tippopview/TipPopViewBase.lua

module("modules.logic.survival.view.tippopview.TipPopViewBase", package.seeall)

local TipPopViewBase = class("TipPopViewBase", BaseView)

function TipPopViewBase:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self.container = gohelper.findChild(self.viewGO, "container")
end

function TipPopViewBase:addEvents()
	self.addClickCb(self, self.btnClose, self.closeThis, self)
end

function TipPopViewBase:onOpen()
	self.offsetX = self.viewParam.offsetX or 0
	self.offsetY = self.viewParam.offsetY or 0
	self._worldPos = self.viewParam._worldPos
	self.onCloseFunc = self.viewParam.onCloseFunc
	self.context = self.viewParam.context

	if self._worldPos then
		local anchorPos = recthelper.rectToRelativeAnchorPos(self._worldPos, self.viewGO.transform)
		local x = anchorPos.x + self.offsetX
		local y = anchorPos.y + self.offsetY

		recthelper.setAnchor(self.container.transform, x, y)
	end
end

function TipPopViewBase:onClose()
	if self.onCloseFunc then
		self.onCloseFunc(self.context)
	end
end

return TipPopViewBase
