-- chunkname: @modules/logic/college/view/common/CollegeToastView.lua

module("modules.logic.college.view.common.CollegeToastView", package.seeall)

local CollegeToastView = class("CollegeToastView", BaseView)

function CollegeToastView:onInitView()
	self._txtTips = gohelper.findChildTextMesh(self.viewGO, "#go_tip/#txt_Tips")
	self._anim = gohelper.findComponentAnim(self.viewGO)
end

function CollegeToastView:addEvents()
	CollegeController.instance:registerCallback(CollegeEvent.ShowToast, self._onShowToast, self)
end

function CollegeToastView:removeEvents()
	CollegeController.instance:unregisterCallback(CollegeEvent.ShowToast, self._onShowToast, self)
end

function CollegeToastView:onOpen()
	self._showList = CollegeModel.instance.toastList

	self:showNextToast()
end

function CollegeToastView:_onShowToast(msg)
	table.insert(self._showList, msg)
end

function CollegeToastView:showNextToast()
	local msg = table.remove(self._showList, 1)

	if msg then
		self._anim:Play(0, 0, 0)

		self._txtTips.text = msg

		TaskDispatcher.runDelay(self.showNextToast, self, 1.667)
	else
		self:closeThis()
	end
end

function CollegeToastView:onClose()
	TaskDispatcher.cancelTask(self.showNextToast, self)
end

return CollegeToastView
