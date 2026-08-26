-- chunkname: @modules/logic/nfc/model/NFCModel.lua

module("modules.logic.nfc.model.NFCModel", package.seeall)

local NFCModel = class("NFCModel", BaseModel)

function NFCModel:onInit()
	return
end

function NFCModel:reInit()
	return
end

NFCModel.instance = NFCModel.New()

return NFCModel
