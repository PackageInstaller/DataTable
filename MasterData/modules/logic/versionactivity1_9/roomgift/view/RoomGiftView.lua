-- chunkname: @modules/logic/versionactivity1_9/roomgift/view/RoomGiftView.lua

module("modules.logic.versionactivity1_9.roomgift.view.RoomGiftView", package.seeall)

local RoomGiftView = class("RoomGiftView", BaseView)

function RoomGiftView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomGiftView:addEvents()
	return
end

function RoomGiftView:removeEvents()
	return
end

function RoomGiftView:_editableInitView()
	return
end

function RoomGiftView:onUpdateParam()
	return
end

function RoomGiftView:onOpen()
	local parentGO = self.viewParam.parent

	if parentGO then
		gohelper.addChild(parentGO, self.viewGO)
	end

	self:_refreshTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, TimeUtil.OneMinuteSecond)
end

function RoomGiftView:_refreshTimeTick()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.RoomGift)
end

function RoomGiftView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function RoomGiftView:onDestroyView()
	return
end

return RoomGiftView
