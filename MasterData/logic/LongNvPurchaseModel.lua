-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/model/LongNvPurchaseModel.lua

module("logic.extensions.directpurchase.model.LongNvPurchaseModel", package.seeall)

local LongNvPurchaseModel = class("LongNvPurchaseModel", BaseModel)

function LongNvPurchaseModel:ctor()
	return
end

function LongNvPurchaseModel:onInit()
	self:onReset()
end

function LongNvPurchaseModel:onReset()
	self._curSelectPetId = nil
end

function LongNvPurchaseModel:setCurSelectPetId(petId)
	self._curSelectPetId = petId
end

function LongNvPurchaseModel:getCurSelectPetId()
	return self._curSelectPetId
end

LongNvPurchaseModel.instance = LongNvPurchaseModel.New()

return LongNvPurchaseModel
