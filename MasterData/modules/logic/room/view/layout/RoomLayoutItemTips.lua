-- chunkname: @modules/logic/room/view/layout/RoomLayoutItemTips.lua

module("modules.logic.room.view.layout.RoomLayoutItemTips", package.seeall)

local RoomLayoutItemTips = class("RoomLayoutItemTips", BaseView)

function RoomLayoutItemTips:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_content/Bg/#txt_title")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "#go_content/#scroll_ItemList")
	self._gonormalitem = gohelper.findChild(self.viewGO, "#go_content/#go_normalitem")
	self._gobuildingicon = gohelper.findChild(self.viewGO, "#go_content/#go_normalitem/#go_buildingicon")
	self._godikuaiicon = gohelper.findChild(self.viewGO, "#go_content/#go_normalitem/#go_dikuaiicon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_content/#go_normalitem/#txt_name")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_content/#go_normalitem/#txt_num")
	self._txtdegree = gohelper.findChildText(self.viewGO, "#go_content/#go_normalitem/#txt_degree")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLayoutItemTips:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.NewBuildingPush, self.onGainItem, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.NewBlockPackagePush, self.onGainItem, self)
end

function RoomLayoutItemTips:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.NewBuildingPush, self.onGainItem, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.NewBlockPackagePush, self.onGainItem, self)
end

function RoomLayoutItemTips:_btncloseOnClick()
	self:closeThis()
end

function RoomLayoutItemTips:onGainItem()
	RoomLayoutItemListModel.instance:resortList()
end

function RoomLayoutItemTips:_editableInitView()
	self._viewGOTrs = self.viewGO.transform
	self._gocontentTrs = self._gocontent.transform
end

function RoomLayoutItemTips:onUpdateParam()
	return
end

function RoomLayoutItemTips:onOpen()
	local height = self.viewContainer:getTipsHeight()

	recthelper.setHeight(self._gocontentTrs, height)

	if self.viewParam then
		if self.viewParam.titleStr then
			self._txttitle.text = self.viewParam.titleStr
		end

		if self.viewParam.uiWorldPos then
			self:layoutAnchor(self.viewParam.uiWorldPos, self.viewParam.offsetWidth, self.viewParam.offsetHeight)
		end
	end
end

function RoomLayoutItemTips:layoutAnchor(uiWorldPos, offWidth, offHeight)
	RoomLayoutHelper.tipLayoutAnchor(self._gocontentTrs, self._viewGOTrs, uiWorldPos, offWidth, offHeight)
end

function RoomLayoutItemTips:onClose()
	RoomLayoutController.instance:dispatchEvent(RoomEvent.UICancelLayoutPlanItemTab)
end

function RoomLayoutItemTips:onDestroyView()
	return
end

return RoomLayoutItemTips
