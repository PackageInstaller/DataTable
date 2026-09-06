-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/model/PayTrussGodGemModel.lua

module("logic.extensions.dressactivityshop.model.PayTrussGodGemModel", package.seeall)

local PayTrussGodGemModel = class("PayTrussGodGemModel", BaseModel)

function PayTrussGodGemModel:ctor()
	return
end

function PayTrussGodGemModel:onInit()
	self:onReset()
end

function PayTrussGodGemModel:onReset()
	self.hasPurchasedIds = {}
	self.buyId = 999
end

function PayTrussGodGemModel:_handlePayTrussInfo(msg)
	self.hasPurchasedIds = {}

	for _, id in ipairs(msg.hasPurchasedIds) do
		table.insert(self.hasPurchasedIds, id)
	end
end

function PayTrussGodGemModel:_handlePayTrussPaySucInfo(msg)
	self.buyId = checknumber(msg.buyId)
end

function PayTrussGodGemModel:_getPayTrussInfoFormModel()
	return self.hasPurchasedIds
end

function PayTrussGodGemModel:_getPayTrussPaySucInfoFormModel()
	return self.buyId
end

PayTrussGodGemModel.instance = PayTrussGodGemModel.New()

return PayTrussGodGemModel
