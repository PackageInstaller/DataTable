-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/purchaselimit/config/PurchaseLimitConfig.lua

module("logic.extensions.purchaselimit.config.PurchaseLimitConfig", package.seeall)

local PurchaseLimitConfig = class("PurchaseLimitConfig", BaseConfig)

function PurchaseLimitConfig:onInit()
	PurchaseLimitConfig.super.onInit(self)
end

function PurchaseLimitConfig:getNames()
	return {
		"purchase_limit_activity",
		"purchase_limit_item",
		"purchase_limit_common"
	}
end

function PurchaseLimitConfig:handleConfig(name, content)
	if name == "purchase_limit_activity" then
		self.purchaseActCfg = content
	elseif name == "purchase_limit_item" then
		self.purchaseItemCfg = content
	elseif name == "purchase_limit_common" then
		self.purchaseCommonCfg = content
	end
end

function PurchaseLimitConfig:getActCfg(actIds)
	local cfg = {}
	local actIds = string.splitToNumber(actIds, ",")

	for _, actId in pairs(actIds) do
		if self.purchaseActCfg[actId] then
			table.insert(cfg, self.purchaseActCfg[actId])
		end
	end

	table.sort(cfg, function(a, b)
		return a.activityId < b.activityId
	end)

	return cfg
end

function PurchaseLimitConfig:getPetCfg(activityId)
	return self.purchaseActCfg[activityId]
end

function PurchaseLimitConfig:getItemCfg(activityId)
	return self.purchaseItemCfg[activityId]
end

function PurchaseLimitConfig:getCommonCfgById(key)
	return self.purchaseCommonCfg[key].value
end

PurchaseLimitConfig.instance = PurchaseLimitConfig.New()

return PurchaseLimitConfig
