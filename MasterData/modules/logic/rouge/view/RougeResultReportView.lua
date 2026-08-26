-- chunkname: @modules/logic/rouge/view/RougeResultReportView.lua

module("modules.logic.rouge.view.RougeResultReportView", package.seeall)

local RougeResultReportView = class("RougeResultReportView", BaseView)

function RougeResultReportView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._scrollrecordlist = gohelper.findChildScrollRect(self.viewGO, "#scroll_recordlist")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeResultReportView:addEvents()
	return
end

function RougeResultReportView:removeEvents()
	return
end

function RougeResultReportView:_btndetailsOnClick()
	return
end

function RougeResultReportView:_editableInitView()
	RougeResultReportListModel.instance.startFrameCount = UnityEngine.Time.frameCount

	RougeResultReportListModel.instance:init()

	local list = RougeResultReportListModel.instance:getList()

	gohelper.setActive(self._goempty, #list == 0)
end

function RougeResultReportView:onUpdateParam()
	return
end

function RougeResultReportView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio9)
end

function RougeResultReportView:onClose()
	return
end

function RougeResultReportView:onDestroyView()
	RougeResultReportListModel.instance:clear()
end

return RougeResultReportView
