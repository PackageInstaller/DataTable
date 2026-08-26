-- chunkname: @modules/logic/room/view/RoomInformReportTypeItem.lua

module("modules.logic.room.view.RoomInformReportTypeItem", package.seeall)

local RoomInformReportTypeItem = class("RoomInformReportTypeItem", ListScrollCellExtend)

function RoomInformReportTypeItem:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
	self.gonormalicon = gohelper.findChild(self.viewGO, "go_normalicon")
	self.goselecticon = gohelper.findChild(self.viewGO, "go_selecticon")
	self.txtinform = gohelper.findChildText(self.viewGO, "txt_inform")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInformReportTypeItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RoomInformReportTypeItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomInformReportTypeItem:_btnclickOnClick()
	RoomReportTypeListModel.instance:setSelectId(self.reportMo.id)
end

function RoomInformReportTypeItem:_editableInitView()
	return
end

function RoomInformReportTypeItem:onSelect(isSelect)
	gohelper.setActive(self.gonormalicon, not isSelect)
	gohelper.setActive(self.goselecticon, isSelect)
end

function RoomInformReportTypeItem:onUpdateMO(mo)
	self.reportMo = mo
	self.txtinform.text = self.reportMo.desc
end

function RoomInformReportTypeItem:getMo()
	return self.reportMo
end

return RoomInformReportTypeItem
