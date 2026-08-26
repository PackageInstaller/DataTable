-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogStartView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogStartView", package.seeall)

local AergusiDialogStartView = class("AergusiDialogStartView", BaseView)

function AergusiDialogStartView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagedec2 = gohelper.findChildSingleImage(self.viewGO, "#simage_dec2")
	self._simagedec1 = gohelper.findChildSingleImage(self.viewGO, "#simage_dec1")
	self._simagedec3 = gohelper.findChildSingleImage(self.viewGO, "#simage_dec3")
	self._txtdesc = gohelper.findChildText(self.viewGO, "txt_dec1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiDialogStartView:addEvents()
	return
end

function AergusiDialogStartView:removeEvents()
	return
end

function AergusiDialogStartView:_editableInitView()
	return
end

function AergusiDialogStartView:onUpdateParam()
	return
end

function AergusiDialogStartView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_ask)
	self:_refreshUI()
	TaskDispatcher.runDelay(self._onShowFinished, self, 2)
end

function AergusiDialogStartView:_refreshUI()
	local groupCo = AergusiConfig.instance:getEvidenceConfig(self.viewParam.groupId)

	self._txtdesc.text = groupCo.conditionStr
end

function AergusiDialogStartView:_onShowFinished()
	self:closeThis()
end

function AergusiDialogStartView:onClose()
	return
end

function AergusiDialogStartView:onDestroyView()
	if self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end

	TaskDispatcher.cancelTask(self._onShowFinished, self)
end

return AergusiDialogStartView
