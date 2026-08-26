-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_SwitchView.lua

module("modules.logic.rouge2.outside.view.Rouge2_SwitchView", package.seeall)

local Rouge2_SwitchView = class("Rouge2_SwitchView", BaseView)

function Rouge2_SwitchView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SwitchView:addEvents()
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SceneSwitchFinish, self.onSwitchFinish, self)
end

function Rouge2_SwitchView:removeEvents()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SceneSwitchFinish, self.onSwitchFinish, self)
end

function Rouge2_SwitchView:_editableInitView()
	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_SwitchView:onUpdateParam()
	return
end

function Rouge2_SwitchView:onSwitchFinish()
	self.animator:Play("end", 0, 0)
	TaskDispatcher.runDelay(self.closeThis, self, Rouge2_OutsideEnum.SwitchViewOpenTime)
end

function Rouge2_SwitchView:onOpen()
	return
end

function Rouge2_SwitchView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function Rouge2_SwitchView:onDestroyView()
	return
end

return Rouge2_SwitchView
