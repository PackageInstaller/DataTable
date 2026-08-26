-- chunkname: @modules/logic/room/view/record/RoomCritterHandBookBackView.lua

module("modules.logic.room.view.record.RoomCritterHandBookBackView", package.seeall)

local RoomCritterHandBookBackView = class("RoomCritterHandBookBackView", BaseView)

function RoomCritterHandBookBackView:onInitView()
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "bg/#scroll_view")
	self._simageback = gohelper.findChildSingleImage(self.viewGO, "bg/#go_show/#simage_back")
	self._simageutm = gohelper.findChildSingleImage(self.viewGO, "bg/#go_show/#simage_utm")
	self._gobackicon = gohelper.findChild(self.viewGO, "bg/#go_show/#simage_back/icon")
	self._txtname = gohelper.findChildText(self.viewGO, "bg/#go_show/#txt_name")
	self._gouse = gohelper.findChild(self.viewGO, "bg/#go_use")
	self._goempty = gohelper.findChild(self.viewGO, "bg/#go_empty")
	self._goshow = gohelper.findChild(self.viewGO, "bg/#go_show")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_confirm")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_close")
	self._btnempty = gohelper.findChildButtonWithAudio(self.viewGO, "bg/maskbg")
	self._txttitle = gohelper.findChildText(self.viewGO, "bg/txt_title")
	self._scrollview = self.viewContainer:getScrollView()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterHandBookBackView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnempty:AddClickListener(self._btncloseOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self.addEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.refreshBack, self.refreshUI, self)
end

function RoomCritterHandBookBackView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnempty:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self.removeEventCb(self, RoomHandBookController.instance, RoomHandBookEvent.refreshBack, self.refreshUI, self)
end

function RoomCritterHandBookBackView:_btncloseOnClick()
	self:closeThis()
end

function RoomCritterHandBookBackView:_btnconfirmOnClick()
	local critterId = RoomHandBookModel.instance:getSelectMo().id
	local backgroundMo = RoomHandBookBackModel.instance:getSelectMo()
	local backgroundId = backgroundMo:isEmpty() and 0 or backgroundMo.id

	CritterRpc.instance:sendSetCritterBookBackgroundRequest(critterId, backgroundId)
end

function RoomCritterHandBookBackView:_editableInitView()
	return
end

function RoomCritterHandBookBackView:onUpdateParam()
	return
end

function RoomCritterHandBookBackView:updateView(info)
	return
end

function RoomCritterHandBookBackView:onOpen()
	RoomHandBookBackListModel.instance:init()
	self:refreshUI()

	local selectIndex = RoomHandBookBackListModel.instance:getSelectIndex()

	self._scrollview:selectCell(selectIndex, true)
end

function RoomCritterHandBookBackView:refreshUI()
	local mo = RoomHandBookBackModel.instance:getSelectMo()
	local isEmpty = mo and mo:isEmpty()

	gohelper.setActive(self._goempty, isEmpty)
	gohelper.setActive(self._goshow, not isEmpty)

	if mo and not mo:isEmpty() then
		gohelper.setActive(self._gobackicon, false)
		self._simageutm:LoadImage(ResUrl.getPropItemIcon(mo:getConfig().icon))

		self._txtname.text = mo:getConfig().name
	else
		gohelper.setActive(self._gobackicon, true)
	end

	local crittermo = RoomHandBookModel.instance:getSelectMo()

	if crittermo then
		self._txttitle.text = string.format(luaLang("critterhandbookbacktitle"), crittermo:getConfig().name)
	end

	local isUse = mo:checkIsUse()

	gohelper.setActive(self._gouse, isUse)
	gohelper.setActive(self._btnconfirm.gameObject, not isUse)
end

function RoomCritterHandBookBackView:onClose()
	return
end

function RoomCritterHandBookBackView:onDestroyView()
	return
end

return RoomCritterHandBookBackView
