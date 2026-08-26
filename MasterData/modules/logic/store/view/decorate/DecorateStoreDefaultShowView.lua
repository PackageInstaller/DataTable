-- chunkname: @modules/logic/store/view/decorate/DecorateStoreDefaultShowView.lua

module("modules.logic.store.view.decorate.DecorateStoreDefaultShowView", package.seeall)

local DecorateStoreDefaultShowView = class("DecorateStoreDefaultShowView", BaseView)

function DecorateStoreDefaultShowView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._goview = gohelper.findChild(self.viewGO, "#go_view")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateStoreDefaultShowView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function DecorateStoreDefaultShowView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function DecorateStoreDefaultShowView:_btncloseOnClick()
	self:closeThis()
end

function DecorateStoreDefaultShowView:_editableInitView()
	return
end

function DecorateStoreDefaultShowView:onUpdateParam()
	return
end

function DecorateStoreDefaultShowView:onOpen()
	self.viewParam.bg.transform:SetParent(self._gobg.transform, false)
	self.viewParam.contentBg.transform:SetParent(self._goview.transform, false)
	self:_openPlayerCard()
end

function DecorateStoreDefaultShowView:onOpenFinish()
	if self.viewParam then
		if self.viewParam and self.viewParam > 0 then
			TaskDispatcher.runDelay(self.closeThis, self, self.viewParam)
		end
	end
end

function DecorateStoreDefaultShowView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)

	if self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj, self.viewParam)

		self.viewParam.callback = nil
	end
end

function DecorateStoreDefaultShowView:onDestroyView()
	if self._bgGo then
		gohelper.destroy(self._bgGo)

		self._bgGo = nil
	end

	if self._viewGo then
		gohelper.destroy(self._viewGo)

		self._viewGo = nil
	end
end

function DecorateStoreDefaultShowView:_openPlayerCard()
	if self.viewParam.viewCls then
		local goViewName = self.viewParam.viewCls.viewGO.name
		local goView = gohelper.findChild(self.viewParam.contentBg, "#go_typebg5/" .. goViewName)

		if goView then
			self.playerCardView = MonoHelper.addNoUpdateLuaComOnceToGo(goView, StorePlayerCardView)

			self.playerCardView:onShowDecorateStoreDefault()
		end
	end
end

return DecorateStoreDefaultShowView
