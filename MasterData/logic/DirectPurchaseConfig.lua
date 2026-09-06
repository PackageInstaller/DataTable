-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/config/DirectPurchaseConfig.lua

module("logic.extensions.directpurchase.config.DirectPurchaseConfig", package.seeall)

local DirectPurchaseConfig = class("DirectPurchaseConfig", BaseConfig)

function DirectPurchaseConfig:onInit()
	DirectPurchaseConfig.super.onInit(self)

	self.direct_purchase = nil
	self.direct_purchase_rec_fmt = nil
	self.direct_purchase_pet = nil
	self.direct_const = nil
	self.direct_animation = nil
	self.directup_purchase = nil
	self.directup_put_pet = nil
	self.directup_const = nil
	self.directup_helicopter = nil
	self.directup_pet = nil
	self.pay_race_strengthen = nil
	self.sell_shop_item = nil
	self.sell_shop_multiple = nil
	self.sell_shop_const = nil
	self.gift_shop_const = nil
end

function DirectPurchaseConfig:getNames()
	return {
		"direct_purchase",
		"direct_purchase_rec_fmt",
		"direct_purchase_pet",
		"direct_const",
		"direct_animation",
		"directup_purchase",
		"directup_put_pet",
		"directup_const",
		"directup_helicopter",
		"directup_pet",
		"pay_race_strengthen",
		"sell_shop_item",
		"sell_shop_multiple",
		"sell_shop_const",
		"gift_shop_const"
	}
end

function DirectPurchaseConfig:handleConfig(name, content)
	if name == "direct_purchase" then
		self.direct_purchase = content
	elseif name == "direct_purchase_rec_fmt" then
		self.direct_purchase_rec_fmt = content
	elseif name == "direct_purchase_pet" then
		self.direct_purchase_pet = content
	elseif name == "direct_const" then
		self.direct_const = content
	elseif name == "direct_animation" then
		self.direct_animation = content
	elseif name == "directup_purchase" then
		self.directup_purchase = content
	elseif name == "directup_put_pet" then
		self.directup_put_pet = content
	elseif name == "directup_const" then
		self.directup_const = content
	elseif name == "directup_helicopter" then
		self.directup_helicopter = content
	elseif name == "directup_pet" then
		self.directup_pet = content
	elseif name == "pay_race_strengthen" then
		self.pay_race_strengthen = content
	elseif name == "sell_shop_item" then
		self.sell_shop_item = content
	elseif name == "sell_shop_multiple" then
		self.sell_shop_multiple = content
	elseif name == "sell_shop_const" then
		self.sell_shop_const = content
	elseif name == "gift_shop_const" then
		self.gift_shop_const = content
	end
end

function DirectPurchaseConfig:getDirectCfgById(activityId, id)
	if self.direct_purchase[activityId] then
		return self.direct_purchase[activityId][id]
	end
end

function DirectPurchaseConfig:getRecFmtById(activityId)
	return self.direct_purchase_rec_fmt[activityId]
end

function DirectPurchaseConfig:getTargetRaceId(activityId)
	if self.direct_purchase_pet[activityId] then
		return self.direct_purchase_pet[activityId].raceId
	else
		return 0
	end
end

function DirectPurchaseConfig:getDirectLevelUp(id)
	return self.pay_race_strengthen[id]
end

function DirectPurchaseConfig:getSellItemCfgById(activityId)
	return self.sell_shop_item[activityId]
end

function DirectPurchaseConfig:getSellShopMultiCfg(id)
	return self.sell_shop_multiple[id]
end

function DirectPurchaseConfig:getValueByKey(activityId, key)
	if self.direct_const[activityId] and self.direct_const[activityId][key] then
		return self.direct_const[activityId][key].value or ""
	end

	return ""
end

function DirectPurchaseConfig:getAnimPathById(activityId)
	if self.direct_animation[activityId] then
		return self.direct_animation[activityId].animPath
	end

	return ""
end

function DirectPurchaseConfig:getDirectUpCfgById(activityId, id)
	if self.directup_purchase[activityId] then
		return self.directup_purchase[activityId][id]
	end
end

function DirectPurchaseConfig:getDirectUpPutPetCfgById(activityId)
	return self.directup_put_pet[activityId]
end

function DirectPurchaseConfig:getDirectUpValueByKey(activityId, key)
	if self.directup_const[activityId] and self.directup_const[activityId][key] then
		return self.directup_const[activityId][key].value or ""
	end

	return ""
end

function DirectPurchaseConfig:getDirectUpJumpCfgById(activityId, id)
	if self.directup_helicopter[activityId] then
		return self.directup_helicopter[activityId][id]
	end

	return nil
end

function DirectPurchaseConfig:getDirectUpPetCfg(activityId, skinId, id)
	if self.directup_pet[activityId] and self.directup_pet[activityId][skinId] then
		return self.directup_pet[activityId][skinId][id]
	end

	return nil
end

function DirectPurchaseConfig:getSellShopConstValue(key)
	if self.sell_shop_const[key] then
		return self.sell_shop_const[key].value
	end

	return ""
end

function DirectPurchaseConfig:getGiftShopConstValue(key)
	if self.gift_shop_const[key] then
		return self.gift_shop_const[key].value
	end

	return ""
end

DirectPurchaseConfig.instance = DirectPurchaseConfig.New()

return DirectPurchaseConfig
