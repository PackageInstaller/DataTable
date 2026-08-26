-- chunkname: @modules/logic/sodache/view/inside/SodacheToastView.lua

module("modules.logic.sodache.view.inside.SodacheToastView", package.seeall)

local SodacheToastView = class("SodacheToastView", BaseView)

function SodacheToastView:onInitView()
	self._anim = gohelper.findComponentAnim(self.viewGO)
	self._txtTips = gohelper.findChildTextMesh(self.viewGO, "#go_Tips/#txt_Tips")
end

function SodacheToastView:addEvents()
	SodacheController.instance:registerCallback(SodacheEvent.ShowToast, self._onShowToast, self)
end

function SodacheToastView:removeEvents()
	SodacheController.instance:unregisterCallback(SodacheEvent.ShowToast, self._onShowToast, self)
end

function SodacheToastView:onOpen()
	self._showList = SodacheModel.instance.toastList

	self:showNextToast()
end

function SodacheToastView:_onShowToast(msg)
	table.insert(self._showList, msg)
end

function SodacheToastView:showNextToast()
	local msg = table.remove(self._showList, 1)

	if msg then
		self._anim.enabled = true

		self._anim:Play("open", 0, 0)

		self._txtTips.text = msg

		TaskDispatcher.runDelay(self.showNextToast, self, 1.5)
	else
		self:closeThis()
	end
end

function SodacheToastView:onClose()
	TaskDispatcher.cancelTask(self.showNextToast, self)
end

return SodacheToastView
