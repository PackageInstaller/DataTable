-- chunkname: @modules/logic/social/view/ReportTypeItem.lua

module("modules.logic.social.view.ReportTypeItem", package.seeall)

local ReportTypeItem = class("ReportTypeItem", ListScrollCellExtend)

function ReportTypeItem:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
	self.gonormalicon = gohelper.findChild(self.viewGO, "go_normalicon")
	self.goselecticon = gohelper.findChild(self.viewGO, "go_selecticon")
	self.txtinform = gohelper.findChildText(self.viewGO, "txt_inform")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ReportTypeItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ReportTypeItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function ReportTypeItem:_btnclickOnClick()
	ReportTypeListModel.instance:setSelectReportItem(self)
end

function ReportTypeItem:_editableInitView()
	return
end

function ReportTypeItem:refreshSelect()
	local isSelect = ReportTypeListModel.instance:isSelect(self)

	gohelper.setActive(self.gonormalicon, not isSelect)
	gohelper.setActive(self.goselecticon, isSelect)
end

function ReportTypeItem:onUpdateMO(mo)
	self.reportMo = mo
	self.txtinform.text = self.reportMo.desc

	self:refreshSelect()
end

function ReportTypeItem:getMo()
	return self.reportMo
end

return ReportTypeItem
