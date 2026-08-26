-- chunkname: @modules/logic/room/view/layout/RoomLayoutBgSelectView.lua

module("modules.logic.room.view.layout.RoomLayoutBgSelectView", package.seeall)

local RoomLayoutBgSelectView = class("RoomLayoutBgSelectView", BaseView)

function RoomLayoutBgSelectView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_content/Bg/#txt_title")
	self._scrollCoverItemList = gohelper.findChildScrollRect(self.viewGO, "#go_content/#scroll_CoverItemList")
	self._gocoveritem = gohelper.findChild(self.viewGO, "#go_content/#go_coveritem")
	self._simagecover = gohelper.findChildSingleImage(self.viewGO, "#go_content/#go_coveritem/bg/#simage_cover")
	self._txtcovername = gohelper.findChildText(self.viewGO, "#go_content/#go_coveritem/bg/covernamebg/#txt_covername")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLayoutBgSelectView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomLayoutBgSelectView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomLayoutBgSelectView:_btncloseOnClick()
	self:closeThis()

	local bgResMO = RoomLayoutBgResListModel.instance:getSelectMO()
	local layoutMO = RoomLayoutListModel.instance:getSelectMO()

	if bgResMO and layoutMO and bgResMO.id ~= layoutMO:getCoverId() then
		RoomRpc.instance:sendSetRoomPlanCoverRequest(layoutMO.id, bgResMO.id)
	end
end

function RoomLayoutBgSelectView:_editableInitView()
	self._viewGOTrs = self.viewGO.transform
	self._gocontentTrs = self._gocontent.transform
end

function RoomLayoutBgSelectView:onUpdateParam()
	return
end

function RoomLayoutBgSelectView:onOpen()
	local selectMO = RoomLayoutListModel.instance:getSelectMO()

	if selectMO then
		self._txttitle.text = selectMO.name or ""
	end

	local layoutMO = RoomLayoutListModel.instance:getSelectMO()

	RoomLayoutBgResListModel.instance:setSelect(layoutMO and layoutMO:getCoverId())

	if self.viewParam and self.viewParam.uiWorldPos then
		self:layoutAnchor(self.viewParam.uiWorldPos, self.viewParam.offsetWidth, self.viewParam.offsetHeight)
	end
end

function RoomLayoutBgSelectView:layoutAnchor(uiWorldPos, offWidth, offHeight)
	RoomLayoutHelper.tipLayoutAnchor(self._gocontentTrs, self._viewGOTrs, uiWorldPos, offWidth, offHeight)
end

function RoomLayoutBgSelectView:onClose()
	RoomLayoutController.instance:dispatchEvent(RoomEvent.UICancelLayoutPlanItemTab)
end

function RoomLayoutBgSelectView:onDestroyView()
	return
end

return RoomLayoutBgSelectView
