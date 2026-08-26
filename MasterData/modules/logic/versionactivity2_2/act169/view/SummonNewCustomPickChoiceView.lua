-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickChoiceView.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceView", package.seeall)

local SummonNewCustomPickChoiceView = class("SummonNewCustomPickChoiceView", BaseView)

function SummonNewCustomPickChoiceView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagedecbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/#simage_decbg")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollrule = gohelper.findChildScrollRect(self.viewGO, "#scroll_rule")
	self._goexskill = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/role/#go_exskill/#image_exskill")
	self._goclick = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/select/#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonNewCustomPickChoiceView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self.addEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, self.handleCusomPickCompleted, self)
	self.addEventCb(self, SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

function SummonNewCustomPickChoiceView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self.removeEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, self.handleCusomPickCompleted, self)
	self.removeEventCb(self, SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

function SummonNewCustomPickChoiceView:_btnconfirmOnClick()
	SummonNewCustomPickChoiceController.instance:trySendChoice()
end

function SummonNewCustomPickChoiceView:_btncancelOnClick()
	self:closeThis()
end

function SummonNewCustomPickChoiceView:_editableInitView()
	return
end

function SummonNewCustomPickChoiceView:onOpen()
	self:refreshUI()
end

function SummonNewCustomPickChoiceView:refreshUI()
	local selectCount = SummonNewCustomPickChoiceListModel.instance:getSelectCount()
	local maxCount = SummonNewCustomPickChoiceListModel.instance:getMaxSelectCount()

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, selectCount ~= maxCount)
end

function SummonNewCustomPickChoiceView:onClose()
	SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
end

function SummonNewCustomPickChoiceView:handleCusomPickCompleted()
	self:closeThis()
end

function SummonNewCustomPickChoiceView:onDestroyView()
	return
end

return SummonNewCustomPickChoiceView
