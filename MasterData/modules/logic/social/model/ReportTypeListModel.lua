-- chunkname: @modules/logic/social/model/ReportTypeListModel.lua

module("modules.logic.social.model.ReportTypeListModel", package.seeall)

local ReportTypeListModel = class("ReportTypeListModel", ListScrollModel)

function ReportTypeListModel:onInit()
	self.reportTypeList = {}
end

function ReportTypeListModel:reInit()
	self.reportTypeList = {}
end

function ReportTypeListModel.sortFunc(a, b)
	return a.id < b.id
end

function ReportTypeListModel:initType(reportTypeList)
	local tmpReportType

	for _, reportType in ipairs(reportTypeList) do
		table.insert(self.reportTypeList, {
			id = reportType.id,
			desc = reportType.desc
		})
	end

	table.sort(reportTypeList, self.sortFunc)
end

function ReportTypeListModel:initDone()
	return self.reportTypeList and #self.reportTypeList > 0
end

function ReportTypeListModel:refreshData()
	self:setList(self.reportTypeList)
end

function ReportTypeListModel:setSelectReportItem(reportTypeItem)
	local preReportTypeItem = self.selectReportItem

	if self:isSelect(reportTypeItem) then
		self.selectReportItem = nil
	else
		self.selectReportItem = reportTypeItem
	end

	if preReportTypeItem then
		preReportTypeItem:refreshSelect()
	end

	reportTypeItem:refreshSelect()
end

function ReportTypeListModel:isSelect(reportTypeItem)
	return self.selectReportItem and self.selectReportItem:getMo().id == reportTypeItem:getMo().id
end

function ReportTypeListModel:getSelectReportId()
	return self.selectReportItem and self.selectReportItem:getMo().id
end

function ReportTypeListModel:clearSelectReportItem()
	self.selectReportItem = nil
end

ReportTypeListModel.instance = ReportTypeListModel.New()

return ReportTypeListModel
