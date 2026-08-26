-- chunkname: @modules/logic/sp02/operationactivity/view/game/AtomicOperationActivityGameCountDownView.lua

module("modules.logic.sp02.operationactivity.view.game.AtomicOperationActivityGameCountDownView", package.seeall)

local AtomicOperationActivityGameCountDownView = class("AtomicOperationActivityGameCountDownView", BaseView)

function AtomicOperationActivityGameCountDownView:onInitView()
	self._gocountdown = gohelper.findChild(self.viewGO, "#go_countdown")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "#go_countdown/#txt_num1")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "#go_countdown/#txt_num2")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "#go_countdown/#txt_num3")
	self._gostart = gohelper.findChild(self.viewGO, "#go_start")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityGameCountDownView:addEvents()
	return
end

function AtomicOperationActivityGameCountDownView:removeEvents()
	return
end

function AtomicOperationActivityGameCountDownView:_editableInitView()
	return
end

function AtomicOperationActivityGameCountDownView:onUpdateParam()
	return
end

function AtomicOperationActivityGameCountDownView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_bulaochuan_countdown_start)
end

function AtomicOperationActivityGameCountDownView:onClose()
	return
end

function AtomicOperationActivityGameCountDownView:onDestroyView()
	return
end

return AtomicOperationActivityGameCountDownView
