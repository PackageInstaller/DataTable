-- chunkname: @modules/logic/room/view/layout/RoomLayoutBgSelectItem.lua

module("modules.logic.room.view.layout.RoomLayoutBgSelectItem", package.seeall)

local RoomLayoutBgSelectItem = class("RoomLayoutBgSelectItem", ListScrollCellExtend)

function RoomLayoutBgSelectItem:onInitView()
	self._btnitem = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_item")
	self._simagecover = gohelper.findChildSingleImage(self.viewGO, "content/#simage_cover")
	self._txtcovername = gohelper.findChildText(self.viewGO, "content/covernamebg/#txt_covername")
	self._goselect = gohelper.findChild(self.viewGO, "content/#go_select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLayoutBgSelectItem:addEvents()
	self._btnitem:AddClickListener(self._btnitemOnClick, self)
end

function RoomLayoutBgSelectItem:removeEvents()
	self._btnitem:RemoveClickListener()
end

function RoomLayoutBgSelectItem:_btnitemOnClick()
	self:_selectThis()
end

function RoomLayoutBgSelectItem:_editableInitView()
	return
end

function RoomLayoutBgSelectItem:_editableAddEvents()
	return
end

function RoomLayoutBgSelectItem:_editableRemoveEvents()
	return
end

function RoomLayoutBgSelectItem:_selectThis()
	if self._bgResMO then
		RoomLayoutBgResListModel.instance:setSelect(self._bgResMO.id)
		RoomLayoutController.instance:dispatchEvent(RoomEvent.UISelectLayoutPlanCoverItem)
	end
end

function RoomLayoutBgSelectItem:onUpdateMO(mo)
	self._bgResMO = mo

	if mo then
		self._simagecover:LoadImage(mo:getResPath())

		self._txtcovername.text = mo:getName()
	end
end

function RoomLayoutBgSelectItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function RoomLayoutBgSelectItem:onDestroyView()
	self._simagecover:UnLoadImage()
end

return RoomLayoutBgSelectItem
