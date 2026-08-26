-- chunkname: @modules/logic/tipdialog/controller/TipDialogController.lua

module("modules.logic.tipdialog.controller.TipDialogController", package.seeall)

local TipDialogController = class("TipDialogController", BaseController)

function TipDialogController:onInit()
	return
end

function TipDialogController:onInitFinish()
	return
end

function TipDialogController:addConstEvents()
	return
end

function TipDialogController:reInit()
	return
end

function TipDialogController:openTipDialogView(dialogId, callback, callbackTarget, auto, autoplayTime, widthPercentage)
	local param = {}

	param.dialogId = dialogId
	param.callback = callback
	param.callbackTarget = callbackTarget
	param.auto = auto
	param.autoplayTime = autoplayTime
	param.widthPercentage = widthPercentage

	ViewMgr.instance:openView(ViewName.TipDialogView, param)
end

TipDialogController.instance = TipDialogController.New()

return TipDialogController
