-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureAddPopView.lua

module("modules.logic.room.view.manufacture.RoomManufactureAddPopView", package.seeall)

local RoomManufactureAddPopView = class("RoomManufactureAddPopView", BaseView)

function RoomManufactureAddPopView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._gorightroot = gohelper.findChild(self.viewGO, "rightRoot")
	self._goaddPop = gohelper.findChild(self.viewGO, "root/#go_addPop")
	self._btncloseAdd = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_addPop/#btn_closeAdd")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureAddPopView:addEvents()
	self._btncloseAdd:AddClickListener(self._btncloseAddOnClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self, LuaEventSystem.High)
end

function RoomManufactureAddPopView:removeEvents()
	self._btncloseAdd:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
end

function RoomManufactureAddPopView:_btncloseAddOnClick()
	ManufactureController.instance:clearSelectedSlotItem()
end

function RoomManufactureAddPopView:_onItemChanged()
	ManufactureController.instance:updateTraceNeedItemDict()
end

function RoomManufactureAddPopView:_editableInitView()
	self._transroot = self._goroot.transform
	self.animatorPlayer = SLFramework.AnimatorPlayer.Get(self._goaddPop)

	ManufactureController.instance:updateTraceNeedItemDict()
end

function RoomManufactureAddPopView:onUpdateParam()
	if self.viewParam then
		self.isRight = self.viewParam.inRight
		self.highLightManufactureItem = self.viewParam.highLightManufactureItem
	end
end

function RoomManufactureAddPopView:onOpen()
	self:onUpdateParam()

	if self.isRight then
		gohelper.addChild(self._gorightroot, self._goaddPop)
	end
end

function RoomManufactureAddPopView:onClose()
	return
end

function RoomManufactureAddPopView:onDestroyView()
	return
end

return RoomManufactureAddPopView
