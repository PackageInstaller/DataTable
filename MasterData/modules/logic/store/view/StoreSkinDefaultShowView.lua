-- chunkname: @modules/logic/store/view/StoreSkinDefaultShowView.lua

module("modules.logic.store.view.StoreSkinDefaultShowView", package.seeall)

local StoreSkinDefaultShowView = class("StoreSkinDefaultShowView", BaseView)

function StoreSkinDefaultShowView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._goview = gohelper.findChild(self.viewGO, "#go_view")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinDefaultShowView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function StoreSkinDefaultShowView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function StoreSkinDefaultShowView:_btncloseOnClick()
	self:closeThis()
end

function StoreSkinDefaultShowView:_editableInitView()
	return
end

function StoreSkinDefaultShowView:onUpdateParam()
	return
end

function StoreSkinDefaultShowView:onOpen()
	self.viewParam.contentBg.transform:SetParent(self._goview.transform, false)
end

function StoreSkinDefaultShowView:onOpenFinish()
	if self.viewParam then
		if self.viewParam and self.viewParam > 0 then
			TaskDispatcher.runDelay(self.closeThis, self, self.viewParam)
		end
	end
end

function StoreSkinDefaultShowView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)

	if self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj, self.viewParam)

		self.viewParam.callback = nil
	end
end

function StoreSkinDefaultShowView:onDestroyView()
	if self._bgGo then
		gohelper.destroy(self._bgGo)

		self._bgGo = nil
	end

	if self._viewGo then
		gohelper.destroy(self._viewGo)

		self._viewGo = nil
	end
end

return StoreSkinDefaultShowView
