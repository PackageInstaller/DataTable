-- chunkname: @modules/logic/rouge/dlc/101/view/RougeDangerousView.lua

module("modules.logic.rouge.dlc.101.view.RougeDangerousView", package.seeall)

local RougeDangerousView = class("RougeDangerousView", BaseView)

RougeDangerousView.OpenViewDuration = 2.5

function RougeDangerousView:onInitView()
	self._simagedecbg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_decbg1")
	self._simagedecbg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_decbg2")
	self._simagedecbg3 = gohelper.findChildSingleImage(self.viewGO, "#simage_decbg3")
	self._simagedecbg4 = gohelper.findChildSingleImage(self.viewGO, "#simage_decbg4")
	self._simagedecbg5 = gohelper.findChildSingleImage(self.viewGO, "#simage_decbg5")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeDangerousView:addEvents()
	return
end

function RougeDangerousView:removeEvents()
	return
end

function RougeDangerousView:_editableInitView()
	return
end

function RougeDangerousView:onUpdateParam()
	return
end

function RougeDangerousView:onOpen()
	self:_delay2CloseView()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRougeDangerousView)
end

function RougeDangerousView:_delay2CloseView()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.runDelay(self.closeThis, self, RougeDangerousView.OpenViewDuration)
end

function RougeDangerousView:onClose()
	return
end

function RougeDangerousView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return RougeDangerousView
