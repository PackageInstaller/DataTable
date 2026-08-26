-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183ReportView.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183ReportView", package.seeall)

local Act183ReportView = class("Act183ReportView", BaseView)

function Act183ReportView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._scrollreview = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_review")
	self._goempty = gohelper.findChild(self.viewGO, "root/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183ReportView:addEvents()
	return
end

function Act183ReportView:removeEvents()
	return
end

function Act183ReportView:_editableInitView()
	return
end

function Act183ReportView:onUpdateParam()
	return
end

function Act183ReportView:onOpen()
	local count = Act183ReportListModel.instance:getCount()

	gohelper.setActive(self._goempty, count <= 0)
end

function Act183ReportView:onClose()
	return
end

function Act183ReportView:onDestroyView()
	return
end

return Act183ReportView
