-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_SaveInfoView.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_SaveInfoView", package.seeall)

local Rouge2_SaveInfoView = class("Rouge2_SaveInfoView", BaseView)

function Rouge2_SaveInfoView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._scrollrecordlist = gohelper.findChildScrollRect(self.viewGO, "#scroll_recordlist")
	self._goRecordContent = gohelper.findChild(self.viewGO, "#scroll_recordlist/Viewport/Content")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SaveInfoView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateBossBattleInfo, self._onUpdateBattleInfo, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSaveRecordDone, self._onSaveInfoDone, self)
end

function Rouge2_SaveInfoView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_SaveInfoView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_SaveInfoView:closeThis()
	self.viewContainer:_onBtnCloseCallback()
end

function Rouge2_SaveInfoView:_editableInitView()
	return
end

function Rouge2_SaveInfoView:onUpdateParam()
	return
end

function Rouge2_SaveInfoView:onOpen()
	Rouge2_SaveInfoListModel.instance:initList(self.viewParam and self.viewParam.viewType)
end

function Rouge2_SaveInfoView:refreshUI()
	Rouge2_SaveInfoListModel.instance:refreshList()
end

function Rouge2_SaveInfoView:_onUpdateBattleInfo()
	self:refreshUI()
end

function Rouge2_SaveInfoView:_onSaveInfoDone()
	Rouge2_SaveInfoListModel.instance:onSaveInfoDone()
end

function Rouge2_SaveInfoView:onClose()
	return
end

function Rouge2_SaveInfoView:onDestroyView()
	return
end

return Rouge2_SaveInfoView
