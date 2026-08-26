-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultReportView.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultReportView", package.seeall)

local Rouge2_ResultReportView = class("Rouge2_ResultReportView", BaseView)

function Rouge2_ResultReportView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._scrollrecordlist = gohelper.findChildScrollRect(self.viewGO, "#scroll_recordlist")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultReportView:addEvents()
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo, self.refreshUI, self)
end

function Rouge2_ResultReportView:removeEvents()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo, self.refreshUI, self)
end

function Rouge2_ResultReportView:_btncloseOnClick()
	return
end

function Rouge2_ResultReportView:_editableInitView()
	Rouge2_ResultReportListModel.instance.startFrameCount = UnityEngine.Time.frameCount
end

function Rouge2_ResultReportView:onUpdateParam()
	return
end

function Rouge2_ResultReportView:onOpen()
	local info = Rouge2_OutsideModel.instance:getReviewInfoList()
	local haveReviewInfo = info and #info > 0

	gohelper.setActive(self._goempty, not haveReviewInfo)
	gohelper.setActive(self._scrollrecordlist, haveReviewInfo)
	self:refreshUI()
end

function Rouge2_ResultReportView:refreshUI()
	Rouge2_ResultReportListModel.instance:initList()
end

function Rouge2_ResultReportView:onClose()
	return
end

function Rouge2_ResultReportView:onDestroyView()
	return
end

return Rouge2_ResultReportView
