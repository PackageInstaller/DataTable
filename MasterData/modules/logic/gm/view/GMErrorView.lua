-- chunkname: @modules/logic/gm/view/GMErrorView.lua

module("modules.logic.gm.view.GMErrorView", package.seeall)

local GMErrorView = class("GMErrorView", BaseView)

function GMErrorView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "panel/detail/btns/btnClose")
	self._btnClear = gohelper.findChildButtonWithAudio(self.viewGO, "panel/detail/btns/btnClear")
	self._btnDel = gohelper.findChildButtonWithAudio(self.viewGO, "panel/detail/btns/btnDel")
	self._btnSend = gohelper.findChildButtonWithAudio(self.viewGO, "panel/detail/btns/btnSend")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "panel/detail/btns/btnHide")
	self._btnCopy = gohelper.findChildButtonWithAudio(self.viewGO, "panel/detail/btns/btnCopy")
	self._btnBlock = gohelper.findChildButtonWithAudio(self.viewGO, "panel/detail/btns/btnBlock")
	self._txtContent = gohelper.findChildText(self.viewGO, "panel/detail/scroll/Viewport/content")
end

function GMErrorView:addEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnClear:AddClickListener(self._onClickClear, self)
	self._btnDel:AddClickListener(self._onClitkDel, self)
	self._btnSend:AddClickListener(self._onClickSend, self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnCopy:AddClickListener(self._onClickCopy, self)
	self._btnBlock:AddClickListener(self._onClickBlock, self)
	self.addEventCb(self, GMController.instance, GMEvent.GMLogView_Select, self._onSelectMO, self)
end

function GMErrorView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._btnDel:RemoveClickListener()
	self._btnSend:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnCopy:RemoveClickListener()
	self._btnBlock:RemoveClickListener()
	self.removeEventCb(self, GMController.instance, GMEvent.GMLogView_Select, self._onSelectMO, self)
end

function GMErrorView:onOpen()
	if GMLogModel.instance.errorModel:getCount() > 0 then
		GMLogModel.instance.errorModel:selectCell(1, true)
	end

	self:_updateBtns()
end

function GMErrorView:_onSelectMO(mo)
	if mo then
		self._selectMO = mo
		self._txtContent.text = string.format("%s %s", os.date("%H:%M:%S", mo.time), mo.msg)
	else
		self._txtContent.text = ""
	end

	self:_updateBtns()
end

function GMErrorView:_onClickClose()
	self:closeThis()
	GMLogController.instance:hideAlert()
end

function GMErrorView:_onClickClear()
	self._selectMO = nil
	self._txtContent.text = ""

	GMLogModel.instance.errorModel:clear()
	self:_updateBtns()
	self:_updateCount()
end

function GMErrorView:_onClitkDel()
	if self._selectMO then
		GMLogModel.instance.errorModel:remove(self._selectMO)

		self._selectMO = nil
		self._txtContent.text = ""
	end

	self:_updateBtns()
	self:_updateCount()
end

function GMErrorView:_onClickSend()
	if self._selectMO then
		if not self._selectMO.hasSend then
			self._selectMO.hasSend = true

			GMLogController.instance:sendRobotMsg(self._selectMO.msg, self._selectMO.stackTrace)
		else
			GameFacade.showToast(ToastEnum.IconId, "had send")
		end
	end

	self:_updateBtns()
end

function GMErrorView:_onClickHide()
	self:closeThis()
	GMLogController.instance:showAlert()
end

function GMErrorView:_onClickCopy()
	if self._selectMO then
		ZProj.GameHelper.SetSystemBuffer(self._selectMO.msg)
		GameFacade.showToast(ToastEnum.IconId, "copy success")
	end
end

function GMErrorView:_onClickBlock()
	GMLogController.instance:block()
	self:closeThis()
end

function GMErrorView:_updateBtns()
	gohelper.setActive(self._btnDel.gameObject, self._selectMO)
	gohelper.setActive(self._btnSend.gameObject, self._selectMO and not self._selectMO.hasSend and not SLFramework.FrameworkSettings.IsEditor)
	gohelper.setActive(self._btnCopy.gameObject, self._selectMO)
end

function GMErrorView:_updateCount()
	GMController.instance:dispatchEvent(GMEvent.GMLog_UpdateCount)
end

return GMErrorView
