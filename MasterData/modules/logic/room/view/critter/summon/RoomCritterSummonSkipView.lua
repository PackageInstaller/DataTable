-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonSkipView.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonSkipView", package.seeall)

local RoomCritterSummonSkipView = class("RoomCritterSummonSkipView", BaseView)

function RoomCritterSummonSkipView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._imageskip = gohelper.findChildImage(self.viewGO, "#btn_skip/#image_skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterSummonSkipView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onDragEnd, self.onDragEnd, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onOpenEgg, self._closeSkip, self)
end

function RoomCritterSummonSkipView:removeEvents()
	self._btnskip:RemoveClickListener()
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onDragEnd, self.onDragEnd, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onOpenEgg, self._closeSkip, self)
end

function RoomCritterSummonSkipView:_btnskipOnClick()
	self:_closeSkip()
	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onSummonSkip)
end

function RoomCritterSummonSkipView:_editableInitView()
	return
end

function RoomCritterSummonSkipView:onUpdateParam()
	return
end

function RoomCritterSummonSkipView:onDragEnd()
	return
end

function RoomCritterSummonSkipView:_closeSkip()
	self:closeThis()
end

function RoomCritterSummonSkipView:onOpen()
	gohelper.setActive(self._btnskip.gameObject, true)
end

function RoomCritterSummonSkipView:onClose()
	return
end

function RoomCritterSummonSkipView:onDestroyView()
	return
end

return RoomCritterSummonSkipView
