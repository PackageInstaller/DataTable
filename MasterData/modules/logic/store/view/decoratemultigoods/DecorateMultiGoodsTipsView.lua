-- chunkname: @modules/logic/store/view/decoratemultigoods/DecorateMultiGoodsTipsView.lua

module("modules.logic.store.view.decoratemultigoods.DecorateMultiGoodsTipsView", package.seeall)

local DecorateMultiGoodsTipsView = class("DecorateMultiGoodsTipsView", BaseView)

function DecorateMultiGoodsTipsView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateMultiGoodsTipsView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function DecorateMultiGoodsTipsView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function DecorateMultiGoodsTipsView:_btnCloseOnClick()
	self:closeThis()
end

function DecorateMultiGoodsTipsView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

return DecorateMultiGoodsTipsView
