-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogEndView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogEndView", package.seeall)

local AergusiDialogEndView = class("AergusiDialogEndView", BaseView)

function AergusiDialogEndView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagedec2 = gohelper.findChildSingleImage(self.viewGO, "#simage_dec2")
	self._simagedec3 = gohelper.findChildSingleImage(self.viewGO, "#simage_dec3")
	self._simagedec1 = gohelper.findChildSingleImage(self.viewGO, "#simage_dec1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiDialogEndView:addEvents()
	return
end

function AergusiDialogEndView:removeEvents()
	return
end

function AergusiDialogEndView:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function AergusiDialogEndView:onUpdateParam()
	return
end

function AergusiDialogEndView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_finish)
	self:_refreshUI()
	TaskDispatcher.runDelay(self._onShowFinished, self, 2)
end

function AergusiDialogEndView:_refreshUI()
	return
end

function AergusiDialogEndView:_onShowFinished()
	self._viewAnim:Play("close", 0, 0)
	TaskDispatcher.runDelay(self._realClose, self, 0.5)
end

function AergusiDialogEndView:_realClose()
	if self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end

	self:closeThis()
end

function AergusiDialogEndView:onClose()
	return
end

function AergusiDialogEndView:onDestroyView()
	TaskDispatcher.cancelTask(self._onShowFinished, self)
	TaskDispatcher.cancelTask(self._realClose, self)
end

return AergusiDialogEndView
