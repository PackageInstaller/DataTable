-- chunkname: @modules/logic/room/view/record/RoomRecordView.lua

module("modules.logic.room.view.record.RoomRecordView", package.seeall)

local RoomRecordView = class("RoomRecordView", BaseView)

function RoomRecordView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomRecordView:addEvents()
	self.addEventCb(self, RoomController.instance, RoomEvent.SwitchRecordView, self.switchTabView, self)
end

function RoomRecordView:removeEvents()
	self.removeEventCb(self, RoomController.instance, RoomEvent.SwitchRecordView, self.switchTabView, self)
end

function RoomRecordView:_editableInitView()
	return
end

function RoomRecordView:onUpdateParam()
	return
end

function RoomRecordView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
	CritterRpc.instance:sendGetCritterBookInfoRequest()
	RoomRpc.instance:sendGetRoomLogRequest()
end

function RoomRecordView:switchTabView(param)
	local animName = param.animName

	self._switchView = param.view

	if not animName then
		return
	end

	self._animator.enabled = true

	self._animator:Play(animName, 0, 0)
	TaskDispatcher.runDelay(self.switchTabViewAfterAnim, self, RoomRecordEnum.AnimTime)
end

function RoomRecordView:switchTabViewAfterAnim()
	TaskDispatcher.cancelTask(self.switchTabViewAfterAnim, self)

	if not self._switchView then
		return
	end

	if self._switchView == RoomRecordEnum.View.Task then
		RoomRpc.instance:sendGetTradeTaskInfoRequest(self._reallySwitchTabView, self)
	else
		self:_reallySwitchTabView()
	end
end

function RoomRecordView:_reallySwitchTabView()
	self.viewContainer:selectTabView(self._switchView)

	self._switchView = nil
end

function RoomRecordView:onClose()
	TaskDispatcher.cancelTask(self.switchTabViewAfterAnim, self)
end

function RoomRecordView:onDestroyView()
	return
end

return RoomRecordView
