-- chunkname: @modules/logic/store/view/decorate/DecorateSkinListView.lua

module("modules.logic.store.view.decorate.DecorateSkinListView", package.seeall)

local DecorateSkinListView = class("DecorateSkinListView", BaseView)

function DecorateSkinListView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateSkinListView:addEvents()
	self.addClickCb(self, self._btnclose, self._btncloseOnClick, self)
end

function DecorateSkinListView:removeEvents()
	self:removeClickCb(self._btnclose)
end

function DecorateSkinListView:_btncloseOnClick()
	self:closeThis()
end

function DecorateSkinListView:_editableInitView()
	return
end

function DecorateSkinListView:onUpdateParam()
	return
end

function DecorateSkinListView:onOpen()
	self.itemId = self.viewParam and self.viewParam.itemId

	self:refreshView()
end

function DecorateSkinListView:refreshView()
	DecorateSkinSelectListModel.instance:refreshList(self.itemId)
end

function DecorateSkinListView:onClose()
	return
end

function DecorateSkinListView:onDestroyView()
	return
end

return DecorateSkinListView
