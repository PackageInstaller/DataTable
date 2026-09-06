-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/purchaselimit/model/PurchaseLimitModel.lua

module("logic.extensions.purchaselimit.model.PurchaseLimitModel", package.seeall)

local PurchaseLimitModel = class("PurchaseLimitModel", BaseModel)

function PurchaseLimitModel:ctor()
	return
end

function PurchaseLimitModel:onInit()
	self:onReset()
end

function PurchaseLimitModel:onReset()
	self.purchaseInfo = {}
end

function PurchaseLimitModel:setPurchaseInfo(msg)
	table.clear(self.purchaseInfo)
	GameUtil.pbToTable(msg, self.purchaseInfo)
end

function PurchaseLimitModel:getPurchaseInfo()
	return self.purchaseInfo
end

function PurchaseLimitModel:getItemInfo(itemId)
	for _, v in ipairs(self.purchaseInfo.itemList) do
		if v.itemId == itemId then
			return v
		end
	end
end

PurchaseLimitModel.instance = PurchaseLimitModel.New()

return PurchaseLimitModel
