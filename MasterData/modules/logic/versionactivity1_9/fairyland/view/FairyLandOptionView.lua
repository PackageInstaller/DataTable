-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/FairyLandOptionView.lua

module("modules.logic.versionactivity1_9.fairyland.view.FairyLandOptionView", package.seeall)

local FairyLandOptionView = class("FairyLandOptionView", BaseView)

function FairyLandOptionView:onInitView()
	self.dialogGO = gohelper.findChild(self.viewGO, "dialog")
	self.option = FairyLandOption.New()

	self.option:init(self)
end

function FairyLandOptionView:addEvents()
	return
end

function FairyLandOptionView:removeEvents()
	return
end

function FairyLandOptionView:onOpen()
	self:_refreshView(self.viewParam)
end

function FairyLandOptionView:_refreshView(param)
	if self.dialogId then
		self:finished()
	end

	self.dialogId = param.dialogId
	self.dialogType = param.dialogType
	self.callback = param.callback
	self.callbackObj = param.callbackObj

	self.option:startDialog(param)
end

function FairyLandOptionView:finished()
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

	if self.option then
		self.option:hide()
	end

	self.dialogId = nil

	self:closeThis()
end

function FairyLandOptionView:onDestroyView()
	if self.option then
		self.option:dispose()
	end
end

return FairyLandOptionView
