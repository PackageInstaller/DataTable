-- chunkname: @modules/logic/tipdialog/model/TipDialogModel.lua

module("modules.logic.tipdialog.model.TipDialogModel", package.seeall)

local TipDialogModel = class("TipDialogModel", BaseModel)

function TipDialogModel:onInit()
	return
end

function TipDialogModel:reInit()
	return
end

TipDialogModel.instance = TipDialogModel.New()

return TipDialogModel
