-- chunkname: @modules/logic/room/view/backpack/RoomBackpackPropView.lua

module("modules.logic.room.view.backpack.RoomBackpackPropView", package.seeall)

local RoomBackpackPropView = class("RoomBackpackPropView", BaseView)

function RoomBackpackPropView:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBackpackPropView:addEvents()
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChange, self)
end

function RoomBackpackPropView:removeEvents()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChange, self)
end

function RoomBackpackPropView:_onItemChange()
	self:refreshPropList()
end

function RoomBackpackPropView:_editableInitView()
	return
end

function RoomBackpackPropView:onUpdateParam()
	return
end

function RoomBackpackPropView:onOpen()
	self:refreshPropList()
end

function RoomBackpackPropView:refreshPropList()
	RoomBackpackController.instance:refreshPropBackpackList()
	self:refreshIsEmpty()
end

function RoomBackpackPropView:refreshIsEmpty()
	local isEmpty = RoomBackpackPropListModel.instance:isBackpackEmpty()

	gohelper.setActive(self._goempty, isEmpty)
end

function RoomBackpackPropView:onClose()
	return
end

function RoomBackpackPropView:onDestroyView()
	return
end

return RoomBackpackPropView
