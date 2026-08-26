-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureWrongTipView.lua

module("modules.logic.room.view.manufacture.RoomManufactureWrongTipView", package.seeall)

local RoomManufactureWrongTipView = class("RoomManufactureWrongTipView", BaseView)

function RoomManufactureWrongTipView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._gorightroot = gohelper.findChild(self.viewGO, "rightRoot")
	self._goworngPop = gohelper.findChild(self.viewGO, "root/#go_wrongPop")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#go_wrongPop/#simage_bg")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/#go_wrongPop/#txt_title")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_wrongPop/#btn_close")
	self._scrolllist = gohelper.findChildScrollRect(self.viewGO, "root/#go_wrongPop/#scroll_list")
	self._gotipcontent = gohelper.findChild(self.viewGO, "root/#go_wrongPop/#scroll_list/viewport/content")
	self._gotipItem = gohelper.findChild(self.viewGO, "root/#go_wrongPop/#scroll_list/viewport/content/#go_tipItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureWrongTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomManufactureWrongTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomManufactureWrongTipView:_btncloseOnClick()
	self:closeThis()
end

function RoomManufactureWrongTipView:_editableInitView()
	return
end

function RoomManufactureWrongTipView:onUpdateParam()
	if not self.viewParam then
		return
	end

	self.isRight = self.viewParam.isRight
	self.buildingUid = self.viewParam.buildingUid

	self:setTipItems()
	ManufactureController.instance:dispatchEvent(ManufactureEvent.OnWrongTipViewChange, self.buildingUid)
end

function RoomManufactureWrongTipView:onOpen()
	self:onUpdateParam()

	if self.isRight then
		gohelper.addChild(self._gorightroot, self._goworngPop)
	end
end

function RoomManufactureWrongTipView:setTipItems()
	self.tipItemList = {}

	local tipItemList = ManufactureModel.instance:getManufactureWrongTipItemList(self.buildingUid)

	gohelper.CreateObjList(self, self._onSetTipItem, tipItemList, self._gotipcontent, self._gotipItem, RoomManufactureWrongTipItem)
end

function RoomManufactureWrongTipView:_onSetTipItem(obj, data, index)
	self.tipItemList[index] = obj

	obj:setData(self.buildingUid, data.manufactureItemId, data.wrongSlotIdList, self.isRight)
end

function RoomManufactureWrongTipView:onClose()
	ManufactureController.instance:dispatchEvent(ManufactureEvent.OnWrongTipViewChange)
end

function RoomManufactureWrongTipView:onDestroyView()
	return
end

return RoomManufactureWrongTipView
