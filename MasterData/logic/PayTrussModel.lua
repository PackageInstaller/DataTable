-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/model/PayTrussModel.lua

module("logic.extensions.dressactivityshop.model.PayTrussModel", package.seeall)

local PayTrussModel = class("PayTrussModel", BaseModel)

function PayTrussModel:ctor()
	return
end

function PayTrussModel:onInit()
	self:onReset()
end

function PayTrussModel:onReset()
	self.hasPurchasedIds = {}
	self.buyId = 999
end

function PayTrussModel:_handlePayTrussInfo(msg)
	self.hasPurchasedIds = {}

	for _, id in ipairs(msg.hasPurchasedIds) do
		table.insert(self.hasPurchasedIds, id)
	end
end

function PayTrussModel:_handlePayTrussPaySucInfo(msg)
	self.buyId = checknumber(msg.buyId)
end

function PayTrussModel:_getPayTrussInfoFormModel()
	return self.hasPurchasedIds
end

function PayTrussModel:_getPayTrussPaySucInfoFormModel()
	return self.buyId
end

PayTrussModel.instance = PayTrussModel.New()

return PayTrussModel
