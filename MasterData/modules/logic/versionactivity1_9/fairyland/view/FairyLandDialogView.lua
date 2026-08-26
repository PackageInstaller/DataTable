-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/FairyLandDialogView.lua

module("modules.logic.versionactivity1_9.fairyland.view.FairyLandDialogView", package.seeall)

local FairyLandDialogView = class("FairyLandDialogView", BaseView)

function FairyLandDialogView:onInitView()
	self.dialogGO = gohelper.findChild(self.viewGO, "main/dialog")
	self.bubble = FairyLandBubble.New()

	self.bubble:init(self)
end

function FairyLandDialogView:addEvents()
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.CloseDialogView, self._onCloseDialogView, self)
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.ShowDialogView, self._refreshView, self)
end

function FairyLandDialogView:removeEvents()
	return
end

function FairyLandDialogView:onOpen()
	return
end

function FairyLandDialogView:_onCloseDialogView()
	self:finished()
end

function FairyLandDialogView:_refreshView(param)
	local dialogId = param.dialogId

	if self.dialogId == dialogId then
		return
	end

	self.dialogId = param.dialogId
	self.dialogType = param.dialogType
	self.callback = param.callback
	self.callbackObj = param.callbackObj

	if self.dialogType == FairyLandEnum.DialogType.Bubble then
		gohelper.setActive(self.dialogGO, true)
		self.bubble:startDialog(param)
	else
		gohelper.setActive(self.dialogGO, false)
		ViewMgr.instance:openView(ViewName.FairyLandOptionView, param)
	end
end

function FairyLandDialogView:finished()
	if self.dialogId then
		if self.dialogId == 22 and not FairyLandModel.instance:isFinishDialog(8) then
			FairyLandRpc.instance:sendRecordDialogRequest(8)
		end

		if not FairyLandModel.instance:isFinishDialog(self.dialogId) then
			FairyLandRpc.instance:sendRecordDialogRequest(self.dialogId)
		end
	end

	if self.callback then
		self.callback(self.callbackObj)
	end

	if self.bubble then
		self.bubble:hide()
	end

	self.dialogId = nil

	gohelper.setActive(self.dialogGO, false)
end

function FairyLandDialogView:onDestroyView()
	if self.bubble then
		self.bubble:dispose()
	end
end

return FairyLandDialogView
